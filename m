Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792830195;
	b=zv7qMFtPWfb3Xycak0jC3OP0iajR7YCvVPm8ZTxtzLDSgaYzTju7Rc6bAR1VkVPLKshh
	 XnHQPgqOvdT8UkYSWeRr9d17ug+OdZ7yZx0/8KoE8ty+6TIJG2kn/Lxsexem9G3PHoz0G
	 Cz2yw9VZFJo/BtybAb02KP/vQeVboFMnGwe7n9zfdeGopDV+yOOiE86Q09qh53zuG1+/g
	 0RrzC3fZFxu1IfQCM+DdVPgSQmHPsujI/2JEXBJ7+VkiEch6yQ2EkBydDxJ89cT3M/DS2
	 RvjFN05dJhyH9QZ0oBW2YaAVm1Hn5EVFlRKYuGnMJ8pdzkqFQxQua3TCvA+8oaG9IEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792830195;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=BxGg8AbZofUdpgG8WVyjDlIOqWA4Osv9johjSGR+F78=;
	b=GccBg6pRa9ZC7pEjv3KlArMDER/rE++uRGamQaHgnn0h1fG+2Ngu/JilwLA6/jHGDdog
	 F/aIc//mMgGH0yJcu7D87PWfHJomutI2DS8+MlOfQRPWy97MmzUvHUe+9sDfQpvLV+uPX
	 iTN0OebGXwXbQrcE3C5XfoFK4WDbGkkxalv2W9oKgatSvVhHfndnD6EZy3VZ1aiOAFw4c
	 /SDXez5En3uzlEHmoZdjj1HzfyOJql2QERg+fenJDHBH3M/1RaXpnmXaQcNsZ/TZBmevs
	 rZsUpMlOP/uB2rKsXo/Cl88XI6ZDJYyt9fMg2bhV10MOFsdq4Qx2c9re5pP0M8e8r/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8cVX4lv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29423606A31A;
	Sat, 24 Oct 2026 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8cVX4lv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7FF1F01825;
	Sat, 24 Oct 2026 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792830194;
	bh=BxGg8AbZofUdpgG8WVyjDlIOqWA4Osv9johjSGR+F78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n8cVX4lvx1NSBssH/4YXge7EsXSSU2aw+HnY+U19XYBXCgcKjgzOgyyd1ksdvcBnh
	 pYFLxMCVKO1ZG4N5VWsQnVBrKrNg/oxXBkxcXLuVab9J8cea5e4Q0IU3wCg6ecmG4z
	 vfh8lB33lvEFTlL33jIQATs8exqoPrIHrOPLHBBSM1QgtYZPQG4hI/Wq1UEfBssk3m
	 AOYt1cwZiPLnMNmMAlHUK/Fp/5CIBLo4p8txuRO0tAI99VPDDYocWkt1NL0aOr/fa1
	 3kAWVce5GdAin18SbOS/fL0VSNnpXCntk1E9chguutsimMFJNBz1xs+SQLCYdMAMK6
	 QiHIcjpgMnrNQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 9223F1E1FCBA;
	Sat, 24 Oct 2026 09:23:11 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>, 
 Pufan Jin <cyan2254650260@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261016130812.282624-1-cyan2254650260@gmail.com>
References: <20261016130812.282624-1-cyan2254650260@gmail.com>
Subject: Re: [PATCH] spi: zynq-qspi: fix address buffer corruption and
 support 4-byte address
Message-Id: <179277759175.3909521.4282064912069805866.b4-ty@b4>
Date: Fri, 23 Oct 2026 18:46:31 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LLAxb/9SE4njQjhCWgVEyFpwj+1TgmsHyia3ikY0bgU=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLuZL3nP1RR9CDy55zFt4+dXmcTmmBY1P9X0GU550KNO
 2olGY/aOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAnCTLzP8z/3480/jpuQl+8tS
 p5ecfzgjIObOi675Ktdvz7PY9e7ZuSRGhtWZqzfIs6rNcX1WzezYHZ19z37x3NcKIaHbLKtmCVX
 YcwAA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 16 Oct 2026 21:08:12 +0800, Pufan Jin wrote:
> spi: zynq-qspi: fix address buffer corruption and support 4-byte address

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: zynq-qspi: fix address buffer corruption and support 4-byte address
      https://git.kernel.org/broonie/spi/c/dc5ca34f5e8d

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

