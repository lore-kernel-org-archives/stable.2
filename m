Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344385;
	b=u5in7sLSwvQlll/3wBpBz7jeQK+JKfAsOfwzVWko4YCnuG10vEr38kWuEUGwTdm5M+T+
	 aYcCeaBhGaNZh87lwUwSW1T2WyJQVY1wNMRsSOCUBDeV80N8qTScN0CUC/tOGahgSH1K+
	 EmqXkNK9Porz6/QzC2nupZQPApTNbmJZW7gSF3kZwicwjM7H6Ui/IpmsORSvB+0y1tkYx
	 T2QEwPoOhA/oxXJEVIy+u5T5wGV24DaWhQH3g2Zbn/XHdTH/1WSdZOczXyTl8osUnrd0U
	 EH/os9WyTsu7F2P3YanoUzNniDgqNA8ufOoK/AqHNvxVdxTWbaZT/Ny3BvNQ0KaL82g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F0KLPcpsr2KeDIfzdo1llt+pA1+7rIxMBvRZlVOiKcY=;
	b=mrKktTetUvGw1/FogzAm4qlULXRxQWIiOy53BaEQn2nXy50zZQyrVW03P09RbjauedcT
	 pkGP2FjSibUJNQ5oyD7HshY/L5/baZtG5PS5cuzdDomU/lcVIj+NVWNMOPMnL05u4vB+K
	 dMHzKA28SHllg1lPhLZEtyxxqvT6jNWI/4xpWFdNMwPVkQDPjSQWnKjFJydAAY6FiK+0g
	 d3RWj/R2lbCA9GGysDQdqgFRvyTxqOFZe3m0PQGV0n777S8o345mqfaZvym1xq+ESkIs/
	 shKwXBPEy28RflRBX/mRk/397Q4ESMVzZGBVh1fKHriemBuh6L/CwOzBD7JHs3K8RTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDobzJig;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2622606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDobzJig
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080CF1F0089F;
	Tue, 10 Nov 2026 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344384;
	bh=F0KLPcpsr2KeDIfzdo1llt+pA1+7rIxMBvRZlVOiKcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDobzJigjcryn0jvJosiWOSnP72Yb5izgMmawotMViCK1cTzm6xmrq30EDVyeXNwT
	 29v1fl/PZVeNs3tjfD7P5EWtQQTJAaYSlXNzzZ2OVrQx7UyohCtB3WoMuBGVcPmawr
	 YCQcCdWru7+EUZxysn5ieGsgSrFIZVGKZWIrXgCxGl7NydCwUcS2tlxULa1xmxjw00
	 1Sl9ATLcHS665CL2a71GABWjbJjogFLqQTotZFFX2V3f7zpIXIt6s9d8K3/BeHLwUT
	 2DgKJVJ5Yitu76Fn4YXnsAe7VvPhwZ+GGHFzjFbjoeSFfL9zklcODI8HUNWaDiT7ci
	 uRWpDHKHl/rtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ramin Moussavi <ramin.moussavi@yacoub.de>
Subject: Re: [PATCH 6.12.y] microblaze: restore the ABI argument home area below pt_regs (PTO)
Date: Tue, 10 Nov 2026 15:59:07 -0500
Message-ID: <2026-11-10-1-daily-reply-0011-microblaze-pto@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110085618.422250-1-ramin.moussavi@yacoub.de>
References: <20261110085618.422250-1-ramin.moussavi@yacoub.de>
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

> microblaze: restore the ABI argument home area below pt_regs (PTO)

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
