Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096C2D8385;
	Wed, 16 Sep 2026 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519086; cv=none; b=DlKUz3guPXG5sBcpHMo+q+fk7FqCscgp7lyZlrsdEshC7CibCrigkawbvx0sNCzfmSGTtBnbB3j76EQZy2rLVVxbU1Z9NkCG3ccAQNdLIgkJn0DE6lJnj0cpURe8qRDdZO+lhTeyubS9JQV4RCRjZ7kDEAbARSQZmE0//Mz68eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519086; c=relaxed/simple;
	bh=PD4ipA27buJj5TyftjyAo8ovH6jNypJtDwOgLFOva9s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BI3ik9gbDP+qSDNNsEkBAhHJISlzSjr5gkELD8TeembfKX7kcKTeSutJcupFt0Im/WhhonZnmkRLy6CHt3u9CTaoBm/s9J6kltezkwwoH2gpdN0E+GCgghFtC/DBB/8zvujFdCaWK9iJC7esh4OfUbyg6i1M208UNsO3Mf8LFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK3xry2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK3xry2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5131F00893;
	Wed, 16 Sep 2026 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519076;
	bh=l81ZUcvlWvIO06J8B1jF4VqUWbNfS9IC5rXtYgsK3CU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NK3xry2dt16gW+UQDc7PXkLPAZlSRVUf9dwOL6/DvS2hruK2dpAp9wuRzqO1hikaK
	 EqhQiir90ihW1x2HwRVxKFVIW6ATUzKH1BzRo0FevsK3KbxJyh0XCNNYzWIIVgl0/q
	 OGZr9MYdrs4hsosnt0paDwoVDhuEkH3OvJZUag3/AV+ZS3WhJ3B4IWbeSglRnF2N7F
	 35Q1CdDqndU4CEA2GL+1rS7fnMSkLaBVHPbte9zz7sp4UXPT9cDtNkNQA1Pc+lP5J2
	 4/QjRR4DOoMEb0YFOeYK892c0adQlejKQPrsO0Ff8rKC9Txp0WYcmFQnI0n9SqC0Rb
	 JUtsuuyMSVglQ==
Subject:
 Re: [PATCH net 2/2] packet: use ubuf_info completion for TX_RING packets
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com, kleaver@janestreet.com,
 doebel@amazon.de, stable@vger.kernel.org
Date: Wed, 16 Sep 2026 00:37:55 +0000
Message-ID: <178951907555.22033.17789684814809358562@kernel.org>
In-Reply-To: <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
References: <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 1

- [High] tpacket_ubuf_complete() (net/packet/af_packet.c:2576) writes
  into the TX ring slot via…
- [Medium] Commit message overstates the ring-teardown lifetime
  guarantee.
- [Medium] uAPI semantics documented in
  Documentation/networking/packet_mmap.rst are no longer implemented,…
- [Low] Two comment/logic pairs in net/packet/af_packet.c still describe
  the tpacket skb destructor that this patch deletes.

--

packet: use ubuf_info completion for TX_RING packets

tpacket_snd() now attaches a per-packet ubuf_info (struct tpacket_uarg) to
the skb instead of overriding skb->destructor, so a ring slot is released
only once all references to the payload have been freed or copied. The uarg
holds an sk_wmem_alloc reference, and the now unused skb_zcopy_*_nouarg
helpers are removed.

Closes: https://lore.kernel.org/netdev/20260909085542.3370986-1-doebel@amazon.de/

A few questions on the commit message and on the new completion path.

The commit message says:

> The uarg holds an sk_wmem_alloc reference, rather than an sk_refcnt
> reference. packet_free_tx_ring waits on sk_wmem_alloc before freeing
> the ring pages.

[Severity: Medium]
Is that wait unconditional? In the tree at this commit it looks like it
applies only in two narrow cases:

net/packet/af_packet.c:packet_free_tx_ring() {
	deferred = vec->deferred;
	if (!deferred || !sk_wmem_alloc_get(sk)) {
		free_pg_vec(pg_vec, order, len);
		return;
	}
	...
}

and vec->deferred is only allocated for vmalloc-backed blocks:

net/packet/af_packet.c:alloc_pg_vec() {
	...
		if (tx_ring && !vec->deferred &&
		    is_vmalloc_addr(pg_vec[i].buffer)) {
			vec->deferred = kzalloc_obj(*vec->deferred,
						    GFP_KERNEL | __GFP_NOWARN);
	...
}

packet_free_tx_ring() is also reached only on the closing path:

net/packet/af_packet.c:packet_set_ring() {
	...
		if (tx_ring && closing)
			packet_free_tx_ring(sk, pg_vec, order, req->tp_block_nr);
		else
			free_pg_vec(pg_vec, order, req->tp_block_nr);
	...
}

So for the usual __get_free_pages()-backed ring, and for any non-closing
teardown, the new sk_wmem_alloc reference does not appear to hold the ring
pages. Could the message spell out which cases actually wait, since this is
the only lifetime argument offered for a change tagged Cc: stable?

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 76bde7906d494..41fc053075dae 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2528,26 +2528,6 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	goto drop_n_restore;
>  }
>  
> -static void tpacket_destruct_skb(struct sk_buff *skb)
> -{
> -	struct packet_sock *po = pkt_sk(skb->sk);
> -
> -	if (likely(po->tx_ring.pg_vec)) {
> -		void *ph;
> -		__u32 ts;
> -
> -		ph = skb_zcopy_get_nouarg(skb);
> -
> -		ts = __packet_set_timestamp(po, ph, skb);
> -		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
> -
> -		packet_dec_pending(&po->tx_ring);
> -		complete(&po->skb_completion);
> -	}
> -
> -	sock_wfree(skb);
> -}
> -

[Severity: Low]
With tpacket_destruct_skb() gone, two comments that describe it are left
behind. In tpacket_snd() the xmit error path still reads:

net/packet/af_packet.c:tpacket_snd() {
	...
			if (err && __packet_get_status(po, ph) ==
				   TP_STATUS_AVAILABLE) {
				/* skb was destructed already */
				skb = NULL;
				goto out_status;
			}
			/*
			 * skb was dropped but not destructed yet;
			 * let's treat it like congestion or err < 0
			 */
	...
}

Do those inferences still hold? The slot can now be AVAILABLE while the skb
is alive (payload copied by skb_copy_ubufs()), and the skb can be gone while
the slot is still TP_STATUS_SENDING when a clone or segment still holds a
uarg reference, since tpacket_ubuf_complete() returns early on
!refcount_dec_and_test().

packet_free_tx_ring() also still says:

	/* A detached ring's pending count can miss late skb destructors. */

Should that now name tpacket_ubuf_complete() instead, given that is what
holds the extra sk_wmem_alloc reference the deferral waits on?

>  static int __packet_snd_vnet_parse(struct virtio_net_hdr *vnet_hdr, size_t len)
>  {
>  	if ((vnet_hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> @@ -2587,27 +2567,57 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
>  	return 0;
>  }
>  
> +struct tpacket_uarg {
> +	struct ubuf_info	ubuf;
> +	struct packet_sock	*po;
> +	void			*ph;
> +};
> +
> +static void tpacket_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
> +				  bool success)
> +{
> +	struct tpacket_uarg *tu = container_of(uarg, struct tpacket_uarg, ubuf);
> +	struct packet_sock *po = tu->po;
> +	void *ph = tu->ph;
> +	__u32 ts = 0;
> +
> +	if (!refcount_dec_and_test(&uarg->refcnt))
> +		return;
> +
> +	if (likely(READ_ONCE(po->tx_ring.pg_vec))) {
> +		if (likely(skb))
> +			ts = __packet_set_timestamp(po, ph, skb);
> +		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
> +
> +		packet_dec_pending(&po->tx_ring);
> +		complete(&po->skb_completion);
> +	}

[Severity: High]
Can these writes through tu->ph land in pages that have already been freed?

The only guard here is the unsynchronized READ_ONCE(po->tx_ring.pg_vec)
test, and that load is not ordered against the swap(rb->pg_vec, pg_vec) plus
free in packet_set_ring()/packet_free_tx_ring(). For a page-backed ring the
close path takes the !deferred branch shown earlier and frees the blocks
immediately, even though sk_wmem_alloc_get(sk) is non-zero because of the
outstanding uarg reference.

The frag page references taken in tpacket_fill_skb() used to cover the
page-backed case, but they are dropped before the completion runs:

net/core/skbuff.c:skb_copy_ubufs() {
	...
	/* skb frags release userspace buffers */
	for (i = 0; i < num_frags; i++)
		skb_frag_unref(skb, i);
	...
release:
	skb_zcopy_clear(skb, false);
}

So a sequence like:

CPU0 (xmit/copy)			CPU1 (close)
tpacket_ubuf_complete()
  READ_ONCE(po->tx_ring.pg_vec)  /* non-NULL */
					packet_set_ring(closing=1)
					  packet_free_tx_ring()
					    free_pg_vec()  /* !deferred */
  __packet_set_status(po, ph, ...)  /* freed pages */

Frames whose payload is fully consumed by copylen (to_write == 0, e.g. a
vnet_hdr whose hdr_len covers the whole frame) never had a frag reference at
all. An analogous window existed for the deleted tpacket_destruct_skb() once
skb_copy_ubufs() had dropped the frag references, but this patch makes
copy-time completion the normal release path and re-bases the lifetime
argument on sk_wmem_alloc, so should packet_free_tx_ring() honour
sk_wmem_alloc unconditionally, or the ph access be made properly
synchronized?

Separately, on the pg_vec == NULL branch packet_dec_pending() is skipped.
Does a late completion after ring teardown leave the per-CPU pending count
permanently elevated?

> +
> +	kfree(tu);
> +	sk_free(&po->sk);
> +}
> +
> +static const struct ubuf_info_ops tpacket_ubuf_ops = {
> +	.complete = tpacket_ubuf_complete,
> +};
> +

[ ... ]

> @@ -2906,7 +2917,24 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  			virtio_net_hdr_set_proto(skb, &vnet_hdr);
>  		}
>  
> -		skb->destructor = tpacket_destruct_skb;
> +		uarg = kmalloc(sizeof(*uarg), GFP_KERNEL);
> +		if (unlikely(!uarg)) {
> +			if (likely(len_sum > 0))
> +				err = len_sum;
> +			else
> +				err = -ENOMEM;
> +			goto out_status;
> +		}
> +		uarg->po = po;
> +		uarg->ph = ph;
> +		uarg->ubuf.ops = &tpacket_ubuf_ops;
> +		uarg->ubuf.flags = SKBFL_ZEROCOPY_FRAG;

[Severity: Medium]
Since only SKBFL_ZEROCOPY_FRAG is set here (no SKBFL_DONT_ORPHAN), even a
plain skb_clone() takes the skb_orphan_frags() -> skb_copy_ubufs() ->
skb_zcopy_clear() path and completes the uarg, as do
skb_orphan_frags_rx() from dev_queue_xmit_nit() when any tap is attached,
tun_net_xmit(), and __skb_tstamp_tx().

At that point neither skb_hwtstamps(skb)->hwtstamp nor skb_tstamp(skb) has
been filled in, so tpacket_get_timestamp() returns 0 and the slot is
published as bare TP_STATUS_AVAILABLE.

Documentation/networking/packet_mmap.rst still documents the old contract:

	The kernel updates each status of sent
	frames with TP_STATUS_SENDING until the end of transfer.

	At the end of each transfer, buffer status returns to TP_STATUS_AVAILABLE.

and the PACKET_TIMESTAMP section tells applications to "wait for status of
relevant frames to be updated resp. the frame handed over to the
application", then "walk through the frames to pick up the individual hw/sw
timestamps", noting that with only TP_STATUS_AVAILABLE set "the tp_sec and
tp_{n,u}sec members do not contain a valid value".

Should packet_mmap.rst be updated in this patch to describe the new release
and timestamp point?

> +		refcount_set(&uarg->ubuf.refcnt, 1);
> +
> +		/* Hold a sk_wmem_alloc reference until completion */
> +		refcount_inc(&po->sk.sk_wmem_alloc);
> +		skb_zcopy_init(skb, &uarg->ubuf);
> +
>  		__packet_set_status(po, ph, TP_STATUS_SENDING);
>  		packet_inc_pending(&po->tx_ring);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914214229.1674102-1-willemdebruijn.kernel%40gmail.com
