Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339181;
	b=ASBya2WohYRgET876YP6vmBBnUAgawLxLDggEDqTPhJnIcFipWxSZmEcO2H9SbswZWXV
	 r7C30QP8Fg1BYSeOah20Xai5EVJOtNeEIDTEP9cEsyKtBDx0LB0R4kBNYEYWEVkZ2zLkK
	 sKqGRIRvFvs9GHz4c8PkgZjWDcKTb9nmFM/lvc6f2HtUTNY6Tn4iuhaFCyG/S0osZhHD6
	 ECaP8wieouNM7uwIn+ZB1kfBEgvhMNT1OBeqz1Sb/uDB6gHXJXMOGSL0AboVOqcfWPtKF
	 ihj3bocl/hVo0sl1RzhMfm/titcuWEECW1iaRFfUqVpA/qloiKUBHTPbjT9pBTt2dvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339181;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fVNYRzFGTGfYNkMSOeZUACCFY7N+y5n5CkCmP6DMOOY=;
	b=FAs59KSzij4bTIAQBGOn9vApTqgHZzK+gNlzKav/uJsOO0wTL0yNLkmLCLmPUyulPKlg
	 mOBifbCso04UkKXc6Fd1zSDjdxlebQEK/7d3D17NXi37VEc5eKGf4G9oB2GeAoNebdeNx
	 yULr1VFeBZQkxB5dZOePFsfVchBohhScb4STLvJ8xfK8/9T/6iDq7yprBwyqB0xJvhtpM
	 o+Zi68p6+jDdwLfm5mNY1HIZ04SFt+euTB7oNK1iFHkt9vYUrzpsc5vyt2IkHyAZPg7M5
	 jh0nEFY1IH0g4XD8g78Y+s0SKOqIx4Huv98XsMeM5aMW1fGfbo+JBoaH+t5AYn9Doxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd0ckpvV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39C606A689;
	Sun, 22 Nov 2026 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd0ckpvV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB5E1F000C0;
	Sun, 22 Nov 2026 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795339181;
	bh=fVNYRzFGTGfYNkMSOeZUACCFY7N+y5n5CkCmP6DMOOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dd0ckpvV9iU7+l+MXGIYaoxsyzfzMGuyX+mHtXwLU3oOVA4/OiyW8JrxgW0I3Xqec
	 7FgAEaDrhiJB092xBEqWK/s49hNFgLMbFpjyHvt1qet9i0msAlDiKZ1ZBj83NddO9q
	 /4ArRBggAXbyey3y8ParLgxacHl4TUbBEtfcROGQUrtS2o8AdewpqfAF9kSnlFwmg9
	 4rb96Nm62Qvp7xfkr+AwcQESkV9ASMn5NQ+aFeAESjEOglV978WkqaWpD4meoMx1ZT
	 vXjqkR4MwyY1PHsPR6/47P19h6xmDgyClyhSkm8PA3oBVhADR618h0X5rvVc2jotl3
	 HQ7hJASzf2Ugw==
Subject: Re: [PATCH net 4/4] net: skbuff: limit folio refcount when splicing
 from sockets
From: netdev-bot+sashiko@kernel.org
To: david@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org,
 kas@kernel.org, songliubraving@fb.com, hannes@cmpxchg.org, riel@surriel.com,
 willy@infradead.org, ncardwell@google.com, kuniyu@google.com,
 pfalcato@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Date: Sun, 22 Nov 2026 09:19:40 +0000
Message-ID: <179533918041.3135.8460911693239501161@kernel.org>
In-Reply-To: <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
References: <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
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

- [Low] The new comment above skb_splice_bits()
  (net/core/skbuff.c:3295-3300) says the function "Returns the number of…

Pre-existing issues:
- [Medium] skb_splice_bits() still returns 0, which callers report as
  EOF, when nothing was spliced because linear_to_page() failed to…

--

net: skbuff: limit folio refcount when splicing from sockets

This patch uses try_get_page() in spd_fill_page() so that splicing from
sockets into pipes cannot push a folio refcount past its limit. On
failure it returns -EFAULT, and the error is propagated as an int
through __splice_segment() and __skb_splice_bits(). skb_splice_bits()
returns the error when nothing was spliced, so the callers don't report
EOF.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c937d74eed6ac..b73fef7a1b460 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -3284,7 +3294,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
>  
>  /*
>   * Map data from the skb to a pipe. Should handle both the linear part,
> - * the fragments, and the frag list.
> + * the fragments, and the frag list. Returns the number of bytes spliced,
> + * or an error if we could not splice anything because we could not take
> + * a page reference.
>   */

[Severity: Low]
This isn't a bug, but is this return description complete?

When spd.nr_pages is non-zero, skb_splice_bits() returns whatever
splice_to_pipe() returns. splice_to_pipe() in fs/splice.c can fail for
reasons that have nothing to do with page references:

	if (unlikely(!pipe->readers)) {
		send_sig(SIGPIPE, current, 0);
		ret = -EPIPE;
		goto out;
	}
	...
	if (!ret)
		ret = -EAGAIN;

The reverse case also exists. If linear_to_page() fails in
spd_fill_page(), nothing gets spliced, yet skb_splice_bits() returns 0
and not an error.

Could the comment also mention the -EPIPE and -EAGAIN cases that come
from splice_to_pipe()?

>  int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>  		    struct pipe_inode_info *pipe, unsigned int tlen,
> @@ -3299,14 +3311,14 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>  		.ops = &default_pipe_buf_ops,
>  		.spd_release = sock_spd_release,
>  	};
> -	int ret = 0;
> +	int ret;
>  
> -	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
> +	ret = __skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
>  
>  	if (spd.nr_pages)
> -		ret = splice_to_pipe(pipe, &spd);
> -
> -	return ret;
> +		return splice_to_pipe(pipe, &spd);
> +	/* Returning 0 would make callers report EOF. */
> +	return ret < 0 ? ret : 0;

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Can the
spurious EOF that this new comment describes still happen when
linear_to_page() fails?

When skb_head_is_locked() is true (a kmalloc'ed head or a cloned skb),
spd_fill_page() goes through linear_to_page(). An allocation failure
there returns a positive value, not a negative errno:

net/core/skbuff.c:linear_to_page() {
	...
	if (!sk_page_frag_refill(sk, pfrag))
		return NULL;
	...
}

net/core/skbuff.c:spd_fill_page() {
	...
	if (linear) {
		page = linear_to_page(page, len, &offset, sk);
		if (!page)
			return true;
	}
	...
}

That 1 is passed up through __splice_segment() and __skb_splice_bits().
With spd.nr_pages == 0, skb_splice_bits() then returns 0 here.

The callers treat the 0 as end of stream even though data is still
queued:

  - unix_stream_read_generic() adds a chunk of 0, breaks because
    unix_skb_len(skb) is non-zero, and returns 0.
  - tcp_splice_read() breaks with ret 0 although the receive queue is
    not empty.
  - kcm_splice_read() and tls_sw_splice_read() return 0 directly.

The old code also returned 0 in this case. Hitting it needs severe
memory pressure, where sk_page_frag_refill() fails both the high-order
and the order-0 allocation.

Would it make sense for spd_fill_page() to return a negative errno such
as -ENOMEM when linear_to_page() fails? That would send it down the same
error path as the try_get_page() failure.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118-skb_refcount_overflow-v1-0-5551b4954c3f%40kernel.org
