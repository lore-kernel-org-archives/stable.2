Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537218;
	b=hTSZFPEeN5DbqmN+QNCQ/ZHytv02aZcKQIaPZ1HM80Ccd4zR1D+YZCZrIO/PJsEV3ufZ
	 MPgHwz2Bt5wHG36m1jiuDCCneJEA6cXBNStK7b5GtPkFLAOzjwotrqahHK/PzooVOYuS9
	 yEG8XYPQf9ZqNyYOOoaxqN30hoWPPGxdS8Ne7G3HBQYv4pRnEyaD3kUJXtXBo3jmao70A
	 6p2O2WAtnT4+kqurK6VlzuV0/9LYlkun4CYzB/Spn2dnFvpQMxre0K5YawvmoNpo8U2cP
	 5DoAJU/r8KybaOXZgkCfgHynMRSP2ntQMDzdQT+m+1Y3CA/k6A2jzBYJEo1XfE9XD+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sImPGd+fAMrEL7HbmeWPmITNnXULrp43D9IT1EwmzwY=;
	b=AlsGdE3tY+qg3kxIsDl7p1ey8hdujjJPaW5hheNdaR9xLYiEr267GG6XeXUWHiLTdaFu
	 xN2K3qY4v0jgbdrYwe7dGKzOBw/YC6LcOFyh1ZdzKC6DCpuD78mEwWt315tkPgQjVnEVF
	 TaRrwBotk14HjeOUvrF6iWgjoJMlAzp02jh1pCIv/gh1AwtP/Hk8NwdA4wlvFov/+MZKt
	 dHaW1gmXcX4Rh3YozCsEiNSaanMp09gDPbkqG+NadP3U3RumDWItCRfl9kcEP1Uahag9q
	 7wkLoTaq3uVCJ+/bFU82vRwy3VYMo0X6yBxGLQR3znUQQJ9a6YwFkVU7BcsG2Z5oEcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTiBRj4Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4D606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTiBRj4Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6EB1F000CB;
	Fri, 13 Nov 2026 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537218;
	bh=sImPGd+fAMrEL7HbmeWPmITNnXULrp43D9IT1EwmzwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTiBRj4Yzm7MfkwbjMgj6pw3iTjgJEMYpm1YEjpJhalwD+RqgTjyXjLy5exT4bgPd
	 fGOU9kv+fAbJqN/u1Ts5wsO3DPF/uPvFCHiXJrgyNZQ7lD1Tel0kHdtlR2k+p75ZoN
	 vbKKjf9zLsYhl9Zd0LTvAq/GQv7MvoRBGEjO3PPayIEAc+rnwSnZdH4/NciZ+0CtA8
	 Fv3nBwBhRPvEsqrbFDtRmLARjrq/QJZlrZcRqqMwf2JDE4J0D5e9tsn9iEjHjNK5e7
	 4DinU5o4Js9pNNR5shbd3az4cFa3j91znevRJ+/UYySCghuhKamWLMRMPvw7cXIfRY
	 nPaDgf5RCkorQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 6.1.y] alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms
Date: Thu, 12 Nov 2026 21:33:18 -0500
Message-ID: <daily-reply-2026-11-12-1164073557@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111175819.1156018-1-linmag7@gmail.com>
References: <20261111175819.1156018-1-linmag7@gmail.com>
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

On 2026-11-11, Magnus Lindholm wrote:
> [PATCH 6.1.y] alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms
> Keep the older 6.1.y callback argument cast.  The Alpha migration
> callback is present here, so that hunk is retained.  The prerequisite
> which stops clearing remote MMU contexts is already in the 6.1.y base;

Queued for 6.1, thanks.


-- 
Thanks,
Sasha
