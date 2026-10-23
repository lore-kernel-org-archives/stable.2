Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785793;
	b=EPYc8TCYJdH3ShNf6Kuw2DKqdRomDQxoj4h30TqfR+rDE9rd0D4N2lnnj+akKgeeivJv
	 rw06MOuB75HHGeOuZHkg7h7cUJP5AXKa6yHTpTxGcX3+EMS9yLgMT9vjkXG6pGbuT6mlI
	 qNlhOtelaG8AjXwiqjj1p7Ei0psiT1oGHKs12STrdQnNCS4Kc83AFbv8UwujOdEbL82ZG
	 qIRHJ3mOczmU5Lu7HKee0+obwP6ZehZh1JLZ6BLCVeUilVsBCOmhrRjneuxSdE0eB6mce
	 F/LUVGhtI9uEqqb8/ppnJ/qXbcXuREhBSn2nJfqesY4V8vZB+o6nX7/YuBHbKy22N6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZnkW/Vl++l5qLA3prJIxC618dlVhI/ylgjw4H0ZfZ/U=;
	b=dFSBAm4TPPVT5A0GNef9AgJlhir1vbD8qEfvshcR7pEJa08aIWJzVoC/CaONqXZDvGRl
	 phbHsXLYl/yx2YxpyW9diHJpdHXY9xqDbPElwxSUMI6RWbdf/YR+dtorDwK79fa2kzCT/
	 bCOh2ih4oii5Z0l+/1xvZ5Bd/cu6JyKzzj4OXxU0waapwWYLeC/4cVLv3VTSOIg9pDgfF
	 zo1qUeHCdXqGHVp8nhquM4vk76kScMd0AVwOkJZGaKomfvxIIFbhrc34MVY0ixD0tZ2Bx
	 hh0KYr653Zl4NiKCrbXzegnr/VP5JMEBO485ZTEI9hakm2oujPLKJ3atr/iko6QtyoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtzS0d1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C773606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtzS0d1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CEE1F01828;
	Fri, 23 Oct 2026 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785793;
	bh=ZnkW/Vl++l5qLA3prJIxC618dlVhI/ylgjw4H0ZfZ/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtzS0d1wvcmKINcg8h96d7CyE9H+r4meAXhxFbdYR6pKr+H7rlLkJIvp05jxfN3g+
	 dMC2cMu5vNNb8j8TiPXyk1mLqHLyWAM1I6Cl9ALgY3K/yeHATfya2D9qC7G5bwjrtC
	 xLOohBaYR4h30+vF088GsUO/PBLhemNdaV84UvaxO1CZQtY25bUD/nYrj/whudbiX1
	 1gDezVEmUJKLj2daLk1rbEMzhY6Y6Pi8UAU/+QVZPXDwEj5L4KGYv/G41jPq+UB0qk
	 I5LoRj5OfWp4qwx/H9HZz5UGPG95vt7Lnv7MsfgMkpq3vJmkP3kEC/eYB3dJYvYKlS
	 vum4UZoC4K2yA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Linmao Li <lilinmao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Miguel Gazquez <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] Input: byd - synchronize timer deletion before freeing private data
Date: Fri, 23 Oct 2026 16:02:51 -0400
Message-ID: <2026-10-23-1-daily-reply-0015-byd-timer-5-15-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9f8f371c-0953-4cb3-a99e-8361a5cc8821@bootlin.com>
References: <9f8f371c-0953-4cb3-a99e-8361a5cc8821@bootlin.com>
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

> Is there a reason why this wasn't merged ?

No, those were missed. Both are queued now for 5.15 and 5.10.

-- 
Thanks,
Sasha
