Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793532631;
	b=NFzxvQpEQsASdIaOKfD5glqSUdW2tjNBsu4a3T5y5SWb7JFsbZZ86A2JW1q4Pa9xq4Ul
	 3YSBOBcJrdDhh39KZBhIKVCrDWdsUKivZqdBGSiWjyTnHrHRbHdzTpK5DEhYnp1DtyE5X
	 tRHqeKmdzBpRocUtOmOQWsffGBsueV6AWF5MSXWMGiR1GJepTYUeS5s/+M3HqVGJ4WrY0
	 904Jx5mD3Z8kYaU9dsfbSE9he5ZyvTlnx6/Qy6lFpGLqib4SvCFD1cRw7v2/nrv6RVtui
	 PBhamBHc2h/RheqOrG2WgPw4TdxBRS61JQK4pFTCphGE8bmeqVu3kuW5gOGzcZjEMHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793532631;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=x3mcuZyG9qk6zYCEmG8zVhZ+uQN9edYhfhzQAy8rRG8=;
	b=qfSbYb9+NiRomGvCFBE0Z0FQtBZ72Ivnt1wwW52GUdltd35k5Y0MKr/dCC9go3IdbIAF
	 ssmVCBrkCpHBVqSDlBfYHZnYkwqUtDclKdieSfXjehIcwWcDCLFpPZUpL2y+h90XiFigP
	 FkD45kU2j1Jok+R6GjSzidTDzqzEFfxWA/V58xZJKMLzp+SRAXa1BjtJqZ3ZgEzHkEC4H
	 NPXkmEEluMN8UAZEfopS8Qx8VmWPjt8+vneCcPmj8wXgm+qfcaxM6kxRJ2AgqfERhVJA2
	 5rir6UV2loAH+qwygEV05QlUi/X+frjjwYAkWzhe6dmre6NoQQEvQzrlFUJVTFdMorQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYEkj9kh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6861606A325;
	Sun,  1 Nov 2026 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYEkj9kh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6141F000C1;
	Sun,  1 Nov 2026 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793532630;
	bh=x3mcuZyG9qk6zYCEmG8zVhZ+uQN9edYhfhzQAy8rRG8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XYEkj9kh+aNqp0ItGuMh6oSodE9+C1Opuli7hGyFvUA1k0o6xtMUBm56CK+Q0hd5v
	 4Iaw5TT830x8kdL9LbkTiNW4uhoxqod9rOzDP7mSYUa+uMSgptiA9gQVbE3sjkiJMj
	 KomkEH3CikjqkaXst35v8XSdfqoLU+1hAuO9kd1kCHObXIlTLuESASY8mcx/RKWbdw
	 x5TrnJUS0B7WKxhPSSEIw1yVLBHIDQnGx5GPwbRYBG9Qvf4/NrbAD1n2XiyijsTn2l
	 vzjrw4EelkRz48GIXb8h18GPZpElhAL9QKp4MEVOGIIBvNF9T8+6VpF7mLeNy9xheq
	 OUWRNp43mkKRg==
Subject:
 Re: [PATCH net v5 1/2] vxlan: reject adding a remote to a nexthop fdb entry
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: idosch@nvidia.com, i.maximets@ovn.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 horms@kernel.org, kuniyu@google.com, petrm@nvidia.com, ferruh.yigit@amd.com,
 atenart@redhat.com, qotmddnjs@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 01 Nov 2026 11:30:28 +0000
Message-ID: <179353262893.3131.14949958099779309653@kernel.org>
In-Reply-To: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
References: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new fib_nexthops.sh cases never create a nexthop-backed
  00:00:00:00:00:00 entry.
- [Low] Baseline decision: false (resolved later in the series).
- [Low] The commit message says that "vxlan_fdb_notify(), RTM_GETNEIGH
  dumps and the switchdev FDB programming all prefer the remote list…
- [Low] The new "Fdb replace with nexthop group" test (fib_nexthops.sh
  lines 555-557 for IPv6 and 714-716 for IPv4) passes with or without…

--

vxlan: reject adding a remote to a nexthop fdb entry

This patch makes vxlan_fdb_update_existing() reject NLM_F_APPEND on a
multicast or all-zeros fdb entry that is backed by a nexthop group, and
does the check before any entry state is modified. It also moves the
non-unicast NLM_F_REPLACE rejection ahead of the state/flags update. New
fib_nexthops.sh cases are added for both.

> The entry state is also misreported: vxlan_fdb_notify(), RTM_GETNEIGH
> dumps and the switchdev FDB programming all prefer the remote list
> over the nexthop, so user space sees the dead remote while the
> datapath follows the nexthop group.

[Severity: Low]
Is this accurate for the netlink paths? vxlan_fdb_info() checks the
nexthop before the remote:

drivers/net/vxlan/vxlan_core.c:vxlan_fdb_info() {
    ...
	if (nh) {
		if (nla_put_u32(skb, NDA_NH_ID, nh_id))
			goto nla_put_failure;
	} else if (rdst) {
		if (send_ip && vxlan_nla_put_addr(skb, NDA_DST,
						  &rdst->remote_ip))
    ...
}

So the RTM_NEWNEIGH notification sent through
vxlan_fdb_notify()->__vxlan_fdb_notify() and the vxlan_fdb_get() reply
both carry NDA_NH_ID, not the stray remote. vxlan_fdb_dump() handles
f->nh entries before it walks the remote list, and it passes a NULL rdst.

As far as I can tell, only the switchdev notifier part of
vxlan_fdb_notify() (vxlan_fdb_switchdev_call_notifiers() with rd) uses
the stray remote. Could the commit message be narrowed to that path?

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 278d41f58d895..3aead3c7f65f0 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1011,6 +1011,22 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (rcu_access_pointer(f->nh) &&
> +	    (flags & NLM_F_APPEND) &&
> +	    (is_multicast_ether_addr(f->key.eth_addr) ||
> +	     is_zero_ether_addr(f->key.eth_addr))) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Cannot add a remote to a nexthop fdb entry");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Low]
With only this patch applied, can this new rejection leave a VNI
half-installed on a vnifilter device? The commit message says "so a
refused request has no side effects". However, vxlan_vni_add() publishes
the vninode before it makes the call that now fails:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vni_add() {
    ...
	__vxlan_vni_add_list(vxlan, vg, vninode);

	if (vxlan->dev->flags & IFF_UP)
		vxlan_vs_add_del_vninode(vxlan, vninode, false);

	err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
				     extack);

	vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);

	return err;
}

Suppose the per-VNI all-zeros entry is nexthop-backed, and either a group
is given or cfg->remote_ip is not any. Then the call chain is:

vxlan_vni_add()
  vxlan_vni_update_group()
    vxlan_update_default_fdb_entry()
      vxlan_fdb_update()
        vxlan_fdb_update_existing()   <- -EOPNOTSUPP

After that failure, vxlan_vni_update_group() jumps to out and skips both
the remote_ip copy and the IGMP join. vxlan_vni_add() still sends
RTM_NEWTUNNEL. It returns the error without removing the vninode from
vg->vni_hash or from the list.

The next patch in this series, "vxlan: reject VNI add when the default
fdb entry is nexthop-backed", adds a check in vxlan_vni_add() before
vxlan_vni_alloc(). That check rejects this case before anything is
installed, so the problem only exists at the bisect point between the two
patches. Would it make sense to reorder or fold the two patches so that
each one is self-consistent on its own?

[ ... ]

> diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> index 431d7bed76224..bdc23205bde4c 100755
> --- a/tools/testing/selftests/net/fib_nexthops.sh
> +++ b/tools/testing/selftests/net/fib_nexthops.sh
> @@ -547,6 +547,15 @@ ipv6_fdb_grp_fcnal()
>  	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
>  	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
>  
> +	# fdb entries with a nexthop group cannot take a remote append
> +	run_cmd "$BRIDGE fdb add 00:00:00:00:00:00 dev vx10 nhid 102 self static"
> +	run_cmd "$BRIDGE fdb append 00:00:00:00:00:00 dev vx10 dst 2001:db8:91::11 self"
> +	log_test $? 255 "Fdb append with nexthop group"

[Severity: Medium]
Does this fdb add actually create a nexthop-backed all-zeros entry?
Earlier in ipv6_fdb_grp_fcnal(), vx10 is created with a remote:

	run_cmd "$IP link add name vx10 type vxlan id 1010 local 2001:db8:91::9 remote 2001:db8:91::10 dstport 4789 nolearning noudpcsum tos inherit ttl 100"

Because cfg->remote_ip is set, __vxlan_dev_create() has already installed
a plain, non-nexthop all_zeros_mac entry:

drivers/net/vxlan/vxlan_core.c:__vxlan_dev_create() {
    ...
	/* create an fdb entry for a valid default destination */
	if (!vxlan_addr_any(&cfg->remote_ip)) {
		union vxlan_addr rip = cfg->remote_ip;

		spin_lock_bh(&vxlan->hash_lock);
		err = vxlan_fdb_update(vxlan, all_zeros_mac,
				       &rip,
				       NUD_REACHABLE | NUD_PERMANENT,
				       NLM_F_EXCL | NLM_F_CREATE,
    ...
}

bridge fdb add sends NLM_F_CREATE | NLM_F_EXCL. vxlan_fdb_update() finds
the existing entry and returns -EEXIST:

	f = vxlan_find_mac(vxlan, mac, src_vni);
	if (f) {
		if (flags & NLM_F_EXCL) {
			netdev_dbg(vxlan->dev,
				   "lost race to create %pM\n", mac);
			return -EEXIST;
		}

Nothing checks the result of that run_cmd. The append that follows then
reaches vxlan_fdb_update_existing() with f->nh == NULL. The new guard does
not fire, vxlan_fdb_append() adds the remote, and bridge exits 0.

If so, log_test $? 255 would report FAIL on a fixed kernel, and the test
would never reach the new f->nh check. ipv4_fdb_grp_fcnal() has the same
problem, because vx10 is created there with remote 10.0.0.2.

Any of these would avoid the collision: delete the default entry first,
create vx10 without a remote, or use a multicast MAC for the
nexthop-backed entry.

> +
> +	# fdb entries with a nexthop group cannot be replaced with a non-unicast MAC
> +	run_cmd "$BRIDGE fdb replace 00:00:00:00:00:00 dev vx10 dst 2001:db8:91::11 self permanent"
> +	log_test $? 255 "Fdb replace with nexthop group"

[Severity: Low]
Can this test distinguish a fixed kernel from an unfixed one? The check
it hits is the moved "Cannot replace non-unicast fdb entries" rejection
in vxlan_fdb_update_existing(), and that check does not look at f->nh.

Before this patch the same request also returned -EOPNOTSUPP. The only
difference was that it did so after f->state and f->flags had been
rewritten. bridge exits with 255 in both cases.

To cover the half-update this patch fixes, the test could check in bridge
fdb show that state and flags are unchanged after the failed replace.

Because of the setup problem above, the entry being replaced is also the
plain default entry, not a nexthop-backed one.

The comment "fdb entries with a nexthop group cannot be replaced with a
non-unicast MAC" also looks inaccurate. The check is not specific to
nexthops, and the MAC is the lookup key, not the thing being replaced.
The copy in ipv4_fdb_grp_fcnal() has the same issues.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028111626.3460759-1-bsdhenrymartin%40gmail.com
