Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792886466;
	b=13XZc/OhHpjW0j2RYrjfhNme0aFuNOL9v6gBFufMNh+EhTMu3e7MuBzovCv6hsLqEbD8
	 WcuFvLkwo5xqzCCprvgyd1LPPj0BNF9M2CZBcdMqbYcZ1Tg/onBM0uXNMPfQPqGQv7nof
	 N/Vf7omlzGSnezzFz7RlJNhkbaxsmjeP/auOtSNhbUMlQvETDccHDzMw93zlqJF/TZdBn
	 ph2CtdZc8SPe7/or/1auRpFojhMl2Vk+wH9HSYjki2kLUBBWjORqiJa9C5wYBbXZr12AD
	 1uNbvOXCHbFBu673plbeVt1g+Ax9X7oabJZSdaQFrG7AbmiA2ryu5Sp37sVJsCc6Z7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792886466;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jbVBejo2uto+Jd7jW4dgNdqbBXMg9WCrh1sx9t99UE0=;
	b=WdnY0K7UYYrzb8qFwdGBwu1FhMpndDZbtZNcAwTZDSlxAWLUKj2DqfLIdtFd0QaIVFQk
	 mbIbqXAnZzHcIWfxR8y4YX0tDGUBx5oo/k70DlTxbZLaXxxdQa7XttzjypbOFg6dj5ALl
	 0wFMYtvm/xbvgbfaCc5tXu/AW2BYVwGknuy1HgDOHPOKpIwHVXSoVaXDu0ufYAjF4NhbO
	 D5bd1JdlwOJGjKKrsSBVU7QrQS/9tomkWa2KHO9/jtcY2NJuzA15fqQ9U3+cNk0rAwhmw
	 9vQCCKbvK9KCSA+NtW6/hM3WaQLzZ8oaJ/N3gUXsxnuMteTpU8CCKKcrPO80S09Pcfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpfkSlkf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0411606A31A;
	Sun, 25 Oct 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpfkSlkf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F148C1F01825;
	Sun, 25 Oct 2026 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792886465;
	bh=jbVBejo2uto+Jd7jW4dgNdqbBXMg9WCrh1sx9t99UE0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PpfkSlkfR/myhnASgCUeU4se2a0nesYT2zNtb3Pa9RVSw8zzl8tossOUAnR9Dgvo5
	 JQ0QcRNW+ZjoKbIntteGEBm9KTDilkbyrXf+CKGww4CH+/OJTBs1seDkaX14pIT6Sm
	 ZvR10Kje3kRIacyd2pFpfn+fdUJ+elTIvCco6TdrPNfwG44C5WKW3CA5VZupwnCYc+
	 AXeNsSzSwNi3B5ben2Mc/2rD3edAhLNkKel9tZEgxGW7NSqKehQOpJBYCtFYoUUUQ6
	 JE2BOsCnkvAtxQhZWxy+09PKe66hgKpAA0rIvgaG0PJtQ8WK2zZk/e05iBcBOjzWUW
	 KFXRqI+ktufQQ==
Subject: Re: [PATCH mptcp-net v7 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Sun, 25 Oct 2026 00:01:04 +0000
Message-ID: <179288646445.3132.10444972890542088038@kernel.org>
In-Reply-To: <20261023110321.403874-3-w453y.me@gmail.com>
References: <20261023110321.403874-3-w453y.me@gmail.com>
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

- [High] The new subtest "delete and re-add, fullmesh, after reset" in
  endpoint_tests() (tools/testing/selftests/net/mptcp/mptcp_join.sh)…

--

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This patch adds four subtests to endpoint_tests() in mptcp_join.sh. Each
one removes and re-adds the endpoint of the initial subflow with the
fullmesh flag set: with a second subflow, after a reset of the initial
subflow, and with only the initial subflow. The goal is to validate the
previous in-kernel fullmesh fix.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..98dc8de81cf01 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4424,6 +4424,135 @@ endpoint_tests()

[ ... ]

> +	# same, but the initial subflow is reset before removing its endpoint
> +	if reset_with_events "delete and re-add, fullmesh, after reset" &&
> +	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
> +		{ timeout_test=120 test_linkfail=128 speed=5 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=$!
> +
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
> +		wait_mpj 1
> +		chk_subflow_nr "before reset" 2
> +
> +		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
> +		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
> +			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +			ip netns exec "${ns1}" ${iptables} -F INPUT

[Severity: High]
Where does ${iptables} get set? I can't find it assigned anywhere under
tools/testing/selftests/net/mptcp/. These two lines seem to be its only
uses.

mptcp_join.sh only uses nftables. init() checks only for these tools:

	mptcp_lib_check_tools ip tc ss nft

When the variable is empty, the command expands to:

	ip netns exec <ns1> -A INPUT -s 10.0.1.2 ...

That always fails, so the if condition is always false. The checks that
would exercise the fix never run: the SUB_CLOSED wait, chk_evt_nr, the
endpoint delete/re-add, wait_mpj 2, chk_mptcp_info and chk_join_nr.

> +			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
> +
> +			pm_nl_del_endpoint $ns2 1 10.0.1.2
> +			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +			wait_mpj 2
> +			chk_mptcp_info subflows 2 subflows 2
> +			chk_join_nr 2 2 2
> +		else
> +			mark_as_skipped "unable to set the filter rules"
> +		fi

Since the if is always false, this else branch always runs.

mark_as_skipped() calls mptcp_lib_fail_if_expected_feature(). With
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1, that helper does:

	echo "ERROR: missing feature: ${*}"
	exit ${KSFT_FAIL}

The test groups run in the main shell, so in that mode the whole
mptcp_join.sh run would stop here and report a failure. None of the
later tests would run, and the background run_tests would still be
running when the script exits.

In the default mode, this subtest is always reported as skipped. It would
still pass if the previous fix were reverted, so the "after a reset of the
initial subflow" case from the commit message is never actually tested.

Should this use nftables, like the existing reset test in
userspace_tests() ("userspace pm no dup close events after error")?

	init_nftables
	...
	ip netns exec "${ns1}" nft add rule ip filter INPUT \
		ip saddr "10.0.1.2" meta l4proto tcp \
		tcp option mptcp exists reject with tcp reset

Unlike reset_with_tcp_filter(), reset_with_events() does not call
init_nftables. The test would need an explicit init_nftables call, and
something like "nft flush chain ip filter INPUT" for the cleanup.

> +
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +	fi

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023110321.403874-1-w453y.me%40gmail.com
