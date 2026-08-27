Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E954DB54B;
	Thu, 27 Aug 2026 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857653; cv=none; b=q6+Cm/qYdSjKViiCawYTx617wQYRI/5xcQwchU2/0bVBv7nzXjxCIDnCxz72Jz8ww4S862wt9MYpvTOHHwCcKwPh8JBDCmDCMGTqRm7qKMzxxx6wKZKenlIl29yCL591W4EQn6SUQXpK4yaVfLTuUZncrKIgbYHso3XS9hYsUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857653; c=relaxed/simple;
	bh=9K91xs1LoNGvs0q+jYYkVc0Ld554sqyE/4hNxzZIZtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H39Mb+AmdIMHbsF2p95sSsnK8Rkkot4z7hgXUcpHMumIVqrXA1vYaRWoWhn6KfyczNdNbSUEkW/PaeywWtOCbOWNfoGYtuJ/Jt6Rw7/gd7YhqvAS5i2Cko6DqhM3YhGmwGT1exz59IzWUKrKL9fVf7+5RSJn/c2Uhr8VsUpu1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahv7Kimq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahv7Kimq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7341F00A3E;
	Thu, 27 Aug 2026 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857648;
	bh=8fr17X89R+htO3pXl2NdsMPY0Yh2gQM2QBdTe2Z82bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ahv7KimqeSM01voPHFN58EibCndjppUpVap9m1ZAUyKzZh7rn4rhY94yNQUtSg9sC
	 eAr5g+HAvWTKxaLBakpMJ1TBnZSdG/XlfxUY75+xe+GEi0OZFbm6fGyirWbN6CiZ0W
	 hh95WnbR0X+SKWp3f8tadcz3JZCW7/rVVOTC9kDKI1XGcAsz8EOnCbeGMvsgYT8Cle
	 d7myvY8XSUm1ja08x5MjBAOmhDovvhNthaRV5DBJF7k3xy+ldW3y8l4tbLEd2hVVlo
	 W0/kBxndIpx+RPlulhLTUvY9ESvDSg0YKYzaWhuHYEvyp18MsGbmjWLReqX/PQqwd9
	 gqAZAi75QseiQ==
From: Jakub Kicinski <kuba@kernel.org>
To: matttbe@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 05/14] mptcp: options: handle MPC data + csum reqd + no csum
Date: Thu, 27 Aug 2026 12:07:27 -0700
Message-ID: <20260827190727.3998288-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-5-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-5-a92309d121ca@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
mptcp: options: handle MPC data + csum reqd + no csum

The parser in mptcp_parse_option() no longer sets OPTION_MPTCP_CSUMREQD from
the MP_CAPABLE 'A' flag when the option carries a data-len, so only the
presence of the 2-byte checksum field marks a data-bearing MP_CAPABLE as
checksummed.  This avoids using the uninitialised 'csum' field when a peer
sets the flag but omits the checksum bytes.

Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-23

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b8318e0301389..92f27b9e087a6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -93,7 +93,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  		 * In other words, the only way for checksums not to be used
>  		 * is if both hosts in their SYNs set A=0."
>  		 */
> -		if (flags & MPTCP_CAP_CHECKSUM_REQD)
> +		if ((flags & MPTCP_CAP_CHECKSUM_REQD) &&
> +		    opsize < TCPOLEN_MPTCP_MPC_ACK_DATA)
>  			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;

[Severity: Medium]
On the passive side, is the third ACK's 'A' bit not the only place where the
peer's checksum requirement is recorded?

subflow_init_req() derives the request state purely from the local sysctl:

net/mptcp/subflow.c:subflow_init_req() {
	...
	subflow_req->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk_listener));
	...
}

There is only that single store of csum_reqd in net/mptcp/subflow.c, so the
'A' bit seen in the remote SYN is not saved anywhere.  The only server-side
promotion into connection state is in mptcp_sk_clone_init():

net/mptcp/protocol.c:mptcp_sk_clone_init() {
	...
	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
		WRITE_ONCE(msk->csum_enabled, true);
	...
}

With net.mptcp.checksum_enabled=0 (the default in net/mptcp/ctrl.c) and a
peer whose SYN had A=1, does the new opsize test mean msk->csum_enabled now
stays false for a 22-byte MP_CAPABLE + ACK that carries a data-len, sets A=1
and omits the checksum field?  That option length is still accepted by the
size check just above:

		if (opsize != expected_opsize &&
		    (expected_opsize != TCPOLEN_MPTCP_MPC_ACK_DATA ||
		     opsize != TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
			break;

Downstream, mptcp_incoming_options() then sets mpext->csum_reqd = 0, and
get_mapping_status() compares:

net/mptcp/subflow.c:get_mapping_status() {
	...
	/* Cfr RFC 8684 Section 3.3.0 */
	if (unlikely(subflow->map_csum_reqd != csum_reqd))
		return MAPPING_INVALID;
	...
}

Both sides being false, the mapping is accepted rather than rejected, so no
RST is sent for the non-conforming peer and the connection runs without
checksums even though the peer asked for them.  Our own writer still emits
the bit on data-carrying MPC + ACKs:

net/mptcp/options.c:mptcp_write_options() {
	...
	if (opts->csum_reqd)
		flag |= MPTCP_CAP_CHECKSUM_REQD;
	...
}

Related to this, the changelog says the csum field "is only used to compare
with the expected one, if previously negotiated in the 3WHS".  Since the
passive side never records the peer's SYN 'A' bit, does that statement hold
for a listener?

[Severity: Low]
This isn't an issue introduced by this patch, but while touching this area:
the trailing pr_debug() in mptcp_parse_option() prints fields that are only
conditionally assigned:

		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
			 version, flags, opsize, mp_opt->sndr_key,
			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);

sndr_key is only set for opsize >= TCPOLEN_MPTCP_MPC_SYNACK, rcvr_key for
opsize >= TCPOLEN_MPTCP_MPC_ACK, data_len for opsize >=
TCPOLEN_MPTCP_MPC_ACK_DATA and csum only for opsize ==
TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM.

mptcp_get_options() only clears the status group:

net/mptcp/options.c:mptcp_get_options() {
	...
	*(u32 *)&mp_opt->status = 0;
	...
}

and struct mptcp_options_received in net/mptcp/protocol.h places sndr_key,
rcvr_key, data_len and csum before struct_group(status, ...), while callers
such as mptcp_incoming_options(), subflow_check_req() and
mptcp_subflow_init_cookie_req() declare the struct on the stack without a
memset.

When the dynamic-debug callsite is enabled, does this print stale caller
stack bytes for MP_CAPABLE SYN, SYN/ACK, plain MPC + ACK, and the
data-without-checksum case this patch targets?  Would initialising csum and
data_len (or extending the zeroed region) make the stated goal of the patch
hold regardless of the debug setting, including for the stable backport?
