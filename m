Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09473B5304;
	Thu, 27 Aug 2026 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844703; cv=none; b=f1Oh81LTRYXV1VNTYxXCbb2ioyjtC7L6cTXL+nxjTwDkoRA3rhZG7c50wHOyLAfooXmepil8qSlBGdkJkDD12tPdL8sw8MUOZa4YHho1/TJ2VsDsgGvRNXwIQhYdKdaatxEQh+ph0a/lFcygCRbUm2qENwiCOTOYds5xKv0OacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844703; c=relaxed/simple;
	bh=IbZDvx1ZxaYcQqLta32Pj3RvUkwae4KK9cXQ7UUZTr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNtJv9CUBLJaWt6R2h1VCTTa7sggO9OTOhBLQLt3cd7VG2r4sQE4UH4jVs2NFB/D/hThjpsw8f7dxJ94TqfQ8tiFKFhPsUQGdPBhH+OBkQHSY6DVO4LfTsIkf9i0BVwKGXcPTUNS88DL/+IqqYP79Ed2T5Rh7+e74ihPCLlgnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBy/zndM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBy/zndM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ACF1F000E9;
	Thu, 27 Aug 2026 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787844702;
	bh=zOcoi4jHu+T1Dl4zlPXslQUWfUwJL1m96r6RTqcs/tk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MBy/zndMJBNpPo83fJILf0E8EfNgtywMzYfWf8R81GCh2kvJF0WodQyNledMebvI9
	 MK/CvmaEPKOWQV6ZDDil2JHOqVAktxcasL3B2HM0OdJxV40oya0cmBF+NF0+jIecqK
	 obCw6akJZ0L2OiIwqEqRNSswy701ClV3Cd9iZRc4kV7L0/de0Bu3NaQ1ZFiVdqgod9
	 1xOu2ypytX+uwMelwLaierY3m8eSYtGRduffCMQFJRWqMVwyXQPW61lt2aOBN9jSjA
	 uO1KJYgV2sC+nhUaa3zAHDM4OqbBl9hpQucSU8NpebmU5bJLqzCBJ/pzYQ+Dk6naHh
	 Arl5QBFTNc54w==
Message-ID: <3d662b34-61ed-4a30-a52c-f86bc70162ca@kernel.org>
Date: Thu, 27 Aug 2026 17:31:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dt-bindings: net: wireless: add flag
 marvell,invalid-reg-hint-in-rom
To: George Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch,
 krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com,
 kees@kernel.org, miriam.rachel.korenblit@intel.com, wenst@chromium.org,
 rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com,
 s.kerkmann@pengutronix.de, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@nxp.com, chunfan.chen@gmail.com, arend.vanspriel@broadcom.com,
 peddolla.reddy@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260821010728.45065-1-gvalkov@gmail.com>
 <20260827-helpful-icy-donkey-9bfdaf@quoll>
 <CADOrJmaF0UpRefk1+BDyn5iU5La4ke1gFWwzyRr5-9wp7Zr2+A@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CADOrJmaF0UpRefk1+BDyn5iU5La4ke1gFWwzyRr5-9wp7Zr2+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 15:08, George Valkov wrote:
> On Thu, 27 Aug 2026 at 13:34, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Fri, Aug 21, 2026 at 04:07:26AM +0300, Georgi Valkov wrote:
>>> WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
>>> from the mwifiex ROM, which conflicts with the platform regulatory
>>> configuration on units sold outside the US market. For example:
>>> - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
>>> - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
>>> - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
>>>
>>> When the system boots, it detects a conflict between the user selected
>>> region and the radios, e.g. BG FR US, and applies extreme restrictions,
>>> preventing phy0 from starting on any DFS channel. phy2 works.
>>>
>>> Add a device-tree flag, which allows affected devices, where the radio
>>> conflicts with the platform to ignore the incorrect regulatory hint in
>>> the ROM of the radio, so the platform regulatory domain can be used.
>>> This does not allow the user to change the regulatory configuration of
>>> any radio. It only allows phy0 to start and operate according to its
>>> certified configuration.
>>>
>>> [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
>>> [2] https://github.com/openwrt/openwrt/issues/9956
>>>
>>> Cc: stable@vger.kernel.org
>>
>> I don't think there is any bug to be fixed here. Support was incomplete,
>> so you add a missing quirk, but there was no bug in the binding.
>> Binding was correct.
>>
>> With stable dropped:
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> I added Reviewed-by to the first patch and sent v7 with these changes:
> 1. drop Cc: stable, the first patch only documents a binding
> 2. restore colon after Tested-on as requested by openwrt-ai

Hm? You cannot test a binding. Please ignore completely openwrt-ai, it's
apparently hallucinating. Anyway, OpenWRT process does not matter to
upstream kernel.

Best regards,
Krzysztof
