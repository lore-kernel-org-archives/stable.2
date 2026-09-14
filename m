Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897E379990;
	Mon, 14 Sep 2026 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789361567; cv=none; b=Rxfdhx4qRfppkvi5sgUDnH2WH5Kt2luUD7rf3i0mW9SUMfV8ZjTdbgbyWPnWcD6rLmajDoEaZ31V5UIDRCfYeDpGRBkyCNhUPYhjT62igRIAfFZbLHydr2VZorgZ7wiuGgO0UxiH5e4q9aDLpbaNzSCKE1H3JGrw2K204QQkTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789361567; c=relaxed/simple;
	bh=6jRdwrWeOpVYyl/KdScpfvKA6VsaIFWLYXoGttNFLt8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOA4ttwk1HuBfGdxAl17Itc8GuEzNOdFO1Ak/dMgPyIjBGXeDo7lqJvA8SmVnAWd7HnNZ47zTVNp/fCp0NShI8s0OGiirk0CfKTO1pUGA/d/YOBicgbXUT2UcGeJdWuf/57yMPQZujW9+LshLMWf6FF3wfkLZAqFxjwZVaEzEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5DfjGBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5DfjGBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9570E1F000FF;
	Mon, 14 Sep 2026 04:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789361565;
	bh=yVisc9vF2tG8Ho6qyXlYRnHc54j42DIkE1I/ylQ34Zw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R5DfjGBLC87YoLcO0DPsq1Jqpu1xe7wwJL8dfc2wUA74ofo8GlzWnTydgCdphBSHc
	 BZTImZBW+e/+nQ+FN765r6/Zf8FmSx34w7TDEZMLCR3NDtLQL1H0zsxNe2ye0XJa0V
	 5lFBmCjvOZ8p6raEqu22rLqnbvqQ6FD6WzUARxecbQjBN4cKzOGGM+k6NX/3TqyPJp
	 52TyQRBHw/kYTP5PEhd47TPvAvJN+W8VchqLyRcHBIOlP+7nQ6T0M6Xo4IrWbqsPqB
	 6KK15zf0CTYuEDEos076ujDER/tXiJj3nsvdJrqdmS0MQiHvBZt4GfNTHFuCuL/OEV
	 Za4y+vfIUmLrA==
Subject: Re: [PATCH net] tipc: reject invalid and unexpected GRP_ACK_MSG to
 prevent bc_ackers underflow
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jamesburton@meta.com,
 stable@vger.kernel.org, security@1seal.org, tung.quang.nguyen@est.tech,
 jmaloy@redhat.com
Date: Mon, 14 Sep 2026 04:52:44 +0000
Message-ID: <178936156410.22033.16977639465746131797@kernel.org>
In-Reply-To: <20260913044233.193927-1-edumazet@google.com>
References: <20260913044233.193927-1-edumazet@google.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] Incomplete ACK accounting in tipc_group_proto_rcv()
  (net/tipc/group.c:799-808): the new validation gates the decrement of…

Pre-existing issues:
- [Medium] Pre-existing (not introduced or claimed by this patch): in
  tipc_send_group_bcast() (net/tipc/socket.c:1131-1137) the packets…

--

tipc: reject invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow

This tightens the GRP_ACK_MSG path in tipc_group_proto_rcv() so that the
message is dropped when grp->bc_ackers is zero, and so that only an ACK
whose value equals grp->bc_snd_nxt (and which is not a repeat of the
member's own last ACK) is allowed to decrement grp->bc_ackers.

> diff --git a/net/tipc/group.c b/net/tipc/group.c
> index 14e6732624e28..74f6d3dac0784 100644
> --- a/net/tipc/group.c
> +++ b/net/tipc/group.c
> @@ -797,10 +797,10 @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
>  		tipc_group_open(m, usr_wakeup);
>  		return;
>  	case GRP_ACK_MSG:
> -		if (!m)
> +		if (!m || !grp->bc_ackers)
>  			return;
>  		acked = msg_grp_bc_acked(hdr);
> -		if (less_eq(acked, m->bc_acked))
> +		if (acked != grp->bc_snd_nxt || m->bc_acked == acked)
>  			return;
>  		m->bc_acked = acked;
>  		if (--grp->bc_ackers)

[Severity: Medium]
The new test gates the decrement on the sequence value and on per-member
duplication.  Does it also need to check that the acking member was one of
the members actually counted into grp->bc_ackers for the current round?

tipc_group_update_bc_members() counts and re-arms receivers only:

net/tipc/group.c:tipc_group_update_bc_members() {
	u16 prev = grp->bc_snd_nxt - 1;
	...
	for (n = rb_first(&grp->members); n; n = rb_next(n)) {
		m = container_of(n, struct tipc_member, tree_node);
		if (tipc_group_is_receiver(m)) {
			tipc_group_update_member(m, len);
			m->bc_acked = prev;
			ackers++;
		}
	}

	/* Mark number of acknowledges to expect, if any */
	if (ack)
		grp->bc_ackers = ackers;
	grp->bc_snd_nxt++;
}

A member in MBR_JOINING or MBR_LEAVING is therefore neither summed into
ackers nor re-armed, so it keeps a stale m->bc_acked.  The same holds for a
member created after the round was published, since
tipc_group_create_member() sets:

	m->bc_acked = grp->bc_snd_nxt - 1;

In both cases m->bc_acked differs from grp->bc_snd_nxt, so a GRP_ACK_MSG
from that member passes both new conditions and still executes
--grp->bc_ackers although it contributed no increment.  The lookup on this
path, tipc_group_find_member(), applies no state filter.

Can that let grp->bc_ackers reach zero while a counted receiver still owes
an ACK?  The number of accepted decrements per round looks bounded by
grp->member_cnt rather than by the counted acker set.

If bc_ackers is cleared early, tipc_group_bc_cong() stops reporting
congestion:

net/tipc/group.c:tipc_group_bc_cong() {
	/* If prev bcast was replicast, reject until all receivers have acked */
	if (grp->bc_ackers) {
		*grp->open = false;
		return true;
	}

so the sender releases the next group broadcast while the previous replicast
round is still outstanding, which is the ordering guarantee from
2f487712b893, one of the Fixes tags on this patch.  The zero-transition
branch also runs list_del_init(&m->small_win) and *m->group->open = true for
the acking member, which need not be a receiver, and the genuine acker's
later ACK is then swallowed by the new !grp->bc_ackers guard, so its
small_win / tipc_group_update_member() bookkeeping never runs.

The commit message states that "each member can acknowledge at most once per
round" - that part holds per member, but does it cover members that were
never counted for the round?

Would a per-round marker set in tipc_group_update_bc_members(), or accepting
only members whose m->bc_acked == grp->bc_snd_nxt - 2, close the remaining
gap?

The u16 wrap to 65535 itself does look closed by the new !grp->bc_ackers
guard, so what is left here is the premature clearing of the counter that
item 2 of the commit message also mentions.

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch - the
patch strictly improves the path - but the same permanent congestion is
still reachable from tipc_send_group_bcast() in net/tipc/socket.c, where the
packets are transmitted before the round state is published:

net/tipc/socket.c:tipc_send_group_bcast() {
	/* Send message */
	rc = tipc_mcast_xmit(net, &pkts, method, dsts, &tsk->cong_link_cnt);
	if (unlikely(rc))
		return rc;

	/* Update broadcast sequence number and send windows */
	tipc_group_update_bc_members(tsk->group, blks, ack);
}

The error return skips the publication entirely, and the failure can happen
after partial delivery:

net/tipc/bcast.c:tipc_rcast_xmit() {
	list_for_each_entry_safe(dst, tmp, &dests->list, list) {
		dnode = dst->node;
		if (!tipc_msg_pskb_copy(dnode, pkts, &_pkts))
			return -ENOMEM;

		if (tipc_node_xmit(net, &_pkts, dnode, selector) == -ELINKCONG)
			(*cong_link_cnt)++;
	}
}

Peers that already received seqno S advance m->bc_rcv_nxt to S + 1 while the
sender's grp->bc_snd_nxt stays at S.  The next broadcast reuses S, and those
peers drop it at the head of tipc_group_filter_msg():

	if (less(msg_grp_bc_seqno(hdr), m->bc_rcv_nxt))
		goto drop;

which is before ack = msg_grp_bc_ack_req(hdr) is evaluated, so they can never
emit the ACK the sender is waiting for and grp->bc_ackers never returns to
zero.  tipc_group_bc_cong() then keeps *grp->open false for the lifetime of
that socket.

Before this patch the same desynchronization additionally wrapped
grp->bc_ackers through the unguarded --grp->bc_ackers, so this change does
remove that part.

Should the round state be published atomically with the transmission, or
rolled back when tipc_mcast_xmit() fails after partial delivery?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913044233.193927-1-edumazet%40google.com
