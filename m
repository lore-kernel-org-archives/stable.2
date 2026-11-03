Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680321;
	b=MvVqvtEck4zjU0HCRAEGsZPXvyJexPsMaoRq1uAR/yFxJFSCz9w4KUMCfzrzD6VGeZb6
	 ZnODTdZzpU3miLFo3A+TYII6nrDcyUj26BpMUtEnEJyIAI03S7kcJonOzyf8m6THYKr7Y
	 SUErIJUISviVGCOIS80aIUwUQv8dEGZZnjVCTcWKK1iuI82cGzp//AoWpTRp//qxVNUMV
	 R6XpIJYnM5sx5e+IP8uNf8GI7RU5Dwfj/+2xSG1Awk31B9FLXAkQu2cTuS8Xx9knX5pov
	 Nshbc8uqV1rGqZREWRrzlvXHYxvpDtCDtiYTEW30h8GeQuBljN3hzB8mD5/b/M27XhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=K7cNTtUrlw/YMKMwg5CBdynxQMrMR2KfNh32rGFC1ZY=;
	b=W4L0LZ5Sq6/DehInjSRO5v71WUKHylNMcv4ogTVO6dcmHWS/oyIY6YTs7AbsbxmpyJKv
	 jhF7dY90mrWBhz0lzu3dTj2AtMpE9la3SGUG/LfEGHeRU+Ay/G5/ezY32CU8goEx2mx51
	 X7KUJkZN7CCRvjzQeclOrYTfOB2laXCVeu0tHNTXP/j71v7QI+zovmyEbON7R1rgyo2Lv
	 grVZaQ3qsnwakn1oiJt+fAx9FACoj2b4zazu9j415gF5VYRLo+pPvwOvASV+n+hARmgx2
	 zn3uu7kLvclkxzhKfCAmXjJIJsClSIgKZaHRZXPWuxaVEF5wToZA6o3U7mmw1GuVE+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktumvrEO;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F010606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 04:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F010606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktumvrEO
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ae8607e8afso27465017b3.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 20:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793680320; x=1794285120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K7cNTtUrlw/YMKMwg5CBdynxQMrMR2KfNh32rGFC1ZY=;
        b=ktumvrEO/Fbgzz7BIo6zVcbBwrh+0p6lniANqwz9XiF5UUrx6AzNtvrP4n3lQgIZ60
         bopGYYFy7FGc6Sho8pAzyzese7akl1eiSvSbp8gDMbtL9OWs9pyZ0nRA5sbQ79zZT1D/
         tVhENVdr8sKUkUuSL+rLvkHuCzQP/+IxnqxvOleLDCWhB+DWtCcGD7jnAY5hdN9kcN/8
         PvmAQ+p9CtoGZEQCNSbO+ExnIOdqfNpr1e3KpTZ8bFxOk5JjqQ4r0dR4QLZKQbiMK0Iq
         6gvmMR42DaWcJsPg/oNcytcRHbRV6DvqVQyLKZ98ne8SPuOKemECxWzst9RzyqaRuyxa
         p5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680320; x=1794285120;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K7cNTtUrlw/YMKMwg5CBdynxQMrMR2KfNh32rGFC1ZY=;
        b=EIvaB2OWCyvHDYsSsZcw/1FOClGI9d+sPet4I0EtM9rSrj9cWddyXqdh5BEyC3LUfo
         9GXu3xFSyXkzCvjCX6oEuo3mxGeTzushU5E3DqHO28cfpkAUoR6nA4YJHN9KktUqS8Rw
         PgUkINP8dQ8LYM0bg7/cqOgRFALYjmUsQ4tzreGLvMfHm9DEyU7o1Lxw6rYCLpOTxyNv
         DQlD8CLs9pnyTK5v2qYw59fz7+MDQLD1EZCoAN8BzhVHO3mlWyRPcucUBgg6h+vXIw37
         oFLYncXbJHhjFSkKrHDM+QXWjbAAsBc58QPYVIss+znrKRL1bFYyGQgs8v3OJYYuwBMA
         m+wg==
X-Forwarded-Encrypted: i=1; AKwUvBw2YtqVn73wfKuSxCGwi/ePJQA4VfEdMUrZnE1yNko1bWwnZSPD4kRmjZMQ8jriW551pQj2XSQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VNWSgNdKiWM4iUr6Dp+UEklM8oXa8Hokwt04dkp2k0ySGbAoP
	11NneJLdZrXzD/s8tQjrK0BMZysiCdiElhBRLdbC5KevT9hNCn6ULS+AAzg4eHXd
X-Gm-Gg: AYBFou2fiuIlKIpKddBsz1hS7CBRU66kPjOhi8ylcO2+3r8WbZ2fwaxa3TRfnwL8RCt
	6E4RB6XfipjzzALFyZqm4ZgADLqyn6psryBdGv1bywY183rlJX/8QwNsX8StLpfqChDDRdqKG/J
	idxrxLbITqXphu72zCNig5V+Rzt0eSnlmmuBVZah/QKjxbkTO565jHTF9D2FfF9j3dsmFoq+BSE
	K+ANngpjCZ8Bfp+hVBMU5oCnLIXqEBAl3E8RXBeP6DrJH55PCqo6WoWyqRlt3cf1phQiiBhtILD
	9k9vuPf+vgx8ZY6czWIyG57KhH5cy0y/U6lenZUEuc1zRa3YKn9UDVxyS7thaehA6GZo0os1YYj
	VKYD03HSWG2Muq6r2s+/B1P/E+mqUJ4wVhqDfJ6e0lvyh21e+PKXipRfPKhSaqNaGaWTL9Z19Gw
	pYd8CxH7wdp+AQYNq5Anpdl6ena4Cu6+DuTOPB8EKqPAwJ/SFcXYnbc4lbjVyCURbgmOCa493Mi
	m0Lvf5SS87MGJkq2u5zEScX8uADoEJHQX0xSXLV6lPHr6i67h/Kl6wYpFC1yQnwA+hANjOJlcrZ
	y1XOxw/b6bBjo4ko7nZ8j1/YQK4Nm0QzY3Ar4b2kWS//PM8RMeQK9bsJeVuJL2y9fOl2YLI=
X-Received: by 2002:a05:690c:a401:20b0:873:5c6b:a305 with SMTP id 00721157ae682-8b2b678564cmr58378467b3.51.1793680320144;
        Mon, 02 Nov 2026 20:32:00 -0800 (PST)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b71657besm65304927b3.30.2026.11.02.20.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 20:31:59 -0800 (PST)
Message-ID: <bf1f9ee0-c7ec-4e6b-bf22-14e64413118d@gmail.com>
Date: Mon, 2 Nov 2026 23:31:57 -0500
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
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andre Brait <andrebrait@gmail.com>, stable@vger.kernel.org
References: <20261028170239.28606-1-tactii@gmail.com>
 <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
 <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
 <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/26 12:53, Alexander Duyck wrote:
> On Fri, Oct 30, 2026 at 12:00 PM Matt Vollrath <tactii@gmail.com> wrote:
>>
>> On 10/29/26 12:47, Alexander H Duyck wrote:
>>> On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
>>>> When an skb arrives at the driver and the header length exceeds the u8
>>>> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
>>>> are sent to the card. If TSO is enabled, some header lengths will cause
>>>> the card to hang.
>>>>
>>>> This was reproduced on an I218-V with an unprivileged Python script.
>>>
>>> Can you elaborate on what the script did to trigger this? I am
>>> wondering if it can even get there with a valid frame supported by the
>>> interface since most of these e1000e parts don't support tunnels and
>>> such.
>>
>> I will send you the script OOB. To be clear, this is a security fix,
>> not a correctness fix for rarely used paths. The rules say I have to
>> post the fix publicly because an LLM found it in a
>> function-by-function scan.
> 
> I got the script, will try to take a look at it over this weekend.
> 
>>> Also did it have separate cases for the CSUM vs the GSO? I would
>>> suspect this is more a CSUM issue than a GSO issue.
>>
>> I have only reproduced hardware hang when TSO is enabled on the nic.
>> Otherwise it likely just mangles the packet, but I have not confirmed
>> that.
>>
>>>> Fix it by disabling GSO and checksum offload when the header length (and
>>>> checksum offset) would exceed the field widths. Compensate for a
>>>> software-inserted VLAN tag.
>>>>
>>>> Because of a quirk in the ordering of ndo_features_check, the skb's
>>>> transport_header field may be stale. If the skb carries
>>>> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
>>>> no reliable interface, so don't offload it.
>>>>
>>>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
>>>
>>> I am pretty sure this Fixes tag is bogus. This is the introduction of
>>> the e1000e driver which was in 2007. The ndo_features_check didn't
>>> exist until 2014 sometime after that if I am not mistaken.
>>
>> My understanding is the Fixes tag should point at the commit where the
>> bug was introduced. A comment on the Cc: stable tag indicates how far
>> back the fix can backport. I didn't bother because this patch should
>> apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.
> 
> I get that, but at the same time the fixes tag is pointing at the
> driver when what more likely happened is that the stack evolved past
> what the driver can handle as evidenced by the fact that the fix would
> never be able to backport that far as the function it was adding was
> introduced sometime after the additional stack complexity was added.

The Fixes tag seems correct to me. To confirm it I reproduced the hanging
hdr_len values against 2.6.24 on top of Fedora 8. It was more or less the
same script, just with different headers. I can't confirm that it hangs
the limited set of hardware supported in the first driver commit. Maybe
Intel could test it in their lab.

It's worth finding new core complexities causing problems in drivers, but
in this case the mechanism predates the driver. It really has been a
security bug for 19 years. The switch was enabling TSO6 when e1000e was
spawned from e1000.

The fix not being able to backport all the way to the Fixes tag was a
choice. It has nothing to do with the bug not being a bug that far back.
I'm not spending time supporting Linux 2.6 or any pre-LTS kernel, nor is
anybody at Intel or kernel.org, as far as I know.

The attack surface and details of exploit have changed over time, but
that's not a story that a single Fixes tag can tell. It's the story of
IPv6 headers.
>>> Much of the complexity that enabled frames to build up massive headers
>>> wasn't until much later when the network tunnels and OVS started being
>>> added.
>>
>> The repro script should work back to 4.10.
> 
> Okay. However, that still only goes back as far as 2017 if I am not
> mistaken. The diff you are blaming is from 2007. I suspect we should
> be looking at blaming whatever introduced the ability to push the
> headers this far as the driver itself isn't likely the root cause for
> the issue, but instead a header change was.
> 
>>>> Cc: stable@vger.kernel.org
>>>> Assisted-by: LLM
>>>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
>>>>    1 file changed, 33 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> index 6f85dab5c55c5..370776657d100 100644
>>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *netdev,
>>>>       return 1;
>>>>    }
>>>>
>>>> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
>>>> +                                          struct net_device *netdev,
>>>> +                                          netdev_features_t features)
>>>> +{
>>>> +    /* Do not offload packets whose header lengths exceed the u8 fields
>>>> +     * in the descriptor.
>>>> +     */
>>>> +    unsigned int hdr_len = 0;
>>>> +
>>>> +    if (skb->ip_summed == CHECKSUM_PARTIAL) {
>>>> +            const struct tcphdr *th = (const void *)skb_checksum_start(skb);
>>>> +
>>>> +            hdr_len = skb_checksum_start_offset(skb);
>>>> +            if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
>>>> +                    hdr_len += __tcp_hdrlen(th);
>>>> +            else
>>>> +                    hdr_len += skb->csum_offset;
>>>> +    } else if (skb_is_gso(skb)) {
>>>> +            /* Work around untrustworthy header offsets in this case. */
>>>> +            return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>>>> +    }
>>>
>>> Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
>>> the frame must not be TCP/UDP GSO since for those normally the checksum
>>> and offsets should be populated. Have you identified cases where we are
>>> seeing TCP/UDP GSO w/o the checksum being set up?
>>
>> It looks like this particular case is never reached by normal traffic.
>> It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
>> hostile or niche setup.
>>
>> When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields are
>> used for csum instead, or left zeroed.
>>
>> The transport_header field is unreliable when a packet is being routed,
>> so you would need to parse the packet from the top to find where the
>> transport header ends.
>>
>> Rather than walk all the headers for hdr_len, it seemed prudent to just
>> categorically deny offload for these exceptional cases. I could be
>> convinced otherwise.
> 
> The point I was trying to get at is that the stack shouldn't be
> allowing those sort of frames through in the first place. Basically if
> checksum partial isn't set the stack should be rejecting the frame for
> UDP/TCP GSO, not the drivers.

I agree that this patch demonstrates how obtuse it is for an
ndo_features_check to reliably measure header length, which is something
that several drivers need to do in the hook. The issues being worked
around should be fixed in core.

GSO without NEEDS_CSUM is the biggest offender, no driver is checking for
that in their implementation of ndo_features_check.

Using a potentially stale transport header is next in line. Several
drivers are getting this wrong. I'm working on a fix, a simple reorder.

>>>   From what I can tell it looks like the only valid cases for it not to
>>> be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
>>> FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
>>> anyway.
>>
>> FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e
> 
> This is part of the problem. It pushed through the ability for
> CHECKSUM_UNECESSARY to be valid in an outgoing TCP frame, and then was
> reverted back to using CHECKSUM_PARTIAL. That is what is partially
> what is allowing the non-partial checksum through for GSO frames.
> 
> I will probably look at submitting a diff for this next week to look
> at limiting this as there are a number of drivers that already expect
> all TSO/USO frames to have CHECKSUM_PARTIAL always set before they
> start processing the frames.

That would be great.

