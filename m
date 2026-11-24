Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795492184;
	b=hOejUBQ8j9yZrX+WUXyJ+Upm9IFo9YWuXWxZZ3+NIw30svvRwaD3HM+7QMxazIrUg9ZP
	 7yhUW/B4bzI9b0wiOuxUVypvod++AOCRX0tHoGwdeVDsG0j57ihF0ZQ+E7SR4K0iF8xKP
	 WKRQkGB5Xea2LZoux18cgRzXhjjwQv4CgzZv25WjZ8G0wIqNW+wnJ4Di3plMDmAdoKqZN
	 YaA4y6Zrb9B4iJoFlMKkAg4s5ygn96nlLuwBuQFifrXi9ZN+U/wNVfeYFbS1yXJPhZNKt
	 C6DDf0mYM8vnTQnYgOThMEA3LZ/qWPsKZUVFenKl5dzG9sMOwqH/92F9YygdRhnP+Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795492184;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=P8oUfBSexavVUTsAsUc+YhXKOctoAO6rQtDj3JDhBYg=;
	b=pgiEBAEti4bGVLchJzGl9TPeJ/eI0u5HveRw1ECB8RE89QELjU4JKtCxY6ZAaZ2HT9OD
	 +w99KVcl957yflFqPmVt0XmhC0o+dGnLkrL3TIOs+MtBqGnvkf6imlEqf/yHHYXVFOe5v
	 CnWu8YnfMJkv53hRUF6Tk4H1J4/9VIfa9FzIuu614kP0/bs54lXsl2unquKGcmDgOXS8k
	 Sl2LYHuCEQEU2Z29e9p0a+bNJy4suPBk83iRgQOeMmK5NUO8jF6kH2oN4OduehcNgsCwp
	 gua0XM7FuNv/6yUM323zN/NGs3P2gGOuqqphO4Rlr1dETMs4Ce/czmzzWILYqnOxzQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giE+FPGm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3D606A31E;
	Tue, 24 Nov 2026 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giE+FPGm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D5B1F000C4;
	Tue, 24 Nov 2026 03:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795492183;
	bh=P8oUfBSexavVUTsAsUc+YhXKOctoAO6rQtDj3JDhBYg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=giE+FPGmL8O4ON1ufgDF/THgDRe+YvddWR3in6YGUDCpM3wD59LkXShqyW84Dcz7+
	 4vIOxPJ5yh1XhqlW6coLCrojxhmOl/0L0BD1QBzMtMvKKkXbizBxPBiFh0wFCkXdv8
	 hm8SbOFmrSn8uSlDSRVtP9yxlDP3u8HSiy/6J06a1/GhCiSlg+nmfUq77iY/riyNjW
	 kCgw/zTQ5hvOPR+bKc0QjYelSiPxkMlBmLIoZhRp3zCNHCscGNEatrEjDB4yIVRluL
	 +3xs4L0vfcdATqE+nEWnnogTQf2FAZ8CCawXqWs/t58zBxf8e3cSnsOYsof0UU32OX
	 KjE1QqWeN34qg==
Subject:
 Re: [PATCH] x25: defer socket cleanup on link termination to process context
From: netdev-bot+sashiko@kernel.org
To: 847807867@qq.com
Cc: ms@dev.tdt.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, netdev-bot+sashiko@kernel.org,
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 03:49:42 +0000
Message-ID: <179549218277.3135.9518512691383315581@kernel.org>
In-Reply-To: <tencent_8BA4FF587EE5579AB67149C5062618DC7109@qq.com>
References: <tencent_8BA4FF587EE5579AB67149C5062618DC7109@qq.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes the X.25 restart and link-termination path
  tear down calls asynchronously.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but struct
  x25_neigh can be freed while its t20timer is still pending or its…

--

x25: defer socket cleanup on link termination to process context

This patch moves the x25_kill_by_neigh() calls in x25_link_control() and
x25_link_terminated() into a per-neighbour work item on a new x25
workqueue, so lock_sock() is no longer called from softirq. The work item
holds references on the neighbour and its net_device, and the NETDEV_DOWN
and NETDEV_CHANGE notifiers flush it.

Closes: https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6

> diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
> index d1e8cd81c2143..424044c1cf974 100644
> --- a/net/x25/x25_link.c
> +++ b/net/x25/x25_link.c

[ ... ]

> @@ -58,6 +60,25 @@ static inline void x25_stop_t20timer(struct x25_neigh *nb)
>  	timer_delete(&nb->t20timer);
>  }
>  
> +static void x25_kill_by_neigh_work(struct work_struct *work)
> +{
> +	struct x25_neigh *nb = container_of(work, struct x25_neigh, kill_work);
> +
> +	x25_kill_by_neigh(nb);
> +	dev_put(nb->dev);
> +	x25_neigh_put(nb);
> +}

[Severity: High]
This is a pre-existing issue and this patch didn't introduce it. Can
struct x25_neigh be freed while nb->t20timer is still pending or its
callback is running?

x25_t20timer_expiry() uses nb and always re-arms itself. It holds no
reference on nb:

net/x25/x25_link.c:x25_t20timer_expiry() {
	struct x25_neigh *nb = timer_container_of(nb, t, t20timer);

	x25_transmit_restart_request(nb);

	x25_start_t20timer(nb);
}

The only cancel is x25_stop_t20timer(). It uses timer_delete(), which
doesn't wait for a running callback, so the callback can re-arm the timer
right after the cancel.

At module exit, x25_exit()->x25_link_free()->__x25_remove_neigh()->
x25_neigh_put()->kfree(nb) never stops t20timer. Suppose the link is in
X25_LINK_STATE_2, for example after a RESTART REQUEST the peer never
confirmed. The timer keeps re-arming, so after rmmod it would fire on
freed memory and call a callback in the unloaded module.

Device teardown has a narrower race. timer_delete() in
x25_link_terminated() (from NETDEV_DOWN) can race with
x25_t20timer_expiry() running on another CPU. The callback re-arms the
timer, and then NETDEV_UNREGISTER->x25_link_device_down() drops the last
reference.

x25_kill_by_neigh_work() adds one more place where the last nb reference
can be dropped without cancelling t20timer. The commit message says the
deferred cleanup "cannot race with neighbour or device teardown". That
seems to hold only for kill_work.

Should t20timer be shut down synchronously before the last reference to
nb is dropped?

> +
> +static void x25_defer_kill_by_neigh(struct x25_neigh *nb)
> +{
> +	x25_neigh_hold(nb);
> +	dev_hold(nb->dev);
> +	if (!queue_work(x25_wq, &nb->kill_work)) {
> +		dev_put(nb->dev);
> +		x25_neigh_put(nb);
> +	}
> +}
> +
>  /*
>   *	This handles all restart and diagnostic frames.
>   */
> @@ -82,7 +103,7 @@ void x25_link_control(struct sk_buff *skb, struct x25_neigh *nb,
>  			break;
>  		case X25_LINK_STATE_3:
>  			/* clear existing virtual calls */
> -			x25_kill_by_neigh(nb);
> +			x25_defer_kill_by_neigh(nb);
>  
>  			x25_transmit_restart_confirmation(nb);
>  			break;

[Severity: Medium]
Does deferring this call change the order of the X.25 restart
handshake?

Before, x25_kill_by_neigh() ran inline. x25_disconnect() reset lci,
state and neighbour on every socket, and x25_clear_forward_by_dev()
removed the forward entries. Both finished before the RESTART
CONFIRMATION was sent and before the next frame was handled.

Now x25_defer_kill_by_neigh() only queues nb->kill_work and returns. The
confirmation goes out and the link stays in X25_LINK_STATE_3, but the old
sockets are still bound to nb with their old LCIs.

Nothing on the softirq paths flushes the work. Only the NETDEV_DOWN and
NETDEV_CHANGE notifiers do. In the lapbether NAPI poll, more frames can
be handled in the same softirq run before the worker gets to run.

In that window, x25_receive_data() looks up an existing socket before it
checks for a call request:

net/x25/x25_dev.c:x25_receive_data() {
	...
	if ((sk = x25_find_socket(lci, nb)) != NULL) {
	...
	if (frametype == X25_CALL_REQUEST)
		return x25_rx_call_request(skb, nb, lci);
	...
	if (x25_forward_data(lci, nb, skb)) {
	...
}

Could a CALL_REQUEST from the peer on a reused LCI go to the stale
socket's x25_process_rx_frame() and never reach x25_rx_call_request()?
Frames for LCIs without a socket would also still be forwarded through
the stale forward entries.

Stale sockets still in X25_STATE_3 can also reach
x25_kick()->x25_transmit_link(). In link state 3 this sends DATA on LCIs
the peer considers cleared.

In link states 0 to 2 the frames are queued on nb->queue instead.
x25_link_terminated() already purged that queue and the deferred kill
doesn't purge it again, so the frames go out after the link comes back.

When the work finally runs, x25_kill_by_neigh() matches sockets only by
neighbour pointer:

	if (x25_sk(s)->neighbour == nb) {

Wouldn't calls set up on the restarted link before the worker runs, via
x25_rx_call_request() or x25_connect(), also be disconnected with
ENETUNREACH? A pending work item also absorbs later requests. A single
late sweep would then kill every socket attached when it runs.

The same applies in three other places:

- The X25_RESTART_CONFIRMATION case, where the restart request is sent
  and nb->state moves to X25_LINK_STATE_2 first.
- x25_link_terminated() on the softirq X25_IFACE_DISCONNECT path, where
  nb->queue is purged and nb->state set to 0 before the sockets are
  detached.
- The in-tree comments ("clear existing virtual calls", "X.25 03/93
  4.6.3"), which now describe an ordering the code no longer provides.

The commit message is tagged for stable but doesn't mention this
behaviour change.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_8BA4FF587EE5579AB67149C5062618DC7109%40qq.com
