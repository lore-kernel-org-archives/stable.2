Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0D40EB99;
	Sat,  8 Aug 2026 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193385; cv=none; b=C0BByBp14fa9vrGIa5TNEPm6nJARnEoCgaU++i8UY70J8see1ocxKsOOe1Se+/7YoMrh5qiRm4g6ByLxpWc1ZttA3tPlfZNtLPWlVOBuqzcPrt0QepdDflRygJOdhJsT/CFl4wnwzhRS3LcFTQ/vHXizc+g/+pjPklBh2aa8RQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193385; c=relaxed/simple;
	bh=qeTWMWw2g3YZZ0st70VOM+mekoOWH27qMJztAQwxShc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AmbHQjzXVSdsIyOFpJzR9doZ7VwjRO0iUmLCGY6KhRn0DSoNlABx3UuR2WLnpwNEMKCNH7Zn33SrZObapMp7rICSB0IwimavQ8dLd7IV5qpXiuJONgUb8eAmJUkYwXyQrI4ezHFeU3rdZkb776gaRbd6tGGzz8xCzBN8KSTtgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orU1Mdff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orU1Mdff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873E31F00A3A;
	Sat,  8 Aug 2026 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786193373;
	bh=n1dARTm6Q8y2aeGOIPi6cU6W+ciUUAyxNJBhrKNOZ7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=orU1Mdffsu3SMJBDI6kmWYk0gPFNzG4qyvouL5fVJuforMLk/Yha4PvMUjt+hfQDd
	 pj3w8ww/sE6E0BtAsweSPorKxBHgFZrvDn3GUAPKKE/zvZvwobBd02nJoQkpIeI4bD
	 HlIkCzNMsz+5AvXqMTb3bcvCAHQ4YhV8cq9FgcmXueV8+912RNDaX81+HMu26acxVb
	 Yeg/fmW0yFc6EbI0ncqIbVIk2S2pM3j6JAjzV6FyYYbZjgkoyGfqQGprqA7vjjhjKS
	 LcxR5KYJrmMhF2ghpry+0YhmYpln+lxNIg8t5RgN5znzVfdlMyeK4ytwwyyYr5qLfY
	 oFGObE+77vSSw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Niranjan H Y <niranjan.hy@ti.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805091327.23944-1-peter.ujfalusi@linux.intel.com>
References: <20260805091327.23944-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: tas2783-sdw: drop duplicate reg_default
 entry
Message-Id: <178611423751.279158.8362298506207761232.b4-ty@b4>
Date: Fri, 07 Aug 2026 15:50:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Wed, 05 Aug 2026 12:13:26 +0300, Peter Ujfalusi wrote:
> ASoC: tas2783-sdw: drop duplicate reg_default entry

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/2] ASoC: tas2783-sdw: drop duplicate reg_default entry
      https://git.kernel.org/broonie/sound/c/ceba07ca24fa
[2/2] ASoC: tas2783-sdw: sort the register default table
      https://git.kernel.org/broonie/sound/c/b45fc97ebcfb

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

