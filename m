Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B8420495;
	Mon, 17 Aug 2026 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973113; cv=none; b=SoaSvyK1IXIwsfWjn1umaKrnYvdg0SDICm4Sch6xYxEOojleFi/TRPX5w2F7V1zQ+Qso12m5/FyMdD7DVcomfY+0npLjASWybxQld/Bw7RWrv15vQAYTKeyc7CyZx6vtyVTXiRHc6qxh9kRMlIrZNqoOeXlKq5KaN+pmp8fdWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973113; c=relaxed/simple;
	bh=KLKeQEu8rXiwO5XrKVW4YX0KnqktTvlGl+6Z2GtkTjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBbaO9GPst0LXqENAUOGSkkYLQCSw+INANPR15Z7oiFXdI4K8188n1XvWergn8+84BKX9K0CHsD5fGJ4R6CajwmaonFhSQiBMMFakNZESkVwRX3V1z9/FWp8XxRIFLOF3/xf7scwB5aqPAoCzAO5LsARtjRQPQTzNj2EtU49uzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiE3BpkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiE3BpkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5C71F00A3D;
	Mon, 17 Aug 2026 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786973110;
	bh=vRJ5wN5BP9Vexmqogl8NhDRj+dNiWoiVFS9/SULJCiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FiE3BpkGG3X5ylo52BGzSOchbeETup+HJnY/NfEibmxFLcAtX6sg9hA6x0vlh0aPw
	 HBU/Mkg4EvBYCh/0DNkl2HGXD2o2eDfPi00sr14tIGnzXn3UAmmL7jfgm3pVqLIRir
	 GxH8/P5OsO/IJLxLQ83B6qeFNxfQIrqRAGCY98eudLsoTkvjajWTtbAh37ciOIVz47
	 ip9BQw7z9bpIwQkUZajdx/IR5kOLdeRuIzNU5oRcNDp/0Gw8Nkjs1JL2Bc+16wQt5E
	 lwQGW9Tz8wYYdSURXILJmK8FcH4ZQYzTMtXm9tqabXWXp6IX62ORBJthY4EcrIWkc2
	 MHXJmMaAKSLIQ==
Message-ID: <2f264b09-98e9-4260-b413-97a494ba789f@kernel.org>
Date: Mon, 17 Aug 2026 15:24:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: net: wireless: add flag
 marvell,ignore-regulatory-hint
To: George Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch,
 francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org,
 miriam.rachel.korenblit@intel.com, wenst@chromium.org,
 rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com,
 s.kerkmann@pengutronix.de, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank.Li@nxp.com, chunfan.chen@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 stable@vger.kernel.org
References: <anoYr9H4KojJv-aZ@google.com>
 <20260814125025.90522-1-gvalkov@gmail.com>
 <20260817-hairy-serval-of-refinement-49039a@quoll>
 <CADOrJmb3uJPpYR481rB-CnL0A9B_5PQ683XP+Gdis47uihqMBw@mail.gmail.com>
 <9b3b6f29-35a8-4b79-a002-bd0aac5dbee4@kernel.org>
 <CADOrJmZRBQb9u9oi2m=4iJuKDLVi6HNjOoSurRwE5QKPB_LetA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CADOrJmZRBQb9u9oi2m=4iJuKDLVi6HNjOoSurRwE5QKPB_LetA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/08/2026 15:20, George Valkov wrote:
> On Mon, 17 Aug 2026 at 14:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 17/08/2026 12:43, George Valkov wrote:
>>> On Mon, 17 Aug 2026 at 11:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Fri, Aug 14, 2026 at 03:50:23PM +0300, Georgi Valkov wrote:
>>>>> WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
>>>>> from the mwifiex ROM, which conflicts with the platform regulatory
>>>>> configuration on units sold outside the US market. For example:
>>>>> - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
>>>>> - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
>>>>> - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
>>>>
>>>> v1 as reply to v3 in big thread. How tools can parse that?
>>>
>>> Hello Krzysztof,
>>> I apologise, I forgot to add the v4 tag to the subject.
>>> I have documented the changes between each revision.
>>> I saw my mistake after sending the mail. But I wasn't sure
>>> what to do? I will make sure to add v5 to my next revision.
>>>
>>>> Does b4 diff work?
>>>>
>>>> b4 diff '20260814125025.90522-1-gvalkov@gmail.com'
>>>
>>> What is b4?
>>
>> Tool used by maintainers and contributors to handle/send patches. See
>> korg docs (or just google "What is b4 Linux kernel").
> 
> Thanks!
> 
> 
>>>>> When the system boots, it detects a conflict between the user selected
>>>>> region and the radios, e.g. BG FR US, and applies extreme restrictions,
>>>>> preventing use of 5 GHz and DFS channels. This also affects phy0.
>>>>>
>>>>> Add a device-tree flag, which allows affected platforms to ignore
>>>>> an incorrect regulatory hint from ROM, so userspace can set the
>>>>> correct platform regulatory domain.
>>>>>
>>>>> [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
>>>>> [2] https://github.com/openwrt/openwrt/issues/9956
>>>>>
>>>>> Tested-on: WRT3200ACM, OpenWrt
>>>>
>>>> Not a valid tag, drop.
>>>
>>> I believe the tag is helpful because it describes that my changes
>>> have been tested on a certain device and platform. It's a common
>>> practice in OpenWrt contributions. My last two accepted patches
>>> have this tag. Should I still remove it?
>>
>> Drop the tag everywhere and instead on the patches which were possible
>> to be tested mention how did you test it.
> 
> ok
> 
> 
>>>> And you cannot even do that, otherwise explain me
>>>> how did your device execute THIS (exactly THIS) code?
>>>
>>> I am not used to your terminology and this gets me completely confused.
>>> You have not quoted any particular code change, so I'm not sure what
>>> you are referring to. Here is a summary of the patch series:
>>
>> Tested means executing or parsing or using the code on the device under
>> test. How can you execute/parse/use this code on the device?
> 
> Test procedure:
> Compile, FLASH and run OpenWrt firmware for WRT3200ACM.
> This compiles the Linux kernel along with all dts files and drivers.
> 
> 1. Before the fix
> Notice how each radio has its own country:
> iw reg get
> https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> 
> If the user sets their correct country code, e.g. BG, then global
> will be set to BG. This conflicts with FR from phy0 and phy1.
> And also conflicts with phy2 which reports US.
> Result: the main radio phy0 does not start.
> 
> 2. With the fix applied
> iw reg get
> phy2 does not appear in the list, so there is no conflict with the US
> region. I can address phy0 and phy1 later in another PR. They need
> a similar device-tree flag in the board file. The actual driver is not part
> of Linux. So I'm not sure if there is any place to add documentation?
> Result: phy0 and phy2 work. 5 GHz and DFS work.
> 
> I also used this test code to confirm that the flag is set:
> mwifiex_dbg(adapter, ERROR,
>             "[%s][%pfwP] ignore-regulatory-hint %u ++\n",
>             dev_name(adapter->dev), dev_fwnode(adapter->dev),
>             device_property_read_bool(adapter->dev,
>                                       "marvell,ignore-regulatory-hint"));
> 
> [   19.927595] mwifiex_sdio mmc0:0001:1:
> [mmc0:0001:1][wifi@1] ignore-regulatory-hint 1 ++

You are not responding to the actual problem.

In very simple words, like one or two sentences, explain me how this
YAML file affected `iw reg get`?


> 
> 
>>> Patch 1 documents a new flag: marvell,ignore-regulatory-hint.
>>> Patch 2 adds a device-tree node with the radio and the flag.
>>> Patch 3 skips the regulatory_hint() call when the flag is set.
>>
>> I can read your patchsets and above does not proof how can you test binding.
> 
> Ah, you mean how I tested if the device-tree changes are valid?
> I have almost no experience with dts. I ran this command before
> sending v4, and I think it seems fine. Here's a link to the output:
> make dt_binding_check
> https://httpstorm.com/share/.openwrt/test/2026-08-17_mwifiex/dt_binding_check-01.txt

This is a make process, so build stage. Nothing related to testing on DUT.

Building kernel (and running standard tools) is not testing, so I repeat
- do not introduce "tested" statements to commits which is impossible to
test by the definition of "tested" in Linux kernel. We discuss all this
in this very specific patch, not some other patches.

Best regards,
Krzysztof
