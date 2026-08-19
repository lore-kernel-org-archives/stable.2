Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1A388E43;
	Wed, 19 Aug 2026 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125797; cv=none; b=OzqW3rKA3A5QdiCXMerqbW6ICH/ZUbFu5AoTn17x+qtm8+PhTsTMMkO/G8Tx7LLTPyY+KFw6LHYhPR08f595nDGlDLlBfcElHSdHqkiljF1NHJ9RBaeYU0tfMTuUP+uAVp80yl3Sls5zk71yR5MMWlVPEX/9OyO/FyZYT1mgAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125797; c=relaxed/simple;
	bh=zRwX6uK2SacFm4nv91jT8PAoqsCsQbtVLhesweaKaxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ubCC2yNeOu8Wj4TJWiwEPY7lmylz5yu9nJbPJRdd+EOqbi8ENJBVm2gPvvFw+hx6JPMPrZvkgG4uHVfPJIkUCvtxAePXYDkimDlYKcTdP85vdsXClGIUtvfTf2jORtOaf4PAxt84hCY+Vo7b16dLzV6S8TIjELWNLNNhyc5I+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=iryU31gZ; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="iryU31gZ"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=U5oTfw5gJcO/xDxQ6cN7x8if7qRyh5e7eVy9/bdqZDI=;
	b=iryU31gZj+cGJwc5wWDV73T2ta0NdlQZQ7sJe/mNv2wztk84OdgoI8rYtYnSGEUQ/Qn4sJsLh
	sHTBA6ucdazYFGiiyBhVaE6vliib3dG4JznxM6TLAppR1aBU7Bg0dT5Rnemf0Ek3AqwdOtYe0jw
	oAr1bMgIjZlZmfy3/qYdoFA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hPz3B0402z1cyTS;
	Wed, 19 Aug 2026 15:39:02 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C7DA40578;
	Wed, 19 Aug 2026 15:49:42 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 19 Aug 2026 15:49:41 +0800
Message-ID: <492adef9-936e-490d-ba1e-3d026ff1223a@h-partners.com>
Date: Wed, 19 Aug 2026 15:49:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>, <stable@vger.kernel.org>
References: <20260811085246.2267779-1-edumazet@google.com>
 <64a0b57c-040c-4703-95eb-886701bdf745@redhat.com>
Content-Language: en-US
From: xietangxin <xietangxin@h-partners.com>
In-Reply-To: <64a0b57c-040c-4703-95eb-886701bdf745@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100001.china.huawei.com (7.202.195.168)



On 8/13/2026 4:49 PM, Paolo Abeni wrote:
> On 8/11/26 10:52 AM, Eric Dumazet wrote:
>> Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
>> NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
>> which dynamically changed vlandev->hard_header_len.
>>
>> This causes two issues:
>> 1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
>>    read dev->hard_header_len without holding RTNL lock. Mutating
>>    hard_header_len dynamically under RTNL creates a data race where upper
>>    layers reserve insufficient headroom based on a stale hard_header_len,
>>    resulting in skb_under_panic when vlan_dev_hard_header() is called.
>> 2. In addition, vlan_transfer_features() updated hard_header_len without
>>    updating header_ops, causing a mismatch between allocated headroom
>>    and header creation.
>>
>> Always setting dev->hard_header_len = real_dev->hard_header_len and
>> dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN unconditionally
>> ensures:
>> - dev->hard_header_len remains 100% static and immutable at real_dev->hard_header_len,
>>   eliminating all dynamic runtime updates and data races on hard_header_len.
>> - Upper layers allocating skbs via LL_RESERVED_SPACE() will always reserve
>>   sufficient headroom for software VLAN tag insertion (real_dev->hard_header_len +
>>   real_dev->needed_headroom + VLAN_HLEN).
>> - vlandev inherits real_dev->needed_tailroom so underlying trailer/padding/ICV
>>   requirements are honored.
>> - AF_PACKET SOCK_RAW network header offsets remain correctly aligned at
>>   real_dev->hard_header_len.
>> - vlan_header_ops is used unconditionally.
>>
>> Note to stable teams: Make sure to backport these commits:
>>
>> e16e960d55a4 ("ipvlan: inherit needed_headroom and needed_tailroom from phy_dev")
>> cef51860becd ("macvlan: inherit needed_headroom and needed_tailroom from lowerdev")
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: Tangxin Xie <xietangxin@h-partners.com>
>> Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com/
>> Cc: <stable@vger.kernel.org> # 3.19: e16e960d55a4: ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
>> Cc: <stable@vger.kernel.org> # 3.19: cef51860becd: macvlan: inherit needed_headroom and needed_tailroom from lowerdev
>> Cc: <stable@vger.kernel.org> # 3.19
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> ---
>> v3: propagate needed_tailroom, add stable tags.
>> v2: https://lore.kernel.org/netdev/20260724035419.1473174-1-edumazet@google.com/
>>
>>  net/8021q/vlan_dev.c | 39 +++++++--------------------------------
>>  1 file changed, 7 insertions(+), 32 deletions(-)
>>
>> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
>> index ec2569b3f8dac629027b4344bc89402decf026d1..2859cbac3f266b7c4e3f44f41280d33ab69c5270 100644
>> --- a/net/8021q/vlan_dev.c
>> +++ b/net/8021q/vlan_dev.c
>> @@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops = {
>>  	.parse_protocol = vlan_parse_protocol,
>>  };
>>  
>> -static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
>> -				     unsigned short type,
>> -				     const void *daddr, const void *saddr,
>> -				     unsigned int len)
>> -{
>> -	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
>> -	struct net_device *real_dev = vlan->real_dev;
>> -
>> -	if (saddr == NULL)
>> -		saddr = dev->dev_addr;
>> -
>> -	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
>> -}
>> -
>> -static const struct header_ops vlan_passthru_header_ops = {
>> -	.create	 = vlan_passthru_hard_header,
>> -	.parse	 = eth_header_parse,
>> -	.parse_protocol = vlan_parse_protocol,
>> -};
>> -
>>  static const struct device_type vlan_type = {
>>  	.name	= "vlan",
>>  };
>> @@ -580,14 +560,10 @@ static int vlan_dev_init(struct net_device *dev)
>>  	dev->fcoe_ddp_xid = real_dev->fcoe_ddp_xid;
>>  #endif
>>  
>> -	dev->needed_headroom = real_dev->needed_headroom;
>> -	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
>> -		dev->header_ops      = &vlan_passthru_header_ops;
>> -		dev->hard_header_len = real_dev->hard_header_len;
>> -	} else {
>> -		dev->header_ops      = &vlan_header_ops;
>> -		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
> 
> Sashiko nipa points to a possible functional and performance regression
> with unusual config (reorder_hdr off):
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260811085246.2267779-1-edumazet%40google.com
> 
> Arguably the current behavior is incorrect, but it's also the
> established one. WDYT?
> 
> /P
> 
> 
Hi Eric,

Gently pinging on this thread.

Just wanted to check if you have any thoughts on Paolo's comment
regarding the potential regression with reorder_hdr=off?

-- 
Best regards,
Tangxin Xie

