Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664440;
	b=phqQnUPts7UIaJYPkvN6sui39oxPGrgiIwNCd1TYzZwtR0i8/n/FzZDvNeMcwF7UFTe0
	 Mfhe/yyMdHtG6bZ1ppEcOoMpmJPFK0S9oDPgWcgCDEu80Zx0rXSgcJCbJKBHHM5bOsZXA
	 bfVUjSRLenLAGXU58PhjYOFU0X041w89oTWnys6vodrfcxoG4oXvUhQESvGMFLXMZu7/p
	 cfceNPNHSiXCgEQRwRTQpT51JLW5OMdxlHWq4nHMsOlHcC9Kbk2fukHNIvlIlAJTc7p5c
	 O/T2ZbOMG1E7eSRKVsTvQxGP/QUL8cdWG0O4ICy+RxN1NdgCg7khGFDbtjspIdmfeTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664440;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qUlR2HVhwzzB13nKghCD6zW/Rz6gdlT3qv4Azsy/Fyw=;
	b=kpvGWvDzj2P0oKSrQyyeZW9M5skZrA6kouPH64DaXtoUF7Ck2/Sa7uRbnlC0kj3BFvtJ
	 cttmIEz1RxE9FLUW4Ri3BRb1bWna8BGbHM4MchVPhoKxXVmYdtiP+Pf1nr22XAB/uz8Iu
	 jbPMH5siJvpMNy6mKSyHBxleaHgOwPqUPRkHCxt+STwWojZ+cfQ/DN5I6cO9W6mA70oz2
	 JV9zCengbkmS0V0TI6Gx0mhmWI77BDAqj0krdAdNVo+VVWZ2hSmk9t6ULN8COgk/0bbSH
	 rGooPyHJ05sH/Fp2d1R4CrVv6vTNRhmXvBaemb6p+VhG3xBEnUIC/EL/BdyM+HNsyEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiakG14G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80195606A324;
	Tue,  3 Nov 2026 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiakG14G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADA31F000C1;
	Tue,  3 Nov 2026 00:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664440;
	bh=qUlR2HVhwzzB13nKghCD6zW/Rz6gdlT3qv4Azsy/Fyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RiakG14GsS06yW6UK4ZxE6knzHsaBbvopUusHSNKsA9LT4JyeVVco5lDu8iXkL+GP
	 /ZCsOErMVNs071LHE9WA0m0OudEnl88DVoqKWhpfX0SnfQGaXJl9p+4boA3SEfZrWw
	 xYWqioy1BH0D1dcgAdRieWuK25q2pQreoU5vtvoitbCYK4e4Jw0mVGZH8EY0dX0zF9
	 T3phvXrakTQ4yDVJqsBYuWUnNyBuFJBC0CEmDUv5dL9ADDKh8SrwKVZ99ljQ2hV9zE
	 28Q+RY+1285Z/+mnGPQ8/3vAWq25ffAlJF3vDldOOIlqQmgl7jgCSNQS/2CLGwtonZ
	 LsqudJyQ2H5qg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D7E5D2539619;
	Tue, 03 Nov 2026 00:07:17 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, James Calligeros <jcalligeros99@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20261025-tas2770-idle-fix-v2-1-6c8096a87f44@gmail.com>
References: <20261025-tas2770-idle-fix-v2-1-6c8096a87f44@gmail.com>
Subject: Re: [PATCH v2] ASoC: tas2770: Fix error detection in
 tas2770_set_dai_tdm_idle
Message-Id: <179364968992.2167617.17427338438659332154.b4-ty@b4>
Date: Mon, 02 Nov 2026 20:01:29 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ARZg3+Jk+gjKvlIs4yQIDjocmpJGxyHdgXFeZ0p0+GI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeqm513Trf16jXaHZHjFT0VBOJQKOPym/uOr284Xt6Z
 YyKzfo3HaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIQ29GhqfsT6OeX8q++8rP
 3vVg4+rL0vMCXnUe+W4+40CzX6Ligc8Mf7jWfDTp+Biw2Sv/ntz8vNUfVlvOmuXdwP/qY5u25sF
 nFvwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 25 Oct 2026 13:22:18 +1000, James Calligeros wrote:
> ASoC: tas2770: Fix error detection in tas2770_set_dai_tdm_idle

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: tas2770: Fix error detection in tas2770_set_dai_tdm_idle
      https://git.kernel.org/broonie/sound/c/f65f866dacbb

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

