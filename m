Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AF426EA8;
	Tue, 14 Jul 2026 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064278; cv=none; b=kAKjCFoidac1FeyHbmJL774IQ+pdFiqGr1EtAy+8UGf3c2BT7LrQ5ADYAyVWm/aUHIkcCgh3C6c/PXpsTR0WMRmRnJSbUAQKG/AwBfhrdrp+6s3A6dSeNd8WGCfHLKkQ9q6pRogjQnen/F8TIh+Qf9StYfkyEkh75DHj0PFFN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064278; c=relaxed/simple;
	bh=Zh49ItfkjMR5OV68dFco2V5vyH1fTNPdViDEVG1Erg0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GrKsw08YRGQLrAhfYDCW6OxddB2Oc6UmQ7HEa/yh7ZIE4WI65jsZ3PE2yMaIviZvJSZhEwpMH8yzBjQjbigkoKq1fc3SbOTyoUzomZ8hPW73lD/e9egzbQxHgP12EMzOBm1OsdMkjO89kyn80ioKe4inqifziKDTqPn0h6tOZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXc3N3wO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXc3N3wO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AA11F000E9;
	Tue, 14 Jul 2026 21:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064277;
	bh=9yrBidhowcLcYZLhMqPaZjXxwNQQl2yRRVBpP23H6lg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DXc3N3wOPk9OwRfqHvUT4umnjofMQXIIFdTIOdodfJU6KUzpiB2K7BswZiirzRWss
	 v3MC4goDcb770zrI2jTlgYpj83H89DZmXADebcSIWCFTOFZrv1ZFqN7rvk71GjtLCB
	 GWErs7RFroLurYQ399mArg2xdGWtWcwzyaaFgs8UC52icgClM8O+lF6oov3rL7oZwV
	 CBasW6NqVL60ISmo9ud6F6Ic7XiITtydAEElSwiqlshMy7vhrapeVQX670kUMfd9Bi
	 oVZMf+DYG8TpgTIZ2LldRHYr1tgbXS1bYwHDSkEJFSvRviTQusOsKuhGP3w5qbnTR9
	 cn8pocY13VA5A==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Pratyush Yadav <pratyush@kernel.org>, git@amd.com
In-Reply-To: <20260708045148.2993313-1-srikanth.boyapally@amd.com>
References: <20260708045148.2993313-1-srikanth.boyapally@amd.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix indirect write timeout when
 DMA read mode is enabled
Message-Id: <178403160898.7661.2328502058732415955.b4-ty@b4>
Date: Tue, 14 Jul 2026 13:20:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Zh49ItfkjMR5OV68dFco2V5vyH1fTNPdViDEVG1Erg0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqVqkSE1i2BA0BT5boSZfIj7g2sQ6+ifsZe/l4l
 jv3W5zOqfSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalapEgAKCRAk1otyXVSH
 0FdsB/4gc7ifi0U4gQQLmeOj6jWIxVXEjBACtptKdj64as31aQ4EHUDFDa9wbqWlAb71uNLrJ1e
 PnTlStUUMl5G+XQsJdYD2Y0EAEPsUTq/eDTFJIu/JohbFXz51tkAhCMDvP3UwJO/AZceHW75Hx0
 WdFSJP3zO2gPbky8bQYdtY6z1m3SfCr7QoiDwM+gIli919AoYBhPXuQnGKDAz0gMTFeZqBsK+7F
 lS8VQUYbPioH1lXR0FTuy3BuHSm7GBzOG7Em1sDkBmA9JRYc/qfz0YOY02XVwyNs9uopXj5qw2l
 jJ9RP0EA2MOPpHkn79MSr++WRZHBQvSSv5YydxrZC1gXA2uN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 08 Jul 2026 10:21:48 +0530, Srikanth Boyapally wrote:
> spi: cadence-quadspi: Fix indirect write timeout when DMA read mode is enabled

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: cadence-quadspi: Fix indirect write timeout when DMA read mode is enabled
      https://git.kernel.org/broonie/spi/c/e919ca35a6e8

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

