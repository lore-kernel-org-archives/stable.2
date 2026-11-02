Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623282;
	b=pVZFRbLUORW9hNJZvvfZELdh+VpGd8BCJh9BwdPg3jOOBJXT2ZogZeStlT+avsdPiExM
	 8X3hnENp4D2X+ss3M/AF73PVAz75OMizzS7MYTThECiYvKOKatgOK98IQiOaPyg4qseSg
	 zYyIAzQ2dFEESNY4Z0aSo9fLeuUtedK5EOA36kyM8IGAOfOfm5Gl1aKvXZHpYLuFhl5/x
	 q9oy8oxxovCRpMMl0XRJ7htNAbcSeIiR/iHhHSQ5UmBpl4J+qwESmfz4mF2XrPq50nXFA
	 rYJEUPpvYhXHNRYTA7Y0cbSnegtpntg3unAo23l/qPfFkmHu3HrQiWDnNRt/NUC+DeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623282;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=wG6PVl9afjCgJht1ela7RS82/k1lmfw/hbm2CmVadAE=;
	b=QqgS8yVodk7rZkZLRicVdwWT046jOlDPNgzs0Cc45EZE2+7JWZeZr+ywLEDfWILwyS6/
	 W40XdAjcSV8XFDxpjAYE6kh6aqLP/2/JSnRwYd5Z2dXVCCKMUwDo3JpkNED7AlD5vC10/
	 CzVhYkD4pwxg+witQRGZWJlMyJzph9y72jRjOk0MiQqULYIrBwzLoch6jE2pA7dl/Hmg3
	 Y0EUfeH/W3hx7I8NCdcoBZJX6WBM0W+xtM2qtaDLktMY/UDA8QcEqYb4QxbrBhg1StsWI
	 /hEgQxwU6/aiyhnQoXQaOoVjCjOzQ8P/QziumotNd1K+NBwQ8g4Pq8r/aVIIu5ZfLVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A0G9qo1H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E960A2612;
	Mon,  2 Nov 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A0G9qo1H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70251F00A1E;
	Mon,  2 Nov 2026 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623281;
	bh=wG6PVl9afjCgJht1ela7RS82/k1lmfw/hbm2CmVadAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=A0G9qo1HUDB2TLR+mGlJMsBlaviQdgwHXOGYKSlzvODvmwk69v4yNP566InFCzca0
	 ctGpvI0Kfhk9I9W246kA0UxRUEtQQDezHhbcgAQUCyeJBJpT3oQqkkrhoLv0cFnRrV
	 rtKyNyK6HsvMNzLdwvF24ji51IgihhTggBKVKtx5kRaJtGR+/LqmL7WHgQ5Ned/989
	 v41eRZwMYs/l+E3gxnovCZHp5t5kaU2qe1w0cNLB22hEN8LZoJK15KR57D1r1H25Sy
	 P77WgcRvuF8P1pFFk/wSL7+EoAme3ujOZw1rR9z+Rw+E/skrO5xgl1sjlOTQHlG7lM
	 UpCZget492RyQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 1661D2310396;
	Mon, 02 Nov 2026 12:41:20 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Gianluca Balboni <gianluca.balboni06@gmail.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261031102136.24600-1-gianluca.balboni06@gmail.com>
References: <20261031102136.24600-1-gianluca.balboni06@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop
 16-by0xxx
Message-Id: <179358147029.1776482.17688065387290621695.b4-ty@b4>
Date: Mon, 02 Nov 2026 01:04:30 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EaL75SNL5ucRFJvQ8UXpIEJyGbu9Bl+L/9Mt/Esv7VM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetLy/PPd69QXXqnu7n7/fk3U1980GEaHpzv5Zn2yU+
 pQEv6042FHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJRE9h+J/k3uceMEFmdkQb
 Z2H0lm/7DQKypt7QObDVUjpunuZ20RCG/x7p8z1iygSq+/rmLxO9b/a9Ie/Z5pjLmj92S9bIX7f
 6wAwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 31 Oct 2026 11:21:36 +0100, Gianluca Balboni wrote:
> ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx
      https://git.kernel.org/broonie/sound/c/1e73257dff33

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

