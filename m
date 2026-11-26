Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736413;
	b=FoBocCP6C6r6CMR0TdhryhLwbUHdZmxubl7kbfCyTcDACeFknifm/Zqbe6gCbO1460Qf
	 Fluplbmvl0APtECJzFB80qWEEPVlO49PzO1RBb+BQAQ8sYU6C1K2Xrott3WHesazWXUCH
	 Hur/zdYu7TqPFuu2qudkzrFGX5ZFJDQKH12XjOZ9jsdI3dMvsSG7lCYefLUi9dQgkA1u0
	 Z9/Z3g3BvqLlQUMcNbwnv+u0YqRUe7TSONu9TObuikst6SOURVjig8T+8H3D+hRUvZDKk
	 1g0gPkqH7o7W2h08NTi39OvHL5/isGCMreUK1wcUAC5wNm7OoJ//XYL85y3dPQep2Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736413;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=p1NwBe1+g7IymIttwNUADtbPs7ADwM1V7cZzWRri7t8=;
	b=FP9w+2Xf2Smi2sm4x06UDxJWV3CjEV+DliShRNuKE99a2N56b25Rfq7AfYdZiVADEDxT
	 aDgm/NcM+HiOUwP8dcN6Kv6JAW52CIWvbQT1c8FJjypKUTvXTWz6EF+Zu16WP/wAYSQJ8
	 iTCAuSPFLJT+VcOTsfvbDKnU2ylCPXjnEhPXkWbO1VOmiycEiaegDI+/gvzc1d6mS0iYT
	 iyIMGqfSOLVIp2P595K3581Bm8drP25HlOn6qHdS8C8rKLafTaXqNJTWPwjNb5eW44qjn
	 fPo2EENi5IgKffffk8WuBJVTQw1QlWMubKcbw+ygaRt2x9uwhiOfyg9DZ1aF3lWRoiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzN0HqBj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA499606A321;
	Thu, 26 Nov 2026 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzN0HqBj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB06F1F0089A;
	Thu, 26 Nov 2026 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795736412;
	bh=p1NwBe1+g7IymIttwNUADtbPs7ADwM1V7cZzWRri7t8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YzN0HqBjURUjbvjhld6Qz0/vG7ZqxKEeYiYlbaK/ROnYhf4XycQ/8IFTzkdQYqnv0
	 UHGxS6789AwMDblQudnhvqx6itrAP6aXB09W5MNYRWRHNdWH0ZP+IS0ZqYnf4b/wVK
	 I3C1uOQ0Hqug3hUkoxfW1L73Ox38HlTsS6XH2LFpU/2htKoIWP3czwKzseFZf6hqCE
	 jRrmIQPQXzUk+bSYs67rV2J7PrpKxOsvQeCgCbP6yZftnGqcoOjUi1QvGXwOYYzwO6
	 W9PEUcIVh8k+LkcxioG/tFvXjpAiy92q1NMhws/NLMjGBTODbvnSHc79wFOhFpT1Gh
	 rh3TVUQndbHkg==
Subject: Re: [PATCH net 3/6] idpf: ignore link events once removal has started
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, willemb@google.com,
 netdev@vger.kernel.org, tianxun.ng@bytedance.com, oss.patchbox@gmail.com,
 emil.s.tantilov@intel.com, richardcochran@gmail.com, milena.olech@intel.com,
 konstantin.ilichev@intel.com, stable@vger.kernel.org, Samuel.salin@intel.com
Date: Thu, 26 Nov 2026 23:40:11 +0000
Message-ID: <179573641139.3135.13380331474083412807@kernel.org>
In-Reply-To: <20261125225145.4126333-4-anthony.l.nguyen@intel.com>
References: <20261125225145.4126333-4-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new IDPF_REMOVE_IN_PROG test in idpf_handle_event_link()
  (idpf_virtchnl.c:45) only works together with the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  leaves the same vport-lifetime race open on two other teardown paths,…
- [High] This problem wasn't introduced by this patch, but
  idpf_handle_event_link() can see a vport whose netdev pointer is not…
- [High] This problem wasn't introduced by this patch, but
  idpf_handle_event_link() does an unlocked check-then-act on…

--

idpf: ignore link events once removal has started

This patch makes idpf_handle_event_link() return early once
IDPF_REMOVE_IN_PROG is set. During remove, mbx_task can handle a
VIRTCHNL2_EVENT_LINK_CHANGE while idpf_vport_dealloc() is freeing the
vport, and the early return keeps that event from using it. It depends on
an earlier patch in the series that waits for a running mbx_task after
the bit is set.

> Make idpf_handle_event_link() return once IDPF_REMOVE_IN_PROG is set.
> The previous patch waits for a running mbx_task after the bit is set and
> before anything is released, so on remove a link event is either handled
> before the vports are torn down or ignored.

[ ... ]

> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Cc: stable@vger.kernel.org

[Severity: Low]
Could the prerequisite be named by subject or SHA here, instead of "The
previous patch"?

The new check only closes the window together with this pair in the
remove_in_prog branch of idpf_vc_core_deinit():

	} else {
		...
		cancel_delayed_work_sync(&adapter->mbx_task);
		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
	}

Without that wait, an mbx_task that passed test_bit() just before
idpf_remove() set the bit can still be inside the handler when
idpf_deinit_task()->idpf_vport_dealloc() frees the vport.

The pair comes from "idpf: ignore Tx timestamp replies once removal has
started". That patch has Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp
flows"). This patch has Fixes: 02cbfba1add5, which is much older.

Stable trees that have 02cbfba1add5 but not 1a49cf814fe1 could pick up
this patch by its Fixes: tag and miss the prerequisite. The prerequisite
also has no PTP code to apply against in those trees. They would get a
smaller race window rather than a fix.

Would a dependency note on the Cc: stable line help here? For example,
"Cc: stable@vger.kernel.org # needs ...".

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 348c7875134ad..854eb1f1ada4c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -41,6 +41,10 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
>  	struct idpf_netdev_priv *np;
>  	struct idpf_vport *vport;
>  
> +	/* The vports are released on remove and shutdown */
> +	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
> +		return;
> +

[Severity: High]
This isn't a bug introduced by this patch, but the same vport lifetime
race is still open on two teardown paths that never set
IDPF_REMOVE_IN_PROG. It is still there at the end of the series.

idpf_vport_dealloc() frees the vport through idpf_vport_rel(), which ends
in kfree(vport), before it clears the slot:

	idpf_vport_rel(vport);

	adapter->vports[i] = NULL;

adapter->vport_ids[i] is never cleared.

That means this call chain can return the freed vport:

idpf_mbx_task()->libie_ctlq_xn_recv()->idpf_recv_event_msg()->
  idpf_handle_event_link()->idpf_vid_to_vport()

The handler then loads vport->netdev from the freed vport, writes
np->link_speed_mbps through that pointer, and writes vport->link_up into
freed memory.

The first path is hard reset. idpf_vc_event_task() does:

func_reset:
	if (adapter->xnm)
		libie_ctlq_xn_shutdown(adapter->xnm);
drv_load:
	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
	idpf_init_hard_reset(adapter);

With remove_in_prog false, idpf_vc_core_deinit() only calls
libie_ctlq_xn_shutdown(). That does not stop event delivery, because
libie_ctlq_xn_recv() still passes unmatched messages to
idpf_recv_event_msg().

mbx_task is only cancelled after idpf_deinit_task() has freed the vports:

	idpf_ptp_release(adapter);
	idpf_deinit_task(adapter);
	...
	cancel_delayed_work_sync(&adapter->serv_task);
	cancel_delayed_work_sync(&adapter->mbx_task);

The second path is the error unwind in idpf_init_task(). The commit
message doesn't mention it:

unwind_vports:
	if (default_vport) {
		for (index = 0; index < adapter->max_vports; index++) {
			if (adapter->vports[index])
				idpf_vport_dealloc(adapter->vports[index]);
		}
	}
	...
	if (test_and_clear_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
		cancel_delayed_work_sync(&adapter->serv_task);
		cancel_delayed_work_sync(&adapter->mbx_task);
	}

Here mbx_task is cancelled only after the vports are freed, and only on
driver load. The KASAN report in the last patch of this series shows
that this init failure window is real for the PTP worker.

On both paths IDPF_HR_RESET_IN_PROG is set. idpf_decfg_netdev() is
therefore skipped, and vport->netdev is not cleared before the free.

Can a link change event that arrives between idpf_vid_to_vport() and
adapter->vports[i] = NULL cause a use-after-free on these paths?

The new comment ("The vports are released on remove and shutdown") also
leaves these paths out.

>  	vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
>  	if (!vport) {
>  		dev_err_ratelimited(&adapter->pdev->dev, "Failed to find vport_id %d for link event\n",

[Severity: High]
This is also a pre-existing issue, not one introduced by this patch. Can
idpf_handle_event_link() see a vport whose netdev pointer is not set yet?

idpf_vport_alloc() publishes the zeroed vport:

	/* fill vport slot in the adapter struct */
	adapter->vports[idx] = vport;
	adapter->vport_ids[idx] = idpf_get_vport_id(vport);

vport->netdev is only assigned later, in idpf_cfg_netdev(). That happens
after idpf_check_supported_desc_ids() and, on first load, after
alloc_etherdev_mqs(), which may sleep.

mbx_task is already running at that point, because idpf_vc_core_init()
queues it before init_task.

A link event for the new vport_id in that window passes both early
returns. The handler then does:

	np = netdev_priv(vport->netdev);

	np->link_speed_mbps = le32_to_cpu(v2e->link_speed);

With a NULL netdev, this write goes to a near-NULL address in mbx_task
context. The same window opens again on every hard reset re-init.

The error path in idpf_cfg_netdev() also calls free_netdev(vport->netdev)
and then sets vport->netdev = NULL while the vport is still published.
That leaves a short use-after-free window as well.

[Severity: High]
This is another pre-existing issue that this patch does not introduce.
Further down in idpf_handle_event_link(), the IDPF_VPORT_UP test is an
unlocked check-then-act:

	if (!test_bit(IDPF_VPORT_UP, np->state))
		return;

	if (vport->link_up) {
		netif_tx_start_all_queues(vport->netdev);
		netif_carrier_on(vport->netdev);

idpf_vport_stop() resets link_up and frees the queues before it clears
the bit:

	vport->link_up = false;
	idpf_vport_intr_deinit(vport, rsrc);
	idpf_xdp_rxq_info_deinit_all(rsrc);
	idpf_vport_queues_rel(vport, rsrc);
	idpf_vport_intr_rel(rsrc);
	clear_bit(IDPF_VPORT_UP, np->state);

mbx_task holds neither rtnl nor vport_ctrl_lock. It keeps processing
events in this window, because the stop path needs it for its own
mailbox replies.

A link-up event in this window sees vport->link_up != link_status and
IDPF_VPORT_UP still set. It then restarts the Tx queues and the carrier.

In the soft reset path the netdev stays running, and the qdisc stays
active because linkwatch needs rtnl. That path is
idpf_initiate_soft_reset(), called from ethtool set_channels and
set_ringparam and from ndo_change_mtu.

idpf_vport_queues_rel() frees vport->txqs and sets it to NULL. Could the
next transmit reach this line in idpf_tx_start() after that, and before
idpf_vport_open() reallocates the queues?

	tx_q = vport->txqs[skb_get_queue_mapping(skb)];

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125225145.4126333-1-anthony.l.nguyen%40intel.com
