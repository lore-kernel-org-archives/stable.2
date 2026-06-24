Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688D37C0FC;
	Mon, 29 Jun 2026 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735247; cv=none; b=Av2v7VOJ/LTjmSH2OGHh0yoR2kbeVashUBUFeh5vsw3cJ2ADmg3h+E3qGA01Mws6c8ZSSad3lxckHrn0+b42erD7EQ2i3rg7uBfw08e5APqGEELEJtl2cJil4YqY6cKzSQRkKCfcOMyyeteV+lQ1DGMqpnuph/e3ThK8H2lhcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735247; c=relaxed/simple;
	bh=I8SxFiR4w7yQ2Mzp5iIXtB1nJWVUCK0u8oqOK9del00=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jDa4a7QOI763h1R8POO2vMPSHKbl2s3ktLBe02h6LT5dtm75m2vWtaSvFGhPSt6Xms4M8cm+vVGT7lzp1mTrUsWl7f8+cVUwN4ecv7cT6BMdESUVTHSxSZHRHtEs5S2HOUko02Jl0qQeSvhPv338jIQAttE1D9nDSN9ulr9IP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIOJGuAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIOJGuAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034CD1F000E9;
	Mon, 29 Jun 2026 12:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782735246;
	bh=nrRq/rqP6CPHqJ5bPla9J1CX1DPLvJIFTJzunN36uJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bIOJGuAkRUeEsVyXg2f4w6mVqSoSoGesHWg/LiHk1eKwRDY89MEN0tl0S4VO1WPXy
	 2Sqd1qdNgX35zyEUdU5bTL4UPaDxzlgDZ3ek654UY/c5LO38Tsw0tuTZEvTKyDXq6L
	 BjknxvL2Qg9GjjiXkSKFFdYBQgNU4p7hfawjXKgvtiDKy/M/c4E+j+60uyUbxJVc6M
	 JwMfNX7yRv71qNizXLd1i5SSXn1Pp2a0htEwDJOSQzgiMq5qDwt1V4h6Lljw6ywzWD
	 zV9PJCikwOT1EDedQaCR+SuuFCG1az0nrI1bgueqMks/dtJsMTMfUmQfnRsW0OK7SE
	 owmwQPzsqjNgQ==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Carlos Song <carlos.song@nxp.com>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
Cc: stable@vger.kernel.org
In-Reply-To: <20260624151958.18626-1-javier.pastrana@linutronix.de>
References: <20260624151958.18626-1-javier.pastrana@linutronix.de>
Subject: Re: [PATCH v2] spi: imx: reconfigure for PIO when DMA cannot be
 started
Message-Id: <178231999027.43395.1514985035115232415.b4-ty@b4>
Date: Wed, 24 Jun 2026 17:53:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I8SxFiR4w7yQ2Mzp5iIXtB1nJWVUCK0u8oqOK9del00=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQmGLTSMvPD+Qz2hu2SvAp+EQjs8+4wlCDYYXX
 1Pz9qVf13CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakJhiwAKCRAk1otyXVSH
 0KSeB/92Zvp4edp2JAXF83YCsb7VKwwI8k9+1fxKerRxav/oc0lreCiVnEvWOxEY0a88/8aAKHw
 L0mOKSavZWuZzlat6yzPzrn8pskTjGQ20NqU7dKPR0RbOgjmhKfBkX+MCoHFzQOKUveZZL/W/Jb
 JUHlAN77K3hZHFLf04upFHGqu4m45Tg+TNpMWZdtPTZgFaqjLUPvGzTh8KR8P/Pa47jortjrABh
 VvDU4dMjH8hkcHoRhrLDhv/yzGqMXi8Jbzz57gcI+jaZ8z9ISAhXc4TVPck7A40WO4u9xsCX61t
 Ajxl6jN96Rfx2MCV/gdet1mnhwsbtYwAYJJiDTDlA1Fm+aZK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 24 Jun 2026 17:19:58 +0200, Javier Fernandez Pastrana wrote:
> spi: imx: reconfigure for PIO when DMA cannot be started

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: imx: reconfigure for PIO when DMA cannot be started
      https://git.kernel.org/broonie/spi/c/245404c26563

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

