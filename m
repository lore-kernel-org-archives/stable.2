Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745834;
	b=XwRmyo/xx5FdYxxUupGh5Q3GAemi9XHnDOyfGz9X811iD6gLbNEdJvxlM9sVWazC+Rd4
	 YtlZ8EyZjEt1Hx0eTHB8laHyRoIJMvxTIqFVHgeBq8RLVRC4NcUzz6IRCAT3x63C8yGw9
	 A5NF0X5Wr1Mz5mvEwNjsNpwmYxGvEq3+cAxVRETCRNAvYXSMh0uVCi7gTkjNVM/DGl7P/
	 x0ci73Rg7UllwrpPx8JCoQzFkCJLNThTP1ppNRe7WKked7KT+upCgzo/6ppe9jB1LTgjU
	 chlOy8O+ITvsn7cp5EwotJbFRkdma07sKfD0bEjpE1qd2yrvXonoBa3l7Ov+D4R5xQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745834;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eptb+3/EXFgZ8fNsxkLPAmXNUSDaiv1rQ2/GDYvfOYo=;
	b=gpb0GsiAVdr9K/8JHV+OHibNfgFe4k34KzWUeTIxYpO6H+Y6f+/fFOzyASX0mP+waPdV
	 S3sl/4N7/auA0lYnUP3Lgd13OneogQ+MHPseH/+VEPy2O77n0MRZC9WnMS7/fzVMT47Ma
	 sTSRuV8/7nSFO4ID9tDVmkoTpw2IiFW4gw17ADTihwiyI8X0FObQWj73x6kEugLY92XFk
	 wfXCxpCVpN7Q44l2/monsXKvGs6Fj6KH+ol2JWkE5vwavF7mq4LdP4ExuxcqaIMJSmOlm
	 q/IM7vueeLH2vWQeblYqIB/t1aCi53rLGf3BWyS+Hwu+CvK5UZjYCkuFli5kI/5nfdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRsdNLrU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AE606A31C;
	Fri, 27 Nov 2026 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRsdNLrU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2201F000C1;
	Fri, 27 Nov 2026 02:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795745833;
	bh=eptb+3/EXFgZ8fNsxkLPAmXNUSDaiv1rQ2/GDYvfOYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cRsdNLrUE3TIH7Gr+dgyRG8Zr6D8952UklD7szq0nbnCzXtNCWRkkv7BVP2taKsGc
	 MnAAhopToZ2bzEyk5UD+3v7pYvg8eGPoLCasum3sSh3UMM6aUDaatnP3enyNR1LL3L
	 +K5gV2ZbC3sT74xYIA3xY5fIYMTX6DerIhHsMZQ5RgOWhJEiTsoaUZP/7FzMd9x154
	 wAQtmII2yVHPFFiw8fVCSG7+bmG0kwgtsrm1FD1y4jFwYiQZLUsvLzomDVmpagpBPe
	 xoJN2tlWqUVnQ1xd7hAIfD9Mzqp1DKqMvY6Rg5gQb1AoSb/u/IcdL287q9lnxjYrmf
	 3rX2QXPpHCF4Q==
Subject: Re: [PATCH] idpf: fix vport_id used as array index in MAC filter
 async handler
From: netdev-bot+sashiko@kernel.org
To: guohongyu@cmss.chinamobile.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alan.brady@intel.com,
 stable@vger.kernel.org, 13057616121@163.com
Date: Fri, 27 Nov 2026 02:17:12 +0000
Message-ID: <179574583226.3135.4850818709708500001@kernel.org>
In-Reply-To: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Possible use-after-free introduced by the patch.
- [Low] The commit message describes only part of what the old code did
  wrong.

--

idpf: fix vport_id used as array index in MAC filter async handler

This patch changes idpf_mac_filter_async_handler() so that it indexes
adapter->vport_config[] with the software slot index of the vport
returned by idpf_vid_to_vport(). Before, it used the raw device-side
vport_id from the virtchnl message, which could be out of range.

> vport_config[] has num_max_vports entries and vport_id is an opaque
> device-side identifier that the protocol does not bound by it, so
> a vport id not smaller than num_max_vports makes the handler read
> past the end of the array and use the garbage result as a
> struct idpf_vport_config (spinlock taken, filter list walked,
> entries list_del()'ed through out-of-bounds pointers).

[Severity: Low]
This isn't a bug, but could the changelog also cover the in-range
cases that the old code got wrong?

idpf_add_del_mac_filters() sends the device-side vport->vport_id.
idpf_vid_to_vport() maps it back to a slot by searching
adapter->vport_ids[]. So the device id and vport->idx are unrelated
values.

If the device id is below num_max_vports but names a slot that belongs
to another vport, the old code silently removed MAC filters from that
other vport's mac_filter_list.

If the device id names a slot that was never allocated, the entry is
NULL, because idpf_vport_alloc() fills vport_config[] lazily:

idpf_vport_alloc() {
    ...
    adapter->vport_config[idx] = vport_config;
    ...
}

In that case spin_lock_bh(&vport_config->mac_filter_list_lock)
dereferences NULL.

The code change fixes all three cases; only the description is
incomplete. The wrong-vport filter deletion may be the symptom stable
backporters are most likely to recognise.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index c89783966bae3..2e173d0cb7e63 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3852,7 +3852,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
>  	if (!vport)
>  		goto invalid_payload;
>  
> -	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
> +	vport_config = adapter->vport_config[vport->idx];

[Severity: Medium]
Can this read vport->idx from a freed struct idpf_vport?

idpf_vid_to_vport() takes no lock, no RCU read lock and no reference:

    for (i = 0; i < num_max_vports; i++)
        if (adapter->vport_ids[i] == v_id)
            return adapter->vports[i];

This handler runs from mbx_task, through libie_ctlq_xn_process_recv()
-> xn->resp_cb(). Only xn->xn_lock is held there, and teardown never
takes that lock.

On PCI remove, IDPF_REMOVE_IN_PROG is set. idpf_vc_core_deinit() then
frees the vports before it shuts down the transaction manager and
cancels mbx_task:

idpf_vc_core_deinit() {
    ...
    idpf_deinit_task(adapter);
    ...
    if (remove_in_prog)
        libie_ctlq_xn_shutdown(adapter->xnm);

    cancel_delayed_work_sync(&adapter->serv_task);
    cancel_delayed_work_sync(&adapter->mbx_task);
    ...
}

idpf_deinit_task() -> idpf_vport_dealloc() -> idpf_vport_rel() does
kfree(vport). idpf_vport_dealloc() clears the slot only after that:

    idpf_vport_rel(vport);

    adapter->vports[i] = NULL;

An error response to an earlier ADD/DEL_MAC_ADDR request could arrive
in that window. The handler could then get the vport pointer just
before the kfree, or the stale pointer between the kfree and the NULL
store.

If that memory has been reused, idx is garbage. That gives an
out-of-bounds read of adapter->vport_config[], followed by
spin_lock_bh() and list_del() on wild memory.

The old code never dereferenced vport here. The vport_config[] entries
are freed only in idpf_remove(), after the workqueues are destroyed.

The window is narrow. idpf_vport_rel() sends destroy_vport
synchronously, so the race needs the control plane to answer a pending
MAC request after the destroy_vport response. The reset path is not
affected: there libie_ctlq_xn_shutdown() runs first and drops async
transactions without calling resp_cb.

Would it be safer to have the lookup return the slot index i instead?
adapter->vports[i] == vport implies i == vport->idx, and i is always
below num_max_vports. adapter->vport_config[i] could then be used
without reading through the vport pointer.

>  	ma_list_head = &vport_config->user_config.mac_filter_list;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126020854.233971-1-guohongyu%40cmss.chinamobile.com
