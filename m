Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736416;
	b=FtbFc9YGzZcgXXWimROep0HH3P++wutPmsTAbHvVKOeghpjI4ENSd+PYbpE4BuNBZcDs
	 87f6Iqv7GzFhBtohvtwxI4qZgWQXugosnM3PYht/bd6iULjt1gODGCaJwajNcJpwNZjeI
	 tbr95jKwsoP4WwMheRn0MJ5jV+SSUl0PM8nT5yY1dGlPmVfC9AaY+x3hMeA/xzTCrpLJO
	 dREfkU4+HZYx1yMEAe8aEjLMkK/wSD7GrzFVun2RGPbNpaAfPxMHXhx1j6MdmDQ9O/T1V
	 4nKuycdQj/7YZevTKzShAuMqVHNWm4GhrLC/Q1oX4CMe1I1LKvwtslGHSl6CzfK24Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736416;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LaONsHcIkb8rJ1R6KT8r3Y33ldV0NjAbydLwV8Ms8OM=;
	b=oXFdPeIvshHu5/3X5QV2WU9seO4M1KTJzyH7iSIUwOPSjReUb+mOef77o0zPGo3WD+mL
	 DxvrkNVLEnHOSNxm1UwwVmAiUGURS0hBH3f4XVC/4sxXRchZjYC0e9NSJjeJtjY+eOCXx
	 utmn3hW8lW9pJmnVLyto71ADH04lxpi76Bb9Z4lHiNQq8UyVVn6NADUfEHMH4ottvJIGO
	 Vnn+if6G9alblucSXHefRd/HpWsI+uMvavdAq7/KEjUlvzBMebJgXgfb4UTFroyeIRSVv
	 MpYK920Ejob9bK1k/158j5CLk/FQfRznJ/JjO89ZriietLMuMDOObkM71SHpUokTOpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcyYc1cv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4B606A31E;
	Thu, 26 Nov 2026 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcyYc1cv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0D61F00897;
	Thu, 26 Nov 2026 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795736416;
	bh=LaONsHcIkb8rJ1R6KT8r3Y33ldV0NjAbydLwV8Ms8OM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EcyYc1cvUhvBIlc59X/6R5wFkNPVXD1H4z7Wo88zoSrGcsLCNRvLWutGr7dLJ/qoh
	 YF7TCHVE0H/SEvB6THh3z/WZ89bhhYPtkSyYGWBHNFYvdLQWe6nbrPg7P/qNS5YW+j
	 RXZBlis1wwtSxOoZPTHa7MfulXpAyH1yS4Y0wCwplw3cg4FAo1eNvY6JCgEGIeiVho
	 v4ZaalYvECkp32RaCXuFgGJQOwepznCcdo5gR+EdFsibdlwcQiCiGL5jzpjUO+rJPl
	 MnIN6jB+prQ3i2Q0UFH7qRXw3wbZ0oBuKtGX1ob8b/pZ0RsVGhJvtU1NYOyETv2AZE
	 BS4MCI3ZQBkGA==
Subject:
 Re: [PATCH net 5/6] idpf: fix use-after-free in the PTP auxiliary worker
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, willemb@google.com,
 netdev@vger.kernel.org, tianxun.ng@bytedance.com, oss.patchbox@gmail.com,
 emil.s.tantilov@intel.com, richardcochran@gmail.com, milena.olech@intel.com,
 konstantin.ilichev@intel.com, stable@vger.kernel.org, Samuel.salin@intel.com
Date: Thu, 26 Nov 2026 23:40:15 +0000
Message-ID: <179573641527.3135.11397629327838341318@kernel.org>
In-Reply-To: <20261125225145.4126333-6-anthony.l.nguyen@intel.com>
References: <20261125225145.4126333-6-anthony.l.nguyen@intel.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes idpf leak the top-level Rx queue group array
  every time a vport is stopped, and also on the allocation error path.
- [Low] idpf: inaccurate Fixes trailer citing 1a49cf814fe1 instead of
  494565a74502

--

idpf: fix use-after-free in the PTP auxiliary worker

This patch adds a per-vport rxq_grps_lock that serializes changes to
rsrc->rxq_grps against the PTP auxiliary worker. idpf_rxq_group_rel() now
clears the pointer under the lock and passes the array to a new
idpf_rxq_grps_free() helper. idpf_rxq_group_alloc() now builds the array
privately and publishes it at the end. The patch also clears the stale
pointer in the soft reset clone and fixes a NULL check in
idpf_ptp_update_phctime_rxq_grp().

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 281b96daa5c1a..968b62f89d873 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1357,16 +1357,15 @@ static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
>  }
>  
>  /**
> - * idpf_rxq_group_rel - Release all resources for rxq groups
> + * idpf_rxq_grps_free - Free an Rx queue group array and everything in it
>   * @rsrc: pointer to queue and vector resources
> + * @rxq_grps: group array to free, not reachable through @rsrc any more
>   */
> -static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
> +static void idpf_rxq_grps_free(struct idpf_q_vec_rsrc *rsrc,
> +			       struct idpf_rxq_group *rxq_grps)
>  {
> -	if (!rsrc->rxq_grps)
> -		return;
> -
>  	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
> -		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
> +		struct idpf_rxq_group *rx_qgrp = &rxq_grps[i];
>  		u16 num_rxq;
>  
>  		if (idpf_is_queue_model_split(rsrc->rxq_model)) {
> @@ -1391,14 +1390,37 @@ static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
>  	rsrc->rxq_grps = NULL;
>  }
>  
> +/**
> + * idpf_rxq_group_rel - Release all resources for rxq groups
> + * @vport: vport the queue groups belong to
> + * @rsrc: pointer to queue and vector resources
> + */
> +static void idpf_rxq_group_rel(struct idpf_vport *vport,
> +			       struct idpf_q_vec_rsrc *rsrc)
> +{
> +	struct idpf_rxq_group *rxq_grps;
> +
> +	if (!rsrc->rxq_grps)
> +		return;
> +
> +	spin_lock(&vport->rxq_grps_lock);
> +	rxq_grps = rsrc->rxq_grps;
> +	rsrc->rxq_grps = NULL;
> +	spin_unlock(&vport->rxq_grps_lock);
> +
> +	idpf_rxq_grps_free(rsrc, rxq_grps);

[Severity: High]
Does this leak the rxq_grps array?

The last two lines of idpf_rxq_grps_free() are unchanged from the old
idpf_rxq_group_rel(). They still free through rsrc, not through the new
argument:

drivers/net/ethernet/intel/idpf/idpf_txrx.c:idpf_rxq_grps_free() {
    ...
	kfree(rsrc->rxq_grps);
	rsrc->rxq_grps = NULL;
}

By the time the helper runs here, rsrc->rxq_grps has already been set to
NULL under rxq_grps_lock, so this is kfree(NULL). The helper frees the
contents of each group through rxq_grps[i], but the array allocated by
kzalloc_objs() is never freed.

This path runs on every interface down, every soft reset (channel, ring,
MTU or GRO_HW changes) and every vport dealloc:

idpf_vport_stop()
  idpf_vport_queues_rel()
    idpf_vport_queue_grp_rel_all()
      idpf_rxq_group_rel()
        idpf_rxq_grps_free()

The error path in idpf_rxq_group_alloc() seems to have the same problem:

err_alloc:
	idpf_rxq_grps_free(rsrc, rxq_grps);

Here rxq_grps was never published to rsrc->rxq_grps, so again only
kfree(NULL) runs. The err_out path in idpf_vport_queue_grp_alloc_all()
calls idpf_vport_queue_grp_rel_all(), but that does not free it either,
because idpf_rxq_group_rel() returns early when rsrc->rxq_grps is NULL.

Also, the helper's rsrc->rxq_grps = NULL store writes the protected pointer
without holding rxq_grps_lock. The new @rxq_grps_lock kernel-doc says the
lock serializes every transition of that pointer.

The same code is still there at the end of the series (73aecc14293f).

Should idpf_rxq_grps_free() end with kfree(rxq_grps) and leave
rsrc->rxq_grps alone?

> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -348,9 +348,11 @@ idpf_ptp_update_phctime_rxq_grp(const struct idpf_rxq_group *grp, bool split,
>  		}
>  	} else {
>  		for (i = 0; i < grp->splitq.num_rxq_sets; i++) {
> +			if (!grp->splitq.rxq_sets[i])
> +				continue;
> +
>  			rxq = &grp->splitq.rxq_sets[i]->rxq;
> -			if (rxq)
> -				WRITE_ONCE(rxq->cached_phc_time, systime);
> +			WRITE_ONCE(rxq->cached_phc_time, systime);
>  		}
>  	}
>  }

[Severity: Low]
Is the Fixes tag pointing at the right commit?

As far as I can tell, in 1a49cf814fe1 ("idpf: add Tx timestamp flows")
idpf_ptp_update_cached_phctime() only refreshed
adapter->ptp->cached_phc_time and adapter->ptp->cached_phc_jiffies. It
did not walk the vports and never touched rxq_grps.

The code this patch fixes seems to come from 494565a74502 ("idpf: add
support for Rx timestamping"). That commit added the
idpf_for_each_vport() loop that reads vport->dflt_qv_rsrc.rxq_grps.
It also added idpf_ptp_update_phctime_rxq_grp(), including the
always-true test on &grp->splitq.rxq_sets[i]->rxq.

This is going to net and will be picked up for stable. Should the
trailer be the following instead?

Fixes: 494565a74502 ("idpf: add support for Rx timestamping")

As it stands, stable trees that carry 1a49cf814fe1 but not the Rx
timestamping commit would be told they need this fix. They do not
contain the Rx queue walk at all, so the patch would not apply there.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125225145.4126333-1-anthony.l.nguyen%40intel.com
