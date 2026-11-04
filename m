Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800839;
	b=kHCX41fpYjgskvklhZzkmCjGXHOWUNYzLsrhYgzzMt5GNUR8ognETB9xLMN3NtjQia+u
	 u6o17P2CChD7iQZYcBg/HlepteAVkPusyS1hDo35pNMuFwhUapSzXwNuaGSgZyShikpHg
	 LmopddY2Z+y63W5VgvB0A6YtdXKteS2qI8qoTkuxYsD/SgUQzhKM5Sr95uex4z0KJ81sB
	 g0/596VT1nDn+3m8gD+qwmsMu31E5zV6YX8r1EwUZ9xYlm1aombWqHELDkenZPnyoZFmp
	 pwfpenFC/1z1dcx6o2Xvlj06jFxYEk7oxi0Y/oMXAblMhs6bMAcMDJp0axU575Je9tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800839;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yGD/A7wahWxDdc+IkOL3MU18AaU2I8e2m4Z/ARdxUgY=;
	b=g0E15MGtzmmdzr4DaElAP4h2nmNeg9R9a77VC/qCC9QknD8sk3dMKL6xf70YCDtOb9wp
	 ZKQBhlJAOP70IYrmoePLSQZLIQCOMT/Iassz1swWdgFwnnGJ3ce9G6BWvSEWHD4hPS8Cr
	 xaVFmow7o3F3SM4LBe1nyteSudDYSCFTlOEFzKoDbY2xLYLkt7hAxBRU74vsZzba0YbM/
	 kyv2NLkS7jcru8wa5T+Stjy5CzBd/nOyD1iCE9cENci0mPXFPt5v6qXOmW67wz2aGdsUz
	 RMN46xp8LI67gpDWo+qht4b8HKFqbnRUSrYKvc5tconoF6ZYseviqX4w86Wg+DxPNsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghAQ5d2G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B5606A329;
	Wed,  4 Nov 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghAQ5d2G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259EB1F00A15;
	Wed,  4 Nov 2026 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800838;
	bh=yGD/A7wahWxDdc+IkOL3MU18AaU2I8e2m4Z/ARdxUgY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ghAQ5d2G7fy0GRrNGqDxEQmkxuM1RE2ZFFtUh2UuUYP341z2DrHB1odlOdI8Nv1Xb
	 hyGMYYJRy4EtBaiOBo1ywoVP6sIEeg6UOSqiyurnr1gpxIjreVnhMVmCMv8EWLIgjG
	 NK6vULPjJ9y/ZYRp64FmbF6qeNjF3sL1qOD7ItphmL6CNW8BHuU9V2fd0oPhM2IQ77
	 DDUcR9IyClg+OJEy+2PbTyGDLTPhS3jY/g6MENT9IQuSqa5QUX6AJf/MUUdarAhl5E
	 O4H98+0JFmFR4b+mEItpNlKei/UGjNFUnkDc/jL3r+91R+ZN29xsmuVjE4CGDVSZif
	 iuMS6P7JyjHdA==
Subject: Re: [PATCH net v3 2/2] net: gro: invalidate frag0 after a pull
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, willemb@google.com, steffen.klassert@secunet.com,
 tom@herbertland.com, cenzhang@linux.microsoft.com,
 AutonomousCodeSecurity@microsoft.com, stable@vger.kernel.org,
 tsgatesv@gmail.com
Date: Wed, 04 Nov 2026 14:00:37 +0000
Message-ID: <179380083773.488856.10057167003627471575@kernel.org>
In-Reply-To: <20261103105752.49542-3-edumazet@kernel.org>
References: <20261103105752.49542-3-edumazet@kernel.org>
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

- [Medium] The patch adds a fallback in gro_try_pull_from_frag0()
  (net/core/gro.c:465): when frag0_len is 0 it calls `pskb_may_pull(skb,…

--

net: gro: invalidate frag0 after a pull

This patch adds skb_gro_frag0_invalidate(), which clears
NAPI_GRO_CB(skb)->frag0_len. It is called before the pulls in
skb_gro_header_slow(), skb_gro_receive_list(), udp_gro_receive_segment(),
esp4_gro_receive() and esp6_gro_receive(). It also changes
gro_try_pull_from_frag0() so it copies from frag0 only while frag0_len is
not zero, and falls back to pskb_may_pull() otherwise.

> diff --git a/net/core/gro.c b/net/core/gro.c
> index 1b033855a20db..49e7f64f27756 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c

[ ... ]

> @@ -454,8 +455,14 @@ static void gro_try_pull_from_frag0(struct sk_buff *skb)
>  {
>  	int grow = skb_gro_offset(skb) - skb_headlen(skb);
>  
> -	if (grow > 0)
> +	if (grow <= 0)
> +		return;
> +
> +	/* frag0 can only be used if no pull happened. */
> +	if (likely(NAPI_GRO_CB(skb)->frag0_len))
>  		gro_pull_from_frag0(skb, grow);
> +	else
> +		pskb_may_pull(skb, skb_gro_offset(skb));
>  }

[Severity: Medium]

Is it safe to ignore the return value of pskb_may_pull() here?

gro_try_pull_from_frag0() still returns void. Before calling it,
dev_gro_receive() has already incremented gro_list->count (or called
gro_flush_oldest()). After it returns, the skb is held unconditionally:

net/core/gro.c:dev_gro_receive() {
    ...
	if (unlikely(gro_list->count >= MAX_GRO_SKBS))
		gro_flush_oldest(gro, &gro_list->list);
	else
		gro_list->count++;

	/* Must be called before setting NAPI_GRO_CB(skb)->{age|last} */
	gro_try_pull_from_frag0(skb);
	...
	list_add(&skb->list, &gro_list->list);
	ret = GRO_HELD;
    ...
}

Before this patch, gro_pull_from_frag0() was the only thing done here,
and it could not fail because frag0_len is bounded by the tailroom.

One way to reach this point with frag0_len == 0 is through
esp4_gro_receive() and esp6_gro_receive(). With this patch they do:

	skb_gro_frag0_invalidate(skb);
	if (!pskb_pull(skb, offset))
		return NULL;

This returns without setting NAPI_GRO_CB(skb)->flush. For an ordinary
unfragmented IPv4 packet, inet_gro_receive() computes flush as 0, so
dev_gro_receive() takes the GRO_HELD path.

offset == skb_gro_offset(skb), so the retry in gro_try_pull_from_frag0()
is the same pull that just failed.

If the held skb's linear area does not reach skb_gro_offset(), later
packets in the same bucket would read stale tailroom bytes as headers:

net/ipv4/af_inet.c:inet_gro_receive() {
    ...
		iph2 = (struct iphdr *)(p->data + off);
    ...
}

The same applies to ipv6_gro_receive(), udp_gro_receive() and the
tcp_hdr(p)/udp_hdr(p) lookups.

If one of these bogus headers matches and a merge happens,
inet_gro_complete() writes tot_len and check through skb->data + nhoff.
Those writes would go into tailroom rather than the real header, and the
aggregated packet would keep its original single-segment tot_len.

The window looks narrow. The retry can only fail for an skb that entered
GRO with headlen == 0 and frags[0] mapped as frag0, and that skb must
also be either:

  - cloned, with pskb_expand_head(..., GFP_ATOMIC) failing, or
  - carrying unreadable frags while frags[0] is a normal page.

No concrete in-tree source of such skbs has been identified, but they
don't look impossible either.

Could gro_try_pull_from_frag0() return a bool? On failure,
dev_gro_receive() could undo the count change and take the normal path
instead of holding the skb.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103105752.49542-1-edumazet%40kernel.org
