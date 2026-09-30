Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824C33DEC0;
	Wed, 30 Sep 2026 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728956; cv=none; b=teGCMxhYcnd+rRIsC6MquoAoiMUVrjmy+8CniO606xdfKKwXV/4hdXJV2kYF1rfCdr+vCFKhoFfyhmUn7klcNtl7F+/iRj4M1cS/6slO7NfkFIib/C0yfeg8aLo/Z7ZGOnMX/uRKlPA1nUFO27rEywkyOy/d+hV34IKVgkiGVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728956; c=relaxed/simple;
	bh=A8/uRNV5GIfCz9Fr1v+X9xs7NcJXpdiqlgf8eRybp6M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0vqKcJ7/hTU5tqsxeJJ1F8aZsf6qSiHb4a5Bnl9oEDMPButbdl75H+FW9HXTlplwyi7kC1+nnJhbvJH9SjS0Ayeh5S7Zm0k1UI08OxzuGElgViLM4/DDFnZbJZ2YN2/8HEfxe33gOVg8Dhc9uI07fD/gJp5BZPX8rGrONwUdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFb2XdmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFb2XdmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349201F000FF;
	Wed, 30 Sep 2026 00:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728930;
	bh=QW55E3RT5k1YStdTDvH/xW8A6uvp6qDAYn+HZlnoi9M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cFb2XdmKpaGhEgDnPc2vssLBn09ZodMT4FHJshps2gkxTCBmEzsxC7Oz4w0K+93j/
	 2iA2I5m+eoR9qOBfDoYqn2dmJy435k67nOr20saD/VhLXazlUm0Co33V/DoTTmOgCI
	 v8G+3DtYPSULqoXmdC0uqmQZHJYqAnaccEePsFjV8edM/3SWrAujPVpguWoiWDbHpE
	 ttvJH8mBcJbeQNQ8zO985r0riRxbQfOAq81kPnExNuJge3fX6aFpxjqdcmvu0BkaY5
	 vByzF2A8Gc5uUzVThMEAfDxr4iWItT46pnBsjvuVmYUL9bKtVftXFGSituTr1se0Vp
	 Th37EG8LkXfpQ==
Subject: Re: [PATCH net] tipc: hold a reference to nodes found by link name
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ying.xue@windriver.com, mohan.krishna.ghanta.krishnamurthy@ericsson.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 30 Sep 2026 00:42:08 +0000
Message-ID: <179072892871.434549.4282083923751507319@kernel.org>
In-Reply-To: <20260927064036.3691962-1-nicoyip.dev@gmail.com>
References: <20260927064036.3691962-1-nicoyip.dev@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The kernel-doc for tipc_node_find_by_name() in net/tipc/node.c no
  longer matches the function.

--

tipc: hold a reference to nodes found by link name

The patch makes tipc_node_find_by_name() take a node reference with
kref_get_unless_zero() before it leaves the RCU read-side section. The
LINK_SET, LINK_GET and LINK_RESET_STATS handlers now drop that reference
with tipc_node_put() after their last access to the node. This closes a
use-after-free against timer-driven cleanup of a down peer.

> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index bd91378b75407..2726bee3bb40d 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -2424,6 +2424,8 @@ static struct tipc_node *tipc_node_find_by_name(struct net *net,
>  		if (found_node)
>  			break;
>  	}
> +	if (found_node && !kref_get_unless_zero(&found_node->kref))
> +		found_node = NULL;
>  	rcu_read_unlock();
>  
>  	return found_node;

[Severity: Low]
This isn't a bug, but should the kernel-doc above tipc_node_find_by_name()
be updated to match the new contract? It still says:

 * Returns pointer to node owning the link, or 0 if no matching link is found.

After this change, a non-NULL return carries a reference that the caller
must drop with tipc_node_put(). NULL can also now mean that a link matched
but the node's refcount had already reached zero.

The comment also documents the parameter as @name, while the real
parameter is link_name. That mismatch was already there before this patch.

[ ... ]

> @@ -2634,11 +2639,13 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
>  	if (!link) {
>  		spin_unlock_bh(&le->lock);
>  		tipc_node_read_unlock(node);
> +		tipc_node_put(node);
>  		return -EINVAL;
>  	}
>  	tipc_link_reset_stats(link);
>  	spin_unlock_bh(&le->lock);
>  	tipc_node_read_unlock(node);
> +	tipc_node_put(node);
>  	return 0;
>  }

[Severity: High]
Is the fix complete for the handlers named in the commit message? The
broadcast branch earlier in tipc_nl_node_reset_link_stats() never calls
tipc_node_find_by_name(), so it takes no node reference:

	} else if (strstr(link_name, tipc_bclink_name)) {
		rcu_read_lock();
		list_for_each_entry_rcu(node, &tn->node_list, list) {
			tipc_node_read_lock(node);
			link = node->bc_entry.link;
			if (link && !strcmp(link_name, tipc_link_name(link))) {
				err = tipc_bclink_reset_stats(net, link);
	...

Only the node struct waits for an RCU grace period. The broadcast link is
freed right away, and the pointer is never cleared:

net/tipc/node.c:tipc_node_kref_release() {
	...
	kfree(n->bc_entry.link);
	call_rcu(&n->rcu, tipc_node_free);
}

Could this interleaving still happen?

CPU0 (reset_link_stats, broadcast branch)
  rcu_read_lock()
  list_for_each_entry_rcu() reaches node N

CPU1
  tipc_node_timeout()
    tipc_node_cleanup()
      tipc_node_clear_links(), tipc_node_delete_from_list()
    tipc_node_put(n)
      tipc_node_kref_release()
        kfree(n->bc_entry.link)

CPU0
  tipc_node_read_lock(N)          /* N still valid under RCU */
  link = N->bc_entry.link         /* stale, non-NULL */
  tipc_link_name(link)            /* reads freed memory */
  tipc_bclink_reset_stats(net, link)
    tipc_link_reset_stats()       /* memset of l->stats in freed memory */

The LINK_GET dump path looks exposed in the same way. When
TIPC_NLA_LINK_BROADCAST is set, it runs:

tipc_nl_node_dump_link()->__tipc_nl_add_node_links()->tipc_nl_add_bc_link()

	if (bc_link) {
		*prev_link = i;
		err = tipc_nl_add_bc_link(net, msg, node->bc_entry.link);

This reads bcl->name, bcl->max_win and bcl->stats from the possibly freed
link and copies them into the netlink reply. It also runs without a node
reference.

TIPC_NL_LINK_RESET_STATS only needs GENL_UNS_ADMIN_PERM. The LINK_GET
dumpit has no permission flag.

Two possible fixes: take a node reference with kref_get_unless_zero()
during the RCU walk before touching bc_entry.link, as this patch already
does in tipc_node_find_by_name(). Or move the kfree(n->bc_entry.link) into
the RCU callback tipc_node_free().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927064036.3691962-1-nicoyip.dev%40gmail.com
