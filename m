Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B8348C75;
	Tue, 22 Sep 2026 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096595; cv=none; b=ZcZM5iD/uX6Eer1AzUqc2zndn+5NzJ68LXBaL8D3nTzEJVmYJ2kNJ5CfLu4gExom+yP6Ef3NZElYPOXHh8OBDeWxOckuiKAKM8nvSzrKO1JzPOnIkSksH6v+HJrM2p8stXooK+oMH/zb8pCqzyUCHsByrpTegEZusUPbGmJv/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096595; c=relaxed/simple;
	bh=YWVXGn05t59bBwYol/9eivEUZrMBbQ7aZl7i8X/Tq9s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5PPZjlKZ/DYISi13AP6uIDIn/O60swjQ2LnUYZ9A3dXij1C/whPk/t+P6EAbKoew81eIcT2ETvil3DAwl76YOrJ+b1yBC7SCw5J13f+V0iARr07G3QVEEFXmwqGCCUxqVZvkEi33gL6NKVjq+H2ZHxar4mQsixhloVuNcuYTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxf06q/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxf06q/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4995F1F000FF;
	Tue, 22 Sep 2026 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790096594;
	bh=DTgI03Mb2guSbNjbgohk2ODS86HEBC4CplwUVNmAa0I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dxf06q/cfVdRc+b9A3STWRA0UWGDXlKXGJvWITgIYlNSzK3Cujfv2zQh7kDpaa6bX
	 /9LasdNdUBAjHzz2yRUdmGjaeueKsI80375q2iIEJaa7r3XT6GSB2KtKqBHD4AkRkT
	 pKIQhXRJr0zBqcPYFpD/TOpGuIdsB0Rddz01va4QQ73GpWAPrBJ+WGedlLqjinn5WH
	 E/auFJGb3Qf9HbyAa/84wZWJa4DOdyO5Og/K6SWUU0py0yhYpbfA+RZFY9ix5ff0X7
	 EftFWNgSzEdOG9rbRpd4KjNOOUT5rVRMazCOXpqwYnxMDwmL8sSnYBGJx39seh2IQr
	 5KsMgWWG+HlhA==
Subject: Re: [net PATCH] net: ethernet: mediatek: only enable WED for ARM64
 architecture
From: netdev-bot+sashiko@kernel.org
To: yangshiji66@outlook.com
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
Date: Tue, 22 Sep 2026 17:03:12 +0000
Message-ID: <179009659284.2160803.2402786454793152027@kernel.org>
In-Reply-To: =?utf-8?q?=3COSZPR01MB8140B889AD227E0B547F5F87BC872=40OSZPR01MB?=
 =?utf-8?q?8140=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3COSZPR01MB8140B889AD227E0B547F5F87BC872=40OSZPR01MB8?=
 =?utf-8?q?140=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Inappropriate `Fixes:` tag: the commit claims to fix
  804775dfc288 ("net: ethernet: mtk_eth_soc: add support for Wireless…

--

net: ethernet: mediatek: only enable WED for ARM64 architecture

This narrows the dependency of the hidden def_bool symbol
NET_MEDIATEK_SOC_WED so it is only enabled on ARM64 ARCH_MEDIATEK
builds, on the grounds that only MT7622 and MT798x implement WED.

> diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
> index 2ba361f8ce7d..7737f2f15478 100644
> --- a/drivers/net/ethernet/mediatek/Kconfig
> +++ b/drivers/net/ethernet/mediatek/Kconfig

>     Fixes: 804775dfc288 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")

[Severity: Medium]

Is the Fixes: tag appropriate here?  The changelog does not describe a
defect, only a hardware-scope observation and a prediction:

    Currently, only MT7622 and MT798x SoCs support WED features. They
    are all ARM64 platforms. And it is unlikely that MediaTek will
    release a new net chip based on ARM32 architecture in the future.

As far as I can tell nothing misbehaves on 32-bit today.  WED is only
instantiated when the ethernet DT node carries a mediatek,wed phandle:

drivers/net/ethernet/mediatek/mtk_eth_soc.c:mtk_probe() {
	...
	np = of_parse_phandle(pdev->dev.of_node,
			      "mediatek,wed", i);
	if (!np)
		break;
	...
	mtk_wed_add_hw(np, eth, eth->base + wdma_base, wdma_phy, i);
	...
}

and git grep wed arch/arm/boot/dts/mediatek returns no matches, so no
32-bit MediaTek platform can reach mtk_wed_add_hw().

There also does not appear to be any 64-bit-only construct that a
depends on ARM64 would be repairing: mtk_wed.c, mtk_wed_wo.c,
mtk_wed_mcu.c and mtk_wed.h contain no readq/writeq, no >> 32 address
splitting and no CONFIG_64BIT conditionals (the only CONFIG_64BIT use in
the directory is in mtk_eth_soc.h, which this symbol does not gate).

> @@ -8,7 +8,7 @@ config NET_VENDOR_MEDIATEK
>  if NET_VENDOR_MEDIATEK
>  
>  config NET_MEDIATEK_SOC_WED
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
>  	def_bool NET_MEDIATEK_SOC != n

Since the Fixes: tag makes this a candidate for stable backporting, could
this silently flip a config symbol in released kernels?  On a stable tree
with 32-bit ARCH_MEDIATEK, the depends on line becomes false and
NET_MEDIATEK_SOC_WED is a hidden def_bool, so make olddefconfig drops
mtk_wed*.o from the build with no prompt or warning.

Would it make sense to drop the Fixes: tag and describe this as a build
scope cleanup instead?

One more question on the ARM64 condition itself: if something in the WED
code really is not buildable on 32-bit, does the || COMPILE_TEST branch
leave that unaddressed, since it still builds the identical code on
non-ARM64 targets?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/OSZPR01MB8140B889AD227E0B547F5F87BC872%40OSZPR01MB8140.jpnprd01.prod.outlook.com
