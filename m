Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FE35C6A0;
	Thu, 10 Sep 2026 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022306; cv=none; b=KnqUHc2wrCyvXr3yoZ5qMhKBMaiqXlh1mkL/WqAiI0MRwt2nB1p+Nviw7VbZBdNDdqTlXty1N7kVIwOZRQimRI7ND712ExYatxCapjB/1UrkZPi3z985FbbycX+l3aNIXSWFn4AebRI2aSV5unRhaPch/v6Z45e39aCk5T5nCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022306; c=relaxed/simple;
	bh=qqtMomsN4Sd/tBQ/4EjEGxD3TtWrBLk+mWCKvG/MC1o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcd04YB/do239VeH1AgTff+F5sJ0XcF8g82IYWxLdKro+yTKCHU96FmFB+ELpsnDEpYw0b11LPCiuxsFuRJXQXeErjy++DX9tGV7RTE4ou/3q4H6nJ62QVHyZ/GDrGbuCfij3xaxeaoP9LVE9b1Kwxj5fXdaFpP1Eo6LdEAbSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifBx0h2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifBx0h2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340A01F00893;
	Thu, 10 Sep 2026 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789022304;
	bh=pWRK+/droh9EmlpVtLq5n2iywPxHYJisoPAiD47WJVQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ifBx0h2U7AAIN681qPjBTZX5/QrmwwPpNz3J/BC34oSKMoq6wONCGzmJS342QggUg
	 xboKte9niQ+c1qTewtco/++S+2HNzZwT1pxc2knttlE/G118N1VD1sqRnsbr3Bfjmu
	 Odc8/kvL44mgAugOtdD7NBDydmMwo3V0wwlTBLIFrn1pr0JhRmKrQjK3tM8WTEaGwA
	 JvqOW6igQ/p9Ff3H96T2ES1R3TKK8Etgzb7xX8nSxrFMIFk93dJYamK2nzm5Ue3Tc9
	 Lcpdduqrk2rWPm4889GhXW31jUjnwb/7jKB/5yHhPI0hSPjx4E9U2DQWTaw+At9XqK
	 wDqv1mJ1D36Mg==
Subject:
 Re: [PATCH] tipc: validate data size before reading Gap ACK block header
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech,
 tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 10 Sep 2026 06:38:23 +0000
Message-ID: <178902230379.219967.14440737915959725996@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB000136A75E6C720544CAC017C8B32=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB000136A75E6C720544CAC017C8B32=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

- [Medium] Commit message overstates the impact of the fixed access in
  tipc_get_gap_ack_blks() (net/tipc/link.c:1422-1434).

Pre-existing issues:
- [Medium] tipc_get_gap_ack_blks() (net/tipc/link.c:1421-1441), the
  receive-side validator this patch extends, never bounds the peer-…
- [Low] The backward-compatibility branch of tipc_get_gap_ack_blks()
  writes into peer-supplied received packet data: p->bgack_cnt = 0…

--

tipc: validate data size before reading Gap ACK block header

This adds a length check to tipc_get_gap_ack_blks() so the Gap ACK block
header fields are only read when msg_data_sz(hdr) is at least
sizeof(struct tipc_gap_ack_blks), otherwise the function takes the
p = NULL path.  The commit is marked Fixes: d7626b5acff9 and Cc: stable.

(no Link: tags in the commit header)

> diff --git a/net/tipc/link.c b/net/tipc/link.c
> index 6427c69f89294..0be86cbdc913d 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -1419,6 +1419,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
>  
>  	/* Does peer support the Gap ACK blocks feature? */
>  	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
> +		if (msg_data_sz(hdr) < sizeof(*p))
> +			goto out;
>  		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
>  		sz = ntohs(p->len);

[Severity: Medium]
Can the impact described in the changelog actually be produced?  The
changelog says:

    "causing an out-of-bounds read of up to 4 bytes past the valid skb
     data"

and

    "the OOB accesses inside the function itself are undefined behavior
     and are detectable by KASAN."

Both call paths run on a validated and linearized skb.  tipc_msg_validate()
in net/tipc/msg.c enforces:

	msz = msg_size(hdr);
	if (unlikely(msz < hsz))
		return false;
	...
	if (unlikely(skb->len < msz))
		return false;

with hsz bounded by MAX_H_SIZE and pskb_may_pull(skb, hsz) already done.
tipc_rcv() in net/tipc/node.c linearizes the skb, and tipc_link_proto_rcv()
linearizes again.

So msg_data(hdr) is at worst exactly at skb_tail_pointer(), and the worst
case read covers [skb->tail, skb->tail + 4), which is skb tailroom or the
leading bytes of skb_shared_info.  Both live inside the same kmalloc'ed
head allocation, which KASAN does not poison.

Would it be more accurate to describe this as a read of stale bytes past
msg_size() rather than a KASAN-detectable out-of-bounds read?

The changelog also says:

    "In the backward-compatible code path, a 1-byte out-of-bounds write also
     occurs through "p->bgack_cnt = 0"."

That store is reached only when the stale bytes happen to satisfy
sz == struct_size(p, gacks, p->ugack_cnt) with a non-zero p->ugack_cnt, so
"also occurs" reads stronger than the code allows.

Since both callers already discard the result (glen > dlen in
tipc_link_proto_rcv(), glen > msg_data_sz(hdr) in tipc_bcast_sync_rcv()),
is the Cc: stable justified, or is this hardening plus a small behavioural
cleanup?  Before the patch a short STATE_MSG could be dropped or accepted
non-deterministically depending on the trailing garbage, which is worth
mentioning in the changelog instead.

>  		/* Sanity check */

[Severity: Medium]
This isn't a bug introduced by this patch, but while the validator in
tipc_get_gap_ack_blks() is being extended: does the sanity check bound the
peer-supplied counts by MAX_GAP_ACK_BLKS?

The check just below is:

	if (sz == struct_size(p, gacks, size_add(p->ugack_cnt, p->bgack_cnt))) {

With u8 counts this accepts up to 510 blocks, i.e. sz up to about 2044,
while net/tipc/msg.h declares:

	#define MAX_GAP_ACK_BLKS	128

and the legitimate sender caps each direction in
__tipc_build_gap_ack_blks():

			if (++n >= MAX_GAP_ACK_BLKS / 2) {

The consumer then asserts the msg.h limit in tipc_link_advance_transmq():

				WARN_ONCE(more(start, end) ||
					  (!offset &&
					   si < last_ga->bgack_cnt) ||
					  si > MAX_GAP_ACK_BLKS,
					  "Corrupted Gap ACK: %d %d %d %d %d\n",

Can a peer that negotiated TIPC_GAP_ACK_BLOCK send bgack_cnt >= 129 with a
matching len, get the record accepted here, and then trip that WARN_ONCE
via tipc_bcast_sync_rcv() -> tipc_link_bc_ack_rcv() ->
tipc_link_advance_transmq()?  That would be fatal with panic_on_warn.

No out-of-bounds access follows, since the kmemdup is sized by
struct_size(ga, gacks, ga->bgack_cnt) and every walk is bounded by the same
count.  Would adding a ugack_cnt + bgack_cnt <= MAX_GAP_ACK_BLKS check here
be worthwhile while this function is being touched?

> @@ -1435,6 +1437,7 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
>  		}
>  	}
>  	/* Other cases: ignore! */
> +out:
>  	p = NULL;
>  
>  ok:

[Severity: Low]
This is a pre-existing issue, but the backward-compatibility branch of
tipc_get_gap_ack_blks() writes into the received packet:

		} else if (uc && sz == struct_size(p, gacks, p->ugack_cnt)) {
			if (p->ugack_cnt) {
				p->bgack_cnt = 0;

Is the data area known to be exclusively owned at that point?  The only
preparation on this path is skb_linearize():

net/tipc/link.c:tipc_link_proto_rcv() {
	if (skb_linearize(skb))
		goto exit;

	hdr = buf_msg(skb);
	data = msg_data(hdr);

and net/tipc/node.c:tipc_rcv() does the same:

		if (unlikely(skb_linearize(skb))) {
			tipc_node_put(n);
			goto discard;
		}

skb_linearize() returns immediately for an already-linear skb, so it does
not unshare a cloned-but-linear data buffer, and git grep finds no
skb_cloned()/skb_unshare()/skb_ensure_writable() on the LINK_PROTOCOL
receive path in net/tipc/.

If the same frame is delivered to an AF_PACKET tap, packet_rcv() does
skb_share_check() -> skb_clone(), so the buffer TIPC then writes to is
shared, and the clone's reader sees bgack_cnt as 0.

This store predates the patch, and the patch only removes its
out-of-bounds aspect.  If there is a respin, could the unicast count and
size be returned to the caller instead of zeroing a field inside the
received packet?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB000136A75E6C720544CAC017C8B32%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
