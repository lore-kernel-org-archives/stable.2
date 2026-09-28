Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994949D595;
	Mon, 28 Sep 2026 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593758; cv=pass; b=MkhEtrICsu/3/lIj/dlp+akmEkd9RS+/3A6gShe8Jd9zfV0kRpF5qNduUTrnGX/lxphDYHpy2YHyut0bGGIFuoiOmCnDR9o8JYx1DsoBgJ2rj9HL7W831X9KLfl9nVukSgv5kP4TaoHLiCGSFRSzPPJ6EJ7vSDxw9MmrLZjb68U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593758; c=relaxed/simple;
	bh=7lELjSk5u4HXV2UZJwHzp+hM6f0FBs68Wk8RmW/l0Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2AKxTY6sBxl7wgi33v2UqfDc0TTaPsggUzsNgN5xrl+X8sSro1yZ6aT6iT1dz/HKJDTmNu6FYk1P0ehHPO2k7cHDR8qJdzml18LTxFKJX+KB94QsYXsgtgnUudnZG2UCTlw3XBU8XjKJlhEiFWGoMj4GHZaCpmUb6fPWqMPOjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pqonKwJx; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VA8TSJE/; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pqonKwJx";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VA8TSJE/"
ARC-Seal: i=1; a=rsa-sha256; t=1790593746; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ya1YCadGji6rMTM6CMEvPU/TkfS1bCGfAfrYS6Fpuat/4pHw9PMf5J1VMC7oYktm3F
    p7xw6RzcADLqjJ1CENJ/R7PI8KRxr7DdWKi0s8WBlxVfxCOo72MXdFCCy0ATsizyuZy7
    IOEdtDJ+GH5mxYYk4wjDA0oP1xSo81IzMrAdWpX+TxTQDmln47Ha7a+Q8l3ew+SzPAjy
    KMXDG4a2mDdWHG5qGw9bJSk5MADFLzoqXDEVWN1OBhqQvAz2dBGNWweksJwQp0n8eJcC
    AB87O9hQXKC3b3FvUTbdUzmHPBNbRAJOqoUebPCvfT2Vi9B8ViF3bYC29Ir73jUaj1JT
    bwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790593746;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WDPPOnZ8zGMqDVanmkLKG1cHDsWhNsNYgX/67/WGH9k=;
    b=ryZW1G4L/mHVLmwzCmhXaFouB2AgHMZthOiMFAn8I8UQUESHYx7rFwlr65XaO5y2D4
    RF4bi6bwT5qI2B9odMjlvDgLGBIcp4GrdMcV5Uz0LQOHY1qzWjwNy/N3kXu9RkNMNuX2
    +jMnIzFupcZn3W2wMZwNR1SoGyftjTa0DOFaZbqOKlPjr6IWJLwSGmghaI9BbIkB48En
    U2XDNUQPzH/9cqcQ1zFdGPQyT8gUy4sAqrnvmJXmF6I9Fhjt41HXuzfMApfkwE2qznpm
    dbqSrjsGV3DlCU4nkeIhwrfKsomb6gq5p9a+3j5mEpKCUbOJntfkaxUj033Vg+3bNz+u
    eQpA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790593746;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WDPPOnZ8zGMqDVanmkLKG1cHDsWhNsNYgX/67/WGH9k=;
    b=pqonKwJxLrSA6qTB7e5B+76O0SJB6ST5UrYibTO772ZGymZNaFETTxU1uFed2MxnAd
    PFm6hw1RL1dQvWaRHHGARQG8mQrsr9d+Jl7L8qAXYBmmHyNGGfc8pC7YkZIz2fCSE84A
    +cbEjJnzWvE+rF4g9JntLOkPrnQFayP2IRkiCzj+iVQno6UIoRaI2gTYfyHpDdQnutLv
    PVvKEGmvt5jT9rKgKkCe5lIoH/ZNdgI/rVWXNX8qj/jtlBKEnz4GRpGMj1GA3KIloZAa
    itK1LJlcY726629K6bKe4awuTUxMCq8ulSbAQHKFgvjeagLURFgcHVFAfUpyF83Xv1/k
    Pjjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790593746;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WDPPOnZ8zGMqDVanmkLKG1cHDsWhNsNYgX/67/WGH9k=;
    b=VA8TSJE/CpXES/f1z9ZewJyYFpNu602kUuzuZHYIRcWWAN+d65zafQeZP8at6YxCVr
    rJdKvUauAM27k8tdT8BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SB95K5c
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 13:09:05 +0200 (CEST)
Message-ID: <3a83de0c-8b64-4f14-ac5f-05f4e7f2d41d@hartkopp.net>
Date: Mon, 28 Sep 2026 13:09:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net/packet: guard the ll header push in
 packet_rcv_spkt()
To: Quchaosheng <quchaosheng000406@163.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 stable@vger.kernel.org
References: <20260928065000.1749383-1-quchaosheng000406@163.com>
 <20260928065000.1749383-2-quchaosheng000406@163.com>
 <a56a3e49-ffdf-4285-bca6-992b12127289@hartkopp.net>
 <20260928080919.1888649-1-quchaosheng000406@163.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260928080919.1888649-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.09.26 10:09, Quchaosheng wrote:
> packet_rcv_spkt() restores the link layer header with
> 
> 	skb_push(skb, skb->data - skb_mac_header(skb));
> 
> That subtraction is only meaningful when the device actually has a link
> layer header.  packet_rcv() and tpacket_rcv() both wrap it in
> dev_has_header(), which is also the predicate the block comment at the
> top of the file states the restore in terms of; packet_rcv_spkt() does
> not.  commit d549699048b4 ("net/packet: fix packet receive on L3
> devices without visible hard header") introduced the helper and changed
> the two call sites, and this one stayed behind.
> 
> A device without a visible ll header can leave skb->mac_header at the
> 0xFFFF sentinel that __alloc_skb() initialises it to.  A CAN skb does:
> init_can_skb() sets pkt_type and ip_summed but does not reset the
> headers, and commit 9f10374bb024 ("can: remove private CAN skb
> headroom infrastructure") dropped the skb_reset_*_header() calls that
> used to be there.  skb_mac_header() is then 0xFFFF, the length becomes
> a large negative number and skb_push() reports it through
> skb_under_panic() -- from softirq context, so it is a full system panic
> even with panic_on_oops=0:
> 
>    skbuff: skb_under_panic: text:ffffffff8bd21bc1 len:-65455 put:-65471 head:... data:... tail:0x50 end:0x180 dev:can0
>    kernel BUG at net/core/skbuff.c:214!
>    RIP: 0010:skb_panic+0x50/0x60
>    Call Trace:
>     <IRQ>
>     skb_push+0x38/0x40
>     packet_rcv_spkt+0xe1/0x170
>     __netif_receive_skb_core.constprop.0+0x7e8/0xd30
>     ...
>    Kernel panic - not syncing: Fatal exception in interrupt
> 
> The socket type is reachable: packet_create() accepts SOCK_PACKET
> alongside SOCK_RAW and SOCK_DGRAM behind the same CAP_NET_RAW check,
> and neither the socket length nor a capability check keeps it away
> from a CAN interface.
> 
> The missing skb_reset_*_header() calls in init_can_skb() are a
> regression in their own right and are being fixed separately, but a
> packet socket should not turn a link layer that did not initialise its
> mac header into a kernel panic.  Guard the push the way the other two
> receive paths do.
> 
> Tested on v7.3-rc5 under QEMU with a slcan device on a pty, which is
> the driver RX path: vcan does not reproduce it, because can_send()
> resets the headers on the way out.  One SOCK_PACKET socket bound to
> can0 and one frame written into the line discipline panics an
> unpatched kernel with the trace above; the same image with this patch
> prints no panic and powers off normally.  Both kernels are this tree,
> defconfig plus CONFIG_CAN_SLCAN=y, differing only in this hunk.
> 
> Fixes: d549699048b4 ("net/packet: fix packet receive on L3 devices without visible hard header")
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> Hello Oliver,
> 
> Yes -- af_packet.c is the right place, and your question made me cut the
> patch back, so this is a v2.
> 

Thanks for the explanation.

> You are right that the CAN side is already being fixed: I ran zjamg's v2
> earlier today and verified it holds.  The two are not alternatives to each
> other.  That patch restores the header initialisations the CAN stack lost,
> which is the actual regression; this one is the packet socket that should
> not panic when a link layer hands it an skb whose mac_header was never set.
> Either one stops the crash on this path, but only the pair leaves the
> producer correct and the receiver safe.
> 
> On your question about where it belongs: packet_rcv_spkt() is the third
> call site of the same subtraction, and commit d549699048b4 changed the
> other two to dev_has_header() and left this one alone.  It is still the
> only one that does the subtraction unconditionally, and it is reachable
> with SOCK_PACKET.  So this is that commit's missing hunk rather than a
> second opinion on the CAN fix.

Correct!

> 
> The v1 had an extra skb_mac_header_was_set(skb) conjunct and this version
> drops it.  dev_has_header() alone is what the block comment at the top of
> the file states the restore in terms of, and what packet_rcv() and
> tpacket_rcv() test; for a device without a visible ll header the documented
> invariant is that mac_header points at data, so the subtraction is a no-op
> push and skipping it outright is the same thing.  CAN is the case where
> that invariant does not hold, which is the panic; the extra conjunct only
> would have masked it.  I have re-run both kernels with this version.
> 
> Details of the re-run, since the earlier numbers were from the v1: v7.3-rc5
> under QEMU with slcan on a pty, defconfig plus CONFIG_CAN_SLCAN=y, two
> images from one tree differing only in this hunk.  Unpatched: skb_under_panic
> len:-65455, packet_rcv_spkt+0xe1, "Kernel panic - not syncing: Fatal
> exception in interrupt".  With this patch: no panic, powers off normally.
> checkpatch is clean apart from the unavoidable long line in the quoted trace.
> 
> Thanks,
> Quchaosheng
> 
>   net/packet/af_packet.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7c83e01526edc..40c67b86a1735 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1911,7 +1911,14 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>   
>   	spkt = &PACKET_SKB_CB(skb)->sa.pkt;
>   
> -	skb_push(skb, skb->data - skb_mac_header(skb));
> +	/* Only a device with a visible ll header can have it restored, which is
> +	 * the test packet_rcv() and tpacket_rcv() already make.  For the others
> +	 * the header is invisible and the subtraction has no meaning: a producer
> +	 * that left skb->mac_header at its 0xFFFF sentinel turns it into a huge
> +	 * negative length that trips skb_under_panic() in softirq context.
> +	 */

Just a nitpick: AI mostly likes to introduce comments that repeat the 
argumentation already provided in the commit message itself.

I would suggest to remove this entire comment as the other "if 
(dev_has_header(dev))" call sites don't have a comment either.

Comments are needed to provide additional information when the code is 
not obvious - and not the development history including producer 
failures ;-)

> +	if (dev_has_header(dev))
> +		skb_push(skb, skb->data - skb_mac_header(skb));
>   
>   	/*
>   	 *	The SOCK_PACKET socket receives _all_ frames.

Many thanks and best regards,
Oliver
