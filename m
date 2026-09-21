Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064194BEE53;
	Mon, 21 Sep 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005241; cv=none; b=Y72ZpefpFSjl+5dZfg7Ecz+cSwe/L48uwW9Gz5n6gGvuE+GGWlgd5YpJz9GtGQVXhkPPDJH8ayUs2F0c1lkE9IVeMPVzHBrVLc2kReCjpWoZeGAsJ8z1Njlp+r6TdYQGJyshttCY2B+VOHmor+YmMwUQqx5Qa1xl4A+PRZN8gJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005241; c=relaxed/simple;
	bh=wndhZUiMMpHruqVoSmu9Q0IABMIPP861w2H1WD12qgU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IyQHN/XR6hXN4XMBfAFDSNWEvzg+VNuC91g4uAKdv0tE4oFG/zCU2JHnTGuJ3oddf05K/HqZ94LytVCA/eNCgCTMsbMozkfuyDyT29YPnO0WofEXX1l2pu6RXjY4d8I1+Z4m0Kor119TN1c7v9vLgpZvag6iuJabG41Vn/Cw3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvXLtScP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvXLtScP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06781F000FF;
	Mon, 21 Sep 2026 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790005239;
	bh=42c5U0WEWRtQDLtAvdMQ5PFeg0kka6tAQthCX1buwMU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hvXLtScP78vzBdRDdegKNCESqV+kT4/s2oc3WOUF0K4sAWoZw2Uke/Tro6HOXl45q
	 sn65akAoYZONrrTOhDz8/Oqj2NldI8DzJtB6xdXpwAtmhYblpmV3gavhLmdQxIJhOA
	 kr7DgGfnlijSK9C8YEWsA1U+fYCKKp9BRymvnntQqwbvCf+PyhDs9aX678bj4z1rGN
	 QgkbcDYNrZF76DkDV+ZR6e9tZFrw3QBaGDyGQR9f6Nn4LTqoRq8vuArIHERw2lqpnG
	 2eApD42fiyxwoptpYZMydHU6mgJk15c9v7Cc0Cpniff3r+EClKiWjnVnd+/RUeL4qt
	 iyMneNHm34FGQ==
Subject:
 Re: [PATCH] ptp: ocp: Fix dpll device reference leak in ptp_ocp_probe()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew+netdev@lunn.ch, arkadiusz.kubalewski@intel.com, davem@davemloft.net,
 edumazet@google.com, jiri@resnulli.us, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 15:40:38 +0000
Message-ID: <179000523836.2160803.2580235402592970562@kernel.org>
In-Reply-To: <20260917142337.2156652-1-vulab@iscas.ac.cn>
References: <20260917142337.2156652-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The sibling error path `out_dpll:` in ptp_ocp_probe()
  (drivers/ptp/ptp_ocp.c:5150-5155) drops only the driver's own DPLL…

Pre-existing issues:
- [Medium] ptp_ocp_probe() (drivers/ptp/ptp_ocp.c) registers the devlink
  instance at line 5115 (`devlink_register(devlink)`) before the DPLL…

--

ptp: ocp: Fix dpll device reference leak in ptp_ocp_probe()

This adds a dpll_device_put() call on the error path taken when
dpll_device_register() fails in ptp_ocp_probe(), so the reference taken
earlier by dpll_device_get() is dropped before the shared unwind path
runs.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 3d26ec1f7b9ec..0739adb69a130 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -5123,8 +5123,10 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	}
>  
>  	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
> -	if (err)
> +	if (err) {
> +		dpll_device_put(bp->dpll, &bp->tracker);
>  		goto out;
> +	}
>  
>  	for (i = 0; i < OCP_SMA_NUM; i++) {
>  		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,

[Severity: High]
Once dpll_device_register() succeeds, does the sibling out_dpll path still
leak the same dpll device this patch is trying to protect?  The loop right
below the changed hunk jumps there on failure:

	for (i = 0; i < OCP_SMA_NUM; i++) {
		bp->sma[i].dpll_pin = dpll_pin_get(...);
		if (IS_ERR(bp->sma[i].dpll_pin)) {
			err = PTR_ERR(bp->sma[i].dpll_pin);
			goto out_dpll;
		}

		err = dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin, ...);
		if (err) {
			dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
			goto out_dpll;
		}
	}

and out_dpll only drops the driver's own reference:

out_dpll:
	while (i--) {
		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
		dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
	}
	dpll_device_put(bp->dpll, &bp->tracker);
out:
	ptp_ocp_detach(bp);
out_disable:
	pci_disable_device(pdev);
out_free:
	devlink_free(devlink);

dpll_device_register() in drivers/dpll/dpll_core.c allocates a registration
that stores priv and takes a second reference of its own:

	reg->ops = ops;
	reg->priv = priv;
	dpll->type = type;
	__dpll_device_hold(dpll, &reg->tracker);
	...
	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);

Only dpll_device_unregister() removes that entry and puts that reference,
which is what ptp_ocp_remove() does:

	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
	dpll_device_put(bp->dpll, &bp->tracker);

Since ptp_ocp_remove() is not called after a failed probe, does the dpll
device stay marked DPLL_REGISTERED with reg->priv pointing at bp, while
devlink_free() releases the allocation whose private area is bp
(bp = devlink_priv(devlink))?  If so, can a later DPLL_CMD_DEVICE_GET reach
ptp_ocp_dpll_lock_status_get() with the freed bp:

	struct ptp_ocp *bp = priv;

	*status = bp->sync ? DPLL_LOCK_STATUS_LOCKED : DPLL_LOCK_STATUS_UNLOCKED;

and would the still-registered device keep ops pointers into the module
text after the module is unloaded?

Triggering conditions are dpll_pin_get() returning ERR_PTR on allocation
failure, or dpll_pin_register() failing for any SMA index.  Would it make
sense for this patch to also add dpll_device_unregister(bp->dpll,
&dpll_ops, bp) to out_dpll, so the reference the newly handled
dpll_device_register() call takes is released on all error paths?

[Severity: Medium]
This isn't a bug introduced by this patch, but the unwind path the patch
extends also looks asymmetric with respect to devlink.  ptp_ocp_probe()
registers the devlink instance before the dpll setup block:

	ptp_ocp_info(bp);
	devlink_register(devlink);

	clkid = pci_get_dsn(pdev);
	bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE, &bp->tracker);

but the out/out_dpll paths reach devlink_free() without any
devlink_unregister():

out:
	ptp_ocp_detach(bp);
out_disable:
	pci_disable_device(pdev);
out_free:
	devlink_free(devlink);
	return err;

ptp_ocp_detach() contains no devlink call, and only ptp_ocp_remove() does:

	devlink_unregister(devlink);
	ptp_ocp_detach(bp);
	pci_disable_device(pdev);

	devlink_free(devlink);

devlink_free() in net/devlink/core.c opens with:

void devlink_free(struct devlink *devlink)
{
	ASSERT_DEVLINK_NOT_REGISTERED(devlink);

Does a dpll failure in probe therefore hit that WARN_ON_ONCE and destroy
the instance while it is still marked DEVLINK_REGISTERED, so userspace
listeners see the NEW notification but never the matching DEL, and the
instance stays findable while ptp_ocp_detach() tears the device down?  The
triggering conditions are the same ones handled here: dpll_device_get()
returning ERR_PTR, dpll_device_register() returning an error, or a
dpll_pin_get()/dpll_pin_register() failure.

Would adding devlink_unregister(devlink) to the out path be appropriate,
either in this patch or as a separate one?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917142337.2156652-1-vulab%40iscas.ac.cn
