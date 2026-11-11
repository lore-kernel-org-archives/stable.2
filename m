Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434111;
	b=geJs6E0GeCvD7idLtXbn17udthM6Dq+CJ+SgPJV4ZuBAQe9YXX20JrwwzUlZRERqzaeb
	 tV4rcHXG24YIFZ4i218DvmJZmZdhRgZ+NqL/GGjF/5IgH/HC8O3I09BZVFau5JUDDLWao
	 VN1k8ygCBNOq3AexgyoDZMKXCwt03zQ/fXYVvajS3f92CrqEyavVg5vYJdPSwL1w7yXRt
	 fDg8dA37CLoBIIRkj6wBvtOlw9ZmAxtpyfM95wCgDW+CGXNGfLHhAsZvo/8vRzXRF1Ca9
	 oVrGalmClj233C45HBcP9/BUbQ1Xq03II64rC6t7htNDQriG0TIT4bDFKPP8vQ///pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434111;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N/ibnVRF2DBXY7c+A4E766nAKN7fksffkL3CtEby9oc=;
	b=KvHz4cwbc+jBatpdZDqn6aoWFsdtWjJg8R9fRWzDQDKr2Bx6jwPM46XjItMIftghZumE
	 5VVzvxkkABjo+ekwsghUv/t/rDUx97+VP35GT9QAMjOzUGQvp5VSr63qKjzNK+fD5own1
	 fZ+VHnOxwmtHuv39dhuf3c5dmGIxTFoCl+vRwI4CiQgIwsQHyrwrit/39cYGDc9IgcCGj
	 PfAgTyu8QQ66hB88FMDO5QH/k743TOos6//MGaiuyYUAJBomBLmHqEdVzZzjdsHfXlE1y
	 uDFbg+XTDEgtvCnFupuEP3Q3ZiQRs58eg71vkmg6eTTBV093cuBGq0jixAchlx6cxQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrlFwZO3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2E60A2613
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrlFwZO3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D121F00A0A;
	Wed, 11 Nov 2026 21:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434110;
	bh=N/ibnVRF2DBXY7c+A4E766nAKN7fksffkL3CtEby9oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrlFwZO339J18mOngy/VzWeuT6pg7L3D8LEyPZmkao0j6rMRvVFY+RniEGPBEmfrO
	 pjWHSJHhpVPZDgypJBotGOHH8OZvlMFqAdktDGZNPLV37FJ+Y0ML695jN91bwdqXNA
	 hxHsUJckPBfTEgnCyP4CgPIfDigYiJ1Eec6FAKhYgKOuo/NwJzKtenbMCE4vBc13x3
	 VVoFplyBdnrO9iMsITZ/gF3Qb3Z07WZwNqovpwmbpU43Zkf+zayO6Hb8O0ax617OLI
	 6IhkJdmiBDKmmGrvCA0E5RnEDLp11wMADm+CsM+hYDtFRUeRdcIygcYIdrJt5QyjAi
	 yoCfC8t0UHdbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.6.y] batman-adv: stop originator purge worker before freeing TT
Date: Wed, 11 Nov 2026 16:54:45 -0500
Message-ID: <2026-11-11-1-daily-reply-0012-4bf58d3f1c6e369458ba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202612.586196-1-sven@narfation.org>
References: <20261110202612.586196-1-sven@narfation.org>
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

> [PATCH 6.6.y] batman-adv: stop originator purge worker before freeing TT
Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
