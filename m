Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634654;
	b=yYyV5CcQ4T2oN2J1GMvB4OxlJyh57glb2004tsSOWrEcT8kPNgI9enPqhhG7OjQbbq9P
	 YkI6MQozbk1Jyd53hgb0aZh0cnyQqpRuwV7KK4glNDJYn85ka6xDxld+2ar+J++2ncfaZ
	 3zboN2qsFlAp/68S/QrenYelEzOm7cNdH8kEv8IPzBpkttZSGmDQMLzKyxwvnaQdjNms0
	 pIi9WKzSeX/Kw1pwAYa/D1T0BX3+fR6vqgJK8ggKezQo+eeB2i0c5Wdu2sHGHFGt93nM2
	 dCzt6AqTcJ1AUMo39vTpXziMQ6KI+Odj0b4ST/K1K7EpCeXJBI69EnbuFK4wDXSVn2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PpC+5qruWV6BLGMaclW3gIjyqrRvHW0AgXlZbUrAEv4=;
	b=mHFEvCTC1n0FETb7BKIYnWngFvrgOqfiOmVCLv5F6p1yVfKmPD4AeWtvsD3Ai7XbVjuc
	 016X/onKc14dVP1M0bl5qBZRhsz7RblQ/ewLdrM+Lq+dQMWaD6Gw8xDM5R11YiU4plYDN
	 zBBp/v0K1UC2D71IRAvrSH/baBV6Xpcdn13iloio4SbGy74T/is1D10veuHvPOJB7w6pq
	 fbAMyyxdIQKwuq4k1XgWonKfZ00PhbkzcEbaJtmyHgiAPXiYgmWlrzvxUhkDY8fJwBP2R
	 mvmdcgOoh4y7sKaRu6H49SPEBP32bC/689xC8OFACSWvMoq+6ATL74uVCU2e9mycuig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDmLwhbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5D606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDmLwhbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3433E1F000C4;
	Thu, 22 Oct 2026 02:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634654;
	bh=PpC+5qruWV6BLGMaclW3gIjyqrRvHW0AgXlZbUrAEv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eDmLwhbOp4GErkKdCjWllUK4b7esVGzTVu0c/xrf53kkJJP7zr36uDe9Ryi8FKygS
	 gwcAvc58Aga1X4XD1vuVvDEfjKCOHVxf2rvl7DyNDdvR0/dckH05hTBQEkuUqsfAaZ
	 V0x7Zn0Glx9iF4lqu408qIGZaTRHoOah3QSPAOv8LF7silrYiaQ2pcwsmrYJJekElL
	 jyyHGSCzSP7O0shhI+XoDYNa4wfgh52R2erZfBtajBCSlMy+XVbwSVH2xsC+OG8LAD
	 fPvxkncZLnFj1fTjAORK4xsQrl8dgfIgV4GJzFZ6FRjQoeqz3RHcrolx9YbnIBYczQ
	 goM/HzYQ8PnPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Di Shen <di.shen@unisoc.com>,
	Ling Xu <ling_ling.xu@unisoc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] OPP: Fix race between OPP addition and lookup
Date: Wed, 21 Oct 2026 22:03:39 -0400
Message-ID: <2026-10-21-1-daily-reply-0014-opp-add-lookup-race-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-74405-5-10-v1-1-e59b22d4afa8@bootlin.com>
References: <20261020-cve-2026-74405-5-10-v1-1-e59b22d4afa8@bootlin.com>
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

> A race exists between dev_pm_opp_add_dynamic() and
> dev_pm_opp_find_freq_exact():

Queued for 5.10, thanks.

> When I'm backporting a patch for a lot of LTS, currently I cherry-pick
> for each LTS, and if there is no conflict and it compiles I send it to
> this list for each LTS. Is this okay for you, as it show that the
> backport was tested for multiple versions ? Or would you prefer that I
> only send a new patch if there was something to do ?

A clean cherry-pick doesn't need a resend for each tree. Please send a
backport only when the cherry-pick needed adaptation.

-- 
Thanks,
Sasha
