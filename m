Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865431;
	b=GW3SZmKyIMnp8VIXabHU7vkAh0GRNG5JerF1WAqM5w4NzNi6gL2G9e3EiJyvX46QW73g
	 t7Sh+ceWwMCfMKnFVV96LXRuazsgPcDLm2rp0j4s9GNalnzb/oG80TD1a1y+WY2wOLPzD
	 0XCfzOmFARNg/dyrnqhvxCfOHVhvmB4GqvA00po+pIkXrXRU4Tzw/ruw9zd6wukCCuKrO
	 CuDtPfnFang9s1zZGPynC5NzZ1gwSvMXmZwSsQXdcxwscRHr8y/7+5QGpPvm0YZ75bQbz
	 ePCF3R3siu9uqW2BEl7IXG1noV7vEMBVnGOmXyyvBJJt5Dl2S/lWTayX4i0jb+sdj4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865431;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ov/6IZZ7XEfFuf0xpzSPcbQE6OpbtU5d3AbTS9+wKu4=;
	b=B3Zfvdruq155a0nm3jMliwgt6oAnTcB5YtUkcXVfFnG16UndgbWbTiQ3s2XKROiAUnVx
	 awTJ2JN967I80xNnxWEsHJbsmCSeXp5zqHxPqbXqAncNDsyIYB7DSqTlKEok7J/Jh+RV4
	 IMPDjzLPpZH5C/hbDE60f483xjVp80Egeo5VECFFO1YM5WPT3g0ayL5HrHBSi5bC6CxXb
	 0Tss58qBaDgDnOSxCQS8/pRcTmluc10nFSuVNApdOduI0po19MI/1TxjCLpdNQWY96Abv
	 RacwcTfZhs9HLXfiZPD8O9yx3CbSM5/2XQMBReouZyUO7kzmICSsA9X1ZXk1C9xMN/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P21+LzkM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161E606A31C;
	Mon, 16 Nov 2026 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P21+LzkM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529FB1F000C4;
	Mon, 16 Nov 2026 21:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794865430;
	bh=Ov/6IZZ7XEfFuf0xpzSPcbQE6OpbtU5d3AbTS9+wKu4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P21+LzkMrBCQNVvG4YGW5FId3BH0twyb3DifSatU6Hs0gg49292bIV9yPZjFffBjb
	 av0ZgTewreqAz5TIw9NeAUQap7pAdMbOrCCQ9NLHI75gtXsEMaa2mPF0QT+mzfPFVg
	 A5Dz/hC1VTTcFXuuLOoqQTHBr1NPoQjOGeGKCeGDymC98QrfzQazUqObB8fiR0i1Mn
	 2nC9WPdJJPXj1WuJBFQDSHLaxV64VmuOamuUGiIvuohhrpwDSOGxvoTZgIf+aAoqdJ
	 kE+NKaLg7Usf/mdL3yCjwNvco12/n5Vg4wKVcFpYOrYCe5hK0Xea0eTAuRRAwuBKoU
	 9feXjCAwbS8Og==
Subject: Re: [PATCH] net: phy: realtek: fix listing of sysfs directory tree
From: netdev-bot+sashiko@kernel.org
To: mat.jonczyk@o2.pl
Cc: andrew@lunn.ch, javen_xu@realsil.com.cn, hkallweit1@gmail.com,
 linux@armlinux.org.uk, kuba@kernel.org, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 16 Nov 2026 21:43:49 +0000
Message-ID: <179486542983.3136.9636959145442798025@kernel.org>
In-Reply-To: <20261115214045.3704-1-mat.jonczyk@o2.pl>
References: <20261115214045.3704-1-mat.jonczyk@o2.pl>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch renames one Realtek PHY driver ("Realtek RTL8261C/D
  10Gbps PHY" -> "Realtek RTL8261C_RTL8261D 10Gbps PHY" in realtek_drvs,…

--

net: phy: realtek: fix listing of sysfs directory tree

This commit renames the RTL8261C/D PHY driver from "Realtek RTL8261C/D
10Gbps PHY" to "Realtek RTL8261C_RTL8261D 10Gbps PHY". The '/' in the old
name makes reading /sys/module/realtek/drivers fail with EIO. It is tagged
for stable.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index ca2d515b77b36..a39ad18382f25 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -3483,7 +3483,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.write_mmd	= genphy_write_mmd_unsupported,
>  	}, {
>  		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
> -		.name			= "Realtek RTL8261C/D 10Gbps PHY",
> +		.name			= "Realtek RTL8261C_RTL8261D 10Gbps PHY",

[Severity: High]

This fixes one driver, but does it leave the root cause in place?

The symlink name under /sys/module/<mod>/drivers is built from the raw
driver name in make_driver_name():

drivers/base/module.c:make_driver_name() {
	driver_name = kasprintf(GFP_KERNEL, "%s:%s", drv->bus->name, drv->name);
	...
}

module_add_driver() then creates the link under that name:

	ret = sysfs_create_link(mk->drivers_dir, &drv->p->kobj, driver_name);

kernfs accepts the '/'. When the directory is read, verify_dirent_name()
in fs/readdir.c rejects the name and getdents fails for the whole
directory:

	if (memchr(name, '/', len))
		return -EIO;

The driver kobject itself is not affected, because
kobject_set_name_vargs() already does strreplace(t, '/', '!'). Only the
module drivers symlink name skips that replacement.

At this commit, several other tristate PHY drivers still have '/' in
their names:

  drivers/net/phy/smsc.c: "SMSC LAN8710/LAN8720"
  drivers/net/phy/qcom/at803x.c: "Qualcomm Atheros AR8031/AR8033"
  drivers/net/phy/marvell.c: "Marvell 88E308X/88E609X Family"
  drivers/net/phy/davicom.c: "Davicom DM9161B/C"
  drivers/net/phy/intel-xway.c: "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.3"
    (plus three more entries in the same file)
  drivers/net/phy/microchip_t1s.c: "LAN865X Rev.B0/B1 Internal Phy"
  drivers/net/phy/xpowers/acx00.c: "X-Powers AC200/AC300 EPHY"

If any of these is built as a module and loaded, find /sys and
ls /sys/module/<mod>/drivers should still fail with EIO. That is the same
symptom quoted in the commit message.

Could the '/' be replaced in make_driver_name() instead, the same way
kobject_set_name_vargs() does it? That would fix every bus and any future
driver name. It would also avoid renaming the user-visible
/sys/bus/mdio_bus/drivers/ entry for this PHY in a stable backport.

>  		.probe			= rtl8261x_probe,
>  		.config_init		= rtl8261x_config_init,
>  		.get_features		= rtl8261x_get_features,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115214045.3704-1-mat.jonczyk%40o2.pl
