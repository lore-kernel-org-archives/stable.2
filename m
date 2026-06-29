Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5D3CB8F1;
	Tue, 30 Jun 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818190; cv=none; b=Q5Qz6OZbt7V0hpyGDTTCzUTsmZ+GVzAmenaBnJt9iQ+V3h9cIEqsPHSOOzqrzBIkhSGQsx4yvdMXJNd6yVy+wwbw8Q2bNjmxEUEJxF2ov72zblN8C3tEPo7VfBwTXULs0UsKDvSk3WKWFGYTBLO/UzExVK+dtrAMZdh3QOZybvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818190; c=relaxed/simple;
	bh=YV6YJpcGwfQvseMKoKnas43u5Hxx1rnlDUu4/Nw/DGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y+UH2nv9M96mRL+9BV8XZejG2isjmA2SZ3Nzo1TpC56cInEx8uRvMRIB3tAozhTGFDp1unavM19HSarijmJ439zNoqepNtcm41QnKIosfdrXPwMHJkZb0aADHXIbyOsSZOWf0q60TNlofSwzY9yCH5keGFXu+4STDa+atqUy2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSPZY21t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSPZY21t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A591F000E9;
	Tue, 30 Jun 2026 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818189;
	bh=7uk3YhrWEUg+nWNZmn8lka+Y14/S6FL8oxksKWCkBzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iSPZY21tUzZI3mSVAns2pmoP4+ViGPrR5XdX85l/Ln5ve31xO1MP1z/3qBNrml4by
	 nlYuzU8StaOLqHUBBM7mVnQ2GIWLEoOXg9WVx4TZZCZ/gPsc5+R4BMWNu9NKxc7T/l
	 4ShnRP2L8n4HZKDP8qt6T4ApG72v1memvv009JoJGvxlmU91LkhQbiPt2HvnpnTUFy
	 qMeosOKayOX27UBnkR4MGhO/euoPVotFYQ4IiCFoGMEn0NKwDor9jZNg1W+5idJ0UF
	 miGlbrfUgUaNIU862RyhHtAVPMFFTDyH42jqfMnVAse3iSPa5622uOI8A3umXPpClh
	 D/laua+JWlMpg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, stable@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260617-ipq9650_refgen-v4-0-c505ea6c6661@oss.qualcomm.com>
References: <20260617-ipq9650_refgen-v4-0-c505ea6c6661@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] Add support for the REFGEN in the IPQ9650 SoC
Message-Id: <178275629145.47562.9789998445156549572.b4-ty@b4>
Date: Mon, 29 Jun 2026 19:04:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YV6YJpcGwfQvseMKoKnas43u5Hxx1rnlDUu4/Nw/DGA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ6WJ3gs57rxjOYInD2MF9f70GjUy2TeB0g/30
 HGlGgu5FpeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakOliQAKCRAk1otyXVSH
 0AygB/4weS7fOFEV/Z0PlEhepkVD4y5TuXvddWKlAAjgw8nIXPWn7jbUbSbRi/WDmjhOYTEUZpj
 V6dYcOhzVh592w8H950ox5WAVxWmBiySqVDYffEc8WAJMsKKR4SS0iQvd1wybjws/X7MxRqIjni
 LlOSTDK1ov/1NN+F/4w2ny4Kr5Ph76svAogSdPIibgV+hZMPe5sd8FR3IHOZgdOrKN6YbDl1Vkv
 caYA0vKOCLB3esiXvs7ZJZkYT2fXWN41kSQOr+edO4SkRjWENO1BAjFQ6IT2PPNdF13qoI6yuye
 ypWVxhjdXZa2VN8MefEy7znvZSSz2RwuNsuwwx1PyJ7RVVOo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 17 Jun 2026 23:08:42 +0530, Kathiravan Thirumoorthy wrote:
> Add support for the REFGEN in the IPQ9650 SoC
> 
> IPQ9650 SoC has 2 REFGEN blocks providing the reference current to
> the PCIe and USB, UNIPHY PHYs. For the other SoCs, clocks for this block
> is enabled on power up but that's not the case for IPQ9650 and we have
> to explicitly enable those clocks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.3

Thanks!

[1/3] regulator: qcom-refgen: correct the regulator type to CURRENT
      https://git.kernel.org/broonie/regulator/c/05dfeb2d0ccf
[2/3] regulator: dt-bindings: qcom,sdm845-refgen-regulator: Document IPQ9650
      https://git.kernel.org/broonie/regulator/c/7b5cd466e488
[3/3] regulator: qcom-refgen: add support for the IPQ9650 SoC
      https://git.kernel.org/broonie/regulator/c/ca5c1a0ca229

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

