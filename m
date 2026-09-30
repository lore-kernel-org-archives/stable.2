Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D835200A;
	Wed, 30 Sep 2026 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729915; cv=none; b=pPpxH/xv7UDObBUq/TSVtwrGoABzEQcebLSOkMeOQ3/6ZQjCdTxV7LW5TpB3nJRlTUI0wUYCaTawLL8kll9dQD8KrNLG5eq3n2O3udAzuBsiA25iK2dw9cdfMd9L1hm3HleOCFJ1IQlNbKywNqzurJ14C+8E7NsJZUfspizgnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729915; c=relaxed/simple;
	bh=TrxddI/Hgirj3yXqGfdAa8Kh6HR2WjWuQji1/UESvo8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+6assFn35tpCFMsI2nJLaSDPjF1hu4WfudfUoPNkma+fkGWw1nE4q1fdxFtRXybKYCpBUxn2WFVYFjMitj9A2xIv0z4RydDWttmn59WF/Enr7INyX6l9b3AuvIM00hm+DYwr8goYzFVpgggwPbewGvwHP8O11W4SZhCCVPPCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbRo++ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbRo++ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C45E1F000FF;
	Wed, 30 Sep 2026 00:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729913;
	bh=vMnelTKbkJpPqT9aJR9g10KIFEv0Jr+MqAQMgk4zQ34=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dbRo++olxlYvcIBot/NK/V3tMpQTE8xYpeXbw1zoJRyi96z4+pPlAA19SrZHd1yh7
	 9E9Zd/YOhNNC9u+hZ+RlfHTNNsIqK9DiXPJSJkrJ1z//I1YbhoEALr5p0YWPfbc/j5
	 gS9YqrAqgP4FJSRtOt5r7WOX/Fj02ExnHD+y/3JOnk9D6ejOA1dQQtuqs0LrguGMhC
	 HigG6oHk50BsMrK6Kwan47yg6MTAcVBU7kW2qAOMD7AmeMat8Ho+1kjYe3DrgITGp8
	 gvBm+KFoHdMK5lyEw1TJ21cYxiyp3tUaislnRmI+rQnRbjj51CMsYnOld3rXr2JsRH
	 C2KbyGhOhIy4w==
Subject: Re: [PATCH net 1/6] idpf: fix possible race on remove during a reset
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 david.butler@appgate.com, emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn,
 bryan.fraschetti@canonical.com, tristan@talencesecurity.com,
 tomasz.lichwala@linux.intel.com, horms@kernel.org,
 aleksander.lobakin@intel.com, stable@vger.kernel.org,
 jacob.e.keller@intel.com, aleksandr.loktionov@intel.com
Date: Wed, 30 Sep 2026 00:58:31 +0000
Message-ID: <179072991189.434549.5989394906343796155@kernel.org>
In-Reply-To: <20260928230429.495442-2-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-2-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch removes the IDPF_REMOVE_IN_PROG early return from
  idpf_stop(), which opens a double-teardown race between a userspace…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  relies on the loop that contains it.
- [High] This problem wasn't introduced by this patch, but the patch now
  sends the remove-racing-reset case through it.

--

idpf: fix possible race on remove during a reset

This patch drops the IDPF_REMOVE_IN_PROG early return from idpf_stop(),
so idpf_vport_stop() always runs on close. The goal is to let a reset
that races with remove tear down NAPI in idpf_detach_and_close(), which
runs under RTNL.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 827c795afcb62..2c148377540cd 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1033,12 +1033,8 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
>   */
>  static int idpf_stop(struct net_device *netdev)
>  {
> -	struct idpf_netdev_priv *np = netdev_priv(netdev);
>  	struct idpf_vport *vport;
>  
> -	if (test_bit(IDPF_REMOVE_IN_PROG, np->adapter->flags))
> -		return 0;
> -

[Severity: High]
Without this check, can a userspace close that runs during idpf_remove()
tear down the vport a second time?

The remove path is idpf_remove() -> idpf_vc_core_deinit() ->
idpf_deinit_task() -> idpf_vport_dealloc() -> idpf_vport_stop(vport, true).
It holds neither vport_ctrl_lock nor RTNL on entry. idpf_vport_stop() tests
the UP bit before it takes RTNL and does not test it again afterwards:

idpf_vport_stop() {
	if (!test_bit(IDPF_VPORT_UP, np->state))
		return;

	if (rtnl)
		rtnl_lock();
    ...
}

This is the interleaving in question:

CPU1 (rmmod)                         CPU2 (ip link set dev down)
                                     __dev_close_many() holds RTNL
idpf_vport_stop(vport, true)
  IDPF_VPORT_UP is set
  rtnl_lock() blocks
                                     idpf_stop()
                                       idpf_vport_stop(vport, false)
                                         queues/vectors released
                                         IDPF_VPORT_UP cleared
                                     rtnl_unlock()
  teardown continues on released state

idpf_vport_intr_rel() sets q_vectors to NULL but does not change
num_q_vectors:

	kfree(rsrc->q_vectors);
	rsrc->q_vectors = NULL;

On the second pass, idpf_vport_intr_dis_irq_all() does:

	struct idpf_q_vector *q_vector = rsrc->q_vectors;
	...
	for (u16 q_idx = 0; q_idx < rsrc->num_q_vectors; q_idx++)
		writel(0, q_vector[q_idx].intr_reg.dyn_ctl);

Won't that dereference a NULL q_vector? The virtchnl message builders
that walk the NULLed rsrc->txq_grps/rxq_grps may also crash before that
point.

Before this patch, a close that reached idpf_stop() after remove had set
IDPF_REMOVE_IN_PROG returned 0, so only one teardown ran.

Would it help to re-check IDPF_VPORT_UP in idpf_vport_stop() after
rtnl_lock() is taken, or to hold vport_ctrl_lock around the stop in the
remove path?

>  	idpf_vport_ctrl_lock(netdev);
>  	vport = idpf_netdev_to_vport(netdev);
>  

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. It
matters here because this fix now depends on the loop in
idpf_detach_and_close():

	for (int i = 0; i < max_vports; i++) {
		struct net_device *netdev = adapter->netdevs[i];
		...
		if (!netif_device_present(netdev))
			continue;

idpf_vc_core_init() sizes adapter->netdevs by caps.max_vports. However,
idpf_init_task() only creates netdevs up to default_num_vports. If the
device reports max_vports > default_num_vports, can the first hard reset
pass a NULL netdev to netif_device_present()?

idpf_vc_event_task() -> idpf_init_hard_reset() -> idpf_detach_and_close()
  -> netif_device_present(NULL)

The other max_vports-bounded loops in the driver check for empty slots.
idpf_remove() does "if (!adapter->netdevs[i]) continue;", idpf_init_task()
checks !netdev, and idpf_decfg_netdev() stores NULL into the slot on
purpose.

It is not clear which shipping firmware reports max_vports larger than
default_num_vports. virtchnl2 defines them as separate fields, though.
This has been present since 2e281e1155fc, the commit named in Fixes:.

[Severity: High]
This is also a pre-existing issue and was not introduced by this patch.
However, the remove-racing-reset case now goes through it as well.

On a software-initiated function reset, the transaction manager is shut
down before the close path runs:

idpf_vc_event_task() {
    ...
func_reset:
	if (adapter->xnm)
		libie_ctlq_xn_shutdown(adapter->xnm);
drv_load:
	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
	idpf_init_hard_reset(adapter);
    ...
}

After that, libie_ctlq_xn_pop_free() refuses new transactions:

	if (unlikely(xnm->shutdown))
		return NULL;

The call chain is idpf_init_hard_reset() -> idpf_detach_and_close() ->
dev_close() -> idpf_stop() -> idpf_vport_stop(). The DISABLE_VPORT and
DISABLE_QUEUES messages fail silently because their return values are
ignored. Then the rings and buffers are freed:

	idpf_vport_intr_deinit(vport, rsrc);
	idpf_xdp_rxq_info_deinit_all(rsrc);
	idpf_vport_queues_rel(vport, rsrc);
	idpf_vport_intr_rel(rsrc);

reg_ops->trigger_reset() is only called later, after
idpf_vc_core_deinit(). Can the still-enabled Rx queues DMA into the freed
descriptor rings or buffers during that window?

On a VF, idpf_vf_trigger_reset() skips the reset entirely during remove:

	if (trig_cause == IDPF_HR_FUNC_RESET &&
	    !test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
		idpf_send_vf_reset_msg(adapter);

In that case, no device reset follows the free at all.

Before this patch, the remove-racing-reset case skipped idpf_vport_stop()
in idpf_stop(). The rings leaked, but they were not freed while still in
use.

Would it help to shut down the transaction manager only after
idpf_detach_and_close() has disabled the queues? Another option is to
keep the DMA memory until the device has been reset.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928230429.495442-1-anthony.l.nguyen%40intel.com
