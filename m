Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132366;
	b=w6BpiD4hHatMlZYfIukKafkaeZlJt/DGiCU61mcGQC8C6FD/gVLn8vCqeVh++uN1gG03
	 cJYZqYp9BZWU2NDO95lJUGYj/TOmHggnGyqR7SXRuwBbcieUbH/Y4Aoi4ydl6fgG6CS5p
	 F0EYevgzI9Ss4hqHPYmcBJd+NCt4kE6LECZLhdbo27G2wbbNvtkxiVvlBIGnTS7vq2kyF
	 kM7Lapp3/9ftvbNnVil1T+HKhRxvU8718z2CKg/xPC0Ab0jtKL9oNctN3CQV8RfBeVCSW
	 sr0NYIoAqJlDdwDhLGoPMc8C8D4waZFcyWWKLa1C8T9lwY/Ifbh89H9o1KWMhidrf0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132366;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dZuufkUf8GpuGJeyrf9o/MLXzvp/HAdAkmQveBEOhnw=;
	b=UM/c7wj+9mL28HR+r0VRvWd1lLEP4JqV8Mgtt9rnlQewtoNDxokyAk4QeF0a/girUP56
	 En0PCDw95sZqU4JRanCkuayAVuMyKv2x6MAcrhJfftCVBTuMcD0qHlnxepXB5gd4csK+c
	 M4akvkj2lbJZJMGqoy6NQwioqMaqelCL0CC1Pnk/U4mlv01OyBr3WZxz0HgqHLARJbAhG
	 DKtEH3gcra+cUdx3PLntNUuqZBu0gld7MbCLYqo6Et3FfoLXcv8DPiNUFw+LNgCvy0ubZ
	 fKTPw47nfRRMaA9ByKQ15EIZZ68fsvVIHrdD3VeT34ZvDGq3o9JQSArQoNDMVbkJQRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=X4h2WWV5;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D3606A31F;
	Tue, 27 Oct 2026 20:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683D3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=X4h2WWV5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793132363;
	bh=vDPdrRiyUL1FypybXVAL8Ck06MvORvilMP3KlioLSSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X4h2WWV5chjNCHuyEK1C1CGNB/yeF6RYj/nwHXe06ltvBfsN8Eye7OebM7xzJptka
	 Y/UZw2bu1lLtQbMlefkZQp2sd3swGsoETh6pw8bK5sYKfs1U4OabEQcGUDxFbMF0KA
	 qvNge9ddk59MjHSluO0ZJb3ZYcHzTAWpprT5fnVnGgI3eOMhrBwq7LkGLrE8sbfK2i
	 dcbDgw9qV2e9eBLnSyKsShUhmMrvEDRpB5PDL36dr8PnLsujeo4HxZdYMy/ePUUaNf
	 ishCEu8VFkPYyQ5eDByWNaSpZdVBxLMyvHxcruxxFJe10aand8a7emX5ZHjS5FprTm
	 MKDtfP52Dd2CA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C468917E03FF;
	Tue, 27 Oct 2026 21:19:22 +0100 (CET)
Message-ID: <f534555a-b62f-4bf9-96cf-ebd74b4b30f0@collabora.com>
Date: Tue, 27 Oct 2026 22:19:22 +0200
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
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Lucas Tanure <lucas.tanure@neat.no>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dom Cobley <popcornmix@gmail.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261026164028.78792-1-lucas.tanure@neat.no>
 <at_4EgWZFghkRHzH@collabws.localdomain>
 <a8b9450f-af4b-47bf-b7b1-3b326ed52dfc@igalia.com>
 <CALt7t=Ef9LS5vNOZq7JGZ1n-L5rgMk7mXBGE66jicfdkqAC35g@mail.gmail.com>
 <a054e9e4-304a-427c-b78f-973fd06f1199@igalia.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <a054e9e4-304a-427c-b78f-973fd06f1199@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maíra, Lucas,

On 10/27/26 3:58 PM, Maíra Canal wrote:
> Hi Lucas,
> 
> On 27/10/26 10:53, Lucas Tanure wrote:
>> On Tue, Oct 27, 2026 at 1:07 PM Maíra Canal <mcanal@igalia.com> wrote:
>>>
>>> Hi Cristian,
>>>
>>> On 26/10/26 22:23, Cristian Ciocaltea wrote:
>>>> Hi Lucas,
>>>>
>>>> On 2026/10/26, Lucas Tanure wrote:
>>>>> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
>>>>> the TMDS clock is stopped and to start the clock at least 1 ms later.
>>>>> vc4 writes the bit, and enables the scrambler, at the end of the enable
>>>>> sequence, long after the PHY has started, and clears it before the PHY
>>>>> stops. A sink that samples the bit when the clock appears never locks
>>>>> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
>>>>> order work on the same sink.
>>>>>
>>>>> Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable()
>>>>> was an empty stub upstream, so the PHY kept running after disable; the
>>>>> Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
>>>>> pre-existing race in the scrambling work cancel that the fix would
>>>>> otherwise make easier to hit.
>>>>>
>>>>> v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
>>>>> with the same change applied, against the sink that showed the
>>>>> problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
>>>>> reset and a sink power cycle all lock with zero character errors. v2
>>>>> and v3 carry the same code; the hardware test of the final form is
>>>>> still pending and will be reported in this thread. Mainline was not
>>>>> booted on the Pi 5. The BCM2711 path is unchanged except for the
>>>>> enable order; I have no Pi 4 at hand.
>>>>
>>>> While converting vc4 to the common HDMI 2.0 scrambling infrastructure, I
>>>> ran several tests on the Raspberry Pi 5 and didn't notice any (obvious)
>>>> issues.
>>>>
>>>> Hence, could you please verify whether your problem reproduces with a
>>>> recent mainline kernel?  If it does, could you also give [1] a try and
>>>> report back the actual behavior?
>>>>
>>>
>>> I suspect you didn't hit this on mainline because vc6_hdmi_phy_disable()
>>> is a stub, so the TMDS clock never stops between disable and enable.
>>>
>>> Best regards,
>>> - Maíra
>>>
>>>> [1] https://protect.checkpoint.com/v2/r02/___https://lore.kernel.org/lkml/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com/___.YzJlOm5lYXQ6YzpnOmQ1ODUyMWJlOGIwNzJjNjNmOWRiMDk3ZmFmYWFkNDliOjc6YTM1MTpiMzBiNzY3ODAyMzBkOGM2M2U0ZjRjMTY2MzE5ZjVhZWZjY2QxYmRjZDBlOWI4MzI0MGYxMjkyNjQ1Y2NkNzJiOnA6VDpG
>>>>
>>>> Regards,
>>>> Cristian
>>>
>>>
>> Hi Cristian, Maíra,
>>
>> Tested on a Raspberry Pi 5 with the Raspberry Pi 7.3 tree [1] as base
>> (pure mainline panics at boot on this board). 

I recall encountering this issue a while ago and spent significant time
bisecting.  The faulty commit was d87773de9efe1
("clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when running
VHE"), introduced in v7.2-rc1.  Reverting it restored the normal boot.  

Note this was later addressed via commit 94f39e4c017e
("clocksource/drivers/arm_arch_timer: Workaround bcm2712 broken EL2 virtual
timer"), part of the v7.2 kernel release. 

Which is the mainline version you've tried?

>> That tree carries
>> vc6_hdmi_phy_disable() implemented, so the clock does stop on disable.
>>
>> 1. plain rpi-7.3.y: 4K60 never locks.
>> 2. 7.3 + my patches: all lock.
>> 3. 7.3 + the 7.4 scrambling infrastructure + Cristian's 9 patches: same
>>     failures as in 1.
>> 4. same as 3 + drm_connector_hdmi_enable_scrambling() moved before
>>     phy_init() and drm_connector_hdmi_disable_scrambling() after
>>     phy_disable(): all lock, zero errors, picture on the panel.

Thanks for testing all this.

>> Maíra, I also tried 3 with vc6_hdmi_phy_disable() emptied again, as on
>> mainline: same failures as in 1. So the stub is not what hides this.
>> Cristian did not see it because his sink re-evaluates
>> TMDS_Bit_Clock_Ratio after the clock is running and forgives the late
>> write, as most TVs do. Ours samples the bit when the clock first
>> appears and never again. So to reproduce the issue you need a strict
>> HDMI input.

Yeah, that's probably why this issue went unnoticed - most displays are pretty
tolerant and don't require 100% spec conformance.

>>
>> Happy to send a v4 on top of Cristian's series, with the two helper
>> calls moved and patch 2 dropped since the common helper already cancels
>> synchronously, if that is the preferred order.
>>
> 
> As your patches are fixes, I'd prefer to push them to drm-misc-fixes and
> then Cristian's would rebase on top of your patches, as their patches
> will go to drm-misc-next.
> 
> Are you okay with this plan, Cristian?

Yes, but sadly I will not be able to reproduce the issue and confirm my rebase
will not regress.  Hence I'd appreciate if Lucas could recheck this after I send
that series out.

Also, Maíra, could you please let me know when you apply the fixes? 

I guess I then need to wait for drm-misc-fixes to get merged into drm-misc-next
before I can proceed with the rebase.

Kind regards,
Cristian
