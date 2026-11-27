Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772141;
	b=V6GZaCrdVnPLDZ1nmx+zevIZHbg7owpQ+twh91ZsTrCW2CyIlgiEphGo8d7DcHK/cLJP
	 KExHk5hsRVeGJ2DztL75JwONH0iskicpXTIIk8v2raKM+RjHF16gL5S+z1ydQDKTSQt/O
	 chnSTAg28NKRvv7KNlrYTv256rxLSGKUcyb2qwmuveVSsTcaQxr4D0YozbSqVOTlOBoLl
	 kre+2gMkK7IRgHkaZ5B5gK5OLOE3gS875DMnug8yNTyrf0S7v4c36ApjwIKauJHelfvgU
	 ZxCCG2k45Z/VwGasZMlMbE1yX2ekah1L8qif17YsbbIKw57WnLN51FqXo4gyyuJay+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772141;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hwQ67UPDDBpBlNdOHdQzfI33A0euocSSF71ObVKBPMQ=;
	b=pbFrFuNfJtdTcpyy80EaZ7KrtRNHKf2rEX5NkEC1p5ADsib1xxdtgl1GrXCy9mN8FhOB
	 UEvytnDRYA9j58w9v6+BWzQg4QCEPD9uPeGfkJdLN8JzBNbAedQvPpL9ULj/CqkYCAOBd
	 C5RXrSTPA3/MpBFbBZvvu5IBFVL9iEpA05RgUt3SNMKijDrFPvZsqEeiAwQmRBR6dB51B
	 DLSNhIyApluigUazLElGq3KE6T1DblBzbF9s6h6qf7OFTsTf3f81eLYyML5NgqgYyLK9H
	 nipmhFiQy64wde1d7F6nvOsfEk/k10FVE1wHPke5pW1KEkVlbsEpix6tzIAZ0dd9Rvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT02Zom2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9E606A321;
	Fri, 27 Nov 2026 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT02Zom2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C7B1F0089A;
	Fri, 27 Nov 2026 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795772140;
	bh=hwQ67UPDDBpBlNdOHdQzfI33A0euocSSF71ObVKBPMQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KT02Zom2To/SSGxUt7pByiwxpkW4tayb6INs8CYUn3wwvvldjtiWAUtfnJbL4yr6E
	 /YBg+LmKFBf36XYHDw99BG4wO2v+3fT1yBRsFjowboqCglXMD3Q6xOKIVDZTFJkgP6
	 Nuihh+rrD3OoUmS8lSF2lgtfhbVJNUUL/s45/8OO8tizYPYSPXJAHGXuYTP4wj+YRn
	 i/mdnc6KT5PfzyiUODza2ZOuhJKhL8hJuY4HzIGqmffTI04E1XVRKrY8Q8LfUZ5u/U
	 o3ahufR3CDlQe/03dgy5BiAnASU428/4Rtz6vjh8afPqWfu5K6ZF1bNhaKCDJYWTMx
	 ErWGGqOjnGNWw==
Subject: Re: [PATCH v2] idpf: fix vport_id used as array index in MAC filter
 async handler
From: netdev-bot+sashiko@kernel.org
To: guohongyu@cmss.chinamobile.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alan.brady@intel.com,
 stable@vger.kernel.org, 13057616121@163.com
Date: Fri, 27 Nov 2026 09:35:39 +0000
Message-ID: <179577213934.3135.4441263933524263637@kernel.org>
In-Reply-To: <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
References: <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `test_bit(IDPF_REMOVE_IN_PROG)` check in
  idpf_mac_filter_async_handler()…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the commit
  message's own reasoning ('during driver removal the vports are freed…

--

idpf: fix vport_id used as array index in MAC filter async handler

This commit changes idpf_mac_filter_async_handler() so that it indexes
adapter->vport_config[] with vport->idx instead of the raw vport_id from
the message. It also returns early if IDPF_REMOVE_IN_PROG is set. It fixes
the filter removal loop so that removed entries are freed and never
deleted twice.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index c89783966bae3..4ffb8f9df2797 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3837,6 +3837,10 @@ static void idpf_mac_filter_async_handler(void *ctx,
>  	if (!status || status == -ETIMEDOUT)
>  		return;
>  
> +	/* vports are freed during removal, before this work is cancelled */
> +	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
> +		return;
> +
>  	ma_list = buff->iov_base;
>  	/* make sure at least struct is there */
>  	if (buff->iov_len < sizeof(*ma_list))

[ ... ]

> @@ -3852,7 +3856,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
>  	if (!vport)
>  		goto invalid_payload;
>  
> -	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
> +	vport_config = adapter->vport_config[vport->idx];

[Severity: High]

Does the IDPF_REMOVE_IN_PROG check close the removal race described in the
commit message? The test_bit() is a lockless snapshot. Nothing keeps the
vport alive once the check has passed.

The handler runs from mbx_task, and the only lock held is xn->xn_lock:

idpf_mbx_task()
  libie_ctlq_xn_recv()
    libie_ctlq_xn_process_recv()
      xn->resp_cb() -> idpf_mac_filter_async_handler()

If the handler sees the bit clear, idpf_remove() can set it right after
and carry on:

idpf_remove()
  set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
  idpf_vc_core_deinit()
    idpf_deinit_task()
      idpf_vport_dealloc()
        idpf_vport_rel()
          kfree(vport);
        adapter->vports[i] = NULL;

idpf_vid_to_vport() reads adapter->vports[i] without a lock. It can
therefore return a vport that has already been freed but whose slot has
not been cleared yet. The new vport->idx read would then come from freed
memory. The spin_lock_bh(), list_del() and kfree(f) that follow would act
on whatever vport_config that stale index selects.

Before this patch, the handler only NULL-checked vport and never
dereferenced it.

Normally the synchronous DESTROY_VPORT in idpf_vport_rel() bounds this
window, because only mbx_task completes sync transactions. But there are
two cases where teardown doesn't wait on mbx_task:

  - idpf_send_mb_msg() returns -EBUSY right away when
    idpf_is_reset_detected() is true.
  - libie_ctlq_xn_send() can fail fast with -EAGAIN when no xn is free.

On PREEMPT_RT, or under vCPU preemption, the handler can also stall between
the test_bit() and the vport->idx read.

Could the handler avoid touching the vport at all? idpf_vid_to_vport()
already finds the slot i where adapter->vport_ids[i] == v_id, and
vport->idx == i. adapter->vport_config[i] stays allocated until after
mbx_task is cancelled. Using the matched slot index would fix the out of
bounds read without needing the flag check.

Another option is to shut down xn and flush mbx_task before the vports are
freed.

[Severity: High]

This isn't a bug introduced by this patch, but the commit message's
reasoning ("During driver removal the vports are freed before the mailbox
work is cancelled") applies equally to idpf_handle_event_link(). That
handler runs from the same mbx_task, via idpf_recv_event_msg(), for
VIRTCHNL2_EVENT_LINK_CHANGE:

drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:idpf_handle_event_link() {
	vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
	...
	np = netdev_priv(vport->netdev);

	np->link_speed_mbps = le32_to_cpu(v2e->link_speed);
	...
	vport->link_up = v2e->link_status;
	...
}

In idpf_vport_dealloc(), idpf_decfg_netdev() frees the netdev and sets
vport->netdev = NULL. adapter->vports[i] stays published until
idpf_vport_rel() returns:

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_vport_dealloc() {
	...
		idpf_decfg_netdev(vport);
	...
	idpf_vport_rel(vport);

	adapter->vports[i] = NULL;
	...
}

That window includes the synchronous DESTROY_VPORT round trip, and mbx_task
keeps dispatching ARQ events during it.

Could a link change event processed in that window hit netdev_priv(NULL)
and oops on the np->link_speed_mbps write? If the event arrives after
kfree(vport) in idpf_vport_rel(), the vport->link_up write would also land
in freed memory.

Neither idpf_mbx_task() nor idpf_recv_event_msg() checks
IDPF_REMOVE_IN_PROG. Copying the test_bit() check here would leave the same
race as above.

Either of these might cover both handlers:

  - clear adapter->vports[i] before tearing down the netdev and the vport
  - stop mbx event dispatch before the vports are freed

>  	ma_list_head = &vport_config->user_config.mac_filter_list;
>  
>  	/* We can't do much to reconcile bad filters at this point, however we

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126092627.255454-1-guohongyu%40cmss.chinamobile.com
