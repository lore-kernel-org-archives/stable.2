Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798940;
	b=P5IJbcpBeNpIwndBHABiTPsn3IRyXMxPIYFpCq89BEFoqhAuMJQlr78dn3F54jaVaxa6
	 oVXOT7DDhlV9RebOq3ydcU/8x73qtQCr9XC/i8eFlb3SvaPoYDE5Oxw79iqc0cVUR9QuK
	 hflhytqGvlrGISKSDpu10ycUlP47iUGg17xnyx/Zgv2VIq0z3Lk4OgX3h7c6rpz10UFVX
	 /LPrZV9O24mF6dLnf1UGpk1lVV0pIU0Li+ZTn5gljeUgSs1I/Lt6LLWM7alq6WzRVT9JB
	 7uWaSjQdRHlj08qUwCfRSZsYc7rm4GhENBFX+m/6YGE4JbgyHpKz5I8OBI+gQ3tmHvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798940;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qXQu/4k2BXjaKqQM1WzL+2EDoyyDvPqsLl+JPhwYs0s=;
	b=d30YW7tJi0kZEqt4BCIJaklecAoeho9X7mkNdTQc6G03Vk8zY8BDGkifCcr99Y2pvXiO
	 0/17sAdWJf2Ca2nfNnHGW4XfGiv3XkeA7OcJ2+5DhIkExW/lqjDfXBbKfgCTfdTa/CaUv
	 95iymzePkNRWmxCbGG3HFFs9WHZ6TJ5C7Ie/0FJi7AQXFgC9dsj5P/UWhdQaMJG3pfS7e
	 3GihCNrGu6EmCcn4z2jvelyDeW85NFjdCZ6SxaubF29mJu1lWxufh4X7Vezcivn1FQ6gU
	 vI09+kPOeyFCT6flXohl0cUtCr46d+rJnaRDDHI54lPTz5EqjtzPAw5XeRdrjKuhVxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jrgv1f+H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D73606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jrgv1f+H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19CB1F00919;
	Fri, 27 Nov 2026 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798940;
	bh=qXQu/4k2BXjaKqQM1WzL+2EDoyyDvPqsLl+JPhwYs0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jrgv1f+HITseOGYhD8zD2PtFkG06FubLVxm2gnVMS/Qm3nsHjSA2ufZm0nnCr1uSZ
	 H5IebNBoVr47DwLyUyQrR7o2kReNwNR1t3+vT20bjf9GjyqPQJ+njfcMm4N9L5pf4c
	 1jkSwr/NZ5ZfKxG1OB/B9i7d/KgzBI5Kveb98BqRWQ2P5VMXbiqq5OTJmoAlrAISLi
	 s4lY1OiR7OsZHEzDu6kaaEx7fSEI+yq7PGgDbJDMPN3cYL68eSsWsVGuad3IRuI1ZC
	 FlciPpcEOplg4ucm9qBk1FGw94NV1MaJF8XhXb4yyurRrMa1FcmfM1BLfo7alrf4L5
	 ozIg3NzZtQG6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.12.y] watchdog: npcm: fix clock prepare leak when setting timeout on a running watchdog
Date: Fri, 27 Nov 2026 12:01:16 -0500
Message-ID: <2026-11-26-1-daily-reply-0028@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126032506.1227-1-zhaofeng2@cmss.chinamobile.com>
References: <20261126032506.1227-1-zhaofeng2@cmss.chinamobile.com>
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

>  6.12.y backport: 6.12 retains the `if (wdt->clk)` NULL check which
>  upstream removed before this fix.

Thanks, but I had already answered the 6.12 and 6.6 FAILED notices (and the 6.1
one) with a two-patch backport: ad3746700ae2 ("watchdog: npcm: Remove
unnecessary NULL check before clk_prepare_enable/clk_disable_unprepare")
followed by a clean pick of the fix. That is what got queued for 6.12, 6.6 and
6.1, so I'm not taking this one or the 6.6 version.

-- 
Thanks,
Sasha
