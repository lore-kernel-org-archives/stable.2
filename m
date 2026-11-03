Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711411;
	b=TgRfmc59EIfVZnx+6BkB6Lm0MPPCemTnyzYZMMpeI1D5TR5ho6RLjDo0DYDPyP3vMqRn
	 w1Iwg7Oq4Q7tPrvrqic5pU9+K8u86/IX/U1Y6aq44aCf/Ex7PIT/dw405B/s5yRvVdN4u
	 +0GntguKQarUvvZ3pfkqubUx4ZBt4SgP31rfTL+aV3PMvtqUvXGj7jyFMlz2xWJLM6u2n
	 05fdqA5PLWhygIpZMeQiQXhw/LbNDrChGeFyB0TpRJkDAGM152jcgwOYJ9mHuMXUYNRpS
	 yNPLHaScivJL8b4X/pGjQEWe0jT/QxHQk8BZ1VRN7CMx4gSrgLMGe7nK/DhxZpizH1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711411;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jo5LTi7Ipnk5ALv111Fhb9BIHOWi0ShQpR0AC2BDWjA=;
	b=L+e6HLTSj4/DJWmvysIxaIiHE7Laoat3DnC33uw3qzor6lvR0rMBen8ru7UpI9RdAu+D
	 JdaaPNDNJ0lFSrPyL2cU4vtK3UJDjtapjgRpwv8KgayRvDqEDM8APiK2Ut1ncafNKHqyl
	 A7pIUNMQprm9hdWVzMWuC1FnJros6llOcgQo9TLkGui7Vpl4aoMsiQs6EI0Q/s2nrFWr2
	 Of4gpNGu7SSmq6aVZebWFJ0iVVnaqNDSjdWAaetUsEUwImwohPUlKLROWVWe7Ce8qTpC0
	 Llc7IOdvD1CJn/ggLRtL4p1OdV+wsmu20eL8sfLiyRucQbLj7axMvTqWB1kscGzlIbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yql3GuP4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECB606A326;
	Tue,  3 Nov 2026 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yql3GuP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536451F000C1;
	Tue,  3 Nov 2026 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711411;
	bh=jo5LTi7Ipnk5ALv111Fhb9BIHOWi0ShQpR0AC2BDWjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yql3GuP4oA5D9+9jLOfkOL9Z7qKLZufDizHoa+gf5EvPaffArPqGAU74wp4sGc3iy
	 PqOflGNAGCwWqXSFD5neLlI8B8qQLyC6HDOe1g3ovXYv2GvHBFJmErVMzPXNwQ83+K
	 eRdak+e33qAVhphLVOIEu6yn5U5gn1zimzZ4x1AC82nGWbkCHt7Ha4GEIZPX/IOsPA
	 dM4cLTTLP+DWSxESBEtjXzRyUlVX9fhsEm5QV1E92E/06zNONnmBBfGcoPicfbPwvm
	 POJ5FaBYLnaHCBYOb+rF/tqAm/ehTUjFsrpRqVdF1UZV6LpjFinnIqd9qvPAQ+77q9
	 Sqjbe4sFMZsWQ==
Subject: Re: [PATCH net 1/2] connector/cn_proc: reject invalid mcast_op before
 touching socket state
From: netdev-bot+sashiko@kernel.org
To: cenzhang@linux.microsoft.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, anjali.k.kulkarni@oracle.com,
 liam@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com
Date: Tue, 03 Nov 2026 13:10:09 +0000
Message-ID: <179371140984.488856.3327434902278140181@kernel.org>
In-Reply-To: <20261102130922.75629-2-cenzhang@linux.microsoft.com>
References: <20261102130922.75629-2-cenzhang@linux.microsoft.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] cn_proc_mcast_ctl() changes per-socket state and the global
  proc_event_num_listeners without any serialization, so an unprivileged…

Pre-existing issues:
- [High] At this commit, the per-socket struct proc_input that
  cn_proc_mcast_ctl() allocates (cn_proc.c:438) whenever…

--

connector/cn_proc: reject invalid mcast_op before touching socket state

With this commit, cn_proc_mcast_ctl() rejects any mcast_op other than
PROC_CN_MCAST_LISTEN or PROC_CN_MCAST_IGNORE before per-socket state is
created or modified. It also drops the default case of the switch, which
can no longer be reached. This keeps an invalid op followed by IGNORE from
decrementing proc_event_num_listeners for a socket that never listened.

> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 0056ab81fbc39..4f613c0648ae4 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -421,6 +421,12 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  		return;
>  	}
>  
> +	if (mc_op != PROC_CN_MCAST_LISTEN &&
> +	    mc_op != PROC_CN_MCAST_IGNORE) {
> +		err = EINVAL;
> +		goto out;
> +	}
> +
>  	ev_type = valid_event((enum proc_cn_event)ev_type);
>  
>  	if (ev_type == PROC_EVENT_NONE)

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can the
proc_input allocated a little further down in cn_proc_mcast_ctl() leak?

drivers/connector/cn_proc.c:cn_proc_mcast_ctl() {
    ...
		if (sk->sk_user_data == NULL) {
			sk->sk_user_data = kzalloc_obj(struct proc_input);
    ...
}

This allocation happens for any socket that sends LISTEN or IGNORE to
portid 0, whether or not it has joined CN_IDX_PROC. At this commit the only
free is in cn_release(), and it runs only if the socket is a group member
at close:

drivers/connector/connector.c:cn_release() {
	if (groups && test_bit(CN_IDX_PROC - 1, groups)) {
		kfree(sk->sk_user_data);
		sk->sk_user_data = NULL;
	}
}

netlink_sock_destruct() does not free sk_user_data either. A socket that
never joins the group, or leaves it before close, keeps its proc_input.
A user in the initial namespaces could repeat socket(), send and close to
leak kmalloc-8 objects without limit.

A later patch in the series appears to resolve this: "connector/cn_proc:
release socket state and listener count on close" makes cn_release() call
cn_proc_release() unconditionally, and cn_proc_release() frees
sk_user_data.

[ ... ]

> @@ -455,9 +461,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  		((struct proc_input *)(sk->sk_user_data))->event_type =
>  			PROC_EVENT_NONE;
>  		break;
> -	default:
> -		err = EINVAL;
> -		break;
>  	}
>  
>  out:

[Severity: High]
Even with the new mcast_op check, can concurrent senders on the same
socket still drive proc_event_num_listeners negative?

The commit message describes this outcome:

  "drives the count negative; every proc_*_connector() then returns
  early and no process events are delivered to any subscriber"

As far as I can see, nothing serializes cn_proc_mcast_ctl() for a given
socket:

- netlink_sendmsg() does not take the socket lock.
- netlink_unicast_kernel() calls nlk->netlink_rcv() (cn_rx_skb) in the
  sender's context.
- cn_call_callback() drops queue_lock before it runs the callback:

drivers/connector/connector.c:cn_call_callback() {
    ...
	spin_unlock_bh(&dev->cbdev->queue_lock);

	if (cbq != NULL) {
		cbq->callback(msg, nsp);
    ...
}

Inside cn_proc_mcast_ctl(), reading prev_mc_op, storing the new mcast_op
and doing the inc/dec are separate unlocked steps:

		} else {
			prev_mc_op =
			((struct proc_input *)(sk->sk_user_data))->mcast_op;
		}
		...
		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
	...
	case PROC_CN_MCAST_IGNORE:
		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
			atomic_dec(&proc_event_num_listeners);

Take two threads sharing one NETLINK_CONNECTOR fd, after a single LISTEN:

thread A                          thread B
IGNORE: prev_mc_op = LISTEN
                                  IGNORE: prev_mc_op = LISTEN
mcast_op = IGNORE
                                  mcast_op = IGNORE
atomic_dec()
                                  atomic_dec()

That is a net -1 from this socket. Another LISTEN followed by another
racing pair repeats it. The window is narrow, but it can be retried
indefinitely. Once the count is below 1, every proc_*_connector() returns
early, and no subscriber gets events, including root-owned monitors.

Two racing first messages can also both see sk_user_data == NULL. Both then
kzalloc and both set initial = 1. One proc_input is overwritten and leaked,
and two LISTENs add +2 for a single socket.

The later "connector/cn_proc: release socket state and listener count on
close" patch in the series adds another path. Suppose a LISTEN races an
IGNORE that saw prev_mc_op == LISTEN, and the LISTEN's store of mcast_op
lands last. The IGNORE has already decremented, and cn_proc_release()
decrements again on close:

	if (input->mcast_op == PROC_CN_MCAST_LISTEN)
		atomic_dec(&proc_event_num_listeners);

Would it make sense to serialize the per-socket update? One option is a
lock around the allocation and the prev/new update. Another is xchg() on
mcast_op, with the inc/dec chosen from the returned old value.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102130922.75629-1-cenzhang%40linux.microsoft.com
