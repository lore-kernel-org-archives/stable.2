Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624022;
	b=lbQTiglHvOkHVEoaCuIgI4MH+MB+7OvClrWW1gqdUBJmxNoPd4Xf4L5yZdLui+ypxzUp
	 PmA3j1JC2efrPdcYlNR0xsRxGRw6v1TSeAGzyw44n8aNm/dTYqjOZ6mEg07rpZ7tTKMjd
	 yWy01VczSdbebyjJdIbxb9EyR4m7hsY26+yjpRxvjQmribgaQW7JKlXjx5xF/AUnhlzA1
	 WIneFKHuePTPw9cR7RoCO028pxqRAIeSG7qs0xYIr1mp/4DNAu7nHUXw6Zhr2RteOH+Rh
	 b2pc/PML+asn+G5mvBXoYk+7vuN+9Sjr3t9H14K9xmzmtCHlLKVeDuGfsGO/WfxtIgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624022;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy;
	bh=utgq9bat//fpEVEH0lsEK7FcWdN2Zti0FTKHLr/dwVQ=;
	b=D6DPBV8+Uaa/vRjv2XU6SMW23UwTxo0kRWG6adjHaYRiwCfPT9CSTE3QvZBk7lzQZeN6
	 kg3YhH39CHOLCrNK0Lbyql3HfgiMDsSWaibBuTgbCcLCaZLzYjgDtCzDEPDNkIFcPZHqV
	 ONFmRUz2PrOI8XJFSrcAudzSppEwMr9zLK7DCL0icqmXZWfkwcFVRTnRuEOr9Icdg8POU
	 cJwO1kgS2a3CT1m90hmbUvuDMDq0WKP5sRWOn6Zl/uTW03cVSjW0vqgPwcNHDCWqtkbK5
	 mLdv+wHNaaHxp5VrOv59c5qtU5YbRXrOVkU5byoFGSgEPJYKP+28hEeQ0MtKZDYkTqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=RTEKWBHP;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D7D606A321;
	Wed, 25 Nov 2026 16:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D7D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=RTEKWBHP
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A8F812083B;
	Wed, 25 Nov 2026 17:26:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yOeWJnMeHvT5; Wed, 25 Nov 2026 17:26:51 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2A0F320758;
	Wed, 25 Nov 2026 17:26:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2A0F320758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1795624011;
	bh=utgq9bat//fpEVEH0lsEK7FcWdN2Zti0FTKHLr/dwVQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=RTEKWBHP3NpZE/KpxI0XIjiAVuQnDIWSkcCgjWwvOBLlaGAQZcmQtclHAWjx+D8R0
	 wkdOdchz2ABCz58zCEofVSBcBDDHhYtlBB78chyUZy7w4je+vzai6pnbOaEwhR7eQe
	 f2HjIpvQ34/WwZ06CddxdiXTBIXkMcPzX7hnCGSeoPBH+eHXOXNsxhbKjR5UX6qMgb
	 PwR+72F6mpKFq56FBSs5iVz4aaRWu00xFwaNhwx7uvTettTe3Cg4196w6pBKOBdvMr
	 Jor5CnJSKxCavF4F8S+PFoxVji3tAUPMcARJw5fbmyTCZ9v+N1+8aHoLWdoK8oQwIN
	 L9nPVr8Cmefzw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 25 Nov
 2026 17:26:50 +0100
Received: (nullmailer pid 1063354 invoked by uid 1000);
	Wed, 25 Nov 2026 16:26:49 -0000
Date: Wed, 25 Nov 2026 17:26:49 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <herbert@gondor.apana.org.au>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<horms@kernel.org>, <q.h.hack.winter@gmail.com>, <stable@vger.kernel.org>,
	<syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com>, Shuai Liu
	<847807867@qq.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: interface: drop non-IP packets before
 pskb_inet_may_pull()
Message-ID: <awcMSdG_3DBYK-4A@gauss4>
References: <6afdcf01.ca6cd63e.174a34.0001.GAE@google.com>
 <tencent_46F20906773869221623F9FA26275C133107@qq.com>
 <f38e588a-91cc-4ded-a0fa-08f129b1c920@redhat.com>
 <116dd5f4-490e-477d-a5e2-30e3e12d6a41@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <116dd5f4-490e-477d-a5e2-30e3e12d6a41@redhat.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Nov 25, 2026 at 01:24:54PM +0100, Paolo Abeni wrote:
> On 11/25/26 13:22, Paolo Abeni wrote:
> > On 11/19/26 06:08, Shuai Liu wrote:
> > > AF_XDP sockets bound to an xfrm interface submit skbs with
> > > skb->protocol unset (0) and skb->network_header still 0 from the
> > > __alloc_skb() zero-initialization; skb_reserve() only moves data
> > > NET_SKB_PAD bytes into the headroom.
> > > 
> > > Since commit 86de3a1118a16 ("xfrm: interface: validate the IP header
> > > on xmit"), xfrmi_xmit() calls pskb_inet_may_pull() unconditionally.
> > > For such a skb, pskb_inet_may_pull_reason() selects nhlen = 0 for the
> > > unknown protocol and pskb_may_pull_reason() receives
> > > len = skb_network_offset(skb) = network_header - data = -64, which as
> > > unsigned int exceeds INT_MAX and trips the
> > > DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason():
> > > 
> > >    WARNING: ./include/linux/skbuff.h:2856 at pskb_may_pull_reason [inline]
> > >    WARNING: ./include/linux/skbuff.h:3286 at pskb_network_may_pull_reason [inline]
> > >    WARNING: ./include/net/ip_tunnels.h:483 at pskb_inet_may_pull_reason [inline]
> > >    WARNING: ./include/net/ip_tunnels.h:488 at pskb_inet_may_pull [inline]
> > >    WARNING: ./include/net/ip_tunnels.h:488 at xfrmi_xmit+0x1844/0x1eb0
> > >      net/xfrm/xfrm_interface_core.c:534
> > >    RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2856 [inline]
> > >    Call Trace:
> > >     __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:5164
> > >     __xsk_generic_xmit net/xdp/xsk.c:1288 [inline]
> > >     xsk_generic_xmit+0x27d8/0x47a0 net/xdp/xsk.c:1344
> > >     xsk_poll+0x326/0x670 net/xdp/xsk.c:1472
> > > 
> > > The packet is dropped by the pull returning PKT_TOO_SMALL and hitting
> > > the default case afterwards anyway, so the only visible effect is the
> > > warning; reject unknown protocols before the pull to restore the
> > > pre-86de3a1118a16 behavior of dropping them silently via the switch
> > > default.
> > > 
> > > Reported-by: syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com
> > > Closes: https://syzbot.org/bug?extid=d29af9ef5c96a3f5e96c
> > > Fixes: 86de3a1118a16 ("xfrm: interface: validate the IP header on xmit")
> > > Cc: stable@vger.kernel.org
> > 
> > The blamed commit is in the current release, Cc: stable is not needed
> > No need to resubmit just for this, I can drop the tag while applying.
> > 
> > > Signed-off-by: Shuai Liu <847807867@qq.com>
> > @Steffen: looks good?
> I forgot to mention. Since this is one of the very rare regression we
> have nowadays, I would like to have it in this week PR, taking it
> directly via the 'net' tree would help. Ok with that?

Ok. If it helps, take it into net.

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
