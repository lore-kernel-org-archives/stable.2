Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634659;
	b=bSy8bxOHXznPCPGKfD2o6qPri1x2kIGZ09UPBIj0ny4HUXOpuw09Sny9Y2DTakXlNEmE
	 oXPt8i2+MMhPioQEGEmjTNjYKLQDvmX4TfGBLK710Xj1275cBX/sLPuW+4RuGC88NSAOm
	 U5yS0rCAsRH9oOpQzoVMO0rQUa9HXiuBKnJZf4OS16djzhk0NwChSheFZ+gGQ6c4HuMKS
	 AqBpxeXpWW/ILVWeyCdzObZg/7b3HL5L4HgopSHjcBJ7JS6Ozw0FMS2dGwEjXmeWAuwTC
	 gpvi66Fi/loZFY7Rr0OKJklmCKHAPz5QJXhPXipo0mkVgA5yRg1qOjOMTC/NoVuXZ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634659;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ochEHq3UOp+Ci13Fi9SIG/nMHtRj+oW1Ty+R4hzJ67g=;
	b=PF24+wFxhjdjdnL7ay/oQwjG3G8hiewLDuxTmFtvSN1ba7NBj2GOZAuoMr2uqU47q0St
	 hvsdwheIt2NdTo72gHAB3QcM8Ulw9/1fW8eoWkjCPcfxp1aLbZFlZePBaxBap2psXBB/2
	 JGTsGxi9idw1WzpT21UbTtQTBv/Fre144d7JZGs6BVsdOhbWYOfNP9UeALWAOniYtiio/
	 zNpjxKCMcOCNocYiXsYi5VsPUpYPoppyuB265dLwiC9xUic5wKUD6HJBAsz+1oxn0LDdm
	 AUjiPGMJ9z8z5QJFTl3sXFSoQXQ/e0ylQ335XBf7yRUl70gqz52DuWaOo6oWoIzHQzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FY45ATOb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E5606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FY45ATOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD7E1F000C1;
	Thu, 22 Oct 2026 02:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634658;
	bh=ochEHq3UOp+Ci13Fi9SIG/nMHtRj+oW1Ty+R4hzJ67g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FY45ATObv7V7kmdQ7EHbOeM0Gp+9tVWrqlPUehnO1ramvE4gEcJ0niSlnf2g8potW
	 q/yY8e5z25Us/bbdL8wo5fBKrm4HT9U2WdJjumBL1TqXY5KbVzdD0Ve05KBA4tQGDy
	 APqyH4AokKT7PGatKuq+lYSAoJuknljsSIXaeCWdQL7xhPi58aN46M2+XqbgC4lEJj
	 cV7LCWZO8si7QAIB08pZvL+Ifi0m77DHzhAC/cJXGHX7VKic/FkugeAm1DvCN7a+Uc
	 AA2KE0wgP/CtUIgZf3hTCh5aOLNugVaXbLNNgr+pb6A4Y8EZxI8VK4EvDYaAPom+JL
	 2dPjm11Zr3VqA==
From: Sasha Levin <sashal@kernel.org>
To: Christian Theune <ct@flyingcircus.io>
Cc: Sasha Levin <sashal@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Deepak Nagaraj <deepak.nagaraj@baseten.com>,
	stable@vger.kernel.org,
	mfleming@cloudflare.com,
	Kaz Kato <kazuyoshi.kato@baseten.co>,
	Stephen Day <stephen.day@baseten.co>,
	Greg KH <greg@kroah.com>,
	1151281@bugs.debian.org,
	Thomas MISCHLER - API AND YOU <thomas.mischler@api-and-you.com>
Subject: Re: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to xas_split_alloc backport
Date: Wed, 21 Oct 2026 22:03:43 -0400
Message-ID: <2026-10-21-1-daily-reply-0018-kswapd-list-lru-6-12-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <PATP264MB48180D3DFF94FB287D09CE64E0662@PATP264MB4818.FRAP264.PROD.OUTLOOK.COM>
References: <PATP264MB48180D3DFF94FB287D09CE64E0662@PATP264MB4818.FRAP264.PROD.OUTLOOK.COM>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> to carry these patches through review ourselves. If someone sends the
> 6.12.y backports, we are glad to run them through the same reproducer
> and reply with a Tested-by.

Thanks for the testing. I queued the backports for 6.12, 6.6 and 6.1.

-- 
Thanks,
Sasha
