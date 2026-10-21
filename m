Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569524;
	b=gfoxmCABL8FFBP/mEmJZLb7PTxDi8jKEXU2vuz4HV3oIiDjDWNknv4jq8aYYP+/qlcm4
	 ylnv10jNy2vGe9imWG3hRvZrQE/B6otSfcW0ptjRzj6tTM8pqsOxryPruuu4xALqhQX2i
	 9miBdtHBbcwnPqLrO+TaXBR3QRE1EE2NTTQtwkBUz0YthLKm9K+P0ONrc3NpL8tLyPS+4
	 Ahb9CyYCkIK207m59n1f62rLIqjEpxnc+VtDRY26mhTSuVtUAZGKGYn+51hojIYVMSNge
	 KxYlbk4enFGnAwN6VzIxOgL70xjWYnYBcfbopu+yDyft1vswCu5wpags5rxDR3/MlFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569524;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lV7WOwF2OwQk2cmb02V8IGhl7zWFcwougSeOwMgRMHE=;
	b=rPB7wJeXRuw6U/KZ7lXjIEy9WIqbBeLpNm+KlGWhzYdjzrVUht8SXfOdBUE70UEe6aHM
	 vPVIUNzjqJUPckWSwX2x9alGvvcBurOn4/N93S4uCtr7+seB61XBC9OAA3w0YgV58bjgA
	 8uRIZuxQW/LYgEykQD9GIO5QMaHkgPhI9LpreGAnEmG7UIaDOodTnrlMwW3MyCApc4Muc
	 Mq64x1kLSl775R+IevVD/2VETTOkzFvHYxoGjurbj+eTNTLM9QfcXBhS+SRtI1cnoAsGA
	 gR93g+dMzVzpKI5SvsF9Ifz3dawlKDhPCk5+sMuDi2Xhy3T78rqi6bxO/3E3nDXoWxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCmQuifC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D2606A319;
	Wed, 21 Oct 2026 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCmQuifC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0933A1F000CA;
	Wed, 21 Oct 2026 07:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792569523;
	bh=lV7WOwF2OwQk2cmb02V8IGhl7zWFcwougSeOwMgRMHE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kCmQuifC+jhxv9BjjoBIrpNVdjxIusI+4S5Tg04JIIDbfzl1VWp49Rgns1nGuL7I5
	 obwrOnyusxfeQTXwLhaFSswzuPKDOicEkqBYKW5RutJ1AfXLiHttqK1fEL7L16YtaE
	 whtqwJ/PVCiBemnzaGGjaICk6jQbKuMMgPE4od6JrUQl8/fkDh9XpYH+9w5Z8z3dHm
	 R8xr/T+squ3woBRdEndyhiH1U7dyIBF2gUMGKxMLRIRiL7Z8k4HAW4fe2K/VVDhOn5
	 Qg0A5CefgmJWQSRiv+l/svcPTqAMlY+88OOgG/+Me9cE3ZHMu1H1iRgBb3/6JkiV9G
	 a4Uh1BG3tIjwQ==
Subject: Re: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 21 Oct 2026 07:58:42 +0000
Message-ID: <179256952257.3133.17458157001507004926@kernel.org>
In-Reply-To: <20261019185512.458313-3-w453y.me@gmail.com>
References: <20261019185512.458313-3-w453y.me@gmail.com>
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

- [Medium] The new subtest "delete and re-add, fullmesh, after reset"
  (endpoint_tests() in tools/testing/selftests/net/mptcp/mptcp_join.sh)…
- [Low] In "delete and re-add, fullmesh, after reset" (endpoint_tests(),
  mptcp_join.sh lines 4493-4507), the reset, the endpoint delete/re-add,…

--

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This commit adds two subtests to endpoint_tests() in mptcp_join.sh. Both
delete and re-add the endpoint used by the initial subflow with the
fullmesh flag set. The second one first resets the initial subflow, then
removes its endpoint.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0..d2d105cef4a9 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4445,6 +4445,68 @@ endpoint_tests()

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
> +
> +			pm_nl_del_endpoint $ns2 1 10.0.1.2
> +			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +			wait_mpj 2
> +			chk_mptcp_info subflows 2 subflows 2

[Severity: Medium]
Can this subtest pass even if the initial subflow was never reset?

wait_event() gives up after 100 polls and reports nothing to its caller,
so a timeout looks the same as success:

tools/testing/selftests/net/mptcp/mptcp_join.sh:wait_event() {
    ...
	for _ in $(seq 100); do
		count=$(grep -cw "type:${evt}" "${evts}")
		[ "${count}" -ge "${exp}" ] && break
		sleep 0.1
	done
}

The REJECT rule only causes a reset if ns2 sends an option 30 packet
from 10.0.1.2 while the rule is in place. Nothing forces traffic onto
the initial subflow during that window.

If no reset happens, the rule is flushed and the endpoint of a subflow
that is still established gets deleted and re-added. That is the same
scenario the previous "delete and re-add, fullmesh" subtest already
covers.

The later checks pass in that case as well. "chk_mptcp_info subflows 2
subflows 2" holds because closing the initial subflow does not decrement
extra_subflows, and the re-add adds one join. "chk_join_nr 2 2 2" holds
too.

So the TCP_CLOSE path in __mptcp_subflow_disconnect() in
net/mptcp/protocol.c may never be reached:

	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
	    fastclosing) {
		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
		mptcp_subflow_ctx_reset(subflow);

The commit message says this subtest covers that case ("also after a
reset of the initial subflow, before the removal of its endpoint").

"userspace pm no dup close events after error" follows its wait_event()
with "chk_subflows_total 1 1" to confirm the reset happened. Could this
subtest add a similar check after the SUB_CLOSED wait, for example
chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 or chk_rst_nr?

> +		fi
> +
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		chk_join_nr 2 2 2

[Severity: Low]
Should this chk_join_nr be inside the iptables branch above?

The if around the iptables command exists to tolerate a rule that cannot
be installed. In that case endpoint id 1 is never re-added.

Then only one MP_JOIN happens, from the id 2 fullmesh endpoint. The
check here sits outside the branch, so it reports "got 1 JOIN[s] syn rx
expected 2" and the subtest fails instead of being skipped.

"userspace pm no dup close events after error" in userspace_tests() uses
the same iptables guard but keeps every dependent check inside the
branch. Also, reset_with_tcp_filter() calls mark_as_skipped when it
cannot set a REJECT rule.

> +	fi
> +
>  	# remove and re-add
>  	if reset_with_events "delete re-add signal" &&
>  	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019185512.458313-1-w453y.me%40gmail.com
