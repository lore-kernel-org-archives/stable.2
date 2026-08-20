Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E51714AA;
	Thu, 20 Aug 2026 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208797; cv=none; b=lx6WQZSSV8e8JMDIgTJOOYXRdp937sg3m3XvU/d2/xSd7kP16iMJsK+SJQX2GaDO97mcTEtwbyO/m5sPfgRfd0gomdhqohCIiwTBDya1J4WRx9iUNZhn5zI0CgKyl83xm02eGEIPoNau/LfJyiStCNPgDcQag+6p7lC3cZR7l/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208797; c=relaxed/simple;
	bh=xeq9p691pnd92mUwraaZ/J+eDzqTgp5lT7ixsE5zmN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su3xqxVWc9UNZv6Ag9R/SZbZikgjcMpHHkSe+rWNZDesmB7TTdOqS6izUdiLf3LAGt6b/itflR8AKwQKe2GbE4MnZE4FGgjIbnW98XBDPo9EgJjMlWbWxCtfht8z4Y8A2BKG7cqzGyztrzP2L6LYQ4n2sNi2zbCIf9doIqVyKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEswjnAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEswjnAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EA81F000E9;
	Thu, 20 Aug 2026 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787208796;
	bh=Poo+wRHDIip4zFS2Z6wipcWfPxZPSybxfz0z1X3UKa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FEswjnABEnurvbzXM7CvNA7SC/fvhsMIpReccYftYu+5Y6fg76sxkv8e5EiZf0BCP
	 +9Zf5FWuz7KQedwlYvqlifF1/JI9z0uoiDKzNCrjyAhQFVvzg0NS/ugcPjnkPkpHpr
	 +BuHkN9KYvPCwmcgZpSXPrY0hytgIkUSpufFjNA1H1m/J18tqTQOBW65nv846h69EG
	 8ZL60cRgehsQSxOAyP7Dz0d0A0eEbMf9c/GlJSq2qUh7pQV66C+O9m9FsCc/dhVbHh
	 83mda/FW6eu0rYz4wl1J5dGPHX1yyfKpfeL2osKkX3vqRMm7xalsDwOB+89p9iuclX
	 6N+1bh92gflUQ==
Message-ID: <d6c8f19e-f154-4b57-9101-cf3b73e9794f@kernel.org>
Date: Thu, 20 Aug 2026 08:53:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag
 marvell,ignore-regulatory-hint
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: George Valkov <gvalkov@gmail.com>, briannorris@chromium.org,
 johannes@sipsolutions.net, andrew@lunn.ch, krzk+dt@kernel.org,
 francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org,
 miriam.rachel.korenblit@intel.com, rafael.beims@toradex.com,
 avraham.stern@intel.com, error27@gmail.com, s.kerkmann@pengutronix.de,
 gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 chunfan.chen@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com>
 <20260819-generous-nickel-dalmatian-b6bb08@quoll>
 <CADOrJmYfBe3ADun_kFjFSH6YOSTX7Vu3UsFsL57yuRdaQ=eJCA@mail.gmail.com>
 <e554c007-67e3-4fbf-b85e-5de02f649e83@kernel.org>
 <CAGXv+5H7AhZgZ06r9KO3HLZ9Cymkai+Cv9SgVTuSC1PjgGf8hg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAGXv+5H7AhZgZ06r9KO3HLZ9Cymkai+Cv9SgVTuSC1PjgGf8hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/08/2026 08:42, Chen-Yu Tsai wrote:
> On Wed, Aug 19, 2026 at 8:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 19/08/2026 13:42, George Valkov wrote:
>>> On Wed, 19 Aug 2026 at 12:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Tue, Aug 18, 2026 at 12:54:26AM +0300, Georgi Valkov wrote:
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
>>>>> index 930b700b73d0..5f235cb9f3e5 100644
>>>>> --- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
>>>>> @@ -59,6 +59,12 @@ properties:
>>>>>      description: Calibration data for sub-band 3 in the 5GHz band.
>>>>>      maxItems: 502
>>>>>
>>>>> +  marvell,ignore-regulatory-hint:
>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>> +    description:
>>>>> +      Ignore an incorrect regulatory hint from ROM,
>>>>> +      so userspace can set the correct regulatory domain.
>>>>> +
>>>>
>>>> Same comments, so you just ignored entire feedback?
>>>
>>> Do you mean this feedback? I already replied to it:
>>>>> Anyway, property looks like SW choice. You must describe hardware
>>>>> instead.
>>>>
>>>> I am sorry, I do not understand what you want me to do?
>>>> Can you please send a diff or a clear description suitable for people
>>>> who have way less experience than you?
>>>
>>>
>>>> Again: you need to describe the hardware, in commit msg, in property
>>>> name and in description. You cannot tell SW what to do, that's not the
>>>> purpose of bindings.
>>>
>>> I still don't understand what I should do?
>>> Can you please show me an example of the changes you want?
>>> Else I'm likely to make a wrong guess and implement it. That obviously
>>> won't help.
>>>
>>> The commit message already describes the issue with WRT3200ACM and WRT32x.
>>>
>>> About the description, do you want me to do something like this?
>>>     description:
>>>       Ignore an incorrect regulatory hint from ROM,
>>>       so userspace can set the correct regulatory domain.
>>> +    WRT3200ACM and WRT32x are known to need this.
>>>
>>> About the property name or flag, do you want me to add a separate flag
>>> for each affected hardware device?
>>> - wrt3200acm,ignore-regulatory-hint
>>> - wrt3200x,ignore-regulatory-hint
>>> - the list may grow if someone decides to add other devices
>>> - and the driver will need to support all of them
>>> - that doesn't make sense, because it isn't scalable
>>
>> You need to describe the actual problem in the hardware or firmware, and
>> then name the property and description accordingly. "Ignore regulatory
>> hint" is clear instruction to the OS what it should do - ignore the
>> wireless-regdb package/instruction etc.
> 
> You probably have it backwards. The driver is taking the hint from the
> hardware ROM, which is fixed and thus wrong once someone carries the
> device to a different country. I.e. it is a quirk saying the _hardware_
> region should not be used.
> 
> Whether one should override the certified settings, or be able to do that,
> is a whole different discussion.
> 

regulatory-hint for me means usually regdb, but even with your meaning
you tell SW what to do - ignore hardware regulatory information.
Property should not tell what SW should do with hardware. Property
should tell what is happening here in the hardware. In this case: what
is the reason behind.

IOW, why user of a board in country X, where regulatory data says X,
should have the correct regulatory data ignored?

Best regards,
Krzysztof
