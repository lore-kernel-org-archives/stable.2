Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EC486E58;
	Thu,  6 Aug 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036842; cv=none; b=u50cp2GSVhJ66p2PvYIDPVZk79mWNSD8clzCn8QZBexlGCPGqjA+d17bc2XMFf/kORrq6U6l2jN1rzOiG78D1QMfoAp9HvFLdKQE9/0ysT/t9qnu/0Cf7O59kGannO+dUWUD22EE5zOsy34JMwNv8bqBg2AlI7nlvlBfaRUY3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036842; c=relaxed/simple;
	bh=uTg/YDzD+Zv20GWed/bOW+I27TbgbWx7SGnXXnr7zow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0u0VzzFh7aOtfR0667rIIB+eBz5ymRnzlYxi7NGM9w3eChloUtoxumqvWiK33fdz1aPBTKSTAcZmRLt55551+FCk50ZjIWU6EBSRQlYkE8eVohclWTQSL+cVYSn4YFtxVruI6/jvzMZZcCzL9hcRq97BUfNO6Ju5p4Eb+v9nMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFzMr8sR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFzMr8sR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F95D1F000E9;
	Thu,  6 Aug 2026 17:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036841;
	bh=sW9pF5MWGI5Lotmi5AEwvYHsIFPAXaS2C+raSxzqWYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFzMr8sRZZFj7rkzNoP6AOCOl12gpwk/NlfweZX1jnmzntx0aROu+tlI2hAgpXuav
	 x1adT80nB/wy9ks6rkPS5tk5HmtksSba+bfiyosdrb4NMiCc2tV/ayPT015juntS9t
	 t8HQM5oAxYlsQgDh1RwSNRKpM1Mb6QNALEPS5COovfwfERbVx/u37sbEVE8vFQtuUZ
	 ocXG5MygDIz7QJyQgfGB9MOfF3A+t/SMUs+VOUDNVwTwLJUvY4xbxMKl1WBMLu8m82
	 3IyN+i+RWwt/Puzv7HHjKDiXRABHPE7ZBnGdgyZArTHnSI7QyMUP9JhpkJ+0S3nN14
	 W7ykoByq+T0dQ==
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
Subject: Re: [PATCH net 07/10] ice: eswitch: fix use-after-free of metadata_dst in repr release
Date: Thu,  6 Aug 2026 10:20:39 -0700
Message-ID: <20260806172039.2935855-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804222205.1580328-8-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-8-anthony.l.nguyen@intel.com>
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
ice: eswitch: fix use-after-free of metadata_dst in repr release

This replaces metadata_dst_free() with dst_release() in
ice_eswitch_release_repr() so that the port representor metadata_dst is
freed only after the last dst_entry reference goes away, instead of being
kfree()d while in-flight skbs may still reference it.

(No Link: tags present in the commit header.)

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index b069e6c514fb1..6e7bba4738989 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
>  		return;
>  
>  	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
> -	metadata_dst_free(repr->dst);
> +	dst_release(&repr->dst->dst);
>  	repr->dst = NULL;
>  	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
>  				       ICE_FWD_TO_VSI);

[Severity: High]

This isn't a bug introduced by this patch, but with the put side now fixed,
is the get side of repr->dst still unsynchronized?

ice_eswitch_port_start_xmit() does three separate plain loads of repr->dst
with no lock, no RCU section and no READ_ONCE():

	skb_dst_drop(skb);
	dst_hold((struct dst_entry *)repr->dst);
	skb_dst_set(skb, (struct dst_entry *)repr->dst);
	skb->dev = repr->dst->u.port_info.lower_dev;

while ice_eswitch_release_repr() drops the last reference and then stores
the NULL:

	dst_release(&repr->dst->dst);
	repr->dst = NULL;

In the normal teardown path the ordering appears to save this, because
ice_eswitch_detach() calls repr->ops.rem() (unregister_netdev(), which
quiesces the representor's ndo_start_xmit) before
ice_eswitch_release_repr().

The attach error path has the opposite order:

	err_xa_alloc:
		ice_eswitch_release_repr(pf, repr);
	err_setup_repr:
		repr->ops.rem(repr);

At err_xa_alloc the representor netdev is already registered, since
repr->ops.add() runs ice_repr_add_vf()/ice_repr_add_sf() ->
ice_repr_reg_netdev() -> register_netdev(), and the attach path holds
devl_lock but not RTNL, so userspace can open the interface and transmit.

Two outcomes seem possible in that window:

  - the xmit CPU loaded a non-NULL repr->dst just before dst_release()
    drove the rcuref to zero, so dst_hold() hits its
    WARN_ON(!rcuref_get(&dst->__rcuref)), takes no reference, and the skb
    carries a metadata_dst that dst_destroy_rcu() frees after the grace
    period, which then gets read by ice_eswitch_set_target_vsi() or by the
    skb free path;

  - the xmit CPU loads repr->dst after the NULL store, giving dst_hold(NULL)
    and a NULL dereference inside rcuref_get().

Would swapping the two error labels so repr->ops.rem() runs before
ice_eswitch_release_repr(), or clearing repr->dst followed by
synchronize_net() before dst_release(), close this window? Also, since
err_setup_repr is reached when metadata_dst_alloc() fails, does that path
leave a registered netdev whose repr->dst is NULL until repr->ops.rem()
runs?

[Severity: High]

This is a pre-existing issue as well, and not something this patch changes,
but does the deferred free help the LAG path at all?

ice_lag_config_eswitch() writes through repr->dst with no NULL check:

	xa_for_each(&lag->pf->eswitch.reprs, id, repr)
		repr->dst->u.port_info.lower_dev = netdev;

xa_for_each() expands to xa_find()/xa_find_after(), which take and drop
rcu_read_lock() internally, so repr is used outside any RCU read-side
section.

The caller ice_lag_process_event() is a work item and holds only
pf->lag_mutex, while the teardown side (ice_free_vfs() ->
ice_eswitch_detach_vf(), and the ice_reset_all_vfs() path) holds
vf->cfg_lock and devl_lock, so the locksets do not intersect.

That seems to allow:

	LAG work				detach thread
	repr = xa_find(...)
						xa_erase(...)
						ice_eswitch_release_repr()
						  repr->dst = NULL;
						ice_repr_destroy()
						  kfree(repr);
	repr->dst->u.port_info.lower_dev = netdev;

which is either a store through NULL or a store into freed memory, since
ice_repr_destroy() does a plain kfree(repr) with no grace period.

The change from metadata_dst_free() to dst_release() only defers freeing the
metadata_dst; the repr->dst = NULL store and the kfree(repr) are still
immediate. Should this path be serialized against the eswitch teardown, or
at least keep the repr lookup inside an RCU read-side section with an
RCU-deferred repr free?
