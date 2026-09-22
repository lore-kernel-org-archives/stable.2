Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938F2EDD53;
	Tue, 22 Sep 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087969; cv=none; b=IewYPJzDObDmJNx/iq3fpasvBkWTPn+uLfyaYRYz6wCL1lYkmf8nAajiKYraQpu/iwfym5CHcV3RVqbAyEBIAkf0v8fyZwqXTK/JTRSXv2ye0g29rswg6MHvN9AJa6sFFxkLKYaexwfal24gFhcGuBxlDYG/Qo4vD/4nOO+cIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087969; c=relaxed/simple;
	bh=2himPEiD7IVYGNC3CLMnnOHkE7F7Dm5FFXDc3XL8nyM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYkzSKZ5Z1gqTywVPh32xiPlwnA4tFekFDATizZeHKaOyFndHlYbuxL/qlqdds3OObutUZB/IbvOeqwkUWX6XoyjoHV7lgZraymJx0wGB5RjDyF/DUAZ+rS1AjwkoBR7gV8wZ1Z8a8JluTalqD9o1NZub1UNQv69Ej/b0ld8XHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORXj95pv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORXj95pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B421F00893;
	Tue, 22 Sep 2026 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790087967;
	bh=ccZLMV8/rmUwkGGZvkXAW2bLKoxzbXksggeNpDhRe8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ORXj95pv7KOyMc3pNi5vvtVRnNz30v2+nysQigo/AYP8xeLMMY9RwFfwqy+rbEE8h
	 m7c7zkyvWXG/wscdLO9kY1jhO/acCeltEGrelkTcv+PszsWRNuAoJpn2Bc6Jk2jkKK
	 FFYNJYztZkuRWd8Tj1GMevcG6qZnFvkSdJo4tqrGVKOSX7QbQp1qrBI0HrFbv3YU/y
	 o1gVEtBI6pwO4KdwDeU3D1a/G05k9SQfooO/lN98Ahlo5XyQ7n/2Ss7cNMzpee0Tw8
	 afFBFOBKWQDtf5TvI9jN0MELb/ei2HdsYlvRIcwjnAm6LgTQDNTcB8a8DLRbZ/rV9A
	 gsb0aL+mDCf9g==
Subject: Re: [PATCH v2] amd-xgbe: fix comm_ownership mutex deadlock on SFP
 module removal
From: netdev-bot+sashiko@kernel.org
To: ssvatenko@iit.org.ua
Cc: kuba@kernel.org, PrashanthKumar.K.R@amd.com, Raju.Rangoju@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 stable@vger.kernel.org, noreply@anthropic.com
Date: Tue, 22 Sep 2026 14:39:25 +0000
Message-ID: <179008796590.2160803.4060604455111749767@kernel.org>
In-Reply-To: <20260918142238.191589-1-ssvatenko@iit.org.ua>
References: <20260918142238.191589-1-ssvatenko@iit.org.ua>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The deferred external-PHY teardown introduced by this patch is
  silently and permanently lost when rtnl_trylock() fails.
- [High] The documented precondition that justifies rtnl_trylock() is
  factually wrong.
- [High] xgbe_phy_sfp_mod_absent_safe() (xgbe-phy-v2.c:1297-1305) skips
  the whole module-absent bookkeeping when rtnl_trylock() fails, yet…

--

amd-xgbe: fix comm_ownership mutex deadlock on SFP module removal

This moves the external PHY teardown out from under xgbe_phy_comm_lock so
that phy_detach() can no longer re-enter the driver's MDIO callbacks and
deadlock on the same non-recursive mutex.  The teardown is now done from
two new helpers that take RTNL with rtnl_trylock() before calling
xgbe_phy_sfp_mod_absent() / xgbe_phy_free_phy_device().

A few questions about the new trylock-based teardown below.

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index 59a074ed312a..8c625a0340c4 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c

[ ... ]

> @@ -1218,7 +1219,13 @@ static int xgbe_phy_sfp_read_eeprom(struct xgbe_prv_data *pdata)
>  		goto put;
>  	}
>  
> -	/* Check for an added or changed SFP */
> +	/* Check for an added or changed SFP. Freeing any existing external
> +	 * PHY device is deferred to the caller: xgbe_phy_free_phy_device()
> +	 * can end up calling back into this driver's MDIO read/write
> +	 * routines (via phy_detach() -> phy_suspend()), which take the
> +	 * comm ownership mutex themselves, and that mutex is held across
> +	 * this call.
> +	 */
>  	if (memcmp(&phy_data->sfp_eeprom, &sfp_eeprom, sizeof(sfp_eeprom))) {
>  		phy_data->sfp_changed = 1;
>  
> @@ -1226,8 +1233,6 @@ static int xgbe_phy_sfp_read_eeprom(struct xgbe_prv_data *pdata)
>  			xgbe_phy_sfp_eeprom_info(pdata, &sfp_eeprom);
>  
>  		memcpy(&phy_data->sfp_eeprom, &sfp_eeprom, sizeof(sfp_eeprom));
> -
> -		xgbe_phy_free_phy_device(pdata);
>  	} else {
>  		phy_data->sfp_changed = 0;
>  	}

Note for the comment below: this memcpy() commits the new module's EEPROM
into phy_data->sfp_eeprom in the very same pass that sets sfp_changed = 1,
so the "changed" condition is consumed here and cannot be re-derived on a
later poll.

> @@ -1268,9 +1273,47 @@ static void xgbe_phy_sfp_mod_absent(struct xgbe_prv_data *pdata)
>  
>  	phy_data->sfp_mod_absent = 1;
>  	phy_data->sfp_phy_avail = 0;
> +	phy_data->sfp_changed = 0;
>  	memset(&phy_data->sfp_eeprom, 0, sizeof(phy_data->sfp_eeprom));
>  }
>  
> +/* phy_detach()/phy_device_remove(), called from xgbe_phy_free_phy_device()
> + * below, require RTNL to be held by the caller (phy_detach() itself uses
> + * rtnl_dereference() and phy_link_topo_del_phy()). The callers below run
> + * from the service workqueue with no lock held, so a plain rtnl_lock()
> + * cannot be used here: xgbe_stopdev() (system workqueue) takes rtnl_lock()

[Severity: High]
Is the statement "The callers below run from the service workqueue with no
lock held" accurate?  xgbe_phy_sfp_detect() has a second caller,
xgbe_phy_start() (phy_impl.start), which runs with RTNL already held by the
current task:

  xgbe_open()            (ndo_open, RTNL taken by the netdev core)
  xgbe_restart()         (rtnl_lock() before xgbe_restart_dev())
  xgbe_change_mtu()      -> xgbe_restart_dev()
    xgbe_start()
      pdata->phy_if.phy_impl.start()
        xgbe_phy_start()
          xgbe_phy_sfp_detect()

rtnl_trylock() is mutex_trylock(&rtnl_mutex), and mutex_trylock() fails when
the current task already owns the mutex.  So on the ifup / restart / MTU
change path, don't both new helpers become deterministic no-ops?

That drops more than the RTNL-requiring phy_detach(): all of
xgbe_phy_sfp_mod_absent()'s pure software bookkeeping (sfp_phy_avail = 0,
sfp_changed = 0, and the memset of sfp_eeprom above) needs no lock at all,
yet it is now only reachable through the trylock wrapper.

Would it make sense to split the RTNL-requiring free from the software state
reset that must always run, and handle the caller-already-holds-RTNL case
explicitly?

> + * and then calls flush_workqueue(pdata->dev_workqueue) inside xgbe_stop(),
> + * which would block waiting for this very (dev_workqueue) work item to
> + * finish - while it is blocked waiting to reacquire RTNL from
> + * xgbe_stopdev(). That is an ABBA deadlock, the same class of bug this
> + * driver just fixed elsewhere.
> + *
> + * Use a non-blocking rtnl_trylock() instead: on contention, skip the
> + * teardown for this poll and let the next service poll (100ms-1s later)
> + * retry it. If the interface is going down concurrently, xgbe_phy_stop()
> + * (phy_impl.stop) frees the PHY itself, under RTNL already held by its
> + * own caller - so nothing is lost by skipping here.
> + */
> +static void xgbe_phy_sfp_mod_absent_safe(struct xgbe_prv_data *pdata)
> +{
> +	if (!rtnl_trylock())
> +		return;
> +
> +	xgbe_phy_sfp_mod_absent(pdata);
> +
> +	rtnl_unlock();
> +}

[Severity: High]
When the trylock loses here, the whole module-absent transition is skipped,
but xgbe_phy_sfp_detect() still falls through to xgbe_phy_sfp_phy_settings()
as though it had been committed.  Can that wedge the port?

xgbe_phy_sfp_mod_absent() is the only place that zeroes phy_data->sfp_eeprom
and clears sfp_phy_avail/sfp_changed; xgbe_phy_sfp_reset() does not touch
sfp_eeprom:

  static void xgbe_phy_sfp_reset(struct xgbe_phy_data *phy_data)
  {
	phy_data->sfp_rx_los = 0;
	phy_data->sfp_tx_fault = 0;
	phy_data->sfp_mod_absent = 1;
	phy_data->sfp_base = XGBE_SFP_BASE_UNKNOWN;
	...
  }

So after a removal where the trylock failed, the old EEPROM stays cached.
If the module is re-inserted before a later poll wins the trylock,
xgbe_phy_sfp_read_eeprom() compares against that never-zeroed cache, finds
it identical and takes the else branch:

	} else {
		phy_data->sfp_changed = 0;
	}

and from then on xgbe_phy_sfp_external_phy() early-returns:

	if (!phy_data->sfp_changed)
		return;

so sfp_phy_avail is never re-validated, xgbe_phy_find_phy_device() returns 0
on the "!sfp_phy_avail" check, and xgbe_phy_sfp_phy_settings() early-returns
too:

	if (!phy_data->sfp_mod_absent && !phy_data->sfp_changed)
		return;

leaving pdata->phy.lks stuck in the absent-module capability set published
during the removal.  Does the port then stay unlinkable until an ifdown/ifup
or a physical re-seat?

The same loss applies to the new comm-ownership fallback added further down,
which calls this helper to "fall back to no module": if the trylock fails
there, sfp_changed stays 1 and sfp_eeprom stays committed to the new module,
which is exactly the half-initialized state that branch is meant to prevent.

> +
> +static void xgbe_phy_free_phy_device_safe(struct xgbe_prv_data *pdata)
> +{
> +	if (!rtnl_trylock())
> +		return;
> +
> +	xgbe_phy_free_phy_device(pdata);
> +
> +	rtnl_unlock();
> +}
> +
>  static void xgbe_phy_sfp_reset(struct xgbe_phy_data *phy_data)
>  {
>  	phy_data->sfp_rx_los = 0;

[ ... ]

> @@ -1296,26 +1339,55 @@ static void xgbe_phy_sfp_detect(struct xgbe_prv_data *pdata)
>  	/* Read the SFP signals and check for module presence */
>  	xgbe_phy_sfp_signals(pdata);
>  	if (phy_data->sfp_mod_absent) {
> -		xgbe_phy_sfp_mod_absent(pdata);
> -		goto put;
> +		/* xgbe_phy_sfp_mod_absent() calls xgbe_phy_free_phy_device(),
> +		 * which can call back into this driver's MDIO read/write
> +		 * routines via phy_detach() -> phy_suspend(). Those routines
> +		 * take the comm ownership mutex themselves, so it must be
> +		 * released before making this call.
> +		 */
> +		xgbe_phy_put_comm_ownership(pdata);
> +		xgbe_phy_sfp_mod_absent_safe(pdata);
> +		goto settings;
>  	}
>  
>  	ret = xgbe_phy_sfp_read_eeprom(pdata);
> +	xgbe_phy_put_comm_ownership(pdata);
>  	if (ret) {
>  		/* Treat any error as if there isn't an SFP plugged in */
>  		xgbe_phy_sfp_reset(phy_data);
> -		xgbe_phy_sfp_mod_absent(pdata);
> -		goto put;
> +		xgbe_phy_sfp_mod_absent_safe(pdata);
> +		goto settings;
>  	}
>  
> +	/* Same reasoning as above: this must run without the comm
> +	 * ownership mutex held.
> +	 */
> +	if (phy_data->sfp_changed)
> +		xgbe_phy_free_phy_device_safe(pdata);

[Severity: High]
Is the deferred free lost for good when rtnl_trylock() fails here?  The
commit message says:

  "on contention, skip the teardown for this poll and let the
   next service poll (100ms-1s later) retry it"

but nothing appears to record that the teardown is still pending.  The only
condition that reaches this call is sfp_changed, and
xgbe_phy_sfp_read_eeprom() already wrote the new EEPROM into
phy_data->sfp_eeprom in the same pass that set sfp_changed = 1, so the next
poll sees an identical memcmp() and sets sfp_changed = 0.

After that:

  - xgbe_phy_free_phy_device_safe() is never called again
  - xgbe_phy_sfp_external_phy() returns early on "if (!phy_data->sfp_changed)"
    so sfp_phy_avail is never re-evaluated
  - xgbe_phy_find_phy_device() returns immediately:

	/* If we already have a PHY, just return */
	if (phy_data->phydev)
		return 0;

and xgbe_phy_link_status() keeps gating link-up on the stale phy_device:

	if (phy_data->phydev) {
		ret = phy_read_status(phy_data->phydev);
		if (ret < 0)
			return 0;

Since RTNL is global, doesn't any concurrent ip/ethtool/netlink operation on
any interface in the system make the trylock fail for the one poll in which
the change is observed?  Would it be better to commit sfp_eeprom only after
a successful teardown, or to keep a sticky "needs free / needs reprobe" flag
so the next poll can genuinely retry?

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
> +	} else {
> +		/* Could not finish bringing up the new module: sfp_changed,
> +		 * sfp_eeprom and sfp_base/sfp_speed were already updated
> +		 * above for it, but external_phy() (and thus sfp_phy_avail)
> +		 * never ran. Fall back to "no module" state instead of
> +		 * committing to a half-initialized one - same pattern as
> +		 * the read_eeprom() failure path above.
> +		 */
> +		xgbe_phy_sfp_reset(phy_data);
> +		xgbe_phy_sfp_mod_absent_safe(pdata);
> +	}
>  
> -put:
> +settings:
>  	xgbe_phy_sfp_phy_settings(pdata);
> -
> -	xgbe_phy_put_comm_ownership(pdata);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918142238.191589-1-ssvatenko%40iit.org.ua
