Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB911355048;
	Thu, 10 Sep 2026 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011487; cv=none; b=L1CqRPmumafvQWBtraIucCKQpS8wK3vrArw4IxM11y08pkGlhMdHNFI2pLk52m4jLrzgn50aq3leObMajgdHoRFIJYZqNthkd3IVOjKS8J43y085Sb3elHZZsZMPIO7/+PbdbhgPz9aTAIIvpZ3bX5zKPz1LzuELqU824P9VRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011487; c=relaxed/simple;
	bh=vlqR+oXId/SrpukB9BNKcBmpRRPr+W5vCyA80E8zVUs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vn/iDFEZW1JwKb7bWQgGHJgvl+1Ps9gD0YWHO60snE6UBLLHEzY+SM7ETIbBQ5367kBTcPth1h9P6aRABFO1NxfV/Y6n+2Tcjp3G6q4T1clOheqm1o8Wm2K5q5vASts0kcMi6/XQ6U4Ecwruo3nTIwVsQHgxUigvS89Hp8IrccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLDYlhhw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLDYlhhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547011F00898;
	Thu, 10 Sep 2026 03:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011485;
	bh=IrNK0hsHGWXg7sJc7fJSJDyrIVimG9uOMvJyKYPS+sk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iLDYlhhwa8KVrb3sbmXb5TcM9mKeTc7byD2HHqldA6YaPqrIQZkzaT4Bz673FVoph
	 9OM6Nqr4nB+GKng0qgNQzCzxdpdKzUsY8gpteXiTV8+sY4VZy12mY7Ulo5aIeKszvg
	 nfQ9clrX52UKTevWcIz5lfZ8lgT4vhgBs0FX+JgnpKM0EZISyqqn7WY0jBU62h/e6u
	 CQHbQ+l0kzUh4Hi9jUrWGF8/47Q7+x+TuEh3VDZGypgBJeXP7WeqY4fD+WXFHmJwx9
	 rrIXEZwxY+En6CbQ1kEzRAggS+3qbKLvxe0JKn1kpYjTq6qsTZRh0vk3kq5Ffj5t0o
	 A5g/vp8+Oh4kA==
Subject: Re: [PATCH] nfc: llcp: validate PDU size in nfc_llcp_recv_dm() and
 nfc_llcp_recv_hdlc()
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: david@ixit.cz, linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 10 Sep 2026 03:38:04 +0000
Message-ID: <178901148487.219967.15383068138444708432@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001E8602F36054CDD8979A2C8B32=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001E8602F36054CDD8979A2C8B32=40AS8P251MB0?=
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] In nfc_llcp_recv_hdlc() (net/nfc/llcp_core.c:1081-1085) the
  newly added short-PDU guard replies with nfc_llcp_send_dm(local, dsap,…
- [Low] Both new guards test the total length skb->len rather than the
  linear/pullable length (pskb_may_pull(skb, 3) or skb_headlen(skb) >=…

--

nfc: llcp: validate PDU size in nfc_llcp_recv_dm() and nfc_llcp_recv_hdlc()

The patch adds minimum length checks to two LLCP receive handlers so the
third PDU byte is not read when only the two header bytes are guaranteed by
__nfc_llcp_recv().  DM requires LLCP_HEADER_SIZE + 1 and HDLC requires
LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE.

A couple of questions below about the new checks.

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index cac1b5487064d..89d6f4599e11a 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1077,6 +1077,12 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
>  	ptype = nfc_llcp_ptype(skb);
>  	dsap = nfc_llcp_dsap(skb);
>  	ssap = nfc_llcp_ssap(skb);
> +
> +	if (skb->len < LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE) {
> +		nfc_llcp_send_dm(local, dsap, ssap, LLCP_DM_NOCONN);
> +		return;
> +	}
> +

[Severity: Medium]
Should the short-PDU case really answer with DM(NOCONN)?

This branch runs before the nfc_llcp_sock_get() lookup further down, so it
cannot tell "no such data link" from "an established data link that sent a
truncated I/RR/RNR frame":

net/nfc/llcp_core.c:nfc_llcp_recv_hdlc() {
	...
	llcp_sock = nfc_llcp_sock_get(local, dsap, ssap);
	if (llcp_sock == NULL) {
		nfc_llcp_send_dm(local, dsap, ssap, LLCP_DM_NOCONN);
		return;
	}
	...
}

Before this patch the only DM(NOCONN) emitted from this function was the one
above, i.e. it was sent only when the lookup actually failed, matching what
the reason code documents in net/nfc/llcp.h:

	/* Disconnection reason code */
	#define LLCP_DM_DISC    0x00
	#define LLCP_DM_NOCONN  0x01

Can this desynchronise the two endpoints?  nfc_llcp_send_dm() passes the
received dsap/ssap into llcp_add_header(), which swaps them, so the DM is
addressed back to the peer of the still-open connection.  The in-tree
decoder of that byte, nfc_llcp_recv_dm() in this same file, does the
following for any reason that is not NOBOUND/REJ:

	sk->sk_err = ENXIO;
	sk->sk_state = LLCP_CLOSED;
	sk->sk_state_change(sk);

so the peer socket goes to LLCP_CLOSED while the local socket stays in
LLCP_CONNECTED with tx_queue/tx_pending_queue intact until the link timer
reaps it.

The sibling hunk of this patch takes the opposite policy and just returns for
the same malformed-PDU condition.  Would silently dropping the frame here
too, as the other malformed-PDU paths in this file do, keep both ends
consistent and let the peer retransmit?

Also, the commit message only mentions adding "a minimum-length check to each
handler" with no mention of emitting a protocol response, which a stable
backporter would likely read as a pure bounds check.

[Severity: Low]
This isn't a bug I can demonstrate today, but the new checks test skb->len
while the bytes they protect are read out of the linear region:

net/nfc/llcp_core.c
static u8 nfc_llcp_ns(const struct sk_buff *pdu)
{
	return pdu->data[2] >> 4;
}

The only linearity guarantee on this path is in __nfc_llcp_recv():

	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
		kfree_skb(skb);
		return;
	}

and nothing between there and the handlers (nfc_llcp_rx_work() ->
nfc_llcp_rx_skb() -> nfc_llcp_recv_hdlc()) pulls further.  For an skb with
skb->len == 3 and data_len == 1, both new conditions are false and
skb->data[2] is still read past the linear data; for an I PDU the following

		skb_pull(skb, LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE);

would drive skb->len below skb->data_len and hit the BUG() in __skb_pull().

I could not find a producer of such an skb: grepping net/nfc/ and drivers/nfc/
for nr_frags, frag_list, skb_add_rx_frag and skb_fill_page_desc returns
nothing, every skb reaching __nfc_llcp_recv() comes from alloc_skb()-based
helpers with data_len == 0, and nci_add_rx_data_frag() coalesces fragments
with skb_cow_head() plus memcpy(skb_push(...)) so the skb stays linear.

Would pskb_may_pull(skb, LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE) (or a
skb_headlen() test) be preferable here, so the guard both validates and
linearizes?

>  	ns = nfc_llcp_ns(skb);
>  	nr = nfc_llcp_nr(skb);
>  
> @@ -1254,6 +1260,10 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
>  
>  	dsap = nfc_llcp_dsap(skb);
>  	ssap = nfc_llcp_ssap(skb);
> +
> +	if (skb->len < LLCP_HEADER_SIZE + 1)
> +		return;
> +

[Severity: Low]
Same skb->len versus linear-length question as above applies to the
reason = skb->data[2] read below.  Note that nfc_llcp_recv_dm() takes a
const struct sk_buff *, so switching to pskb_may_pull() here would need
either a signature change or raising the guarantee in __nfc_llcp_recv() and
the AGF dispatch path.

>  	reason = skb->data[2];
>  
>  	pr_debug("%d %d reason %d\n", ssap, dsap, reason);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001E8602F36054CDD8979A2C8B32%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
