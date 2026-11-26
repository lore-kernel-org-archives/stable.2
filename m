Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723085;
	b=MsUGIe490UInM4scayom/iJPwFMXAxfRQrx6C8Gkz58K9VWZdGAxng1UR4fWIkOXj+SI
	 +t484SZL3fEsfSgc++vLFJHA52sbTjB5dyHJArVgx1WCuAbH1W+gTkpKT92z0YbAVtMns
	 KbXezADaErf4b8ycBRWwEbz35R/KNvEPCt3FPy0lOB+Mf6m01xEx2ufONIQZjn/AEIsqW
	 qDPQT0AIH+t3Tor/7WqFd31EmMNg0l+rriBpi/deRpz4Ap18TX21pZPFOEz2Ro9DDVN7J
	 7BQlPujQLz6/A9Jo1mNkpCwtAuxYOSaNmCq1EbNobZQ4oABGK7TrSVSx/SkJMOiI9ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723085;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XfmQtKu5Trt3TmyRt9+W4Depfu0cIn9OSpKxY/sot9M=;
	b=T1xCOCutfP49MvweAjOfcYgHY2tUEJSwEVtZFgedZqLxKuS9T7f5d7wJBnZgCBJgI0LV
	 ucnR73Jl+SLmUX0BoYjS2TbhSUirUgsmwbLt2bwhKDoVfzue2U26h4dXCaL+PZIAiFJBO
	 CNiL//OLupTifdE1UUnabJfVniP66GRm8VfT0kavd3kAsmjPADxsGx4XW70kYSYXOc7Ju
	 4DGM6xmBpu0HzDJ5fgvGlEZaxmkWm83p0JCTAnY20yncVw3KYZYjr9uEF4iJLpkg13kBW
	 2ejmMjfli8tfm4VNjN7RGLKFM9W7SjXkYQyddVTr3oJnR6Jg5Go8csP/HHmHVv885XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXTpm38z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3648606A31C;
	Thu, 26 Nov 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXTpm38z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E751F000C4;
	Thu, 26 Nov 2026 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795723084;
	bh=XfmQtKu5Trt3TmyRt9+W4Depfu0cIn9OSpKxY/sot9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bXTpm38zvFaMTw0kqMesspI1CYH6ZH8k7HHsO05DX4fEU95hcnlIJQhatoTSDj7OM
	 C0p1LbvNzgMbUd/gz6Wlrk9fa70aFpn1bo1xfoKO9kw2pE2m3avpkpcWL63E5qR7Lt
	 KrI2Mysw5nwJaSROnfUmdo7MIBoDkFv3yRePrvcMe+YZ4VBBcM7fc+vrVb2OHC/uRY
	 +y+42WZXKYGi0WoKWWfZ4mKnYLSuZDImV2+VT65ihz/iUGJEr1/OSGKE5u+aT/wZMZ
	 U2qK2416SImvhTBYb1y8L9DP1TPI5bufkN98x5e/mk3aSx6rl3PAgiIpqEYKgnrxdA
	 +RyFx0NHMySkA==
From: Mark Brown <broonie@kernel.org>
To: Markus Klotzbuecher <mk@mkio.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Sahaj Chaudhari <sahaj123.sc@gmail.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261125161340.1218564-1-mk@mkio.de>
References: <20261125161340.1218564-1-mk@mkio.de>
Subject: Re: [PATCH] spi: omap2-mcspi: lock the DMA request bit updates
Message-Id: <179571459583.142532.8153361107156627337.b4-ty@b4>
Date: Thu, 26 Nov 2026 17:36:35 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bRLqeyBKZI5LgkzqGH1B6e/M2DxPB/1CdZK68tYCWTU=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5+j2Djz0UO8PJdlHl5Ff2GJ729bMD7jv9eRzS/PwYj
 /jmzpi8jlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzk/Q+G/0HbdqV8fngjdxvn
 7Wcr9Nqi7vZFTa/0MTLKSX0SYVPcPoOR4VXE34YjopxL7nsFqT60YvTd51Xvd6VuZ2Dksz5vs3P
 KzAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 25 Nov 2026 17:13:40 +0100, Markus Klotzbuecher wrote:
> spi: omap2-mcspi: lock the DMA request bit updates

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: omap2-mcspi: lock the DMA request bit updates
      https://git.kernel.org/broonie/spi/c/a8e3a6453f2a

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

