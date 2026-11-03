Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711412;
	b=cfEPnnQHf7sEdl9Xmu/i2jTnka/DLcfG3uGwKLAUoN7Bd9mQPWw34bG76ByO01dfjygO
	 dXULDu5vZJjf5tUsYPIw9toLZOEsPAn5YpUM+gmGhw8lkPBWo6Bplh42g55dGpi27SWGv
	 SvpCupitCHFt1sH5osftgvbhw+DBE7yBZwLszxKkQt9EuOqEKF6TrKpEwgPKSZKjAq/dr
	 VfyiTaF9/meIQRzllFugOBtjQbuEIuo1DJxfe58BlsSlJG4woEjLHcLeGQRV+Fo9DKRwf
	 y8LGIJ673TbWiJs8EPGZYOGbnmcW9FFjfugeW8f4IGBipEvFsHAd2LFkwpKZmSgyDyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711412;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PSDntGuIfgagBvAExwS6AxASDwHywut+hO3ZGe4XpBM=;
	b=egR+3LtTyBxTxPxFspTzoATrHc/P3+Rp5yLf321o0am4Zz72V8Qtrsf19uXYcduxG43V
	 31lPnsfLkbMd+ZXb9pqfu4vzifmcYO+peAMlZp4CSCCXZCKvAIXlGj9WzUmpCMFSKVcCM
	 EfmROie0UPN+RRm5Pk4TnzFWLDFT5mdKOxLe5fId49DpmwtcwNnHeSXQNvnDPg63rrbNu
	 /tXst5DANkxILy3LzqqapYmxVyUzN4AYnimvwZAnt1nrmf/HgIGGy6p7qnR6OS/HAThF1
	 TlpkjI2l7TqfXr9PTubSbKy0PhP6iP2DakjspnC8FzLj3X+PNzRmCIW+LsyPzZ82Z/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEyqadUq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281C6082BD9;
	Tue,  3 Nov 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEyqadUq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA251F00919;
	Tue,  3 Nov 2026 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711412;
	bh=PSDntGuIfgagBvAExwS6AxASDwHywut+hO3ZGe4XpBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YEyqadUq/vD7mn2sQm7rW5cXSKEBCH/ZXFx7VIjAsR/sVuKdO9E4SzT3UBw28oGOW
	 Y7Ssto7CIv59mQru1uVSibGFkHy7VhU738TmPn+3NAAiDX51ZozvEL6Y8iZQFP1DTV
	 agZkjzhjBgXYAaJikdv8RYfrbedIEFKozfjGca95CoT7B50B3on4TeX9nl0QKVVXYv
	 zNKNxyVKc0oydZyn4uCwh3J1Ua63+sfHDokcgfmtd8B03fsr9dw5Rev67vzcl+uvS7
	 EUUnWfpoTnqLU3BY13hlaFhffZl8oYr7ngAl2gyiJarVZfTiTIwA6b2RqBV/dgN+fF
	 bcjZeTbE5WRaA==
Subject: Re: [PATCH net 2/2] connector/cn_proc: release socket state and
 listener count on close
From: netdev-bot+sashiko@kernel.org
To: cenzhang@linux.microsoft.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, anjali.k.kulkarni@oracle.com,
 liam@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com
Date: Tue, 03 Nov 2026 13:10:11 +0000
Message-ID: <179371141120.488856.13027523647862479080@kernel.org>
In-Reply-To: <20261102130922.75629-3-cenzhang@linux.microsoft.com>
References: <20261102130922.75629-3-cenzhang@linux.microsoft.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes cn_proc_release() (drivers/connector/cn_proc.c)
  the single place that cleans up when a NETLINK_CONNECTOR socket closes.

--

connector/cn_proc: release socket state and listener count on close

This moves the NETLINK_CONNECTOR release cleanup into a new
cn_proc_release() helper, which now runs for every socket on close. The
helper frees sk->sk_user_data and decrements proc_event_num_listeners
when the stored mcast_op is PROC_CN_MCAST_LISTEN. The aim is to fix the
proc_input leak and the listener count imbalance.

> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 4f613c0648ae4..a4b62998095ea 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -387,6 +387,20 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
>  	send_msg(msg);
>  }
>  
> +/* Called when a NETLINK_CONNECTOR socket is released. */
> +void cn_proc_release(struct sock *sk)
> +{
> +	struct proc_input *input = sk->sk_user_data;
> +
> +	if (!input)
> +		return;
> +
> +	if (input->mcast_op == PROC_CN_MCAST_LISTEN)
> +		atomic_dec(&proc_event_num_listeners);
> +	kfree(input);
> +	sk->sk_user_data = NULL;
> +}

[Severity: High]
This cleanup assumes two things. Each socket owns at most one
proc_input, and proc_event_num_listeners holds exactly one increment for
each socket whose stored mcast_op is LISTEN. Does cn_proc_mcast_ctl()
actually guarantee either of these?

Nothing on the send path serialises it per socket. In
netlink_sendmsg()->netlink_unicast()->netlink_unicast_kernel(),
nlk->netlink_rcv() is called with no lock_sock(). cn_call_callback()
holds queue_lock only for the lookup:

drivers/connector/connector.c:cn_call_callback() {
    ...
	spin_unlock_bh(&dev->cbdev->queue_lock);

	if (cbq != NULL) {
		cbq->callback(msg, nsp);
    ...
}

As a result, two threads sharing one fd can run this section of
cn_proc_mcast_ctl() at the same time:

drivers/connector/cn_proc.c:cn_proc_mcast_ctl() {
    ...
		if (sk->sk_user_data == NULL) {
			sk->sk_user_data = kzalloc_obj(struct proc_input);
			...
			initial = 1;
		} else {
			prev_mc_op =
			((struct proc_input *)(sk->sk_user_data))->mcast_op;
		}
		...
		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
	...
	case PROC_CN_MCAST_LISTEN:
		if (initial || (prev_mc_op != PROC_CN_MCAST_LISTEN))
			atomic_inc(&proc_event_num_listeners);
		break;
	case PROC_CN_MCAST_IGNORE:
		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
			atomic_dec(&proc_event_num_listeners);
    ...
}

Can this still leak the proc_input? If both threads see sk_user_data as
NULL, each calls kzalloc and the second store overwrites the first
pointer. cn_proc_release() frees only the pointer that survives. A loop
of socket(), two concurrent control messages and close() would then
still leak kmalloc-8, much like the OOM reproducer in the commit
message.

Can the count still be left too high? Both threads can take the
increment path, for example when both are initial LISTENs, or when the
second thread reads the freshly published zeroed mcast_op (0, which is
not PROC_CN_MCAST_LISTEN) before the first thread stores LISTEN.
cn_proc_release() decrements only once.

There is also an interleaving where the new release-time decrement
seems to push the count too low:

thread A (LISTEN, fresh socket)
    sk->sk_user_data = kzalloc_obj(...)   /* mcast_op == 0 */
    initial = 1

thread B (IGNORE)
    prev_mc_op = 0
    atomic_dec(&proc_event_num_listeners)
    mcast_op = PROC_CN_MCAST_IGNORE

thread A
    mcast_op = PROC_CN_MCAST_LISTEN
    atomic_inc(&proc_event_num_listeners)

close()
    cn_proc_release()
        atomic_dec(&proc_event_num_listeners)

Before this patch that sequence left the counter balanced. With this
patch, each round lowers proc_event_num_listeners by one.

Once the count drops below 1, proc_fork_connector() and the other
proc_*_connector() hooks, as well as cn_proc_ack(), return early. Would
that stop process events for every listener on the system? The
reachability checks are cn_bind() for CN_IDX_PROC and the init user/pid
namespace test in cn_proc_mcast_ctl(), so an unprivileged user can
trigger this.

Would it make sense to serialise cn_proc_mcast_ctl() per socket, for
example with lock_sock(sk) or a mutex around the sk_user_data install
and the mcast_op transition plus counter update? Another option is a
cmpxchg() install of sk_user_data together with an xchg() of mcast_op,
using the old value to pick the inc or dec.

>  /**
>   * cn_proc_mcast_ctl
>   * @msg: message sent from userspace via the connector

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102130922.75629-1-cenzhang%40linux.microsoft.com
