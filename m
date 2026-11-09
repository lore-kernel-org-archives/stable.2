Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223497;
	b=SNAbSIw2jTSvGziaNHdysffKSaF4QCxS4JpIG0zOEGhZ6W6CfbKAMvfsJ5g6+D8aqFo8
	 vlSrMedaO4MwCYB6c8tG0g0pgE7c3C5MFGuAKLYfrme5b9kYZsQzkUXy2btdE1Y/4QHAQ
	 8SFVToZKfrhHr++8estGtfe7SCSZ/mLBofe2Plih6r+aBinhPU0nkV4n3Eq4L/A/tRHvL
	 xfVifQKwefZIe45suelxXDbv4iyrEbUBCBvSVpg5DcP2I00s57zV66Srz5n+09/Jd1lYN
	 pvXmzG2scg/psck8zkvzZ05DzYzwZIOL9J647a3ISZp18nBrMXeqelNdhab+UT2WbdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223497;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WkXk8UeMIidM85N3aQ+wC/0a5G6Gf28wjQOq2oq5ouE=;
	b=hg+ufHyWZyLymbbsNaE3IMFd7eqwOoGZZk6zEYqsM6ZHUx6qxbrApmYL5dt23wbJe3vp
	 ZzBBXg/+LA8CkEqab8c7ARrBSEre1VsqbFs7RHZOdGTsXy0/jFg4Ro5IfrhmMVvOnYc3L
	 7gMsZVpDplTF9cfQy8qqz1k1OCs8udcCf9r3UhrAgw47PA5NCsKQn7dhuJCdPqn3zDPQ0
	 ShbxulmSzEzqKYIbg6OL+QkNwbxkV+fL367f+fClJZYnQKiUF7fG3pZRdwdpVbCAeQ/cv
	 odoxn/CuopaoMF1V1A6gY/Sv2kAtjNz36oe1PUdfFaMo43Qfp4yEwUcfUnjslaANI7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1P9jweV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C652606A31C;
	Mon,  9 Nov 2026 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1P9jweV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB081F0089F;
	Mon,  9 Nov 2026 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223496;
	bh=WkXk8UeMIidM85N3aQ+wC/0a5G6Gf28wjQOq2oq5ouE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j1P9jweVtKFreXVlXGX4OQRWUqQL1IbwZVuAbemRauaDZ/+Tmhb9J1ana7IuoCwT1
	 ap/RS00ZiEV8AKpvU03iZKOpWyc3ATpOzZpZYNsK4Lxgh7kWs7n3/FzIH0fwJjBdMh
	 TjYfowfE7MFEqQo40qb0LtNHfoAZFI930zGSIVSM/U+oKCKYh80nAyfHvptERGNYXt
	 hOastcYc3BFYquSex+hrsv6LMMSzHIyr5cd9Sf5KkN/AaIjzAT2NME7R/WjltNVQDQ
	 42gHLAsGhU02pNoYSMhLb8tslSUohki00SmyGE/e886/BibgkKiBH/SrVQ2Vna5Vgf
	 4G3/O/coCspxw==
Subject: Re: [PATCH net] nfp: flower: hold an RCU read lock while using an
 offloaded MAC entry
From: netdev-bot+sashiko@kernel.org
To: getshell@seu.edu.cn
Cc: kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, oss-drivers@corigine.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 09 Nov 2026 11:24:55 +0000
Message-ID: <179422349578.994134.14069907207951136090@kernel.org>
In-Reply-To: <20261108105605.1668-1-getshell@seu.edu.cn>
References: <20261108105605.1668-1-getshell@seu.edu.cn>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message gets the pre-patch state wrong and leaves
  out half of the fix.
- [Medium] nfp: flower: RMW race on mac_entry->index in
  nfp_flower_xmit_pre_tun_flow()

--

nfp: flower: hold an RCU read lock while using an offloaded MAC entry

This commit takes rcu_read_lock() around the offloaded MAC lookup in
nfp_flower_xmit_pre_tun_flow() and around the update of mac_entry->index.
The index is copied into a local before nfp_flower_xmit_tun_conf() is
called. The patch also adds an rcu_head to struct nfp_tun_offloaded_mac
and converts the kfree(entry) calls in nfp_tunnel_add_shared_mac() and
nfp_tunnel_del_shared_mac() to kfree_rcu().

> so kfree_rcu() alone is not enough: a grace period only protects readers
> still inside an RCU read-side critical section. The writer is the netdev
> notifier chain under rtnl, freeing in nfp_tunnel_del_shared_mac() with
> rhashtable_remove_fast() + kfree_rcu(); the reader is the tc flower
> offload path, which holds no rtnl, only priv->nfp_fl_lock.

[ ... ]

> the unlock: the firmware payload is unchanged and kfree_rcu() is kept.

[Severity: Medium]
Is this an accurate description of the code before the patch?

Before this patch, struct nfp_tun_offloaded_mac had no rcu_head, and
nfp_tunnel_del_shared_mac() freed the entry with a plain kfree(). This
patch adds both the field and the conversion:

    struct nfp_tun_offloaded_mac {
    ...
    	int bridge_count;
    +	struct rcu_head rcu;
    };

and in nfp_tunnel_del_shared_mac():

    -	kfree(entry);
    +	kfree_rcu(entry, rcu);

So kfree_rcu() is not "kept". It is introduced here.

The patch also converts the err_free_entry path in
nfp_tunnel_add_shared_mac(). That path is reached from err_remove_hash
after the entry has already been inserted into offloaded_macs, but the
commit message does not mention it:

    err_remove_hash:
    	rhashtable_remove_fast(&priv->tun.offloaded_macs, &entry->ht_node,
    			       offloaded_macs_params);
    err_free_entry:
    -	kfree(entry);
    +	kfree_rcu(entry, rcu);

The patch carries Cc: stable. Could the commit message, and maybe the
subject, say that the original bug was an immediate kfree() with no grace
period? It would also help to say that the fix adds the rcu_head and
converts both kfree() calls, not just the reader-side lock. Otherwise a
backport could take only the rcu_read_lock()/rcu_read_unlock() part and
keep the immediate kfree().

[ ... ]

> diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> --- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> +++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> @@ -1462,7 +1473,10 @@ int nfp_flower_xmit_pre_tun_flow(struct nfp_app *app,
>  	else
>  		mac_entry->index &= ~NFP_TUN_PRE_TUN_IPV6_BIT;
>  
> -	payload.port_idx = cpu_to_be16(mac_entry->index);
> +	mac_idx = mac_entry->index;
> +	rcu_read_unlock();
> +
> +	payload.port_idx = cpu_to_be16(mac_idx);
>  
>  	/* Copy mac id and vlan to flow - dev may not exist at delete time. */
>  	flow->pre_tun_rule.vlan_tci = payload.vlan_tci;

[Severity: Medium]
The commit message says the read-modify-write of mac_entry->index is
now inside the RCU read-side section, but rcu_read_lock() only keeps
the entry from being freed. It does not serialize setting or clearing
NFP_TUN_PRE_TUN_IPV6_BIT here against the writers in
nfp_tunnel_add_shared_mac() and nfp_tunnel_del_shared_mac(). Those
assign entry->index from the netdev notifier under rtnl, while this
path holds only priv->nfp_fl_lock. Either side's update to
entry->index can be lost.

Writing the IPv6 bit back into the shared entry also seems to corrupt
the index those writers rely on. NFP_TUN_PRE_TUN_IPV6_BIT is BIT(7),
and nfp_tunnel_is_mac_idx_global() compares the whole low byte of the
index against NFP_FLOWER_CMSG_PORT_TYPE_OTHER_PORT. After an IPv6
pre-tunnel rule has been offloaded, the low byte of entry->index has
0x80 set.

Later, nfp_tunnel_del_shared_mac() drops the last reference. It only
masks off NFP_TUN_PRE_TUN_IDX_BIT before calling
nfp_tunnel_is_mac_idx_global(), so the check fails. The ida_free() on
priv->tun.mac_off_ids is then skipped, which leaks the ID. The stale
bit is also carried into the index that the bridge_count revert path
sends through __nfp_tunnel_offload_mac().

This behaviour predates the patch. Since mac_idx is now a local copy
anyway, would it make sense to read mac_entry->index once with
READ_ONCE() under rcu_read_lock() and apply NFP_TUN_PRE_TUN_IPV6_BIT
only to mac_idx? flow->pre_tun_rule.port_idx is taken from
payload.port_idx, so the delete path should still see the IPv6 bit.
Or is there a reason the bit has to be stored in the shared entry?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108105605.1668-1-getshell%40seu.edu.cn
