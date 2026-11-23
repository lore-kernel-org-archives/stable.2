Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795398009;
	b=CnQO6dXK4dl96YGywT/A5+JHb+NveRqgopwVWyQOnaMYgQmHiqAUPZd2uPwQWj2CiVoL
	 HirLGrMEhl2dm79jIY+O891+3fiKXWqLhTkefgTeulduoxtHZJ75h5Icup625zXwcPUbz
	 RXL4skZzqIR6aWNMzsSCM4YJKNAvHS/Fdb9oeGnZcSnAk0vQ0mD4x+xX8YKbiFD+MRR3r
	 RWfhHyCMN3dUgatJB4FiBArONSGshRs5y4USzRBqv/qkaO0KEfhuvWRE0Qze1TFLkDgs+
	 N+MLFwXyrO0+Z2FkRYYb0p2EfNnH9F1xI4ycmp0kXVbyQAkyJoDca4IJFfyYyps7cgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398009;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ceIIcc4zK+CPfUbBfPOZqR1EDh72ggw2yVO7k0cL/kQ=;
	b=eDWxxkqAiujz9RkTLw9/gO8On8/o1ApMYjA2+hLc+PaRmNf2BLO60SwOV0BfQXZ9HE3O
	 bJ4kN8qPwcJbGTfQhMuB9ItQv1sB/RS1xUmZ2LECm4kurpqweApz4B00jM8Whq+ujG2OD
	 t2MR4W0okAqsdCV5HCsSp0ub19ZFL5XJPNxHHC0Vfm4GRG9eVK/OJIr7cDvsYrMd//10u
	 omEeb6iuAaRdW7CbdJOPVWolXgrNHm3JdKJw8v2scTCFSUeu9ODIYQWFqwddlYvEleab7
	 y0fNNaxd4pxePSJH1Y1FdJikbOWdWXiKxUfQbmugfmTgAg9oJxUcPT3dJwnFQwxpckQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsKWYh4s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF5606A31A;
	Mon, 23 Nov 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsKWYh4s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4001F000CA;
	Mon, 23 Nov 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795398008;
	bh=ceIIcc4zK+CPfUbBfPOZqR1EDh72ggw2yVO7k0cL/kQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WsKWYh4sY2Lb7noH2Cjog3vul3I/aqK4L4wpahyxWlXhe0ytZeCFa6h9ZbLKFc9X/
	 cuJyEkerxsU/paW8mFIT8I9hjeaH+tEU3rnHKeMSHXCJj5qOib9s4UNc3Sqs2b+snt
	 lVVOeiSrfuwmi9lX7jbRqKIWTg86kmHczAGd6YagP6X/7qfqJUFB2VB6YCDAq+uhi/
	 +oTDFGEVPzPC5V1a/q4UUqtk2DT+oprxjxD8sSKxBYvX0KAyw7VvJU7QTBTPD2kw3z
	 lWSUZ/GtPcPPzSaKuij8Vy74fwS4RqvE8xCPQg9pf6B/ggaKvBScWh8yzxKX2ohowY
	 7+nHJUcXHtE5A==
Subject:
 Re: [PATCH] x25: defer socket cleanup on link termination to process context
From: netdev-bot+sashiko@kernel.org
To: 847807867@qq.com
Cc: ms@dev.tdt.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, netdev-bot+sashiko@kernel.org,
 stable@vger.kernel.org
Date: Mon, 23 Nov 2026 01:40:07 +0000
Message-ID: <179539800759.3135.17245752044060918891@kernel.org>
In-Reply-To: <tencent_EC124B80BC53531B2EAB18DD04B37BAE7406@qq.com>
References: <tencent_EC124B80BC53531B2EAB18DD04B37BAE7406@qq.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes clearing of existing virtual calls
  asynchronous.
- [Low] x25_device_event() (net/x25/af_x25.c) calls x25_link_terminated()
  from two process-context notifier events, and the patch treats them…

--

x25: defer socket cleanup on link termination to process context

This patch moves x25_kill_by_neigh() out of softirq context and into a
per-neighbour work item on a new dedicated x25 workqueue, which avoids
calling lock_sock() from softirq. The work holds references on the
neighbour and its net_device, and NETDEV_DOWN flushes the work.

Closes: https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6

> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index f45c9ec7d2c68..a1a8bc203a24f 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -222,6 +222,7 @@ static int x25_device_event(struct notifier_block *this, unsigned long event,
>  			nb = x25_get_neigh(dev);
>  			if (nb) {
>  				x25_link_terminated(nb);
> +				flush_work(&nb->kill_work);
>  				x25_neigh_put(nb);
>  			}
>  			x25_route_device_down(dev);

[Severity: Low]
NETDEV_DOWN now flushes kill_work. Should the NETDEV_CHANGE case in
x25_device_event() flush it as well?

net/x25/af_x25.c:x25_device_event() {
    ...
		case NETDEV_CHANGE:
			if (!netif_carrier_ok(dev)) {
				nb = x25_get_neigh(dev);
				if (nb) {
					x25_link_terminated(nb);
					x25_neigh_put(nb);
				}
			}
			break;
    ...
}

Both cases run in process context under RTNL. Before this patch, both
cleared the sockets synchronously.

After carrier loss, the sockets now stay attached to nb with
nb->state == X25_LINK_STATE_0 until the worker runs. During that window
they can still send through x25_transmit_link(), which would queue the
frame and call x25_establish_link().

Only the softirq callers seem to need the deferral. The process-context
callers could keep the old behaviour with a flush, or by calling
x25_kill_by_neigh() directly.

[ ... ]

> diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
> index d1e8cd81c2143..424044c1cf974 100644
> --- a/net/x25/x25_link.c
> +++ b/net/x25/x25_link.c

[ ... ]

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
With this change, does the restart/terminate sequence continue while the
old virtual calls are still bound to nb?

x25_defer_kill_by_neigh() only queues the work and returns. In
x25_link_control(), the restart confirmation (or the restart request,
the move to X25_LINK_STATE_2, and T20 in the RESTART_CONFIRMATION case)
goes out first. nb->queue is also drained in STATE_3 at the end of the
function.

The old sockets are still on x25_list at that point, with
x25->neighbour == nb and their old LCIs. The same applies to
x25_link_terminated(), which sets STATE_0 but leaves the sockets
connected. Neither the softirq X25_IFACE_DISCONNECT path nor
NETDEV_CHANGE flushes the work.

Until the worker runs, a few things look possible.

If the peer reuses an LCI after the restart, x25_receive_data() still
matches the stale socket:

net/x25/x25_dev.c:x25_receive_data() {
    ...
	if ((sk = x25_find_socket(lci, nb)) != NULL) {
		...
		queued = x25_process_rx_frame(sk, skb);
		...
	}

	if (frametype == X25_CALL_REQUEST)
		return x25_rx_call_request(skb, nb, lci);
    ...
}

So could a new CALL_REQUEST on a reused LCI be handed to the old socket
instead of reaching x25_rx_call_request()?

A stale socket can also still transmit via x25_transmit_link(). In
STATE_0 that queues the frame and calls x25_establish_link(), which
brings the link back up for a dead call. In STATE_1/2 the frame is
queued and flushed later onto the restarted link.

When x25_kill_by_neigh_work()->x25_kill_by_neigh() finally runs, it
disconnects every socket whose neighbour == nb at that moment. That
includes calls set up after the triggering event, such as sockets from
x25_rx_call_request() or outgoing calls from x25_connect():

	x25->neighbour = x25_get_neigh(rt->dev);

Can valid new calls get torn down with ENETUNREACH this way? The same
question applies to forwards that x25_clear_forward_by_dev() removes
after being created post-event.

The comments "clear existing virtual calls" and "Out of order: clear
existing virtual calls (X.25 03/93 4.6.3)" also no longer match what
happens synchronously.

One option might be to detach the sockets synchronously in softirq (for
example, mark them dead or clear lci/neighbour under x25_list_lock or
bh_lock_sock()) and defer only the part that sleeps.

> @@ -97,7 +118,7 @@ void x25_link_control(struct sk_buff *skb, struct x25_neigh *nb,
>  			break;
>  		case X25_LINK_STATE_3:
>  			/* clear existing virtual calls */
> -			x25_kill_by_neigh(nb);
> +			x25_defer_kill_by_neigh(nb);
>  
>  			x25_transmit_restart_request(nb);
>  			nb->state = X25_LINK_STATE_2;
> @@ -254,7 +275,7 @@ void x25_link_terminated(struct x25_neigh *nb)
>  	x25_stop_t20timer(nb);
>  
>  	/* Out of order: clear existing virtual calls (X.25 03/93 4.6.3) */
> -	x25_kill_by_neigh(nb);
> +	x25_defer_kill_by_neigh(nb);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_EC124B80BC53531B2EAB18DD04B37BAE7406%40qq.com
