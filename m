Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442354EDCD2;
	Thu, 17 Sep 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676346; cv=none; b=TDx4vYi2+QyPxd1lq07SKc+lknwkHsjXx2U85y2H2soIsKQNc2Vazn03qOXSYw7rpqi9qyDkyzj2hPI/ztR6ggJD2UQTifltF8he/SAhEddIFAOOs8pd3hXf40Nkrqx8Hnu78ev20YTRCM4vUBtzzvbAaVI1t53cD6gAdJKIGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676346; c=relaxed/simple;
	bh=1jD9l88UysJOW4QXtC9rJ7BTDu3h+25PTPjbHKaOD5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UFSNUwV5RVjlaBpS2Sqq003qXUB0QGNrkwppqerb7Q/HMraxNu5W0tkDxO8ZqM3laPPZTEan4UD+leUMtExGkA5azeME6mu1wCWkyLyKlq47k4VCTsteJaWMF/5jDWDQ/tlivtZDF3MyEz/3Iz0WDsEaze+3eh02j7sl5QWj3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB54TKf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB54TKf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F6B1F000FF;
	Thu, 17 Sep 2026 20:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789676344;
	bh=IKXo5yabTUWdhBjpPbiBNR1U6f4LrOuF0hESsdk9420=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cB54TKf6WHRUIdMnPiTi/biotMG39LWDwVYubNRGRTYjy3O9qM/vIVqwPiLUbFP4C
	 hq73aU0F0wcyATXkFNirOd04SgKh8eHL5M/l54ZATzwkHggk+djlK6V/gf57PDajII
	 AxPjGgi3PD0O+EBySCYncbrimfGZjXs3pffgpPhCSqNdWcgMsWkYNxnHlsXBtxM3Yw
	 nEWA5nUg019ipYHQ7IyHOK2RUesEgSgJwHPC+MXwJWdad9RH/AtdETmjGeD0nT+e4X
	 1h8Izxd78WNYy/MeNuov2SwpTfjGQmLcScCC3kBOy3NXTmb00UOPVo8ozaXcaQnIxs
	 xVD9fkG+ZUPQg==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Frieder Schrempf <frieder@fris.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, stable@vger.kernel.org
In-Reply-To: <20260917-fsl-qspi-freq-op-fix-v1-1-5fbe6b02f738@kontron.de>
References: <20260917-fsl-qspi-freq-op-fix-v1-1-5fbe6b02f738@kontron.de>
Subject: Re: [PATCH] spi: fsl-qspi: Reprogram the clock rate when the
 operation frequency changes
Message-Id: <178967118348.285745.5749858167489960674.b4-ty@b4>
Date: Thu, 17 Sep 2026 19:53:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1jD9l88UysJOW4QXtC9rJ7BTDu3h+25PTPjbHKaOD5U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrEs0rKueolVC/E8/0BKAmXXRPhCgzcjkjYpU7
 6C6abxQqyaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqxLNAAKCRAk1otyXVSH
 0LdRB/9RkRnqXku/IcRxJKxmrhN6Ygpzlg3+iQDVokZLquHU9yYT6RtHaVx8A4nqasMpG+IZIIu
 u8P9P7Bbabim0msIZyq9lQb40etlU0cdh9mxcL4DRoN69zfgrumjNgnf3ExK1j2m77NrzBvOTod
 DWx4CySHMK9Dhqb845FMnxfaXjEnGxNiz0IpqqDDBgTo9bvjdnffokz+HH8FtXmO1HPvN7mu+gc
 x5nHOIYtSTgNx8MWX7H7WUUVW16LSpzblmZsH1LvfaQHjkjuZE2PoeaZhABP4KHZ26rAn+E7dDd
 Y+dM54t6aEbHbXkOjt996C1eu4TXhcTO+Jx02/7BU7xnaPr6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 16:10:15 +0200, Frieder Schrempf wrote:
> spi: fsl-qspi: Reprogram the clock rate when the operation frequency changes

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: fsl-qspi: Reprogram the clock rate when the operation frequency changes
      https://git.kernel.org/broonie/spi/c/3d743adf090c

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

