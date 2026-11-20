Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184794;
	b=yCEIAHiAxQZNZK79+D9asrBu2qP0BqKXwMZWbLt4aicWDuT8gvMJCm3f5+/wPhgdi1Et
	 Y3VlGoNJkkdlImoU32jgsCME9Wjcl/10bOLHrIUtwGhsmHNuYkTkwkdmVFs0yF0mwbVhu
	 yn81QeAH5GHEEDZ2BZu6hLPxOkvlkwIJ9w7Nmr8dt2ME+nEHrlLGLOBkBo6ZMH7r1mfhD
	 p2QEazI9svtJgs4h8wuGrxwWUw5iMDGjKL9Wvmg5Erdglmo8/mRxJCKzRp1Bs77N009Wr
	 jMQyHmKN8FF2Bsx8pXIRC+suzwOwqfyx2+zTX87aOiANf6OHWyc4KySm3umfLS7FbXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184794;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MXEJ+MFtGcP0MDSd1iebV4N/4A/ZG9FDk3hg8wlxkpE=;
	b=W54U2y2dZftQ4EPKDA3wWL/l8tQgSE2NgwgnwsIaPNv+Ma8vkDX8ZLvRP2ojjEDVmK1Y
	 KL+2KX6VJ29dEfQz8Q4FlEEuF5V3HNGfqfdbRL3ciTgVsOaFd/xVNUdwuufyIeo+h6+qK
	 YdaXPsLJInGTX4xkgEzCFTHdF6f70ur8vnXS2mzlwHfnW+DwTyFS29iN1ipjdRxMk0KR5
	 D2GsglCGJwUHcgxG+iv2JbNBjXIe61nXvV5G2r++QwBHuNayaR7fi5kMJm5cp8vgAxXJ7
	 R2ItLl4RsS8w8ENP6FGnaNq3T3YAyWHK89kpXKZJam4UMlrVF1lqWaNA/ACk8pJBPdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtA9bkLk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72FC606A325;
	Fri, 20 Nov 2026 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtA9bkLk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F501F000CF;
	Fri, 20 Nov 2026 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184794;
	bh=MXEJ+MFtGcP0MDSd1iebV4N/4A/ZG9FDk3hg8wlxkpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QtA9bkLkgkFwKQsDiv12DqRIWbzHZpScKt1iRsISUsXDSloCPQWxrWjmR5ulTVYNc
	 juYMPpFOFpv9nSMAiPgMXKsr7ayNGHhswHL61TKR30+Cbm+08XdCSCTlDgmIa6+VgG
	 RuAU0IqOFkH9OmSjGOZd2kmBH4AExhAku7CKhgZtYFa78NTmrKAF6huNQy7jgOxW79
	 0e4UE7o9fRm78y99yhP3UAlpo11bJJ5A0XmQu154NNNCgfYOGCBfMxiHevBebz58Qu
	 lVwL70tkKo49iJV0A4RaSc8WZedg6M7wKXl/gBKaRarKhTyQowS3ThIHpcEUuS0m5x
	 b9GH5eXadMVFA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Patrick Fischer <admin@tsv-stahl-riesa.de>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261111-upstream-emc-t114-v1-0-54d9e1bceb6a@tsv-stahl-riesa.de>
References: <20261111-upstream-emc-t114-v1-0-54d9e1bceb6a@tsv-stahl-riesa.de>
Subject: Re: (subset) [PATCH 0/6] memory: tegra114-emc: Fix bus width and
 pad auto-calibration
Message-Id: <179518478010.10624.16434816435378444252.b4-ty@b4>
Date: Fri, 20 Nov 2026 15:26:20 +0100
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=krzk@kernel.org;
 h=from:subject:message-id; bh=wvfsuBATYqa0g6BF6xgpEUVthjbiBUKHaaA0ibnh1TM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrAFiRgdH12q3VGdzDpPK08nTsfu9r0pw0kKdNu
 NcZgnxdtUWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawBYkQAKCRDBN2bmhouD
 1yADD/4hFgqnhy4MNornfnm0PoFb3TfX8OXvCk5LPnYXTX5gVgvcG3W7FOcfhX6lC5F+gtpoh7o
 qI6a3rOFtRPtx9Z0C5yPTVPK5JPBsvTU868zm0wVGP+bZnm0kkX+l3WJcVBLEk3CylquyvnHuLE
 Nfh1FAJoS7hghX7CSsbLAIFy3n2sYs56r+DvEHYrdRMsLNXqzrjeSTFzOKxGjdjy60JVVVY7z8O
 BvXiD1eQ9yG5aZPGbBVhiLP1TWd8ZSQYczyTvlspI7mcmX4/sMCGHaGL93HeUbjaDxeM5Y6vSKH
 hpbLTNICmRm2bTNWF7pPZIZP9lQRfrE/2Fa3Q0KuhKcBLtej4UnI9KXW9yfVjsujJFAPYmSGnph
 nRRSlQHzi5AwUHlIPhVbwMLKp4nBqyLZDU4LwOC1m8RuTL92rLZ6MFs9GHsbGvQVoGPXjF8npK4
 J3RCGHY++jSsh7VHPYP2+94pzhOw0F67sE0YalhpXzcngOmG3rGGfn1c2Gb/slP2tzo2LhIpbbP
 lqYDTyP8s9T9Zmb1HLm74fwSM6b7A4LifRfgD5rSx6lS+1SaqUxeJ9dQ4SuDSbBLthYIaeE1ZaN
 xVzStqQuujWIFYCKsZsW0D9uIp9E5aqXnvrceptcEX5Ka4oYcFLImTCj2/qhsYtTeKk/d/OK9g5
 BvzFpuShYSqGtPA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B


On Wed, 11 Nov 2026 11:10:55 +0100, Patrick Fischer wrote:
> memory: tegra114-emc: Fix bus width and pad auto-calibration
> 
> On a Tegra Note 7 (Tegra114, P1640) I had kernel panics, bit errors and
> WLAN firmware hangs under load, and two kernel panics on EMC rate
> changes from pll_p to 624 MHz on pll_c. Looking at the EMC I
> found three problems in the Tegra114 EMC driver:
> 
> [...]

Applied, thanks!

[1/6] memory: tegra114-emc: Stop clearing EMC_AUTO_CAL_CONFIG
      https://git.kernel.org/krzk/linux-mem-ctrl/c/3b8f59b6feda47ea37ddfd29f4352f4990e9b9d9
[2/6] memory: tegra114-emc: Use the full DRAM bus width for interconnect requests
      https://git.kernel.org/krzk/linux-mem-ctrl/c/b7789fb82fbfe5ef16bed6068a3d5b1efe379eea
[3/6] memory: tegra114-emc: Always restore the auto-calibration interval
      https://git.kernel.org/krzk/linux-mem-ctrl/c/8d48b698942dc1f439dc785e2f83a00ef750b8a0
[4/6] dt-bindings: memory: tegra: Add Tegra114 EMC channel registers
      https://git.kernel.org/krzk/linux-mem-ctrl/c/2ab2ea1bb4720c567ec6a47539e75ffaad502bde
[5/6] memory: tegra114-emc: Program pad auto-calibration per channel
      https://git.kernel.org/krzk/linux-mem-ctrl/c/af17b5fee079904c89008268c54029ff84dffab7

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

