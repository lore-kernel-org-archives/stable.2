Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562822;
	b=0rXeY7CeTENWv2rKpDfoy+Hgpl2MbzLYZMvcpSH9sOboLqV1lsd4ZDn9miKIGyinD95H
	 bDFtmai3rEvnJBjI+7sKlMfCAEyNxMMzRXxA55JrLTpeA0SrT76MXaornugeWxQx6QHdf
	 G7ktDjww9zFQ9rzezNLtkGYe1obE5i6YcTj9PVEgmPKza585jjgRC0ADB/1doW1RomoTX
	 mgj1G199D0ThPnPostTS08iPuqmlgWAD0C/k/rlbyRFaeRhuvsL19EafeUShRR89IhNha
	 8NMM3Wij5nWewET6W70fT+mY8tmPPkfuUSTDnDhF89rVRuCRBDuEkcTIMTY+QdnVgtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562822;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=w0bfKG4jWhsgSPibMdf5DakdYa8sqFj/DLA6rj361Lg=;
	b=xK5hjkAZvhqgeaPbdiyrSKWXNNNx5ECXYSc9QtcMT6Y6+3fTdFuYVLOlKDsgx6kArQdf
	 clcV4IENb2CR+PTjKY9aVUj9wYRDNmjBlSg9cQ3AWC04t1UAnlEr8jOEFP8izbI8EN9ZY
	 PEx1V/l0QQtcqUFnArrkWg+2Omevx7JU0DJWUrzYyUlOeu2mzyEXdayIE/TVhu+F/bXVi
	 BsEppKetLbJtiHB28EUDnL8ZkC9yaKcAekqIZFovijb2CmywHp5482IYoj7UgL7Ly9goA
	 6q3DV2D1XcvtCm/s43iCsJ+APfHSOFSX9KYxxjSo00mqgvF6/bOJzi9s1XVcPPnSF3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBGtq+pG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB3606A329;
	Wed, 21 Oct 2026 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBGtq+pG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B8B1F000C9;
	Wed, 21 Oct 2026 06:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792562821;
	bh=w0bfKG4jWhsgSPibMdf5DakdYa8sqFj/DLA6rj361Lg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DBGtq+pGdde4n2ZkFs4ytJc2vdgzLUhfUE9JWOjkoDzcAjNURwsPnuq2OtAE1JWK3
	 eRm+KWSIhX6PcI0m+0bz8GsGcPS6ABfuuCjGxjtIh6wrf459G+BhBjgnrK4U2wGcTP
	 3IYhRuBhbiTTMDYm8isx9EqY9nkk0CEWKvHw/1H5RoOcCpg1r97WHp76AUBTzzRtle
	 Do3yY9DdBkf00Zz2ZbwXvHKK139O7j3GJhYdIQ8Anat9PsZSEVNSFZZUkbVY+zNR/E
	 1HOoXwS+JdhnRaVrXTGs25UKphbUvMVAzSBL+a6rKQg4CkM2Ld7cp6GyTlKV3n2Q6B
	 8LCVfm3/ZY2pQ==
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: join: re-add the initial
 subflow endp with fullmesh
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 21 Oct 2026 06:07:00 +0000
Message-ID: <179256282060.3133.15812705751852336988@kernel.org>
In-Reply-To: <20261019170751.200446-3-w453y.me@gmail.com>
References: <20261019170751.200446-3-w453y.me@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp: pm: fill_remote_addresses_fullmesh() fails to skip
  reset initial subflow

--

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4424,6 +4424,36 @@ endpoint_tests()
>  		chk_rm_nr 4 4
>  	fi
>  
> +	# remove and re-add the endpoint of the initial subflow, with fullmesh
> +	if reset_with_events "delete and re-add, fullmesh" &&
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
> +		chk_subflow_nr "before delete id 0" 2
> +
> +		pm_nl_del_endpoint $ns2 1 10.0.1.2
> +		sleep 0.5
> +		chk_subflow_nr "after delete id 0" 1
> +
> +		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
> +		wait_mpj 2
> +		chk_subflow_nr "after re-add id 0" 2
> +
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		chk_join_nr 2 2 2
> +		chk_rm_nr 1 1
> +	fi
> +
>  	# remove and re-add
>  	if reset_with_events "delete re-add signal" &&
>  	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then

[Severity: Medium]
This only exercises the case where msk->first is still established
when the endpoint is removed. In that case __mptcp_subflow_disconnect()
takes the tcp_shutdown() branch and the subflow context is left intact.
Doesn't the fix from the previous patch still have a hole when the
initial subflow reaches TCP_CLOSE before mptcp_close_ssk() runs? That
can happen after a peer RST or FIN, a timeout, or a shutdown from
TCP_SYN_SENT.

In that case __mptcp_close_ssk() sets subflow->closing and keeps
msk->first in conn_list because dispose_it is false. Then
__mptcp_subflow_disconnect() calls tcp_disconnect() followed by
mptcp_subflow_ctx_reset(). The memset of subflow->reset clears closing
again, zeroes remote_id and sets local_id to -1.

When the fullmesh endpoint is then re-added,
fill_remote_addresses_fullmesh() no longer skips that subflow. The
second loop copies 0.0.0.0 port 0 with id 0 from the disconnected
socket and marks remote id 0 as unavailable, so any live subflow
towards remote id 0 is skipped. __mptcp_subflow_connect() then fails
with -EINVAL on the port 0 address. No subflow towards remote id 0
gets created, which is the same symptom this test is meant to catch.

Would checking the ssk state or the remote port in
fill_remote_addresses_fullmesh() be a more robust guard than
subflow->closing here? Could the selftest also grow a variant where
the initial subflow is reset by the peer before the endpoint is
re-added, so that path is covered too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019170751.200446-1-w453y.me%40gmail.com
