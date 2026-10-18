Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF43CAE9B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304109; cv=none; b=X1l/MpKUwVX/csMyeiHbFfNjOgpE4u/Z+mcmQ1/X+kT82L5nB8IXRhcAnK9X+xT46M7TryArmDvSpMw8pCGX4oUNpMztPhbIYh1cTwSZznIy4EDua/TtRnAr2+sS1/uns/bcPCQEUhszyX+RQqLo6sjhWtugW44qNeTj8x+QyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304109; c=relaxed/simple;
	bh=dFRO/d/6Wl1NjIou5Sj9HlQFKiI/UvFn2/HqnF5nYY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol2lxzOHGaWwGIEIGzQRB6Vu90ES6UwguRcgSlmudeBDDk4T1/OjTN5D9NC3gTXZtTwUtZOmIGu+B0GbomEgEr15dJPr/ggsFOoVEowBtV4sqEGSvnVg5c3c3sOWskZNtY2I3t1HWSBafIgLVzv3N5u0gALgNJV1rZRlwmrTg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=h3PwPNQe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="h3PwPNQe"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e60f9af6e6so8025775ad.3
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 23:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792304107; x=1792908907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oRH5Jy551mYfc/WkSOrU9rJBVCAUTwu41wYys1NmakA=;
        b=h3PwPNQe7KKjKgZVpIK7synCo/UDTN54hSCWKXRywMpEsFftUOAPh0x+9S8iso4LlP
         rAitp2FcPWnRQWCA1pS7oJuxHgLQGLFxvvEVluYZ8SBu6nz9R2rfsAS/hzlqujcpPxT9
         VmCbtYMuMEzzFmbRkR3b0DiLsgpoP35MuS0ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304107; x=1792908907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRH5Jy551mYfc/WkSOrU9rJBVCAUTwu41wYys1NmakA=;
        b=fjwU/dLStiC3VQjtZOErtNk2/rLviEjtS0OLdv+SnCWyd12fCX9P99O9P5ROkixX/q
         4wfqyrofH1/WUbLA/pc0eJ68d+bzP9viyxHEo6Ei41RCTbWU5QlYg9KN8gbyctGSoNUB
         XgK+uHXYe1LfOUYhULgX4vzZyM2BPJrD+RDq6yaM7gKugjWQgwWAUcSU9AEkyzdsCTjB
         x17fhp+A4TmvOv+t7JaUfHrUGaPJM00OdIaEewoBwflr+XMirXsLFr/IXfEUEh49yY+8
         d9yYXkqEADGB7Lidn+IV4nee344KG3xMOmMzx4EpAQypSeY6RHgISYvv6KkaJtyjoYqE
         JXew==
X-Forwarded-Encrypted: i=1; AKwUvBwjUkbDBP+Bm2HP5mq1PI1RPOxIQwODg1Dyfc8vhTTEUIio03mwVvMbq6MxQ0S5ZM87GyQJH/o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlS6uLIBfHwl/qE8ylbRtTHJhjsBmo9plVq6ArO5vbsVmkcleC
	36PXZKUNSJDgbrmTeRGrOicDCBds6o4XYJxuQ/tHbVWnbDbMtuG4nyvIevSPmtVUYVA=
X-Gm-Gg: AYBFou2wx3S0y41wwg2aNWC39JwIjTyXN8UbIoeUVqiV22ViYgv+jVLL+CD1iMNAy8f
	9dqw5q4J5NMFimHStmbxfA+i/XCI3XEfEZkE+6ZeXVZkmAmz94gG6bsrKkzWkxEQtzASHjA9uEe
	dAuLfaxqv2+gH9lKCbTAxYeOd4EsxCKIwMeDD8inIMN2TCj6+iM0Gh8cFaJVJsCs2NW8yM4/Evv
	Tb5yEb1ISYXKa6TpAL8eDdWoqAhKlNsPSTww2PkBot2dI3nkkkAEDIXtdcfX7jxrASkf2qhbrUc
	BLoyApkQQ8NGrZJJpM7amXKS+pX8WwqOKcLIFe5jNN39Lsvqhmte1GBhcAywfFDFfgBM55QNmww
	Jcx7VeewAtqzzQm4CSGNJP/aschtmn7p9KEWTuWah1fCdRhjOU8u6T8SMWEfWM2XrtEuyLBAgOM
	WlrgkYCNGnoo/mnJi1jfaAG/okoa754AI4Mxf+ZJU98GPHolWzud7l0/cjJUxWM9NoZNvO4liiv
	3FIiHl/lvPG6wE3o8EnX3d9e2Mv+TLjE4BdV1dba82jRZpyiSxLL18=
X-Received: by 2002:a17:903:2f87:b0:2e9:4175:3079 with SMTP id d9443c01a7336-2e9a69e4360mr42362815ad.21.1792304107338;
        Sat, 17 Oct 2026 23:15:07 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e833f1asm26464945ad.43.2026.10.17.23.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:15:06 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: netdev-bot+sashiko@kernel.org
Cc: 98lawweijie@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	law.wei.jie@gt.tech.gov.sg,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	woojung.huh@microchip.com
Subject: Re: [PATCH net 2/2] net: usb: lan78xx: reject short register and statistics reads
Date: Sun, 18 Oct 2026 14:14:56 +0800
Message-ID: <20261018061456.18648-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179229346399.3135.12116533277810426921@kernel.org>
References: <179229346399.3135.12116533277810426921@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko is correct. Will be submitting v2 with commit messages changed:
- with patch 1 a zero-length stats reply is already harmless; the remaining
  leak is a 1 to 187 byte reply (the counter block is 188 bytes). The message
  now says so and no longer claims the counters "stay zero" because of 2/2.
- it says that 2/2 depends on 1/2 (otherwise the leak moves to the stack) and
  that both should be backported together.
- RX_ADDRL/RX_ADDRH are only written back for an invalid address; the heap
  derived address is written to MAF_LO(0)/MAF_HI(0) and set as the netdev address.

pw-bot: cr
