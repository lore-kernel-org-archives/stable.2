Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072842642E;
	Mon, 20 Jul 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553613; cv=none; b=JcPq2QniRMhFDXdQI/Dwy/xdBJn1XOqV57f4PqJwuF/GiU47xYfT9hEt6QAFxcfQVInSV7Q8Uox3E0yXCJC3ceDGoCqHy+JKXBg53iTYnDHigRJrqfLO7UWAbwWrHx13+Ld2VB0aPjBdUNCYiK8GfUhIrdd7ED/jEYmpJZQlw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553613; c=relaxed/simple;
	bh=ZZGbl8VLcVUxPYMHHx9hIEhdJOf8nwWQOm9etWdl6Gc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fe2DLEyXhexR/nAsROphOWBLzcRgdrbfEkd00gq0paF2QEuPkkt9CzwpdHfOD9wZTx/4pTTMPwaky3omHZ1vC0uk3q6K6QZpUqoPSm9xeECbDQ5pigdkgI3vPxangaDMccvy7EygCRtGtxTQBUP7LBlbfB4xtlt/w9MmR5zsFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCLIFrWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCLIFrWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6FF1F000E9;
	Mon, 20 Jul 2026 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553611;
	bh=P9pTdlaEOPFbBuO5H5hUgd6MssJSxnbUnkFhHgXMa2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WCLIFrWWYM2i6ygnxNbig4XfjUtP1bLQRo7Dm5KpBcVUBnN8IsxlTYcfuMIFziWrz
	 H9oyvVW2jWmT3NqbL6tusAiTeE1V5v9q1DetVKSai056cOF59OjVWp7bluTQJ7LbIt
	 2UsQTknYOjBA9j61QGusH+ZixXJILx4H+dXdJcgbgYaiwvl2A0YaKsx36aGGgSw86f
	 trINVmhq7DSHioz8VtAFqWptGOijZRoX1ro/BSUlKX8rec0NynMzevnqtG2HxnU+3u
	 eZS+fp7J057etux2rUieWtfZR5w/i5e0CNKlblB9gmvqfugzo2z52lCzdWh0aFQfz3
	 qUcEmwpOlkr9g==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>, 
 Haidar Lee <haidar.lee@adlinktech.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260715-tas2562-dvc-fix-v1-0-072b13901b20@adlinktech.com>
References: <20260715-tas2562-dvc-fix-v1-0-072b13901b20@adlinktech.com>
Subject: Re: [PATCH 0/2] ASoC: tas2562: fix Digital Volume Control
Message-Id: <178449490619.33801.13781097046784774665.b4-ty@b4>
Date: Sun, 19 Jul 2026 22:01:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZZGbl8VLcVUxPYMHHx9hIEhdJOf8nwWQOm9etWdl6Gc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqXiCILC55z1U3/1r+O6UgOJ+UFnrrLvR0n58nn
 IiVMZfP/YWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCal4giAAKCRAk1otyXVSH
 0LnVB/9RYwnhlqFJDQhnE2PUMibuDtCualhSY4+OUXKHpHTUBQOaTHawXj1HwXBMWryxqPWhewy
 O/OlncS8VsSayd3Nol89ABUhSpEWzV3u3FLlmM97APDtyshvn1RLiqA4mfdxbS7kgF7RoRSxtHR
 ffLcTeSDiFRY2MV2CRfOA8I4QIFLRx+PI1OPtfITGMn9Rp/YB1lDTO4IsdxrBkgTeZAE3Y9zzOn
 c6pCxPe30Zg4N8A5XGiIeHVZxpi38EQmIqrcs8bX3JYMMhVcb8Pa9mbIoqLpEGDIXvvptIS8tww
 knVGyjUzzD4STw6FnneSQONiQHjGgnWN/JCGNzXhfGKqlJO/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 15 Jul 2026 14:04:39 +0800, Haidar Lee wrote:
> ASoC: tas2562: fix Digital Volume Control
> 
> The 'Digital Volume Control' added in v5.7 has never worked correctly:
> the driver writes the 32-bit DVC coefficient LSB first, but the device
> latches the whole coefficient on the write to the last byte (DVC_CFG4),
> so every volume change applies a mix of the previous coefficient's
> upper bytes and the new LSB. Depending on the sequence of values this
> mutes the output entirely or plays at full volume regardless of the
> requested level.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/2] ASoC: tas2562: fix DVC coefficient write order
      https://git.kernel.org/broonie/sound/c/8e957e4907c5
[2/2] ASoC: tas2562: fix broken entries in the volume lookup table
      https://git.kernel.org/broonie/sound/c/bdb0fd6de403

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

