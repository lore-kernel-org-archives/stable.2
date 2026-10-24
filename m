Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872697;
	b=gBIbGjDOD+GYCCJILTW05qtuyp4u1Ih2EcitQG9b6z0fp2LTou7th+zz9lpKA81UCtqf
	 QjQY1jeNWwRTYRq2JuQWgxanBigHWpSmvbacMcoCibR/0ZEP7w6wzNain/mz69dCGbqFG
	 vFubhInQEeRjKUEdNQ5DiQQSU0lJhMBzdnBrw61Hf/rBi5jiROqapVcl5pvOeZHNWBZgd
	 ekl0q4ZuG+aqqHyBTBSJWusBI8/t3JIbuh4fLivUOKr0YZqLJHI5zvRRHv6Sp4AdoE99S
	 bJ5PnTscCbxHGSZHOrMHFwg4zV2sEn2OZiwPsMKBWr16dGS3lfxMG8RSRUi4fgiM2fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mMIEVoAwh93h4ClXvRNbxxyxNgwNFPgmnZjBQorLvmk=;
	b=0GZeidkWHFIcvseE2LDtJU7Dm41Egsh21vOk4ewMJtoTsOSjeVhjVUtfzvOtwlxvM2Fy
	 kPqvapqlVyTJu46nDXgOCCF5I+sVbLuoWR20azBQta1Hn14XENVG42lIrOAcY6+2GKxP9
	 5uZ102RyFBQAho2ZMBvgKIBvw34D72JKRx+GVDOnBOGHiY6RHwkbnq6fzBVyIVR0aRItM
	 k5jDz3SHGdVdNQMxfo0s/ZFbb8lF8nZTdojlnjSCIBvPtFtpqRYy+0s/X0BXlFn5zQhO2
	 ShKQgeI1NVTK57FifXpIGTyXuTMNie9s6v8rdmBpJd9EfVbWaLoPRKJGeYAaQwDgCDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STn+IRd8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD23606A321
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STn+IRd8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C44E1F031E2;
	Sat, 24 Oct 2026 20:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872696;
	bh=mMIEVoAwh93h4ClXvRNbxxyxNgwNFPgmnZjBQorLvmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=STn+IRd8KN6rP4CeuXIB6DSbrlqa6qKsGMxT3XO5H+mCB4ieZb/V0UK1cL7q+tRLG
	 T7T5NCdE0nscbvELvC61UNho3SyFRbpYI8Nt1o545czf6Ym5VdC2CdYGZfBzYIEYcL
	 loEn2s0VGk3VywuwDYl8WvvzBVeaA8ZDWvIFIwuxkH8OER/AI7UiZFgLU8oDyqKjU1
	 6IpK54AIv9Xhw1uVGLctM/uN44bGzaqXNKTLnC2iAuRWhLZAL25bDD9tJqaemdWSjM
	 1Adp9Pw3vX0Mf8efRxvUNfMbG8kpS5+BjdzpUTLEWBvn4T3DMyJMWdX3V5X/LQvAB/
	 fYZI1Y905FIYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 6.1.y] net: gso: limit recursive IP-in-IP segmentation
Date: Sat, 24 Oct 2026 16:11:09 -0400
Message-ID: <2026-10-24-1-daily-reply-0011-gso-ipip-recursion-6-1-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024122720.641-1-ue081723@gmail.com>
References: <20261024122720.641-1-ue081723@gmail.com>
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

> Tested on top of v6.1.190 plus the whole current 6.1 queue
> (stable-queue fa04d3db75, applied with quilt). It needs the queued
> backport of 6f1a9140ecda ("net: add xmit recursion limit to tunnel
> xmit functions") for IP_TUNNEL_RECURSION_LIMIT, which v6.1.190 and
> 6.1.191-rc1 do not have yet.

That backport of 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit
functions") is no longer in the 6.1 queue, so IP_TUNNEL_RECURSION_LIMIT is not
declared and this patch fails to build:

  net/ipv6/ip6_offload.c:92: error: 'IP_TUNNEL_RECURSION_LIMIT' undeclared

How was this tested against the current queue?

Please make sure that what you send it actually tested, this is not ok...

-- 
Thanks,
Sasha
