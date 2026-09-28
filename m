Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAB4963AC;
	Mon, 28 Sep 2026 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634062; cv=none; b=bSoefDnC+M6y54C/hPfyp9852n6BL79i289izo7urXPuuJ1zmVZ2qnDCR/dpBAq1kO1zpi7MZEnIEMU2Ur5iqW1WN+nDOslQudr40RRQqPhSveUNlGdIJuL8JCv5t7EmfPhcVwiaR1sjUFBW32beKiT4U3lMaHB6m321XwDUGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634062; c=relaxed/simple;
	bh=a7FrXxhQPMQAuv6iDAAZDyVzytS2J0lG9A91Y2NaZH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lqVpy3yLD8lBISMydMb94AkT+1INcjTONdg+nNsP68jZXp2/zi0A89cu9ScaAHW8vx1asPdeZWvdl9tRoek7a7gt5mPKGEMxyMud/wfcU6Ox3TOtgcm6JxSfn/SDq48gHjNUIq12gmu1mjcAxfmBvRWTsM6LSRDKWtX5sEm8MgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlQJFuZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlQJFuZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948FB1F000FF;
	Mon, 28 Sep 2026 22:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790634060;
	bh=N2ukRt7u37PXdnASZSDb3u99a4jgfFBtdSx//53lGZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QlQJFuZZWfCYkJ+rkSPhStacQAtPayY0AuRTEXdKHZKQQG45XJcYt8SiCnw7tK5xr
	 6AYyCV5dmefdeXfmvg7qABChpiaNCZgNS0YnfehR7FMAgS4oqRW3mBy6tGopfo3GWf
	 qSF1ousuAloL5pRpIz53wa9HTYU+h9DvO7peDqnwsH3YbNcL38APH6aVSs84SvN4mu
	 9oH+QTL3naN5Oj8DzxIpjC7IYTBbCVGFX6iG5Zf/mibQilbiSpq/QocXCBuhyL7JEu
	 kvozwTVZ0DuRCkD/oKV5KbRl001OjxDSzbFmgUUIWfUKcW9OfpThBnv0lUt1KB2s1+
	 J6r6wm+/QWEjg==
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Lucas Costa <2000.costalucas@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-spi@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260925193008.127314-1-2000.costalucas@gmail.com>
References: <20260925193008.127314-1-2000.costalucas@gmail.com>
Subject: Re: [PATCH v2] spi: bcm2835: fix device_node reference leak in
 bcm2835_spi_setup()
Message-Id: <179061518603.139547.16962778636816952777.b4-ty@b4>
Date: Mon, 28 Sep 2026 18:06:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a7FrXxhQPMQAuv6iDAAZDyVzytS2J0lG9A91Y2NaZH0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBquuhIYWG6ndBfp+OlehjuoDhwjsUU9LLllcNTT
 NExYikIodyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarroSAAKCRAk1otyXVSH
 0BgVB/9XXw1Q3FbKpo0WVt/Pgygdodbp9KfiZO2rH39IViEj90XIV/v8aJ0m0xwHNahKv6MRrjn
 1Al56hG8Tpwo7gZyYhTEoY2KDjy64K1DppOD9pjJMVGTdI7HvR+i3ZkPyT/PS991b1Yk5AhsbuL
 qD1hcGbVuxDTw3QGXsq86OR85J2zQOwvY7cmEOidh7yxEGesppsV3H0+IO2aDUMYsPFlZ7oaCyo
 Im0ygHKxyS4bVORrg5Rr3Yr9ZWeuYNRXztaPj0BJhskDm5rYuNVQcMwL+0NAMpxl9CaWTbal2LX
 i7R+A3kaQUoHDCMgmF0xZmJO/K1Ary06cq57k5dT47vxp+/3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 25 Sep 2026 16:30:08 -0300, Lucas Costa wrote:
> spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()
      https://git.kernel.org/broonie/spi/c/8db44cca03df

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

