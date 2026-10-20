Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518116;
	b=im+4c37EO9Ki9pViip0OdsPGrAWLf5fxgiMM4X+GQcItwV8VQGW6IWqhgWHi1Fdh7bt3
	 2XAbXowfXP8sqlBQjDSRsJTU9qn0XkH0l0eLpjUiL9zGJ/uQULnJc9VJyOcj0uT5HbpFI
	 Gv4vVbUo7WU12wQT9PlDKydFnYnvctXuqNxbqG8THm3FrpxnN2D808nlU+fH2d2P1HOJQ
	 7wm5s7wDqq2RaYf8Lot+fYFIpkoPhql13w1Vpk4GS/guJYvv3GGJyTKQjqOdythxNI+9o
	 8d3+x1WDlpvVzl04mBhXzU3ByNbEsLfF0GE3gKWxtCjNtvgAWJaYh2IMsAecKUlVglg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518116;
	h=Received:Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 X-sashiko-severity:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=7kHsNvX7qhi13hNAheORWGGXQJ977zoh3p67QbCteZs=;
	b=ZOmk327MLX5tG1SSTl9k9eFIct5y+VxQM9sxqB4e/EJPQxv0hFLA54WLXEmICeQrFWVK
	 WBhXAMQ0DlEbV1suoNZeG3WVGGanOuUySa0NEk+VZc+qzLROmodGJNSRBN+Rd3Kb6c4m0
	 E5oMDMSPdRY2VrHt/F8RcUug2tucJ84643Vd9K6ye5MyLbop6MZzvNux/ercCX80gB7zl
	 nvbgfdvvI25mV6mwOitPgxdeSdsd0V0di9sIBHnQsAwGYhmNUZQ5znww4fX3M7SHC+ThE
	 f1bRfPqwAObgGT4X92aqIbF4pP5jZVzzxapqNcVgw0WfcrVD+RPg4dvusI5z23+7BUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14755606A31C;
	Tue, 20 Oct 2026 17:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C951F000C9;
	Tue, 20 Oct 2026 17:41:54 +0000 (UTC)
Subject:
 Re: [PATCH net] net: gso: complete partial checksums of fraglist segments
From: netdev-bot+sashiko@kernel.org
To: pylaterreur@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com,
 steffen.klassert@secunet.com, willemb@google.com, nbd@nbd.name,
 dsahern@kernel.org, alice.kernel@fastmail.im, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 20 Oct 2026 17:41:24 +0000
Message-ID: <179251808436.3135.4663009008988261682@kernel.org>
In-Reply-To: <20261016-fraglist-csum-v1-1-93945be7bb5d@gmail.com>
References: <20261016-fraglist-csum-v1-1-93945be7bb5d@gmail.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] skb_segment_list_csum_help() runs software checksum
  completion on the head segment while that skb is shared.
- [Medium] skb_segment_list_csum_help() completes each segment's checksum
  using the csum_start/csum_offset that skb_segment_list() copied from…
- [Medium] On a segmentation failure, udp_rcv_segment() counts drops with
  `drop_count = skb_shinfo(skb)->gso_segs`, then calls sk_drops_add()…
- [Low] The kerneldoc of skb_segment_list_csum_help() ('Segments that are
  GSO packets themselves (TCP fraglist GRO can chain those) are left…

--

net: gso: complete partial checksums of fraglist segments

This patch adds skb_segment_list_csum_help(). When the output features
can't offload the checksum, it completes the CHECKSUM_PARTIAL checksums of
the segments built by skb_segment_list(). The UDP and TCP (v4/v6) fraglist
GSO paths call it after the protocol code has fixed up the segment
headers.

Closes: https://github.com/Ysurac/openmptcprouter/issues/4402

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421a..be3fa938e1da2 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4782,6 +4782,46 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL_GPL(skb_segment_list);
>  
> +/**
> + * skb_segment_list_csum_help - finish the checksums of fraglist segments

[ ... ]

> + * Segments that are GSO packets themselves (TCP fraglist GRO can chain
> + * those) are left alone, as skb_checksum_help() can't handle them.

[Severity: Low]
Is this still true on the base tree? Commit 66817a979426 ("net: gro: Fix
nesting of TCP GSO SKBs in skb_gro_receive_list()") changed
tcp4_check_fraglist_gro() and tcp6_check_fraglist_gro() so that only
non-GSO skbs start an flist flow:

	NAPI_GRO_CB(skb)->is_flist = !sk && !skb_is_gso(skb);

When a GSO skb meets an flist head, it falls back to regular GRO, and
tcp_gro_receive() flushes when the is_flist values differ. skb_segment_list()
also calls skb_gso_reset() on the head. Put together, skb_segment_list()
doesn't appear to produce GSO segments, so the skb_is_gso() skip below
would be dead code on mainline.

The changelog gives the same reason:

  Segments that are GSO packets themselves, which TCP fraglist GRO can
  chain, are left as they were: skb_checksum_help() refuses GSO packets.

The test in the notes with a TSO veth sender can't exercise this skip
either, because TSO packets never become flist on this tree.

Could the comment and changelog describe the skip as defensive, or mention
66817a979426? This patch is tagged for stable. On stable trees that don't
have that commit, the skipped GSO members would still go out with only the
pseudo-header sum.

> + *
> + * Return: @segs, or an error pointer after freeing the segments.
> + */
> +struct sk_buff *skb_segment_list_csum_help(struct sk_buff *segs,
> +					   netdev_features_t features)
> +{
> +	struct sk_buff *seg;
> +	int err;
> +
> +	if (segs->ip_summed != CHECKSUM_PARTIAL)
> +		return segs;
> +
> +	for (seg = segs; seg; seg = seg->next) {
> +		if (skb_is_gso(seg))
> +			continue;
> +
> +		err = skb_csum_hwoffload_help(seg, features);

[Severity: Critical]
Can this hit BUG_ON(skb_shared(skb)) in pskb_expand_head() for the head
segment?

skb_segment_list() returns the head with an extra reference:

	skb_get(skb);

	return skb;

So the first entry of segs has users == 2 when this loop runs.
skb_gso_reset() has already cleared its gso_size, so the skb_is_gso() skip
doesn't apply to it.

If features have no checksum offload that fits the packet,
skb_csum_hwoffload_help() falls through to skb_checksum_help(), which
does:

	if (skb_has_shared_frag(skb)) {
		ret = __skb_linearize(skb);

skb_segment_list() only linearizes the head when NETIF_F_SG is missing, so
with SG set the head can still have page frags. skb_gro_receive_list()
copies SKBFL_SHARED_FRAG from every aggregated member onto the head, and
MSG_SPLICE_PAGES senders (sendfile/splice over TCP or UDP) set that flag.

The resulting chain would be:

validate_xmit_skb()
  __skb_gso_segment()
    __udp_gso_segment_list() / __tcp{4,6}_gso_segment_list()
      skb_segment_list()             /* skb_get(), users == 2 */
      skb_segment_list_csum_help()
        skb_csum_hwoffload_help()
          skb_checksum_help()
            __skb_linearize()
              __pskb_pull_tail()
                pskb_expand_head()   /* BUG_ON(skb_shared(skb)) */

Two cases look like they reach this. The first is forwarding to a tun
device without TUN_F_CSUM, since tun keeps NETIF_F_SG | NETIF_F_FRAGLIST.
The second is udp_rcv_segment() for a socket using IP_CHECKSUM, where
features == NETIF_F_SG.

skb_segment() doesn't have this problem because its segments are freshly
allocated with a refcount of 1. Would it work to complete or linearize the
head before skb_get() in skb_segment_list(), or to handle the head
separately?

[Severity: Medium]
Do csum_start and csum_offset on each segment always point at that
segment's L4 check field here?

skb_segment_list() copies them from the head with __copy_skb_header().
skb_headers_offset_update() then only shifts them by the headroom
difference.

The fraglist GRO path never normalizes them:
__virtio_net_hdr_to_skb() accepts any csum_start/csum_offset that fits in
that packet's own linear data. The is_flist branches of
udp4_gro_complete() and tcp4_gro_complete() also don't reset them the way
udp_gro_complete_segment() and tcp_gro_complete() do.

tcp_gso_segment() rejects such packets with:

	if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))

__udp_gso_segment() has the same check, but exempts SKB_GSO_FRAGLIST.

Suppose the head has a large csum_offset and is followed by a shorter
member. Could skb_checksum_help() then hit:

	if (unlikely(offset + sizeof(__sum16) > skb_headlen(skb))) {
		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
		WARN_ONCE(true, "offset+2 (%zu) > skb_headlen() (%u)\n",

and drop the whole aggregate with -EINVAL? For members where the offset
does fit, the folded checksum would be written into payload bytes instead
of the TCP or UDP check field.

Crafted vnet headers written to a tap opened with IFF_NAPI | IFF_VNET_HDR
with rx-gro-list on seem enough to trigger this. That is the reproducer
setup from the notes.

Should each segment's checksum start be checked against its transport
header, or reset to it, before skb_csum_hwoffload_help() is called?

> +		if (err) {
> +			kfree_skb_list(segs->next);
> +			segs->next = NULL;
> +			/* drop the extra reference skb_segment_list() took */
> +			kfree_skb(segs);
> +			return ERR_PTR(err);

[Severity: Medium]
Does this error path leave the UDP drop counters at zero?

After a failure, udp_rcv_segment() counts drops using the head:

	segs = __skb_gso_segment(skb, features, false);
	if (IS_ERR_OR_NULL(segs)) {
		drop_count = skb_shinfo(skb)->gso_segs;
		goto drop;

skb_segment_list() has already called skb_gso_reset() on that head before
skb_segment_list_csum_help() runs, so gso_segs is 0 at this point. All the
aggregated datagrams are freed here, but sk_drops and UDP_MIB_INERRORS go
up by 0.

This can happen on receive for a socket using IP_CHECKSUM, or when IPv6
extension headers force the software checksum. skb_checksum_help() can
fail there with -ENOMEM, or with -EINVAL from the csum offset problem
above.

The existing late __skb_linearize() failure in skb_segment_list() has the
same accounting gap. This patch adds a new trigger that is easier to reach.

> +		}
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-fraglist-csum-v1-1-93945be7bb5d%40gmail.com
