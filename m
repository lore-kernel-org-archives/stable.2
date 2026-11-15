Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785246;
	b=MEiZV4Hgb1Z3i+KT25Wt/ayH8nyIySfmcVCgg5IJiWT1drVJLF+1mNq0eKbp5Id0Ukli
	 euoGkQjJtgO0M1gw70LNcVVLueozwOPCZWXLsAWqArMlO7lG6eCxwiV1Cjziv/r1IQ121
	 +lV9XC+wCW2IDwtPC2br5Tg7VNvrivDqCPlTpzF+uMRrwAZK6rFY3HcChk5d5diUb/Wjn
	 OBSxDKwnuFHrvc0c+l4u+rcfCGgCQ5+nZb6MyCsYANjgj23XKo1GB5OTh5JblADSTuEG3
	 b81d1NrxFuxPAcEZazD220GSr5RvM9joOt+sU7iCX/1o7zEnuijlnwdIoK2RMpr3bKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785246;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=cIfzgv3qu6yiC39fCkm4e84KuPvX4hk/OB4bftLSTYo=;
	b=GsAAw9Emj5P/6JdGBmyeQSHQ1uzfgXQbDxNvony8K6fqzpIKkZAy4iwwjS263E76DWKt
	 ZpDi0N3Hja0y8pHg3B2MLqsv980eGv62dzVIcPcBvr3Ku/Al8D4M8PKhZvYDTrbQnM382
	 nLkySGEG6bX+ThK3YlKyl/XoXHJO4R7Wxcu7pQmiAkbpDVsh21gK294MnUPLrm/xI9cjd
	 AgFHWidnIK0X7AiA3h79ByzNSmbi7Iqni/1SwQmGuQHjW9tyT5wWHP7hBb7A0yPVsqwbb
	 5nyg/+KATd/LOjDgqZ2a0hbPPkaixMT1QxQvXirnZ5WCUrx/YHm5P/Pri/BTUdPH3Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj8MZ9Ai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD50606A334;
	Sun, 15 Nov 2026 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj8MZ9Ai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809291F000C4;
	Sun, 15 Nov 2026 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785246;
	bh=cIfzgv3qu6yiC39fCkm4e84KuPvX4hk/OB4bftLSTYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Tj8MZ9AisVgw23GvZTy8kfJAIVljSioV2c9AEIyfYmz+LEqzzin978LRIQYN1TM1w
	 xOoGxmw7itwSeXXflZUeYaRACoqUNSJ7INT2qv3A2EJ6wUC4a82Pi8JQ0iQ6v789kz
	 KNVnMKH+EzTc10z/lWVnR8GMyxZB+UfiX+wBSqOMLGrSH1Qab/XqZDXapyrW26Qkmo
	 QlyYGnvyMnGAj8097Xlgb6Yr1L2m2mib3dCu/SXImCU5d5ego9+Cqx0mlbMc7ZNOCM
	 OLfotQbFIv4Tu4x1ef5MlPzumz1BtZmKGdHbadEPxjCTuhXrtnJ9TEk/ZBWpovhKAa
	 igC3a3Nnt1yWQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D97613438EEB;
	Sun, 15 Nov 2026 23:27:24 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261110043013.56937-1-mhun512@gmail.com>
References: <20261110043013.56937-1-mhun512@gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: disable jack detection works on shutdown
Message-Id: <179476728283.140154.14405729138456445681.b4-ty@b4>
Date: Sun, 15 Nov 2026 18:28:02 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HF+jy0ZS6sDiGK3srGFu8ugezhonIivYkip1HGfkOqg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+2d+Z2D85L39DV4JCRuiP40V8T479dDT7UL52ybQ/u
 7WlGlSXd5SyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAilqmMDAcvLhc1710QYPva
 qClxseO95NR9OnpZnySnTuzfrSFj8ZGR4YBtJd/eVZEJs1/IRiws9V/TL7Y5g10kXrlqtd3VzXF
 lrAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 09 Nov 2026 23:30:13 -0500, Myeonghun Pak wrote:
> ASoC: rt5682: disable jack detection works on shutdown

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: rt5682: disable jack detection works on shutdown
      https://git.kernel.org/broonie/sound/c/b45849311e88

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

