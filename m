Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3227485CEF;
	Thu,  6 Aug 2026 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036854; cv=none; b=ptpFoARPQDYAQvkfmfyIHlvHIFE9E0Pwm9NIW697cSwErUkd78+Gth8nTlBj3CxXyXdowvt/li5y1iavs5ZZSWVZ+mzQxIc+ILEHdsUG8kOlTl5t8H42WepycQMreAvQipM3xACuygphW2qgwXLp4uOEH3KGW+zadjGfRg6BF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036854; c=relaxed/simple;
	bh=9Dc9mzcppt92C/0mZ2usn7BBlMmhyEf9LSfHIniwo2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPdd587xJ1s8vhlrMOOR42+Kn4A+YoydpO1MM50klqRZbws+WC1DIMbjJAp9xFaFi0r/lrGursOOIz4//pPaUh5ia0NhnYDZdb9CEBofjeqZZStPYrBBtB8TELV7jS/G9balxx3G6JE0jObfKvsjZ5H2zS9zG2i72tdu7vVjYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOXTYYnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOXTYYnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B5A1F00A3A;
	Thu,  6 Aug 2026 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036852;
	bh=LkwrYsJ8pCJmIXlHV+xEoHUyE6w2MTLsuuD6Xk1D0Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WOXTYYnIgSrKudHAI85OzgjS08eDaQVbQ4464+/1ZcfULOAMX4gBrnhGf4b3Gws+2
	 5tu0ww1k40LAjZ91zxpzMjW0122v41I/E6sw2Oey+2CMfFmXMZhs9X0zRKffTTqnDB
	 zK8ix5U/5yyzyjS96bH5F1KGZMZ1D879Gac78hqv7AX9Oce9iS9ZHyaSMChKMU/Mmw
	 NWbgznbAfStPRZhB6GV/eCdmKXdQAcXntBoYsuzEB8xqhYzkwXoOdkvtflZWKO97U6
	 VX5pRYp5yvwWc6YMVHn527FsyA3ZjGv+IanFdyhV9EvbOr2OlINzZQ2pQxM0jKvBH2
	 ZXh2MVHVOol5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	doruk@0sec.ai,
	michal.swiatkowski@linux.intel.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net 09/10] i40e: fix netdev leak in i40e_vsi_setup() error paths
Date: Thu,  6 Aug 2026 10:20:51 -0700
Message-ID: <20260806172051.2936459-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804222205.1580328-10-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-10-anthony.l.nguyen@intel.com>
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
i40e: fix netdev leak in i40e_vsi_setup() error paths

This moves the free_netdev() call out of the netdev_registered block at
err_msix and into a new unconditional block at err_netdev, so that the
netdev allocated by i40e_config_netdev() is released when
i40e_netif_set_realnum_tx_rx_queues(), i40e_devlink_create_port() or
register_netdev() fail.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 0ac1be6289f6b..4f0f7626605ba 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14494,13 +14494,15 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
> -		free_netdev(vsi->netdev);
> -		vsi->netdev = NULL;
>  	}
>  err_dl_port:
>  	if (vsi->type == I40E_VSI_MAIN)
>  		i40e_devlink_destroy_port(pf);
>  err_netdev:
> +	if (vsi->netdev) {
> +		free_netdev(vsi->netdev);
> +		vsi->netdev = NULL;
> +	}

[Severity: Medium]
On the newly covered paths the netdev was never registered, but the VSI
is already published in pf->vsi[vsi->idx] by i40e_vsi_mem_alloc(), and
i40e_config_netdev() has already run i40e_add_mac_filter() for the
unicast and broadcast addresses, which does:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_add_filter() {
	...
	vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
	set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->back->state);
	...
}

The service work item then walks pf->vsi[] with no lock:

i40e_sync_filters_subtask() {
	i40e_pf_for_each_vsi(pf, v, vsi) {
		if ((vsi->flags & I40E_VSI_FLAG_FILTER_CHANGED) &&
		    !test_bit(__I40E_VSI_RELEASING, vsi->state)) {
			int ret = i40e_sync_vsi_filters(vsi);
	...
}

and i40e_sync_vsi_filters() dereferences the netdev:

i40e_sync_vsi_filters() {
	...
	if (vsi->netdev) {
		changed_flags = vsi->current_netdev_flags ^ vsi->netdev->flags;
		vsi->current_netdev_flags = vsi->netdev->flags;
	}
	...
}

Can the service task load vsi->netdev, pass the NULL test, and then
dereference it after this free_netdev()?  The error path does not set
__I40E_VSI_RELEASING first, which is the ordering i40e_vsi_release()
uses before its own free_netdev(), and the vsi->netdev = NULL store
carries no lock or barrier.

This is reachable at runtime for I40E_VSI_VMDQ2 VSIs created from
debugfs, where i40e_dbg_command_write() calls
i40e_vsi_setup(pf, I40E_VSI_VMDQ2, vsi_seid, 0) while the service work
item is live.  Would setting __I40E_VSI_RELEASING (or clearing
I40E_VSI_FLAG_FILTER_CHANGED / unpublishing pf->vsi[idx] under
pf->switch_mutex) before dropping the netdev close this window, mirroring
i40e_vsi_release()?

The exposure window is short, since the following i40e_vsi_clear() also
kfree()s the still-published struct i40e_vsi on these same paths, which
is a pre-existing unsynchronised teardown.

[Severity: High]
This isn't a bug introduced by this patch, but the other in-tree caller of
i40e_config_netdev() does not follow the ownership rule this hunk
codifies.  In i40e_init_recovery_mode() the netdev is never released:

	err = i40e_config_netdev(vsi);
	if (err)
		goto err_switch_setup;
	err = register_netdev(vsi->netdev);
	if (err)
		goto err_switch_setup;
	vsi->netdev_registered = true;
	i40e_dbg_pf_init(pf);

	err = i40e_setup_misc_vector_for_recovery_mode(pf);
	if (err)
		goto err_switch_setup;

If register_netdev() fails, is the net_device allocated by
alloc_etherdev_mq() inside i40e_config_netdev() leaked?  i40e_probe()
does "return i40e_init_recovery_mode(pf, hw);", so i40e_remove() never
runs for the failed probe and nothing later frees it.

The case where register_netdev() succeeded and
i40e_setup_misc_vector_for_recovery_mode() then fails looks worse, since
err_switch_setup never calls unregister_netdev():

err_switch_setup:
	i40e_reset_interrupt_capability(pf);
	timer_shutdown_sync(&pf->service_timer);
	i40e_shutdown_adminq(hw);
	iounmap(hw->hw_addr);
	pci_release_mem_regions(pf->pdev);
	pci_disable_device(pf->pdev);
	i40e_free_pf(pf);

	return err;

i40e_free_pf() is devlink_free() on the devlink whose priv is the struct
i40e_pf, so the netdev stays registered in the netns while its
netdev_priv()->vsi->back has been freed and hw->hw_addr has been
iounmapped.  Can a later "ip link set <dev> up" on the leftover interface
reach i40e_open() and touch the freed pf and the unmapped register
window?  The debugfs directory created by i40e_dbg_pf_init(pf) is left in
place pointing at the freed pf as well.

Would it make sense to fix that call site in the same series, so both
users of i40e_config_netdev() release the netdev consistently?
