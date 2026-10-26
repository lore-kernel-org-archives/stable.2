Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016942;
	b=Cxe3eOr4ZwFPCrIO34jA39qQs7BaapX/LRPWYlRCR0SXAbDP18dDxiSsh3j+Yf8I/4sA
	 xr59erXnPSEF/5i/7jGZnnSas63M3cYz37aScbxme7MPmuBRbezpRFZB2UCfduj4iD3I5
	 8qqQryE5cajLV5voMzTcmECDUSOlRBncBOjQr5zPokPUGIpNURUCmrXbV1M5aq3zKkx9i
	 72KhdVFAqZIAL13oOqo9jy4zymyHYJEv2uIK/L2oOBa6de3LcfNjseAoSwszZ0pyKStz8
	 qZpDhMsF27d7MF1WEqD5DTYJxumNvcl707YRXuHLhUjmQdfRzXq70nyQS05Bx+W61mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016942;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IXFaKwcmdOnkE2hJVoEK/ilWxxhplixkaig1tchY038=;
	b=FbUBEfV6WoTv1OlLamRHfDFyXbnzEn7+eFpgjw4ZGOYc05+0PVN4uWKYVeVTB9nGQU4O
	 y92qgJXjCRaRYqMgLQZHsH2Qm/agYAMJiXblQLHNbUcbAgQJuey+9vx1RXet5ZeyU7sQi
	 ofGQxM0CUTDo0mTfQJMviWvqamr4c8ihYQKzqETj3pIxmcNJSR5HlM7ZRg2B+6iRoIXuG
	 kShbpgeNyQ6I0ZoGvZmsnuPEw2tAX+5vGIhZd63P85so2aA2jvDbL1A37WkzyuHTMur5i
	 LyBLeD2UWNJBuG5kDlOv1yG0l2cspP8KjZaI4LYwVG672BD0VHEPFDLm6MfbVIcgvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUGx0YBX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAF606A324;
	Mon, 26 Oct 2026 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUGx0YBX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5206E1F031E2;
	Mon, 26 Oct 2026 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016941;
	bh=IXFaKwcmdOnkE2hJVoEK/ilWxxhplixkaig1tchY038=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nUGx0YBXKuED6KFBkinRGaoKdoxNcOBelK2ZK8CXtOsXOxmNoInT59B9gIRsWYK0e
	 enK4rHOKbfoSJ0c8GadAt0ii1j78bSN03ia7b+KS6G65svOX+JBfNjo/MUHm+Lm3Qx
	 nQAv6xHQalCzXxQ8RcIrsvTKIzyeCjIngyu+jR9D6t8XOFl5BROSae7w28KjoSt4Mj
	 SscIJxlV/jhljW7y8T3ZmYM6SKzWkqVMpZkKlyloEQZyJUfGP3vLTjxi8gHzNqZG8M
	 RwfJ45CePfLWAv997JNiDvTT9+oMcM+FIydSbMB2bwEjpnVFg8MzHgEP1GrUvrDf1+
	 sA8inmowOOPgA==
Subject:
 Re: [PATCH net 2/5] ipv4: fix shift-out-of-bounds in ip_rt_send_redirect()
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, kuniyu@google.com,
 joel.granados@kernel.org, chia-yu.chang@nokia-bell-labs.com,
 bronzed_45_vested@icloud.com, yuuchihsu@gmail.com, fmancera@suse.de,
 hannes@stressinduktion.org, fbl@redhat.com, pmladek@suse.com,
 paulmck@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 12:15:39 +0000
Message-ID: <179301693984.3134.10311722588849367187@kernel.org>
In-Reply-To: <20261023091419.167088-3-jiayuan.chen@linux.dev>
References: <20261023091419.167088-3-jiayuan.chen@linux.dev>
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

- [Medium] The new backoff code in ip_rt_send_redirect() casts the signed
  sysctl `ip_rt_redirect_load` straight to u64.

--

ipv4: fix shift-out-of-bounds in ip_rt_send_redirect()

This commit fixes a UBSAN shift-out-of-bounds in ip_rt_send_redirect().
The shift happens when ip_rt_redirect_number is set above 32. The backoff
is now computed in u64 with the shift count capped at 31, and the result
is clamped to MAX_JIFFY_OFFSET before it is passed to time_after().

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 595a3b7f17830..76807b7570467 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c

[ ... ]

> @@ -945,10 +946,10 @@ void ip_rt_send_redirect(struct sk_buff *skb)
>  	/* Check for load limit; set rate_last to the latest sent
>  	 * redirect.
>  	 */
> +	backoff = (u64)ip_rt_redirect_load << min(peer->n_redirects, 31U);
> +	backoff = min_t(u64, backoff, MAX_JIFFY_OFFSET);

[Severity: Medium]
What happens here when ip_rt_redirect_load is negative?

The redirect_load sysctl is a plain proc_dointvec with no extra1/extra2
bounds, so root can write a negative value:

net/ipv4/route.c:ipv4_route_table[] {
    ...
	.procname	= "redirect_load",
	.data		= &ip_rt_redirect_load,
	.maxlen		= sizeof(int),
	.mode		= 0644,
	.proc_handler	= proc_dointvec,
    ...
}

When the load is a negative x, (u64)ip_rt_redirect_load sign-extends to
2^64 + x. For any shift n <= 31, the shifted value mod 2^64 is
2^64 + x * 2^n, which is still at or above 2^63.

The min_t() would then always return MAX_JIFFY_OFFSET, and this check
would effectively never be true:

    time_after(jiffies, peer->rate_last + MAX_JIFFY_OFFSET)

So after the first redirect (n_redirects == 0 skips the check), does a
peer get no more redirects until the ip_rt_redirect_silence reset clears
n_redirects?

Before this patch, a negative load produced a negative offset from
rate_last. time_after() was then always true, so a redirect went out on
every packet until ip_rt_redirect_number was reached. With this patch a
negative redirect_load seems to change from no backoff to maximum backoff.

The commit message says the u64 computation "cannot overflow since
ip_rt_redirect_load is an int". That only seems to hold for non-negative
values.

A later patch in this series restricts message_cost and message_burst to
non-negative values. It doesn't touch redirect_load, and route.c is
unchanged through the end of the series.

Would it make sense to treat a negative load as 0 before the cast? The
other option is a lower bound on the sysctl, for example
proc_dointvec_minmax with extra1 = SYSCTL_ZERO.

>  	if (peer->n_redirects == 0 ||
> -	    time_after(jiffies,
> -		       (peer->rate_last +
> -			(ip_rt_redirect_load << peer->n_redirects)))) {
> +	    time_after(jiffies, peer->rate_last + (unsigned long)backoff)) {
>  		__be32 gw = rt_nexthop(rt, ip_hdr(skb)->daddr);
>  
>  		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, gw);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023091419.167088-1-jiayuan.chen%40linux.dev
