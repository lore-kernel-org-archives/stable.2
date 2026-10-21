Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571158;
	b=MsC2tpf3a2W0h7HMFELexMBFQfddrTUVvEqVVpqfR2f9of2ds0FZqJo1U3TKZCu5xivt
	 H8MS80EQo1e16m14HidltJ9D8UOuFXUpFxeE5bvpTXldWGZKRvMs1Geiw+xfntZjN3rTM
	 lxrmS2LKE0HziN9i2SGw6w2/UeWpp4H+4ItW4W2Cgc5qCvN+Uhu3slAgmNs5JG2dAuhqV
	 dlqol0ILIfYammH/qORu4ipfXKQfIXeck+ZRHVPG4bWe/vfmWLuwy7KZUtEptdA3Fq5Fr
	 Itai04PTf9Z4zRFDB5GJNg+xfAwy8ukYtkV4thm4fUjnZkH5MnTlBWwExz5GRySecPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571158;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6LXWkR/KDncLuIfg/DvP76gihoIHrMaY6kRaiCR8V4Q=;
	b=CB4529YzRpfUQETdIaoe35UCPAWhMLX+6B471oEk72/W28UsoRytIzeTi7mBRIho2Sfq
	 anirTk/0fJoMTfkEoPNegXDTkzoSAE+4tQwXGvi4mGQVx3mOcmmlDmu1pU3Xyooxk4LNo
	 684M4keg6PELY0a36uIh+yLXhB+9rntf1XxR7qid+tftCtd/v2CouCOEo2Joq5kqTTnP1
	 jotrk6KEHvL9Ym0AWKaGWRRMJrHiFYH/IIqGB12WiG1MCZlKbGVaEuEzx7NglVTHvnhNS
	 jp6G8Xag8MM2Ps1kQP5IOJS0AJr90VThzoy1hCpC+LiawQWdW+jZOuEbdRULfhBACZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aJ68gM//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC2606A322;
	Wed, 21 Oct 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJ68gM//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83721F000D0;
	Wed, 21 Oct 2026 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792571157;
	bh=6LXWkR/KDncLuIfg/DvP76gihoIHrMaY6kRaiCR8V4Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aJ68gM//t/LjLLm+Je8lHCLpHT3abP410M7alJ5ANDQxBW05YazfoCrjCpBcPSqTt
	 MENLh1EUTgwek8PdjSMSrpXdUS+IeDaBnwO2/T63nuzQ3dhvtxB7+VQTalTt/BkXW7
	 ioPkWh7c8VymazbMN/SNlkq4rZlM9in+nVlbrP4REB7FrLBMamLW8CYe5/9HNI3GYH
	 o6a7yse32mqAJm4w4vw52cpaUg0TXkKRxqGH3mHegpmLNwRZ+8kpVTPM9DsGmwMag8
	 P7cUcSDNmHNqsWOECJiLwtJ3I60kgTJgFaA5LB726ZgCevJUsMp/I5r3UM7x+XLJvl
	 DfsNkxfCO/crw==
Subject: Re: [PATCH mptcp-net v4 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 21 Oct 2026 08:25:56 +0000
Message-ID: <179257115648.3133.2414695393525694837@kernel.org>
In-Reply-To: <20261019190558.465270-3-w453y.me@gmail.com>
References: <20261019190558.465270-3-w453y.me@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In endpoint_tests()
  (tools/testing/selftests/net/mptcp/mptcp_join.sh), the new subtest…
- [Low] The "delete and re-add, fullmesh, after reset" subtest in
  endpoint_tests() never checks that the initial subflow was actually…

--

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This adds two subtests to endpoint_tests() in mptcp_join.sh. Both delete
and re-add the endpoint of the initial subflow with the fullmesh flag. The
second one first resets the initial subflow with an iptables REJECT rule,
to validate the fix for 045e9d812868 ("mptcp: fix duplicate subflow
creation").

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0..25fedf5b12ec 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4445,6 +4445,67 @@ endpoint_tests()

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

[Severity: Low]
What does this subtest report if the iptables rule can't be installed,
for example because the REJECT target is missing or the iptables-nft
backend has a problem?

This if has no else branch. The reset wait, the endpoint delete and
re-add, wait_mpj 2, chk_mptcp_info and chk_join_nr would all be skipped.
The only check left is chk_subflow_nr "before reset", so the subtest
would pass without ever running the reset path.

reset_with_tcp_filter() in the same file handles this case:

	if ! ip netns exec "${ns}" ${iptables} \
			-A "${chain}" \
			...
		mark_as_skipped "unable to set the filter rules"
		return 1
	fi

The existing "userspace pm no dup close events after error" subtest has
the same no-else pattern.

Could an else branch calling mark_as_skipped (or fail_test) be added
here?

> +			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +			ip netns exec "${ns1}" ${iptables} -F INPUT

[Severity: Low]
Does anything here check that the initial subflow was actually reset
before its endpoint is deleted?

wait_event() gives up quietly when it times out:

	for _ in $(seq 100); do
		count=$(grep -cw "type:${evt}" "${evts}")
		[ "${count}" -ge "${exp}" ] && break
		sleep 0.1
	done

The checks below (wait_mpj 2, chk_mptcp_info subflows 2 subflows 2,
chk_join_nr 2 2 2) give the same results whether or not the reset
happened. The initial subflow doesn't change the extra-subflow counters.

If no RST arrives, pm_nl_del_endpoint acts on an established initial
subflow. __mptcp_close_ssk() then sets subflow->closing, and that alone
satisfies mptcp_subflow_is_closed() in net/mptcp/pm_kernel.c:

	return subflow->closing || inet_sk_state_load(ssk) == TCP_CLOSE;

In that case this subtest behaves like "delete and re-add, fullmesh". It
would still pass if the TCP_CLOSE half were removed. Only the reset path
needs that half, because mptcp_subflow_ctx_reset() clears closing.

The "userspace pm no dup close events after error" subtest checks the
reset after its wait_event calls with:

	chk_subflows_total 1 1

Could a similar check, such as chk_subflows_total, chk_rst_nr or
chk_evt_nr on MPTCP_LIB_EVENT_SUB_CLOSED, be added after this
wait_event?

> +
> +			pm_nl_del_endpoint $ns2 1 10.0.1.2
> +			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +			wait_mpj 2
> +			chk_mptcp_info subflows 2 subflows 2
> +			chk_join_nr 2 2 2
> +		fi

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019190558.465270-1-w453y.me%40gmail.com
