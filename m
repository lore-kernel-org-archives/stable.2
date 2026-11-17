Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908636;
	b=26/PW073ZYQxZFlCsAjcMWItFfikDPD82mE3PQRKmW1Hw5m2XdRVuYZU14B4zNfXmbC6
	 5XHXbmmHPjKMCgjEA4xO8DlwDy19omeHDq05e6deMooez7Vj56qHegOIjqLl+RR2ETf7I
	 Lbdb6CVnOAvhoXxsX6rWcovNFmDOTosC9yz7cwNlTc357GFwYcopJJwTuYv2nRRazrAhd
	 IDZTwAb1K4z17CvpDIP3WwT+Y5no8zuLc6I+VrULk0rtF2NL+yEghmN00xG3IWf9ycOM+
	 OZ/S3sV2UWEP1451kK2EKAjeFpPY5UvFf5W2womj7jIp3D+8Mblyha5gSWt/0DTgG4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908636;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EkMkRGE3wUMYDlYWX26IfHh9fQHE7ly+qPAGDAGs94Y=;
	b=3zIX7bw4N+OiSWfwMBT38ZHEqnxPiJzLWOsI+3b9fbBXcXoeFNJwMqsjUtvW31Mni2Ar
	 wGNi65zGWTq+j9nkxdr2jrzeMCq8Fk280pBN5+l+owXxThJiph7pBICoVbZJIjUponHuU
	 +W+muDRsc44govm5kP1Cz23jZnaabrrKqaYru2h2ra27LJk8PcHMErm48/mZrRiHK62Ia
	 rAxggwzVuS2Pdt/CHRrMtrq4O6jx2qQzyq8MvgKDtaiiOBWMZZ1egHHPVGSXTNotkgUzv
	 6Usg2M0d4FcS1Oa5OM1bHzzxEbsc9ATz+KvtJlJnf0WVbYZgq42DsG+2PI3EjVFYR1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3smttsi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA8606A898;
	Tue, 17 Nov 2026 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3smttsi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0821F000D2;
	Tue, 17 Nov 2026 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908635;
	bh=EkMkRGE3wUMYDlYWX26IfHh9fQHE7ly+qPAGDAGs94Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P3smttsihzvyAwE/2EaRi4cKFqx4R/4ZOu2OGX3an0jJ+abA3lN4gk8bsaKvqfRkD
	 L5WQMZ+0f9obDAc5cuTfpANlUNY+ef8amWshZFC5QG5qcupobxitUQ+QTaeX21jna5
	 jsHTCIVzoGw2vkx9vAOSdVgkH/6N/etJDhDWEyMrMyCNRyHvWnrThbWE0heiVcpvGG
	 XCjuxucnK6/hiDNMIpydWo6BjI5kEhJD8pCZJo/tWB6cz14ZBvnV9AVCiMTEiCtEjN
	 64Z/HmFtSCpfDxHBcZVPHU0uIEMphMRfdLoJI4FBcV4bBHhHBo0/Mn/SX0r6UpOULH
	 EA/YhbbSDtphQ==
Subject: Re: [PATCH net v4 3/3] net: mptcp: verify the token slot in
 mptcp_token_iter_next()
From: netdev-bot+sashiko@kernel.org
To: 2122295973@qq.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 17 Nov 2026 09:43:54 +0000
Message-ID: <179490863464.3133.2064838572417107624@kernel.org>
In-Reply-To: <tencent_647B95315D18DBA311A33E8120517E1DA60A@qq.com>
References: <tencent_647B95315D18DBA311A33E8120517E1DA60A@qq.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Under the new check in mptcp_token_iter_next()
  (net/mptcp/token.c:381-386), a socket passes if its token is non-zero…
- [Low] The commit message says the affected callers are "mptcp_diag and
  the userspace path manager".
- [Low] The patch uses a plain READ_ONCE() of msk->token as an
  "initialisation complete" signal (net/mptcp/token.c:381), but nothing…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the walk in
  mptcp_token_iter_next() (net/mptcp/token.c:370-393) does not follow…

--

net: mptcp: verify the token slot in mptcp_token_iter_next()

This patch makes mptcp_token_iter_next() re-read msk->token after it takes
a reference on a socket. The socket is skipped unless the token is
non-zero and hashes to the slot being walked. The goal is to stop the
iterator from returning a recycled msk whose pm state is not initialised.

> mptcp_token_iter_next() takes a reference on a socket found on the chain
> of the slot it is walking and then re-checks only net_eq().  A socket
> that was freed and whose memory has been reused by a new msk in the same
> network namespace passes that check while it is still zeroed, and the
> callers - mptcp_diag and the userspace path manager - then use mptcp_pm
> state that has not been initialised yet.

[Severity: Low]
Is "the userspace path manager" the right caller to name here?

Apart from mptcp_diag_dump(), every caller of mptcp_token_iter_next() is
in net/mptcp/pm_kernel.c:

  mptcp_nl_add_subflow_or_signal_addr()
  mptcp_nl_remove_subflow_and_signal_addr()
  mptcp_nl_remove_id_zero_address()
  mptcp_nl_flush_addrs_list()
  mptcp_pm_nl_set_flags_all()

Each of them skips userspace PM sockets:

    if (mptcp_pm_is_userspace(msk))
        goto next;

net/mptcp/pm_userspace.c does not use the iterator. It uses
mptcp_token_get_sock(), which already re-checks the token after taking
the reference.

Could the commit message name the in-kernel path manager endpoint
operations instead?

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 8a603fc8dc059..48470d6e751d6 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c

[ ... ]

> @@ -377,7 +378,9 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
>  			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
>  				continue;
>  
> -			if (!net_eq(sock_net(sk), net)) {
> +			token = READ_ONCE(mptcp_sk(sk)->token);
> +			if (!token || (token & token_mask) != slot ||
> +			    !net_eq(sock_net(sk), net)) {

[Severity: Medium]
Does a non-zero token that maps to this slot really show that the msk is
on this chain and fully set up?

On the passive path, the token is published while the refcount is already
non-zero and before the msk is hashed. First, sk_clone_lock() does:

    smp_wmb();
    refcount_set(&newsk->sk_refcnt, 2);

Then mptcp_sk_clone_init() in net/mptcp/protocol.c does:

    WRITE_ONCE(msk->token, subflow_req->token);
    ...
    mptcp_set_state(nsk, TCP_ESTABLISHED);
    WRITE_ONCE(msk->first, ssk);
    ...
    list_add(&subflow->node, &msk->conn_list);
    ...
    mptcp_copy_inaddrs(nsk, ssk);
    ...
    if (!mptcp_token_accept(subflow_req, msk)) {

Here is one way to hit it:

- A diag dump or PM netlink walk holds a stale RCU pointer to a freed msk
  in slot S.
- That memory is reused by this clone.
- The new token happens to hash to S.

refcount_inc_not_zero_acquire() then succeeds, and the token is non-zero
and matches the slot. So the iterator returns an msk that is not hashed
yet.

Callers then do lockless reads before lock_sock(): sk_state, conn_list,
and the inet addresses via mptcp_local_address(). These race with the
initialisation above.

The failure path looks worse. mptcp_token_accept() can fail, for example
when mptcp_subflow_reqsk_clone()->mptcp_token_move_request() has moved
the request token during reqsk migration. In that case
mptcp_sk_clone_destroy() does:

    bh_unlock_sock(nsk);
    sock_put(nsk);
    sock_set_flag(nsk, SOCK_DEAD);
    tcp_orphan_count_inc();
    inet_sk(nsk)->inet_num = 0;
    inet_csk_destroy_sock(nsk);

A reader blocked in lock_sock() can get the socket right after
bh_unlock_sock(). Examples are mptcp_nl_remove_subflow_and_signal_addr()
and mptcp_nl_flush_addrs_list(). The same applies to lock_sock_fast() in
mptcp_diag_fill_info().

Can that reader then run pm and subflow operations while
inet_csk_destroy_sock()->mptcp_destroy() tears down the msk without the
socket lock?

Would a check tied to hash membership close this window? Another option
would be to assign msk->token inside mptcp_token_accept() under the
bucket lock.

[Severity: Low]
Is a plain READ_ONCE() enough to treat the token as an "initialisation
done" flag?

On the clone path, __mptcp_init_sock()->mptcp_pm_data_init() runs before
WRITE_ONCE(msk->token, ...) in mptcp_sk_clone_init(). There is no release
barrier between them.

On the reader side, refcount_inc_not_zero_acquire() pairs only with the
smp_wmb()/refcount_set() in sk_clone_lock(). That store comes before any
MPTCP init. After the token load there is only a control dependency.

The callers make some lockless reads before taking the socket lock:

  mptcp_pm_is_userspace() (reads pm.pm_type)
  list_empty(&msk->conn_list)
  READ_ONCE(msk->fully_established)
  the pm counters in mptcp_diag_fill_info():

    info->mptcpi_extra_subflows = READ_ONCE(msk->pm.extra_subflows);
    info->mptcpi_add_addr_signal = READ_ONCE(msk->pm.add_addr_signaled);

On arm64 or POWER, can these reads be satisfied before the token load?
They would then see the listener values copied by sock_copy() even though
the token check passed.

Would this need smp_store_release()/smp_load_acquire() on msk->token, or
a hash membership check?

>  				sock_put(sk);
>  				continue;
>  			}

[Severity: Medium]
This isn't a bug introduced by this patch, but the walk in
mptcp_token_iter_next() does not follow the nulls-list protocol that the
other msk_chain readers in net/mptcp/token.c use.

mptcp_token_get_sock() restarts when its post-acquire re-check fails, and
when the walk ends on another chain:

    if (READ_ONCE(msk->token) != token ||
        !net_eq(sock_net(sk), net)) {
        sock_put(sk);
        goto again;
    }
    ...
    if (get_nulls_value(pos) != (token & token_mask))
        goto again;

mptcp_token_exists() does the same nulls check.

The msk cache is SLAB_TYPESAFE_BY_RCU. An msk deleted from slot X and
re-added to slot Y can move a lockless walker onto chain Y.

The new (token & token_mask) != slot test detects that hop, but it
responds with continue. The walker then takes and drops a reference on
each entry of chain Y, and stops at Y's nulls marker.

Are the remaining entries of slot X skipped for this dump or PM pass?

Before this patch the X entries were skipped as well, and Y's entries
were returned instead.

Should a failed slot check restart the bucket walk? And should
get_nulls_value(pos) be compared against slot when the walk ends?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_D0DCF4B132B20B70FB5AE2D9272AA4AEAF07%40qq.com
