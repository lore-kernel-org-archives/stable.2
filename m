Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3101E32D6;
	Fri, 16 Oct 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160585; cv=none; b=nBWBag4l02XoWL2FAWIFgRqb6HoPSeMMYG7EL0Bp0V/0swKdqc9Yi6H92/LBlPkh977kVK5WmCEjMmQqXkmoQpBUntsWCySPJDA9ifJ5OJUrFv7liz3VWgqTTROdk9a76Hcao9pZ8lA3DMSiwsKCQPF4rEgsGNUa2IFXUekoZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160585; c=relaxed/simple;
	bh=MI8w3JMby05eixNSvlAabSy8bwZ/Z9wHQHiE8BSaMO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sdiW1dkDEC7/vGSh7sNNBxIOsx/BwzyMNiALIWNzTycSv5wPkp7agtFn2VsOi525PeSyu/EHQ9fOVoR8C0MNVxEIHwqJydkoihCS6IhsF7ek1QlDu3xwHAu/avMzqy5HDXFGesLgnf7iuNEbX6aDYJGqFFkitLqTro9f4EL5N5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElHWCZVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElHWCZVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194571F000C4;
	Fri, 16 Oct 2026 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792160584;
	bh=aWRXMefw28eUVj+w8KBDJb0x2SzoK17sUyM30M4GBUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ElHWCZVBnzLBtvDRTLlzU1YYcYeabZPt6MvVikKzY72S5Y+cwpugGvtBXSoeKCZHF
	 Ti98ZCsMvshGBvqULHi+Ox08peAvw63Qr9MCfPrdGYynaDE+XdTKvlCYzOrDzykB9Z
	 yH+C3h6jORxrQ/qrwH9CFR5cECC7xoXb6YdemWrMaQH690WzWU3X4eMSnKS0qeYDue
	 eGZgt2eVRinQ9b8RFuEjiM1FajsNkTGrVnesM3jGjJGmxjcUT7SCjzkjmc7jtI8Eoq
	 8k7gg6OOmYDDg0M9hxXY4G9+okRGKshLKoTOwVayFL/6yBG9GThD5cITRNQ/CePAa7
	 5jIns0UOt3hgw==
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: thangaraj.s@microchip.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261016020036.1333548-1-liuwb@xiaopeng.com>
References: <20261016020036.1333548-1-liuwb@xiaopeng.com>
Subject: Re: [PATCH v2] spi: spi-pci1xxxx: quiesce DMA engines on transfer
 timeout
Message-Id: <179214977843.134795.8288039955291409864.b4-ty@b4>
Date: Fri, 16 Oct 2026 12:22:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MI8w3JMby05eixNSvlAabSy8bwZ/Z9wHQHiE8BSaMO8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuGbs69D41P7tj+n7Na9+0RTLCRSxmKTXcu3jaNfbx1
 DV7vk227ShlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBEeCIZ/gqJ2F0U1egIOrbv
 tdMkZZ39dkGda7XO/vl6wepX/uxzOVwMfwXaJtumrl82QS8lm2NLT6WsQ/eCih07Fbdffd6re/L
 oAR4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 16 Oct 2026 10:00:36 +0800, Weibin Liu wrote:
> spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout
      https://git.kernel.org/broonie/spi/c/0b591332a2bd

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

