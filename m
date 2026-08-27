Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401D38D011;
	Thu, 27 Aug 2026 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859100; cv=none; b=JSBtnoWF69yFI6STka1U/2bUUSQStFAT7GXSlFAccM+DSgGDUvWnohIoxiGJ8iROpUn2cVcKMslFlUhIlFU1PUCViQuLuJW62CMgv98LJsPa2HSLQuBue6csncEyNpijA6u5qCoyaAE7rekuZ6EN6b59yzrIA6vaZYd8VN7poEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859100; c=relaxed/simple;
	bh=2MFKG7CY/pe2egGvEH4CblfQk8bZP4EglvSjFHysPFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuBQqsTKAf1HUMnG+s7vDPS4v4wssNa3WuE6p9NUkbebhqoeA4NvxqO0qQFwvVBhIW4DchW12/Tk5FkHaeaL1B5v/q/4afkBNCddIEm5AFNgknxD5u8sDcuD8McctdrJRR5vTkUGS17nUvMDULT9TUI1fq654n+HprATjtgZotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzK7ssnw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzK7ssnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209031F000E9;
	Thu, 27 Aug 2026 19:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859098;
	bh=xnLKtGco1pn9+Nil6iJUWrRiRtxhYLrrckyu5BmxByY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AzK7ssnwEyPO356D+I3wrYhRkaUv8qrckiznW6Hrbq820dCjxlOq93F2Yq4TEfl7K
	 6Hw7uTwyYrdrIe2nCuwlfRP6X65fzn3xrjE5NprcUiBQLT0e0vDf+Dm+jWbq0WQogX
	 AgvE7jHtMU7vlCySxmwqXuoxjnqTOI2zbtiM7rNk9I7uPNd3egTnMvfVEyJ3pJdvlt
	 vJW8ywwZKcWC7yX0Dn32GofyK76a9XAbL1obKiCGiofy5QFOzA4svHC8OlxV8yu7Eo
	 coSbgyID+GKNe47jyePkmPFd33qw6Y95i8W/SwoaL5uT0xp1Io40CLE6YBwBvK/75/
	 I478shbDBMo8Q==
From: Jakub Kicinski <kuba@kernel.org>
To: littleddfu@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	corvus@tencent.com,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	junvyyang@tencent.com
Subject: Re: [PATCH net v2] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Thu, 27 Aug 2026 12:31:37 -0700
Message-ID: <20260827193137.4015557-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826014200.362304-1-littleddfu@gmail.com>
References: <20260826014200.362304-1-littleddfu@gmail.com>
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
net: bridge: mcast: don't truncate the port group walk on teardown

This changes br_multicast_del_pg() to unlink the port group from
port->mglist with hlist_del_init_rcu() instead of hlist_del_init(), so
that a nested deletion of another group of the same port does not clear
the ->next pointer that an in-progress teardown walk has already latched.
The intent is to stop br_multicast_del_port() and
__br_multicast_disable_port_ctx() from terminating early and leaving port
groups behind with a dangling ->key.port.

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 75e1e2a8fc83a..452ac68c4a835 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -808,7 +808,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
>  	struct hlist_node *tmp;
>  
>  	rcu_assign_pointer(*pp, pg->next);
> -	hlist_del_init(&pg->mglist);
> +	/* Keep ->next (held under multicast_lock, freed later by the GC work):
> +	 * a port->mglist teardown walk may have latched this node as its next,
> +	 * and deleting other groups of the same port must not truncate it.
> +	 */
> +	hlist_del_init_rcu(&pg->mglist);

[Severity: High]

Preserving ->next keeps the walk going, but doesn't it now make the walk
visit a group that was already deleted as a side effect?

hlist_del_init_rcu() only clears ->pprev, so the latched next node is
still reachable by the iterator:

	include/linux/rculist.h:
	static inline void hlist_del_init_rcu(struct hlist_node *n)
	{
		if (!hlist_unhashed(n)) {
			__hlist_del(n);
			WRITE_ONCE(n->pprev, NULL);
		}
	}

Taking br_multicast_del_port() as the example, all under
br->multicast_lock:

br_multicast_del_port()
   hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)  /* n = A->next = B */
      br_multicast_find_del_pg(br, A)
         br_multicast_del_pg(mp, A, pp)
            br_multicast_del_group_src() -> br_multicast_fwd_src_remove()
            or br_multicast_star_g_handle_mode() -> __fwd_del_star_excl()
            or br_multicast_sg_del_exclude_ports()
               -> deletes B (same port) via br_multicast_del_pg()
                  rcu_assign_pointer(*pp, B->next);   /* B off mp->ports */
                  hlist_del_init_rcu(&B->mglist);     /* B->next preserved */
   pg = n = B                                          /* loop continues into B */
      br_multicast_find_del_pg(br, B)

In br_multicast_find_del_pg() the mdb entry lookup still succeeds, since
mdb entries are only unhashed under br->multicast_lock, but the scan over
mp->ports can no longer find B because br_multicast_del_pg() already did
rcu_assign_pointer(*pp, pg->next) for it:

	for (pp = &mp->ports;
	     (p = mlock_dereference(*pp, br)) != NULL;
	     pp = &p->next) {
		if (p != pg)
			continue;

		br_multicast_del_pg(mp, pg, pp);
		return;
	}

	WARN_ON(1);

So control falls through to the trailing WARN_ON(1). br_multicast_del_port()
applies no filter at all before calling br_multicast_find_del_pg(), and the
filter in __br_multicast_disable_port_ctx():

	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist)
		if (!(pg->flags & MDB_PG_FLAGS_PERMANENT) &&
		    (!br_multicast_port_ctx_is_vlan(pmctx) ||
		     pg->key.addr.vid == pmctx->vlan->vid))
			br_multicast_find_del_pg(pmctx->port->br, pg);

doesn't exclude a kernel-installed, non-permanent S,G group either.

Does that mean the reproducer described in the commit message now produces
a WARN backtrace on the same path instead of the KASAN use-after-free, and
a panic when booted with panic_on_warn=1?

Would it make sense to also skip nodes that are already unlinked in both
teardown walks, e.g.:

	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist) {
		if (hlist_unhashed(&pg->mglist))
			continue;
		br_multicast_find_del_pg(br, pg);
	}

or otherwise restart the walk, rather than relying on the preserved ->next
alone?

[Severity: High]

This isn't a bug introduced by this patch, but the same list has a second
deletion site that still uses the non-RCU helper and frees immediately,
br_multicast_del_port_group():

	void br_multicast_del_port_group(struct net_bridge_port_group *p)
	{
		struct net_bridge_port *port = p->key.port;
		__u16 vid = p->key.addr.vid;

		hlist_del_init(&p->mglist);
		if (!br_multicast_is_star_g(&p->key.addr))
			rhashtable_remove_fast(&port->br->sg_port_tbl, &p->rhnode,
					       br_sg_port_rht_params);
		kfree(p);
		br_multicast_port_ngroups_dec(port, vid);
	}

port->mglist is also walked locklessly by br_multicast_list_adjacent(),
which only holds rcu_read_lock():

	hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
		...
		entry->addr = group->key.addr;

That reader is exported and used from net/batman-adv/multicast.c. The group
is already published on port->mglist by br_multicast_new_port_group()
(hlist_add_head(&p->mglist, &port->mglist)) before the only caller of
br_multicast_del_port_group() runs, the err_del_port_group label in
br_mdb_add_group_star_g() in net/bridge/br_mdb.c, reached when
br_mdb_add_group_srcs() fails. br_mdb_config_src_list_init() does not
reject a duplicated source, so a MDBE_ATTR_SRC_LIST carrying the same
source twice without NLM_F_REPLACE makes br_mdb_add_group_src() return
-EEXIST; an allocation failure returning -ENOSPC is a second trigger.

spin_lock_bh(&br->multicast_lock) held by the deleting side does not
exclude an RCU reader on another CPU. Can br_multicast_list_adjacent()
then read group->key.addr and follow group->mglist.next after the plain
kfree(p), and does the hlist_del_init() there also truncate that RCU walk
by NULLing ->next?

Since this patch establishes that port->mglist deletions must preserve
->next and defer the free, would it be worth converting this site to
hlist_del_init_rcu() plus a deferred free, in the way
br_multicast_destroy_port_group() uses kfree_rcu()?
