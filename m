Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602982;
	b=DnpLJNldjnUjVFPx0kUEHgo/sq/C5NO6MB/quDabUwitws8wSmUzFlAvbnb5TjAWpjPl
	 sP/j7XM9d/T/BYbURk/+fFhfzCUwJ+V1YVuLvsACH+qk/kMcVJrJqtaNyhmOtlUKi84lQ
	 Z8H9B6O8y+ckyErQKrbQ1+1NEl+jpgyK83h2ZcfXPOhveEtjuFYV2JkJrVEHZdUUiF4a0
	 tXXpgRiTSguS50mXaq3I5mKs36DJ20ipCGM7H/0fEM3OIS6GV4bP3kcRrjFseEas8OGll
	 vz6FO0G5GS36275anKiVEmTGWPuXJANnllOj6VtM5IsXJVTPat756wO0RTwqx495koA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=aFyPqufKPTRfFHH6kiVo0N40szheXQ5ACKShZcHFEdc=;
	b=QDSMh0JZ9ubAz/+1/vjg57w8AfjvYY6ddWSEKBABCmhMyPXoOj/H5bxw78LExNwlWDaf
	 Gu0gvNVF7TndXMC3jz9uN7GCRl6Nhfil3cs2Z6qKIUaD/lGNfuvVtQ062lz6i9wb8uEp7
	 1/qEbhpL5aUK05bONfLJtKA34o5vrtwbhQ+YkS8IAghJ6iNuflLQTPg1lqNisi4E0w9N7
	 uuI1DAXJD9Uh5ZJ5rZJV7ukB5pvaFaMYV4PEqs9Nwy2sUSQXSzvtNOmvv85J5TJKDTMpT
	 YM2JJQSufXZBH/30r0KLAjxA2Mp66CcRR1sMYEFFBuhVpm6a34EzBDoWvY8oDKT3Ajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jtJt+6aY;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C183606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 07:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C183606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jtJt+6aY
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so4080900a91.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 23:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793602981; x=1794207781; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFyPqufKPTRfFHH6kiVo0N40szheXQ5ACKShZcHFEdc=;
        b=jtJt+6aYbPByuXxUOxALSzqcBfCqep5WAKQ+Mk8/QBES5us1Qq15iqrp8nkRpEaF7C
         TAb3ErLjuxlY8l+G4NAoyqa/YSHJqTRj3rr1FboPnvyZjTFdo7KiGULsdyLMexpwSjum
         iJHobQFMrschpujBVY/0UJu/EHl0LYZGj814V7Oi75XQZ0wZLyv61jQpEzyxwDwpn7aj
         ElhkbcvFlu067KOGpeYkCDeAnIfuaKEOC/Nil1UvmrXzImaGhCnr5vJK7joltytG6+mN
         d+vUS6Ff9v5Nn2XEQBj3hNRTB19zqfnhW1ftaAdyx3qCvXkdjW5z27Sa7WGQS9waxRbT
         U1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793602981; x=1794207781;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFyPqufKPTRfFHH6kiVo0N40szheXQ5ACKShZcHFEdc=;
        b=G3HneX2AXPhVxwbNY97YXy+gq5yKnVL01wkJmajIymFgrKuuo+Xdgi9qAdPRiEolVN
         Uw2S3HlninWkBn6iravqHcg4DDTLn3DOoflnPcy4JB63mQtgH6lI1huuITaX37K+6lgn
         VWMh8HT7ivJAjaP61k/VOJJvXid5aKmYtu0MNpFu5NYjtuI74Q9dCu6/fmRkZxuZBgXF
         XC4kRcmoWBy2efW7VA5CN90N0hTYjXxCaEtkPdbtVfNh+0tnA1GUZk2gyS8cyiwEk892
         HyhvPy/kzt3MKJkzyxjFbeUUN5wXCK7NCmPxFtx28gJl2b3RHNGrghaN3LUfTQutYF34
         cVqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzG6B1/eC04DmNHEg91WzFX0LOvHLH0OxlAqlipEuc0cZTTQqjcTA3fohq602scBQoa3Hr0afI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2RB/AdGTCVLyHCj4ZgAmfHIpUqOThq0zQ7o7QmDVD+VajLWz0
	XKenKvaksuq7Sw7mvMzkxfj4O2wKGddhhqzN/gcCZgBduhjLXRHyEeM3Xzca4SEwn9HtD2ZZTlO
	fzBM53Q==
X-Received: from pglk11-n1.prod.google.com ([2002:a05:6a02:6b8b:10b0:cca:d82:90fc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180d:b0:3ab:2d46:1dd2
 with SMTP id 98e67ed59e1d1-3ae895a5c46mr7949392a91.6.1793602981199; Sun, 01
 Nov 2026 23:03:01 -0800 (PST)
Date: Mon, 2 Nov 2026 07:03:00 +0000
In-Reply-To: <82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com>
Message-ID: <aug0tMr2QXRxTWuE@google.com>
Subject: Re: [PATCH net] tcp: ipv6: keep request pktopts alive until request destruction
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@kernel.org" <edumazet@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, 02 Nov 2026 06:12:18 +0000, Yingjie Wang wrote:
> When IPv6 flow label reflection is enabled, tcp_v6_send_synack() reads
> ireq->pktopts to copy the flow label from the initial SYN.
> 
> Request sockets can be processed without the listener lock. A
> retransmitted SYN can therefore run tcp_v6_send_synack() while a
> concurrent final ACK creates the child in tcp_v6_syn_recv_sock(). The
> latter clones ireq->pktopts for the child and immediately consumes the
> request's reference. This can free the skb while the retransmit path is
> still reading its IPv6 header, causing a use-after-free.
> 
> Request migration has the same ownership problem. inet_reqsk_clone()
> copies pktopts without taking an skb reference, and reqsk_migrate_reset()
> then clears the old request's pointer. A CPU holding the old request can
> still be sending a SYNACK when the cloned request releases the only skb
> reference.
> 
> Do not consume pktopts while creating the child. Give each cloned request
> its own skb reference and let every request release its reference from
> tcp_v6_reqsk_destructor().
> 
> I found this while testing IPv6 TCP request-socket lifetime handling. The
> reproducer required no source changes, artificial delay, or fault
> injection beyond enabling KASAN. It triggered the use-after-free before
> this change. With this change, a 2000-round run completed without a KASAN
> report. A separate 10-round test recorded four successful request
> migrations and no KASAN report. Networking selftests were not run because
> none directly exercises this race.
> 
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  net/ipv4/inet_connection_sock.c | 6 +++++-
>  net/ipv6/tcp_ipv6.c             | 7 ++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 93b306d91b6d..66f8ce25aa38 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -936,6 +936,11 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>  		      req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end),
>  		      /* alloc is larger than struct, see above */);
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (inet_rsk(nreq)->pktopts)
> +		skb_get(inet_rsk(nreq)->pktopts);
> +#endif
> +
>  	sk_node_init(&nreq_sk->sk_node);
>  	nreq_sk->sk_tx_queue_mapping = req_sk->sk_tx_queue_mapping;
>  #ifdef CONFIG_SOCK_RX_QUEUE_MAPPING
> @@ -982,7 +987,6 @@ static void reqsk_migrate_reset(struct request_sock *req)
>  	req->saved_syn = NULL;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	inet_rsk(req)->ipv6_opt = NULL;
> -	inet_rsk(req)->pktopts = NULL;
>  #else
>  	inet_rsk(req)->ireq_opt = NULL;
>  #endif
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360ea..0b51cb4ad960 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1522,11 +1522,12 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>  	if (*own_req) {
>  		tcp_move_syn(newtp, req);
>  
> -		/* Clone pktoptions received with SYN, if we own the req */
> +		/* Clone pktoptions received with SYN. Keep the request's
> +		 * reference until the request is destroyed, as a concurrent
> +		 * SYN retransmit may still read it.
> +		 */
>  		if (ireq->pktopts) {
>  			newnp->pktoptions = skb_clone_and_charge_r(ireq->pktopts, newsk);
> -			consume_skb(ireq->pktopts);
> -			ireq->pktopts = NULL;

This is reported from another person in security@ mailing list
yesterday and Eric has a better fix.

pw-bot: rejected
