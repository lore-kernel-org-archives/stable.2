Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2EC39EB5B
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611003; cv=none; b=pZ7DPhtsFZPwwCynNB09RpQjkSUu4gLpRLjnnzIun5Yf9QShRAHMWshtoMWAz7ttgv0SvrmVYoYk2UwNYLFIIZpyB54HVM1MNC0ulR68vuwS7s2tusLAWN2FoP+Tn5GeWlq7XHHE7dbGZAJii681Ipfdwzu6rEM6xvXDD8HggIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611003; c=relaxed/simple;
	bh=FjEGFFlm88Ei+R5EFTWOJ5+TvUYy5g7LTG3bgKw3bR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUdOlzSJ8/5VTRQvj7Fg8u2RnZ8h5f5lWAdeMGZ1CxDsrsWKz6XVtfQSW/7O9o8FrgCskISfSOmabnElTXvG6FDXHnUBAC67ZmNKQTLslCcP5cHQ2qQdHO6toMdv6cZUBR66rK9+GtfokmdVvMcr76re7hBjtY0m8eIhdMzERBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aerQiDen; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+AaFFmC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aerQiDen";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+AaFFmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786610998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhCeJuOeXQYs6cGlSqtvP+vdZHn0FA++1lLJa9BNjLw=;
	b=aerQiDenJF5XwHQm25XlqBBZbBjOkx9ZZ1cmrd0f9oHFsy2amI4TpPm4Rezby56HtG8pAn
	K5HySyor1TTOS67BT5P3VkKmHfCcZXwfRVALoMh+/EkiWyaMwpGtL6bc9Zowd8e8vDQsmj
	WSCItJQ2B9Zu8rsM+0eBjgWeawF3xwE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-x_SLs0NWNHeyO6PwYDhMtA-1; Thu, 13 Aug 2026 04:49:53 -0400
X-MC-Unique: x_SLs0NWNHeyO6PwYDhMtA-1
X-Mimecast-MFC-AGG-ID: x_SLs0NWNHeyO6PwYDhMtA_1786610993
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4997d718093so10086875e9.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786610992; x=1787215792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhCeJuOeXQYs6cGlSqtvP+vdZHn0FA++1lLJa9BNjLw=;
        b=P+AaFFmCnMZlAYwcVRZq++IPjsaTcFT0oyXuVNumOz+S9h7Phys+StN1Ai95RXcOmF
         PnueJk3FS+y+gSh0X5QRCJR82pQsuUZRnoSu5npWVOFCU7rodDQ0KYxicjDFrmLpLBGc
         EHKbcWlx4JrV8jZpK31PJZbW3XONu+xAaKSFhEhsZvusMXSkm2rHQM8TUH++tbltPkHX
         mWOpyP8u03SBQxH5pWucMbsejuvyTu3sHNzNwA1Pw2fH8jvAXGxO49IGET6CPwPlfEW4
         fMTC8pcpzsM2B4sMnTuUhoWA9Eae99uILVPrOfI6WGKXno0PCrgQuPf1Gt6E7CcH6x/+
         wO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610992; x=1787215792;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhCeJuOeXQYs6cGlSqtvP+vdZHn0FA++1lLJa9BNjLw=;
        b=Ltd8DyYjww2XieOImcoFVhsmvT2WKaBAoapMYD2w2CGxg5glVY8A3xB5gjwpMxp5+M
         P6M2HbP9O/SEQBY/55vjVpU6x+lxI2/85ccNAA83oWVW3rZuC2FFZhh9SmwLPv3Ihhpw
         /stL0qklubzhZf0ghKUL/yq95K4d3NLbIen8d4QUKmMibbjOD+JpSqdDRK+hEql8rwIb
         2kgm0LoQM32vwEf2laF7hXeNfDkavd7j8snKFbGB5rBm+bK5AkVVG7t5U4PeqCCvMRhM
         R+3MyOpUZ/CRd6lvClMon/LTczSNZc0d3pfn0WQrTAVTROfKcZowhN5XcZeWowMRkuxw
         rBzg==
X-Forwarded-Encrypted: i=1; AHgh+RpUy9PhQmuV9X7N7DtPde6u9QeQPkSf4aKDPBFwjl3f5fwZ1L0Izoscit+hMCD/puAJg04r3LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQ6CMDroJKwcMTW38WqoIrA9PL529kBOebPqaTNzon2fWiWnZ
	rsMgowW5yuuyMfLa18yR5+QIczwVPcmTvHYsW/OFLxBiOVHF7IStc1l6gZZz7z1MmX/Jfu/OCFZ
	d/Dfzmq+XKOc9wA+Xiatw2knitTayYRXIgpPU7PqrfnjBdxcxcV4nsE5wPA==
X-Gm-Gg: AR+sD10yw/G2bB81fjifPLNEB7Hd14mg1ENBXCLqOFZO3lAGn55OlHvrLGkjgjFnvOO
	W5SCqZr7fZIA5YpyTkQefcLpw3iLf6qmGKnXcpfVAeSOS265teOB06XmuyIzMDfjFKIDzFrKTD0
	IUNywrE7FM8c9az7RR6LiBKew659ULj9/dhz3FR5K+bU0x1IA/We/P9jeId4ypReumV0t5bwSFf
	0ob5BYD70XhoV0UeziTeOKld/1P7kjoQVX4bheE5QhstDtH0SqWFK/L9n4IsMxqpPJEU99tfEB/
	zaBtB+d1tcZPwjIcasxfGZ5rUKkIfFsjStMncUxzEPXZLeXlbzWwNU3N1BmbV5D2E/aVqyBwVLW
	nxbul1pVNNTmUsYgwddrfYeVWI3DKPebqSKikIzI34YntpNDE3mMBPY0IPqQIUWX8+veYPYKjpW
	4=
X-Received: by 2002:a05:600c:6995:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4998216ad6cmr53122245e9.7.1786610992579;
        Thu, 13 Aug 2026 01:49:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6995:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4998216ad6cmr53121185e9.7.1786610992126;
        Thu, 13 Aug 2026 01:49:52 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998216cf70sm41013415e9.12.2026.08.13.01.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 01:49:51 -0700 (PDT)
Message-ID: <64a0b57c-040c-4703-95eb-886701bdf745@redhat.com>
Date: Thu, 13 Aug 2026 10:49:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Tangxin Xie <xietangxin@h-partners.com>,
 stable@vger.kernel.org
References: <20260811085246.2267779-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260811085246.2267779-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 10:52 AM, Eric Dumazet wrote:
> Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
> NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
> which dynamically changed vlandev->hard_header_len.
> 
> This causes two issues:
> 1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
>    read dev->hard_header_len without holding RTNL lock. Mutating
>    hard_header_len dynamically under RTNL creates a data race where upper
>    layers reserve insufficient headroom based on a stale hard_header_len,
>    resulting in skb_under_panic when vlan_dev_hard_header() is called.
> 2. In addition, vlan_transfer_features() updated hard_header_len without
>    updating header_ops, causing a mismatch between allocated headroom
>    and header creation.
> 
> Always setting dev->hard_header_len = real_dev->hard_header_len and
> dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN unconditionally
> ensures:
> - dev->hard_header_len remains 100% static and immutable at real_dev->hard_header_len,
>   eliminating all dynamic runtime updates and data races on hard_header_len.
> - Upper layers allocating skbs via LL_RESERVED_SPACE() will always reserve
>   sufficient headroom for software VLAN tag insertion (real_dev->hard_header_len +
>   real_dev->needed_headroom + VLAN_HLEN).
> - vlandev inherits real_dev->needed_tailroom so underlying trailer/padding/ICV
>   requirements are honored.
> - AF_PACKET SOCK_RAW network header offsets remain correctly aligned at
>   real_dev->hard_header_len.
> - vlan_header_ops is used unconditionally.
> 
> Note to stable teams: Make sure to backport these commits:
> 
> e16e960d55a4 ("ipvlan: inherit needed_headroom and needed_tailroom from phy_dev")
> cef51860becd ("macvlan: inherit needed_headroom and needed_tailroom from lowerdev")
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tangxin Xie <xietangxin@h-partners.com>
> Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com/
> Cc: <stable@vger.kernel.org> # 3.19: e16e960d55a4: ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
> Cc: <stable@vger.kernel.org> # 3.19: cef51860becd: macvlan: inherit needed_headroom and needed_tailroom from lowerdev
> Cc: <stable@vger.kernel.org> # 3.19
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v3: propagate needed_tailroom, add stable tags.
> v2: https://lore.kernel.org/netdev/20260724035419.1473174-1-edumazet@google.com/
> 
>  net/8021q/vlan_dev.c | 39 +++++++--------------------------------
>  1 file changed, 7 insertions(+), 32 deletions(-)
> 
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index ec2569b3f8dac629027b4344bc89402decf026d1..2859cbac3f266b7c4e3f44f41280d33ab69c5270 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops = {
>  	.parse_protocol = vlan_parse_protocol,
>  };
>  
> -static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
> -				     unsigned short type,
> -				     const void *daddr, const void *saddr,
> -				     unsigned int len)
> -{
> -	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -	struct net_device *real_dev = vlan->real_dev;
> -
> -	if (saddr == NULL)
> -		saddr = dev->dev_addr;
> -
> -	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
> -}
> -
> -static const struct header_ops vlan_passthru_header_ops = {
> -	.create	 = vlan_passthru_hard_header,
> -	.parse	 = eth_header_parse,
> -	.parse_protocol = vlan_parse_protocol,
> -};
> -
>  static const struct device_type vlan_type = {
>  	.name	= "vlan",
>  };
> @@ -580,14 +560,10 @@ static int vlan_dev_init(struct net_device *dev)
>  	dev->fcoe_ddp_xid = real_dev->fcoe_ddp_xid;
>  #endif
>  
> -	dev->needed_headroom = real_dev->needed_headroom;
> -	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
> -		dev->header_ops      = &vlan_passthru_header_ops;
> -		dev->hard_header_len = real_dev->hard_header_len;
> -	} else {
> -		dev->header_ops      = &vlan_header_ops;
> -		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;

Sashiko nipa points to a possible functional and performance regression
with unusual config (reorder_hdr off):

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260811085246.2267779-1-edumazet%40google.com

Arguably the current behavior is incorrect, but it's also the
established one. WDYT?

/P

