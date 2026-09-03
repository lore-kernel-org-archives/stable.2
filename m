Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF112E7622;
	Thu,  3 Sep 2026 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403262; cv=none; b=Wnc2zn4S5qpXplEhy9tcy3L8Xx737Mu+At1fRQF+Sj7jMQ2s9bR57aYwHNn1sWnCU9ICU/saRbkvaLxPNrMt20N9EzabPSIRInNseTILoR9GGOeZuGXsGRj0s1sMa3V9G+97RJAIkb5vtoWYTH94aSd+poijfKVBSAVKyw26C7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403262; c=relaxed/simple;
	bh=gJ+5OHmwalQRPj0PFTrbr5rKjzhumhV93+UMbSmFAYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwSDQbcz9AZ4lt3yUJb1hMK8LDL029fxVuiHjvux/uAAsGs/aOqpNxlK4DMkPYSXMp5jjDaBqVMWWQ8Bw3Yd5HlhzuBMzcX8puminSkTVw1Sy38dqpkt+PrbvytZoNX6LYgxnOCcy9Up0rS4sZqiNOgPuubONGPCADZffc+fueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj5mG7NA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj5mG7NA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663FB1F000E9;
	Thu,  3 Sep 2026 02:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788403260;
	bh=uIPul49R2Fclph0FgWFNmp+obxjhTncsHWqiHMNoOFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lj5mG7NAmcchdADS1eKpG+Lg/2k2IfZFEOYqMEAW+7ChKxqazgS448WT01ug2lSMR
	 TW+cK+IDuMxIQLmwMUXuIqFAgKa0McowfvgR2vf19bsjB/So7uiqJswJqjBgYcm6ra
	 xbJye739Q67n/LkeiGAIKU3ZSRGezb5tCVn87NwztDJr48U2LF75+g+MifLz0DZvJI
	 BMKHSV78AjTLpgSBgAt8gBo2/5oaght9R4OgL3Z2j71Gru5/lvFb9WsC/NDRDLo8jG
	 K9sJpX/UKw4iHO+J7/Crr/z2gmR/o/3ZpMnXEhkfe20ftLS3ehw16W/q1OoPUZpclm
	 olxxn8DDEqbpA==
From: Jakub Kicinski <kuba@kernel.org>
To: ssvatenko@iit.org.ua
Cc: Jakub Kicinski <kuba@kernel.org>,
	Raju.Rangoju@amd.com,
	PrashanthKumar.K.R@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] amd-xgbe: fix comm_ownership mutex deadlock on SFP module removal
Date: Wed,  2 Sep 2026 19:40:59 -0700
Message-ID: <20260903024059.2957610-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828092023.105405-2-ssvatenko@iit.org.ua>
References: <20260828092023.105405-2-ssvatenko@iit.org.ua>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
amd-xgbe: fix comm_ownership mutex deadlock on SFP module removal

The patch stops xgbe_phy_sfp_read_eeprom() from freeing the external PHY
device and instead defers that to xgbe_phy_sfp_detect(), which now drops
xgbe_phy_comm_lock before calling xgbe_phy_sfp_mod_absent() or
xgbe_phy_free_phy_device() and re-acquires it only around
xgbe_phy_sfp_external_phy().  A couple of questions about the new
sequence below.

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index 59a074ed312a5..a264ec5bb0851 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c

[ ... ]

> @@ -1296,26 +1300,45 @@ static void xgbe_phy_sfp_detect(struct xgbe_prv_data *pdata)
>  	/* Read the SFP signals and check for module presence */
>  	xgbe_phy_sfp_signals(pdata);
>  	if (phy_data->sfp_mod_absent) {
> +		/* xgbe_phy_sfp_mod_absent() calls xgbe_phy_free_phy_device(),
> +		 * which can call back into this driver's MDIO read/write
> +		 * routines via phy_detach() -> phy_suspend(). Those routines
> +		 * take the comm ownership mutex themselves, so it must be
> +		 * released before making this call.
> +		 */
> +		xgbe_phy_put_comm_ownership(pdata);
>  		xgbe_phy_sfp_mod_absent(pdata);
> -		goto put;
> +		goto settings;
>  	}
>  
>  	ret = xgbe_phy_sfp_read_eeprom(pdata);
> +	xgbe_phy_put_comm_ownership(pdata);
>  	if (ret) {
>  		/* Treat any error as if there isn't an SFP plugged in */
>  		xgbe_phy_sfp_reset(phy_data);
>  		xgbe_phy_sfp_mod_absent(pdata);
> -		goto put;
> +		goto settings;
>  	}
>  
> +	/* Same reasoning as above: this must run without the comm
> +	 * ownership mutex held.
> +	 */
> +	if (phy_data->sfp_changed)
> +		xgbe_phy_free_phy_device(pdata);

[Severity: High]
Can freeing phy_data->phydev here race with the ethtool configuration
path and turn into a use-after-free write?

Before this patch the teardown could not actually complete from the
service work, because phy_detach() -> phy_suspend() -> genphy_suspend()
-> xgbe_phy_mii_read_c22() -> xgbe_phy_get_comm_ownership() deadlocked
on the mutex that was still held.  That is the hang this commit fixes.
With the mutex released, xgbe_phy_free_phy_device() now runs to
completion from:

xgbe_service()
  xgbe_phy_status()
    xgbe_phy_link_status()
      xgbe_phy_sfp_detect()
        xgbe_phy_sfp_mod_absent() / xgbe_phy_free_phy_device()

xgbe_service() holds neither RTNL nor pdata->an_mutex, and
xgbe_phy_free_phy_device() dereferences the shared pointer before
clearing it:

	if (phy_data->phydev) {
		phy_detach(phy_data->phydev);
		phy_device_remove(phy_data->phydev);
		phy_device_free(phy_data->phydev);
		phy_data->phydev = NULL;
	}

Meanwhile ethtool -s / ethtool -A enter xgbe_set_link_ksettings() /
xgbe_set_pauseparam() under only "if (netif_running(netdev))", then
__xgbe_phy_config_aneg() (which takes pdata->an_mutex only) calls
xgbe_phy_an_config():

	if (!phy_data->phydev)
		return 0;

	phy_data->phydev->autoneg = pdata->phy.autoneg;
	linkmode_and(phy_data->phydev->advertising, ...);
	...
	ret = phy_start_aneg(phy_data->phydev);

The freeing path holds no lock the consumer path takes, so can the
phy_device be freed between that NULL check and the writes?  The same
window looks present for phy_init_hw(phy_data->phydev) and the
phy_data->phydev dereferences in xgbe_phy_phydev_flowctrl().  Neither
ethtool entry point flushes or cancels pdata->service_work; only
xgbe_stop() does that, which is why the existing free in
xgbe_phy_stop() is safe.

Also, phy_detach() uses rtnl_dereference(dev->hwprov) and calls
phy_link_topo_del_phy(), so it expects RTNL to be held.  Should the
teardown be moved into a context that holds RTNL or an_mutex, or be
serialized against the phydev consumers some other way?

>  	xgbe_phy_sfp_parse_eeprom(pdata);
>  
> -	xgbe_phy_sfp_external_phy(pdata);
> +	/* Re-acquire ownership for the external PHY access below; it talks
> +	 * to the SFP over I2C directly and needs the mutex held again.
> +	 */
> +	ret = xgbe_phy_get_comm_ownership(pdata);
> +	if (!ret) {
> +		xgbe_phy_sfp_external_phy(pdata);
> +		xgbe_phy_put_comm_ownership(pdata);
> +	}

[Severity: Medium]
What happens to phy_data->sfp_phy_avail when this second
xgbe_phy_get_comm_ownership() fails?

xgbe_phy_get_comm_ownership() can return -ETIMEDOUT after polling
XP_I2C_MUTEX / XP_MDIO_MUTEX for five seconds and printing "unable to
obtain hardware mutexes".  There is no else branch here, so the failure
is neither propagated nor reflected in driver state.

By this point the "SFP changed" edge has already been consumed:
xgbe_phy_sfp_read_eeprom() set phy_data->sfp_changed = 1 and copied the
new image into phy_data->sfp_eeprom, xgbe_phy_free_phy_device() already
cleared phy_data->phydev, and xgbe_phy_sfp_parse_eeprom() reprogrammed
sfp_base/sfp_speed.

xgbe_phy_sfp_external_phy() is the only writer of sfp_phy_avail and
self-disables on the next poll:

	if (!phy_data->sfp_changed)
		return;

	phy_data->sfp_phy_avail = 0;
	...
	ret = xgbe_phy_i2c_mii_read(pdata, MII_BMCR);
	if (ret < 0)
		return;

	phy_data->sfp_phy_avail = 1;

On the following service poll the EEPROM compares equal, sfp_changed
becomes 0, and this function returns immediately, so does sfp_phy_avail
keep the value computed for the previous module until the module is
physically re-plugged?

The consumer xgbe_phy_find_phy_device() gates on that flag:

	if ((phy_data->port_mode == XGBE_PORT_MODE_SFP) &&
	    !phy_data->sfp_phy_avail)
		return 0;

so a stale 1 after a copper-to-fiber swap would make get_phy_device()
fail and return -ENODEV up through xgbe_phy_an_config() ->
__xgbe_phy_config_aneg() -> xgbe_phy_start(), and a stale 0 for a newly
inserted 1000BASE-T module would leave its internal PHY unattached even
though xgbe_phy_sfp_phy_settings() just advertised 10/100/1000baseT.
xgbe_phy_link_status() sets *an_restart = 1 whenever sfp_changed is
set, so xgbe_phy_config_aneg() acts on the stale flag right away.

Before this patch a mutex timeout aborted xgbe_phy_sfp_detect() with all
bookkeeping untouched and the next poll re-ran the whole sequence.  Would
it make sense to handle this like the read_eeprom error path does, i.e.
xgbe_phy_sfp_reset() plus xgbe_phy_sfp_mod_absent(), or otherwise avoid
committing sfp_eeprom/sfp_changed before the probe can be retried?  The
commit message does not mention this new failure path.

>  
> -put:
> +settings:
>  	xgbe_phy_sfp_phy_settings(pdata);
> -
> -	xgbe_phy_put_comm_ownership(pdata);
>  }

Both observations are still present at the end of the series, since the
following patch touches only xgbe-mdio.c.
-- 
pw-bot: cr
