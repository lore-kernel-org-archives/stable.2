Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008688;
	b=tIqy6Y9oi5QPCdwMzUYJZ6V9srw4xZp9rUUgf0NxHpZ+QdMEHR2CZxNddxlixa6XEMOP
	 GutXEXDrTQJ7CYorX6cXaltyjhnIJthSwst31OFGuQsgdQKWrB3r/qiiy2k9cNoHe0o9u
	 5pAEp5Xqs/yOpEq2JUiF3yGPyDHOjZ7fROEtQNpgyNYX6ZwlY2kaygp1Uxsld9ujdobxV
	 miTH2LTNi30rfhYDtS/R5eEW+DUWkb+ub3P95GMjKOfSUdPL0Tm/hCUS4n1KZY5YhwRE+
	 +1CPTRtSkupjFM5IZkpuhxXJWNJ2fMeLSPDzL3s0AqGh8+fNuX1oREuEa6ICn/w8jcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008688;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QpZpC1O18TBX4KqjeqZ571d36hlitpykAr1EFcL90gw=;
	b=b13OPhYox+x57q6utlR3GXYEmlcAMXlm6BDX17TI571UUGBrY1FPNX/KxMuZQ6Y9PMPm
	 dAipokw0/2+ajrXjN7y04NY5L07SRgkpl8dRuF5DlnmnI0oY8k/T1hp/Npx1ZTNO8f0ek
	 fRrtB17GsZ52DBotiC3AX/r+cghugiKsSIpE4cQFsPcVFb/3iviaZqmBWzvsLl8jcaDQA
	 5XpF5mKiQTyaY4bbukXWrU40MQu1A1ns7AwYAk/VPFWYIq5j5E4+Vzqyfo7Mz35uCsTGO
	 OAqegR9ZSuTwZrJ/S2UcZE3WwELkIb0LJXZeCFtcx8Ru5RgKUdxhSHEuQ2AL6Yp6mAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UNd9IZhJ;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC2606CF89;
	Mon, 26 Oct 2026 09:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAEC2606CF89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UNd9IZhJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793008688; x=1824544688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40x+2VGzkZ2eFHl8AUtRrzfKo/eNc9LEpQUYRwDDVd0=;
  b=UNd9IZhJfU+FWTkGbTKa6hJj7njgqIrONLqs/i2BktRNa8H2/5BgI9Ax
   HnjD/M+b420csh9oScJFhmQ3ACcRfrBVG2dobwYOVd24Ns+z1jc6qSosC
   Y0kTp/CMEIV46MGvwwkiPssd37CB0S/lFAlCeDm9ceAzsQXg6K7/Mu+mF
   zgrxQ5RIC43xLpk4G8LaukjcMvp1UROwYXJTm7wn2sK53ZBIGz3r5lHg0
   W77fbN9mF7g+DgCJVsfpVpuQL8W5DxeDK4gWDoBBUw7H4k41w1wHnZ3Ly
   2gjL1fQMNuDyNYmiBwFGII31gErqvhyKo35xXsUwUIQJMU3BVibaar1TF
   A==;
X-CSE-ConnectionGUID: n1HRvaPLRl+1qkHwW9NI+w==
X-CSE-MsgGUID: pDOlQl9vQm65Eswz546mLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1696880"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1696880"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:58:07 -0700
X-CSE-ConnectionGUID: FVYmi1jtQX2eeAqYe+WfIA==
X-CSE-MsgGUID: Z08vYvfrQJqzGTcf5V3G+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4627247"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 26 Oct 2026 02:58:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 244FC99; Mon, 26 Oct 2026 10:58:04 +0100 (CET)
Date: Mon, 26 Oct 2026 10:58:04 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: David Vornholt <dv@etik.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Vornholt <david@vornholt.online>, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Stop a power level change
 notification storm
Message-ID: <at8kLPzAnJAfZRjF@black.igk.intel.com>
References: <20261010183917.146821-1-dv@etik.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010183917.146821-1-dv@etik.com>

Hi David,

On Sat, Oct 10, 2026 at 08:39:17PM +0200, David Vornholt wrote:
> From: David Vornholt <david@vornholt.online>
> 
> On a Lenovo ThinkPad X1 Carbon Gen 13 (BIOS N4BET78W 1.48, EC N4BHT61W
> 1.41, UCSI 1.0) with an HP E273m monitor connected, the PPM keeps
> signaling a Negotiated Power Level Change although the power contract
> stays the same, and signals it again right after it has been
> acknowledged:
> 
>   ucsi_connector_change: port1 status: change=0040, opmode=3,
>     connected=1, sourcing=0, partner_flags=2, partner_type=4,
>     request_data_obj=1304b12c, BC status=2

Okay, so the PPM really should not report the power level changes
since there are not power level changes, right? Have you reported this
to Lenovo?

> This repeats about seven times a second for as long as the monitor stays
> connected. Since commit a0d4618788f2 ("usb: typec: ucsi: Workaround for
> missed op_mode change"), every Negotiated Power Level Change is handled
> like a power operation mode change, so the driver reads the source PDOs
> again, checks the alternate modes and the connector capability, and
> registers the partner's PDOs again each time. Every UCSI command takes
> about 50 ms of EC transactions on this machine. The EC GPE fires about
> 680 times a second, and irq/9-acpi and the kworkers keep a CPU busy.
> Skipping that work for an unchanged contract only brings the rate down
> to about 360 a second, because the PPM still signals every change and
> the driver still reads the connector status and acknowledges it.
> 
> Keep handling the notification as before when the power operation mode
> or the RDO changed, which the workaround for Dell's firmware relies on,
> or when the source PDOs changed with it. Once the PPM has signaled it
> ten times in a row with the same PD contract, each within a second of
> the previous one and without a power operation mode change, disable the
> notification with SET_NOTIFICATION_ENABLE and log it, and enable it
> again when the partner on that connector is gone. The mask applies to
> all connectors, so until then a contract change on another connector is
> only handled with the next connector change that it does signal. This
> PPM still reports the bit in the connector status change field. If the
> PPM signals the notification while it is disabled, ignore it for an
> unchanged contract, and send the mask again after another ten.
> 
> Resume and the reset after a timed-out role swap send ucsi->ntfy to the
> PPM too. Update ucsi->ntfy and send it in one helper that holds
> ppm_lock, so that none of them can send an outdated mask after another
> one has changed it. Keep the new mask, and enable the notification again
> later, even if the command fails, as the PPM may have applied it anyway.
> Once ucsi_unregister() has disabled the notifications, don't send a mask
> anymore.
> 
> Also forget the RDO when the partner goes away, so that the first
> contract with the next partner counts as a new one.
> 
> With this, the PPM signals ten changes after the monitor is connected,
> the driver disables the notification and the GPE rate drops to zero.
> The ports, the partner and its 5 V/3 A power supply stay registered.
> 
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Vornholt <david@vornholt.online>
> ---
> 
> Notes:
>     Changes in v2:
>     - Enable the notification again when the partner on the connector that
>       it was disabled for goes away, instead of leaving it disabled until
>       the driver is unbound (Sashiko review).
>     - Update ucsi->ntfy and send it to the PPM in one helper that holds
>       ppm_lock, and use it on resume and in the reset path of
>       ucsi_role_cmd() too, so that they can't send an outdated mask
>       (Sashiko review).
>     - No longer decide from ucsi->ntfy whether to ignore the notification.
>       While it is disabled, ignore it for an unchanged contract, and send
>       the mask again after another ten.
>     - Keep the new mask, and enable the notification again later, even if
>       SET_NOTIFICATION_ENABLE fails, and don't send a mask anymore once
>       ucsi_unregister() has disabled the notifications (Codex review).
>     - Start counting again after a power operation mode change, and don't
>       count a power level change that comes with a source PDO change
>       (Codex review).
>     - v1: https://lore.kernel.org/r/20261010121026.84844-1-dv@etik.com
>     
>     Claude Code, an AI coding assistant, found the cause while I was looking
>     into why irq/9-acpi kept a CPU busy, and wrote this patch and its
>     description. Codex with GPT-6 Astra reviewed v2 before I sent it, and
>     this version addresses its findings.
>     
>     Tested: v1 ported to v7.2.9 on the X1 Carbon Gen 13 with the HP E273m.
>     The ucsi trace events show ten connector changes about 100 ms apart,
>     one SET_NOTIFICATION_ENABLE and the warning, and no connector changes
>     after that. GPE 0x6E went from about 680/s to 0/s.
>     
>     This version, ported to v7.2.9 on the same machine, with the monitor on
>     the other port (con1): after the monitor is plugged in, the PPM signals
>     the power level change about every 5 s, which doesn't count, and after
>     about 50 s every 110 ms. After ten of those, the warning appears and
>     SET_NOTIFICATION_ENABLE is sent once. The PPM still signals a power
>     level change about every 5 to 15 s for another 45 s, which the driver
>     ignores (no GET_PDOS), and then stops. GPE 0x6E goes to about 1/s.
>     Unplugging the monitor sends SET_NOTIFICATION_ENABLE again, and after
>     plugging it back in, the next storm is caught the same way. I did that
>     twice.
>     
>     Against usb-linus, this version is only compile-tested (x86_64 defconfig
>     with TYPEC_UCSI=m and UCSI_ACPI=m, W=1) and passes checkpatch --strict.
>     
>     Not tested: this version on con2; other PPMs, in particular Dell's that
>     rely on a0d4618788f2; other partners on this laptop; suspend and resume
>     with the notification disabled; the reset path of ucsi_role_cmd(); a
>     failing SET_NOTIFICATION_ENABLE; unbinding while connector work runs;
>     sparse (the version available to me was too old).
>     
>     If enabling the notification again fails, it's only retried when the
>     next partner on that connector goes away, or sent again on resume.
>     
>     The patch applies as-is from v7.2 on. Older stable trees need a
>     backport, in particular for the ucsi_run_command() call in
>     ucsi_update_notifications().

This problem may only affect your system, so we really have to isolate
it somehow. I'm almost certain that like this there will be problems
on some other systems.

Something that I did not quite understand from the above is, if you
revert commit a0d4618788f2, do you still have a problem (I understand
that you still get the repeated notifications, but do they cause other
problems then)?

Thanks,

>  drivers/usb/typec/ucsi/ucsi.c | 119 +++++++++++++++++++++++++++++++---
>  drivers/usb/typec/ucsi/ucsi.h |   5 ++
>  2 files changed, 115 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index c1450639c..0d543f777 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -274,6 +274,37 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
>  }
>  EXPORT_SYMBOL_GPL(ucsi_send_command);
>  
> +/*
> + * Update the notification enable mask and send it to the PPM. Holding ppm_lock
> + * across both keeps ucsi->ntfy the mask that the PPM was sent last. Keep it
> + * even if the command fails, as the PPM may have applied the mask anyway.
> + */
> +static int ucsi_update_notifications(struct ucsi *ucsi, u64 clear, u64 set)
> +{
> +	u64 command;
> +	u32 cci;
> +	int ret;
> +
> +	mutex_lock(&ucsi->ppm_lock);
> +
> +	if (ucsi->unregistering) {
> +		ret = -ESHUTDOWN;
> +		goto out_unlock;
> +	}
> +
> +	ucsi->ntfy = (ucsi->ntfy & ~clear) | set;
> +	command = UCSI_SET_NOTIFICATION_ENABLE | ucsi->ntfy;
> +	ret = ucsi_run_command(ucsi, command, &cci, NULL, 0, NULL, 0, false);
> +	if (cci & UCSI_CCI_ERROR)
> +		ret = ucsi_read_error(ucsi, 0);
> +
> +	trace_ucsi_run_command(command, ret);
> +
> +out_unlock:
> +	mutex_unlock(&ucsi->ppm_lock);
> +	return ret;
> +}
> +
>  int ucsi_write_message_out_command(struct ucsi *ucsi, u64 command,
>  				   void *data, size_t size, void *msg_out,
>  				   size_t msg_out_size)
> @@ -1254,6 +1285,68 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>  	}
>  }
>  
> +/*
> + * Some PPMs keep signaling a Negotiated Power Level Change although the power
> + * contract stays the same, and signal it again as soon as it has been
> + * acknowledged, so the PPM and the driver keep each other busy for as long as
> + * the partner stays connected. Disable the notification once the PPM has
> + * signaled it this many times in a row, each within a second of the previous
> + * one, without a new contract, and enable it again when the partner is gone.
> + * The notification can only be disabled for all connectors at once. A change
> + * of the source PDOs can come with an unchanged RDO, so it doesn't count.
> + */
> +#define UCSI_PWR_LEVEL_UNCHANGED_MAX	10
> +
> +static void ucsi_pwr_level_change(struct ucsi_connector *con)
> +{
> +	struct ucsi *ucsi = con->ucsi;
> +
> +	if (UCSI_CONSTAT(con, PWR_OPMODE) != UCSI_CONSTAT_PWR_OPMODE_PD ||
> +	    UCSI_CONSTAT(con, RDO) != con->rdo ||
> +	    (UCSI_CONSTAT(con, CHANGE) & UCSI_CONSTAT_PDOS_CHANGE)) {
> +		con->pwr_level_unchanged = 0;
> +		ucsi_pwr_opmode_change(con);
> +		return;
> +	}
> +
> +	if (time_after(jiffies, con->pwr_level_change_time + HZ))
> +		con->pwr_level_unchanged = 0;
> +	con->pwr_level_change_time = jiffies;
> +
> +	if (++con->pwr_level_unchanged < UCSI_PWR_LEVEL_UNCHANGED_MAX) {
> +		/* Signaled before the notification was disabled, or despite it */
> +		if (!con->pwr_level_ntfy_disabled)
> +			ucsi_pwr_opmode_change(con);
> +		return;
> +	}
> +
> +	/*
> +	 * Enable it again when the partner is gone even if the command fails,
> +	 * as the PPM may have disabled it anyway.
> +	 */
> +	if (!con->pwr_level_ntfy_disabled) {
> +		con->pwr_level_ntfy_disabled = true;
> +		dev_warn(ucsi->dev,
> +			 "con%d: Firmware bug: power level changes without a new contract, disabling the notification\n",
> +			 con->num);
> +	}
> +
> +	if (ucsi_update_notifications(ucsi, UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE, 0) >= 0)
> +		con->pwr_level_unchanged = 0;
> +}
> +
> +/* The partner that the notification was disabled for is gone */
> +static void ucsi_pwr_level_ntfy_restore(struct ucsi_connector *con)
> +{
> +	if (!con->pwr_level_ntfy_disabled)
> +		return;
> +
> +	if (ucsi_update_notifications(con->ucsi, 0, UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE) < 0)
> +		return;
> +
> +	con->pwr_level_ntfy_disabled = false;
> +}
> +
>  static int ucsi_register_partner(struct ucsi_connector *con)
>  {
>  	u8 pwr_opmode = UCSI_CONSTAT(con, PWR_OPMODE);
> @@ -1324,6 +1417,8 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
>  	typec_unregister_partner(con->partner);
>  	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
>  	con->partner = NULL;
> +	con->rdo = 0;
> +	con->pwr_level_unchanged = 0;
>  }
>  
>  static void ucsi_partner_change(struct ucsi_connector *con)
> @@ -1400,6 +1495,7 @@ static int ucsi_check_connection(struct ucsi_connector *con)
>  		ucsi_partner_change(con);
>  		ucsi_port_psy_changed(con);
>  		ucsi_unregister_partner(con);
> +		ucsi_pwr_level_ntfy_restore(con);
>  	}
>  
>  	return 0;
> @@ -1511,11 +1607,16 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  			}
>  		} else {
>  			ucsi_unregister_partner(con);
> +			ucsi_pwr_level_ntfy_restore(con);
>  		}
>  	}
>  
> -	if (change & (UCSI_CONSTAT_POWER_OPMODE_CHANGE | UCSI_CONSTAT_POWER_LEVEL_CHANGE))
> +	if (change & UCSI_CONSTAT_POWER_OPMODE_CHANGE) {
> +		con->pwr_level_unchanged = 0;
>  		ucsi_pwr_opmode_change(con);
> +	} else if (change & UCSI_CONSTAT_POWER_LEVEL_CHANGE) {
> +		ucsi_pwr_level_change(con);
> +	}
>  
>  	if (con->partner && (change & UCSI_CONSTAT_PARTNER_CHANGE)) {
>  		ucsi_partner_change(con);
> @@ -1685,13 +1786,10 @@ static int ucsi_role_cmd(struct ucsi_connector *con, u64 command)
>  
>  	ret = ucsi_send_command(con->ucsi, command, NULL, 0);
>  	if (ret == -ETIMEDOUT) {
> -		u64 c;
> -
>  		/* PPM most likely stopped responding. Resetting everything. */
>  		ucsi_reset_ppm(con->ucsi);
>  
> -		c = UCSI_SET_NOTIFICATION_ENABLE | con->ucsi->ntfy;
> -		ucsi_send_command(con->ucsi, c, NULL, 0);
> +		ucsi_update_notifications(con->ucsi, 0, 0);
>  
>  		ucsi_reset_connector(con, true);
>  	}
> @@ -2171,12 +2269,10 @@ static void ucsi_resume_work(struct work_struct *work)
>  {
>  	struct ucsi *ucsi = container_of(work, struct ucsi, resume_work);
>  	struct ucsi_connector *con;
> -	u64 command;
>  	int ret;
>  
>  	/* Restore UCSI notification enable mask after system resume */
> -	command = UCSI_SET_NOTIFICATION_ENABLE | ucsi->ntfy;
> -	ret = ucsi_send_command(ucsi, command, NULL, 0);
> +	ret = ucsi_update_notifications(ucsi, 0, 0);
>  	if (ret < 0) {
>  		dev_err(ucsi->dev, "failed to re-enable notifications (%d)\n", ret);
>  		return;
> @@ -2347,6 +2443,8 @@ int ucsi_register(struct ucsi *ucsi)
>  	if (!ucsi->version)
>  		return -ENODEV;
>  
> +	ucsi->unregistering = false;
> +
>  	/*
>  	 * Version format is JJ.M.N (JJ = Major version, M = Minor version,
>  	 * N = sub-minor version).
> @@ -2380,7 +2478,10 @@ void ucsi_unregister(struct ucsi *ucsi)
>  
>  	ucsi_debugfs_unregister(ucsi);
>  
> -	/* Disable notifications */
> +	/* Disable notifications, and keep connector work from enabling them */
> +	mutex_lock(&ucsi->ppm_lock);
> +	ucsi->unregistering = true;
> +	mutex_unlock(&ucsi->ppm_lock);
>  	ucsi->ops->async_control(ucsi, cmd);
>  
>  	if (!ucsi->connector)
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index dc594388d..137a83357 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -496,6 +496,8 @@ struct ucsi {
>  
>  	/* The latest "Notification Enable" bits (SET_NOTIFICATION_ENABLE) */
>  	u64 ntfy;
> +	/* Set by ucsi_unregister(), protected by ppm_lock */
> +	bool unregistering;
>  
>  	/* PPM communication flags */
>  	unsigned long flags;
> @@ -554,6 +556,9 @@ struct ucsi_connector {
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	u32 rdo;
> +	unsigned long pwr_level_change_time;
> +	unsigned int pwr_level_unchanged;
> +	bool pwr_level_ntfy_disabled;
>  	u32 src_pdos[PDO_MAX_OBJECTS];
>  	int num_pdos;
>  
> 
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> -- 
> 2.54.0

-- 
heikki
