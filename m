Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEE52BE29;
	Fri, 18 Sep 2026 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765486; cv=none; b=VdOhYHAdLiXEXFCtCgrV6rxyWlcQiIUu60mVYaXXNGnUD+cgmUwlA9JSIrwVrx0Bk/UDvUSNIBtADMqiuekxaL9weBkfVxnDiAhW5ulcC3imzbyNKLb5HiBwE/R1SKqdUpZmmJNJpyJWGUcjTlhw456Bo7oLOxrOyaBASJZO7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765486; c=relaxed/simple;
	bh=ckePIfgoka0Rf4mwt80S3uV3xBUMBRQgF7iWoRQakm8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cSfvNF+hlfUg4zmsfC36N+zrsSyhhNN8iRhdItg10ydrr+QTSMyz96AUdNRQdPdDc91dHm8qvgHC0BC1Ta+RmyOjHB3piDFoIfXfbhku2yHHifcTaFaOkzaJ2rpyV/ZsE6NwbZAPfuhGGNJGu7QDTq8iQwLzsyaftYqcsX/+G2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnCWyOlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnCWyOlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84501F000FF;
	Fri, 18 Sep 2026 21:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765485;
	bh=fsss2wB7f+lxa1B6M3RPy+oqjwmiHVsAVHF6YEIzzQE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GnCWyOlD2Q1/FdbnjDaIWSVnLqmLOl4BDMV9zaC0UnRAuYHgZUB6QZ9ZQWMhKAv0f
	 rFH1lze6gvxJzHVgaalZNUcnHoIdLGiZf8UtbS0NBdFbqdp7fHqrh8iIokPBbR88Bl
	 m2RQpYVBxyHk5hW9fv71kfXkyGunYeqIWJz6H/s5oZtUaoqcYEwVg7B61a9L6CQYYg
	 Sk7rjLywyEhtG8jFpgZAI01j8QzH6aqml9p3Fd3SA0BX/OTWVo1qYNRPHS9mllEnO1
	 QGu4J2yvsgH3DkkVN8UAXyOoFaa6QesOxEqS84Qx9DTdASwmKM2nga12rC740kVnQx
	 VFmNo0lxrKjJQ==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ckeepax@opensource.cirrus.com, krzk@kernel.org, lgirdwood@gmail.com, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, perex@perex.cz, s.nawrocki@samsung.com, 
 tiwai@suse.com, stable@vger.kernel.org
In-Reply-To: <20260917165130.2163278-1-vulab@iscas.ac.cn>
References: <20260917165130.2163278-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: codecs: wm8994: Fix runtime PM leak in
 wm8994_mic_detect()
Message-Id: <178975136505.1812520.14638556027707618597.b4-ty@b4>
Date: Fri, 18 Sep 2026 18:09:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ckePIfgoka0Rf4mwt80S3uV3xBUMBRQgF7iWoRQakm8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqradomm2SSXxOvZt8Nrd972H9J6IEjXpewRVgO
 3vRNvSDowiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq2naAAKCRAk1otyXVSH
 0J3SB/99D6YBfuifpYnuHkLLg0mWAX/4un8CBXR+lx8jwjws0o9yuTZuftSNyTN2+Zaj07Ztgtd
 /FEvgs50MB8MT9WY7kZ5xBoGyQmBwtFnv5wX8jA/CwwFWh7WaspSQXr/4UC5AwXyhKqdEyioH/6
 Rcv6tBjkTuS8hiRo3k2L1OaLCztzvVkuNStp9A7iIS/aPCp6Yqprxl5JdoDnk2qqf4NWJVbEGKI
 181Zway1XcfjdRVM/5YRbmjLWLIIMxFnMQ50pGDZIZpQxxm6XpmhV6kiHAaq9yBpZ/vVHpoPQKX
 BuVQM9iwPsC2BbUYuEzvLR4UjWlO7xJZHnujwX5HBVOQdYiX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 16:51:30 +0000, Wentao Liang wrote:
> ASoC: codecs: wm8994: Fix runtime PM leak in wm8994_mic_detect()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: codecs: wm8994: Fix runtime PM leak in wm8994_mic_detect()
      https://git.kernel.org/broonie/sound/c/b2c0e5bf750e

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

