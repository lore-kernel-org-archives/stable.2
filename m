Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339177;
	b=qWgq5nmR45HCN0MVI05Ycq36O4DpiFNWQvZ+bO7ikbRwgrxMJntoj5D6QxMmlruj4BZw
	 ujHpNAMewguBlNLN78glJ1SaIIT+vjy35sk90jSQvKtAlHx/MD/g8oO4aS8c3++1fYGYg
	 uPfiRz20p+E0nSo/IP08NJTItnWGW2lrdzm30v4avEKL6HN52o7DqAU7a4OdnnYNBlpHr
	 3ZB5rD1Mw3F+nU1jGe6e0vIggSI2KwuQhrx6MVQZPyyLF4VZydIUQMy9Auwyl7UDnob8s
	 zl+d5FPLR4CthKRFrM/YKsjXHaavWGrlTzNQdh9pULXPC9zZEAxgLh1d5Etexv7gj3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339177;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BzQISL5lSMrXxR4Vn+nWmVJdpxxTtSXQ7y9eFl2L6oI=;
	b=kSGBuUPlV1D6F3dnrNZkIcrohuARRzOFgASUpW7FY1zwRhuljtDHaWFz+FzsxOW9sznn
	 P4TY4B9TeQwzxKFvVJZ/+6t85rcyVMby9TEhZX6FIsBlAKaNIcmv7xjq6p6N+ckvGqyRN
	 lvbVjBbGoBx4qYLoO4s21mbrD3UEXeklmMl+nG6vUwrP0PawyqSox7hl44hvjC9u8iQJG
	 L7I554ecJ9UyORPoYaX2CnVnc6nCePeiFPpziggTI9IHMUIpzKL1fR1ousuYJSq0Dcuoz
	 W3OiVwWyUbV6/ZiE97S1X59s950AhFVxiXZDv9pqIIqrrUm8wCBsK+buxcZOdrMfAhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6BShycF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AF606A320;
	Sun, 22 Nov 2026 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6BShycF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1288E1F000C0;
	Sun, 22 Nov 2026 09:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795339177;
	bh=BzQISL5lSMrXxR4Vn+nWmVJdpxxTtSXQ7y9eFl2L6oI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k6BShycFQ7Et7Ajt8PiMo9vbr3rvYz5QOtnCooR1aE7EFb+3YI59uEcKudTxmqHB+
	 zKgQnGRmjvJPRRBW+PmV06QmfMBYoHQ9jBJFozoguS9jQ5BjcHAzcM2xEo4wH04CM4
	 b7PtNbMoDT4gVDjw59JgaIkqlixRUbENRxp369RfnlWCDLXLZZExFQMEse5PvtuuZY
	 P5mkZ14b1rGZ+Z2NAW4XtKjlDV0zdEczliwYdn6dhaxBVwRpWXGneFrHEd0SYa76wC
	 5TTnfdivPyHRviIudf7dkHwpvO6zZNdAYeiV9T3/cHbS1TBk3U3XWHqrZTLZWY6xp1
	 zXi0wo3Rjd/Sw==
Subject: Re: [PATCH net 1/4] net: skbuff: limit folio refcount when copying
 skb frag references
From: netdev-bot+sashiko@kernel.org
To: david@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org,
 kas@kernel.org, songliubraving@fb.com, hannes@cmpxchg.org, riel@surriel.com,
 willy@infradead.org, ncardwell@google.com, kuniyu@google.com,
 pfalcato@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Date: Sun, 22 Nov 2026 09:19:35 +0000
Message-ID: <179533917558.3135.17684828734142496084@kernel.org>
In-Reply-To: <20261118-skb_refcount_overflow-v1-1-5551b4954c3f@kernel.org>
References: <20261118-skb_refcount_overflow-v1-1-5551b4954c3f@kernel.org>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] skb_frag_try_ref() (include/linux/skbuff_ref.h) sends every frag
  page that is neither page_pool nor net_iov through try_get_page() ->…
- [Low] The patch is tagged Cc: stable with Fixes tags going back to v4.8
  (800d8c63b2e9).

--

net: skbuff: limit folio refcount when copying skb frag references

This patch adds skb_frag_try_ref() and skb_frags_try_ref(). They take
non-page_pool frag page references through try_get_page(), so the folio
refcount limit is enforced. pskb_expand_head(), __pskb_copy_fclone(),
skb_zerocopy() and pskb_carve_inside_*() now use them and fail when a
reference is refused.

> diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
> index b6f6da556ee90..560ddc863bbec 100644
> --- a/include/linux/skbuff_ref.h
> +++ b/include/linux/skbuff_ref.h
> @@ -44,6 +44,33 @@ static __always_inline void skb_frag_ref(struct sk_buff *skb, int f)
>  		       skb->pp_recycle);
>  }
>  
> +/**
> + * skb_frag_try_ref - try to acquire a reference on a paged fragment of an skb
> + * @skb: the buffer
> + * @f: the fragment offset
> + *
> + * Like skb_frag_ref(), but acquires non-page_pool page references using
> + * try_get_page(), refusing additional references to a page whose refcount is
> + * at its limit.

[Severity: Low]
This isn't a bug in mainline, but the refusal described here only works
because try_get_page() enforces the refcount limit. That check was added
by commit c6c9a4c1c9a1 ("mm: limit pagecache folio refcount when splicing
into pipes"), which builds on 26b8f029ce52 ("mm: limit pagecache folio
refcount when mapping pages").

Before those commits, try_get_page() had no upper bound:

	page = compound_head(page);
	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
		return false;
	page_ref_inc(page);
	return true;

This patch has Cc: stable and Fixes tags back to 800d8c63b2e9. A backport
to a tree without the prerequisites would still compile. There,
skb_frag_try_ref() would never refuse a reference and would only warn
after the refcount has wrapped.

Could the commit message state this dependency, for example with a
"# depends on" note on the stable tag?

> + *
> + * Return: True if a reference was acquired, otherwise false.
> + */
> +static __always_inline __must_check bool skb_frag_try_ref(struct sk_buff *skb,
> +							  int f)
> +{
> +	netmem_ref netmem = skb_frag_netmem(&skb_shinfo(skb)->frags[f]);
> +
> +#ifdef CONFIG_PAGE_POOL
> +	if (skb->pp_recycle && napi_pp_get_page(netmem))
> +		return true;
> +#endif
> +	if (netmem_is_net_iov(netmem)) {
> +		net_iov_inc_ref(netmem_to_net_iov(netmem));
> +		return true;
> +	}
> +	return try_get_page(netmem_to_page(netmem));

[Severity: High]
Can this make the converted paths fail on every packet for drivers that
deliberately keep RX page refcounts near INT_MAX?

Every frag that is neither page_pool nor net_iov now goes through
try_get_page()->folio_get_checked()->__folio_ref_count_over_limit(). That
check applies to any folio, not just pagecache folios.

The gve driver uses GQI RDA/QPL and DQO-QPL, and none of these use
page_pool. It biases its RX pages up to INT_MAX:

drivers/net/ethernet/google/gve/gve_rx.c:gve_setup_rx_buffer() {
    ...
	/* The page already has 1 ref */
	page_ref_add(page, INT_MAX - 1);
	page_info->pagecnt_bias = INT_MAX;
}

The qpl_copy_pool setup in gve_rx.c and gve_alloc_qpl_page_dqo() do the
same thing.

Handing a frag to the stack only decrements the private bias. When the
bias runs out, the page count is raised back to INT_MAX:

drivers/net/ethernet/google/gve/gve_utils.c:gve_dec_pagecnt_bias() {
	page_info->pagecnt_bias--;
	if (page_info->pagecnt_bias == 0) {
		int pagecount = page_count(page_info->page);
		...
		page_ref_add(page_info->page, INT_MAX - pagecount);
	}
}

So for roughly the first 33M frees of each ring page, page_count() stays
at or above FOLIO_REF_COUNT_ADMIN_LIMIT. For roughly the first 67M it
stays at or above FOLIO_REF_COUNT_LIMIT.

In that range folio_ref_count_over_limit_slowpath() refuses the reference:

	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
		goto over_limit;
	...
	if (!in_task())
		goto over_limit;

It refuses unconditionally above the admin limit, and always in softirq.
Each refusal also prints the ratelimited "reached refcount limit" warning.

If that's right, these paths would fail every time for gve RX skbs that
carry page frags, i.e. packets larger than rx_copybreak:

  nfqnl_build_packet_message()->skb_zerocopy()
    (NFQUEUE copy-packet mode, the packet is dropped)
  queue_userspace_packet()->skb_zerocopy()
    (OVS upcall fails)
  ___pskb_trim()->pskb_expand_head() on a cloned skb
    (AF_PACKET with snaplen < len)
  skb_unclone()/skb_cow()->pskb_expand_head() after a tap cloned the skb
  __pskb_copy_fclone()
    (pskb_copy users such as nft dup)
  pskb_carve_inside_header()/pskb_carve_inside_nonlinear()

Before this patch these paths only failed when a GFP_ATOMIC allocation
failed, because get_page() kept incrementing without a check.

Later patches in the series apply the same check to skb_segment(),
skb_try_coalesce(), skb_shift(), tcp_clone_payload() and spd_fill_page().
That would also affect software GSO of forwarded GRO packets. splice()
from TCP and AF_UNIX sockets would return -EFAULT on gve-received data.

The kernel-doc for __folio_ref_count_over_limit() in include/linux/mm.h
says "Checking other folios does no harm.". That doesn't seem to hold for
drivers that bias refcounts this way.

There is also a more speculative issue. folio_get_checked() has an
unconditional WARN_ON_ONCE(ref_count <= 0). If any remaining unchecked
get_page() wraps such a page to INT_MIN, a later skb_frag_try_ref() on it
would fire a real WARN. One example is iptfs_skb_add_frags() in
xfrm_iptfs on RX outer-packet frags. Under panic_on_warn, a remote sender
could trigger that WARN.

Since this is Cc: stable, would it be better to restrict the check to
pagecache folios in these net paths? Alternatively, gve could stop biasing
to INT_MAX, with that change backported as a prerequisite.

> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118-skb_refcount_overflow-v1-0-5551b4954c3f%40kernel.org
