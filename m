Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B333D9DD4;
	Thu,  8 Oct 2026 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443960; cv=none; b=uwIo6F9tjFWVeOwFhYUDKJaanT+2fa7gj9TepX012A5eBx/hHDXgB4gTX2mBX61kMguRzf9OC1rve18uG9R3gRcKlzwgEfTDr2lwObmsLkVRdJb6Rr45PPzAVc6UmtAM50UuvkUY6zdoYaXhGsjP/BQzsiw25riB9vFN5QCbZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443960; c=relaxed/simple;
	bh=8RaKJJa88G/U43Om9GWKyuM7R61X/xlktmHdGJHrtew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q3OcAoCrSLsW/sFogqn1ZfMn+25LvgtvNZ1PsUoPQE4AH9xyXx5KpzEI7zFQ4xZ037KGDoDlXeC7pzAci2B0gOe7TLsxBeb6MlIowZTS4Pn2bdhsbSE0z8VsoFXj2mPcC2hX1V42WHv9dtJMy1O2sKJTbwah29NkT3zkKBuWC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQsfXGtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQsfXGtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F241F00893;
	Thu,  8 Oct 2026 07:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791443952;
	bh=LSxPZEPR5SziIXhK2HrZDL72qyLOyeEGstZGusBKpNM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LQsfXGtdDAq5hxoRYFNW5Bc7NQI+wkUEG7tOAvMv450ED0QbJr+NjFOIOEW0tqXCg
	 0JFra5nKNM5H+TIHlvq0la45Xz/b8+3jCWG6mvZZp9QcYX/zCYhD20jHfcC36J/4KH
	 Rvn1vvl3UwijR664CP0qb0Z/wlAdkgd6lrDEP2wi3wNubzBNZzfYb/mwRYgk7XVT1c
	 x+9/O6+fzwKtxkw7NMV49CBCUS+YGoGmnl39/KsFBRyO/9Xpp4GGUGJOqJdnZtHwy8
	 SlCE3MO+FMBUjLy5X6Bnzhc9MU3biOun1q7E4QKy7JEz/5OSKvJjTsFs2AqcUfNV1v
	 YBk27Mf8I7bRA==
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Pin-Hao Chen <billy920225@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261005220528.7199-1-billy920225@gmail.com>
References: <20261005220528.7199-1-billy920225@gmail.com>
Subject: Re: [PATCH] spi: stm32: fix double free of SRAM buffer on MDMA
 fallback
Message-Id: <179138619954.2423942.17574965828667602495.b4-ty@b4>
Date: Wed, 07 Oct 2026 17:16:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8RaKJJa88G/U43Om9GWKyuM7R61X/xlktmHdGJHrtew=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqx0PqnniUR/n8Cc0GizO4cmryq7XxHYvsVWhR2
 Isr9QXQfHmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasdD6gAKCRAk1otyXVSH
 0PEMB/9jChwCIe3aM1b6h8T/3EjY6c0rCpzb8LBIjBXSH+I3C5muPF31tDmpJbZlA2rInp3S+54
 rrA2HswRABIZY0iAnIXZVh5efFl219B4cVRO7IuAfbKdl81A/do86DIal7ucBKyojoKV8w9CX77
 F4EvzTeWzGD+N4pqlHYl5lOzdOeSmBuuw4QZAaEV/Y7gXuYKAio9Dd5xS5VHUP1ZrsuF0hQOfHI
 rdyALx0PiErmOjBiUuqIXk9eDY1EvWzkjSExiKNZDlAnYbULFwnb3KYa5UrnSaVtPoIC4tgCyOr
 cdsb7teB6Dzj8b5TqPgDmJ23v8//S2LQLYeHBHxtiyIVuYMK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 06 Oct 2026 06:05:28 +0800, Pin-Hao Chen wrote:
> spi: stm32: fix double free of SRAM buffer on MDMA fallback

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: stm32: fix double free of SRAM buffer on MDMA fallback
      https://git.kernel.org/broonie/spi/c/0c5b0c3eb1d6

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

