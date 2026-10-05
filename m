Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063D2F691D;
	Mon,  5 Oct 2026 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225032; cv=none; b=Ut8hMpi4NclYimA0g+mmTumyKoKl/maN4m/t79a2vcvSwGsI72vcAZweQ8YLMnmhVh+Kyq2OzakAonZtwfMpIooNq3UlriCJNY5hGt96nZsY8AI1oS4sBrpV5LKMpqBQpdVAbvX8BpMiSKeqx8aDnvC9cpvJlFFTFWDwrJYSxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225032; c=relaxed/simple;
	bh=MG4Tjld7hZabVpZGg3vFrDczUzSHYt3g5FosmmYXvkU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYBQHg/R3FW3v953SPTo5fIu7WaByGmYTXeWCN29QQCErzwYm31XKMOy6X6T9yglYbX08fIE+RJ9aN2cUTkiFBgatCSgKIUrPCB1XgNaGwl1LmUpt5T1ggdeDXDtSD3vn0mjkvvavCWFrCIrzikqTDuNaficbdkAs/qh+ZSpips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU/UxDPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU/UxDPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3B41F000FF;
	Mon,  5 Oct 2026 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791225030;
	bh=kiwNmRctuL5dViiP2gAVt8a3ApIXXyasWdud6WkJ8ec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZU/UxDPV2pEk3B5HfOiOF3E+iknajHjkTK6ZT07gAxduLExk8r4I5fgFfEnFnLFWv
	 WOqd1yHQdghiR0PwdRaU51BCuyqEKpXR2JI3Tf7HU33P/o+4MXNmW8rk302FnHcQH6
	 WKTHKX+rV25D7fRhmwtcRhGq7gEUtnol5LwKchLYP7mvdNWlBn6281vDTkYrNwVl6D
	 GZeogALIIM/SxK0InW3f00qd++IDUED8dKtV0IKKgUPaOOCso7NJsHA6am33f1SVwk
	 5QA1imJ4VtRMJ/s+G/oi8wDVOAPfioGRq8R05kJONP4zh551uv+86YE5f4rZF5+/Gq
	 1irI0bz6cGCJA==
Subject:
 Re: [PATCH net v2 1/2] tipc: unlink publications without a node lookup
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 05 Oct 2026 18:30:29 +0000
Message-ID: <179122502934.434549.13857333587187188896@kernel.org>
In-Reply-To: <20261001182924.3928331-2-nicoyip.dev@gmail.com>
References: <20261001182924.3928331-2-nicoyip.dev@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 1 · High: 1 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch replaces tipc_node_unsubscribe() with an
  unconditional list_del_init(&p->binding_node) in tipc_update_nametbl()…
- [High] The WITHDRAWAL branch of tipc_update_nametbl() now calls
  list_del_init(&p->binding_node) on whatever publication…

Pre-existing issues:
- [High] At this commit, tipc_publ_notify() still walks n->publ_list with
  list_for_each_entry_safe() while holding no lock.
- [Low] The kernel-doc of tipc_update_nametbl() says "Return: the
  publication item if successful, otherwise NULL.", but the function is…

--

tipc: unlink publications without a node lookup

This commit replaces tipc_node_unsubscribe() in tipc_publ_purge() and in
the WITHDRAWAL path of tipc_update_nametbl() with a direct
list_del_init(&p->binding_node) done under nametbl_lock. The node lookup
helper and the now-unused address arguments are removed.

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b7..acf96562608b9 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c

[ ... ]

> @@ -243,14 +242,14 @@ static void tipc_publ_purge(struct net *net, struct publication *p, u32 addr)
>  	spin_lock_bh(&tn->nametbl_lock);
>  	_p = tipc_nametbl_remove_publ(net, &ua, &p->sk, p->key);
>  	if (_p)
> -		tipc_node_unsubscribe(net, &_p->binding_node, addr);
> +		list_del_init(&_p->binding_node);
>  	spin_unlock_bh(&tn->nametbl_lock);
>  	if (_p)
>  		kfree_rcu(_p, rcu);
>  }

[ ... ]

> @@ -258,7 +257,7 @@ void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
>  	struct publication *publ, *tmp;
>  
>  	list_for_each_entry_safe(publ, tmp, nsub_list, binding_node)
> -		tipc_publ_purge(net, publ, addr);
> +		tipc_publ_purge(net, publ);

[Severity: High]
This is a pre-existing issue, but tipc_publ_notify() still walks
n->publ_list here without holding any lock. nametbl_lock is only taken
inside tipc_publ_purge(), one entry at a time.

Can a concurrent WITHDRAWAL unlink and free the entry the iterator has
cached in tmp?

tipc_named_rcv()
  tipc_update_nametbl()
    list_del_init(&p->binding_node);
    kfree_rcu(p, rcu);

tipc_publ_purge() would then read that entry's fields before it takes
nametbl_lock, which is a use-after-free once the grace period has passed.
Before then, the self-linked binding_node means the loop never gets back
to the list head.

The old unlink ran under n->lock, and this traversal didn't hold that lock
either, so the race existed before this patch. It appears to be fixed
later in the series by "tipc: serialize publication purging with name
table updates". That commit splices nsub_list onto a private list under
nametbl_lock and then pops one entry per lock acquisition.

[ ... ]

> @@ -307,7 +306,7 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
>  	} else if (dtype == WITHDRAWAL) {
>  		p = tipc_nametbl_remove_publ(net, &ua, &sk, key);
>  		if (p) {
> -			tipc_node_unsubscribe(net, &p->binding_node, node);
> +			list_del_init(&p->binding_node);
>  			kfree_rcu(p, rcu);
>  			return true;
>  		}

[Severity: Critical]
Can this list_del_init() write into a freed struct tipc_node?

The new unlink assumes that the list head binding_node is linked to is
still alive. Node teardown doesn't appear to drain n->publ_list first:

tipc_node_timeout()
  tipc_node_cleanup()
    tipc_node_delete_from_list()
      list_del_rcu(&node->list);
      hlist_del_rcu(&node->hash);
      tipc_node_put(node);

tipc_node_kref_release()
  kfree(n->bc_entry.link);
  call_rcu(&n->rcu, tipc_node_free);

A publication can also be linked onto a node that is down but still in
the hash. tipc_named_rcv() takes node = msg_orignode(hdr) straight from
the peer's header. tipc_node_subscribe() only checks that the node is in
the hash and does not look at its state:

	tipc_node_write_lock(n);
	list_add_tail(subscr, &n->publ_list);

That allows this sequence:

1. Peer C sends a PUBLICATION with orignode set to a down node B. The
   publication goes onto B->publ_list, and no later NODE_DOWN purge will
   remove it.

2. After NODE_CLEANUP_AFTER, tipc_node_cleanup() deletes B, and B is freed
   after a grace period. The stale publication's binding_node still points
   at &B->publ_list.

3. C sends a WITHDRAWAL with orignode B. tipc_nametbl_remove_publ()
   returns the publication, and list_del_init() writes next->prev and
   prev->next into the freed (or reallocated) tipc_node.

tipc_publ_purge() above uses the same unconditional unlink.

Before this patch, tipc_node_find(B) failed in tipc_node_unsubscribe()
and nothing was written. The commit message describes this exact case:

    tipc_node_unsubscribe() looks up the publishing node by address and returns
    without unlinking when the node has already disappeared from the hash.

The later patch "tipc: serialize publication purging with name table
updates" only reworks tipc_publ_notify(), so this seems to still be
present at the end of the series.

Would it be safer to detach or purge every entry on n->publ_list under
nametbl_lock before the node can be freed?

[Severity: High]
Is p guaranteed to be a remote publication here? The removed
tipc_node_unsubscribe() returned early via in_own_node(net, addr), which
is true for both the own address and 0. The new code has no equivalent
check.

The peer controls node through msg_orignode(), and
tipc_service_remove_publ() treats node == 0 as a wildcard:

	if (p->key != key || p->sk.ref != sk->ref ||
	    (node && node != p->sk.node))
		continue;

A WITHDRAWAL with orignode 0 or the local address could therefore match
a local publication. The peer already has the type, lower, upper, port
and key values it needs from the PUBLICATION items it received.

For a local publication, binding_node is on nt->cluster_scope or
nt->node_scope. tipc_named_publish() and tipc_named_withdraw() modify that
list under cluster_scope_lock. named_distribute() walks it holding only
read_lock_bh(&nt->cluster_scope_lock), called from tipc_named_node_up().

Can this list_del_init(), done under nametbl_lock only, race with that
walk? A walker on this entry would follow the self-linked next pointer
and never reach the head. It would keep packing the same item with BH
disabled.

kfree_rcu() then runs on the publication while it is still linked on the
owning socket's tsk->publications list through binding_sock.
tipc_sk_withdraw() later walks that list on unbind or close and reads
p->scope, p->sr and p->sk from freed memory.

A remote withdrawal could already free a local publication before this
patch. The unlocked change to cluster_scope is new, though, and the commit
message's safety argument only covers "a valid remote publication".

[Severity: Low]
This is a pre-existing issue, but the kernel-doc for tipc_update_nametbl()
says:

 * Return: the publication item if successful, otherwise NULL.

The function is declared static bool and returns only true or false.
Since this patch already touches the function body, could the comment be
updated as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001182924.3928331-1-nicoyip.dev%40gmail.com
