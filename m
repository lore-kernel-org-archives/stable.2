Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931959;
	b=t5JZGrohVO+48yP9Sn1gc2dZ2HcgIexTuCKc5nyIuV32kxWbhoQBTZgZHuCt7DEXf+M2
	 TeBjWMvwwyJCGVh+pBMj83JW2NhxW75+LXBw65+RvGxE7361Tb68hXEC36jLgTpduTb/8
	 ONmstP4g4k1hnUmvFusE9Vv7P3dYK586J412OHjlOppzpQ86OdIKULJGRG/CSRR4p/HFd
	 7+AdbnE3n9RWI/Zv+NHVJAL5yvBtlgBVN+7EnQfOYNG3qcVyLFHNdC7VEdi2CCmTlSX1+
	 +f4HSDizKcQrFC0GuCyBu9ZB5ZeVp+N7JaqB3wgbhUNgv0KaQA7kKohpW638af8QNtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931959;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=f+/6cPyVL7K4OQJ17M0iF+OL3WNe7td3ln+qN/9TMlU=;
	b=l+07wxUYjuj9g0Yl4ccsLwlvk2JXWzQLNthFX35hrxzXoSr/sD55N2hZkEXe7UqXtXHb
	 4H+t76PitdHx0IFTT0DkydbYhCwu0Rf+pjJBsO7g7LBAk+89CoiMuec4upEpCY7ZQhUOG
	 fd+cAcb1O92v2slPxUgcfTQBPTw6jS7kRdOSzMeV93fyO9Wk86ri39khnZqiVkeNqT1vw
	 sVxPDFgEjB9hnORP4uVNJXyRAnw4hg0Jwx6PNlFUSPye7788fM98n/itXycpISNVdPyJ5
	 fR2pK5ZWj7s71H6+yVpqCuoItSfuFjCSq7oiWj6MgFH2IJPPMH3XVw2l496RzGVYaMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O5Q+/YvM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A17606A31C;
	Tue, 17 Nov 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5Q+/YvM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0249E1F000C4;
	Tue, 17 Nov 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794931958;
	bh=f+/6cPyVL7K4OQJ17M0iF+OL3WNe7td3ln+qN/9TMlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=O5Q+/YvM44QUk3wBqsXYQ26kDyelxtYbP2AvDJgP4Icc/O+WTKurgKpLEx1KD7NA8
	 tPenRS3dAbuIf+ZA0sVhuKWsb0thB07Tj4fdspfYaeKZccr5Z4VNt7eBiDxYP0gUH9
	 hACBTwj/SuWTmcHINjid+6p6xgMetH4SlRfegPdhSprjLRGO8vpDql5MSFeBrMXjuR
	 s/4+X5HfeD4LNzr7DxslN5CaxeWh8xKzYCE2VAor1bkNJ72Q9/Yj1O5nx/G+BPUDs3
	 Y8P5WOBKpRS8WFFLctyKlgqQ+hAOa2kzz3OklN9BaYLZio7xB169v6rkmlY0aXC/eS
	 F3ZTrVkwWBo5w==
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>, Mark Hasemeyer <markhas@chromium.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 kernel@collabora.com, Alexander Shiyan <eagle.alexander923@gmail.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261110-spi-runtime-pm-fix-v1-1-8601ebb2f6a8@collabora.com>
References: <20261110-spi-runtime-pm-fix-v1-1-8601ebb2f6a8@collabora.com>
Subject: Re: [PATCH] spi: Fix runtime PM imbalance on pump transfer message
 error
Message-Id: <179492736789.77896.11207792576309707845.b4-ty@b4>
Date: Tue, 17 Nov 2026 14:56:07 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GPDZObiCK6E7h0QOgxLM+QhPzWZiBmUAKR9S9vrKWUY=;
 b=kA0DAAoWL+9zsLPQOIkByyZiAGr8fPPI7inKTe2wtGgZeTG4r2RF9kW8nGMEgXFbp+eQObqro
 4h1BAAWCgAdFiEEXmoL6X9066wOwaGGL+9zsLPQOIkFAmr8fPMACgkQL+9zsLPQOImb3wD/Whxe
 fbfRYX67y/ghbpoJ3vURtSdkY1/y/tSBKKYneZsBANtXLZCDy3LmaNxdZU9ahvCM+nBfEhqwv0l
 JVvHp5QMN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 10 Nov 2026 01:41:58 +0100, Sebastian Reichel wrote:
> spi: Fix runtime PM imbalance on pump transfer message error

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: Fix runtime PM imbalance on pump transfer message error
      https://git.kernel.org/broonie/spi/c/bb5caf7a2e0b

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

