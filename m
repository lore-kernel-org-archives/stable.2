Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318771;
	b=XlqDyvOLsBrNJguPfdGVuVov6w6OcNbQYc+HlYWRSlbdzus9kOzZwJIiWVcCSrIiUNID
	 9hGE5eFQalAGaf1a1/ZMaejMYWNawNUwlp/6m92WW8MxUsP2B84R/ez+sT1qFBM74iA4b
	 vzffczZmlR9QzgC0MpQbZYltmdF2AV2Pdl6qHhC64uzSfFG460EH9BdKdMnbs3VX98YBo
	 SbaRlcGQQlnbmWd9aMpjwiuefI6IvFy1Au32XKJfndrQAhLHhbQoX+BeiPqEsyCGp0GjY
	 VSLWCQFD+d8v+zULPifRvA2swr8zPaoLXergz+PKJIN6WsuT2M4Je9JorsbCfwJZBsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PLbuL06sFlyANmBEVvYnV5dLMpV37RDe3mWJRsZ2LAw=;
	b=Wsc36zLN5NZbXWYMLtRc1TtUUL/ryV9Pv9GDEHt1QLRmFV17wOFhE4aXkQsWxEPupXaX
	 LqbQ1XoUHLto1wXv4IG/9gaJvegN9tBvFq6fR/0CFj2XGTdYvGbVSaz/N4ZuSCXHTbBGe
	 V03P7S32Tt+wFH8SALkAkEjmom2dYBLZz5oApxtT8LBbZIirC2rX3mERmadgTh+UYNBAV
	 HKTlV4LnUgrtyitz9DIsH6SnQ1DawtA+QUQQRfpIS1+ls6deKt55zbLFcMrVD5tqnPvCO
	 gj0/7brlQKNrh2eoyz2y0W2aSTCT1HzWllMw41zi1A/U3K0CLTg8hoANpnOJx8W5w3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GPK/0tDn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784A606A332
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPK/0tDn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01961F000C6;
	Sun, 22 Nov 2026 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318771;
	bh=PLbuL06sFlyANmBEVvYnV5dLMpV37RDe3mWJRsZ2LAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GPK/0tDn5dAdMldCF82UG7hdvr6afR8nBtRsOxS7L17XfDsgpXXmjJjpkzz0zs6Tn
	 CrRxCvWUWT3v5VE/albuiMw0uqSH2MtHhy0PL4FDYaN4RO1S//9JkgeH3k1LJCIFOe
	 yw0MpKdNCEYfjf3j0n2kCnE62Egh8gSay4lelCcv4QvkqSKvSORhs2Vxq3pgUhW/EP
	 vwIBxNoh/XTXwZk/0GmVGKpvWYJ+U5rv4dt/WU8EvE+IXSHbph1k5iTDLCT3uwAb17
	 N5SPH5kcg0h+QAPdtgWz3ySTtVdqk/kZyu/XH4EqROdAZd/+YI9q1VHHnN1Vh7uPoD
	 vQa1m77VVeeyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.1.y 0/4] io_uring fixes for 6.1-stable
Date: Sat, 21 Nov 2026 22:38:58 -0500
Message-ID: <2026-11-21-2-daily-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121213006.1787626-1-axboe@kernel.dk>
References: <20261121213006.1787626-1-axboe@kernel.dk>
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

> Here are io_uring fixes for 6.1-stable. All 4 patches are in Linus's
> tree.

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
