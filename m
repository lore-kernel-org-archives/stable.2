Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734826ED3C;
	Tue,  6 Oct 2026 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274355; cv=none; b=nVVnJbwMGWlUj6CKIiBGDnUThMA6e37HgJPLpqdO2iCB8th7lXKgLIoJLAqaU2F3k4cjBwM1ySXO++YaLHmwBux5lfG0AwROyghi5rK2lM4znTk6QMKoBCGTYCGl1Y1fvpp4pKThPIwUCTgURStmPu5Bjtt8noBFZfIpJVHTem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274355; c=relaxed/simple;
	bh=zm+OpLLELwb7hrM2/g1QIO+IVAqsCSLrDqO6ci09Vvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eGK+zDuzSnABmD9fP9+n7DJaZVMXGueukibd7DbXXS2bfJ5yAKZsZkBdXSxEC6MtQwRAX2aSJBm6vUorXVHxXyCAX5AGIChPl6n3boIa0tpzqxAAMjkoQu825fQ0RbkKTV8N9kAHDPj19C9Pd/t/DQBhuUPK9VjXYnl+2vYyt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KczcJp2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KczcJp2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16611F000FF;
	Tue,  6 Oct 2026 08:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274348;
	bh=7h9+yYx9vCpmotG9nojbUu5IAfempJl5vCqPgtuwvFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KczcJp2NxsC52UaYoca9TicJzMgEWYYjA2x8RRf/B+/Nqqff/wA3UI82zsn0N9NII
	 WF1bJncM83HmEYUBu+6k3GYheW9rWQuc1v0nXYBSJZMEP8+voIe1vVh6qT4y0pkYeX
	 oFzll+FG/JZGUuMcE2x1+YYIk/B+HD3Th2ETUzv34sQwFXzG24ntRUbtqTjC5DaRRC
	 dTT9F7WgbdPP6V39SaGwlDDa9QQeUNpXdBCG8U25Oz1xt+zNi/KcLQmSwovWdoD6Fb
	 2TvOk6M98iCjBwDxop4Gt6W8VhLAQNZPxLtMix98IEYS28U41OqvDYEsyNg/CdI0gd
	 xl9Jp6LP5R+nQ==
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261004043451.1138613-1-mhun512@gmail.com>
References: <20261004043451.1138613-1-mhun512@gmail.com>
Subject: Re: [PATCH] ASoC: stm: stm32_i2s: request IRQ after regmap
 initialization
Message-Id: <179120716531.150114.2078241476703327218.b4-ty@b4>
Date: Mon, 05 Oct 2026 15:32:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zm+OpLLELwb7hrM2/g1QIO+IVAqsCSLrDqO6ci09Vvs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqxK1mb4SogEOteBhnmY/5JBgFwx62J4mRMdXey
 mz9uw+UdYKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasStZgAKCRAk1otyXVSH
 0MUMB/4jH6NwA/h9kOpUpsDoQh+ZlGcm/CH16zFLgmwQooPdrGJSG19NkGw3V6oe6cCaVL+LrAS
 zPmWdqJZh/7SIbRMG9th7EALTxaOu9PMir6NIlvslMG9WLvL68GpRfvkjoM79wIwE+Ke296StJP
 BJ7QiuV/wv2fqE97AuVnJY2jpYk+H7lrJTlVfgyjnc9m1D6DxCtAncnIER08k2c83QeKOugMY11
 sxy/jZZw15HTKi7NCcKqRalzvwf5Ljop+kCKUtHtI9cJcoRwYPsUR3oKgwmxmqKuaNG6VANycEO
 JPUISc/t+z/VMpSj5dMyUgavq9K0CMr3Bt52zS58Qm88Dc7J
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 04 Oct 2026 00:34:51 -0400, Myeonghun Pak wrote:
> ASoC: stm: stm32_i2s: request IRQ after regmap initialization

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: stm: stm32_i2s: request IRQ after regmap initialization
      https://git.kernel.org/broonie/sound/c/1b207c85551f

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

