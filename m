Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762433;
	b=vdmvXjBKL3jNlaO2/WrUOvkDhYHMk9PUeH7xL+K2A8Skwaf4pjT+VDaO393xx+LE5oM/
	 +B/p/HJ7ws6juSRDG7aGYrr9PldjiqoxJ13D/hINvOZfvXGsXnpz9gjggczDadvkruk7q
	 UJ07EHQF6yJa2p28JleuKIqb6ENprKS2Q04BvIB/BK+7T3FKDjaeDH8ZPFrOnd3JWn8jJ
	 SDkQQhgv4hj8xzmMcpB0pIEP0IkQthqd/J2Hko6GoQLjYZuBYu3U6oJTxbAMXmLX7uM7k
	 T199nM1ia8IkJNT9SupaYnqrZzkLwADI2s09+4r474f/SZDOBBahb05p9ukQ8XenFTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=2H0t5kpM3pe14/mbVtSpoJZsm/og4/cN5Fop4PduzXRHab5sUhJdQZUfHE4tnuWKrnOf
	 kiRXLFLRu2C2iHvdGLyWv3uMBiHE2WXcs8PwxIAqUltLCpNU662L/uvqCGGtgfVX8VxlZ
	 R2FpSf3BnS40AH3VYty5qDe7J9sJR3p0DkOzPb+WDksdRMNWVwP6KnqwinzMdrNJ12rvJ
	 hrUpTgaECfmCJxCaHADf9OVBok7RMd47XnBPvNtdPuzscfeB5M4wuSJ8+WpV90RbUFpM7
	 bOcANQdcYa9fOoz+2S3NvZyPKX3Mz9qAF4I5fWPIwk3dixpaIvhjdR6okCDv0TL+Djg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhz7djXo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F2606A31E;
	Fri, 27 Nov 2026 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhz7djXo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F861F00893;
	Fri, 27 Nov 2026 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762433;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dhz7djXok8SLAjIzI4X5L/BWYSDpHRLmMjvU2ftAlS0nD49hnqwJVS4iXo4iIw5R8
	 vSsTcDAhxYuJN1E/wMswWX/MEtFoWoWMbzmn2cxHR3tJXBIi7ZLFZ2dAR9YfhqpziC
	 nt2KLCUGCuYnNjCwHxRoqfqEJNQsEmb9+qhrB90pa3fjSyPwKfOssYSrszwdRxi73j
	 h2BOmfLQMsiW/QIKvhjCL1H/PuNsW3h6/1jBAwCPpZhkfva03P6ID/JEUWqWxeOxRv
	 lgKUHRJf9WGOqAXVZR3CU++SO6lmP+ROBV1qLDdsshs9PS9RyJwSpnvHgL3i4rMDBP
	 T2Of9y9PCSJBQ==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] geneve: don't announce options that are not geneve options
Date: Fri, 27 Nov 2026 06:53:52 +0000
Message-ID: <179576243210.3294.12001284268844727459@kernel.org>
In-Reply-To: <20261127064706.2920854-1-bsdhenrymartin@gmail.com>
References: <20261127064706.2920854-1-bsdhenrymartin@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
