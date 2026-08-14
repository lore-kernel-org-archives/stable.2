Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADF2F7F17
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685492; cv=pass; b=VPyeSbwFKC8zvRj1sF/gcrn1Jar09XvNb07SCKMdN7JaRTVtzajK6ycDw/nXqs4Hr4+awW3S74vgxU/tv4uo2ftVRy5lCtLPg6zOrtW0FeArUiChfU7+Bdc3xb20/MEEsz0KCUJWiYg28TDgNJcUb9J3jm6hnKAmgDPIR+Fm4Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685492; c=relaxed/simple;
	bh=dk806SjFpPH8NpVBblIdKzY6q05TLQru/qiEollp5rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ProbY3YVOGsHwla4Uc8093FMeaX3TpeAEt6g82oOW9KMyRdjk8UMNTc6QLu2itv5EIQjlbgXuXiGbB9jblV81v075TqWpjxttThgvfPUaGBQfJi0dVxZeXHPzAEisbYNahQ1Iprv+U3ZaPHqhJ49GrOLkvAg/PQ/d0+D7z9+77g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=GDaRLRfh; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="GDaRLRfh"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso665391a91.3
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786685489; cv=none;
        d=google.com; s=arc-20260327;
        b=SyZrU8qdX+cHIZj/WKbANfVU/Zv3P404RXZGpsJVClLYquE05NBSf+uD6j8SXQXl3X
         nXvkAKKpjWfo6pLkwT2u0r8qrT/50xO25vEJXsraNmiCFoGBDmfHDeU2e/8z8MwCXZO9
         CL/vS/+kqepYB12wyOSNPtyUUVy+jjqzh04uxmNMaxFRya9rSWZqme/yzSVaN0Grvp+v
         7tDUxYwkyfwc9Yu670NZx511ZQHFzwVhHieFZJv4vnZ2ZD39hG7bby2ZRzrL4zTinYBe
         O5MEon/i/mPkS+CwCTbJlRrcvI1+Xt8WNC8aXuf+ovLxvdMjJgl1ErpOXDww5Z0+wY0Z
         HYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=byOxXmNFwQEwsCB1id9Tfj2UmoFKRHfsfny+Jto1cVU=;
        fh=UNcIV2RxRIB5HIeOD7LqBzPazMftQ7tHEnP3yKGQkfE=;
        b=HhDjyWiTQ47mTMMPNvvg2/GP+BBV5CfMLSWWMlEFvrWZ4lBERFhuT7qZzm3Nyz4qmR
         fb7e0c2YImP2HRaGhqcCG8QxxvMTsgUuozzMvYLRum4DtZMTiphEvDHQg6QnDKU8xP1w
         vb6YCBHhtsfU8SkAurzft4pW26Dz46h8WsKAy64/37lS/HqOGhtakb56TwyyMqSZAUem
         T21f+NTNdG+ykaxXcj9YcC734indktl5O1GrGhkGJ4X9nflpECuAPr0do7klCTlsyb9q
         JzTBQZkHdR7t9Avzq9Ko1BXf+SsQmSk8VJ9UuySQFluf0T18z5BFKY+jNCLJk77KmrR+
         k54w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786685489; x=1787290289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=byOxXmNFwQEwsCB1id9Tfj2UmoFKRHfsfny+Jto1cVU=;
        b=GDaRLRfh7DV9k1AuwzbnXKMLTm3QEt+b2WULffiru3j2Q0aXm68Q4UU7yeKx2btcD/
         svVopxw/6JSPLOfC48mvW/Dx/KtzZQjeiecFtDAE8UC+AviblPrAMTx7epsQMxYaho6r
         dScVg3TIDfhwz1Srv0gsUaqJvV3wlEfOn+ZfVj5mjL2XRIU+qz13EJHOiHjDrLOrkH2j
         pSKKHacPp/SoLZpCz4EoHFlXVgX7bBSPN5Wqc0Y97OnIjgBd/P0rfGGYgCI9RrFshgml
         Fdbis8QPS6Jk4M+4AHAyieoREZfdAt8Gvj0q4/r8jGZ8AdZI+Y1VCepklQ50d4P0r4pf
         5caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786685489; x=1787290289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=byOxXmNFwQEwsCB1id9Tfj2UmoFKRHfsfny+Jto1cVU=;
        b=rpblfaGcB7Jl7+KOOsVI1S94Ypfz6lLxzXWBzLuS1967M3e26rtWCzdLGTtGF1O6QO
         eZoy22Q4eJ11zkKROEuueXOaPCqpWnEvfS3BrlwQbmhdOHWMMBbeK2Gs/VwLJTZ9AOjT
         3aWMtCViACOp9raqwn+d0A6iDZJQPcXo+ZePzg9WT8HEPwb5YTNJRqbrxAomHaEXSrT/
         VZ8rzQXTzARByzOQ68H6yZkV5mWcT8BUlxPezX3xNLO/LftriM/gVdp9DtMoyZxtvxDG
         De+fGApZHVRSjdq80ko7qxJ+3BpWnpzAy3R5q1hPflHArIPGeFR3jWTXAZejxURWRzID
         AO5g==
X-Forwarded-Encrypted: i=1; AHgh+Rotf7/AS+uXK0M0C4q69B3DA2ZyNyics4P+P+Au+Do+AWM78z4Ou7k6KE3dq9pQm/4YHXiU9z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7camcs5chMU9E2TKzPzLVCUJkCAPSXT6AOp06ivQGrczsXDm4
	gybFbUVDx5FEOoIk5P68D6/K8mJlHP5wX4EE3GunslJGJv1pgnQu697gKuiwAFmQw0knPRZxiaw
	Jl23AqDMd/5MzTsE8G3QMVPNw2Z8PdGGrQsjLglxP
X-Gm-Gg: AR+sD11Te/X1InSiylH2DKm3JCH+iZmy4snolIt9A/vJHRAIcuCbeXKY+1vW8J70/o6
	UDyXKUGvmHB0FKMMbEuM9VCbIeFUhdTi+l0s03fagJtp6UgGgP5Q4cfLoN69gLDp63RJUFqIAfE
	YLbsV5lQ+FuCbtd5waV3G7YjWWipq69bAjqTQVckOrPd9+QCf2xdWS2lNZwT3scw59frnzR0jw3
	PhKuNHBg/uZM3rHYIIkUHE2T20a/YOCDQAJ4OTH1t5q0pxuS3btwOzpNrWHQSywNIrJD6nuRKjY
	t0wxb7fkoHwyWP0NwPq+RZwAuqkVCC8tDxXBMk7DbHZyRA==
X-Received: by 2002:a17:90a:ec83:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-3933b8c1041mr3685605a91.16.1786685489453; Thu, 13 Aug 2026
 22:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521200859.816b8923b5f27bba6124461e@uniroma2.it> <20260814052541.1198373-1-xmei5@asu.edu>
In-Reply-To: <20260814052541.1198373-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 13 Aug 2026 22:31:18 -0700
X-Gm-Features: AUfX_myIgXG-OsLrFyLRWQjjcH7O6vsQUmJd4IgyhW0PB5LEPUCYkeJ32826dYg
Message-ID: <CAPpSM+RCXzepVid2qnPky33Sx4j4uy-gWZ74UuG6E1k3pGsKeg@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
To: andrea.mayer@uniroma2.it
Cc: dsahern@kernel.org, edumazet@google.com, netdev@vger.kernel.org, 
	bestswngs@gmail.com, justin.iurman@gmail.com, alex.aring@gmail.com, 
	davem@davemloft.net, horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	pabeni@redhat.com, stefano.salsano@uniroma2.it, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:25=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> Hi Andrea,
>
> We noticed this is still not fixed in net.  We tested your idea and it
> works.  This is the patch we tested:
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 9c677eb1d1a6..51941ad656a3 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -368,23 +368,16 @@ static void seg6_update_csum(struct sk_buff *skb)
>                            (__be32 *)addr);
>  }
>
> -static int ipv6_srh_rcv(struct sk_buff *skb)
> +static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  {
>         struct inet6_skb_parm *opt =3D IP6CB(skb);
>         struct net *net =3D dev_net(skb->dev);
>         struct ipv6_sr_hdr *hdr;
> -       struct inet6_dev *idev;
>         struct in6_addr *addr;
>         int accept_seg6;
>
>         hdr =3D (struct ipv6_sr_hdr *)skb_transport_header(skb);
>
> -       idev =3D __in6_dev_get(skb->dev);
> -       if (!idev) {
> -               kfree_skb(skb);
> -               return -1;
> -       }
> -
>         accept_seg6 =3D min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled=
),
>                           READ_ONCE(idev->cnf.seg6_enabled));
>
> @@ -485,12 +478,11 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
>         return -1;
>  }
>
> -static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> +static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  {
>         struct ipv6_rpl_sr_hdr *hdr, *ohdr, *chdr;
>         struct inet6_skb_parm *opt =3D IP6CB(skb);
>         struct net *net =3D dev_net(skb->dev);
> -       struct inet6_dev *idev;
>         struct ipv6hdr *oldhdr;
>         unsigned int chdr_len;
>         unsigned char *buf;
> @@ -499,8 +491,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>         u64 n =3D 0;
>         u32 r;
>
> -       idev =3D __in6_dev_get(skb->dev);
> -
>         accept_rpl_seg =3D min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_e=
nabled),
>                              READ_ONCE(idev->cnf.rpl_seg_enabled));
>         if (!accept_rpl_seg) {
> @@ -689,10 +679,14 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>         switch (hdr->type) {
>         case IPV6_SRCRT_TYPE_4:
>                 /* segment routing */
> -               return ipv6_srh_rcv(skb);
> +               if (!idev)
> +                       goto disabled;
> +               return ipv6_srh_rcv(skb, idev);
>         case IPV6_SRCRT_TYPE_3:
>                 /* rpl segment routing */
> -               return ipv6_rpl_srh_rcv(skb);
> +               if (!idev)
> +                       goto disabled;
> +               return ipv6_rpl_srh_rcv(skb, idev);
>         default:
>                 break;
>         }
> @@ -837,6 +831,10 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>         icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
>                           (&hdr->type) - skb_network_header(skb));
>         return -1;
> +
> +disabled:
> +       kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
> +       return -1;
>  }
>
>  static const struct inet6_protocol rthdr_protocol =3D {
>
> We don't want to take your credit, so if you have time, could you send
> this as v3?  If you don't have time to land it, we are happy to send it
> for you.
>
Sorry for my English. I mean, if you agree with this patch, you can
take it (it's based on the proposed version you mentioned).
You don't need to follow our version of imp.

Thanks,
Xiang

> Thanks,
> Xiang
