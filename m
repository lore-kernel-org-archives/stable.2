Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913510;
	b=f1dgJ69S9jRMYsnNI9r6NkZbdZ/nz/FgmJw1VkGTwbmtpyol5bEjvhDmD5i/L+gwQR6x
	 WQ0/qVYr9/fj0HzUIv1xx+CjL9fgcoDPtlXJoY1DPgqKmVxjAud6tadN2naYH2KKzXd/6
	 BeG2dMTpPeG42qrmMY6ksq0itqkpa0gWRv3Y1f+aJ9MDfDsBCjkzW9YC9WCRATKBF4dCv
	 8d33ngZk9vO7MxqQ18CR+PXOAa8sks0PS3ncAIWeXCaMlDhTkNL/8nxDC0nNsdss+IlqG
	 oj9osPzfvvEWyIELld/8R+2c62Gty2Tv5CC3s27vCwvzMWUUI3b5XbaNfXTnVMsL/4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913510;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=Ed7lLF0CP7JeqyIekPCZLpbtKsM3+dJiy8vZ0Ay8D/w=;
	b=vZ2Kw1FZsarVP8ScXdx4anRghvqhiNLAfJAYOB8L6sCitat2E2YkfuuEhnBPKMKMnMkF
	 fahhQrxbGSivnIIEFg90qfFc6E7BU8Zbe4rdDNgmoYzPPaPYPg67s9CyFibWFDgfH54Ir
	 Qi6bwBQZOvYEjgg7OxVk4l1J3Zaskm+MBPI5WTm89HPPmUxy+Ug/DHkQIFZEU75qRSGzl
	 e30rlEOk7FZmsuZS4s5Y2VysS5ep9umwmuOdieNPmR92NJ53nVjoBrnAeM4K6E90QZlnW
	 UsdnL/484ZePHfxPkwdpBA8+AdqJweY7g9QUx9RKNPfjeJA/smR3BN2p4ITZBqdccaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="AlhkpnS/";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE1606A329;
	Tue, 17 Nov 2026 11:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EBE1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AlhkpnS/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794913508;
	bh=qD+A+5r0Pu5rX+NsDc5YpHGQypt4R2BcA7Y/dGhVwQ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AlhkpnS/onVNimPbPrBmaOEMj9/lUaCy+YIcEnteLP6km+nmS2zpGCFDaFacNKq7u
	 5ZoOl1s6+XQKXzkVpzK9842JDliGu+WXMyccOEKN002T0d+7zrv06j9n1AjKqjHdVw
	 T8y7JuGrpYakX3f8g5DrYedooFL9pi5Q9CtXWXG+qiJx5hUcsjKn4BzV4W7mGwcaow
	 piZxWPhGnzCBR8u4ECs3dp0WSN1113Gz1AM/XS03kG3q3zSnMefRoctr3amQjvmusQ
	 vcHtFyMe+NYLPm6lK0hwRZ901d+nn1kE2b7zilGaJJjEwSf/zQZqkzA2b8U4WB3V1O
	 Q+fJM/Rje8Gow==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 38C1617E07EC;
	Tue, 17 Nov 2026 12:05:08 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
In-Reply-To: <20261030103418.2355854-1-wenst@chromium.org>
References: <20261030103418.2355854-1-wenst@chromium.org>
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: mt8192-asurada: Add
 ramp-delay for MT6315 regulators
Message-Id: <179491350817.164578.3923681659802112857.b4-ty@b4>
Date: Tue, 17 Nov 2026 12:05:08 +0100
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

On Fri, 30 Oct 2026 18:34:15 +0800, Chen-Yu Tsai wrote:
> On Asurada, the MT6315 buck regulators (Vbcpu, Vlcpu, and Vgpu) are
> missing the regulator-ramp-delay property. Without the slew rate
> specified, voltage increases may not have settled before switching CPU
> or GPU to higher operating points, risking undervoltage crashes.
> 
> Add regulator-ramp-delay properties matching the slew rates configured
> by firmware, with values provided by MediaTek: 8000 uV/us for Vbcpu, and
> 4500 uV/us for Vlcpu and Vgpu.
> 
> [...]

Applied to v7.4-next/dts64, thanks!

[1/3] arm64: dts: mediatek: mt8192-asurada: Add ramp-delay for MT6315 regulators
      commit: 9c9f83e3368d27d1e0ba55827a171ebf551c3d0c
[2/3] arm64: dts: mediatek: mt8195-cherry: Fix ramp-delay for Vgpu
      commit: 04560888cde5fd8adc325a6ce47466f80b8c668f
[3/3] arm64: dts: mediatek: mt8186-corsola-voltorb: Add MT6319 ramp-delay
      commit: 929638df9f3b36665efd60ac71f1eed4ba36a0a5

Cheers,
Angelo


