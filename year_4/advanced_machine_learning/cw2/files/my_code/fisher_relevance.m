function relevance = fisher_relevance(X_pos, X_neg,index)
    m = size(X_pos,1) + size(X_neg,1) ; % scalar
    m_pos = mean(X_pos);% notscalar
    m_pos = m_pos(1,index); 
    m_neg = mean(X_neg);% not scalar
    m_neg = m_neg(1,index);
    v_pos = 1/m * sum( (X_pos(:,index) - m_pos) .^ 2);
    v_neg = 1/m * sum( (X_neg(:,index) - m_neg) .^ 2);
    
    relevance = (m_pos - m_neg)^2/(v_pos + v_neg + 0.00001) ;
end