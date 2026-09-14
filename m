Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758936B927;
	Mon, 14 Sep 2026 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424008; cv=none; b=RGpAT6cee+n+fYQP0Wb+JvYC+yPv64AKj5DX8NYuNNFqfXchHM1xdQCYpB+ZDKmKvzcjD/0tt4qaKIf1q8rzPcpq609d/B0oX8f6+g+Vu4b2VyZPFFkp9voZ+aDUFcWdChnFqZrSW4cEhSdSCac/Yn+TbkyxIfRGQBsYj1sVWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424008; c=relaxed/simple;
	bh=wYYFAQImsMaUcxCGe3bH3Wi9+6++MQbNHU+QCsuQT2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DKopmbTN235us9z2T3xuFfkxMacK/nyz0yIOMTF/RV7yVrn0AijIrbMiY3waoBKQPGu56wVkV6mb9KzgEXVE/1qaEj25Jx4yCAeIGfvdHiNPufofpNWoxLCK5MZJL5mpSUgryxcKME4rMkYWYqcNQK9H2KjlIE//hbnLQN9VHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj4LsHMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj4LsHMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20CF1F000FF;
	Mon, 14 Sep 2026 22:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789424007;
	bh=w5ZxICt6RyNBBcsv8PtuLdI0PmtZ+1CM9RWdDcC0spw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Uj4LsHMOv2FGfDoF9rWK4Yze9xM1bckOL93wswNtVvUhZxSgcjGobFHCA3legYEIw
	 qsbSTOfaIsKO8gOagLSl+HlizS+wzUUECQp8mypuIrE8OVuKJaNccmbQfMe5ne4zz1
	 SE7nA3NPqBzTanCWwpeO6pCYdaB/25q5w0IzON2HWvSSxFXkslM17EdRoDorwbqyFx
	 CSjQp2UXqmRjJKux3r+XWHoJ1nSJYG5epBiodyfgPI6H9YKwQXrTjFqig7pGWqRXbH
	 I8MSYSOwTFxGhbyonjMZtVtkkNk+TTEO3gKDakx0BFyzAbLDL/I+5JplKm1DkGaT7f
	 nVzAqJTOmscbg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alexey Charkov <alchark@flipper.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org
In-Reply-To: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
References: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
Subject: Re: (subset) [PATCH v2 0/4] nvmem: Derive Rockchip MAC addresses
 from the OTP CPU ID
Message-Id: <178942400455.686568.7345103522777056647.b4-ty@kernel.org>
Date: Mon, 14 Sep 2026 23:13:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 02 Sep 2026 17:07:51 +0400, Alexey Charkov wrote:
> Rockchip SoCs are shipped with a unique CPU ID in their internal OTP
> memory, and Rockchip bootloaders use it to give boards which have no
> dedicated storage for a MAC address a stable one anyway: they hash the CPU
> ID and patch the resulting addresses into the device tree they hand over.
> 
> Kernels started without that fixup, e.g. straight from the SPL in Falcon
> mode or by any other loader which does not implement Rockchip's derivation,
> fall back to random MAC addresses which change on every boot.
> 
> [...]

Applied, thanks!

[1/4] nvmem: rockchip-otp: Serialize reads
      commit: 798be42019957b28b4fb897d7f9f6cf6712247db

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

