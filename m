Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5628030E;
	Wed, 30 Sep 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754991; cv=none; b=MsS1N0aiX0N2pYZZPqGc9KhF1sEMDXYDKYX3EuTBWEFJP+amjkdetkYw34wJk8SEcJjX6WYFMN8b1LLsDnUtO4WUJHu3UoXhv4a9/tBmNoJLp5/iHlJNeMWsYbHvKQFxiqcVZjqRZPc/UIRANkaJ8FoscfQo4Q0Z9y70bBFKRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754991; c=relaxed/simple;
	bh=D27b5SQ9LI1LxWbjBKKZ3oNv4Y5uzcayqJXkPA5pjF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4fKsRAARm6ZwzrFZjLcJ7/+S3gSj1Nsh9ceAGFs7FAZ1oCfoCWn0xFffjR7RlEFirU6e5EoVEZ00kRNAkVfgLkHfnwDd/ZHAXseCnrpQXjioedcPrscG7x6uop41ZrYlvQHEYi2QCvFtRsOOF182phlBjFadCERLGkugPhWBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaKwMRNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaKwMRNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BCB1F00893;
	Wed, 30 Sep 2026 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790754989;
	bh=VjbbNRN2eC8tZmkn1mH2A2DvnjZWU/1CxEv8Yo7WvqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kaKwMRNp+1dn8WFtBVMsdSawhYFDw9KvpAXXtIx04OTjq7CWcHD5lEOSB24LTbFIt
	 R7z0p2uc/pP/vcOs6eCGPFELSQUXvfjNOPY4GW3VNuUjiwCIp7lDX/kSsFXsM0aL2u
	 NjiGyIe6PH6WFh/BCpQPYobtWzXTFagaTEI9PV8DmQHdyTdmx7D64D0l4I3DD8Ieba
	 eywgd8THm5SiSqznhAwdYq6iufgiXvIA73aaLx4XlWvc8qtacEX4C7EtvI6IwhLpor
	 Qi0Q+VzrXsMBzMH0kZeFEg1wDlhvs3QguqwJ4SFWkBkw1kW+A6jwRyAw17O1koh1/d
	 wipm0KLqd75VA==
Message-ID: <4f43465f-98ba-4722-8e29-03df20315369@kernel.org>
Date: Wed, 30 Sep 2026 09:56:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 14IWC11
To: Martino Papero <martino.papero@lcb.to.it>,
 Iustin Ivan <iustinivan2002@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260911182328.9267-1-iustinivan2002@gmail.com>
 <db8af2fe-481d-454b-a205-4f22cd9b7a0d@kernel.org>
 <f849e969-364c-4138-b4d0-ec761022a32f@lcb.to.it>
 <3ccd6cc1-4b69-41dc-8f2b-3c7c1cd1626e@lcb.to.it>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <3ccd6cc1-4b69-41dc-8f2b-3c7c1cd1626e@lcb.to.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 29-Sep-26 22:37, Martino Papero wrote:
> 
> Il 19/09/26 02:09, Martino Papero ha scritto:
>>
>> Il 11/09/26 20:52, Hans de Goede ha scritto:
>>> Hi,
>>> I'm starting to wonder if we should not just make this behavior the default.
>>>
>>> IIRC the whole deactivate thing was added as a workaround for multi-byte scancodes
>>> getting split-up during suspend/resume. I wonder if we can come-up with some
>>> better fix for that ?
>>>
>>> Regards,
>>>
>>> Hans
>>
>>
>> Hi,
>>
>> I tested the same atkbd_deactivate_fixup on a Lenovo IdeaPad Slim 3 15IWC11 (83RR), which was affected by the keyboard issue previously discussed here:
>>
>> https://lore.kernel.org/all/20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com/ <https://lore.kernel.org/all/20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com/>
>>
>> Without any kernel quirk, the internal keyboard does not work. I had been using:
>>
>> |i8042.nopnp=1 i8042.dumbkbd=1|
>>
>> which makes the keyboard work, but prevents the Caps Lock LED from working.
>>
>> I built Fedora kernel 7.2.5 with the following additional DMI entry:
>>
>> {
>>     /* Lenovo IdeaPad Slim 3 15IWC11 (83RR) */
>>     .matches = {
>>     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>     DMI_MATCH(DMI_PRODUCT_NAME, "83RR"),
>>     },
>>     .callback = atkbd_deactivate_fixup,
>> },|
>>
>> I booted this kernel without any i8042 command-line parameters.
>>
>> The internal keyboard and Caps Lock LED both work correctly. I also tested suspend/resume and a cold boot, with no issues so far.
>>
>> DMI:
>> LENOVO 83RR
>> LENOVO_MT_83RR_BU_idea_FM_IdeaPad Slim 3 15IWC11
>>
>> So it looks like the 83RR can use the same atkbd_deactivate_fixup as the 83RQ.
>>
>> I can test a revised patch if needed.
>>
>> Regards,
>> Martino
> 
> 
> Hi,
> 
> Just following up on this.
> 
> The 83RR is still working reliably with atkbd_deactivate_fixup after further use, without i8042.nopnp or i8042.dumbkbd.
> 
> Would it be useful for me to submit a separate patch adding the Lenovo IdeaPad Slim 3 15IWC11 (83RR) to the atkbd_deactivate_fixup DMI table?
> 
> I can prepare and test the patch on the affected hardware. Alternatively, if the generic solution discussed above is preferred, I am happy to test that as well.

Submitting a patch adding a quirk for this would be useful, I don't think
anyone is actually working on a generic solution so for now we will need
quirks to get these laptops to work.

Thanks & Regards,

Hans

