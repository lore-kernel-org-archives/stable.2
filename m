Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544328;
	b=sgnyHga4rRvWH7OpodD+RmKB6Gb83mKtKkxJCWREuugO9JNX0VsLVaunTcHLo528xdda
	 i+UpN5tIKJEtsmWKlrKvdytGtwANyBgmw6r/hXgbKt4AQVpYwXu21vKv0YtML1bjRvdaK
	 aTjmRLB35PzQVm5592SURMZ2p3G4xxUksIYP4Ps4/by01v+Y7utbFHPbUAb1IZ5Mom+IS
	 fgL74tgEd4ODU6VYLV9P19cwZPgeLb0AvW9aD1kPQ7UvpepnJTGMIpN+YS/dEr3sjkjFr
	 rDMTwsAuyOnZosKaovyxGXOwL9/FpwxarAjzzAgqjaGYy6vm4q5EzX4UiIhER/KjfWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544328;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=44s04JgPecTtm6NhDjYX2WlJHWZ2E+d8hRSUAWRiAAQ=;
	b=LYfR6lTqy+tOi9LiBYXBqS6mbx1Gzk35O639LEZo8LrUVvMRRJdX2tuoY6wcKqzHzybx
	 WBnmZ2N96G089u1fRu5ViZMq/kmmYGE4x6LBbcaYq+SJSes42RAYzDISP02B+KsiQYrts
	 WZfVAA+EfWWIosA5KgM5D4euhgiWLTxXft2d3GcqDA5X62qy5qdYe2vP9i+jYXR6J1x+6
	 rlmgeG2Lfpw/hDq0RFAEDyHyzCqK3sdoPbicJ4mMlsdDCY1kqBaZDln1aBBIhOQtJkH1+
	 Yr/0O42r9VijqVTWzRLBP72WpyStQ/8WzFU2caDuzklqzaCtds6GF8gHn3g6hEmSgZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBWLt1AF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF6606A325;
	Sun,  1 Nov 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBWLt1AF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E851B1F000C1;
	Sun,  1 Nov 2026 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793544327;
	bh=44s04JgPecTtm6NhDjYX2WlJHWZ2E+d8hRSUAWRiAAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MBWLt1AFnyDdYSwLLQ/T3kR47lm5EWNitJQwhPQ7IygtOyWnbbCrCNnyqc606rFj0
	 8Y9Pi7zipDkNKoopHJtxJtFo85ePgz3XOzX3f2U3qWFOPtFhRKJgA4lJnsOx/PzLIW
	 eG2opP5MH9zd0UWSYxW1I8/mZa030UoKrVvYVUj+jmzV4VrjNlhEdK/hhYyuZyorL8
	 X4Jpuhd01xfcaj1RgBxWgmKBD16GZRlxLYIszJ7lHN4ybPy/AAJFWg+WilMZ7g0wcL
	 VQfwcQ4ufT2EHtx9jZkK4DPc8c+qjf2bJ6ujjzSpQmqV7tUcHE8m6tYjSkIiw//Ccj
	 j7oRyLHYSYFWw==
Subject: Re: [PATCH ipsec] xfrm: use software GSO for inner tunnels without
 crypto offload
From: netdev-bot+sashiko@kernel.org
To: usmanmalik@engineer.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cratiu@nvidia.com, leon@kernel.org, stable@vger.kernel.org
Date: Sun, 01 Nov 2026 14:45:26 +0000
Message-ID: <179354432643.3131.245171497251536441@kernel.org>
In-Reply-To: <20261028-xfrm-inner-gso-v1-1-1908f0eb7313@engineer.com>
References: <20261028-xfrm-inner-gso-v1-1-1908f0eb7313@engineer.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch sends more traffic into xfrm_output_gso(), and on
  that path AES-GCM IVs can repeat.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but transport-
  mode SAs that have a crypto offload device (x->xso.dev != NULL) still…
- [Low] This problem wasn't introduced by this patch, but xfrm_output()
  reads x->xso.dev with plain, unmarked loads: in xfrm_dev_offload_ok()…

--

xfrm: use software GSO for inner tunnels without crypto offload

This commit changes xfrm_output() to use xfrm_output_gso() for GSO
packets with skb->inner_protocol set. Before, that only happened in
tunnel mode. Now it also happens when the SA has no offload device. The
goal is to stop the SKB_GSO_ESP path from producing malformed ESP packets
for ipip/ip6tnl traffic over transport-mode software SAs when
esp4_offload/esp6_offload are loaded.

> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index e305ba32e356b..c370d28a83f50 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -808,7 +808,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  		skb->encapsulation = 1;
>  
>  		if (skb_is_gso(skb)) {
> -			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
> +			if (skb->inner_protocol &&
> +			    (x->props.mode == XFRM_MODE_TUNNEL || !x->xso.dev))
>  				return xfrm_output_gso(net, sk, skb);

[Severity: Critical]
Can this cause AES-GCM IV reuse for the transport-mode software SA
traffic that this change sends to xfrm_output_gso()?

Before this point, xfrm_output() has attached a sec_path with
sp->olen = 1, so the skb carries an xfrm_offload. xfrm_output_gso() then
calls skb_gso_segment(). In skb_segment()->__copy_skb_header(),
__skb_ext_copy() only takes a reference on the extension:

include/linux/skbuff.h:__skb_ext_copy() {
	...
		refcount_inc(&ext->refcnt);
		dst->extensions = ext;
	...
}

So all segments seem to share one struct xfrm_offload.

For each segment, xfrm_output2()->...->xfrm_replay_overflow_offload()
writes to that shared xo:

net/xfrm/xfrm_replay.c:xfrm_replay_overflow_offload() {
	...
		if (!skb_is_gso(skb)) {
			XFRM_SKB_CB(skb)->seq.output.low = ++oseq;
			xo->seq.low = oseq;
	...
}

The XFRM_SKB_CB() copy belongs to each skb, but xo->seq.low is in the
shared extension.

Encryption happens later, at qdisc dequeue time, in
validate_xmit_skb()->validate_xmit_xfrm()->esp_xmit(). That code reads
the shared value:

net/ipv4/esp4_offload.c:esp_xmit() {
	...
	seq = xo->seq.low;
	...
	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
	...
}

XFRM_GSO_SEGMENT is not set on this path, so nothing advances
xo->seq.low per segment. esp_output_tail() then copies esp->seqno into
the AEAD IV. esp6_xmit() does the same.

Segments can wait in the qdisc while the xfrm_output_gso() loop keeps
running. For example, dequeue_skb() returns nothing while a
TCQ_F_ONETXQUEUE txq is stopped by BQL or a full ring, or another CPU
may already be running the qdisc. In that case, won't later segments
overwrite xo->seq.low before the earlier ones are encrypted?

Each packet would still have a distinct esph->seq_no on the wire, but
the explicit IVs would be the same. That is GCM nonce reuse under one
key. The receiver takes the IV from the packet, so decryption still
succeeds and nothing reports the problem.

veth is noqueue, so in the test setup validate_xmit_skb() runs before
the next segment's xfrm_output_one(). That would hide this.

Tunnel-mode software SAs already use this mechanism today. In the base
tree, however, these transport-mode packets, including the vxlan and
geneve traffic that worked, went down the SKB_GSO_ESP path. There,
xo->seq.low advances per segment within one validate_xmit_xfrm() call,
on an extension owned by a single GSO skb.

Could the sec_path be unshared per segment, or the IV be taken from the
per-skb XFRM_SKB_CB() sequence? Another option would be to fix
xfrm{4,6}_transport_gso_segment() instead of rerouting these packets.

[Severity: Low]
This is a pre-existing issue, but x->xso.dev is read here with a plain
load, and xfrm_dev_state_free() can clear it at the same time:

net/xfrm/xfrm_state.c:xfrm_dev_state_free() {
	...
		WRITE_ONCE(xso->dev, NULL);
		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
		netdev_put(dev, &xso->dev_tracker);
	...
}

The new !x->xso.dev test is only used as a boolean, and either value
leads to a valid path. At worst it is a data race that KCSAN can see,
like the one already in xfrm_dev_offload_ok():

	struct net_device *dev = x->xso.dev;

Further down in xfrm_output(), the check-then-dereference also uses two
plain loads. This patch does not touch it:

	if (x->xso.dev && x->xso.dev->features & NETIF_F_HW_ESP_TX_CSUM)

Would it make sense to read x->xso.dev once with READ_ONCE() into a
local variable and use that for these checks?

>  
>  			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;

[Severity: Medium]
This isn't a bug introduced by this patch, but transport-mode SAs with
a crypto offload device (x->xso.dev != NULL) still set SKB_GSO_ESP here
for packets with skb->inner_protocol set.

The commit message says:

  "An SA with crypto offload that falls back to software
  segmentation in validate_xmit_xfrm() takes the same path."

Is the reroute/overflow fallback in validate_xmit_xfrm() the only way to
get there? validate_xmit_skb() also does this:

net/core/dev.c:validate_xmit_skb() {
	...
	if (netif_needs_gso(skb, features)) {
		struct sk_buff *segs;

		segs = skb_gso_segment(skb, features);
	...
}

That runs whenever the device's hw_enc_features don't cover the whole
gso_type, for example SKB_GSO_ESP | SKB_GSO_IPXIP4. The call chain would
then be:

skb_gso_segment()
  esp4_gso_segment()
    xfrm4_transport_gso_segment()
      inet_gso_segment()   /* inner IPIP, transport header at inner L4 */

followed by validate_xmit_xfrm()->__xfrm_transport_prep()->esp_xmit().
That writes the ESP header 4 bytes into the inner IP header, which is
the same malformed layout the commit message describes.
xfrm6_transport_gso_segment() has the same limitation.

Could the commit message mention this fallback as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-xfrm-inner-gso-v1-1-1908f0eb7313%40engineer.com
