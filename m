Received: from outbound.ms.icloud.com (ms-2004h-snip4-1.eps.apple.com [57.103.74.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26393D5C12
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714236; cv=none; b=nUNaUtPg2NX2rReidz/OoBBp6oVhnitHKHo3lqZvK/0N8OhJ8VsURgsWEga9Jf905FgetuDT7Wu4ndPZQ5uwrBBZMwIl3eXUPe/z754lvYAUT/onTydtNveJeIYy5hm17WDl1qwIDSYE2nEISLAc07zkI/djtmpvz1ZsWurUH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714236; c=relaxed/simple;
	bh=CmlE80pSLORwSx812eu1SFv+69BqG+tG5JfC1lXaUWw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gFPAdpgtpupFGJc4xuIWC7sV20iKjVrOgqsbBk8qWjKYG9z/rxoM0Po9GpZsvVDPFE1MLDCJ/laaJXHlMQdG7JDlTSryseMgovdk6lUWTpiHVxQqnmNustGI02bkIkE3XV3ZDlseAgI70P9uH57RCxRJv4e/YbTsapJtUt/Zpqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lcb.to.it; spf=pass smtp.mailfrom=lcb.to.it; dkim=pass (2048-bit key) header.d=lcb.to.it header.i=@lcb.to.it header.b=Hmma00I1; arc=none smtp.client-ip=57.103.74.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lcb.to.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lcb.to.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lcb.to.it header.i=@lcb.to.it header.b="Hmma00I1"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPS id 1D75818001DC;
	Tue, 29 Sep 2026 20:37:10 +0000 (UTC)
X-ICL-RepId: 01a0eee2-b8c6-701d-bd84-4469f180ccb1
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhBBkMEWRxBCU0dXwVcEhVdRV4MRR9bHlZWQwxHDkAfeRRQDxkfXV5QDBMLU1ZeE1tWRwIZAkZQSxsOWxcDVxxWRVwYQwldBVccHQBERVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUFsIUF5NFx0EQ0tfGV1FD15UCFZGWhsCQAMJBEkUTAIJVEYKFgsaHl5UXFFBWhwCWwVdVzBVG1FDQwQcGU1GExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lcb.to.it; s=sig1; t=1790714234; x=1793306234; bh=zmp8SFl84gZRi5OkpkQVvlEiTxHsOKWX9tq1JueGvnA=; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:x-icloud-hme; b=Hmma00I1iCTJetJLa+4lEcU2IJz2CTZSLyP1/eSX7O2Hin+njeiX/5qIFzrt+kQDK74uL3SnlcUh04MdlhLy+vnTjVqWijHsko8nXx0qy0a8+RCxN+3PYVD2Y69zNbWLRuUrTvLUxDZmGGTQmytTTxtliHu8e71gBk+v1SvjlPKUWIOBA/sSihPvkfrmdXYF3cNvP25Dg1dZjV+3f97zit0hRXHLuSOe/i9h90i3kmWTHuNQPVD/gbSvPHDaTh62yeey/PV3n1JSKWy+uTUAWmFPm9cIX4IgY1BRCQlpo2lGHKlOoogPYRN9xls7jzVByl8ZrUj1269tsPCKVBZJ9w==
mail-alias-created-date: 1748381178872
Received: from [10.69.1.69] (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPSA id 07A2C1800128;
	Tue, 29 Sep 2026 20:37:08 +0000 (UTC)
Message-ID: <3ccd6cc1-4b69-41dc-8f2b-3c7c1cd1626e@lcb.to.it>
Date: Tue, 29 Sep 2026 22:37:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 14IWC11
From: Martino Papero <martino.papero@lcb.to.it>
To: Hans de Goede <hansg@kernel.org>, Iustin Ivan <iustinivan2002@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260911182328.9267-1-iustinivan2002@gmail.com>
 <db8af2fe-481d-454b-a205-4f22cd9b7a0d@kernel.org>
 <f849e969-364c-4138-b4d0-ec761022a32f@lcb.to.it>
Content-Language: en-US, it-IT
In-Reply-To: <f849e969-364c-4138-b4d0-ec761022a32f@lcb.to.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9JlmH3iyPLzgemWWF9Fou-DUGXNdTqPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4MiBTYWx0ZWRfXzX4PcDGFh85E
 GiqboE8JyjiohHnoEtkhUvhRVaVCRL10/aWKG9PFm+QJogYvicTUtlu0V8BBkjFOx3noM20blfZ
 AzPxJ1jG6IeR4QklnnZzZKgmer6gbQYkkj0KM983MU5qB8loOXIyd+GggkHd6jvv9vHnGvtj8Iw
 rqv2fvdEWiVJ11cKqscjiMqCBoeX3J2KTwqTe4G0rMaAl8PjmcnFcOicDorFkkrevGNf8m4V3vB
 llCzz3WaFNbNaDcdzSYbgjgipip2mCEUZU9GH6zGsRToebWtnLJ+qgB/xP4esIWHHviya6Ck9Vv
 o+4CgMfnaFb8wBX3LGV+8iFibDYxoayUoosjo4G/VJaZwUEXsIoY2vY2GiWcKM=
X-Authority-Info-Out: v=2.4 cv=K4Ev3iWI c=1 sm=1 tr=0 ts=6abc2177
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=3zCP-tckM5ql3hE0fiwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9JlmH3iyPLzgemWWF9Fou-DUGXNdTqPo
X-JNJ: AAAAAAABvqZ69FQdBawXlj+s49PQOgiboPcUwYZUMrWYErmdxHFYAdED5eSlp3rj3Y6HN/4Y6WIozw5nZpuw5Vz+kkhZ2YHbFKhCDx9DlF1EmoGF5/X+RgqiTm7lOqddiSeOr5GSlQ2LXaRXTjEF3P2myJRkYJNgvgcKvN6hr4veke+YcuyUKZQVUGv1VTH8bpQTPsciTCUUf6PB+5hkq6+bEallsgChhFJovl2dyWMop2JjBYT/aLH7mKixGPf+1+mCpT0XT/Zr9n09LJFdbbb4fm97OC9yMXZaZarjWqEgdE1uCYG8HFbgZYurEneiy1fqgHg+7cHGgsusIRPVclbiDjVQPVxIpd+BAOSorCTcCw+QAwCiqYeFlsoT5gwjCX5K4uOfzXwEwFXMNubyJHt699gFiF1nsqgUIJSGB4RKsHxfz846iuSXgGYCHV7GJti9ZKPZTYGZezoX++bEeBYAuuJGuTRy1Nep341R2Tum9T13i/zHHN8krmy4a0VyVaX4AWePAy4qo6U5KT71JM12efGSB5tSST+kW8+6gcxZOXef269sNn9zfRjlV1GeasMMuIvMbu7pa2QBylipMwtcVzsxC3dQ0AqCXOsMZH2kqxiXQs03TABFXdHQ1eNSx7uo2jduzfdY8hlZTN3XJsra2padRSKUFdUPWLCeo2Yt9meTcZElfbWx2OX7D7vxtfENlRIhpbbRDpRshCPhEmbAzCzVM37XCrVqFv0T8423O6K9PVT+G86Y1D4VZ2SHJzdPLSW+DDQgROfrK/o8BIuvKLVFG3LaFiXmBn7egxsiIMpbVNBjDy9IwrhTfUwo3bwein15YmWomTnhT2PUCzwpLMUPhD77DFRs9W+2qNHNMCnK6IeWuHykdT63Au9rrJ25s6j6MJhArV26jtUs7Ts/VpMzuIq/7PyuXC4z2LkmruN30tYQtIrGXzl2tOGXvrzRU/xiLqYuH5PavjnjU2Cj5uvtHjC
 U/wAXfKodBAOShx/MlYMZsfU5dQDrJIZ4bdzIBWUQrtABxU1evpcnhFJn/QOclohbQ4IpdKX/0+sto12UQDpD/fHZjegn4DiREimci4SIWM41QSNz2COuNVPH928HSpQFvYdHE37g6E2/xfICk93dcJHdiEQ9xuA2kMe/JEX+a/XsPnwic2sAZffcK7SnqQeTAL1+UbaU0S/eKTawLKQ4Mx0imrsUi19ck1/idm+5LV+ylZfbrVxHI+j6PJ/3zkGVNjB75szX37X0O1h8Iqd60MHu3zS7cz0EXPG7ppWOVGPO7lFLJ0wvCZ4ACuxT8Q+3i2h67xrFcfIOyYjUW+xD/qDchj1vLtCcA9uR4L5tl/KKwPmTr6rK7zQB


Il 19/09/26 02:09, Martino Papero ha scritto:
>
> Il 11/09/26 20:52, Hans de Goede ha scritto:
>> Hi,
>> I'm starting to wonder if we should not just make this behavior the 
>> default.
>>
>> IIRC the whole deactivate thing was added as a workaround for 
>> multi-byte scancodes
>> getting split-up during suspend/resume. I wonder if we can come-up 
>> with some
>> better fix for that ?
>>
>> Regards,
>>
>> Hans
>
>
> Hi,
>
> I tested the same atkbd_deactivate_fixup on a Lenovo IdeaPad Slim 3 
> 15IWC11 (83RR), which was affected by the keyboard issue previously 
> discussed here:
>
> https://lore.kernel.org/all/20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com/ 
> <https://lore.kernel.org/all/20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com/> 
>
>
> Without any kernel quirk, the internal keyboard does not work. I had 
> been using:
>
> |i8042.nopnp=1 i8042.dumbkbd=1|
>
> which makes the keyboard work, but prevents the Caps Lock LED from 
> working.
>
> I built Fedora kernel 7.2.5 with the following additional DMI entry:
>
> {
>     /* Lenovo IdeaPad Slim 3 15IWC11 (83RR) */
>     .matches = {
>     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>     DMI_MATCH(DMI_PRODUCT_NAME, "83RR"),
>     },
>     .callback = atkbd_deactivate_fixup,
> },|
>
> I booted this kernel without any i8042 command-line parameters.
>
> The internal keyboard and Caps Lock LED both work correctly. I also 
> tested suspend/resume and a cold boot, with no issues so far.
>
> DMI:
> LENOVO 83RR
> LENOVO_MT_83RR_BU_idea_FM_IdeaPad Slim 3 15IWC11
>
> So it looks like the 83RR can use the same atkbd_deactivate_fixup as 
> the 83RQ.
>
> I can test a revised patch if needed.
>
> Regards,
> Martino


Hi,

Just following up on this.

The 83RR is still working reliably with atkbd_deactivate_fixup after 
further use, without i8042.nopnp or i8042.dumbkbd.

Would it be useful for me to submit a separate patch adding the Lenovo 
IdeaPad Slim 3 15IWC11 (83RR) to the atkbd_deactivate_fixup DMI table?

I can prepare and test the patch on the affected hardware. 
Alternatively, if the generic solution discussed above is preferred, I 
am happy to test that as well.

Regards,
Martino


