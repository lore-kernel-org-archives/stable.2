Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743020;
	b=akPDGCKjPv4vgGLpsJMTb0c84ekWYWvBs1moe1tJFV7fAOrMYL3UcQgaD0sFvtMgGdvc
	 2OHickpbs8sLnU4m6NH6HAfhHdoQPj56Mq06FwgGX/PL3zSWt+Cbxm2LBA89MIJWtXxkQ
	 ZcOUeJmuy+CEvr+Wpg/pP4mU1XI6lRS8iOTdevl2uDI/OT1CU1swOFaaboNX4qH7JYDRl
	 ex49RPbJETujxHt23eBmm/KX1+0nsYzzptJ9Y9HcmPm6nUKvNi3bDeK3OpZY/cUM6+sUG
	 2VwZGVvfgy2U4exVaq2nF0SK82rJurPCR6RnCRmds953do58Ur0AjXnWJbbwjx6kjMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743020;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=HORPT2+OKhUQX/c+w9CEyiHuwbVnQXzU8FvgGpEczmg=;
	b=a2gSNiDDDhu7IqxSViqdSN5bMdp7fYY8sxfXy7R3VNsr9pB/y31kLF2BLfHZgUuGneuN
	 b7+j40RKZumeLk0jGtgB+s6aLTxxM+s4FynzJbHAxdUfbKGR40PAZkbjdOFf7GOgcsk97
	 9hXlil6C9dkKZsPQGfGAP0V1TvnMWNW3uEwib2xKIMFvX+qi5wr95lvEqVzZ9PpeITBm5
	 K4WExkb7QDTRCn9o9rVaw+h+g5tQVn1L2UdrpZXocNkGPCoTZf7+BOJUXxRpRS0D0YZME
	 nmwPtBIIBKc+BoRiW5aiVhPUNyL6v/1LLGvqneEV6OO2K6q5bxw+GmgOgso2oZqKfOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhRTarOg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B7606A32F;
	Sun, 15 Nov 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhRTarOg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CB91F000C6;
	Sun, 15 Nov 2026 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794743019;
	bh=HORPT2+OKhUQX/c+w9CEyiHuwbVnQXzU8FvgGpEczmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hhRTarOgvtkcvoHQCponhnC43YrzXZb9k8hBYH9WUgbOguss8fkqRRwLtcwPgUMz8
	 qmxre8bRPxJvw7QKepZd9G7XAxDHhb5fIi1FtsJIKy+epPBjwlUrFUM2xEoP1n82xH
	 9fjoujxjm7VeBE9HZ7x86JRqj/+48Dv1tpfOTnLNv0t5RSop+P8JLm9YpXETQqEiZY
	 l/ypqv9PXA+WOkC/ax2ry01IlWmQKrYyzLx+O4ohBPiCnQcSS8kCp+2PTNc41uJ/np
	 YcLyvA/QTkcJTR+BWQKwjRbDRgtj6F19cYcnvkGx22qKS8IRf+BgOF3NXZqog+EqkJ
	 WIDf15WrJdW+g==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D87813366C0C;
	Sun, 15 Nov 2026 11:43:37 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, Tristan Madani <tristmd@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Tristan Madani <tristan@talencesecurity.com>
In-Reply-To: <20261111114919.95639-1-tristmd@gmail.com>
References: <20261111114919.95639-1-tristmd@gmail.com>
Subject: Re: [PATCH] ASoC: rt5668: initialize calibrate_mutex before first
 use
Message-Id: <179460731193.448985.18161081326814436601.b4-ty@b4>
Date: Fri, 13 Nov 2026 22:01:51 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kfDqLVqtfwV5YnDdru5bhXRI8M2REBjYV5be8X44nAk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+znp5lO8vR2zDkU/9G9m4FNWVfP58+/NxT18ye+BD3
 c2zJ51r7ChlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBEXl1n+O99X2DX6yfWmz/L
 LUnW101Z+lpMn3tK/+TLz6dp/3VSNNnM8D/htEW0VWFbm93srXaGE6coq/RsyfbWXcM+PWQaa/v
 y7RwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 11 Nov 2026 11:49:19 +0000, Tristan Madani wrote:
> ASoC: rt5668: initialize calibrate_mutex before first use

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: rt5668: initialize calibrate_mutex before first use
      https://git.kernel.org/broonie/sound/c/00e80a5f6dcd

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

