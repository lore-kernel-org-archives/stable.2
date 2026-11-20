Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161394;
	b=Yw9hitqyXePX1jV1OaTyl8gJOv8wA+YV4Q1kCmzD5AQd3tghfrqh65N6+0APWNyTHoyd
	 qimwHj46kOhTwAZkH9hCCFhkZ+yOjrfTLvBz3eOiwnYRK7VzE+7NcGXp4mDWnsN8bdFpC
	 zXMPm9mRQ9OtEvEzqt1OEDG2ig+KIU7hj5Bwzds3BWS8zT+bIUkNebEMcBPtYCCn+oNPp
	 vNxz01TE03H+cVfW57kBpEEs6ig8pPsWRO6p2zYChwcovKWOWSzVW7evM96LDpnQJ4/Gi
	 Z+l1DucUAbI+KfoGSSjS4rOwF46Lf1ZfhqFOn5TMh4oR131sm1YKG7Zjbj2gVpxmYeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161394;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=gAl2ZVcUXTJM4d+7Xp/kQi7sWyZ9rO0zFNBkXMsjWX0=;
	b=mNAfCXQBA5jo9TgDU0qwhnhk0kFNUuIeCtfRm7MS059eFCWE3f6wePrsEcpGf4d69Gc3
	 Wk+Dqx2XK7/PXnfKjUo9e/vyz+CosjNde72f2JFLKZhIMLUv47OqWOxO+fc9VzrM8qoSn
	 Wfe/7noxQsWOaDf9BpP7SnX+aVd41wOqa4kPMbQ1qReqKylffq/SIG4gyN3vXXmiD9MdG
	 D1DM7PkTCbdK9cyUhH9ljOF9M03tddp1DU5MH9yoJJiAhhE5fNvOrU72ao2uS1HcyQpOU
	 1NRdrpVmKPWA931Cpy5x1QSarMjor9GqSpy05fHACIC3fVTQEjaJFk/fEy9BBZwjtTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=YExmTbxo;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07B606A320;
	Fri, 20 Nov 2026 07:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA07B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=YExmTbxo
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DB895206E9;
	Fri, 20 Nov 2026 08:56:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zA6t1mgFjdmQ; Fri, 20 Nov 2026 08:56:30 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1CE272068C;
	Fri, 20 Nov 2026 08:56:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1CE272068C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1795161390;
	bh=gAl2ZVcUXTJM4d+7Xp/kQi7sWyZ9rO0zFNBkXMsjWX0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=YExmTbxoI6nYtIM8/QLDjhOYs26udnaL7I7uqi4vL1gEQZDn3Mx2FtbXG2xxIRNob
	 Fg9tUFz/jQ8/e9E4ELFmrOSNBaq9ZsxFPtFC2VF0YjSMiVtjoLpsBW4eQGawRnlSZW
	 PdixfvJfCJDRhMWkWZaLmbYeFp09nJ83We1ZFxkFHFJUDZbIPtppKYQ8LvbRLB6Ztl
	 rUVAZ5tDh8bUGdma5mmtUdBdmHcgdTquuhFVGAcV5UYFN+FNNvlgezTdRXnJspxVAG
	 S9CpXPandEuK+fVDaRWaQxIjnIP2u43xXjxIpEx2HiV7uKIU0EJ7VRDF8RhUbRt3eG
	 NqnqAC/Kvbd+g==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 20 Nov
 2026 08:56:28 +0100
Received: (nullmailer pid 1740373 invoked by uid 1000);
	Fri, 20 Nov 2026 07:56:28 -0000
Date: Fri, 20 Nov 2026 08:56:28 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <ipsec@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH ipsec] xfrm6: gate the local error on the frame's own
 socket
Message-ID: <av_9LIb7im4b-HcG@gauss4>
References: <20261114125552.1319352-1-rmustafin@cloudlinux.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261114125552.1319352-1-rmustafin@cloudlinux.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Author: Rustam Mustafin <rmustafin@cloudlinux.com>

xfrm6: gate the local error on the frame's own socket

This commit changes __xfrm6_output() to check skb_to_full_sk(skb) instead
of the sk argument before calling xfrm_local_error() on an oversized packet.

> diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
> index 44b221a09a0c8..54fcf4b430915 100644
> --- a/net/ipv6/xfrm6_output.c
> +++ b/net/ipv6/xfrm6_output.c
> @@ -95,7 +95,10 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	} else if (toobig && xfrm6_noneed_fragment(skb)) {
>  		skb->ignore_df = 1;
>  		goto skip_frag;
> -	} else if (!skb->ignore_df && toobig && sk) {
> +	} else if (!skb->ignore_df && toobig && skb_to_full_sk(skb)) {
> +		/* xfrm_local_error() reports to skb->sk; a forwarded frame
> +		 * sent through a UDP tunnel has none, sk is the tunnel's.
> +		 */
>  		xfrm_local_error(skb, mtu);
>  		kfree_skb(skb);
>  		return -EMSGSIZE;

Should the earlier xfrm6_local_dontfrag(sk) check in __xfrm6_output() also
use skb_to_full_sk(skb), as xfrm6_tunnel_check_size() does?

net/ipv6/xfrm6_output.c:__xfrm6_output() {
    ...
	if (toobig && xfrm6_local_dontfrag(sk)) {
		xfrm6_local_rxpmtu(skb, mtu);
		kfree_skb(skb);
		return -EMSGSIZE;
	} else if (toobig && xfrm6_noneed_fragment(skb)) {
		skb->ignore_df = 1;
		goto skip_frag;
	} else if (!skb->ignore_df && toobig && skb_to_full_sk(skb)) {
    ...
}

When a caller passes sk == NULL while skb->sk is a local UDPv6 or RAWv6
socket with IPV6_DONTFRAG set, such as ip6_tnl_xmit() ->
ip6tunnel_xmit(NULL, skb, dev, 0) where skb_scrub_packet() clears
skb->ignore_df, xfrm6_local_dontfrag(sk) evaluates to false on NULL and
this change routes the packet into xfrm_local_error() instead of
xfrm6_local_rxpmtu() (or into ip6_fragment() via
ipvlan_process_v6_outbound() -> ip6_local_out(dev_net(dev), NULL, skb) when
skb->ignore_df remains 1).

Conversely, if a forwarded frame (skb->sk == NULL) is sent through
udp_tunnel6_xmit_skb() on a tunnel socket with IPV6_DONTFRAG set,
xfrm6_local_dontfrag(sk) returns true, xfrm6_local_rxpmtu() does nothing
because skb_to_full_sk(skb) is NULL, and the frame is dropped without
reaching ip6_fragment() to send an ICMPv6 Packet Too Big.

In addition, callers such as vrf_process_v6_outbound() pass raw skb->sk as
sk to dst_output(), so if skb->sk is a TCP_NEW_SYN_RECV or TCP_TIME_WAIT
mini-socket, xfrm6_local_dontfrag(sk) reads sk->sk_protocol and
inet_sk(sk)->inet_flags out-of-bounds past struct tcp6_request_sock or
struct tcp6_timewait_sock.
