Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64B34EEEE;
	Sat, 10 Oct 2026 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611965; cv=none; b=TOkN2gndI18rN35oFRPpTiXsPe3dmpvUVzDNa8QGPYFrN516Fkv1YkpzhbswsfHjXXmIT8IbsZ+d4Lv2TqC3LKvQWQ+y+v8HXCC178srxnrTC3Ws6XWnshMnw+oqdZlbC7PqpGv8MfrsehNJGjJ0s6pT3AlnEh8Z5TFLz/2+1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611965; c=relaxed/simple;
	bh=ECDYU8nvA5nDoKAMn0PLElWGN0Ucb2tYuKNsjYUtS8o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmxZkoT4PqhDY62kUstNgM/baomnxMLw7PWz5nYz7HaIeAzlS3pCMoZlWr3qqAui6xC5ATuQPKNA06ik6122RDj7rMZob4UkLfURsmWSs1iONgwDSBC1mtUMskWh7/8C6chVKpAGp83TZoKRnTnlIYeDl41mSYA4KjeIEQ0A6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHxoOt6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHxoOt6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442941F00893;
	Sat, 10 Oct 2026 05:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791611964;
	bh=yN1ic1zNRdHQvR2RxJiOmxDR5GhPGFRlzQ+rr/yhTXk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XHxoOt6DAAr7sZ+AfKsM78JU4EI02Ctk3TDxCEYzfFtwA7CyFGU5gleICEZQDAXF1
	 jbfcS7sd8xAOKD3ZBkiE3xda0KbRss2u9/XziuSKYcmx86B9YWGdmKWQwAPc/fZ75p
	 DqaIAFk1oZ5hhr8GhRwa+PS0eVZ1LlUFQ/vuWiWY2GsdgoHv42QhdPsIBdsuusIBux
	 qE2ZoJmyQZiA0zYs9ssKI+J4bRo+kwA/W/Ynl3T3Sjp88puQwMT01VrMVk6HyqHTnm
	 Y6F18VtzfL1rAaCD0AMyPy0UMPUn3h0Sbpz4qAZGEI93UdqC+87K+d7vRWCHRof/YC
	 ePPGwV4XkCwxA==
Subject:
 Re: [PATCH] tipc: fix broadcast sender hang and leak on last acker departure
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, ying.xue@windriver.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 10 Oct 2026 05:59:22 +0000
Message-ID: <179161196277.434549.7319105806730748323@kernel.org>
In-Reply-To: <20261009055601.2304158-1-bsdhenrymartin@gmail.com>
References: <20261009055601.2304158-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new open-restore in tipc_group_delete_member()
  (net/tipc/group.c:346-348) depends on less(m->bc_acked,…
- [Low] The commit message does not match the patch.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a node-down
  withdrawal event can get stuck behind a deferred unicast, so the…
- [Low] This problem wasn't introduced by this patch, but
  tsk->group_is_open (aliased as *grp->open) is written with plain…

--

tipc: fix broadcast sender hang and leak on last acker departure

This patch makes tipc_group_delete_member() restore *grp->open when
grp->bc_ackers drops from 1 to 0. It also makes tipc_sk_filter_rcv() call
sk->sk_write_space() when tipc_group_filter_msg() switches the group from
closed to open. The aim is to unblock group broadcast senders when the
last outstanding acker leaves.

> tipc: fix broadcast sender hang and leak on last acker departure

[Severity: Low]
Which leak does this patch fix? The diff only adds the reopen and the
wakeup. The kfree(m) and the bc_ackers decrement in
tipc_group_delete_member() were already there.

This patch carries Cc: stable and a Fixes: tag. Could "leak" be dropped
from the subject so it doesn't mislead backporters?

> blocked senders; write() then sleeps until the send timeout and
> poll() is never woken at all.

Is the write() part accurate? tipc_wait_for_cond() sleeps in wait_woken()
with woken_wake_function(), and that function doesn't filter on the poll
key:

net/tipc/socket.c:tipc_wait_for_cond() {
    ...
	add_wait_queue(sk_sleep(sk_), &wait_);
	release_sock(sk_);
	*(timeo_) = wait_woken(&wait_, TASK_INTERRUPTIBLE, *(timeo_));
    ...
}

So any tipc_data_ready() on the socket wakes the writer and re-runs
tipc_group_bc_cong(). One example is delivery of the TIPC_WITHDRAWN member
event when TIPC_GROUP_MEMBER_EVTS is set.

If no such wakeup comes, the default blocking sk_sndtimeo is
MAX_SCHEDULE_TIMEOUT, so there is no bounded send timeout either.

The poll() part looks correct, since tipc_poll() reports EPOLLOUT only
when tsk->group_is_open is set.

> diff --git a/net/tipc/group.c b/net/tipc/group.c
> index 74f6d3dac0784..e20eb612f82ce 100644
> --- a/net/tipc/group.c
> +++ b/net/tipc/group.c
> @@ -340,9 +340,12 @@ static void tipc_group_delete_member(struct tipc_group *grp,
>  	rb_erase(&m->tree_node, &grp->members);
>  	grp->member_cnt--;
>  
> -	/* Check if we were waiting for replicast ack from this member */
> -	if (grp->bc_ackers && less(m->bc_acked, grp->bc_snd_nxt - 1))
> -		grp->bc_ackers--;
> +	/* If this member held the last outstanding replicast ack,
> +	 * restore the open state so blocked broadcast senders can proceed.
> +	 */
> +	if (grp->bc_ackers && less(m->bc_acked, grp->bc_snd_nxt - 1) &&
> +	    !--grp->bc_ackers)
> +		*grp->open = true;

[Severity: Medium]
Can this reopen the group while a counted acker is still outstanding?

The less(m->bc_acked, grp->bc_snd_nxt - 1) check also matches members
that were never counted in bc_ackers. tipc_group_update_bc_members() only
counts a member, and refreshes its bc_acked, when tipc_group_is_receiver()
is true:

net/tipc/group.c:tipc_group_update_bc_members() {
    ...
		if (tipc_group_is_receiver(m)) {
			tipc_group_update_member(m, len);
			m->bc_acked = prev;
			ackers++;
		}
    ...
}

tipc_group_is_receiver() excludes MBR_JOINING and MBR_LEAVING. A member in
either state keeps a stale bc_acked.

For example, say members X and Y are both JOINED:

  - A non-ack broadcast at seqno 10 sets X.bc_acked = Y.bc_acked = 9 and
    bc_snd_nxt = 11.
  - X becomes MBR_LEAVING. This can happen when TIPC_WITHDRAWN arrives
    with the node still up and before GRP_LEAVE_MSG, or when the leave
    event is still waiting in m->deferredq.
  - The local socket sends a unicast. tipc_send_group_anycast()/unicast
    then sets method->rcast and method->mandatory, so the next broadcast
    goes out as an ack-requesting replicast at seqno 11. Only Y is
    counted: bc_ackers = 1, Y.bc_acked = 10, bc_snd_nxt = 12.
  - X's leave event is delivered, and tipc_group_filter_msg() calls
    tipc_group_delete_member(X).

At that point less(9, 11) is true. So --bc_ackers reaches 0 and *grp->open
is set to true, even though Y hasn't acked yet.

The new check in tipc_sk_filter_rcv() then sees this:

	if (!was_open && tsk->group_is_open)
		sk->sk_write_space(sk);

The writer blocked in tipc_send_group_bcast() wakes up and
tipc_group_bc_cong() returns false. The next broadcast can then go out,
possibly over the broadcast link, before Y has acked the replicast.

Doesn't that break the unicast/broadcast ordering that commit 2f487712b893
added the bc_ackers gate for? Y's later GRP_ACK_MSG is also dropped by the
!grp->bc_ackers check in tipc_group_proto_rcv().

The miscount itself predates this patch. Before it, a false zero only
took effect on the next send or the next unrelated wakeup. With this
patch it causes an immediate wakeup and EPOLLOUT. The new comment ("If
this member held the last outstanding replicast ack") also doesn't hold
in this case.

Would it be better to record whether the member was counted when the
replicast was sent, for example with a per-member pending-ack flag,
instead of comparing a possibly stale bc_acked?

[Severity: Medium]
This is a pre-existing issue and not one introduced by this patch. Can
the departure path that leads here get stuck behind a deferred unicast,
so that this reopen never runs?

A member's group unicast carries msg_grp_bc_seqno = N+1. It can arrive
before that member's broadcast N, which travels on a different link. The
unicast is then deferred in m->deferredq with m->bc_rcv_nxt == N.

If the peer node fails before broadcast N arrives, tipc_group_member_evt()
creates the withdrawal event with seqno m->bc_rcv_nxt:

net/tipc/group.c:tipc_group_member_evt() {
    ...
		if (!tipc_node_is_up(net, node))
			tipc_group_create_event(grp, m, TIPC_WITHDRAWN,
						m->bc_rcv_nxt, inputq);
    ...
}

tipc_group_sort_msg() only sorts BCAST/MCAST messages, so the event is
appended behind the deferred unicast:

	/* Unicasts are never bypassed, - always add to tail */
	__skb_queue_tail(defq, skb);

tipc_group_filter_msg() then peeks the unicast at the head of the queue
and stops:

		if (more(msg_grp_bc_seqno(hdr), m->bc_rcv_nxt))
			break;

Broadcast N is lost along with the node, so tipc_group_delete_member() is
never called for this member, and the stale member stays in the tree. If
that member was the last outstanding acker, bc_ackers stays non-zero and
group broadcasts on this socket stay blocked.

Should the node-down case be handled before the event is queued behind
messages that can no longer be delivered?

[Severity: Low]
This isn't a bug introduced by this patch, but tsk->group_is_open (which
*grp->open points to) is written with plain stores under the socket lock.
tipc_poll() reads it without the lock:

net/tipc/socket.c:tipc_poll() {
    ...
	case TIPC_OPEN:
		if (tsk->group_is_open && !tsk->cong_link_cnt)
			revents |= EPOLLOUT;
    ...
}

This new store is one more writer of the same kind as the ones in
tipc_group_create(), tipc_group_cong(), tipc_group_bc_cong(),
tipc_group_open() and the GRP_ACK_MSG handler. The new was_open read in
tipc_sk_filter_rcv() runs under the socket lock, so it is fine.

Could KCSAN report this as a data race? If so, READ_ONCE()/WRITE_ONCE()
annotations on group_is_open would cover all of these accesses.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009055601.2304158-1-bsdhenrymartin%40gmail.com
