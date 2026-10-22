Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699845;
	b=g/HCEDe3D/HQZdXgfeLDCHgU7Syw3x3bWtml59oRNDOmCJjJY3HXpr681DJxAujewL6l
	 /u899as683Sx7NkjQ0KEs5XxPJOim2oCg0kkG8d+MrpI6v2mzFmrJ+QIBNYAFlSHajog+
	 88xHHMk9TvIlJBALBVxZlWg+6UQhdGrn75GDlXxNBQPStoXqEo/8I4y0RgNW8fj4JA0rs
	 03QwPX7s8B7HD8hmi4f2l1eUFW4czVDfOdD5uIaxEMbZ9HY/uHuGWXEEx4lNifg5E5on+
	 C2WdCc35FPH4rlHve2BaKZeP2JkJA6YGC4c9oPiIwpS7yZfJw3fv5CAmulfGRyxlApQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699845;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FG273xMG1Uae6fqL/j4kCU9/xbfPk6mISMKHJAcQOuo=;
	b=BPwae1uYs1AX84nr3qGdOheBkCdnT090cyTdxEGhMS7uKNirfcL/ktuxxoTMv51urLJ6
	 +8Q1Fpynu0h8qUt2u7Xo1DiBLzlhnojgPgn/hWUN/WlxugLG6hjjUu+30I9TpV0S4y9JL
	 jW6vm222cDN4GH7Cbct1sunzDacjjf6fC699nMHUPMIl9ZTSd48qJI+jTFkP8Zk4W4bwe
	 piL0PTntsOvhoOXSqLKR7K4oCgkUBuTduiyGRqJFK+NN5feBZaadVu3VPkpH2xr6V+Dm+
	 9mlV8k5goOmVJURfehrV7QA0DjtXcZLpDsXWqRNf/AqnsVQB7zLcA9/B15zqWE1fLqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JDF542N/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E5606A31D;
	Thu, 22 Oct 2026 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDF542N/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4331F01825;
	Thu, 22 Oct 2026 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792699844;
	bh=FG273xMG1Uae6fqL/j4kCU9/xbfPk6mISMKHJAcQOuo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JDF542N/voHMh8Ttpa695Cp3cQC56d1e+882C4gB1AJgdoUUp/Dleh2q/vd/WEcvi
	 gPN/HBMAJy8p6CDv8AuHPT1kKhf6jZmDepTAXiFomOB7HMGXgQPy7OA7ITjb3VPjTW
	 wxaB8mYdFWVBBp2BJxNYUziFZP9OSGRgdIwgwUVv/pBrtkEKWzJa9sNXeyElh9c0gW
	 fhJ5raHJRO/B9aNSIqn6cFKZKCFLqpREztgReRVeKuwRM4xKYGneoy9ueZUnkIbm/T
	 LZsfpHno8yncdn/rf5zAAzagQ4W8/nm0vsTJpO32rtpiy6e9ZaGOw2fLWzJHRuy2jj
	 IwhXy5GApi14A==
Subject: Re: [PATCH mptcp-net v5 1/2] mptcp: pm: in-kernel: fullmesh: skip
 closed subflows
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 22 Oct 2026 20:10:43 +0000
Message-ID: <179269984391.3133.8401922398950966518@kernel.org>
In-Reply-To: <20261021070324.50533-2-w453y.me@gmail.com>
References: <20261021070324.50533-2-w453y.me@gmail.com>
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

- [Low] The commit message gets the failure mechanism partly wrong for
  the case where the initial subflow is already in TCP_CLOSE.

--

mptcp: pm: in-kernel: fullmesh: skip closed subflows

This patch changes fill_remote_addresses_fullmesh() to skip subflows that
are closing or in TCP_CLOSE. They are skipped both when collecting the
remote IDs in use and when picking remote addresses. If no subflow is left
to provide the remote ID 0 address, the remote address of the MPTCP socket
is used instead, as fill_remote_addr() does.

> If it was already in TCP_CLOSE,
> e.g. after a reset, it is disconnected and its context is reset: the
> 'closing' flag and the remote ID are cleared, and its remote address
> and port are zeroed. It is then picked as a remote address, with the
> address 0.0.0.0, the port 0 and the ID 0, which also marks the remote
> ID 0 as unavailable.

[Severity: Low]
Is this description of the TCP_CLOSE case accurate?

>From __mptcp_close_ssk(), the initial subflow stays in the conn_list and
goes through __mptcp_subflow_disconnect():

net/mptcp/protocol.c:__mptcp_subflow_disconnect() {
    ...
	WARN_ON_ONCE(tcp_disconnect(ssk, 0));
	mptcp_subflow_ctx_reset(subflow);
    ...
}

On that path, tcp_disconnect() resets only the destination port and the
source address:

net/ipv4/tcp.c:tcp_disconnect() {
    ...
	inet->inet_dport = 0;

	inet_bhash2_reset_saddr(sk);
    ...
}

inet_bhash2_reset_saddr() ends up in inet_reset_saddr(). That clears
inet_saddr, inet_rcv_saddr and the IPv6 source addresses, but not
sk_daddr or skc_v6_daddr. mptcp_subflow_ctx_reset() clears the reset
group (closing, remote_id, ...) and sets local_id to -1. It does not
touch the socket addresses.

So in the old fill_remote_addresses_fullmesh(), mptcp_remote_address(ssk)
would return the real peer address with port 0 and remote ID 0, not
0.0.0.0:0.

The conclusion still holds, since port 0 is unusable and remote ID 0
still gets marked as unavailable. Could the changelog say that only the
destination port, the source address and the IDs are reset, and that the
peer address is kept?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021070324.50533-1-w453y.me%40gmail.com
