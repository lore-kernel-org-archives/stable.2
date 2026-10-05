Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A83DC4C9;
	Mon,  5 Oct 2026 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234203; cv=none; b=YKGDlFHfANzWxuH+/gl0FFWV24wynQgzjt8V3MKf0FCJK2PEgL0uQg7/dVlastrNvX/E4gfLecj8Iux9JcvYE0D83rlvM8J3JU7+QpoCUutHpPMm5bgMoABQIte+4Vv00HZrfiRGQpHXyD1A95wYf8T75xUSyvgYkocVhefJvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234203; c=relaxed/simple;
	bh=lOUO35f3j7w5DYfrecFPedQEqQvAZsNWCE76tojm9Nw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQTnj4iJJtzcJq5Ar8pFENJoz2of6LNFHZViR+Vl542TIbflSKgma6pTMjjHuLYIBh68uSQonmOPQPBpHAM3ffnKsuSmctwDvwaNbjfmnUsZIWsg8weG+2uz6F8UfMqKhQK6IdwwCQ4gZmN4CKX0CytjvJIF8oWGrAPYDnv/8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeKg3F6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeKg3F6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA7E1F000FF;
	Mon,  5 Oct 2026 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234201;
	bh=jwv0HVGjzrN5FFLbgJcuw1J8O6A9CSjgD+2/fVQWRCM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PeKg3F6KGFyqK8rqNkfgvNJeRlXlWOET6jXV1V08EvejfYCyXrF2qcNBTWc9Y4Qfk
	 o4nv+6ywq5vbdv26+j3AmuMPHv5cf8V0Zn61TAiJF8wxnYMr/9yaY7JGwh0jQhqLcz
	 M9ZP8wyqfPg1BiSqC9Qy6lhPFXRoO4SChX/SiElWdxnMWZz7tGkHzl/RkPiPr9DdvS
	 bZBUPwsmGVu0h5p7CtT9E/O/Aj5WxEmhqWBephwV7h1ufVFIUWHj/gy8i8lMvoTbUV
	 AatKsDT9PhnlKd/B+AoJCemWirmM60znlqzZ9NWIpkE8v7EKS4yrfyOgdzIctqFm7m
	 7cBAdr8BPjaWA==
Subject:
 Re: [PATCH v2 1/2] tipc: skip socketless connections in topsrv teardown
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 21:03:20 +0000
Message-ID: <179123420070.434549.7498402204710379095@kernel.org>
In-Reply-To: <20261004210016.3051310-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261004210016.3051310-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch is not complete on its own.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same
  livelock already exists for socket-backed conns.
- [High] This problem wasn't introduced by this patch, but
  tipc_topsrv_stop() calls conn_get() (plain kref_get()) on any conn…

--

tipc: skip socketless connections in topsrv teardown

This patch makes tipc_topsrv_stop() skip tipc_conn_close() for kernel
subscription connections, which have no socket. These connections can
stay in conn_idr after unsubscribe while send work is still pending.
Calling tipc_conn_close() on them dereferences a NULL con->sock during
netns teardown.

> diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
> index af530c9ed8402..01dd34b758f4b 100644
> --- a/net/tipc/topsrv.c
> +++ b/net/tipc/topsrv.c
> @@ -706,7 +706,8 @@ static void tipc_topsrv_stop(struct net *net)
>  		if (con) {
>  			conn_get(con);
>  			spin_unlock_bh(&srv->idr_lock);
> -			tipc_conn_close(con);
> +			if (con->sock)
> +				tipc_conn_close(con);
>  			conn_put(con);
>  			spin_lock_bh(&srv->idr_lock);
>  		}

[Severity: High]
This avoids the NULL dereference. In the scenario from the commit
message, though, can netns teardown still stall and then hit a
use-after-free on con?

In that scenario, tipc_topsrv_queue_evt() passes its lookup reference
to con->swork:

	if (queue_work(srv->send_wq, &con->swork))
		return;

tipc_topsrv_kern_unsubscr() then drops its two references:

	test_and_clear_bit(CF_CONNECTED, &con->flags);
	tipc_conn_delete_sub(con, NULL);
	conn_put(con);
	conn_put(con);

After that, the pending swork holds the last reference.

At this commit the loop in tipc_topsrv_stop() is:

	spin_lock_bh(&srv->idr_lock);
	for (id = 0; srv->idr_in_use; id++) {
		con = idr_find(&srv->conn_idr, id);
		if (con) {
		[ ... ]

With the new check, the socketless conn gets conn_get() and conn_put(),
which leaves the refcount at 1. The loop then retakes idr_lock and moves
on.

idr_find() returns NULL for every higher id. So idr_lock stays held with
BH disabled and no cond_resched().

Meanwhile the send_wq worker runs:

tipc_conn_send_work()
    conn_put(con)
        tipc_conn_kref_release()
            spin_lock_bh(&s->idr_lock);   <- blocks on the stop loop

tipc_conn_kref_release() is the only place that calls idr_remove() and
decrements s->idr_in_use. So the loop only ends after int id wraps
around, which takes about 2^32 lookups under the spinlock. Won't that
cause soft lockup and RCU stall warnings?

When id gets back to the conn's slot, conn_get() raises a zero refcount.
After spin_unlock_bh(), the release path calls kfree(con). The stop path
then reads con->sock and calls conn_put() on freed memory.

The path is reachable from an unprivileged user in a user+net namespace:

  1. TIPC_GROUP_JOIN (tipc_group_create()->tipc_topsrv_kern_subscr()).
  2. Leave the group or close the socket while topology events are
     queued (tipc_group_delete()->tipc_topsrv_kern_unsubscr()).
  3. Tear down the netns.

The later patch in this series, "tipc: fix use-after-free in netns
teardown", fixes this. Its loop uses idr_get_next_ul() with
kref_get_unless_zero() and drops idr_lock with cond_resched() on every
iteration. Remaining work references are left to
tipc_topsrv_work_stop(). So the problem only exists at this commit.

The two patches carry different Fixes: tags. Could that cause trouble
for bisection, or for stable trees that take this patch without the
follow-up?

[Severity: High]
This isn't a bug introduced by this patch, but the same livelock looks
possible for socket-backed conns too.

Suppose recv or send work already cleared CF_CONNECTED through
tipc_conn_close(), while rwork or swork still holds a reference. The
call to tipc_conn_close() from the stop loop then returns early without
a conn_put():

	disconnect = test_and_clear_bit(CF_CONNECTED, &con->flags);
	[ ... ]
	if (!disconnect)
		return;

The loop's own conn_get()/conn_put() pair leaves the work's reference
in place. The loop then scans empty ids under idr_lock, waiting for
idr_in_use to reach 0.

The worker's final conn_put()->tipc_conn_kref_release() blocks in
spin_lock_bh(&s->idr_lock). Can idr_in_use ever drop while the stop
loop spins?

The later patch in this series, "tipc: fix use-after-free in netns
teardown", also fixes this. With it, the loop ends when
idr_get_next_ul() returns NULL and drops idr_lock on every iteration.

[Severity: High]
This is a pre-existing issue, but can the conn_get() here bring back a
zero refcount? conn_get() is a plain kref_get():

static void conn_get(struct tipc_conn *con)
{
	kref_get(&con->kref);
}

tipc_conn_lookup() uses kref_get_unless_zero() instead.

Say a final conn_put() from rwork, swork or tipc_conn_close() runs on
another CPU while the stop loop holds idr_lock. The conn is then still
visible in conn_idr with a refcount of 0:

CPU1                              CPU2 tipc_topsrv_stop()
                                  spin_lock_bh(&srv->idr_lock)
conn_put(con)
  tipc_conn_kref_release()
    spin_lock_bh(&s->idr_lock)
      (blocks)
                                  con = idr_find(&srv->conn_idr, id)
                                  conn_get(con)    <- refcount from 0
                                  spin_unlock_bh(&srv->idr_lock)
    idr_remove(&s->conn_idr, ...)
    [ ... ]
    kfree(con)
                                  if (con->sock)   <- freed memory
                                      tipc_conn_close(con)
                                  conn_put(con)

Before this patch, tipc_conn_close() already dereferenced con->sock->sk
on the same freed object. The new con->sock read touches the same
memory.

This seems to match the KASAN slab-use-after-free described in the next
patch in the series, "tipc: fix use-after-free in netns teardown". That
patch replaces conn_get() with kref_get_unless_zero() under idr_lock
and sets con = NULL when it fails.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004210016.3051310-1-Jeremy.Jean%40oss.cyber.gouv.fr
