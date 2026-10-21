Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566445;
	b=D2mgwCwygJ5wgboRAm7kv+IqTL2mA4ZpIpez6RBdNK5aJYuouTNUZkxvQU3L7YiuU29O
	 wf8AhAmUg9XwM+TYfxn33a1UACXCr24Z7+uXINjKT/AoEisFOSa8dH2O6UbeAi3n89F5B
	 hB7sWM3QMFbDUXVPtHB8bL5jzTF9XfLeCLiIRdOLpv/GRE9eU6xRrF1R9p9C29GUTD4fG
	 pZxPvsNzbjjanachf55CUw0+oAo63kePV6pIvvg+ovMv/3NtOORy6fmiBJAurh7e8OMJd
	 U7x2wRyieQ/gh9S6/tVZbE9TeWYPdXw8xlp0LiHcTVU6s2WiZOejb2qWZx1+AQguG5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566445;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NAeuNFyN6QMNmsh01D0dKl/tXHrfHFrWz1E8kDoow9Y=;
	b=yESg5RWUdiq6bTSEJDTjqEiZFCJP0nei24RkEG13mT8/FYdQR0pD55tAJFvJtNw+S8oR
	 zWP1TQyEvF3rTqVgJzyWfQrOkg1ATrB5WdHm/+X8teHYiErkEKn0stj5+kPY9TGXV0DZ/
	 2cFAZMXhd9gcay0x+flUcORbVnqzY14NN0u6OddB+y7AgNzW8TS3t81vrwBI/i9cEDckd
	 45vLENTVf6kwt0t+WIz/ZSaMCodvvHB6WRYaoEav4assvvjejAMsYC6pATN+EgQHYB9j6
	 3wRhFHPhT7JgBM7fAGg0P9++My72ByGe9qRf3muJtEioPLsEN7zRobO4g6U3nADFgKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6EGkxBI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD196606A323;
	Wed, 21 Oct 2026 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6EGkxBI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD811F000CA;
	Wed, 21 Oct 2026 07:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566444;
	bh=NAeuNFyN6QMNmsh01D0dKl/tXHrfHFrWz1E8kDoow9Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F6EGkxBI3vnKXRv+hq/hsO6z9pLhelk7e26sDGf7EK2hJ/6NSQYwDnAO0IbDeDoYS
	 8UnixyVgXSUtBZTLopDMzb8sexkUSqzojM5i7k3FnifVK1p7bUHrMiwB0jArE3cNT5
	 MOTsZpczEsAJOO7c17sW9L9sXk4qPG/6HWxeJShdJTY3Xbe55H9hqXUBOsRy272JnJ
	 Zv5CVGy2eRsPz8LhLgYYoR68+tZEYW5lus48U0yCrfGFaaAxT8+dSEp3MkJ/wNalKa
	 Cn5kqqGXtkUvefSChf0RFJ7BTTPleqgN1RkAy+pQQkrLXhsDDIwEf2y2ZwB2JAUe2n
	 hHPRGtyMzpGSw==
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 21 Oct 2026 07:07:23 +0000
Message-ID: <179256644378.3133.9526185067620358472@kernel.org>
In-Reply-To: <20261019180306.382039-3-w453y.me@gmail.com>
References: <20261019180306.382039-3-w453y.me@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new "delete and re-add, fullmesh, after reset" test in
  endpoint_tests()…
- [Medium] The "delete and re-add, fullmesh, after reset" test depends on
  the `nft` binary and on IPv4 nf_tables reject support, but declares…
- [Low] Even if the nft rule were installed, the "after reset" test never
  checks that the initial subflow was actually reset before its endpoint…

--

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This adds two subtests to endpoint_tests() in mptcp_join.sh. Both delete
and re-add the endpoint used by the initial subflow with the fullmesh
flag. The second one first resets the initial subflow with an nft reject
rule, to validate the previous fix for 045e9d812868.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0..0fa69aa2e9b8 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4445,6 +4445,70 @@ endpoint_tests()

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
> +		init_nftables
> +		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
> +				ip saddr "10.0.1.2" meta l4proto tcp \
> +				reject with tcp reset; then

[Severity: High]
Where is init_nftables() defined? A grep over tools/testing/selftests/
finds only this call site. There is no definition in mptcp_join.sh,
mptcp_lib.sh or net/lib.sh. The script doesn't use set -e, so bash
would print "command not found" and keep going.

Without that helper, does anything create the ip filter table and its
INPUT chain in ns1? Each test gets a fresh netns from
reset()->init_partial()->mptcp_lib_ns_init, and this test runs no other
iptables or nft command in ns1.

If so, the nft add rule always fails and the whole body of this if is
skipped: the SUB_CLOSED wait, the endpoint delete and re-add, wait_mpj 2
and chk_mptcp_info.

The unconditional chk_join_nr 2 2 2 further down would then see only the
single MP_JOIN from the id 2 subflow. Wouldn't this subtest then fail on
every kernel, with or without the previous fix?

It also means this part of the commit message isn't actually validated:

  Do the same with the fullmesh flag, and also after a reset of the
  initial subflow, before the removal of its endpoint.

The TCP_CLOSE branch of mptcp_subflow_is_closed() added by the previous
patch would stay untested.

Was a helper hunk dropped from this submission? The existing reset in
userspace_tests() uses iptables and needs no extra helper:

		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&

> +			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +			ip netns exec "${ns1}" nft flush chain ip filter INPUT
> +
> +			pm_nl_del_endpoint $ns2 1 10.0.1.2

[Severity: Low]
Once the rule can be installed, does anything confirm that the initial
subflow was actually reset before its endpoint is deleted?

wait_event() polls up to 100 times. If the count is not reached it just
leaves the loop, without calling fail_test:

mptcp_join.sh:wait_event() {
	...
	for _ in $(seq 100); do
		count=$(grep -cw "type:${evt}" "${evts}")
		[ "${count}" -ge "${exp}" ] && break
		sleep 0.1
	done
}

The checks that follow, chk_mptcp_info subflows 2 subflows 2 and
chk_join_nr 2 2 2, give the same result whether the initial subflow was
reset or simply closed by pm_nl_del_endpoint. The reason is that
mptcp_pm_subflow_check_next() only updates the counter for join
subflows:

net/mptcp/pm.c:mptcp_pm_subflow_check_next() {
	...
	update_subflows = subflow->request_join || subflow->mp_join;
	...
}

If no reset happens, wouldn't this reduce to the preceding fullmesh
re-add test and still pass?

The userspace reset test asserts the event explicitly:

			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2

Could a similar chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED check be added
here?

> +			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +			wait_mpj 2
> +			chk_mptcp_info subflows 2 subflows 2
> +		fi
> +
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		chk_join_nr 2 2 2

[Severity: Medium]
Even once init_nftables() exists, should this test be skipped rather
than failed when the nft rule can't be loaded?

The new rule needs three things: the nft binary, an ip family table
(CONFIG_NF_TABLES_IPV4), and reject support (CONFIG_NFT_REJECT and
NFT_REJECT_IPV4). tools/testing/selftests/net/mptcp/config only enables
these nftables options:

CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NFT_COMPAT=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_TPROXY=m

NF_TABLES_IPV4 has no default. NFT_REJECT defaults to m only when
NETFILTER_ADVANCED=n, and this config sets NETFILTER_ADVANCED=y.

init() also doesn't check for nft:

	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"

The if block has no else branch, and chk_join_nr 2 2 2 runs on both
paths. A missing dependency therefore shows up as a hard failure (1 join
instead of the expected 2) rather than a skip.

reset_with_tcp_filter() handles the same situation like this:

		mark_as_skipped "unable to set the filter rules"

Would switching to the iptables idiom, or adding a skip path like this
one, avoid the false failure?

> +	fi
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019180306.382039-1-w453y.me%40gmail.com
