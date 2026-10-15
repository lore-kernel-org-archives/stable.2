Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD0342CBA;
	Fri, 16 Oct 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112332; cv=none; b=ljVciynUcdx1bm+L3hhX9zdqp+FXqI9b8S5f+O2GYvLv6TXwnMCwtkmqFZBkD5a8MTVEtFMy/FTpZtph5czOFtihv+0N+9yJxuIdl8rDe7DNL9lj8mlfMLcqDZt65S6xgdUEhXUDHYWKTcWC/NJadq5POTR0Lr0hDyJrc2tP+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112332; c=relaxed/simple;
	bh=ynwuheiIWANQC04BmAHXZkIRlH18J0WhcJhdUIM8KyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MvzYuMdAiIJ36OPiqvVhOmR02tD60H9pRIk+SOmS2ShEaZlHQ1DSC/fs44RAKe9lbkQnkg9N4DrY6oOj/1T2IlisrAnlD5PO+YDL35NkWAH/5oAY5aHF6xJNB0eXo47nVQMSxe2ms3rIMK2MBAa6hCTm0pcJ3aJ2ldDkLdk++LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlDp0hvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlDp0hvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDB81F000C6;
	Fri, 16 Oct 2026 00:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792112329;
	bh=2EU7hP5vGG3LUZhdD3CsdfYAGBkQxAC6HY5rWrqMzak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nlDp0hvmJepY02wyE9K2fj3OVRlxWeLLVlQAmMs5lyY9qsklQTrgHU9IvC2ncsaMh
	 KKS5apMxwaE+1CY7TY+EbRJOEUAlemkenZtZgQN2VeuyBaDu6xlhaR285t5GjtCxL9
	 Ceeukfp6uIwPdPwkBd96y/fuppmFqY8xRH8CCF8NhoQLDtL7VlGVoaLWcJy1j7d0wa
	 PrpJdRT97sgVbEKaj95lIJWIyFdv4rdtCaZfAuolqUZ1APUDqXFDh1cCh3TObTLY+s
	 2EPu72HUQfkiCkEas9kO3+4nPncu5tSBH0+CHpKh2cvpGbxTfEOsacI6N+iTJY2v0c
	 O7dM99c2Ejp8g==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Carlos Song <carlos.song@nxp.com>, 
 Richard Leitner <richard.leitner@linux.dev>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261015-fix-spi-imx-dma-v1-1-e28259671392@linux.dev>
References: <20261015-fix-spi-imx-dma-v1-1-e28259671392@linux.dev>
Subject: Re: [PATCH] spi: imx: fix slab corruption from undersized DMA
 bounce buffers
Message-Id: <179209959253.134795.9397557555007574163.b4-ty@b4>
Date: Thu, 15 Oct 2026 22:26:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ynwuheiIWANQC04BmAHXZkIRlH18J0WhcJhdUIM8KyI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIulh0VWj27PfmcyLPvr1tCLtmkhrz77TV/8oevD00s3
 27iPTphWkcpC4MYF4OsmCJLXBb3y/qS12v4Di5sg5nDygQyhIGLUwAmsuwfwx+OD7YPH+yQqfW8
 cqHM6aXDZaGYCoZE3T+r7k1PjzGLiY1n+Kc259ixNyIyl45cly1Xj1o2SeFcG4PIXsedE6Uk1ht
 +Xc4MAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 15 Oct 2026 22:58:00 +0200, Richard Leitner wrote:
> spi: imx: fix slab corruption from undersized DMA bounce buffers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: imx: fix slab corruption from undersized DMA bounce buffers
      https://git.kernel.org/broonie/spi/c/59eb22641f0c

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

