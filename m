Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104526;
	b=hJN+uh3um77lzZZnmsrbLaLoeSm+TME2fRZqmCJ3ef5v9snnNXb5M4+FskqMHkCUXa3V
	 loyjVrtIGNugdzYjG9ZOHiHMojHHBz7wmYpc8ng0vNxiet9PfNGAM0tyh6JBVo/VSUTac
	 qbS4G5TNRNYW/wBZD2U1sC1InZrcos3w7De9ttqmoLPrBUxiSGrX0F1ydtlpDHdJXV8X8
	 JHex7PeGlNozDt3xsiRne3kqjIV2VRoueArp8OP2HHKJaxwHSdFuWM/hkh+g97E/RE1G0
	 l7M5e3qHBgkJaWikQm8b/H6wEMGxtZHbwiNbwv1DkhlxIENv/FQhWHHkEHaTQc7nwag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gRWANBlT0Bnp2XnzsfnX0TeeSBM3mHH4TnEUnF2xY/E=;
	b=Du1j3LVFww87xqyHX1aZyn2RXvKxHRW0+pRNebTl8TOUtLB/5yqemqPFJLd6I5wQqeyA
	 TrcdVywOmOO1QQs6lmfu1gxECDCNyZM/9ZfJ8hpMK3iYiG6TJRbq3KqL6HOUMpVivHRP5
	 XKWSUNvtAb5Y2p+H4IVrDuYeVn/nvZg14FvKxJVdYJFLSlxKnSgrSTOcRicSObqOO7ruA
	 6tytUpxVcUuG/E7PQd9KNCcyxhYHvKpSfKexiOmwSpcAe0X79oPHQFnr6KtVT7mA7Hv5t
	 EQJbqlWdf4hsYhz5Mt7BZOVgoy1NMyREKHpvy1iRIvZ6FGWcHYdtXDitkdIoO6nLUMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfEad8J0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0F606A326;
	Thu, 19 Nov 2026 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfEad8J0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C2E1F000CA;
	Thu, 19 Nov 2026 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104525;
	bh=gRWANBlT0Bnp2XnzsfnX0TeeSBM3mHH4TnEUnF2xY/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfEad8J0gBUUb3/f+K2Bitq7PHpdeSwCQM3KUXdcfafUDjcWZQ5MNb7tdEsGTQrYX
	 jH+KhtXrnN1NjJIsSQO6CjoUsJViHkAeCoZklCFWvM+OQJfJDTfZroGXcbztZWK9dp
	 0n870HjgPQ4YzzqFdLyzxxzI6m28o8IyOcr2PvObloJpgtXLgNsK7uhiCPiO8aJTVj
	 kfMYzKR298omJAk+51I9uUcMNFe1dZRpDcPacJQTKG65D6Z6oCwIHvpx0REJaN9y5t
	 vpGKpEnXRhAxETlaFcR7TQKlenb3Lo6pTheFT1EMwCg0h/kkvy8UGnOzYoiNDR7PgN
	 B8DR+jixPQJQg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	asatsuyu.liu@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH 6.18.y 0/2] bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
Date: Thu, 19 Nov 2026 11:08:13 -0500
Message-ID: <2026-11-19-1-daily-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
References: <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
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

> Here is a direct backport of upstream commit
> 1a5c01d2508a ("bpf: Make KF_TRUSTED_ARGS the default for all kfuncs")
> to v6.18.64.

This changes verifier behaviour for every kfunc: programs that load today
(for instance NULL arguments to the netfilter conntrack kfuncs) will be
rejected. The series also leaves out the other selftest fixes that went in
with 1a5c01d2508a ("bpf: Make KF_TRUSTED_ARGS the default for all kfuncs").

I'm holding this until a BPF maintainer acks it for stable.

-- 
Thanks,
Sasha
