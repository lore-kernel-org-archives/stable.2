Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699846;
	b=0W2Lmjs29CSR4YZDzy63IRaS58kLKsykcKdlAJLqxb7xYVFjWp5RK51CVmFeva+RKXzY
	 nv5WoKpy7IlAZ1xi7cdvJxvLvFHClzxPspHb0NRzOGq0hFcky68payptcU73jKBC7z/yp
	 sTa8uB2Ux1gj27yFxA+1mmPU2l898gADwnmNuReLfZH8ph/UvvkmD7OFJXFN/buEopPAK
	 Eht9+zerAVfZyUHg8Ql5dv7PmEM8gjVseKCZ5RAVxMiEmHUGwySGWc6b4x6oHFkqPNEXh
	 gAeSGvKz+8xqd/ZNHuGdgJdj3zH3AP04k7aY3NgqT2yJa4IE/A7Tdvw8RM+imUG5eoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699846;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IHKIB44D4PfWrcJ2DF0A4+dTYI8QvNL9ppG/s6UZSeI=;
	b=sVRFlWXSNCBvskJamGjCwb8+MqOgr0qLrza2QKjiRxY2uJX3Lgj6Mg/WItwGtsjOLz03
	 qW4fUaHeOMawhdfG0GJnJBGUVQWiaA95+jT2LQVplV3Nxum9ie4RxUE/xMf7kpMmgzCMg
	 iWWykt9tNfxKGwZR6DY2WLwRDjAshEYk7DYwuVwFOy8Gxj8Di5fR8LTod1MQaUmo4WOl4
	 EEbxh6G7EeOgibIRs/MH+gIpBG58B1rXoUvj5gr5LoirUTPvWbS6DJvp9DdFFnyXVK+VT
	 wdRcoz4hdDP2IUnM/c8v+j5RAln3+6hUuV4SqAB+rXEpKbuSJ2tDTVCYDmffoCi3RfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cFaYBLNc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526F606A320;
	Thu, 22 Oct 2026 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cFaYBLNc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698681F01828;
	Thu, 22 Oct 2026 20:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792699845;
	bh=IHKIB44D4PfWrcJ2DF0A4+dTYI8QvNL9ppG/s6UZSeI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cFaYBLNcZqsCfung7WT83N6qubChsbiWE5CJy58U0fLeOka3V6N/rMSEaJ5JxVicI
	 YPWwu7361lEl76+aUnKONVF0pVI/DFENDzWHxuy9OcIYJYCG31SV7AA4fAYV8sq0vm
	 peLsi/V8Bke9s1c+KeY7WE/9wJ7sgkuRafLFZD4Pl8uFNe7x1cHMNDDO9ts1GAoWGD
	 oazzbRuCWGGShtqEKvoul5rlin64MBlxjT3aZkHe+Pv/oCCDHKvgbvN0Vk/2EFqqKy
	 +CrQs1+4SDRe7F9ndETflfOTj4hPdpq+5LzdJU7l83D1FaAi5+6i7JL+mtdFMZpxNV
	 6mbLmyGswAl6A==
Subject: Re: [PATCH mptcp-net v5 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 22 Oct 2026 20:10:45 +0000
Message-ID: <179269984501.3133.3133518777444307676@kernel.org>
In-Reply-To: <20261021070324.50533-3-w453y.me@gmail.com>
References: <20261021070324.50533-3-w453y.me@gmail.com>
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

- [Medium] The two new single-subflow subtests, "delete and re-add,
  fullmesh, single subflow" (lines 4520-4523) and "delete and add…
- [Low] In the new subtest "delete and re-add, fullmesh, after reset"
  (endpoint_tests() in tools/testing/selftests/net/mptcp/mptcp_join.sh),…

--

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This commit adds four subtests to endpoint_tests() in mptcp_join.sh. Each
one removes and re-adds the endpoint used by the initial subflow, with the
fullmesh flag set. They cover three cases: a second subflow is present,
the initial subflow is reset first, and only the initial subflow exists
(re-adding the same endpoint or adding another one).

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..6d2cc01ac4492 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4445,6 +4445,114 @@ endpoint_tests()

[ ... ]

> +	# same, but the initial subflow is reset before removing its endpoint
> +	if reset_with_events "delete and re-add, fullmesh, after reset" &&
> +	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then

[ ... ]

> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
> +		wait_mpj 1
> +		chk_subflow_nr "before reset" 2
> +
> +		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
> +		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
> +			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +			ip netns exec "${ns1}" ${iptables} -F INPUT
> +
> +			pm_nl_del_endpoint $ns2 1 10.0.1.2
> +			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +			wait_mpj 2
> +			chk_mptcp_info subflows 2 subflows 2
> +			chk_join_nr 2 2 2
> +		fi

[Severity: Low]
What happens if the iptables rule can't be installed here? For example,
the REJECT target or the tcp-option match might be unavailable.

There is no else branch. In that case the SUB_CLOSED wait, the endpoint
delete and re-add, wait_mpj 2, chk_mptcp_info and chk_join_nr are all
skipped. Nothing calls mark_as_skipped() or fail_test(), so
append_prev_results() reports the subtest as a pass even though only
chk_subflow_nr "before reset" 2 ran.

The rule is the reason this subtest exists: it is there to exercise the
TCP_CLOSE branch of mptcp_subflow_is_closed(). Should it mark the test as
skipped, the way reset_with_tcp_filter() does?

reset_with_tcp_filter() {
    ...
	if ! ip netns exec "${ns}" ${iptables} \
			-A "${chain}" \
			-s "${src}" \
			-p tcp \
			-j "${target}"; then
		mark_as_skipped "unable to set the filter rules"
		return 1
	fi
    ...
}

The "userspace pm no dup close events after error" subtest uses a
similar bare if. Commit 560edd99b5f5 accepted that because another subtest
that depends fully on iptables would be marked as skipped. Nothing like
that covers this case.

> +
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +	fi
> +
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
> +		sleep 0.5
> +		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +		wait_mpj 1
> +		chk_mptcp_info subflows 1 subflows 1

[Severity: Medium]
Is the ESTABLISHED event enough synchronization before deleting endpoint
id 1?

mptcp_pm_fully_established() only schedules the PM work, then emits the
event:

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
mptcp_mpc_endpoint_setup():

	entry = __lookup_addr(pernet, &mpc_addr);
	if (entry) {
		__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
		msk->mpc_endpoint_id = entry->addr.id;
		...
	}

Suppose pm_nl_del_endpoint runs before the worker. Then this call in
mptcp_nl_remove_subflow_and_signal_addr() returns 1 rather than 0:

	list.ids[0] = mptcp_endp_get_local_id(msk, addr);

mptcp_pm_rm_addr_or_subflow() then skips the initial subflow, because its
local id is 0, so the subflow stays established. When the worker runs it
finds no endpoint for 10.0.1.2, and mpc_endpoint_id stays 0.

In this re-add variant, the re-add then maps endpoint 1 to local id 0.
The initial subflow is still alive and keeps remote id 0 unavailable, so
no new subflow is created. Could wait_mpj 1, chk_mptcp_info subflows 1
and chk_join_nr 1 1 1 then fail spuriously?

The "delete and add another, fullmesh, single subflow" subtest below has
the same race. There, endpoint 2 would still join using the remote
address of the live initial subflow. The test would pass without covering
the case where no subflow is left.

The two-subflow subtests avoid this, because their wait_mpj 1 runs after
the worker has called mptcp_mpc_endpoint_setup(). Neither single-subflow
subtest checks the subflow count after the delete, the way the first new
subtest does with chk_subflow_nr.

The window is probably small, but nothing seems to prevent it on loaded
CI machines or debug kernels. Should these subtests wait for the PM
worker, or check that the initial subflow is gone, before re-adding the
endpoint?

> +
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		chk_join_nr 1 1 1
> +	fi

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021070324.50533-1-w453y.me%40gmail.com
