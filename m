Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793018069;
	b=UoMjjs9NjA88N4KT3lYXNGISgWnOGmr7hogIJbJ7UAJPQPWndwwVsRDH6q08B87hUQpE
	 wh1WymhubFjb1AEYhCx2vm8vVwBwAretj6JZXQlBQ7gM6nR+n02Q5fnqozGyc3xVtEMQr
	 Q19+5loeA8/HR8YzpOVdq/8kWPp2/ccIaStqDUmhOAVsrqn9zBqYhTb+8re4lJTd6A/6a
	 e3DdGvL1Bp2jGRp2AEojK4wnnPwBHZPr5P/qCRNe5yfhyp4BTKaofZiHIpak/vYRha3rg
	 I+adYItrKwLHauFdJCZymUlRSkIKs96Dcz4WL+h3dN9iVYD7/u1/BHjnX86n9zVqdPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
	b=zK8LCSV2W3iYIUiCHMk5RaVbi6qvs8h7hPUVTRggxHNTXCaG70CetjwXTD47nxaZBgpo
	 G9d1RKInc26Ev7uYN5RC3DRRhs97kCm3vOaW8mCVKZ7QSFy/0/z9vQDBU7McaNJ3WvTcZ
	 Xip/E5FXp2Y/uQC+H1zj3w6mFql1V/YhHQCt2KKV1JbviByQNVVsR58iV3EKcGxRf6TsP
	 +kJwCybtyYBjvu2JimUexbrwiHrixiWumZm6PGRTB2MNvSHhGd5Wne3+fWp6Q43ANw7CM
	 c/yL6fLwPNL5cNkP95cZ6v+8mMoKjFqG9IIDC3VC4HGTcjIgQknSitRs5spQ6Ny4Zyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HdtFncM0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF2606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CF2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HdtFncM0
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8246b13cbso25484115ad.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018068; cv=none;
        d=google.com; s=arc-20260327;
        b=rO/wK/p7RnvtplkPlQvboQoCUZNN8eqqKdnu5im2dlzPC77xrFnDoyKqnbZlLlzaG9
         FS1QSN44HkLjnFs4zRehpbxy6go4EU8OqCpo4NjNfyMlTBLR3rhMe4lU4LtjS28BNLeo
         hDg5JpgObeL8bL1tDPCEGCIPSV3jhqBIfvh2GSrlCQ+KjtdRzCLKeg25Z9cOD1W9Pgk5
         +dzOUM7FQ2oQK1IJXKUksyholITKBNOqBXgTrNqCwzgrSI0x1QDz83yda5fKJhpUNtKL
         lFD++X/PVKnLucvyliKu2mtX71SaMdnOLskgeyCJpurbaGEGtrDF6LUzT/MOfTKtWE7F
         eKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        fh=fl3eMEkoPHoGF+6cqErcuEJ6NNptgYjIlOO/ZPJp+Fg=;
        b=MyBosEGIcPFZQkpMB1dhpdlMN2t6H1uKXWHvW2TIPd5m+4f2mtHds965Xf4hlrLfLF
         4/33V/Hrhj86XAe8ouGypVhtQ67heUDnid2448ke/98vHteLVfcM0d+ZXX4N11JCvn2T
         U45FdnyuyuIiA9SMl0O/jSc4ziYVp2XOZ1P5p8KAK25OjM+OGQVnD4eGylSpumA/+0t+
         tdTi/Oitdtyh0G/Rtl6jHs0ErvjR95B2nWIg1VkS6/wLSaEwAA/9OCwfd4+H5P5ClaNC
         tjPpbSXRnU8CauLYs92qRVjguFYHN4eHhh9391G/lf3jY+UX+bM52zVGMccBAwE9z6G1
         cU3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018068; x=1793622868; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        b=HdtFncM04w4/76lIdgLfZLw/0vgYLnhbPuHclib1LzHCRj0B1KxFZekGEulO7gtq0i
         POQFwKjj3LXA2dcopzYhgWNgZVrCWwBJLkmFGbQaQmsO/c6Q1q4XO0ouSL8XC7x45/dG
         um54EGBS+m6o8La2GkzbOUNBl00ocendPMUC4FY8qPvHfiBE14TfsV8EHQymgVVUgUJ3
         rCQ0Q8nLVU2lfnQDMCfYtUF915/7YSDk499Rh45X2gFlBYLHwdKfTlBzUSIQrxjWe4tU
         Bnwlr+e+VjVQX273sUjj3mClGgrORgkouFyUX0sQzGugEhDMrQrX5xTow4oT9R47UA2T
         JfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018068; x=1793622868;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        b=QK1XufVJGlLYwT277K0Z1AufTUXdN5ysT6FYNCixlM9kCKJwMylOh8S4d+V4BtMDFR
         l3ZA40fR13668xds+IkpaiEQu29MBwCAkndR5agwX/4cQYatabmN7mZ+pT+Gqbp4tQX9
         +oPE9KEexwcz+MVowY1BGN6AGvRDE6VdjGM0sUZ2NutYGz1I5AeAxMlKveMqPc+dSGVQ
         jSCf1WQFJD24H1az4utTH/3jap5FyFR9Fi8Uv9YSDtRa5fzx2k5kxEZVRTSU3Daqprlt
         CMvnh0ARkUlcJbrs4wSIbB/Gsq6dc4n9L84QgP2vm4nOcdZOvqaU6eTuTzsJNmc6PnxA
         YQaA==
X-Forwarded-Encrypted: i=1; AKwUvBwUTLUJsjIA7oXIuqmhPn6ak7RCZoESxXS292WSELoL6JwCgCgsE3nYT9kwKLeQmM4PhOuw118=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoP/Pdu7XTzIYSzvft8MKvEkrsB4LK2oATcx3m6BQZ65lmmAer
	ndouHbAWG5TP0nbUR0r3Yz36dfpB8pkpqeKu01NaXH3Gyb1U3Mnm0HRqdNqhhpK4SXNtqD6OQxz
	FM84bjvQqm7j17YQkW5K1bByqcpWYGTk=
X-Gm-Gg: AYBFou2KWmNF4v99AoJxkDPLc1Hn9kyc2TJr2/z2IaFhhNMOXzVU5keBglSxxs8m2mV
	yo37Zi39NDIFu8ZsdMBt1QNcXzHzKhG4LkoqtzNey6kBc9NV3+9qfvfgtOKcQV5MkkP/c43V44N
	OEZaWDFlsuT4NRpXKi2h48aIITwMIMIWeNK684P7NeGdiGIDesVy1sV6RY3GifGKEY2N8uFDP8u
	LncLSPZ81bJ3mxnSHKpg9IaUI5gLOQqnuPqgKiGZ5wsSB3ls4jfQTR8eNhiMP7WAXr4dJUALBnd
	SVMeDIuCnLkSFY+C4oPovURdqM0E9FnjLdalwerBVnvLGywKh0buPUva3adgYctbi5G+uApMrg2
	79wKJQF7yR2tOgqM+neRwCvAsSgVgwDV6zBHTiss=
X-Received: by 2002:a17:903:3ba5:b0:2ea:33eb:7375 with SMTP id
 d9443c01a7336-2ea9c7fb26fmr60059095ad.45.1793018067828; Mon, 26 Oct 2026
 05:34:27 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer>
In-Reply-To: <at82NLzM7g8HGgum@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 26 Oct 2026 14:34:15 +0200
X-Gm-Features: AclHuK86Nf4MoOy1SZ-DK_sdM59j4Q0Ek644A1GPV_2QYD872VpQvocWDHsm21I
Message-ID: <CAJ8uoz0bU0ETmEp0Nv9V4Q-H272D9dmyuK8vFj+B_un-rA4VoA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Rongzheng Wang <testwrzwrz@gmail.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 13:32, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, Oct 24, 2026 at 10:11:56PM +0800, Rongzheng Wang wrote:
> > When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> > calls skb_checksum_help() while only the first descriptor has been added to
> > the skb. The checksum therefore covers just the first fragment, and
> > skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> > fragments are never included in the checksum.
> >
> > Move the software checksum calculation to the point where the last
> > descriptor has been added to the skb.
> >
> > On a checksum failure the packet is now dropped instead of being returned
> > to the application for a retry. This path is not reachable with the
> > existing metadata validation, but the behavior change is intentional.
> >
> > Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> > ---
> >  net/xdp/xsk.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 33475b180ea6..65be2a368325 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >               skb->csum_start = hr + csum_start;
> >               skb->csum_offset = csum_offset;
> >               skb->ip_summed = CHECKSUM_PARTIAL;
> > -
> > -             if (unlikely(pool->tx_sw_csum)) {
> > -                     int err;
> > -
> > -                     err = skb_checksum_help(skb);
> > -                     if (err)
> > -                             return err;
> > -             }
> >       }
> >
> >       if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> > @@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >       return 0;
> >  }
> >
> > +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
> > +{
> > +     if (!pool->tx_sw_csum || skb->ip_summed != CHECKSUM_PARTIAL)
>
> If i am reading this right check against ip_summed is a way to tell that
> first frag had XDP_TXMD_FLAGS_CHECKSUM flag set.
>
> Agreed with Jason to preserve unlikely() when checking pool->tx_sw_csum.
>
> Regarding skb drop, I am leaning towards this, I don't see much sense in
> retry when packet is malformed? Not sure how this could be communicated up
> to user space.

Do we need a new error statistics counter, e.g. tx_malformed_packet or
tx_invalid_packet? We do have one for invalid descriptors, but that
does not really apply here.

> > +             return 0;
> > +
> > +     return skb_checksum_help(skb);
> > +}
> > +
> >  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >                                             struct xdp_desc *desc)
> >  {
> > @@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
> >               if (xp_mb_desc(&desc)) {
> >                       xs->skb = skb;
> >                       continue;
> > +             } else {
> > +                     err = xsk_skb_sw_csum(skb, xs->pool);
> > +                     if (unlikely(err)) {
> > +                             xsk_drop_skb(skb);
> > +                             goto out;
> > +                     }
> >               }
> >
> >               err = __dev_direct_xmit(skb, xs->queue_id);
> > --
> > 2.39.5 (Apple Git-154)
> >
>
