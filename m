Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2882E266C;
	Mon,  5 Oct 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225033; cv=none; b=ft7p7daoTcZ41ykQcnVPeJkvGgVpCj7EG2NmZRgCxV6B41nP0YRgSbIO7/wq8eFkVQ53N0zF1KjJ8l1sauWgiSJ1gob+M6wRJWrVEbr3+LsDk9XDRNT9vx4sl7EEs+YsJwhPZoGe4X3KzQWqeui1Q7q33jGPUvnDk8HFf2MTTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225033; c=relaxed/simple;
	bh=102UlpV4ICPswpZPhQbC4d6qwOqqHix4q6CaWu7R/2Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RE3odAmOetqOBvns/jhQL7SU2aTMeUtW61B8XP3t1i0YTBIMBdNgBPtgM2O/kysoix3ePRGmaqE6bV95/StkgkX9wXRAy+PLithqWcfQSYARaAGlViQnCACTMmD+5Es3TtJTYA/KF9EejV63v9ign3CkXQEHoTGmBSvl5jp6b1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB2qennz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB2qennz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193061F00893;
	Mon,  5 Oct 2026 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791225031;
	bh=y4x+qMO4gNb9ywGPSxBUqj5Sccqe67jONCVF04D7448=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oB2qennzMUHmNMufzGgakvVAX5EEhIeQYwv26DpUkQJ4Txhgx7KAT69pJoRZPgqx0
	 OIcU5iK8mGn/i0ML3dbx3/vYs5aMPYkPenIBCixOUaMc8cfGmJFIQAOPfwUekWjKBr
	 4+IWeqgdLsvIFtx31BgcPWPYKF2hGnk/iUy06knkftpwcDxQNZ7W5nOc4qAgUvObSY
	 tjjA5b8RxoO57CmlhAG9fyko3TOl4X0YXofBTxT/4l8/A7HJLvOhKB8eFubrSSg/11
	 W6yJ2UhoQSdSPqECqc17UX/kyidE9NfmJjatneR563WvesbHhailaxhqMkHlJ4r/JM
	 togVv3NDnkiGA==
Subject: Re: [PATCH net v2 2/2] tipc: serialize publication purging with name
 table updates
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 05 Oct 2026 18:30:30 +0000
Message-ID: <179122503065.434549.17120097170406854417@kernel.org>
In-Reply-To: <20261001182924.3928331-3-nicoyip.dev@gmail.com>
References: <20261001182924.3928331-3-nicoyip.dev@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] tipc_publ_notify() (net/tipc/name_distr.c) now calls
  list_del_init(&publ->binding_node) on every selected publication…

--

tipc: serialize publication purging with name table updates

This patch moves a failed node's publications onto a private list while
holding nametbl_lock. It then unlinks and purges one publication per lock
acquisition, so no publication pointer is kept across an unlocked
interval.

Link: https://lore.kernel.org/netdev/20260927180806.1315902-1-nicoyip.dev@gmail.com/

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index acf96562608b9..9a400a1fa4d72 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c
> @@ -230,20 +230,16 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)

[ ... ]

>  	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, p->scope, p->sr.type,
>  		   p->sr.lower, p->sr.upper);
> -	spin_lock_bh(&tn->nametbl_lock);
>  	_p = tipc_nametbl_remove_publ(net, &ua, &p->sk, p->key);
> -	if (_p)
> -		list_del_init(&_p->binding_node);
> -	spin_unlock_bh(&tn->nametbl_lock);
>  	if (_p)
>  		kfree_rcu(_p, rcu);
>  }
> @@ -254,10 +250,27 @@ void tipc_publ_notify(struct net *net, struct list_head *nsub_list,

[ ... ]

> +	for (;;) {
> +		spin_lock_bh(&tn->nametbl_lock);
> +		if (list_empty(&purge_list)) {
> +			spin_unlock_bh(&tn->nametbl_lock);
> +			break;
> +		}
> +		publ = list_first_entry(&purge_list, struct publication,
> +					binding_node);
> +		list_del_init(&publ->binding_node);
>  		tipc_publ_purge(net, publ);

[Severity: Medium]
What happens to publ here if tipc_nametbl_remove_publ() returns NULL
inside tipc_publ_purge()?

The old code only unlinked binding_node when removal succeeded:

	if (_p)
		list_del_init(&_p->binding_node);

A failed removal left the publication on n->publ_list, so a later
node-down purge would try it again. With this change, list_del_init() runs
before the removal is attempted. tipc_publ_purge() also drops a NULL
result silently.

So a publication that fails removal stays in the name table but is no
longer on any node publication list. Can it then be orphaned for good?

A failed removal looks reachable through an existing problem with
duplicate ranges. This part predates the patch. In
tipc_service_create_range(), equal lower bounds always go left:

	if (lower <= sr->lower)
		n = &parent->rb_left;
	else
		n = &parent->rb_right;

After a rotation, an exact match in a right subtree is missed. For one
service type, with every range published by the same remote node:

  1. Insert R1=[10,20] (pubA), then R2=[10,30] (pubB). R2 becomes the
     left child of R1.
  2. Insert R3=[10,40] (pubC). After the rebalance, R2 is the root, R3 is
     on its left and R1 is on its right.
  3. Insert pubD=[10,20]. The walk goes R2 -> R3 -> NULL and never
     reaches R1. A duplicate [10,20] range R4 is created as the left
     child of R3.
  4. n->publ_list holds pubA, pubB, pubC, pubD in that order, because
     tipc_node_subscribe() uses list_add_tail().

On node-down, the new loop picks pubA first and unlinks it. Then
tipc_service_find_range() returns the leftmost exact match, R4.
tipc_service_remove_publ(R4, skA, keyA) returns NULL because R4 only
holds pubD.

The loop goes on to purge pubB, pubC and pubD, and R4 is erased. pubA is
left in R1 and is no longer on any node list.

If the peer reconnects, tipc_service_insert_publ() rejects the
re-published pubA as a duplicate, so pubA never goes back on the node
list. If the peer then goes down without withdrawing it, pubA stays in
the name table until tipc_nametbl_stop().

Until then, lookups can still pick the dead node/port, and topology
subscribers never get TIPC_WITHDRAWN for it. The remote peer controls the
order through its bind() calls.

Could tipc_publ_purge() return whether the removal succeeded, so the
caller can keep or re-queue the publication when it fails?

> +		spin_unlock_bh(&tn->nametbl_lock);
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001182924.3928331-1-nicoyip.dev%40gmail.com
