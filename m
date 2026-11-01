Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793532632;
	b=4CAZdsKjGgwPmxiMBvV98fuWf61YWP6zCpx9r04hE1oS7XoNNbtZ/F5QraEnFWFoqYbT
	 x+hYoeYGehY0sLZnNswntE+A463Fa71n3Cy0/IzkukB47QqKdYJ5Y985i+MwDW1j7jvsr
	 OhHDGYKrdud8JC30X+UTjesGgNO448cKgkJxrpZb40iCzbKeYX0JuEmpoym+1RZsAkOJH
	 oeVKXwakykab5loV2bBEJhtq6kYAsiKfT/2EXDcV4NKYU29+CCOLdcway2qNScYxDS+la
	 +SXS8dNhdG1F+78ySf2xntvkW5Mvd8a3Gklzi3Ze+XOJVB3eoqQ9Yvb8ixxIXnP1cIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793532632;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QKR+8PYQn0QJC3PYuH+CNGQV8EHuF+fb3PL5Dw961vg=;
	b=RHcDU9I4PGaYLnpfxFaRUr5AH/0z3oVZSxNXzm7YJ+sC2IsGdgrI696CGoNFVnJTx/As
	 izeYag296/Nu/uyjJVmHd6GMCAL4AYvcmrlnseBRsaJ8mSay20J7rQw2iJO+YZdIb7zbX
	 Vtnn2GBb2+0okEsmZOmR8e4sEZtsaScrQwUtCGQxmoi4GHPmYNaB89WCQmA51cHPT3zyG
	 NhSKaX78EAuCDS+d75pd/j86eaqz2nGQsO4sKm5ymWTtflnmaDAEl9dV7oHaXMy1yDYCu
	 +fLJwndqSzOxiQj3TMjT8Wa8wc57jo+FP7qCNzeVGY6VrkMhrrNoh4cRt+a4hTv/Bew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mF7XePRw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E583606A324;
	Sun,  1 Nov 2026 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mF7XePRw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F223D1F00919;
	Sun,  1 Nov 2026 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793532631;
	bh=QKR+8PYQn0QJC3PYuH+CNGQV8EHuF+fb3PL5Dw961vg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mF7XePRwJmAXD1IHvhoY/4aUME4xWQP9Ugvff8Oroc9ikZ9vVtXz4c+ZQDCvYsoLT
	 KAJtmcU4zGXYfhEvMrja8QQmZM3f2i4JJSC1cl5atwrUwZimsYu8/1RtLme4sPCIDb
	 fBsLUn+md9QacA6C4Y5kxJdhOSkeLnaySObzW6uUDRX7j0P0o3cClbkSg1Ws7qARj7
	 yuOoi8hpmO+/t92HGADdQBKd4WSTbKTlNsD3b6kP44OsY0y+5ulDuBqPENyylTIChb
	 qfHHUnBWbpCC1CwbpPl21qunheFy/KS/HEIxAPESTwZtDF2P3XIPh8aV/9VdBA5Tej
	 Ew1UJcMt/xtXg==
Subject: Re: [PATCH net v5 2/2] vxlan: reject VNI add when the default fdb
 entry is nexthop-backed
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: idosch@nvidia.com, i.maximets@ovn.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 horms@kernel.org, kuniyu@google.com, petrm@nvidia.com, ferruh.yigit@amd.com,
 atenart@redhat.com, qotmddnjs@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 01 Nov 2026 11:30:30 +0000
Message-ID: <179353263054.3131.3806722064671880892@kernel.org>
In-Reply-To: <20261028111626.3460759-2-bsdhenrymartin@gmail.com>
References: <20261028111626.3460759-2-bsdhenrymartin@gmail.com>
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

- [Low] The series order leaves a bisect window, and nothing protects the
  stable backport.
- [Low] The commit message gets the order of operations in
  vxlan_vni_add() wrong.

--

vxlan: reject VNI add when the default fdb entry is nexthop-backed

This commit adds vxlan_fdb_entry_nh_backed() and calls it from
vxlan_vni_add(). A VNI add with a group, or with a device default remote,
is now rejected when the all-zeros fdb entry for that VNI is backed by a
nexthop. The check runs before the VNI is installed, so a later
-EOPNOTSUPP from vxlan_fdb_update_existing() can no longer leave the VNI
half-installed.

> vxlan_vni_add() installs the new VNI - hash table insert, group list,
> socket attach and the RTM_NEWTUNNEL notification - before calling
> vxlan_vni_update_group(), which in turn calls
> vxlan_update_default_fdb_entry() to store the group (or the device's
> default remote) into the all-zeros fdb entry of that VNI.

[Severity: Low]
Does this ordering match vxlan_vni_add()? In the code, the notification
goes out after vxlan_vni_update_group() returns, and it goes out whatever
the return value is:

	err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
				     extack);

	vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);

	return err;

The end state described later in the message is accurate: the VNI is
installed and announced despite the error. But it is announced after the
failed update, not before it.

Could this paragraph be reworded to match?

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 124ba47758e91..07e17f4b93530 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -837,6 +837,20 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
>  		return err;
>  	}
>  
> +	/* A default fdb entry that is backed by a nexthop group can
> +	 * never take a remote; reject before the VNI is installed,
> +	 * otherwise a failure in vxlan_vni_update_group() would leave
> +	 * the VNI half-installed.
> +	 */
> +	if ((group && !vxlan_addr_any(group)) ||
> +	    !vxlan_addr_any(&cfg->remote_ip)) {
> +		if (vxlan_fdb_entry_nh_backed(vxlan, all_zeros_mac, v)) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Cannot add a remote to a nexthop fdb entry");
> +			return -EOPNOTSUPP;
> +		}
> +	}

[Severity: Low]
Does the series order leave a bisect window between this patch and the
earlier "vxlan: reject adding a remote to a nexthop fdb entry"?

That earlier patch adds this check to vxlan_fdb_update_existing():

	if (rcu_access_pointer(f->nh) &&
	    (flags & NLM_F_APPEND) &&
	    (is_multicast_ether_addr(f->key.eth_addr) ||
	     is_zero_ether_addr(f->key.eth_addr))) {
		NL_SET_ERR_MSG(extack,
			       "Cannot add a remote to a nexthop fdb entry");
		return -EOPNOTSUPP;
	}

With only that patch applied, a sequence like this:

  bridge fdb add 00:00:00:00:00:00 dev vx0 nhid X self permanent src_vni N
  bridge vni add dev vx0 vni N group G

goes through this path:

vxlan_vni_add()
  vxlan_vni_update_group()
    vxlan_update_default_fdb_entry()
      vxlan_fdb_update()
        vxlan_fdb_update_existing() returns -EOPNOTSUPP

By then the VNI is already in the hash table and the group list, and
RTM_NEWTUNNEL is still sent. That is the half-installed state this patch
is meant to prevent. Leaving out the group has the same effect when the
device has a default remote. Before the earlier patch, the same request
succeeded and appended a stray remote.

Both patches carry Cc: stable and the same Fixes: tag, but neither one
records the dependency.

The earlier patch only touches vxlan_fdb_update_existing(), so it will
probably apply cleanly to older trees. This patch was reworked in v5 for
the RCU conversion of vxlan->cfg (the local cfg from
rtnl_dereference(vxlan->cfg)), so its context is unlikely to apply there.

Could stable end up taking the earlier patch on its own? This guard does
not depend on the earlier patch, so would it make sense to put it first
in the series, or to squash the two?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028111626.3460759-1-bsdhenrymartin%40gmail.com
