Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA9361DAD;
	Wed, 30 Sep 2026 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734726; cv=none; b=Ij8WpidQu4PD5P9uaWiSdcdhVn43GGzvwP9QykqJk3Cf0Cmw/8o1hNOKhPTne8eu2OSqNiep9mj7bb3whT4ATqdwp0osVZxp2Ov+soOyUeiKs5Kf+1RXs+CUi5bP0MtWCw+cQjdd7VeMr+ibAUglTAwTyqQ41MjqiQk/ZMj1KyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734726; c=relaxed/simple;
	bh=pyQO883NRPojRZfYjmQUGAsitV8JX0aRM2i7kZCM2tA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KollzBZnDeL/LbMXPsJV/8YHJ/qB4Sst9XghNNk14T/KcwbCQCAHNLu+quGLNg1HYJ99HyMEuxy2sRlo+cbjncIaH8T0GFtNrlXHgbX6RJwMJI5yLbK3/tXd4GL8VzDcYAxS7YVbl15r3MAKZSvHG52D3p4DX/ZOuLngE0TKhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD6c7xJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD6c7xJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9911F000FF;
	Wed, 30 Sep 2026 02:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790734725;
	bh=czR0nRm9zndX2MO0cGAliR6Gzy/xWJTBTrMUpOVt7/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QD6c7xJv0aWYw7/xOP+DyARXqsG/eRnXAALehGoLHvVtqdDa6xTOFsHszmwt7HpLY
	 Mi+PMgpIuKPRL86MYagoYbO2iQ7+BYGGbf+J5l4DYuZuKcitDaEjndMZokLhdcsNhg
	 ks2SZNtKrT2VEJ9QzlFyCUamwIDONiavQCT5yitVv7UghW9To4IvKlivURgFFdCzll
	 OytDCRwjA92OHesxOgriFjhJpIDOvlpp2PAjehlluxlU6bkhTts3aYzKYYDPArin2d
	 K8invIJ6slkkV7moJCdHBf2J94E9Nt7UGkxj5qfHTq6HPnT9l5oI4oWQUlG0spkR44
	 eA5mr1VvCgT9w==
Subject:
 Re: [PATCH net v2] tipc: reject name table updates with invalid origin node
From: netdev-bot+sashiko@kernel.org
To: juny24602@gmail.com
Cc: tung.quang.nguyen@est.tech, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, jmaloy@redhat.com,
 junvyyang@tencent.com, stable@vger.kernel.org, corvus@tencent.com
Date: Wed, 30 Sep 2026 02:18:44 +0000
Message-ID: <179073472418.434549.10884281621721922226@kernel.org>
In-Reply-To: <20260928021807.7945-1-juny24602@gmail.com>
References: <20260928021807.7945-1-juny24602@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: it does not check the origin node against
  the peer that sent the message, so the same stale binding_node use-…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the kernel-doc
  for tipc_update_nametbl() in net/tipc/name_distr.c (lines 268-278)…

--

tipc: reject name table updates with invalid origin node

This patch adds an in_own_node() check at the start of
tipc_update_nametbl(). Name table updates whose origin node is 0 or the
local address are now dropped before any publication is inserted or
removed. The goal is to stop a stale binding_node from being left on a
peer's publ_list after kfree_rcu().

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b7..a496e2e9ef623 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c
> @@ -286,6 +286,9 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
>  	u32 key = ntohl(i->key);
>  	struct tipc_uaddr ua;
>
> +	if (in_own_node(net, node))
> +		return false;
> +

[Severity: High]
Does this fully close the problem described in the commit message? The
message names the root cause as orignode never being checked against the
sending peer. This check only filters two special values, so any other
spoofed origin X still gets through.

In tipc_named_rcv() the origin still comes straight from the header:

    node = msg_orignode(hdr);
    ...
    tipc_update_nametbl(net, item, node, msg_type(hdr));

In tipc_rcv(), the peer n found through msg_prevnode() is not passed
down, so nothing compares node with n->addr:

    tipc_named_rcv(net, &n->bc_entry.namedq,
                   &n->bc_entry.named_rcv_nxt,
                   &n->bc_entry.named_open);

Could a link peer A still reach the same list_del_init() use-after-free
through a node X that is known but not up? That could be a node A creates
with discovery frames, or a real node that went down recently. The
sequence would be:

1. A sends a PUBLICATION with origin X. tipc_node_subscribe() does not
   check node_is_up(), so it links p->binding_node into X->publ_list:

    tipc_node_write_lock(n);
    list_add_tail(subscr, &n->publ_list);

2. After delete_at expires, tipc_node_timeout()->tipc_node_cleanup()
   removes X:

    if (!node_is_up(peer) && time_after(jiffies, peer->delete_at)) {
        tipc_node_clear_links(peer);
        tipc_node_delete_from_list(peer);

   X is then freed through tipc_node_put()->tipc_node_kref_release()->
   tipc_node_free(). Nothing on that path empties publ_list. publ_list
   is only purged on NODE_DOWN via tipc_publ_notify(), which has either
   already run or never runs for a node that was never up.

3. A recreates X with discovery, so tipc_node_create() allocates a new
   node. A then sends a WITHDRAWAL with origin X and matching
   type/lower/upper/port/key. tipc_node_unsubscribe() finds the new X and
   runs:

    list_del_init(subscr);

   This goes through binding_node pointers that still point into the
   freed tipc_node.

A spoofed origin for a node that does not exist at all also looks like a
problem. tipc_node_subscribe() only warns in that case, and the
publication is not purged when A goes down. That would let a remote peer
fill the name table with entries that are never cleaned up.

Would it be better to require msg_orignode() == n->addr for the node that
owns bc_entry.namedq? For example, n or its address could be passed into
tipc_named_rcv() from both callers in net/tipc/node.c. That check would
also cover the 0 and own-node cases, so it could replace this one rather
than sit next to it.

[Severity: Low]
This is a pre-existing issue that this patch didn't introduce. The
kernel-doc above tipc_update_nametbl() no longer matches the function:

 * tipc_nametbl_lock must be held.
 * Return: the publication item if successful, otherwise NULL.

The function is static bool and returns only true or false. There is no
tipc_nametbl_lock symbol. The caller tipc_named_rcv() actually holds
tn->nametbl_lock through spin_lock_bh().

This patch adds another return false path. Since the function is being
changed anyway, could the comment be updated at the same time? The only
caller ignores the return value, so there is no runtime impact.

>  	/* A peer-advertised binding with lower > upper can never be matched
>  	 * or withdrawn and would leak the publication; the local bind path
>  	 * rejects such ranges, so reject ranges learned from the network too.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928021807.7945-1-juny24602%40gmail.com
