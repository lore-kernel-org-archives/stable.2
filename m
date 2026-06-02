Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374939B4BF;
	Wed,  3 Jun 2026 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470279; cv=none; b=LatpEj5CEkdqumlVuJziGAm7R1VT67In7qAk7wye0PtRENMT9i139VHk1bZMBaQ0sRGRQv4Vtw404PRwFJus7oHIbtGZqNAicweQxMy9RL1HWEnZfIhglCBZ0h3XHar0+ajTbpo6drHdWn+gvc7ZapMzdVyKBHr/2q10Ipwu7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470279; c=relaxed/simple;
	bh=eJuv17eLJZHSwOzwJZ0aqFGo6sAVK3Q/bWt1bbGlGf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PUaxE3xeFVhRs1s9gjWiZ3exI3AHpr9tlL1o43ZHGNjUa2IwEloTfj0cqhsDCbQ32PpI7IdAU9+0sH1JGvvfdhVbjTiXWi3IspHKuz4XCWlck3tZXVaXVVVoR/jfSepy7zfvzWx/fCGmvyELxDywZTObTWJW6kvROEWY1I/cz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfsjrNxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfsjrNxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1531F00893;
	Wed,  3 Jun 2026 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470278;
	bh=6SqQTJLSLTc5ORTNNPdbBL07+KG62ToCTtBK3V8opPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KfsjrNxcj1VMh69TZyNr766N2a5OtRF6gK+uhKgkAA78blDHXhFvob1gZ0pbhc7ZJ
	 psYMknlzRESOe8XHedppTqp/TwH0NQvYqX1C0IcjKKpzVg2P4tXc5wc6IHXCpHCxZW
	 ztvqsjJnkQcOTY6t9TdYanP+c6A+QMvBiwI/CCE45UibN5oD+Rkf1H4oRvCvW2OJdU
	 BxrEjOc8MeBktTm6SsPWOTbMZECll/C876od0b8jC4ng2kcKEQ3qM/PNkhsxCa3EpV
	 AnsSltcAE7PGUAJLOUAXS/0YALi4qaGQOHzqtaaKDV/wZR0U2uPbPKjgx1DWYaWG37
	 YmDSnAYQj/rmw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Shunli Wang <shunli.wang@mediatek.com>, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
References: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: mediatek: mt8183: Fix probe resource cleanup
Message-Id: <178041307167.93058.8280968694103073134.b4-ty@b4>
Date: Tue, 02 Jun 2026 16:11:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eJuv17eLJZHSwOzwJZ0aqFGo6sAVK3Q/bWt1bbGlGf8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqH9IClZGO7bSnhuRJdTwfqiPVGBv1f7+UdJSuL
 6seECFgrcSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCah/SAgAKCRAk1otyXVSH
 0H2YCACBk8TC/Qq4VLNuBxjSwYqK8FPlGzzfq0uknvbQ+NhJuuocnTfTUXEDtPWJFSwPd+dwiCS
 DRVhecgclYTY6DhRFWPxVNp8qsKnQw9lF2oDJJtofi7CYc6tLNFy5jT0XmJv4ecjUPY8e+/STPq
 0hOXBUyYu4VvPPTPd/fQa/hX/AnRoAYNBpd+qW4st1Yceyml9yy/uuJ4Tm5BimdrVZJWwdcopR5
 X0q/2AoCJiqdEGLWBQAk//E43MzyCG49UBbkQLK2ZzFmrMmIQ1S5TVLrS4cFJBQHY9E02Q5yYri
 QGPRON907c1QK9wxAtJ8K3aQB6vkX9lpBVKED1pCwa6Z0ft4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 27 May 2026 10:41:47 -0300, Cássio Gabriel wrote:
> ASoC: mediatek: mt8183: Fix probe resource cleanup
> 
> The MT8183 AFE probe has two cleanup gaps that match issues
> recently fixed in newer MediaTek AFE drivers.
> 
> First, reserved memory assigned with of_reserved_mem_device_init()
> is never released on driver removal or later probe failures.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/2] ASoC: mediatek: mt8183: Release reserved memory on cleanup
      https://git.kernel.org/broonie/sound/c/bee65e00c092
[2/2] ASoC: mediatek: mt8183: Check runtime resume during probe
      https://git.kernel.org/broonie/sound/c/f0334fbfd107

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

