Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624417;
	b=rmWbqifm6PanpDOvT3oBcujBCJ4K4nKns0jih8vGGmQ4oS+jMRtgFq6oEp7z796Qrt9u
	 0waumu6R0QdIM+j/V47Rz08tLAueFAb/7wwEWnmMBDUxfZ8e0cVGRXk5GBzwdxubcwyaV
	 A0uQ2K7quq9Vxs2mO/k4GiFE8Degyh3CpxCoP8odYxuLu6VVLziPH3U0R5Z40N2pBtF4R
	 eG2+ilTEFY4w/ceMWGH0Zi2avP21ikgkn3jDelmpXjDxc0SV7+07qOSx0QP4Ek6A40tov
	 99Orb2KuWCO2zqg5iSaTo1Dgm6BTx6JVOB6fOpa1QHN7XB+JSOpuAb19ryxwkT5UAMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624417;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/P1RSqnLX+hUxtcb1KyjT/xNFMizKENJrUqr+CPPikU=;
	b=KDrLQGPUJQc3H0ULx9rn+1YOYhLqR1cK+WcJGBQLuc7DChyQnn4gkqY9h/Wg6Y6HJSJi
	 yElOGVhtcPoX7EmUMzF5xuplet5K9Q51Mi/2ienEr93trV8AZ/ZoXoCbhLIcVFXIYPaiw
	 LwH4HOY3kUOubQR+iYrwTpkIZ4ktJaniZguQG82V6UWpWM+O5i5x53pkogLUt9dDrwxNb
	 K4/F4PiDt0NSHd+9WJ0seuzQZAzFgMoNyiJCbWBnNSH0JdvKxilOk1X8yOXNgQ6PTtgwN
	 fwftW8tIQL/wtGjDhOuVLKhw4W1jRTdtKeJY7I2jEWJEvLllmLY1scai1/+wDlScKZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJX67fXI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76231606A32D;
	Mon,  2 Nov 2026 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJX67fXI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894901F00A17;
	Mon,  2 Nov 2026 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793624417;
	bh=/P1RSqnLX+hUxtcb1KyjT/xNFMizKENJrUqr+CPPikU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RJX67fXID/owlK0qA56Fw0euUY9+k76bvhdibm2v9xu2szC2t/tCJUpA/7hHFqblP
	 wf1fICMMIWDqVV2qHwdclcQ3QRWXqP6P70QNaHX4yZXQRONzNQt+WEU7ihyNms0JlQ
	 1gNIqUfdtBQMsmgv1Q/hRPTeDPxnwt6cCFTVC9Ar95iVZhvyeVwUyHElTbeHFVBygx
	 yuhfMJy4Te8k3nHPS7vi991/BK5itdL4xlY6JRjo6oWBB+rkOekFCpk/plA0wM6k2P
	 1dxy7jhZYmIiDgKkA+vVBCU57wZ2YlE44Okd4aCh49anjghpbNNusDRj9cCfA6wwLQ
	 tzJMbbUWzrKOw==
Subject: Re: [PATCH net v2 2/2] net: gro: invalidate frag0 after a pull
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, willemb@google.com, steffen.klassert@secunet.com,
 tom@herbertland.com, cenzhang@linux.microsoft.com,
 AutonomousCodeSecurity@microsoft.com, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 13:00:16 +0000
Message-ID: <179362441613.3131.6007536857643093308@kernel.org>
In-Reply-To: <20261030125955.3107383-3-edumazet@kernel.org>
References: <20261030125955.3107383-3-edumazet@kernel.org>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: gro: packet corruption in gro_pull_from_frag0() after
  failed pull

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  `napi_gro_frags()` (net/core/gro.c:783-794) never checks the result of…

--

net: gro: invalidate frag0 after a pull

This patch adds skb_gro_frag0_invalidate(), which clears
NAPI_GRO_CB(skb)->frag0_len. It is called before the slow pulls in
skb_gro_header_slow(), skb_gro_receive_list(), esp4_gro_receive(),
esp6_gro_receive() and udp_gro_receive_segment(). This keeps later GRO
header accesses from using a frag0 pointer that the pull may have
released or reallocated.

> diff --git a/include/net/gro.h b/include/net/gro.h
> index 00b49b6b9e74f..6f6affc8ab91c 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -160,9 +160,19 @@ static inline bool skb_gro_may_pull(const struct sk_buff *skb,
>  	return likely(hlen <= NAPI_GRO_CB(skb)->frag0_len);
>  }
>  
> +/* A pull can release the page fragment frag0 points to, or reallocate
> + * skb->head, even if it fails. Call this before the pull, to make sure later
> + * skb_gro_header() and skb_gro_network_header() calls no longer use frag0.
> + */
> +static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
> +{
> +	NAPI_GRO_CB(skb)->frag0_len = 0;
> +}
> +
>  static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned int hlen,
>  					unsigned int offset)
>  {
> +	skb_gro_frag0_invalidate(skb);
>  	if (!pskb_may_pull(skb, hlen))
>  		return NULL;

[Severity: High]
Does clearing frag0_len here, while frag0 itself is left pointing at
the old location, break gro_pull_from_frag0() when the slow pull in
skb_gro_header_slow() fails?

Consider an skb that enters GRO with skb_headlen(skb) == 0. In that
case skb_gro_reset_offset() points frag0 at the start of frags[0],
which is packet offset 0.

Now add remote checksum offload nopartial: vxlan_gro_receive() or
vxlan_gpe_gro_receive() with VXLAN_F_REMCSUM_NOPARTIAL, or
gue_gro_receive() with FOU_F_REMCSUM_NOPARTIAL. There,
skb_gro_remcsum_process() records grc->offset and grc->delta through
the frag0 fast path. The inner eth_gro_receive() and
inet_gro_receive()/ipv6_gro_receive() handlers then advance
skb_gro_offset() through frag0 too, so skb_headlen() is still 0.

Suppose the next inner header does not fit in frag0_len, for instance
in tcp_gro_pull_header() or udp_gro_udphdr(). skb_gro_header_slow()
now sets frag0_len to 0 and calls pskb_may_pull(). On a truncated
packet where hlen > skb->len, this fails without pulling anything.
That leaves skb_headlen() at 0 and frag0_len at 0.

On the way out, skb_gro_flush_final_remcsum() calls
skb_gro_remcsum_cleanup(), which does:

	ptr = skb_gro_header(skb, plen, grc->offset);

Before this patch that was served from frag0. Now skb_gro_may_pull()
fails, and pskb_may_pull(skb, plen) really copies plen bytes into the
linear area. Here plen = grc->offset + sizeof(u16), which is below
skb_gro_offset(skb) once the inner headers were pulled. frags[0] is
advanced by plen, but NAPI_GRO_CB(skb)->frag0 still points at packet
offset 0.

Since the skb is flushed, dev_gro_receive() ends up in
gro_try_pull_from_frag0(). That computes
grow = skb_gro_offset(skb) - skb_headlen(skb) > 0 and calls
gro_pull_from_frag0():

	memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);

This copies packet bytes 0..grow to skb->data + plen, then advances
frags[0] by grow again. The skb handed up the stack as GRO_NORMAL
has its inner headers overwritten with outer header bytes, and the
real bytes at plen..skb_gro_offset() are lost. A remote sender can
trigger this with a short encapsulated packet.

gro_pull_from_frag0() assumes frag0 is the current start of frags[0],
which only holds while skb_headlen() is 0. Should it copy from
skb_frag_address(&pinfo->frags[0]) instead? Or should
skb_gro_remcsum_cleanup() and gro_try_pull_from_frag0() handle a
partially linearized skb in some other way?

[Severity: High]
This patch didn't introduce this, but since the failure path of
skb_gro_header_slow() is being changed here: what happens in
napi_gro_frags() when this pull fails for the Ethernet header?

In net/core/gro.c, napi_frags_skb() takes the slow path and returns
NULL when the pull fails:

net/core/gro.c:napi_frags_skb() {
    ...
	if (unlikely(!skb_gro_may_pull(skb, hlen))) {
		eth = skb_gro_header_slow(skb, hlen, 0);
		if (unlikely(!eth)) {
			net_warn_ratelimited("%s: dropping impossible skb from %s\n",
					     __func__, napi->dev->name);
			napi_reuse_skb(napi, skb);
			return NULL;
    ...
}

The caller doesn't check for NULL, though:

net/core/gro.c:napi_gro_frags() {
	struct sk_buff *skb = napi_frags_skb(napi);

	trace_napi_gro_frags_entry(skb);

	ret = napi_frags_finish(napi, skb, dev_gro_receive(&napi->gro, skb));
    ...
}

dev_gro_receive() starts with skb_get_hash_raw(skb) and then reads
skb->protocol. Can this be a NULL pointer dereference in NAPI softirq
context? One way to reach it would be skb->len < ETH_HLEN, where
pskb_may_pull() fails with PKT_TOO_SMALL. Another would be
__pskb_pull_tail() returning NULL.

napi_gro_frags() used to have an "if (!skb) return GRO_DROP;" check.
Commit 1d11fa696733 ("net-gro: remove GRO_DROP") removed it on the
grounds that NULL could only come from a failed napi_get_frags()
allocation. That reasoning doesn't cover the header pull failure return
shown above.

The drivers checked so far (tun, r8152, e1000) all enforce a minimum
frame length before calling napi_gro_frags(). The other callers have
not been checked.

Should napi_gro_frags() check for a NULL skb again?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030125955.3107383-1-edumazet%40kernel.org
