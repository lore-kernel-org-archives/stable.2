Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A873368B0;
	Mon, 28 Sep 2026 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578797; cv=pass; b=a87tvJAmF3kvl7ShIruM2A0+/vbWia2EgX21CpiXU+bzg65aQQATlX5lce+eK0/XrtNzUDSOKQBLv+3TiT25wTIPlYn31vkLJOx4a4dTe5SD3vYkKUISSrpTZrRhYOWmiaqlj7CK4oIhbJJZyiZ1Gq87TZz1zfK2ASDjyb89w4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578797; c=relaxed/simple;
	bh=I9R9BOryNFbV7EgBRkj3htmaS4F0LubWapLIUBncKQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqJJdHh5KBS5RKro9933IwmSvwHn4iqq9+fwzUWeeeJirexF3DjXcACwMrCV8Yy9ucHRr77BYRtCgFCH/UZV+Wx8BvTvninnd5andOsRyyMNja3ZWnz9j11S+LZBfKmqrKNeqdjRFF1J8cloHppxuKiVteF8iT4MhC+yxIt1r2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=a/AaiXUb; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CH9Sy9Qc; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="a/AaiXUb";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CH9Sy9Qc"
ARC-Seal: i=1; a=rsa-sha256; t=1790578785; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cFNfJQTSwsMmYDO5C96MtyZTT+nlfOYFr0AoNBKEOv4IwoWQydec/+UZa9gnQ+2sds
    ko1Rc5vtcuawiHYZejyAQ9BG36Bhw78VCz1bqobz7WXVfc1FsKyuAt6bfvwu2BwhH5yv
    +20STTwNDdfrLSM5/22Jbw67oDYwmEvB2436suPpMaR2ckekvuYnxvwj4WfdQtALo8SV
    BpUyU1dsxZtIZtbn+PSf/iSVSFoI4dXmImA1cNPxqb8P72sK39IKIf6d5by2MIwPIVxx
    34WvlI/yF1kqO6IRJnY/2GAyWBdBFy+TIFmoIPjP4K1Gvm+9JmY3v6T7+glfzVIKjauf
    wUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790578785;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5supvZF1bTf9R58tuJ/omhKdhyV3UVVrr46s6dprTF8=;
    b=Ev1+FNy+hrqfUmX/u1Pf18XRJyRe5GggbqPQ81XfgJ/CwhDO9AjpN6dhr8/vBY7JwQ
    fOV1wbAMC1ouQm5BUgFRquKaYakd/NXHGNjY21ZlagVjLX0Pt02+eFSt3tiZCKUbbvzm
    4izNJoTeam+ti0elyxbHZW2kichICdbF8SpmMhpyDHIuBx4cogO5kgk95kkJ7KBxDMV5
    jM6Yrfgy09GbFlRgyte0kHuhnm3DPjT6FNyAZUJoPnGp7Lt1vRUxReSraO4f4x+gSK7O
    +Cb50mrakWWDvznLAG1e1DGsqfaJyqHOU+ftnANvbe4C/YBQ5ItpAe3RoKEA6I4WZdbR
    HQ/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790578785;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5supvZF1bTf9R58tuJ/omhKdhyV3UVVrr46s6dprTF8=;
    b=a/AaiXUbwQ+3Fl8gKDsINZZ4si7BoxeqXfSj7yJA8Pp40ulG4no6Zj9h17zQt3FLrH
    IHwcjQzTLyXgfptZlCVcQ3fLOKPg+0aSD6YcQaobTh48J5xFtPErFk6/Db9gxbyS+nLO
    RnuRH2n5ZozuDNVMCRgK/aAyxbznwPu8RljCgkSw/wcy4goh1J14/w2GZlR1zgH/GId5
    jjUDhgnElCtYahFF9upjC48hu2O9Hr7K4hacXAyJ3VDv3yhuyKpEhXIePnuEi1Zpz/de
    xaUsT+xwxA/XXjnYTaX5oQsYt3zHJ2MHZHqvFt9hWyzu2awvNj11oX9neRiCsCQizPkI
    ItCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790578785;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5supvZF1bTf9R58tuJ/omhKdhyV3UVVrr46s6dprTF8=;
    b=CH9Sy9Qc4S985Op2zynjRsU5LX3VmP7hjJofxzN/0cyFKkthPo8s0IepDlgUknFGZC
    x4jDxrZ51gtdGPZAu0Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4Kp38="
Received: from [192.168.20.237]
    by smtp.strato.de (RZmta 55.6.2 SBL|AUTH)
    with ESMTPSA id K04b9a28S6xiHxA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 08:59:44 +0200 (CEST)
Message-ID: <a56a3e49-ffdf-4285-bca6-992b12127289@hartkopp.net>
Date: Mon, 28 Sep 2026 08:59:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/packet: guard the ll header push in
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260928065000.1749383-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.09.26 08:50, Quchaosheng wrote:
> 
> packet_rcv_spkt() restores the link layer header with
> 
> 	skb_push(skb, skb->data - skb_mac_header(skb));
> 
> That subtraction is only meaningful when the device actually has a link
> layer header and the producer initialised skb->mac_header.  A CAN skb
> does not: init_can_skb() sets pkt_type and ip_summed but leaves
> skb->mac_header at the 0xFFFF sentinel, because 9f10374bb024 ("can:
> remove private CAN skb headroom infrastructure") dropped the
> skb_reset_*_header() calls that used to be there.
> 
> skb_mac_header() is then 0xFFFF, the length becomes a large negative
> number and skb_push() reports it through skb_under_panic() -- from
> softirq context, so it is a full system panic even with panic_on_oops=0:
> 
>    skbuff: skb_under_panic: text:ffffffffadd28261 len:-65455 put:-65471 head:... data:... tail:0x50 end:0x180 dev:can0
>    kernel BUG at net/core/skbuff.c:214!
>    RIP: 0010:skb_panic+0x50/0x60
>    Call Trace:
>     <TASK>
>     skb_push+0x4d/0x60
>     packet_rcv_spkt+0xe1/0x170
>     ...
>    Kernel panic - not syncing: Fatal exception in interrupt
> 
> packet_rcv() and tpacket_rcv() already handle this: both wrap their
> skb_push() in dev_has_header(dev).  packet_rcv_spkt() is the only
> remaining receive path that does the subtraction unconditionally, and it
> is reachable with SOCK_PACKET -- a socket type that still works and that
> no length or capability check keeps away from a CAN interface.
> 
> The missing skb_reset_*_header() calls in init_can_skb() are a regression
> in their own right and are being fixed separately, but a packet socket
> should not turn a link layer that forgot to initialise its mac header into
> a kernel panic.  Guard the push the same way the other two paths do.
> 
> Tested on v7.3.0-rc5 under QEMU with a slcan device on a pty (the driver
> RX path is required; vcan resets the headers on the way out and does not
> reproduce it).  A SOCK_PACKET socket on can0 panics an unpatched kernel
> with the trace above and is silent with this patch applied.
> 
> Fixes: 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")

I wonder if we should fix this in af_packet.c ?

There's already a patch waiting for upstream in the CAN subsystem, where 
the problem has originally been introduced:

[PATCH v2] can: restore skb header initialisations in init_can_skb()
https://lore.kernel.org/linux-can/20260917123716.63116-1-ndaugoing@gmail.com/

Best regards,
Oliver

> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
>   net/packet/af_packet.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7c83e0152..ab8e0309e 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1911,7 +1911,17 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>   
>   	spkt = &PACKET_SKB_CB(skb)->sa.pkt;
>   
> -	skb_push(skb, skb->data - skb_mac_header(skb));
> +	/* The push restores the link layer header, which only exists for
> +	 * devices that have one.  A device without a visible ll header
> +	 * (ARPHRD_CAN and other L3 types) must not be pushed, and the
> +	 * subtraction is meaningless when the producer never initialised
> +	 * skb->mac_header -- it then holds the 0xFFFF sentinel and the
> +	 * result is a huge negative length that trips skb_under_panic() in
> +	 * softirq context.  packet_rcv() and tpacket_rcv() already guard
> +	 * this with dev_has_header(); do the same here.
> +	 */
> +	if (dev_has_header(dev) && skb_mac_header_was_set(skb))
> +		skb_push(skb, skb->data - skb_mac_header(skb));
>   
>   	/*
>   	 *	The SOCK_PACKET socket receives _all_ frames.
> 

