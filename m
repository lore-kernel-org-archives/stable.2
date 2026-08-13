Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E5212550;
	Thu, 13 Aug 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610362; cv=none; b=fNaspEs1PgBGKnn0e9V7YMObpaIBOfFTevP71sSVOt2kJZSqRL914TELizjtZpuSFFb/wMkl9tR1xh/JWpr4xF9OS9cHTcU8etRyZSPljeIF6XhP46rLWf52g5tFziwxyiFYnWYFDuFt6PGnsbvzxm+13VO4rxaFDE10bHz3Zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610362; c=relaxed/simple;
	bh=IMKd6ctsSzxAom010WdeHw8+f0VyQ9kH2Fc8LoV6Rv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNY88c8pKuuXCsft7FvHvIeE7GsKtdG/m+VddUPyfmLjiqs49GblUFpEvFnffYXSZh7dBUUEoKd/yUjt82IXSuGjmhOxU0BOvMrZg15h/dLCz+WmWZT6CvtuJE/08BTpk+zJug0UZzdoeaBMwofoYlpMfDsbplFTSYMmiYEsRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Rxki+4b9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Rxki+4b9"
Received: from francesco-nb (2-224-16-253.ip168.fastwebnet.it [2.224.16.253])
	by mail11.truemail.it (Postfix) with ESMTPA id 75CA81FBAF;
	Thu, 13 Aug 2026 10:39:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1786610355;
	bh=CVSjljxeTNiOuA8vcM9heS5OVd8fSR3FWCLRErPJk2w=; h=From:To:Subject;
	b=Rxki+4b9HHk1g177TyUVGYgaFeBxm792nu9YHZaz0+HyaZmeyUOPQQOBJoJptGMXw
	 5+sEXymW6Q0M6fMqt3OHNGJeAErFUS0cXYGlT+5Pm2pShg+oqHnTAyetmaQJyu/BDO
	 klp01qqS7kjZi6wsmior1B0PjtL4+W0gIPeENGYrxaxKjYJm5RwvygCmSJwUZEa7JC
	 R2cyr7yr1fBNZHygeWwHTvFtdFoZe7QQ5ej5EgBpRLOK5dA2vNZPd4eS7IyDk2HT48
	 ziJIr7a9L+gRBEawizjv9g+T3t6PmAUfQPI5WtwtAdhP506yw+XERG0G5jJFeqNxPM
	 Z5PLFlnfo8K5g==
Date: Thu, 13 Aug 2026 10:39:12 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: hongxing.zhu@oss.nxp.com
Cc: leoreis.costa@gmail.com, fra.schnyder@gmail.com, francesco@dolcini.it,
	frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Move clock enable after core reset
 assertion
Message-ID: <20260813083912.GB19687@francesco-nb>
References: <20260813082900.270003-1-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813082900.270003-1-hongxing.zhu@oss.nxp.com>

On Thu, Aug 13, 2026 at 04:29:00PM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> inadvertently moved clock enablement before core reset assertion, breaking
> PCI device initialization on i.MX6Q Apalis platforms when
> ASM1061/ASM1062 is connected.
> 
> Logs:
> root@apalis-imx6-11486042:~# dmesg | grep pcie
> imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
> imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
> imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
> imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
> imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
> imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
> imx6q-pcie 1ffc000.pcie: Link failed to come up. LTSSM: POLL_CONFIG
> imx6q-pcie 1ffc000.pcie: probe with driver imx6q-pcie failed with error -110
> 
> To fix this regression, restore the original sequence where clocks are
> enabled after asserting core reset and configuring the controller type.
> 
> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reported-by: Leonardo Costa <leoreis.costa@gmail.com>
> Closes: https://lore.kernel.org/all/bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hpgwve6@n2m5uhlduw57/T/#u
> Reported-by: Franz Schnyder <fra.schnyder@gmail.com>
> Closes: https://lore.kernel.org/all/t65y5d54axtksbfs7r4olcefqhwm6m4dz3njgnrnf7fcotj74i@o7avoznlafbj/
> Cc: stable@vger.kernel.org # 7.1+

7.2+, 7.1 does not have the broken commit

minor: it is not 100% clear if the issue is specific to the ASM1061/ASM1062
device or on the specific power-up sequence (reset vs cold-power-on).

Francesco

