Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057890;
	b=ZZLLcyeq6IJs8rDaMZPA4cq5vRwj/g8hq6Szsh+GydUVRb28V/JIW8N12V3Ens+xaDHh
	 rjg3Njy7FbJs731zQK90nqAd09+ACF3F9J4Fv6nEVMHY8hoLq6HlQU82YGCBkkBGJIodJ
	 fxQrsQ96PqZh6iRvCEqqEDiOwrxuKGgwaxp5veu1DzpZYDTLgDh+sPFsy6L1Kfq2QEX0m
	 /IVtaKEaTfLKx3Fb2sBMq4iq8jOiJtScb5PK4DqJsC8SG55aysn2GC6/uEgBy5dvr+zwv
	 /Sov5QRYQl33aIP/Abq9Htrb+vYxx0dQJH8aH47dz1T5skvuOF8HU+5T/Q2mZQMeJLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057890;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=miXRAW1Efri9cUSyb7Jw4ccqK0kjkG8zCIFDdKi5TKo=;
	b=nl60EeOx063b700tDd384nQM208GnHl9SO06sQs0FOh7kju6xtaZ6WbxNRV9xFXBbH7E
	 Ks2eNTK4fNeSy/P/lzKIeRCUVYKTA5EPeW2ACbwBt5q77A0UFcHaRcVYKgb4ZLEWPjD/F
	 i4chemGI9Y7cFoSrRx8I8Q/AIvIsm047Z1Dp9edaKTG0UAsAEIZJjKbJbgWzoXztMmSFh
	 V6zTg/IdyB/decVfx1AcXJqE+q5zERN6qj+RwS8TTTgbNuooYVo3y+8qNqsCu/jKjuJuF
	 DJu0xblQqLZRCnUNLn1ObqhIhW8r8GM8Wsfi1nI5REleXK/29+qG5NlWkMAVwfjAEhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFMTYist;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9B606A32C;
	Sat,  7 Nov 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFMTYist
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D6A1F0089F;
	Sat,  7 Nov 2026 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794057889;
	bh=miXRAW1Efri9cUSyb7Jw4ccqK0kjkG8zCIFDdKi5TKo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OFMTYistWAuJUZ+YHRAp20uGkUMAZ8XeXx7HcTiulRTFdACK/wj8In4p4IxUCaHiZ
	 wKHfcdhgsrudrpf4LF1ej5+w36swO8ekjD/L/1f8ZR7yYHg+mEOI22DragnKEkKMKi
	 TOkhgiTp0B6pNN0vj2i8XlmUCHoTRjAV2K1HuzWRSFsaHlKN7fkVQ3VADp4LZ5Jqt0
	 yzgAdV6uo4PQzr6RUKhzu+0FZ19UK1cUKaMLU52/ei1Hu9vglWY2Ej30mPi3sGQwlb
	 QXp59F9Z4GZPHhmLbPDn4OEaD3lin/cVHPCwGAdSVE/zSqmOdTYEF5sccW0L6U77Pv
	 6ZSivK4UA34OA==
Subject: Re: [PATCH] net: phy: microchip_rds_ptp: unregister the PTP clock if
 init fails
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 13:24:48 +0000
Message-ID: <179405788818.994134.7883775213631372468@kernel.org>
In-Reply-To: <20261103102900.1340854-1-vulab@iscas.ac.cn>
References: <20261103102900.1340854-1-vulab@iscas.ac.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The PTP clock registered by mchp_rds_ptp_probe() is still never
  unregistered when the driver unbinds after a successful init.
- [Medium] The commit message misdescribes the failure context.
- [Medium] The new error path in mchp_rds_ptp_probe()
  (drivers/net/phy/microchip_rds_ptp.c:1321-1323) calls…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  mchp_rds_ptp_probe() makes the PHC visible to userspace before the…
- [Low] This problem wasn't introduced by this patch, but
  mchp_rds_ptp_init() (drivers/net/phy/microchip_rds_ptp.c:1139-1240)…

--

net: phy: microchip_rds_ptp: unregister the PTP clock if init fails

When mchp_rds_ptp_init() fails, mchp_rds_ptp_probe() now calls
ptp_clock_unregister() on the PTP clock it has just registered. The goal
is to stop leaking the PHC, its character device and its sysfs entries.

> Nothing else releases that clock: the callers abort the PHY probe, and
> the clock object allocated by ptp_clock_register(), together with its
> character device and sysfs entries, stays around forever.

[Severity: Medium]
Is "the callers abort the PHY probe" accurate? The only caller of
mchp_rds_ptp_probe() is lan887x_phy_init(). That is the driver's
.config_init, not its .probe:

drivers/net/phy/microchip_t1.c:microchip_t1_phy_driver[] {
    ...
		.probe		= lan887x_probe,
		.get_features	= lan887x_get_features,
		.config_init    = lan887x_phy_init,
    ...
}

lan887x_cd_reset() also calls it directly on the cable diagnostics
restore path.

So when it fails, phy_init_hw()/phy_attach_direct() fails, but the PHY
driver stays bound and devm resources are not released.
lan887x_phy_init() returns before init_done is set:

	if (!priv->init_done && phy_interrupt_is_valid(phydev)) {
		priv->clock = mchp_rds_ptp_probe(phydev, MDIO_MMD_VEND1,
						 MCHP_RDS_PTP_LTC_BASE_ADDR,
						 MCHP_RDS_PTP_PORT_BASE_ADDR);
		if (IS_ERR(priv->clock))
			return PTR_ERR(priv->clock);
		...
		priv->init_done = true;
	}

As a result, every later attach (each ifup, for example) calls
mchp_rds_ptp_probe() again. Before this patch, each retry leaked another
PTP clock, not just one. With the patch, each retry still allocates a new
devm clock and pin_config, and those are only freed on unbind.

Could the commit message describe the config_init context instead? The
probe premise may also explain why this error path only unwinds the PHC
and leaves phydev->mii_ts and default_timestamp set (see below).

> diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
> index 2ad95d5c9d867..0db6eeb2660c2 100644
> --- a/drivers/net/phy/microchip_rds_ptp.c
> +++ b/drivers/net/phy/microchip_rds_ptp.c
> @@ -1318,8 +1318,10 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
>  	clock->phydev = phydev;

[Severity: High]
This is a pre-existing issue, but is the PHC visible to userspace before
clock->phydev is set? Earlier in mchp_rds_ptp_probe():

	clock->ptp_clock = ptp_clock_register(&clock->caps,
					      &phydev->mdio.dev);

ptp_clock_register() creates /dev/ptpN and its pin sysfs attributes
through posix_clock_register(). clock comes from devm_kzalloc(), so
clock->phydev stays NULL until the assignment above.

A process that opens /dev/ptpN in that window and issues a PHC operation
would follow this path:

ptp_clock_gettime()
  mchp_rds_ptp_ltc_gettime64()
    mchp_rds_phy_set_bits_mmd()
      phy_set_bits_mmd(NULL, ...)
        phy_lock_mdio_bus()

Can this dereference a NULL phydev? settime64, adjtime, adjfine and
PEROUT through mchp_rds_ptpci_enable() follow similar paths. Those
callbacks take clock->ptp_lock, but that lock does not serialize against
probe.

There is also a second race. mchp_rds_ptp_init() runs without ptp_lock
and does CMD_CTL_DIS, a TSU hard reset, OP_MODE/REF_CLK programming and
the enables. Could that overwrite LTC or PEROUT settings a user programs
in the same window?

Would it close both races to set clock->phydev, set up the software state
and run mchp_rds_ptp_init() before ptp_clock_register()? The
unregister-on-failure path added here would then no longer be needed.

>  
>  	rc = mchp_rds_ptp_init(clock);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		ptp_clock_unregister(clock->ptp_clock);

[Severity: Medium]
Does this leave phydev->mii_ts pointing at a timestamper whose ptp_clock
has just been freed? By the time mchp_rds_ptp_init() runs, the function
has already published:

	phydev->mii_ts = &clock->mii_ts;
	...
	phydev->default_timestamp = true;

This path resets neither of them. It also does not clear
clock->ptp_clock, even though ptp_clock_unregister() drops the final
reference and ptp_clock_release() frees the ptp_clock when no fd is open.
The caller then stores the ERR_PTR in priv->clock.

Because the caller is .config_init, the driver stays bound and the devm
clock behind phydev->mii_ts stays allocated. Before this patch, the stale
mii_ts pointed to a ptp_clock that was leaked but still valid. With the
patch, reaching the stale mii_ts makes mchp_rds_ptp_ts_info() read freed
memory:

	info->phc_index = ptp_clock_index(clock->ptp_clock);

One way to reach it is an ethtool get_ts_info that runs while
dev->phydev is set during the failing phy_attach_direct(). This is not
proven reachable, because ethtool and attach normally both run under
RTNL.

phy_is_default_hwtstamp() also stays true. A later attach can skip the
PTP probe, for example when PHY_F_NO_IRQ forces phydev->irq to PHY_POLL
(phy_detach_internal() does not restore irq for non-genphy drivers). If
that attach succeeds, lan887x_config_intr() does:

	if (phy_is_default_hwtstamp(phydev)) {
		return mchp_rds_ptp_top_config_intr(priv->clock,
		...

with the ERR_PTR in priv->clock, and mchp_rds_ptp_top_config_intr()
dereferences clock->phydev. That oops already existed before this patch.

For comparison, dp83640_probe() undoes this state on its error path:

	clock->ptp_clock = NULL;
	phydev->default_timestamp = false;
	phydev->mii_ts = NULL;

Could mchp_rds_ptp_init() run before ptp_clock_register(), with mii_ts
and default_timestamp published only on success? If not, should this
path reset phydev->mii_ts, phydev->default_timestamp and clock->ptp_clock?

[Severity: Low]
This isn't a bug introduced by this patch, but mchp_rds_ptp_init()
returns on the first failed MDIO write and leaves the PTP/TSU block
partly programmed. For example, writing MCHP_RDS_PTP_TSU_GEN_CFG_TSU_EN
to MCHP_RDS_PTP_TSU_GEN_CONFIG can succeed and the final
MCHP_RDS_PTP_CMD_CTL_EN write can then fail.

Should this error path also disable the TSU and PTP in hardware, rather
than only unregistering the software PHC?

>  		return ERR_PTR(rc);
> +	}
>  
>  	return clock;
>  }

[Severity: High]
On the success path, is the registered PHC ever unregistered? The only
user of this library is the LAN887X entry in microchip_t1_phy_driver[].
That entry has .probe and .config_init but no .remove. The library
exports no teardown helper, and phy_remove() only calls drv->remove when
a driver provides one.

The ptp_clock_info passed to ptp_clock_register() is &clock->caps.
clock is allocated with devm_kzalloc() on phydev->mdio.dev, and so is
caps.pin_config. Both are freed on unbind (sysfs unbind, rmmod of
microchip_t1, or removal of the MDIO bus or MAC). /dev/ptpN and its pin
sysfs files stay registered after that.

Could a later PHC call then do this?

ptp_clock_gettime()
  ptp->info->gettime64()   <-- info points into freed devm memory

That would load a function pointer from freed memory.

phydev->mii_ts also keeps pointing into the freed clock. A later ethtool
get_ts_info on a netdev that is still attached would read freed memory,
and so would phy_device_remove()->unregister_mii_timestamper() after a
sysfs unbind.

This is the same leak the commit message describes ("stays around
forever"). The message also says the change is "mirroring what the
remove callbacks of the other PTP capable PHY drivers do", but this
driver has no remove callback.

Does a complete fix need a teardown helper? It would unregister the PHC
and clear phydev->mii_ts and default_timestamp. It could be called from
both this error path and a new lan887x .remove, or registered as a devm
action.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103102900.1340854-1-vulab%40iscas.ac.cn
