Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562820;
	b=vG4Cim2OmQXpnJy5KIbhT0KWuF/t8EqLmdInr7TSpWT+1O926IEUTmM2q+JTk45Rn9bO
	 LMLTL9ZXhvgBIHl09mel/ejZYejt+w0B+tJjYX8bmYs0ZKXxaCrzATsi94NsoCm2EKWYj
	 rCkZPuWHZcn5RW/PNRA7EZdpQVCRnBS4S/OC+ScpLGOTEcr3X6GfUqlV2r2LWwhPnPSru
	 nCcJVrilC5utMSdZqZB2mtTs6HCmtlY796w34wawP384TnR4sQTpTqwOBkT/SDT6apRjD
	 NM0dW+vntotDEm0uMYNP1gL/AH/FkXofjDZITQrd74sUd11IYqEHDGzA+kiAia7JxeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562820;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=izfThV7wsAx4FqTvspHGNv4Iqj5ikmlqrQJJX3as0oY=;
	b=a1NhecAEeZHpIGgPr1BDNxRzJBN+DomP0ll86BhtM9B4tB2yJLHhgtUTkjR6Lq9ToUTm
	 MK38355trfRNSNcRZ5MKzFMNLKLBmRoUXQBcwPMO5aOylJjrH+Zsp65kphjSaWhGmN5Nz
	 gkPocs0hqx38+FWBmrWe+GT94YQZX44FR0gi0LbOkkbtTscWotDZWzgkiIBrnPlcSt4m+
	 q8HGNfc6EUB1TC1vNKeJ8sQxN+Wpc3XkUMnAFFOnF5SxiCZoEZ2zqgLRk9ZeWcfGL+GlL
	 RFuCuI/I4+MspmD9VhYucsdQIqsZHLgGCWpy0mMfN13/WZw84rL2su/ysR/FlSKcEmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMUYlTft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D82606A31F;
	Wed, 21 Oct 2026 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMUYlTft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7B21F000C9;
	Wed, 21 Oct 2026 06:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792562820;
	bh=izfThV7wsAx4FqTvspHGNv4Iqj5ikmlqrQJJX3as0oY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PMUYlTft9TCo2t6T/gpJcngC2XNsVA4/E3o/6XIKf83oxdO7NY0OoUceaIg6WWYd6
	 mju4UMRnMgSoZHgqYZFjaVygt4msxHnpgUNMJ2F3gHLxpVE1gkAY4w2cxUNqDd54oo
	 GCrehLhFnxufcMUkfS9ksGb7h0g2P7lJUTTpzcDUERtlODkmxqaMaSs2uNr/yURbQd
	 Bjid/YzEIiJrK38cjHaxfnh5UkrR8mUw8a4RYxj8++0prnFK4tmtdhegaP3VdxyVpH
	 v/JR1ZGryoAY/Mtk3EaM90VXgoUlQc/aTHMNvIgPBVBw2ql+goLa3Sm0NVQhdw63pl
	 ySq3jmObpn9hw==
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: fullmesh: skip closed
 subflows
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 21 Oct 2026 06:06:59 +0000
Message-ID: <179256281931.3133.3826869783117765302@kernel.org>
In-Reply-To: <20261019170751.200446-2-w453y.me@gmail.com>
References: <20261019170751.200446-2-w453y.me@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In fill_remote_addresses_fullmesh() (net/mptcp/pm_kernel.c,
  lines 228-234), the new `if (subflow->closing) continue;` check in the…
- [High] fill_remote_addresses_fullmesh() (net/mptcp/pm_kernel.c) now
  skips every subflow with `closing` set, in both loops.

--

mptcp: pm: in-kernel: fullmesh: skip closed subflows

When a fullmesh endpoint used by the initial subflow is removed and then
added back, the closed initial subflow stays in conn_list and marks remote
ID 0 as unavailable, so no new subflow is created. This patch makes
fill_remote_addresses_fullmesh() skip subflows with closing set, both when
collecting unavailable remote IDs and when picking remote addresses.

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 1a7750813235..b7d7520a3290 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -216,11 +216,19 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,

[ ... ]

>  	mptcp_for_each_subflow(msk, subflow) {
> +		if (subflow->closing)
> +			continue;
> +
>  		ssk = mptcp_subflow_tcp_sock(subflow);
>  		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
>  		addrs[i].id = READ_ONCE(subflow->remote_id);

[Severity: High]
Does the closing check catch the tcp_disconnect() case that the commit
message gives as the reason for this check?

msk->first can reach TCP_CLOSE while the msk stays established, for
example after a peer RST or a timeout. In that case __mptcp_close_ssk()
sets closing = 1. The first subflow is not disposed, so
__mptcp_subflow_disconnect() then runs:

net/mptcp/protocol.c:__mptcp_subflow_disconnect() {
    ...
		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
		mptcp_subflow_ctx_reset(subflow);
    ...
}

tcp_disconnect() sets inet_dport to 0 and keeps daddr.
mptcp_subflow_ctx_reset() memsets the reset struct_group, which includes
closing and remote_id, and sets local_id to -1:

net/mptcp/protocol.h:mptcp_subflow_ctx_reset() {
	memset(&subflow->reset, 0, sizeof(subflow->reset));
	subflow->request_mptcp = 1;
	WRITE_ONCE(subflow->local_id, -1);
    ...
}

The subflow stays at the head of conn_list, because msk->first is added
with list_add() and joins use list_add_tail(). It now has closing == 0,
remote_id == 0 and dport == 0.

The first loop does not match it, since local_id is -1. The second loop
does not skip it either, so addrs[0] becomes {peer daddr, port 0, id 0}
and bit 0 is set in unavail_id. It is visited first, so it would also
hide the valid remote ID 0 address of any live subflow later in the list.

When a fullmesh endpoint is added later, would the PM call
__mptcp_subflow_connect() towards <peer>:0? The endpoint would be marked
used and extra_subflows incremented, so that local address would still
never get a working subflow.

The commit message also says:

  "The initial subflow is kept in the conn_list once closed, and it keeps
   the local ID 0"

That seems to hold only on the tcp_shutdown() path. mptcp_close_ssk()
already treats local_id < 0 as a disconnected first subflow:

	/* The first subflow can already be closed or disconnected */
	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
		return;

Should this also skip subflows with READ_ONCE(subflow->local_id) < 0, or
with the ssk in TCP_CLOSE? Another option is to take the remote ID 0
address from the msk, as fill_remote_addr() does.

[Severity: High]
With every closing subflow skipped in both loops, can this function end
up with no candidate at all? Unlike fill_remote_addr(), there is no
fallback to the msk's remote address.

On graceful endpoint removal, mptcp_pm_rm_addr_or_subflow() calls
mptcp_subflow_shutdown() and then mptcp_close_ssk(). For an established
msk->first, __mptcp_close_ssk() sets closing = 1 and only calls
tcp_shutdown(ssk, SEND_SHUTDOWN). local_id, remote_id, daddr and dport
all stay valid, and the subflow stays in conn_list.

The msk is kept alive on purpose in this state. A comment in
__mptcp_close_ssk() says "the protocol can still create more subflows".

Take a single-subflow connection whose initial endpoint is deleted. The
closed initial subflow is then the only conn_list entry with remote ID 0.
Both new checks skip it, and the function returns 0.
mptcp_pm_create_subflow_or_signal_addr() has already cleared the
endpoint id from id_avail_bitmap at this point:

		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh,
					       addrs, ARRAY_SIZE(addrs));
		if (nr == 0)
			continue;

As a result, no subflow is attempted from that endpoint.

Does re-adding the initial fullmesh endpoint (local ID 0) still create no
subflow in this case? The selftest in the follow-up patch, "selftests:
mptcp: join: re-add the initial subflow endp with fullmesh", seems to
cover only the case with a second subflow (endpoint id 2) to remote ID 0.

There also seems to be a new regression for a different fullmesh
endpoint X (X != 0) added after the initial endpoint was removed.

Before this patch, the first loop marked nothing (local_id 0 != X). The
second loop then used the closed subflow's still-valid peer address, so
the subflow X -> peer was created.

With this patch, nothing is created and the endpoint is consumed. The
connection can then only wait for the close timeout.

Non-fullmesh endpoints still work, because fill_remote_addr() uses the
msk address:

	mptcp_remote_address((struct sock_common *)sk, &remote);

Would using the msk's remote address for remote ID 0 in the fullmesh
path, subject to deny_join_id0, cover both cases?

Since the patch is tagged for stable, these regressions would also go to
stable kernels.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019170751.200446-1-w453y.me%40gmail.com
