Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386857;
	b=CgJ3YU/3U3Q7V45kE+BflsYHBkGSyRbJVF6aEDtyLu1mxj+7jErV1aQz3Dbd+6Kk5wMO
	 hTs2blpWtPdzTT2rOh+yDFWvDTPI8K008bohqQPxdrS/9kKMa6FUgvqFciw4oF+/JaHVO
	 mz8vVNhsG6Pjw2fEbXxFSXwdbJVQvuVOG0cAQT68KliXzxNkg+ZrPtONGr01dvEIHBtyw
	 f/M5OiEN2r1SljaIDZ3vq5fqpO0EFxGOfIGEdrilSc/ZgPP8aqiDKSI1Il0jSEDzH99O1
	 s3zivTRAk9/L4IyaZ9T/16gycPpqyGfObvrbJAVOPYVGgQGADxA9TQwLOUZwWpgwHEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
	b=Ed3REbHPsmRnp7rrq+pa6AxkL2quX/e0OXjCR/xvR/K60w/TlRUleTWNLbrC9CIx+Vnd
	 Dd/9K8+08LQuPS9ZCQHaW4KXlz/9IcL/F4ekVyragVTEEN1Sq3IUtrFxBZgkE1v5Nqg5z
	 wDbDbsNXWc8YmbI64/BrqkIglHPrTEhDp6V3nGdYnR95lM2enZGlo1nBAWksbrE/Q9cAH
	 zWLwROpm7XdavNKuQEiKFg/GQPYf63gxQkx3kXM0tbnwZv3ijRwkeQ385doysTDatf7x3
	 +GACTbgepugEPcrbbpDdPkTq6NjGDbtDMvnaFgWT0ApgXzxgoEtb41BP4OWRwlqzVxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vv2Hs2Kr;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C041606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C041606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vv2Hs2Kr
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b1afdf5196so352796eaf.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793386855; x=1793991655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
        b=Vv2Hs2KrFjB/loc09g6ZDMIoKgPelY786FvhRMM9uA+vQNMaNG+psgdLdAaCabhE0M
         67N0AOsBjfxA5a8mh6L30HG/LYLiVuCL9qJdxQH00EHJy4n0j/UbEeEwvb2QWh8hzk3D
         Abkauv0KK6tekxRoO0JPkSt8HuCr5JukTC1iZ2t8gh2X2nQoP1V7CVr6RSkZLzbSskFx
         suVCBUn7WWglGzh/U23lBHfpFIOqJeqcLQ8wOpi065TavixE7Tn8T3XYZfAx0NHX0fTp
         6wHiJMiiq7jPXTV7MB1Lg1ojCm4vQqSUq5batWlXHWGTYo7SHcmzwuFcA8jr8Gw+Co3l
         3rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386855; x=1793991655;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
        b=K1RmfjpGd/vyHofsYrbL50bFRtHsA9deIbJZEOSMW7iTqN0NxmIIiPmpDqwA+AWBcT
         sV0bgTC9eYxdTvZ6jlMYoO+iGCYiieS5UibUVtxzPojavqzk4dpizmqw+6Fh4SmBAGAE
         WZRkIcPCqvle/luFCn+XDa5WkX4qAeofA8rhlCDlVIiwns3jlcPHqUZDc+L8ZkE6NLR5
         U8vIY5JD3mqUevm6ION6Aq9TTZINxjRfOV4Oke9YYnvKJ4g7K1DokS4697t3yBaUPxuK
         SFBdRzv3tKP7MUk5VPhkvfqvxbbr1qIOx0rtBysemFdcqyN+XjFpiYGRvRQuMyaedwG8
         rj4w==
X-Forwarded-Encrypted: i=1; AKwUvBzi09bOQKT+3Y7ExWOZMlNy5jXQPxj58/9o8QlE508TsIhNc6LH0+qLhFHbtxzIzj+xfdadNlU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkPDLNsqskgzgvTrqUXr+DT72sDFDFSOxA8ArIWIQhcFedp+Qb
	7oHZF8NCIVhXHCfwo0f0r8bhm9QbSPq/uiVoPfHoA28FAeNzTBly1L5r
X-Gm-Gg: AYBFou2BIXGfSlN8em3nvVWqQe+AZeRWU7XKNTPLIRQRAuSgfLmZRxvGdhH4d4VVMji
	+3z/enMsyEa0eldoHQKd8m5ngf2taPz3G6am4u14obaTBzOfaKUlqnFwwau+e+1cSWwOxr6ZEYj
	PWyFdggJcORgAYQv+E0go0a53tWdpUI9k5ZC/oIrlNIZS98+mEaAI5dMTSqagqeHrTFW3MhxcHL
	xja6GzaE6NZMubd4IJVywsabuWlIrTsVS0bPZdGIP3Dp2iX+7k7Fj+TI7+HouEPmgKHRsYw7JC4
	S9I0i2Y4+XihAkb+XRiFZyYYJlDj6iWOLMe6HilbvUTC2EMJoqAdN7omcRjYFnLLcPrJ6gvIsKn
	GsRcx+DbDkaP9jgGPvL5RSoA4n8Bf9yHbvW3wpHlQxQV2h6SuHE/bdX5T1Rbhu7PTgBsfdEahsx
	G5jV97dAcPXxhlhtQWMzxyorsgJTx/YjyGK2dGPJoEN7r80Hdv0E1maeaj27mIQmeWanMsdms1H
	J8xWC3tCB3rMqVpcTsL8P037KTEJ+C+xjE/qXuAAZVZQQX6gegSDyiaa86Rm965I8TKlyWqigSz
	BPqC+Fit8b5CM86rhZzrL0PGlD/drFgzPNrykh33vEK7EbtJV7A4oW+DgP6tQNS0mIc/ptWBtK+
	lKy76ElWOekRjYeGlew==
X-Received: by 2002:a05:6820:8582:10b0:6d7:3933:461d with SMTP id 006d021491bc7-714f29a29a7mr1457363eaf.51.1793386855141;
        Fri, 30 Oct 2026 12:00:55 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316:4bf6:e4d9:c6ae:de64? ([2600:6c5c:6b00:316:4bf6:e4d9:c6ae:de64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f3190fe6sm2430468eaf.14.2026.10.30.12.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 12:00:54 -0700 (PDT)
Message-ID: <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
Date: Fri, 30 Oct 2026 15:00:51 -0400
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matt Vollrath <tactii@gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Alexander H Duyck <alexander.duyck@gmail.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andre Brait <andrebrait@gmail.com>,
 stable@vger.kernel.org
References: <20261028170239.28606-1-tactii@gmail.com>
 <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 12:47, Alexander H Duyck wrote:
> On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
>> When an skb arrives at the driver and the header length exceeds the u8
>> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
>> are sent to the card. If TSO is enabled, some header lengths will cause
>> the card to hang.
>>
>> This was reproduced on an I218-V with an unprivileged Python script.
> 
> Can you elaborate on what the script did to trigger this? I am
> wondering if it can even get there with a valid frame supported by the
> interface since most of these e1000e parts don't support tunnels and
> such.

I will send you the script OOB. To be clear, this is a security fix,
not a correctness fix for rarely used paths. The rules say I have to
post the fix publicly because an LLM found it in a
function-by-function scan.

> Also did it have separate cases for the CSUM vs the GSO? I would
> suspect this is more a CSUM issue than a GSO issue.

I have only reproduced hardware hang when TSO is enabled on the nic.
Otherwise it likely just mangles the packet, but I have not confirmed
that.

>> Fix it by disabling GSO and checksum offload when the header length (and
>> checksum offset) would exceed the field widths. Compensate for a
>> software-inserted VLAN tag.
>>
>> Because of a quirk in the ordering of ndo_features_check, the skb's
>> transport_header field may be stale. If the skb carries
>> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
>> no reliable interface, so don't offload it.
>>
>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> 
> I am pretty sure this Fixes tag is bogus. This is the introduction of
> the e1000e driver which was in 2007. The ndo_features_check didn't
> exist until 2014 sometime after that if I am not mistaken.

My understanding is the Fixes tag should point at the commit where the
bug was introduced. A comment on the Cc: stable tag indicates how far
back the fix can backport. I didn't bother because this patch should
apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.

> Much of the complexity that enabled frames to build up massive headers
> wasn't until much later when the network tunnels and OVS started being
> added.

The repro script should work back to 4.10.

>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 6f85dab5c55c5..370776657d100 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *netdev,
>>   	return 1;
>>   }
>>   
>> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
>> +					      struct net_device *netdev,
>> +					      netdev_features_t features)
>> +{
>> +	/* Do not offload packets whose header lengths exceed the u8 fields
>> +	 * in the descriptor.
>> +	 */
>> +	unsigned int hdr_len = 0;
>> +
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>> +		const struct tcphdr *th = (const void *)skb_checksum_start(skb);
>> +
>> +		hdr_len = skb_checksum_start_offset(skb);
>> +		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
>> +			hdr_len += __tcp_hdrlen(th);
>> +		else
>> +			hdr_len += skb->csum_offset;
>> +	} else if (skb_is_gso(skb)) {
>> +		/* Work around untrustworthy header offsets in this case. */
>> +		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>> +	}
> 
> Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
> the frame must not be TCP/UDP GSO since for those normally the checksum
> and offsets should be populated. Have you identified cases where we are
> seeing TCP/UDP GSO w/o the checksum being set up?

It looks like this particular case is never reached by normal traffic.
It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
hostile or niche setup.

When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields are
used for csum instead, or left zeroed.

The transport_header field is unreliable when a packet is being routed,
so you would need to parse the packet from the top to find where the
transport header ends.

Rather than walk all the headers for hdr_len, it seemed prudent to just
categorically deny offload for these exceptional cases. I could be
convinced otherwise.

>  From what I can tell it looks like the only valid cases for it not to
> be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
> FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
> anyway.

FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e

>> +
>> +	if (skb_vlan_tag_present(skb) &&
>> +	    !vlan_hw_offload_capable(features, skb->vlan_proto))
>> +		hdr_len += VLAN_HLEN;
>> +
>> +	if (hdr_len > U8_MAX)
>> +		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>> +
>> +	return features;
>> +}
>> +
>>   static const struct net_device_ops e1000e_netdev_ops = {
>>   	.ndo_open		= e1000e_open,
>>   	.ndo_stop		= e1000e_close,
>> @@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
>>   #endif
>>   	.ndo_set_features	= e1000_set_features,
>>   	.ndo_fix_features	= e1000_fix_features,
>> -	.ndo_features_check	= passthru_features_check,
>> +	.ndo_features_check	= e1000_features_check,
>>   	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
>>   	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
>>   };
>>
>> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5

