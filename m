Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651670;
	b=1cap916SYBfcO3UvBp8nJDKnKsuF55clVDWC0DJ//iqZgp6cg4oq8sfrmMNxRm7AcJX9
	 jziZSRympjhIMYHxbJR0myOPGfjOLkAJwt0ewGpq5n9D7uLmP/qrJqSa4KCXeXTr7L8gY
	 ONGSBxKMod2I+fG59DoITVFprfwIh1KClmZVc5MIYu3NxJaMuHrTA7R7W7vjrLLyxX+lR
	 TNtbGApp0lEcDu5Rkzw1sWEkTq4/R6qg+oUfEhrnszTPsgaB3+TA7pAvD9RDvj3AV5QKY
	 5RImaXWRC/tP0BgG0WASWwrxxPqvdOOfgYwnsHP3QNRhJ93E5NdreCH/krNM2k2Ot/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651670;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sAB86wHiV8Mp01DPEoAR5TRuqqoXNRHYOq2A3Ycx5Mw=;
	b=1O+Qp8LxgBIop+6/BQW9jWsfEXO6mLgg6kOzWCwLavShUVExFVHLTDf5IMO3jN8c17SN
	 dOUnqaoVrWsJx88lEmmGg34lMK3Co2aEuYlkkBfNv9ZzDgLuLnLeVKRFvNhTBO+mUdXB2
	 hfs3THxd7MyaCpXHqnIZQXHA03iL2kTj6DdNo5OvytbKM8Frct1DBBTg5r3bmI4WeOiZE
	 ZLK++cD04VxhaqHCaSfhd/L+RBXjj2RaEJkL2NanjNtgdtk02pOZzVpxOe5+dQWVpCCgN
	 xJI1L6jW1ugw1B/L3rVnLtRALDCmr9BRuJ1QbG7vpJZQInX+seL0jVe9xRMmAkLo0LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXzXSxXR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5D606A319;
	Thu, 22 Oct 2026 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXzXSxXR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D822F1F000C1;
	Thu, 22 Oct 2026 06:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792651669;
	bh=sAB86wHiV8Mp01DPEoAR5TRuqqoXNRHYOq2A3Ycx5Mw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KXzXSxXR2CWjgjf4pXHd3oJIpa80cFaXcy0EodPXrfp5oAF6bbOHosVJfuAZlyf0O
	 CdNQW06Yi7qgjLK7WwPeM7Ln2HVoCzlOD9uYJUU864C2J3PClNwnJS7biJBpTutupk
	 HyeJIkxZ7gfLqZ8Rt2+TIbHuM16OCCd/Iou+3sfrBs0gQujLAa1odP/0vJJGdZyuyI
	 AugeLbDcURg1n9y6d6yN8DILCpWo4mmw55nE4iROiz2OR/xlLy8TaYdsbyYDtWKFoL
	 abkzrzKFV2rg6xGnYuZAWjcgrEPwUUbpBlZPzMV5FGCOzplv+VEDgW26u1gaAPz6pi
	 N9rGL9TYby3HA==
Subject:
 Re: [PATCH net v2] vxlan: reject adding a remote to a nexthop fdb entry
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, horms@kernel.org, kuniyu@google.com,
 idosch@nvidia.com, petrm@nvidia.com, ferruh.yigit@amd.com, atenart@redhat.com,
 i.maximets@ovn.org, qotmddnjs@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 06:47:48 +0000
Message-ID: <179265166841.3135.17127619051490650490@kernel.org>
In-Reply-To: <20261020034531.1420194-1-bsdhenrymartin@gmail.com>
References: <20261020034531.1420194-1-bsdhenrymartin@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new rejection makes a VNI add on a vnifilter device fail
  every time, and the failure leaves the VNI half-installed.
- [Low] The commit message understates the user-visible harm of the bug
  it fixes.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it is the
  same half-update the patch avoids for its own check.

--

vxlan: reject adding a remote to a nexthop fdb entry

This patch adds a check near the top of vxlan_fdb_update_existing(). The
check rejects NLM_F_APPEND requests on multicast or all-zeros fdb entries
that are backed by a nexthop. As a result, bridge fdb append,
vxlan_changelink() and the vnifilter default fdb update path now fail with
-EOPNOTSUPP instead of silently appending a remote.

> Note the resulting behavior change for the two rtnetlink callers:
> operations that previously succeeded while silently attaching an
> unused remote to a nexthop entry now fail with extack
> "Cannot add a remote to a nexthop fdb entry".

[Severity: Low]

Is "unused" accurate here? vxlan_xmit() ignores f->remotes when f->nh is
set. However, __vxlan_fdb_delete() destroys the whole fdb entry when the
matched rdst is the only one on f->remotes:

drivers/net/vxlan/vxlan_core.c:__vxlan_fdb_delete() {
    ...
	if (rd && !list_is_singular(&f->remotes)) {
		vxlan_fdb_dst_destroy(vxlan, f, rd, swdev_notify);
		goto out;
	}

	vxlan_fdb_destroy(vxlan, f, true, swdev_notify);
    ...
}

Say a stray remote B has been appended to a nexthop-backed all-zeros
entry. Either of these then removes the whole nexthop entry, not just the
stray remote:

  ip link set vx0 type vxlan remote 0.0.0.0
      (vxlan_changelink()->__vxlan_fdb_delete())

  bridge fdb del 00:00:00:00:00:00 dev vx0 dst B

Without the stray remote, a dst-qualified delete finds no rdst and does
nothing.

This is Cc: stable and makes previously successful rtnetlink operations
fail. Could the commit message describe this concrete consequence?

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 278d41f58d89..42da2d7d51e0 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1011,6 +1011,15 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
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

[Severity: Medium]

The commit message says the check goes here "so a refused request has no
side effects". That holds inside vxlan_fdb_update_existing(). Does it also
hold for the vnifilter caller the commit message lists?

vxlan_vni_add() in drivers/net/vxlan/vxlan_vnifilter.c installs the new VNI
before it touches the default fdb entry:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vni_add() {
    ...
	err = rhashtable_lookup_insert_fast(&vg->vni_hash,
					    &vninode->vnode,
					    vxlan_vni_rht_params);
    ...
	__vxlan_vni_add_list(vxlan, vg, vninode);

	if (vxlan->dev->flags & IFF_UP)
		vxlan_vs_add_del_vninode(vxlan, vninode, false);

	err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
				     extack);

	vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);

	return err;
}

Suppose a nexthop-backed all-zeros fdb entry already exists for src_vni N.
This chain now returns -EOPNOTSUPP:

vxlan_vni_add()
  vxlan_vni_update_group()
    vxlan_update_default_fdb_entry()
      vxlan_fdb_update(all_zeros_mac, NLM_F_APPEND | NLM_F_CREATE)
        vxlan_fdb_update_existing()

vxlan_vni_update_group() returns before it stores vninode->remote_ip and
before vxlan_igmp_join(). vxlan_vni_add() still sends RTM_NEWTUNNEL, and
nothing undoes the hash insert, the list add or the socket attach.

Would "bridge vni add vni N dev vx0" then report failure to user space
while VNI N stays installed? The VNI would be attached to the socket and
announced to listeners, but with no group stored and no multicast join.
Before this patch the same request succeeded.

Such an entry can be created with:

  bridge fdb add 00:00:00:00:00:00 dev vx0 nhid X src_vni N self permanent

This works because vxlan_fdb_parse() doesn't check that NDA_SRC_VNI is a
configured VNI. The entry can also be left behind by adding VNI N, adding
the nexthop entry, and then deleting VNI N.

The missing unwind in vxlan_vni_add() predates this patch. Before, it was
only reachable on -ENOMEM or notify failures. This patch gives user space
a deterministic way to reach it.

Would it make sense to check for the nexthop entry before the VNI is
installed, or to roll back the insertion before notifying?

The trigger also looks wider than the "group <mcast>" in the commit
message. When no group is given, vxlan_vni_update_group() falls back to
cfg->remote_ip:

	if (group && !vxlan_addr_any(group)) {
		newrip = group;
	} else {
		if (!vxlan_addr_any(&cfg->remote_ip))
			newrip = &cfg->remote_ip;
	}

vxlan_update_default_fdb_entry() accepts any non-any address. So a plain
"bridge vni add vni N" on a device with a default remote would hit this
too, and so would a unicast group.

> +
>  	/* Do not allow an externally learned entry to take over an entry added
>  	 * by the user.
>  	 */

[Severity: Medium]

This is a pre-existing issue that this patch didn't introduce. It is the
same half-update the commit message says the new check avoids.

Take an NLM_F_REPLACE request on an existing zero or multicast MAC entry.
The block below this comment overwrites f->state and f->flags and sets
notify = 1:

	if (!(fdb_flags & NTF_EXT_LEARNED) ||
	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
		if (f->state != state) {
			f->state = state;
			notify = 1;
		}
		...
	}

The NLM_F_REPLACE branch then returns directly for the non-unicast MAC:

		} else {
			NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
			return -EOPNOTSUPP;
		}

That return skips the RTM_NEWNEIGH and switchdev notification. It also
skips the err_notify rollback.

For example, take this command with a state or ndm flags that differ from
the existing default entry:

  bridge fdb replace 00:00:00:00:00:00 dev vx0 dst X self permanent

It would fail, but the entry's state and flags would already have
changed, and neither listeners nor offload would be told.

Could the non-unicast REPLACE check also move up next to the other guards?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020034531.1420194-1-bsdhenrymartin%40gmail.com
