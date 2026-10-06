Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974E388878;
	Tue,  6 Oct 2026 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324007; cv=none; b=W4MLzP1GD5Hv6aAk8Mo96Nn/H/BqhLpto30rzW17m0rlFXWqJkXMlFZn3/zQrU42/loxSLeUm7XBP4FqKl1Gar7+UtJApAs36F5HyaQmEqV+mDCq9F3rdlY/ywuCZSvyGW88OEHsw2zdJnEwXWCr1qx8U9DRSpu0SWwEwqzuzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324007; c=relaxed/simple;
	bh=brk0PvIILN+5DqrtGOIk4U1m9qBEHZjx6IWEAQIa1Cg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=utq7+91PeSfjHFB9VPsY2DDxkxzK4HjkgQAZSSNhingFsOXf4fBKuvPxog5ksrc1rFDOF02XJ3w5NN4HeBnGcJrnvYrRdovatTxMwZ/lUH8wZgh+hOQVP3vEah/t361kJo5IzekCw4zqTEthcjKz8PHMR/0GPstea1LOZXMN/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4GcnhcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4GcnhcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504791F0089B;
	Tue,  6 Oct 2026 22:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324005;
	bh=JAZHPiWR5j0jM9LKWbiM25hgRJqvybtekBb6aLKSHzo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=m4GcnhcUYgBwZ6K14h3yjXkKTj+kIYHqfuu5yHLdsAW/rqpjQqgqrwz3dlpq8lRCa
	 wghyJ334cx1DLRUPJxIFoS2BUuvrOWdNlf6XzfPR1o0KspnjmgUNIDliMzPVvYtECV
	 3ACnyslLEn/L3qt7mKKPrCry2WYenGbw17OuMj1zDffsNMxOYXghqQyqOtw3yDrDm4
	 tW9opOQV9SxyFSHPdKuIH6TbV9Hvj2crP3D02yauTPvIk1muxOafItivOzyFAUACWH
	 XhWvhLy6wteaEuPVuvh3ZOzw48oES5gQHKrG+IlA4+Xllz0A4h8603VNkU6lPox3gc
	 1kmoEASKNPO9w==
Message-ID: <4c98eff5-c8c7-43ee-b59a-adb833978816@kernel.org>
Date: Tue, 6 Oct 2026 23:59:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
From: Eric Dumazet <edumazet@kernel.org>
To: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com,
 Sasha Levin <sashal@kernel.org>
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org>
 <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
 <CAL4WiiqSmW093PDngLrUNiNA5GVKeM3+tAO7KMDJeyjYZ7GRzg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAL4WiiqSmW093PDngLrUNiNA5GVKeM3+tAO7KMDJeyjYZ7GRzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/6/26 20:16, Eric Dumazet wrote:
> Le mar. 6 oct. 2026 à 19:07, Eric Dumazet <edumazet@kernel.org> a écrit :
>>
>> Le mar. 6 oct. 2026 à 18:27, Eric Dumazet <edumazet@kernel.org> a écrit :
>>>
>>>
>>>
>>> On 10/6/26 13:45, Jan Čermák wrote:
>>>> Hi,
>>>>
>>>> the Home Assistant OS recently shipped kernel update from 6.18.39 to
>>>> 6.18.52 which was followed by a bunch of community reports about fatal
>>>> network breakages [1] which had one thing in common - r8169 driver and
>>>> configured VLANs. This manifested as network stall early in the setup
>>>> of the system with dmesg events like this:
>>>>
>>>>> r8169 0000:03:00.0 enp3s0: NETDEV WATCHDOG: CPU: 7: transmit queue 0 timed out 6125 ms
>>>>> r8169 0000:03:00.0 enp3s0: rtl_rxtx_empty_cond == 0 (loop: 42, delay: 100).
>>>>
>>>> As there was no change in the r8169 driver itself, I focused on the
>>>> vlan subsystem, where AI pointed me shortly to this suspect commit in
>>>> the range: 1517d1996b5236fe69eccd9d253f725e06996eb1 ("vlan: fix
>>>> skb_under_panic and races when toggling HW VLAN offload"), added in
>>>> 6.18.51. I'm not referring to the mainline counterpart below for
>>>> regzbot (447cbe95ebb9) as I can't confirm whether it triggers the bug
>>>> there as well. FWIW there was another issue [2] with a similar
>>>> combination recently in the regressions ML but that one seems
>>>> unrelated, as disabling EEE fixed that issue, and it doesn't fix it
>>>> here.
>>>>
>>>> I don't have the hardware myself, I asked for testing with this commit
>>>> reverted, which confirmed that this change indeed started to cause
>>>> trouble. However, it's obvious that the change itself is not bad, as
>>>> it fixes another issue and the regression is scoped to very specific
>>>> hardware/setup combo.
>>>>
>>>> Besides the revert, following workarounds were reported to fix the
>>>> issue as well:
>>>> - Disabling TX checksum offload with `ethtool.feature-tx off` in
>>>> NetworkManager for the connection (HAOS doesn't have ethtool binary,
>>>> hence this option instead of direct ethtool command)
>>>> - Enabling REORDER_HDR with `ip link set enp1s0.100 type vlan reorder_hdr on`
>>>>
>>>> Clearly, this needs rather esoteric setup to trigger the bug - I guess
>>>> most systems set the REORDER_HDR flag by default, however, due to some
>>>> legacy in the DBus interface that HAOS stack uses to configure the
>>>> network [3], it was disabled. Anyway, I think that disabling it should
>>>> not lead to driver breakage as we're seeing.
>>>>
>>>> So far it appears that this only affects RTL8168h/8111h, XID 541 -
>>>> there isn't any report of another chip/XID combination yet.
>>>> Unfortunately, as I said above, I don't have the hardware available
>>>> for testing but I believe I'll find some community members who'll be
>>>> willing to test a proposed fix for the issue if needed.
>>>>
>>>> [1] https://github.com/home-assistant/operating-system/issues/5019
>>>> [2] https://lore.kernel.org/regressions/353419280.954808.1790290283530@mail.yahoo.com/
>>>> [3] https://github.com/home-assistant/supervisor/issues/7248
>>>>
>>>> #regzbot introduced: 1517d1996b5236fe69eccd9d253f725e06996eb1
>>>> #regzbot link: https://github.com/home-assistant/operating-system/issues/5019
>>>>
>>>> Cheers,
>>>> Jan
>>>
>>> Ok this NIC can not perform tx csum offloads with vlans.
>>>
>>> opts[1] only takes TD1_IPv4_CS and TCPHO (Transport Header Offset).
>>>
>>> There is no IP header offset field in the descriptor. The MAC assumes
>>> the IP header starts immediately at byte 14.
>>>
>>> So we need to change vlan_dev_hard_header() to take into account
>>> vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)
>>>
>>> Can you test the following patch?
>>>
>>> Thanks!
>>>
>>> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
>>> index
>>> cb8f3cdbf1f732c55a8a3d69ab5445988c953205..3a518ff064465e8ab978c66a28bf7df579931256
>>> 100644
>>> --- a/net/8021q/vlan_dev.c
>>> +++ b/net/8021q/vlan_dev.c
>>> @@ -54,7 +54,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb,
>>> struct net_device *dev,
>>>           u16 vlan_tci = 0;
>>>           int rc;
>>>
>>> -       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
>>> +       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR) &&
>>> +           !vlan_hw_offload_capable(READ_ONCE(vlan->real_dev->features),
>>> +                                    vlan->vlan_proto)) {
>>>                   unsigned int hlen = READ_ONCE(dev->hard_header_len) +
>>>                                       READ_ONCE(dev->needed_headroom);
>>
>> Nope, scratch this. I need to spend more time on a proper fix.
> 
> It seems this code is not needed anymore, and was the source of many
> bugs anyway.
> 
> In modern Linux, core networking already has validate_xmit_vlan() in
> net/core/dev.c which handles software fallback tag insertion right before
> ndo_start_xmit when the lower device lacks HW VLAN TX offload.
> 
> VLAN_FLAG_REORDER_HDR should be an RX option (controlling vlan_untag()).
> 
> I am tempted with this (untested) approach
> 
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index cb8f3cdbf1f732c55a8a3d69ab5445988c953205..7c1394ee2a653706c42f1b970e13664583d1cf36
> 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -49,47 +49,14 @@ static int vlan_dev_hard_header(struct sk_buff
> *skb, struct net_device *dev,
>                                  unsigned int len)
>   {
>          struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -       struct vlan_hdr *vhdr;
> -       unsigned int vhdrlen = 0;
> -       u16 vlan_tci = 0;
> -       int rc;
> -
> -       if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
> -               unsigned int hlen = READ_ONCE(dev->hard_header_len) +
> -                                   READ_ONCE(dev->needed_headroom);
> -
> -               if (skb_cow_head(skb, hlen) < 0)
> -                       return -ENOMEM;
> -               vhdr = skb_push(skb, VLAN_HLEN);
> -
> -               vlan_tci = vlan->vlan_id;
> -               vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
> -               vhdr->h_vlan_TCI = htons(vlan_tci);
> -
> -               /*
> -                *  Set the protocol type. For a packet of type ETH_P_802_3/2 we
> -                *  put the length in here instead.
> -                */
> -               if (type != ETH_P_802_3 && type != ETH_P_802_2)
> -                       vhdr->h_vlan_encapsulated_proto = htons(type);
> -               else
> -                       vhdr->h_vlan_encapsulated_proto = htons(len);
> -
> -               skb->protocol = vlan->vlan_proto;
> -               type = ntohs(vlan->vlan_proto);
> -               vhdrlen = VLAN_HLEN;
> -       }
> +       struct net_device *real_dev = vlan->real_dev;
> 
>          /* Before delegating work to the lower layer, enter our MAC-address */
>          if (saddr == NULL)
>                  saddr = dev->dev_addr;
> 
>          /* Now make the underlying real hard header */
> -       dev = vlan->real_dev;
> -       rc = dev_hard_header(skb, dev, type, daddr, saddr, len + vhdrlen);
> -       if (rc > 0)
> -               rc += vhdrlen;
> -       return rc;
> +       return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
>   }
> 

Note to testers:

My LLM agreed with the change in vlan_dev_hard_header() (above), but said
that no change was needed in vlan_dev_hard_start_xmit() (below)


>   static inline netdev_tx_t vlan_netpoll_send_skb(struct vlan_dev_priv
> *vlan, struct sk_buff *skb)
> @@ -106,8 +73,8 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct
> sk_buff *skb,
>                                              struct net_device *dev)
>   {
>          struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -       struct vlan_ethhdr *veth = (struct vlan_ethhdr *)(skb->data);
>          unsigned int len;
> +       u16 vlan_tci;
>          int ret;
> 
>          /* Handle non-VLAN frames if they are sent to us, for example by DHCP.
> @@ -115,13 +82,9 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct
> sk_buff *skb,
>           * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
>           * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
>           */
> -       if (READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR ||
> -           veth->h_vlan_proto != vlan->vlan_proto) {
> -               u16 vlan_tci;
> -               vlan_tci = vlan->vlan_id;
> -               vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
> -               __vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
> -       }
> +       vlan_tci = vlan->vlan_id;
> +       vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
> +       __vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
> 
>          skb->dev = vlan->real_dev;
>          len = skb->len;

