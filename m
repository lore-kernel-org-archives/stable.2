Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814512;
	b=oCUCPO3SK2pJHEAFH/qpr58t3gej9NjZ3XfoEg4CMDeAERHKmHGCMA1xv91KoeekcI8S
	 BiLcCygMVPqSUr9N+SZpC0Fj6z6jXr4YsndIvEeXVaU+v6wgLRoW9JiACKdQ4WCg/QOWQ
	 NRPoB09Uj6a6xBGzy15CPD2zss/2Iza3mr8jxxVpro3V5JoydI/KVmAgCyX0BewsYK8kc
	 /jvryj+LyUQh076zs+WWNSSo+nFCI0H87V4r7duy/Ozu7cJ+Z6k2sCYOeerk8TA204ea7
	 F3tmk/rHEbsUyNhttB8YlTcOJGJ6+jIqiG/80qSu7fXuBTVsPOLcT12H1OmpWjBVqDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814512;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YIRTDuQE4r/aXiKDRPP0uS7lZ5Ydoef491BfdGmULdw=;
	b=F5TpXjvGkpPwermH61p12B9DRNVjKI9g77lLVLP72sCbBhzSGP5JCLO811U25/gihK5N
	 bgMjn/upFHtl0B0FYRopPh7Fzby0oXSlIlU7R5eSoRZmTIIMpkbe8/qUFzUTQe1mpPRhK
	 QBcXGjN6Wki14II00E/dY16ijCyQnZtrpVadXC9QY97l5OgN3EZAFPo0rpbbm0iFJuBdb
	 VhjBMNJWePmzMLpKHImVA+tf7LRzGAoEKmO46NUQS04Qupd6bzijeYbnrnt1cfcchhyhR
	 6U3HRF+Dr3yaE6V/ye27K3S9aEjIeAy1KFbQK7no4P2SDfRoHxF22+6LzZ1xtmvUFUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyXeg09V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED76606A336;
	Fri, 27 Nov 2026 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyXeg09V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDD91F00897;
	Fri, 27 Nov 2026 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795814512;
	bh=YIRTDuQE4r/aXiKDRPP0uS7lZ5Ydoef491BfdGmULdw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GyXeg09VB0wAl0TmCP+UxG6RrRmfqXEG/4IhxJ1zoEH9+INmjqQYNKNW4+b5QtRfR
	 a3BcfF8GGG9UpO8uDuxoTgZdzukxLv6z835qNLUvGZFLqAvcsIvzNZXers5+YqN++K
	 Vd5kyeQlCd0MtrhRzUSsUEMiaobcSmqLmrd1+G1HmEweLidfTv69X4gvyXHbzWJ8eP
	 yYA9yyYffm5lqcZcc88Ppw9imIM8tpLNdK5ncLgOXbvjk8GQnt1xvVYxIdaelCsYTk
	 6f6CshpkX6nsGDDWnyC0tNwO9L6M+wdB49AHjiNNsJ9Xi6fk5sUqHarMJQrYdb5Vtc
	 tK03Xs9SeMDUA==
Subject: Re: [PATCH net v2 3/4] net: skbuff: limit folio refcount when
 splicing pages into skbs
From: netdev-bot+sashiko@kernel.org
To: david@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, sdf.kernel@gmail.com, willemb@google.com, horms@kernel.org,
 akpm@linux-foundation.org, kas@kernel.org, songliubraving@fb.com,
 hannes@cmpxchg.org, riel@surriel.com, willy@infradead.org,
 ncardwell@google.com, kuniyu@google.com, pfalcato@suse.de, cel@kernel.org,
 jlayton@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 21:21:50 +0000
Message-ID: <179581451032.3135.17667643003292457918@kernel.org>
In-Reply-To: <20261126-skb_refcount_overflow-v2-3-a6f600a5634a@kernel.org>
References: <20261126-skb_refcount_overflow-v2-3-a6f600a5634a@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The refcount-limit fix does not cover kernel TLS, so the case
  the commit message uses as its example (sunrpc/nfsd sending pagecache…

--

net: skbuff: limit folio refcount when splicing pages into skbs

This commit changes skb_append_pagefrags() to use try_get_page() instead
of get_page(). In-kernel MSG_SPLICE_PAGES senders that pass pagecache
pages directly, such as sunrpc, can then no longer push a folio's
refcount past the limit. On failure it returns -EFAULT rather than
-EMSGSIZE, so TCP does not just retry with a new skb.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6da51ad8fd440..957335bcc5961 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4714,8 +4714,13 @@ int skb_append_pagefrags(struct sk_buff *skb, struct page *page,
>  	if (skb_can_coalesce(skb, i, page, offset)) {
>  		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], size);
>  	} else if (i < max_frags) {
> +		/*
> +		 * Don't use -EMSGSIZE, as callers would just retry with a new
> +		 * skb.
> +		 */
> +		if (!try_get_page(page))
> +			return -EFAULT;
>  		skb_zcopy_downgrade_managed(skb);
> -		get_page(page);
>  		skb_fill_page_desc_noacc(skb, i, page, offset, size);
>  	} else {
>  		return -EMSGSIZE;

[Severity: High]
Does this cover sockets that have kTLS installed? The commit message uses
sunrpc/nfsd as its example. With kTLS, though, MSG_SPLICE_PAGES never
reaches skb_append_pagefrags().

With software kTLS the call chain is:

tls_sw_sendmsg()
  tls_sw_sendmsg_splice()
    sk_msg_page_add()

sk_msg_page_add() in include/linux/skmsg.h still takes the reference
without a check, and it has no way to return an error:

static inline void sk_msg_page_add(struct sk_msg *msg, struct page *page,
				   u32 len, u32 offset)
{
	struct scatterlist *sge;

	get_page(page);
	...
}

With TLS device offload, the MSG_SPLICE_PAGES branch in tls_push_data()
passes the extracted page to tls_append_frag(). That function also uses
plain get_page(), and the reference is held until the record is ACKed:

net/tls/tls_device.c:tls_append_frag() {
	...
	} else {
		++frag;
		skb_frag_fill_page_desc(frag, pfrag->page, pfrag->offset,
					size);
		++record->num_frags;
		get_page(pfrag->page);
	}
	...
}

nfsd reaches these paths with xprtsec=tls:

- nfsd_read_splice_ok() only turns off splice reads for krb5i and krb5p.
- So nfsd_splice_read() still puts pagecache pages into rq_res.
- svc_tcp_sendmsg() then sends them with MSG_SPLICE_PAGES through
  sock_sendmsg(), which goes to tls_sw_sendmsg() or tls_device_sendmsg().

nvme-tcp over TLS also sends pages with MSG_SPLICE_PAGES and goes through
the same paths.

The sunrpc client does not seem to use MSG_SPLICE_PAGES, since
XS_SENDMSG_FLAGS is MSG_DONTWAIT | MSG_NOSIGNAL. The server side is the
case that matters here.

Should sk_msg_page_add() (or tls_sw_sendmsg_splice()) and the zero-copy
tls_append_frag() path also use try_get_page() and fail with -EFAULT in
the same way? No other patch in the series appears to touch net/tls or
include/linux/skmsg.h.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-skb_refcount_overflow-v2-0-a6f600a5634a%40kernel.org
