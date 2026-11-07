Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060861;
	b=JBfg/xANsJqqd565e8TqJzQP+oOep2/Xv7tOCryLu9CMJuEZuXTrDoxaE/tOn09x2Sfz
	 2PgKLEP90X6PFOO+Pwoc3LMJR0dFex5crBHwVxio4nybq77gamXWGGnCxIga3dcUiQE9s
	 v6Swwc62aHyNlj+jGayviz+bqYhakYRHVFy6tmcix/+Picu8yhxpyoTkZnPIIY41Oad5/
	 f6u6eChAqc7f0AZB/2g+2J5rkjQ1KlUvfFK5DwoCGSCOYPp2/wZvMcSS84oukf7r2WXx8
	 QPCQ52r/S8YpEGHoSSQe/9xELcaapOKaHwUxQnpOgPnzSKMjxkWVxAsTcO2HBuQV82g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060861;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=RPPlRfAa8q8m8kCH4uT5obJP/Uf1/VTGNGMMDfFCbMQ=;
	b=gZF8yGbj9qR8bWsARfb4+Q9j35HUlVVAzRkVsqYXysIEP3yUC6YmPpoE7G4mxJN5U6Wj
	 8azkJWxvnyH+KQYJop5wRJo8nG4n6qqTtaAta9KZo/796mUmIWxmFhut9scnl/DU+U8vK
	 NrdQ/CtktPZqUHBF/j/vUaK2NcBnhlCAbY3RCjvqNGKmIt86JKvEGh7BYEj42/ZOH6p9s
	 jMQLvxsKwbdSFMVQley9krplcbRxPBfFu26lxE7tst+wcZO6Jtynf2nJuDYSZ/r+klqfI
	 MmiTc42+mIP3bonEqv+3+7qu2uVlJNLv6MJVD1kBMC/HWSBVrye18D+fFXtkSIiea3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f1IRyn2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71821606D834;
	Sat,  7 Nov 2026 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1IRyn2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C741F0089F;
	Sat,  7 Nov 2026 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794060861;
	bh=RPPlRfAa8q8m8kCH4uT5obJP/Uf1/VTGNGMMDfFCbMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f1IRyn2/Dk6JQfdqfRFHHDKQGpk1hoxJ7mMklxxgAGoXuepM3aaQwhHCJPPBTZyjY
	 YZCbYosjuNx9EDZ+KdOsRvOwC3ENGERUNG+/kL3CSgAGJbfWXXN+wK/QeCzH+vWn1L
	 6zuwWQrxM+JzLEVPupOA7tqs98h/VwqfHQsLBm5t7HcsHyrNSYuunJrTt5b36WroZ3
	 CIiXkaxIIb1AnrmvBKTq+d/tShMiVh/RX+Fo5i0zu/WKmn7KbdfDYLw1pQF7iGBOLk
	 R4Mf5NyOVd4hZ/NkXJb4HNcaLWhb2Q+tAo4ULKfprXH1ZVotTjZeA5FvFlS/6ZbhiA
	 6sf4KXWxSAxGw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id DBE0F29E6B03;
	Sat, 07 Nov 2026 14:14:17 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Ban Tao <fengzheng923@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Joao Schim <joao@schimsalabim.eu>, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiale Yao <yaojiale02@163.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20261028050626.133421-1-yaojiale02@163.com>
References: <20261028050626.133421-1-yaojiale02@163.com>
Subject: Re: [PATCH] ASoC: sunxi: sun50i-dmic: resume device for control
 access
Message-Id: <179405379422.3424803.12187103513130159217.b4-ty@b4>
Date: Sat, 07 Nov 2026 12:16:34 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Gu1jY485f4IoGWid9OKwTb1mv5ZWsLOBY84mmSMNKrE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeG1kmymo8l2CKLdzRIesYnnZH6qabygPdQB+zUwUPZ
 i/MVGbvKGVhEONikBVTZInL4n5ZX/J6Dd/BhW0wc1iZQIYwcHEKwES8Ghn+uwsysivcezXhK0vs
 yai2pyp1nlECsz9Xs23uVtjXLdRXxMjwT42Jb1YKx4ydCdu/C5RftOu0twy0EFym42kkENs9iYs
 dAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 28 Oct 2026 13:06:26 +0800, Jiale Yao wrote:
> ASoC: sunxi: sun50i-dmic: resume device for control access

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: sunxi: sun50i-dmic: resume device for control access
      https://git.kernel.org/broonie/sound/c/73ade6a51c79

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

