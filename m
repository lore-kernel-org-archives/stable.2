Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BAF443E40;
	Thu,  1 Oct 2026 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890358; cv=none; b=nxEjtks0Hl6vZDXJJaui8R9QVF8NghuukRsprtHo+IV1HaGFASbtlWfYhDH4u7RaP/TilTnHy9fCdOe0k44JYXxh8O6L6xHvqhUzx1MCyXXO73p8jA+j3pNFyCjaqZwgliycugXQ9JaxlwP49jFN/PRvpa8O4EzD1f4J94yrL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890358; c=relaxed/simple;
	bh=/9LOBQkjJjhxi1MW0jTUI3yyXsdYYTHaWTMbTxB8b3o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfKAjOyaTAm++uU4A/ruMWUTGBAJ99nEVb+q27nq2L7kwT+2wq/wIWF5TulV6d9pqlyyJdVwZWRyzIlgkqhLFJUt0wmiTCi4XoqolrVxsT+sSA53TfqJLrON5YbeyxVuCQ3/KCa1B3V6WNilwm8kuBbonNveauOoZqho90sYozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjtJt3fz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjtJt3fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E2B1F000FF;
	Thu,  1 Oct 2026 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790890356;
	bh=hsqiOjWJes5QL5Swg2qcGQK2F4DTo5Fcsb/ksOfHTzQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DjtJt3fzmgwQgbl8/G3ER3U5dGbT9g/aZWRWUgaqNcaZlCbBC+DvuSIgfxi7WfX9x
	 mZChBUUkt3AaMf8RecXDUH43coF3d7eC5djHhPACrqk4qPEEKZ7vqWYcqkZ4s87prv
	 HM9ZI1oyuS8Hi72nj22/KumMhk7H432NKEeYLu6iQZe3BA3DbzPxKpmg7pXNuSbhSN
	 dbv7NQnOWmtfVjsf8Un5blXRry+69UpcIj0RqFWz85ghj39qo4kgEtSDryAxg+KRGS
	 rPfykHckLOD/RmvmCElonxPEOLVOpgsIq8k//lAz4lfF2DY1bcgUaObFBVsWGFnnBs
	 48kKLzYQ5K/YQ==
Subject:
 Re: [PATCH net] net/smc: prevent TCP from retaining freed address-family ops
From: netdev-bot+sashiko@kernel.org
To: kylebot@openai.com
Cc: netdev@vger.kernel.org, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, samsun1006219@gmail.com,
 stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:32:35 +0000
Message-ID: <179089035510.434549.11808413703827521402@kernel.org>
In-Reply-To: <20260928213153.36141-1-kylebot@openai.com>
References: <20260928213153.36141-1-kylebot@openai.com>
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

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] smc_listen() still installs &smc->af_ops on a clcsock that is
  already a live TCP listener, so an accepted child can keep the…
- [High] The new MPTCP gate in subflow_ulp_init() rejects exposed sockets
  only if it sees `sk->sk_socket->file != NULL`.

Pre-existing issues:
- [High] The problem wasn't introduced by this patch, but smc_listen()
  publishes &smc->af_ops with WRITE_ONCE() after plain stores to…

--

net/smc: prevent TCP from retaining freed address-family ops

This patch restores the original icsk_af_ops when smc_listen() fails and
in smc_clcsock_release(). Installing and restoring the ops is serialized
with the clcsock lock, and SOCK_RCU_FREE is now set before the listener
callbacks are published.

It also compares a child's ops against the embedded table in
smc_tcp_syn_recv_sock(). The MPTCP ULP can no longer be attached to a
kernel socket that has been exposed through a file.

Closes: https://lore.kernel.org/netdev/20260713085238.16780-1-samsun1006219@gmail.com/

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c37..da7ac71344a9 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1984,10 +1984,11 @@ static int subflow_ulp_init(struct sock *sk)
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	int err = 0;
>  
> -	/* disallow attaching ULP to a socket unless it has been
> -	 * created with sock_create_kern()
> +	/* Only attach to a kernel-created socket that has not been
> +	 * exposed through a file.
>  	 */
> -	if (!sk->sk_kern_sock) {
> +	if (!sk->sk_kern_sock ||
> +	    (sk->sk_socket && READ_ONCE(sk->sk_socket->file))) {

[Severity: High]

Does this check hold up against a concurrent smc_switch_to_fallback()?

smc_switch_to_fallback() exposes the clcsock with two plain stores and no
barrier between them:

net/smc/af_smc.c:smc_switch_to_fallback() {
    ...
	if (smc->sk.sk_socket && smc->sk.sk_socket->file) {
		smc->clcsock->file = smc->sk.sk_socket->file;
		smc->clcsock->file->private_data = smc->clcsock;
    ...
}

By then the file is already in the fd table. Another thread calling
setsockopt(fd, SOL_TCP, TCP_ULP, "mptcp") finds the clcsock through
sock_from_file(), which does a plain load of file->private_data. That
thread holds neither clcsock_release_lock nor the SMC sock lock.

The compiler may reorder those two stores, and so may arm64 or POWER. In
that case, can the second thread see private_data == clcsock while
clcsock->file still reads NULL?

The clcsock came from sock_create_kern(), so sk_kern_sock is 1 and both
checks would pass.

The MPTCP ULP would then attach to a TCP socket that userspace can reach
but that has no MPTCP parent, so ctx->conn is NULL. subflow_data_ready()
starts with:

	struct sock *parent = subflow->conn;

and subflow_state_change() also uses the parent. ctx->icsk_af_ops could
also capture the SMC-embedded table.

The commit message says:

    Reject attaching the MPTCP ULP to such a socket: otherwise userspace
    can bypass smc_setsockopt() and MPTCP can retain the embedded table in
    its subflow context.

Is that path still reachable through this window?

>  		err = -EOPNOTSUPP;
>  		goto out;
>  	}
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index e9f93b3ab435..dbbe7d6574e4 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c

[ ... ]

> @@ -2682,18 +2684,25 @@ int smc_listen(struct socket *sock, int backlog)
>  	write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
>  
>  	/* save original ops */
> +	lock_sock(smc->clcsock->sk);
>  	smc->ori_af_ops = inet_csk(smc->clcsock->sk)->icsk_af_ops;
>  
>  	smc->af_ops = *smc->ori_af_ops;
>  	smc->af_ops.syn_recv_sock = smc_tcp_syn_recv_sock;
>  
> -	inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
> +	WRITE_ONCE(inet_csk(smc->clcsock->sk)->icsk_af_ops, &smc->af_ops);
> +	release_sock(smc->clcsock->sk);

[Severity: High]

Can this still install &smc->af_ops on a clcsock that is already a live
TCP listener?

Here is one possible interleaving. Three threads share an AF_SMC fd that
is in SMC_INIT:

T1: listen(fd)
    smc_listen()
        lock_sock(sk)            <- waits

T2: setsockopt(fd, SOL_TCP, TCP_FASTOPEN, ...)
    smc_setsockopt()
        smc_switch_to_fallback()
            file->private_data = clcsock
    (sk_state stays SMC_INIT)

T3: listen(fd)
    inet_listen() on the clcsock, which is now a plain TCP listener

T1 then resumes and passes the state checks in smc_listen(), then
installs &smc->af_ops. kernel_listen() returns 0 because
__inet_listen_sk() only adjusts the backlog when the socket is already in
TCP_LISTEN.

The listener receive path runs without the socket lock:

tcp_v4_rcv()
    tcp_v4_do_rcv()          (TCP_LISTEN)
    tcp_check_req()          (TCP_NEW_SYN_RECV)
        inet_csk(sk)->icsk_af_ops->syn_recv_sock()

A softirq can load the original tcp_v4_syn_recv_sock() before the
WRITE_ONCE() above. It can then clone the listener in
tcp_create_openreq_child() after it.

That child inherits &smc->af_ops but never goes through
smc_tcp_syn_recv_sock(). So the new check there never runs for it:

    if (inet_csk(child)->icsk_af_ops == &smc->af_ops)

Suppose userspace then accepts that child from the clcsock and closes the
SMC fd. smc_clcsock_release() restores only the listener's ops.

Once the RCU grace period ends and the smc_sock is freed, would the child
keep calling through the freed table (net_header_len, queue_xmit, and so
on)?

Taking lock_sock() on the clcsock serializes install against restore, but
it doesn't seem to exclude lockless listener processing. Should the
install be refused when the clcsock is already in TCP_LISTEN?

[Severity: High]

This problem wasn't introduced by this patch, but is the publication of
&smc->af_ops ordered after the stores that initialize it?

smc->ori_af_ops and the struct copy into smc->af_ops are plain stores.
The WRITE_ONCE() that publishes &smc->af_ops has no release semantics.

In the already-listening case above, the lockless reader is:

tcp_v4_rcv()
    tcp_check_req()
        inet_csk(sk)->icsk_af_ops->syn_recv_sock(...)

The compiler may reorder the plain stores, and so may arm64 or POWER.
Could the reader then see the new pointer before the struct copy is
visible?

sk_alloc() zeroes smc->af_ops, so the softirq could call a NULL
syn_recv_sock. It could also enter smc_tcp_syn_recv_sock() and
dereference a NULL smc->ori_af_ops here:

	child = smc->ori_af_ops->syn_recv_sock(sk, skb, req, dst, req_unhash,

The added lock_sock() does not synchronize with this reader, which never
takes sk_lock. Refusing to install on a socket that is already listening,
or publishing with smp_store_release(), would avoid this.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928213153.36141-1-kylebot%40openai.com
