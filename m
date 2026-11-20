Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156983;
	b=r8s3vK/n3s4pg68mo6VA2jkcrgbdslkD3rVGaUlcTx5ogp+3Fb6nJvenVNACQ8BUBKUJ
	 mO3MgCmcrZkEkd8ehQJ+y2YjXY7KUk2d+p2VMtPy27coCUpa8oboaLqjBXnBK7CYcVB3k
	 kL+rtSvQFWQngBX6zBYWVjf6BSoSE9/KV4MebBB1eKMDwJ33UmkR+YIXLnQPPM6AaF3U2
	 TsU7cDlC7VKee9WlOvtEJv5b96mATxXn6H+y442M9ky4is8z0rTWKcZTp6xQNAhEZkGkb
	 YlvVlJdvRZ80OEUn+rib8e2mcnVjAYcn1kgAz04/1ogk1uw89VPOkYrFGfDhL91zBSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156983;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy;
	bh=5L5MV5K9+o090G2Wf4y7FRKXeHZWJ1IGq5n28rVHbBE=;
	b=W/E1GV9taOQWyZ32OFSxXOI6GX9GRwcT9UAgJTSdNSiGpH/Jq6N4Ndj0YyDJJse5PSQs
	 8bwrtGx7hWr9cCjrWol/iAW0bvypQSUvo1tntu8A8dHm9d9WygutfhpVshA6YrQrsA1DI
	 XMYGEjOzC27kH0PeI7dgLfZwrNL3i35MD9rWIPfxuGeYSSj4LYhZwRqvrQODmcQ9QJ2pX
	 JZD2eVPMlcFzbOSAbZr8Q5YHCd7agM3lfbL8vOMnWAqdFeF5WIi4BklbIFNVO4rpLvw40
	 dgtogQBs7ah7Ru70vydQa0bTQFz+idXbialU1GJQ16JJMPihOJVMQyWfNd+Th9/wrTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b="O7//PZXX";
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99C606A326;
	Fri, 20 Nov 2026 06:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC99C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=O7//PZXX
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D56DD20743;
	Fri, 20 Nov 2026 07:42:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AWpiZiIyASIi; Fri, 20 Nov 2026 07:42:59 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 420FB2069C;
	Fri, 20 Nov 2026 07:42:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 420FB2069C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1795156979;
	bh=5L5MV5K9+o090G2Wf4y7FRKXeHZWJ1IGq5n28rVHbBE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=O7//PZXXS2BxZ7HIF8RijE/yH9oyOT/zJP9KyUHuQSs9T+t63SzLo41QFuSYeXKN8
	 6xRMYZMRzcurBvpi0/V1AO99nLifwZPC/GXSZYZM4sQSiZ8qtbjboWv8lXv+M5e0d6
	 CNkr3dg6AaqEvKesHkRZM2mvCg7vWkGVqKz0g7MWUsnlxS/pSwY5kQDoTJyKrDq++m
	 Cxpje+0jJp1qFyrmd/30j1LGLz7SYKv/uVWKYI1aU41HKxhGvFaNBfDTUfPz8da1vn
	 SLo6le0jhBEEPhNf+y8MSM/4oc8mxz/6WYgnc0Nc86IoV1+/+imDEbc55sYxxmHKa5
	 EhK2PVKo+VxCg==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 20 Nov
 2026 07:42:57 +0100
Received: (nullmailer pid 1661259 invoked by uid 1000);
	Fri, 20 Nov 2026 06:42:57 -0000
Date: Fri, 20 Nov 2026 07:42:57 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sewook Seo <sewookseo@google.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@android.com>, <stable@vger.kernel.org>, Maciej
 =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>, Lorenzo Colitti
	<lorenzo@google.com>
Subject: Re: [PATCH ipsec] xfrm: check inner family via skb_dst for
 small_ipv6 DF clearing
Message-ID: <av_r8dKdyeJmw-jj@gauss4>
References: <20261110092513.2375648-1-sewookseo@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110092513.2375648-1-sewookseo@google.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Nov 10, 2026 at 09:25:12AM +0000, Sewook Seo wrote:
> Commit 6821ad877034 ("xfrm: do not set IPv4 DF flag when encapsulating
> IPv6 frames <= 1280 bytes.") intended to clear the outer IPv4 DF bit in
> xfrm4_tunnel_encap_add() when encapsulating inner IPv6 frames of at most
> IPV6_MIN_MTU (1280) bytes, by checking skb->protocol == htons(ETH_P_IPV6).
> 
> However, its caller xfrm4_prepare_output() overwrites skb->protocol with
> htons(ETH_P_IP) before invoking xfrm4_tunnel_encap_add(), since
> commit 0c620e97b349 ("xfrm: remove output indirection from xfrm_mode").
> As a result, small_ipv6 always evaluates to false, leaving IP_DF set on
> outer IPv4 tunnel packets even when encapsulating <= 1280-byte IPv6
> frames.
> 
> This issue was observed on devices in production use over IPv6-in-IPv4
> ESP-in-UDP tunnels where an intermediate IPv4 link has an MTU smaller
> than the encapsulated packet size (e.g. < 1362 bytes) and ICMPv4
> Fragmentation Needed errors are either filtered or not actionable below
> IPV6_MIN_MTU, causing encapsulated <= 1280-byte IPv6 packets to be
> dropped instead of fragmented by the outer IPv4 router.
> 
> At the time xfrm4_tunnel_encap_add() runs, skb_dst(skb) has not been
> popped yet and still represents the inner packet destination entry, as
> already used a few lines below to set top_iph->protocol via
> xfrm_af2proto(skb_dst(skb)->ops->family), while skb->len still holds the
> unencapsulated inner packet length. Check dst->ops->family == AF_INET6
> instead of skb->protocol so small_ipv6 works as intended.
> 
> Tested on User-Mode Linux (ARCH=um) with a four-namespace IPv6-over-IPv4
> XFRM ESP tunnel reproducer across a 1300-byte MTU router link with ICMPv4
> Fragmentation Needed filtered (verifying 1280-byte inner IPv6 frames fail
> before the fix and pass via outer IPv4 fragmentation with the fix, while
> larger frames still preserve outer IP_DF), and verified all tests pass in
> tools/testing/selftests/net/xfrm_state.sh.
> 
> Fixes: 6821ad877034 ("xfrm: do not set IPv4 DF flag when encapsulating IPv6 frames <= 1280 bytes.")
> Cc: stable@vger.kernel.org
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Assisted-by: LLM
> Signed-off-by: Sewook Seo <sewookseo@google.com>

Applied, thanks a lot!
