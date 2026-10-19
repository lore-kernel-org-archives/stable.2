Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DB282F20
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372053; cv=none; b=rVAk1geZ8ZC4esKgoY+qyDrPZMxJbY8hG9MKUaWKOkKBFoHZcH0NEacRcTt7V1v0MghLkPuvCxrR7c5xHsdjr1XMv3wUP3tSGYi3mpCPZdHgA/u4E2oQvHfjaMabpz61Y0dQGdx7tFKAQ8Bw6j57mxPh47Q4SIsrD02JRJj1tEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372053; c=relaxed/simple;
	bh=mIiL9PgSJJ8fjuyW++lfEH4uifioW1V5PZY/k9OTv5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkrEn7WgT1IW84TQ2hb+5PEvV8MgeUoCqw+F91vSGREwb+QQJyym/Z63Uw999pc5MYCe15td5yNs3UoE/KHrl9Nhp442n00VRZiUylxQpLL98NtCh3jF05834hrCZa3XzvSF+mmDbp+pA7iJUNbVXs0zisplZdUPfn3j/+Te0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=pdpjT8dR; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="pdpjT8dR"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3247795eec.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 18:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792372051; x=1792976851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwsY2GW9uMLA/+aDo+zZetHYH/MOnEHa84gDTy3J3Zg=;
        b=pdpjT8dR72Iis7eWYhTg1J+Li4ygPMsE7ibvytonFeSadqQ8Rnqs+DKxmWpIBBsG8M
         RRjsjNd7XrWLqODNqBQ0sIcD0GYEtojWeRd24nXiphw25Gn0PnHbbm0u9BZClt9hFh8a
         mfcC+OcF3Xb9f3QpbMpFrXXBtiU/sY2wlC/qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372051; x=1792976851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwsY2GW9uMLA/+aDo+zZetHYH/MOnEHa84gDTy3J3Zg=;
        b=fpc3APqx9ckOQ7t1fqPkfCPtuOJSBOUCMlZSTVey4YIzZAE2MsjsvWZEO/rn2uHmUq
         jmEx0462IvT2ZNTG0X6wI1rPVcYQC94Rmg4h6v9ymyPnBUPRWmEqRzNsVa7ngwQwlw6c
         PvJ/yKDqJSRi3UuRJk1GPNLTfCnQ8ZO13WQBf3mCnFjltBRxX0etroQObPoEWTCsxYgF
         0aiJcoH7aLNCJbakpwqgj/Hpc5hJB3Nfa2j0NZtNeyoLoSgXFHG1NTo9A/2YDuX48Ry/
         6/92ubSEDfFXHB94RaaAh6ZRtuk472RMjVBjmXIebKU7CNyMeYLMW9TXbwtbIGqCp6Dc
         7rfw==
X-Forwarded-Encrypted: i=1; AKwUvBwS0e/pHnap9S8yWqjDN8JGE7qEyrk/RD6Ws9LLsbmFfxs3/xGLLX5+GEkTViZeVy8hA2hQBfA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJojQnQK43RfUuTzxJow4Z194+R1ejcahlQFW6L83PEsNmX82PW
	Lcz3x6GevpgKSWCIfNdSf1Nz+4KKPDHLJlns0IkX76+PfXscRLrAD7G3WAgl+1+xsJ4=
X-Gm-Gg: AYBFou3iCpnpDqcAm1Mv10dHxbvnjDyN8mZIpa2pY7QVLYSj2Ou4Gii7mdv4RJTspTz
	oBME1sBSsjPRLrjNTq4WqEYiJwmaxhl81njgorrmR/oTUYu2SzT+crAr25k7YBM1nuu1ACOInqW
	u3q+Or4uTCnm3zLynL36pIolDRtpYgjYirZyLAQS/VGnE3FhW2S5Ffd8d3Q3UtHNz3x34ddSfnl
	lhYKIFs8QWyRGp8F7PSILXC4N/mTPpgc0T59oL3rIJLv8VFZ6lZPSX3c4CJPkiGu5e7NsDlTi5y
	yrNx7KL0PgKthMbNRpL0x16M9E6no38iLNtnsWmvduhhE95ICaN9Gat/f8BsOWHYfca+nLQONui
	ugz+/f89jBGWIRF4R87gfGVVQw5EU/yOuNBNEMb1XK0VCGaCw0ZslHnVh15li1PyKAJU9GCkjP1
	yKF7w1V3AbB3SHiVfRcvP/BeFkyXrjEmNtHh8rlKkvk6euHlzwhkCe3JeQULxKJZacg28x0mRHq
	+b0ixUeM4fCD8uehL04Gz5Lt5WNsY4FnvR5L5eqNmG/ishggKlbvMSR0NNylfZHEg==
X-Received: by 2002:a05:7300:7a99:b0:358:f678:46b6 with SMTP id 5a478bee46e88-361a2343165mr9757670eec.22.1792372051354;
        Sun, 18 Oct 2026 18:07:31 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm25934235eec.22.2026.10.18.18.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:07:30 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: netdev-bot+sashiko@kernel.org
Cc: 98lawweijie@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	law.wei.jie@gt.tech.gov.sg,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: usb: pegasus: check rx pkt_len against the received length
Date: Mon, 19 Oct 2026 09:07:04 +0800
Message-ID: <20261019010704.90465-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179229290253.3135.18168766657798775955@kernel.org>
References: <179229290253.3135.18168766657798775955@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko is right. Will be making changes to this patch (2/2) in a v2
patch request, addressing those comments.

    Wei Jie Law
---
pw-bot: cr
