Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD443D6CC4;
	Mon, 31 Aug 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168619; cv=none; b=rLaux/WIkCwkqO/TTfVfoUlDGMIyXsbsEG27H0oDzofGxDHL2p8VcCsdfANhQTXOpoq0+fFdPpTfE5NWA198e/9X+IvESl5M5LCV8Dv1DVNXM+Q4GN6jW+p/xovmLdOvbsC5d+oZjnXLhzNBgiGKO4waBIN+D+KFz6y7vNz4xM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168619; c=relaxed/simple;
	bh=3k093OZn7jiKKV7B+IPv79Fk8Z+3lNp4TiIVas+bEFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4UletKnV6GPystpA2G2ljObRe+gycNUcKTPn6RZ28VbgYkHJ3nLMTGSAg/hq8dnu0AXczRHX+ef/CVJ8MGh060OOGxX0zPGS9LaLr1x0fNcdlZ+BEDPOQeRQ38UlbWWHDjiZ4XQE7rPB5aRvbv2QwFf1a/CL+8LBcvsTW72SA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lZfavcCU; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lZfavcCU"
Received: from francesco-nb (2-224-25-26.ip168.fastwebnet.it [2.224.25.26])
	by mail11.truemail.it (Postfix) with ESMTPA id E86D91FCB2;
	Mon, 31 Aug 2026 11:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1788168607;
	bh=Rg3osVrlVujAJNkG/ATHMtl2juMAYLPOw8Bb3Ax+ya0=; h=From:To:Subject;
	b=lZfavcCUTgbZxwA0zMbPbgnJChS5FYFr9quaQxIVd/YU7OaMh5G5tAoCbE4BgcOU5
	 wl+m1JMP9Zta9vhcdOC2lozpxTCaQl9ufIeULJIkXrly2cq0O6klXpk0kpl4wfsjU9
	 r5XGJt8Bo26aoKbT1n7yfayfQj+BcqzWzpX+KSO2/KGNDpJL4PGRCtH8KTxPbngm1w
	 Tm8KPmGPpONlmAALYeKCUa3tUyI7wBwy/bIyphKWHIrmUpsLbqk120yH5iJjt9eFSc
	 iYkrvsK5MeuRaC+eHWjXD/lLHQLB5kJnXzuEfw0v0buZsGAlknrf2J2drtl0r0G598
	 LfTmIqR7jWKNg==
Date: Mon, 31 Aug 2026 11:30:01 +0200
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
Subject: Re: [PATCH v2] PCI: imx6: Move clock enable after core reset
 assertion
Message-ID: <20260831093001.GA38375@francesco-nb>
References: <20260813095003.356062-1-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813095003.356062-1-hongxing.zhu@oss.nxp.com>

Hello all,

On Thu, Aug 13, 2026 at 05:50:03PM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> inadvertently moved clock enablement before core reset assertion, breaking
> PCI device initialization on i.MX6Q Apalis platforms with
> ASM1061/ASM1062 SATA controllers connected.
> 
> NOTE: It is not 100% clear if the issue is specific to the ASM1061/ASM1062
> device or on the specific power-up sequence (reset vs cold-power-on).
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
> Cc: stable@vger.kernel.org # 7.2+

gentle ping on this, it fixes a regression from kernel 7.2

Thanks,
Francesco

