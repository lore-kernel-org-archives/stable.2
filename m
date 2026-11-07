Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050147;
	b=UCQFDz4PzeuULrddYIhhrD+bZe7jEW4V1vCGL3kOk0CKkRuTfZLJoZrHDVwf9MZ9XUN/
	 UqvISYq3VhNB+hderj5JBf+Tg8/fuFt8/WfqNsCWkuKq4vG9ilFP3ap14ilMZe6xrU/CH
	 S91tOQD6yMMOk39eGW5brlA2T8qv6gS7DgA7ithGO9WwwQaE2OsseF5CPGDHZwXoBQWQj
	 5eNPAMRsnTMdEvXdpABOkz/6KKcK8qnMmor8Rzp8LGwnspM+jdBN611zBb0YnupMDoKnB
	 5H5noNGax6p7G5sZc5hz2gjrExISDGoJYqQWaIb84TnHsSJmmjj0fCfi4gyJtNIylyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050147;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HlLkPFRA47iYpBWPfJSKGrVGd9XNqqaIsaN822UA81k=;
	b=GDhWm2ysEpWiLUSj1sclQflcIQjeN4LYq4+bqceN1C1hmZIPwmTmaQ6s02SoJBrj8PW/
	 wDi5bl0mUmRH/BUo/JL5KzmwJT/BZO0dyYUxx70ZqFLG2E7UHTMXclIqvJsZjMhCOyYew
	 ywgw1DpEWdlysiMsAjb016UNd/MFIg8w9fpmEpd+XK0DVtO7GPtmptFQsr2lkEaloq4iS
	 egpq0dex86j28gE4b2owYQpCJowNw655/6m7ucoes9Pa8gJ4GTgw3RF8At8ngec6U0Fqo
	 Iqq9He7YZx/iSagZyHEyXeg5CcLxamHuw47vU7okFV/Horr3jNaf5nLHeE2xY+N6Uaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8yvilQ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DCD606D802;
	Sat,  7 Nov 2026 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8yvilQ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FAF1F0089F;
	Sat,  7 Nov 2026 11:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050146;
	bh=HlLkPFRA47iYpBWPfJSKGrVGd9XNqqaIsaN822UA81k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E8yvilQ6bM1/ZFCRN2Aupy3mdGtXi1d07S7K3DERfQLlQTetUnJxAsoMfuMGva9Hl
	 /yNdTK8FcqGwgtPsgIqT/j4OV1sSE/x/EADkVCS40ef4G/qpkCYRKa4/Uaa84EgnQb
	 gVC6t6dvVQnIqBcHvl/bOQ4Mt8Ax7M2duIE8iepjKZQnapKpm1d+m3Zq0fMU0Zubvi
	 FLWppSRyV+URd9AtlXGKBDedzLWfRLk4oAKWLTTrmbMmq8DIju889NrGuFj56uc9aW
	 yMeHS6w7DP0bMzez+Q3sWtM7/iBGPHPDGHgBm0sJUvs16+kS0OnlQ9pTZ5hAjMIjmU
	 1GKxqKehFqeyA==
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 11:15:45 +0000
Message-ID: <179405014554.994134.10719290719575125531@kernel.org>
In-Reply-To: <20261103100534.1310039-1-vulab@iscas.ac.cn>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch fixes the SA reference leak in only one of the two
  copies of this Rx code.

Pre-existing issues:
- [High] ixgbe_ipsec_del_sa() unlinks the rx_sa from the RCU hash table
  with hash_del_rcu(&rsa->hlist) (line 783) and then zeroes the same…
- [High] ixgbe_ipsec_find_rx_state() finds rsa->xs only under
  rcu_read_lock() and takes its reference with xfrm_state_hold(), which…

--

net: ixgbe: drop the SA reference if secpath_set() fails

ixgbe_ipsec_find_rx_state() takes a reference on an xfrm_state. With this
patch, ixgbe_ipsec_rx() releases that reference when secpath_set() fails
to allocate the skb extension. Before this patch the reference was leaked
on that error path.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index bd397b3d7deab..e44d5eed9ab59 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -1197,8 +1197,10 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>  		return;
>  
>  	sp = secpath_set(skb);
> -	if (unlikely(!sp))
> +	if (unlikely(!sp)) {
> +		xfrm_state_put(xs);
>  		return;
> +	}

[Severity: Medium]
Does ixgbevf need the same fix? The VF driver has a copy of this Rx code
in drivers/net/ethernet/intel/ixgbevf/ipsec.c. After this patch,
ixgbevf_ipsec_rx() still returns without dropping the reference:

drivers/net/ethernet/intel/ixgbevf/ipsec.c:ixgbevf_ipsec_rx() {
    ...
	sp = secpath_set(skb);
	if (unlikely(!sp))
		return;
    ...
}

ixgbevf_ipsec_find_rx_state() takes the reference the same way the PF
helper does:

			ret = rsa->xs;
			xfrm_state_hold(ret);
			break;

secpath_set()->skb_ext_add() is a GFP_ATOMIC allocation. Suppose a VF gets
inline-offloaded ESP/AH traffic while memory is tight. Would one
xfrm_state reference leak each time the allocation fails? If so, the state
would never be freed after the SA is deleted.

Could ixgbevf get a matching fix with its own Fixes: tag?

>  
>  	sp->xvec[sp->len++] = xs;
>  	sp->olen++;

[Severity: High]
This isn't a bug introduced by this patch, but is the rx_sa entry walked
by ixgbe_ipsec_find_rx_state() safe against ixgbe_ipsec_del_sa()?

ixgbe_ipsec_del_sa() unlinks the entry and zeroes it straight away. There
is no grace period in between:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:ixgbe_ipsec_del_sa() {
    ...
		hash_del_rcu(&rsa->hlist);
    ...
		memset(rsa, 0, sizeof(struct rx_sa));
		ipsec->num_rx_sa--;
    ...
}

The NAPI reader runs under rcu_read_lock() and loads rsa->mode and
rsa->xs with plain loads:

ixgbe_ipsec_find_rx_state() {
    ...
		if (rsa->mode & IXGBE_RXTXMOD_VF)
			continue;
		if (spi == rsa->xs->id.spi &&
		    ((ip4 && *daddr == rsa->xs->id.daddr.a4) ||
    ...
}

Suppose a reader picked up rsa from the bucket before hash_del_rcu(). Can
it then see rsa->mode == 0, pass the VF check, and dereference
rsa->xs == NULL in softirq? If ixgbe_ipsec_add_sa() reuses the slot, the
reader could also see a mix of old and new SA fields.

The trigger would be an SA deletion (XFRM_MSG_DELSA, IKE rekey or
lifetime expiry) racing with Rx traffic whose SPI hashes to the same
bucket.

ixgbevf_ipsec_del_sa() has the same pattern:

		hash_del_rcu(&ipsec->rx_tbl[sa_idx].hlist);
		memset(&ipsec->rx_tbl[sa_idx], 0, sizeof(struct rx_sa));

[Severity: High]
This is a pre-existing issue, but is xfrm_state_hold() safe on an
xfrm_state that was found only under rcu_read_lock()?

ixgbe_ipsec_find_rx_state() does this:

			ret = rsa->xs;
			xfrm_state_hold(ret);

xfrm_state_hold() is an unconditional refcount_inc(). The rx_sa entry
holds no reference of its own on xs. __xfrm_state_delete() calls
xfrm_dev_state_delete() and then drops the reference right away:

net/xfrm/xfrm_state.c:__xfrm_state_delete() {
    ...
		xfrm_dev_state_delete(x);

		xfrm_state_delete_tunnel(x);
		...
		xfrm_state_put(x);
    ...
}

Can the refcount reach zero while a NAPI reader that has already loaded
rsa->xs is still in its RCU section? If so, refcount_inc() would run on 0.
That warns and saturates, but the pointer still ends up in sp->xvec[]
above.

xfrm_state_gc_task() frees the state after synchronize_rcu(). That waits
for RCU readers, but not for skbs that hold the secpath.

Suppose the skb outlives the grace period, for example when RPS queues it
to another CPU's backlog. Would xfrm_input() and
secpath_put()->xfrm_state_put() then touch freed memory?

The xfrm core handles this case with xfrm_state_hold_rcu(), which uses
refcount_inc_not_zero(). Should the driver take its reference with an
inc-not-zero as well? ixgbevf_ipsec_find_rx_state() has the same pattern.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103100534.1310039-1-vulab%40iscas.ac.cn
