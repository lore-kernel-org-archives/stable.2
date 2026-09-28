Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FE49B459
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636149; cv=none; b=bbV2SJbcebzHBRL9W3PvH+F0Z8dO2s9tJQ6FbGDJNiFHDB1wbaq3FN2LAVE6qbHDH9bCyLogcnu91+z29/dto/8ERr+UrxR7KJBpElG2A0zfnye2zI1qJaWCuy8LdCmXybn1zUeiBu1AenZIb4PbNZ6JzFOLcsPj5fVg0HpL+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636149; c=relaxed/simple;
	bh=c+1TmU9Z1heypwb9Tq4sZld/EcAfEMtsgtwzoNz4TzE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YW67AZcj3ruOymeI6iVIpZj4137FFSl5NWmTi3bRzdModRmTkGPdw/l8nG+/kY4bh3mV7sLH9r2/koQFB73r3owY9WOCKlceRYP1fKgJzm89P0RehM/sMgcJiU/MvXoCJq4t9kcnQgqBDlZ9TiaYWt0LF2vgrWbWnCisajxhbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr43Q5ej; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr43Q5ej"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a886c555c5so23556617b3.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790636146; x=1791240946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Oz4ORqhseW8wrGQtwuTHR97Ah7SXn4SA0Rm+AVP5OLQ=;
        b=Xr43Q5ej81G9D1ufxqGLbrMclOn7I/yNv9PMc4GLDE0j+9y0vCAhuI5laDsFCMNOix
         3mKSvy8SXjngJuTk7s1ACBhJHTVRItz1wN/v3YBybruqTLdbtBMrcdo1Ui2ttBfmBMcB
         cfDqF+rn7dAi8TtXgnd4Yocgo2BakQOLbtwQViDxE299ouI84dteS9NKMnt4EiVCJ2H7
         G99WBNSdancijgbKnQlDQ3WlppHy3AwaiaUNMvTdOdDrNbdJf54LN2aFhg4k/8iE9mHq
         yq0geCz8ZWBlxkQ7vur20RLnsbsigPYAizypRfHOAFB2Xrzkh6MGkDzc6G1vNUG+2uGJ
         MMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790636146; x=1791240946;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oz4ORqhseW8wrGQtwuTHR97Ah7SXn4SA0Rm+AVP5OLQ=;
        b=lYwz+lnJcSNzvOlXctNWvS6i+03jxBrP6M3H7vQrvQFDDdYtB4j/gJiBG74mg1ghaA
         W7ZSE97wziV5JEWfSvma6rGAOxGHy4NJ7Ufjv6hQoBTUaRjhYSDOcaY+IeiRw0NNoSZP
         OLTqdzYdSlp/fTDhB66LaH3Jl7vLT6zon3easK/QLNd1o+y2oC/g2umxtzaaGeu55Fpk
         1ZBY8avWJMWOKWZ/WlqoP1tl5A9Qj+AU5UD48L5qqtL88Q/HC4b0JswXr32scrOLPpuj
         89zsbpdimtamRinfTCaKm6/zCmPOBggvd2KU9Ht7FOSDOq7jnNPn7WU8xm8kkBTvXoEx
         f2PA==
X-Forwarded-Encrypted: i=1; AKwUvBz6LB0oiQ18X8F0QVJWyT1SW1pLCNn7pIjcXgYOD8ewBFeh9m6e4sCP3zv0scaCiV0VpPZFO8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUzOdCauZ9QQjauKbjpYujXR1OhvjVAoRpVCq0VJLnB5iWsYmM
	H3lBmucAue4HIiggT/z41Usq1YA316Dr1TwnfjHKqyINt2Ik1wm7Ttds
X-Gm-Gg: AYBFou051FcJZX11+L2H438JIncRKjoU/9E2oa+ExXJMQqPoVjVV2nuZzoig8uvXawU
	S9iYKw301tgEKAERHi0Qe679kChOe3kBvtwL6VYNo2Micu4RkMuiIuGF7JLFoqK+ZQ9A210M0SP
	yXM9EkbE/jsGAGmYLbqbbqY9nhVFbFbllcHj2vZvo6KA4m6hhrcnBfNnOgpPJInFWU4wrCxTOuu
	8s97hcDayXQNOMbmN5f7QGAidJ2iE8W6qbKb/bH9sLBRcgdAfcPtKAj03aVRF1nPQW9Hf34AoEP
	URlVhZDLK8aWegGUU26cJrHHBV2NmWOKEVdOd7K7HElSL/OGr/DmbqLBLuKmzcSJQYQNkhc6z4w
	SmAHx0cr1Kgi50JIOJrD9lP92rHPQJVswyzuCtvdkmXv+CJKj7osvAnwV6b2MdUgPIqa2gKEh5J
	evxSs1Fh7OMrm6OB+NLbYRAVBjNqsGqEM/1DtCj+UIMqv0a+QvhABV3hvC5VTxWB0+vrV7XVIXr
	wUJlB9jTcnSxHcwnPcDC+/chPVyYTV/Wd6iX0Fl/jI8lD/eaR3O
X-Received: by 2002:a05:690c:3489:b0:8a9:b587:f5ab with SMTP id 00721157ae682-8a9b587f722mr28533617b3.6.1790636146130;
        Mon, 28 Sep 2026 15:55:46 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860e5a5e9sm51228887b3.17.2026.09.28.15.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:55:45 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:55:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Quchaosheng <quchaosheng000406@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Quchaosheng <quchaosheng000406@163.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2d23ff6855a34@gmail.com>
In-Reply-To: <20260928113108.2127215-1-quchaosheng000406@163.com>
References: <20260928113108.2127215-1-quchaosheng000406@163.com>
Subject: Re: [PATCH v3 net] net/packet: guard the ll header push in
 packet_rcv_spkt()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Quchaosheng wrote:
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
>   skbuff: skb_under_panic: text:ffffffff8bd21bc1 len:-65455 put:-65471 head:... data:... tail:0x50 end:0x180 dev:can0
>   kernel BUG at net/core/skbuff.c:214!
>   RIP: 0010:skb_panic+0x50/0x60
>   Call Trace:
>    <IRQ>
>    skb_push+0x38/0x40
>    packet_rcv_spkt+0xe1/0x170
>    __netif_receive_skb_core.constprop.0+0x7e8/0xd30
>    ...
>   Kernel panic - not syncing: Fatal exception in interrupt
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
> 
> Hello Oliver,
> 
> Removed the comment block, as you suggested.  You are right that the other
> two dev_has_header() call sites do not carry one, and that the block
> comment at the top of the file already states the invariant -- so the
> comment was only restating the commit message.  The hunk is the guard
> alone now, two lines.
> 
> No behaviour change from v2: same predicate, same push.  I re-ran the
> QEMU/slcan pair on this exact revision to be sure nothing else moved with
> it -- unpatched still panics with skb_under_panic len:-65455 out of
> packet_rcv_spkt+0xe1 in interrupt, patched prints no panic and powers off
> normally.  checkpatch is clean on the resulting diff.
> 
> Thanks for the review,
> Quchaosheng
>  net/packet/af_packet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7c83e01526ed..a951a1e3c088 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1911,7 +1911,8 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>  
>  	spkt = &PACKET_SKB_CB(skb)->sa.pkt;
>  
> -	skb_push(skb, skb->data - skb_mac_header(skb));
> +	if (dev_has_header(dev))
> +		skb_push(skb, skb->data - skb_mac_header(skb));

Since SOCK_PACKET is equivalent to SOCK_RAW, this looks like a
legitimate fix to me.

An earlier version of the patch gave a different reason: that CAN had
removed skb_reset_mac_header. This is a not a fix for that change,
agreed? Other locations in the stack also require it initialized, also
on devices without mac header.

I see that there is another CAN patch that reverts that change:
https://lore.kernel.org/linux-can/20260917123716.63116-1-ndaugoing@gmail.com/#r

Specifically to packet sockets, also see the detailed comments on this
point at the top of net/packet/af_packet.c

Small aside: please remember to not send more than 1 revision per 24h,
per Documentation/process/maintainer-netdev.rst

>  
>  	/*
>  	 *	The SOCK_PACKET socket receives _all_ frames.
> -- 
> 2.43.0
> 


