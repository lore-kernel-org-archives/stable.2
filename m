Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793329;
	b=t97hSFSZa1H9ltSzN6XEygX0vndvY+sv+r0nZHxQL0TW0j4KXJHbafCPS9qS7FDpS3YW
	 XUMHK7FYktXzOAoRh3w5cA3uNIyiBn1I6KkWEcoNaZNmjrqTYWd+iLitRKUl2GNcecGOR
	 YQKRIskR6VxFSSPj+2OKDZanyxN+s1uQ3LmynxUApDmwz/ZoaYqjR6ydxCv1YBL7lc3rG
	 9ey/wSeo/VzQHWYQy4G5eed/WDSZHyDwteI8Pi1Hmdml1iWxY5yqRqpmr+IDH4bwj5dWM
	 ojZgPtBrHD2xCE6hRgtj3iFp5iWGAL7FjXB8/lI9RvVKkyLGJRa+fOZONtUuiq4fQvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793329;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e7oAFuckFMx7W0E61PjGMaFfAeNYQLKdoncPVZoG0Qg=;
	b=FhRyzFK0a5i1NrKx8SQGNR34BKFWPGG1HDB+uEdJyXfDHP4uKuIxV1a8NKo3zy7cx/Es
	 +yn6Kk72z3rwxyZTaubDAg8Rtrr+N18jycPw8FY0CBhf7lSDoCCbo6rONXqtCbBoyGQlL
	 3AuQ7IPOL5ljBgzzH79dtCszfxC/Emo/f282GnS2PX1XMtJfZQ5rSdwPQPor+xpZKkP/u
	 BnoCb8xbEHPonA1E8zZYhQ2ryxAMiMvb1TkO065l9i/vAwEErW7HF33XkOQMmoGlyaBO+
	 j3ZGjdl3V8B0dSkcm6L4GKnRbtPGTZgkjs72Q/RUBDAbam70uIhKsV63+hmSFV6sitw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQ+93vAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E449606A31A;
	Fri, 23 Oct 2026 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQ+93vAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A921F01828;
	Fri, 23 Oct 2026 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793328;
	bh=e7oAFuckFMx7W0E61PjGMaFfAeNYQLKdoncPVZoG0Qg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nQ+93vAbDOr7lwlOWSXk/T4FUBZ17tHLSwcdM6WFJttxPQid9mHENxCWWWIGulzY/
	 RYw6kkVw2++tYCFr6XD7RteYtBkqxsSN1Hy2eCWqYxn1wzUU3cU7Z8Bf+403WnZ2v0
	 1p1VU5Y1KQQq1Acf2/StAFs4/8yhyK9ogZWjSuVKG+NHHskyOrr+5wtr1a6QCopQDk
	 oAwqpTl6BWst7Pe7JUCZ5POwih0Zq47zvYcCKUXFdM6ew06jFfmypEcRbvoJhj5xhK
	 K1204Hs52tSmMmpbfjaaM+DDEtb4hpsczasVM5nHG1JKvSuKAC81FK5zIdtg2P5C9f
	 9LB9f76ypy92Q==
Subject: Re: [PATCH mptcp-net v6 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Fri, 23 Oct 2026 22:08:47 +0000
Message-ID: <179279332774.3132.7813168813559908382@kernel.org>
In-Reply-To: <20261022085041.211318-3-w453y.me@gmail.com>
References: <20261022085041.211318-3-w453y.me@gmail.com>
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

- [Medium] Two of the new tests, "delete and re-add, fullmesh, single
  subflow" and "delete and add another, fullmesh, single subflow"…
- [Low] In "delete and re-add, fullmesh, single subflow" and "delete and
  add another, fullmesh, single subflow" (endpoint_tests() in…

--

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This adds four cases to endpoint_tests() in mptcp_join.sh. Each one
removes and re-adds the endpoint used by the initial subflow, with the
fullmesh flag set. The cases are: with a second subflow, after a reset of
the initial subflow, and with the initial subflow only (re-adding the
same endpoint or adding another one).

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..52031288bcc86 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4445,6 +4445,123 @@ endpoint_tests()

[ ... ]

> +	# only the initial subflow: once its endpoint is removed, no live subflow
> +	# is left to take the remote address from
> +	if reset_with_events "delete and re-add, fullmesh, single subflow" &&
> +	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=$!
> +
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
> +		pm_nl_del_endpoint $ns2 1 10.0.1.2

[Severity: Medium]
Can this delete race with ns2's PM worker accounting the MPC endpoint?

mptcp_pm_fully_established() only queues the PM work before it sends the
ESTABLISHED event:

net/mptcp/pm.c:mptcp_pm_fully_established() {
    ...
	if (READ_ONCE(pm->work_pending) &&
	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
    ...
	if (announce)
		mptcp_event(MPTCP_EVENT_ESTABLISHED, msk, ssk, GFP_ATOMIC);
}

msk->mpc_endpoint_id is set later, from the worker, in
mptcp_mpc_endpoint_setup(). If the delete request is handled first,
mpc_endpoint_id is still 0, so mptcp_endp_get_local_id() returns 1
instead of 0:

	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;

As a result, mptcp_nl_remove_subflow_and_signal_addr() asks to remove
local id 1. mptcp_pm_rm_addr_or_subflow() then skips the initial subflow,
which has local id 0:

			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
				continue;

When the worker runs later, __lookup_addr() in mptcp_mpc_endpoint_setup()
can no longer find the endpoint. MPTCP_PM_MPC_ENDPOINT_ACCOUNTED is set
while mpc_endpoint_id is still 0, and the initial subflow stays alive.

If that happens, does the SUB_CLOSED wait_event time out, and does
chk_subflow_nr "after delete" 0 fail?

After the re-add, the live initial subflow still holds remote id 0. No
fullmesh subflow would be created, so wait_mpj, chk_mptcp_info and
chk_join_nr would fail as well.

The comment below shows this ordering is known. However, waiting for
SUB_CLOSED only detects the race and does not prevent it. Could the test
wait until the MPC endpoint has been accounted before it deletes the
endpoint?

"delete and add another, fullmesh, single subflow" has the same pattern.
The two-subflow variants look fine: wait_mpj 1 only succeeds after the
same worker run has done the accounting.

> +		# the ESTABLISHED event comes before the PM worker accounts the
> +		# initial subflow endpoint: check the subflow is really gone
> +		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +		chk_subflow_nr "after delete" 0

[Severity: Low]
Does a SUB_CLOSED event on ns2 guarantee that ss reports 0 subflows in
both namespaces at this point?

mptcp_close_ssk() sends the event before teardown starts:

	if (sk->sk_state == TCP_ESTABLISHED)
		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
	...
	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);

For msk->first, __mptcp_subflow_disconnect() only does:

	} else {
		tcp_shutdown(ssk, SEND_SHUTDOWN);
	}

ns2's subflow can therefore sit in FIN_WAIT1/FIN_WAIT2, and ss still
lists it until ns1 sends its FIN. ns1 closes its side asynchronously,
once its PM worker has handled the RM_ADDR id 0.

chk_subflow_nr() counts the sockets once, with no retry:

	cnt1=$(ss -N $ns1 -tOni | grep -c token)
	cnt2=$(ss -N $ns2 -tOni | grep -c token)

The other tests in endpoint_tests() run sleep 0.5 before this check, and
so does the new "delete and re-add, fullmesh" test. Could the
single-subflow variants fail spuriously without that delay?

"delete and add another, fullmesh, single subflow" has the same pattern.

> +		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +		wait_mpj 1
> +		chk_mptcp_info subflows 1 subflows 1

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022085041.211318-1-w453y.me%40gmail.com
