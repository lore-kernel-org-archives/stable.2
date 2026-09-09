Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4309569F39;
	Wed,  9 Sep 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965378; cv=none; b=pGVNW1SX2LczFH3nGyyFSrqg1GeCTbv+WRjAlUy9GqJHpkRfp3WPREz6/+jqp4VRJVqusxSi5rAIr5zIfZa0L5pSuhMNCirXA32VqvudvyZRxpdwkgUWI7YrD06mJlH0MTEh+we04XloXUD4O2E5iqeMWIDQ5rY2YDIo4X/IA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965378; c=relaxed/simple;
	bh=J4EZs/1fcDexciQsoFKdQczKjyQOpGWz/QDI4ZwgWoY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MbAItnccbUsOOmLsYBUFkZPNsBj42P9DI56LuIU96gPF8wnxAUQBFkIS0oUbtXeZsMrAQ3qLTJnau2NKTXfR0Hq/OVUM6Pd8ZjuUnm8NxawQ1YD+8HCbk8pgjuWYJ8ucTtIQyO46FT36/dm96uHcWZ/DxQGGLxCkdbGtCeu/plQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKkQUYTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKkQUYTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E71B1F00A3A;
	Wed,  9 Sep 2026 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965376;
	bh=NhcQi1GvIwJhTO5Gh64vIrmVrIKaz0htQF1FYr4p65Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HKkQUYTTJhsgiEiFaLMZhZMJ5xU67NduZLSXGGv0M2d/YO1xHptYYnr0KaR0T4cta
	 BDKEhDIy1lL75Fq0t+rbrWp4RuF6o3sWic9RBuQtdPIfebYVvUF+UJ4HMEsydGb8Zm
	 LCWAJ3z6x9wePKUzD0Zza3yg3NMOd6699i9+WxBs91Jb4RrA5d2f9A/GEfhha/ECaa
	 S7/KadrVyrH9WFtFokThhse2u+OrSVCXeY2JiZMg9eqykWA/zaz6PwAy82B1jYUJte
	 uj3/8Ii0hgW9+pg2hkoidfntW05rIRHlt4dtHbVwwZ/bHKrEbLGzi28LajGfDXc4VS
	 rRXqLPhWycJVQ==
Subject: Re: [PATCH net v2 05/15] mptcp: options: handle MPC data + csum reqd
 + no csum
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 09 Sep 2026 14:49:35 +0000
Message-ID: <178896537514.219967.16760487622956837996@kernel.org>
In-Reply-To:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-5-df1de70348b6@kernel.org>
References:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-5-df1de70348b6@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1 (1)

- [Low] Residual uninitialised read of `mp_opt->csum`: the patch closes
  the functional consumer of the uninitialised checksum…

Pre-existing issues:
- [Low] Reported concern (assessed as an intentional, documented
  behaviour change): a passive endpoint whose local checksum sysctl is…

--

mptcp: options: handle MPC data + csum reqd + no csum

The MP_CAPABLE parser now only honours the checksum required flag for
options that do not carry a data-len, so a peer that sets the flag on a
data-bearing MP_CAPABLE without appending the 2 bytes of checksum no
longer makes the receiver use an uninitialised csum field.

Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-23 [1]
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=1

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b8318e030138..92f27b9e087a 100644
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

[Severity: Low]
The commit message says "uninitialised bytes could be used for the 'csum'
field".  Is the uninitialised csum field itself still read after this
change?

In mptcp_parse_option(), mp_opt->csum is only assigned in the 24-byte
form:

	if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
		mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
		mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
		ptr += 2;
	}
	pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
		 version, flags, opsize, mp_opt->sndr_key,
		 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);

but the pr_debug() passes mp_opt->csum for every opsize, including the
22-byte MP_CAPABLE + data form this patch is about.

The struct is an uninitialised stack object in mptcp_incoming_options()
and in net/mptcp/subflow.c, and mptcp_get_options() only clears the
4-byte status group:

	*(u32 *)&mp_opt->status = 0;

while protocol.h declares csum outside of that group:

	u16	data_len;
	__sum16	csum;
	struct_group(status,

So when that dynamic-debug callsite is enabled, 2 bytes of stale stack
are formatted into dmesg on a remotely reachable path.  The same
pr_debug() also prints sndr_key/rcvr_key/data_len for short opsizes,
so the debug-print read predates this commit; it is mentioned here
because the commit message frames the fix as removing the uninitialised
use of csum, and a stable backporter may read it that way.

Would adding mp_opt->csum = 0 (or extending the region cleared in
mptcp_get_options()) address this at the root, rather than relying on
every consumer testing OPTION_MPTCP_CSUMREQD?

[Severity: Low]
This isn't a bug introduced by this patch, but a question about the
passive side losing the peer's checksum requirement in one corner case.

subflow_init_req() derives the requirement from the local sysctl only:

	subflow_req->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk_listener));

and subflow_check_req() does not preserve OPTION_MPTCP_CSUMREQD from the
SYN, so mptcp_sk_clone_init() is the only place where the passive side
picks up the peer's flag:

	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
		WRITE_ONCE(msk->csum_enabled, true);

With the new opsize test, a 22-byte MP_CAPABLE + data with the A bit set
no longer sets that suboption, so msk->csum_enabled stays false and
get_mapping_status() accepts the mapping without validation:

	if (unlikely(subflow->map_csum_reqd != csum_reqd))
		return MAPPING_INVALID;

For a Linux sender the two signals cannot diverge, since
mptcp_established_options_mp() and mptcp_write_options() both derive the
A flag and the checksum field from opts->csum_reqd, and RFC 8684 omits
the checksum field only when checksums are not in use, so only a
self-contradictory peer reaches this path.  The commit message already
covers that trade-off.  The gap where the peer's SYN A bit is never
stored in subflow_req is pre-existing and unchanged here.

Would it be worth a short note in the commit message that the passive
side's only source for the peer's A bit is the third ACK, so the new
condition also drops that signal for a data-bearing third ACK?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6%40kernel.org
