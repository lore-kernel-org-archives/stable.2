Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB63C4A3410;
	Thu, 17 Sep 2026 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636112; cv=pass; b=mtqzX6Da2miiQlDIKY2MqrVG07Yf9hmaWAEblwME44PvrVS6DlvSYLOjknvlq8c/VX4Uglp0kzj7/tMA6+OIx6XUuW+tjxktAlLUWMwV3rkph4bXUQYvB6xr0Tqq55GiFqD14bJoIB7LrCVrFJimvybXe2B4IsHg7NWkO94En3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636112; c=relaxed/simple;
	bh=dh2Pe+J3ZLxadmFtdCBSKgheSTP5UgNO5XD9yjX7iC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ba2s05rFKG43vdzA91EIwQM80z8SShwxuf3zOLve0S4nvv4lw9LlNlNq3fHwa9D2gaeuhBbtn4hcrPV8py6e58ahqN3sldt7DH+OjxaUgDR4xn6pJATE7TquV+9PxPVDzyCTM2i6tkEm+dAl9vJYgMo7dvJgSKUDm4NOHpnT4/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kGvkAt+2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xOySnDSI; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kGvkAt+2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xOySnDSI"
ARC-Seal: i=1; a=rsa-sha256; t=1789636100; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tDIaKv8RaHo1xAVuHuE0DDlwXTgOql4PmNK0/uPOMsvTNz+B37v2PAehkRLTCUGLuf
    hnamSTQxdpGvumKWg2XDYEPpEPoxLqixGT/Cnvj1AlYjKFDb3t7X65nppBnHla7EQCIf
    kNgXP8W4PS2qQFbv1oxarkc40HEhMyHO+koVn20P+JSNgllYsJGGVRPJ9/eLNF7aMMiK
    kJ6DDDfLJevSVxhJehoqQZjLyi1fKtpINxHa4tnDfYxoFIdZeEjIJKHDyrBFAA7E4WRD
    VX64qiLgPfCi41MJtsQBUMqAMmSIqWg6ayxCTqtAOH63a+SKhM1GN+wNVeMU7Yk5Womd
    zQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789636100;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Lb76yEjIkMgTdk6d63jrjFBsGWOPjYzP7tDJzvjAHeA=;
    b=UFs8ywJVeycn73MMTyJYyq68rA10B/mz+RaPBIUDxSRSLoIvdGdC03a/djpj9opUd7
    odtI3Z6aqGyIPkeO16PKYDx5t+99C54441xlRbd+8x9L//qCW4+heSH1R5dCaVPgXgCA
    Htfe9qyr3yYL6y7f2jgwOKiC2HVzu/h0T5CZ2lebLBYhXrXPernVtNcMzDBhuQ0/NzLk
    h14UHcEsVqJu9Uq1UllWfjJsQuxgDwDEKotMEG4/v3FKwYPhxiSn129dspOEeV73CCoq
    lywk2OpAtJtT/2jV8c5+zOO3ui/u94YcEBgJyDXuHgf+kMjKy8Ft2hWMxQ/QA14O751M
    p1Ww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789636100;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Lb76yEjIkMgTdk6d63jrjFBsGWOPjYzP7tDJzvjAHeA=;
    b=kGvkAt+2LS6haOQ/+DQnoePCVG3c1Bxen83JIrQ5BU6cYaNqFzaYyq2B3VxY51Dl2M
    j0ms8+UUm6m8kvevuG+X5/rl/bF3HFuhX9FIJSjmZP+yYAbf7rZAuyR+t/R7RNdWZykY
    sOIfZfl8XzuU4l25AABgDYDHqClOZWugpshnKBugbzMmuEY4XSVMLM3HkV8qzSB7vFB8
    +nSWq0ZKhFnTh1BoN95so522UKlHTBNmXsTTdR8t4YUuSVqSgMpDTOtD1o10xn5t+u7S
    ixp+OUOplA8xTA1PbmR8hM3F4u7oZoL7bqWYlx/4YM/DCWbyGGJ/YV8AHKJDk6sugBEs
    BfSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789636100;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Lb76yEjIkMgTdk6d63jrjFBsGWOPjYzP7tDJzvjAHeA=;
    b=xOySnDSIT9Snw7ectIvkh9/XKkyDUPyUGIfrG18DCL5xJ/AL4kSFAwtS4rMkUfiXOA
    cfkIfO+aBSmlPkf2J1AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTnagWHxxFohXWHykT5Sj"
Received: from [10.91.122.125]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b728H97bWPm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 17 Sep 2026 11:07:37 +0200 (CEST)
Message-ID: <a0eca0ff-5ccc-4eff-b608-fb7a39cd05aa@hartkopp.net>
Date: Thu, 17 Sep 2026 11:06:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] can: restore skb header initialisations in
 init_can_skb()
To: zjamg <ndaugoing@gmail.com>, mkl@pengutronix.de, mailhol@kernel.org,
 linux-can@vger.kernel.org
Cc: pabeni@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260917063744.591-1-ndaugoing@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260917063744.591-1-ndaugoing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello zjamg!

Many thanks for the patch!

On 17.09.26 08:37, zjamg wrote:
> Commit 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
> removed the skb_reset_mac_header()/skb_reset_network_header()/
> skb_reset_transport_header() calls from init_can_skb(). As a result, RX
> skbs from alloc_can_skb() and friends again carry mac_header = 0xFFFF.
> When such an skb reaches packet_rcv_spkt() (SOCK_PACKET), the push length
> calculation overflows and triggers skb_under_panic -> kernel BUG -> full
> machine panic.
> 
> The same issue was originally reported in 2014 on linux-can and fixed by
> commit 969439016d2c ("can: add missing initialisations in CAN related
> skbuffs"). packet_rcv_spkt() itself has never been hardened: only
> packet_rcv() and tpacket_rcv() gained dev_has_header() checks in
> commit d549699048b4 ("net/packet: fix packet receive on L3 devices
> without visible hard header").

Right. My bad.

I looked into netdev_alloc_skb() to see the the values were initialized 
and therefore thought I can leave it out.

But there are initialized in a way that the header settings do not 
present valid settings, e.g. mac_header = 0xFFFF

So the functions definitely need to be called as you correctly remarked.

> Fixes: 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: zjamg <ndaugoing@gmail.com>

You can add my

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

in your v2 patch.

> ---
>   drivers/net/can/dev/skb.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f8..a0712e607b28 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -210,6 +210,14 @@ static void init_can_skb(struct sk_buff *skb)
>   {
>   	skb->pkt_type = PACKET_BROADCAST;
>   	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +
> +	/* Restore the initialisations that were present before
> +	 * 9f10374bb024 to prevent skb_under_panic in packet_rcv_spkt
> +	 * and similar consumers.
> +	 */

Please remove this comment in v2 - just add the code.

This is not usual and the patch description perfectly serves the 
documentation needs.

Thanks & best regards,
Oliver


> +	skb_reset_mac_header(skb);
> +	skb_reset_network_header(skb);
> +	skb_reset_transport_header(skb);
>   }
>   
>   struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)

