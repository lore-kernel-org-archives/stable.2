Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845206;
	b=D1xVlhQ8qJai46gwLn19DbNYn0H83hx34t4RIuDbjq0dOCCAh2sqHlWWGJ+aKRD4FZRy
	 JcyG1mIh8Ibt5PAcSoYpZQuuyal68eYq/GkO/YDwnA8SKopbNaVMsMB1PU0sIZWFNSgvw
	 sGPK1q5ororOjQQKkAtuZJY1SVYC30ID4+8BOth2vtDMG1dhRR5aaWHg/KfG2ZOuYDSKM
	 Pg0mAJ0bfDAXjnete/6UtxG/ArtR/uyGSvjsr+KNLOw/zvNBHLESJ7HhfzoCE8JEt3W5T
	 19PFeL4VRTXh/3EdxoHuSyFgGwwWGlD+v1W8ke8VBHUhD2PGpwY9n7Rb5sxW/4Y+qJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OQFlw/5JdAeNh0Gfzu0SKhCEjG+Jr4RgsxS4SPQAs3k=;
	b=Wdn2DP4DViHpZNIX5Hw8OzGyjBNGqzZBZAAjKGoBtW2ye4nVKeKvEmLiFc0k6vi6Jez3
	 5Oly8EFj9X9GPGv8DHXF+bANPtulwJgcLhj7G6tNtjmKNGhDTvsHy9XOwPP9BNlRu2lsP
	 zqfmGN445Bor1eWvesfdaWkitRq81V6xEoeXYw3CUISLWf8o8KS0Hvu+nyn2Ej/sm8Cf+
	 +ADlibtjDux6nGxYGpUiZYgykHH5G8Jz7uHMrcpwr3JG/VpQj6aG3zpkbjarcUGQjhQnh
	 dzzdbedrP6Y71OMCOmi/x8KKBoLUqDNkXX1ZNlikhk9mWXFU1fgyg3GQatDc84T8Lhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WXW/Ufzv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE4606A329;
	Mon, 16 Nov 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXW/Ufzv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633201F000C9;
	Mon, 16 Nov 2026 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845206;
	bh=OQFlw/5JdAeNh0Gfzu0SKhCEjG+Jr4RgsxS4SPQAs3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WXW/UfzvlZXtcc4iPo4WBrCfCfhDOhrKUME1A0g26Ux/yOgXONeVeGD5l1w/8HRCA
	 vNBIezEoWqiPBjjzhWgPkaVrq4VMXFksg/pH+F5p3xXsUri5jE097rW6nWZkKJhxkL
	 kQiuNZ9HSmlXgz5VZRsfzlL4oBJOzpuTwkNA7G0+6fx6xvrX2MLzp/X1k1ttmT9B7P
	 Am2wdgTqfEsC2VNY6FM5ND8ZWr/ANZdJfQJoPoHPgWwBxNcNF630/YTMlyPVYtWEws
	 2gYqUIxNWo7EnwtU9oZe0vBcuP40c4jMXpRB3/AWBJHavmGuo0eCjC2pu+qsGHWRNc
	 lGDxp99dkAPwQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan) - 10 more patches for 6.12.y/6.18.y
Date: Mon, 16 Nov 2026 11:06:36 -0500
Message-ID: <2026-11-16-1-daily-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YD2wtt+3n0Ve9c9ms42Z0x16f988Jdd4XTw-50xNE8zOg@mail.gmail.com>
References: <CAFAa3YD2wtt+3n0Ve9c9ms42Z0x16f988Jdd4XTw-50xNE8zOg@mail.gmail.com>
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

> Here are the ten fixes merged in mod-orphan since then, for 6.12.y and
> 6.18.y.

Queued the series for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
