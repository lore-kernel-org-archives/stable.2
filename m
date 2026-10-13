Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8445515970;
	Tue, 13 Oct 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908661; cv=none; b=UAMyniA/uWiZrKGIRuTIVdsu6o69O0ceXIW4qDTu2tnBG0Oz2N+OnmbflvKHyPa4fqMQXyf772dT33VOgT843mHfCF8bqL2Ho1HadCNQ5pOppXD4Cuh6swA4lHwgO1TkYIZTrb8j0fF0m6oKGA4c51wpC2PvKn5yx0UdyCTquz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908661; c=relaxed/simple;
	bh=/mEx8vdFcfI3hLMAtaYNjZl+5y7yaZRJJk6u/Lg1E6A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BeCm0caVRXfNY2AXCDOO4pYJEWBkI3xLGf8ENIM2FIp/aEGQaPTKMAk7npLHwmoIyx33NfqDTgDcGA+i1v/Nnjm24eQfqwngniyqGjJao/p3puUpYj9cudGjrja2CFEeDtJq2/CnofNEN1ZYe/49sSKeIRjrncDpiGzI5DCMjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtZ4ut8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtZ4ut8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CFC1F000FF;
	Tue, 13 Oct 2026 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908660;
	bh=awofmRGa51mWfxvkSwx2u56skeAV3P8MmfNnS2lWxu0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jtZ4ut8FeIVqhdA0zFO0OZB2I/jyr+koVsoBc+speykIcENvqEJXENgarRat7TpZt
	 U53jry6971Ptn4euEfIGMOhVnpMt2O7TD3p04w4qeKGHwbOteugDTG2PR3k7iDXVUx
	 STeWzjjGNk2v/V6PVKM/7VHzuQlvZcw5EqGvEuKb2ugqRsoNTgrLZqQwMj2m5IpRLK
	 nosztYQQrB4SDltmGmCMYGtn+VEeQkfHFXWCwTiYBBM8mu1aAAV58fjEeW1zqsHZ6C
	 xoXztTAfmC4kbXg3UaEW2OFqO9ioaaX82/XIXJ0EN+wE7y4fjPO9dJGiYT/+EVpW0J
	 TIJn286JGWDJA==
Subject:
 Re: [PATCH net v2] tipc: fix broadcast sender hang on last acker departure
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ying.xue@windriver.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 13 Oct 2026 16:24:19 +0000
Message-ID: <179190865919.434549.2450236888091417368@kernel.org>
In-Reply-To: <20261012153357.1863316-1-bsdhenrymartin@gmail.com>
References: <20261012153357.1863316-1-bsdhenrymartin@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds m->bc_pending so that only members counted for
  the current replicast can reduce grp->bc_ackers, but it checks the…
- [Low] The commit message gives the wrong reason why blocked writers
  stay asleep, and it overstates when the blocking sendmsg() hang…

--

tipc: fix broadcast sender hang on last acker departure

This patch restores *grp->open when the last member that owes a replicast
ack is deleted. It also calls sk->sk_write_space() from tipc_sk_filter_rcv()
when the group becomes writable again. A new per-member bc_pending flag
limits the bc_ackers decrement in the delete path to members that were
counted for the current replicast.

> TIPC group broadcast senders are blocked while a replicast still has
> outstanding member acks: poll(EPOLLOUT) only fires when
> tsk->group_is_open, and writers keep re-sleeping on every unrelated
> data-ready wakeup because tipc_group_bc_cong() keeps seeing
> *grp->open == false (the default sk_sndtimeo is MAX_SCHEDULE_TIMEOUT,
> so there is no bounded send timeout either).

[Severity: Low]
Is this description of the mechanism accurate? tipc_group_bc_cong() only
writes *grp->open and never reads it:

net/tipc/group.c:tipc_group_bc_cong() {
	if (grp->bc_ackers) {
		*grp->open = false;
		return true;
	}
	if (list_empty(&grp->small_win))
		return false;
	...
}

Its return value depends only on grp->bc_ackers and the head of
grp->small_win.

> When the last outstanding acker departs before acking,
> tipc_group_delete_member() decrements grp->bc_ackers but never
> restores *grp->open, and the blocked senders are never woken.

The old delete path already brought bc_ackers to 0 when the last owing
member left. That member has bc_acked == S-1 and bc_snd_nxt == S+1, so the
less() test matches.

tipc_wait_for_cond() waits with woken_wake_function, which ignores the poll
key, and tipc_data_ready() wakes every sleeper on sk_wq.

So with group member events enabled, the sk_data_ready() after the leave
event is delivered already woke the writer in tipc_send_group_bcast().
tipc_group_bc_cong() then returned false and sendmsg() went on, returning
EHOSTUNREACH if the group was now empty.

The poll(EPOLLOUT) hang does look real in every case, because tipc_poll()
only sets EPOLLOUT when tsk->group_is_open is true.

The blocking sendmsg() hang seems to happen only when nothing wakes the
writer after the deletion. One example is group member events being
disabled. In that case TIPC_GRP_MEMBER_EVT is freed with deliver = false
and sk_data_ready() is never called.

The code change itself looks correct. Since this is tagged for stable,
could the changelog describe the actual wakeup path and say when the
sendmsg() hang occurs?

> diff --git a/net/tipc/group.c b/net/tipc/group.c
> index 74f6d3dac0784..e9c77f12c9819 100644
> --- a/net/tipc/group.c
> +++ b/net/tipc/group.c

[ ... ]

> @@ -340,9 +341,12 @@ static void tipc_group_delete_member(struct tipc_group *grp,
>  	rb_erase(&m->tree_node, &grp->members);
>  	grp->member_cnt--;
>  
> -	/* Check if we were waiting for replicast ack from this member */
> -	if (grp->bc_ackers && less(m->bc_acked, grp->bc_snd_nxt - 1))
> -		grp->bc_ackers--;
> +	/* If this member owed an ack for the current replicast and it
> +	 * was the last one, restore the open state so blocked broadcast
> +	 * senders can proceed.
> +	 */
> +	if (grp->bc_ackers && m->bc_pending && !--grp->bc_ackers)
> +		*grp->open = true;
>  
>  	list_del_init(&m->list);
>  	list_del_init(&m->small_win);
> @@ -406,6 +410,8 @@ void tipc_group_update_bc_members(struct tipc_group *grp, int len, bool ack)
>  			m->bc_acked = prev;
>  			ackers++;
>  		}
> +		if (ack)
> +			m->bc_pending = tipc_group_is_receiver(m);
>  	}
>  
>  	/* Mark number of acknowledges to expect, if any */
> @@ -803,6 +809,7 @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
>  		if (acked != grp->bc_snd_nxt || m->bc_acked == acked)
>  			return;
>  		m->bc_acked = acked;
> +		m->bc_pending = false;
>  		if (--grp->bc_ackers)
>  			return;
>  		list_del_init(&m->small_win);

[Severity: Medium]
Should the GRP_ACK_MSG handler also check m->bc_pending before it
decrements grp->bc_ackers?

The new test in tipc_group_delete_member() assumes bc_ackers equals the
number of members with bc_pending set.

This handler still decrements bc_ackers for any member that passes the
acked == grp->bc_snd_nxt and m->bc_acked != acked checks.

Two kinds of member can pass those checks without having been counted:

- Members that were MBR_JOINING or MBR_LEAVING when
  tipc_group_update_bc_members() ran keep a stale bc_acked and get
  bc_pending = false.
- Members created after the replicast have bc_pending = false and
  bc_acked = bc_snd_nxt - 1 from tipc_group_create_member().

For both, a GRP_ACK_MSG carrying acked == bc_snd_nxt passes every check
here.

For example, with bc_ackers == 2 for counted members A and B:

  ack from uncounted member X     bc_ackers 2 -> 1
  B acks, or B is deleted         bc_ackers 1 -> 0, *grp->open = true

A still has bc_pending == true and has never acked.

Isn't this the case the commit message gives as the reason for adding
bc_pending, where a non-counted member "could silently void a
still-outstanding ack from a real acker"?

A cluster peer can trigger this. It sends GRP_JOIN_MSG, which makes
tipc_group_proto_rcv() create an MBR_JOINING member for any port. It then
sends GRP_ACK_MSG with acked == bc_snd_nxt. I could not find a benign
protocol sequence that ends up here.

Would something like this close the gap?

	if (acked != grp->bc_snd_nxt || !m->bc_pending)
		return;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012153357.1863316-1-bsdhenrymartin%40gmail.com
