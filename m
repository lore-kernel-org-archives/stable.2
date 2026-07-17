Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323038D3ED;
	Fri, 17 Jul 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282208; cv=none; b=FbubjMbdgrT8ze21f/+yxxdZcmzSkQsux/X4ZWFANMU2I5J02dAYGJOa359OozZMU/mNrGLMM8uCJGp50x3NisFziU8XbY1CYN9E8Ne7fTLaCf8EAXthETkXq6JDY6d0OSp9uF4dt0v8meb+2JGKy1NZE1y6iV081bjEeg2WIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282208; c=relaxed/simple;
	bh=Sr89TNn2NgaYiSBqvK4cOSOzgv8vcIhUYYBrZsyUQUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GOpdXzZUYbcqttnHZTtZUBA/nLGN2OZo+BwpmiXb0VjpCepwjp6Jb/Q99BW2FgodDFHpEVStnTCpWoGTMLVry5G/ePgBn5jbCHcdArVyAH8hmQBTjnova5TVQgFM4iYkjj3DEsboSJqrLjy9ByrnSPjDNey5jO0sbW5cpoPDutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Matt Fleming <matt@readmodwrite.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf] veth: convert frag_list skbs before running XDP
In-Reply-To: <20260716100605.939654-1-matt@readmodwrite.com>
References: <20260716100605.939654-1-matt@readmodwrite.com>
Date: Fri, 17 Jul 2026 11:56:41 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jyquj5wm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matt Fleming <matt@readmodwrite.com> writes:

> From: Matt Fleming <mfleming@cloudflare.com>
>
> A frag_list skb can reach veth with data_len set but nr_frags zero.
> veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
> locked, have frags[], or do not have enough headroom. It later uses
> skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
> xdp_frags_size.
>
> That exposes frag_list data to XDP as if it were stored in frags[], but
> frags[] is empty. AF_XDP copy mode can then trust the bogus XDP fragment
> metadata, walk an empty fragment entry, and crash in memcpy() from
> __xsk_rcv().
>
> Route frag_list skbs through skb_pp_cow_data() before exposing them to
> XDP, and only advertise XDP frags when the resulting skb has frags[].
> skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
> builds frags[] output with skb_add_rx_frag(), which is the representation
> XDP multi-buffer expects.
>
> Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>

Seems reasonable, but a few nits below:

> ---
>  drivers/net/veth.c | 4 ++--
>  net/core/skbuff.c  | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 1c5142149175..efb24aae1f26 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  	u32 frame_sz;
>  
>  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> -	    skb_shinfo(skb)->nr_frags ||
> +	    skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb) ||

Isn't 'skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb)' basically
the same as 'skb_is_nonlinear(skb)'? Which, incidentally, is what
generic XDP uses in the check that guards calling into the
skb_pp_cow_data() path.

Looking at those two places, generic XDP checks for 'skb_cloned(skb)',
while veth checks 'skb_shared(skb) || skb_head_is_locked(skb)'. AFAICT,
the latter is stricter; should we update the generic XDP check?

>  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
>  		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
>  			goto drop;
> @@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
>  			 skb_headlen(skb), true);
>  
> -	if (skb_is_nonlinear(skb)) {
> +	if (skb_shinfo(skb)->nr_frags) {
>  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
>  	} else {
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 18dabb4e9cfa..1e837d01a908 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -936,12 +936,11 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
>  	int err, i, head_off;
>  	void *data;
>  
> -	/* XDP does not support fraglist so we need to linearize
> -	 * the skb.
> +	/*
> +	 * skb_copy_bits() handles both frags[] and frag_list input. If the
> +	 * copied skb remains non-linear, it uses frags[], which is the
> +	 * representation used by XDP multi-buffer.
>  	 */

This comment sorta reads like a function documentation comment, but it
ends up sitting weirdly in the middle of the function body. The comment
you're replacing was tied to the statement below, but this one isn't,
really. Should we turn it into an actual function doc comment instead?

-Toke
