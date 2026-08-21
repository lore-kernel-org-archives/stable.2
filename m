Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4F4078EE;
	Fri, 21 Aug 2026 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340091; cv=none; b=VZy6CxjyW2WmqEtwHDXNi3h02n0+bF7utoFg9jW0CL7euTq2s2wHUq4kgwZJP2UuQz1+v7TdTHlxu0CFIcegz7g8XKMW8LtYQSBRQJF5c437JusqVOEuUB53Br12ntCnDMsINb1oKwhGOZNlV/uZ9sLhgDwB71K0kHDW/en5o8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340091; c=relaxed/simple;
	bh=W+jSF2/PQyIWS5jx2LYAKZmVdlWg4dx0QPg73MFnC2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+PfZB6r1zl3MUT3qIeVDz7UC2zfLf7mOTaRk+ncpKVkkdy/fCkJmd6SolYOsRDzrdnPs374rt3gUcGncOyVObMgygi9cg7cggqTqAwGvdOThEeO09NOtljvZTbxgiuitRsYilGP5LAKkpk25E257XjJ2rkMS2P7PK+JpiOx1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=hIRTAgDM; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="hIRTAgDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1787340070; x=1787944870;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=W+jSF2/PQyIWS5jx2LYAKZmVdlWg4dx0QPg73MFnC2U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hIRTAgDM7JRrAPGEo+1dxcW8r0Sdm9OPOJFwunjvSxlQJw6qusf+sLkZohqZ8ZJV
	 uOtOj5+lWauf+cVgYZaVG2tkPWZpKUhSZEsRW04xrkdIH1vjH9H1oC3WHfhVH3prf
	 qUU3ebRbD2nztgUt9HeCSfYVZAjfknKsG5DXYJy3ovoon2VADg/KdgNPN5CLOh8Wv
	 pZgURlUeay+p6Gzz1ryOdkI7NbKU/bsSkSpClFrVGZ+q3l+WBY7nyeryQbPPMP4b3
	 58+3sgb1iurgq2s7KPYpu43kTVlp9ZnaI8IAncLMfLqMnvtJSqH5V8Lns1AriPeqx
	 KcCu0QivU7krRtS9pA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MJmbB-1xDFKp1Ak5-00RAqH; Fri, 21
 Aug 2026 21:21:10 +0200
Message-ID: <8bdf6062-8ec2-4c30-8463-0368d3a0f1ce@oldschoolsolutions.biz>
Date: Fri, 21 Aug 2026 21:20:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
To: Marek Vasut <marex@nabladev.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20260817182302.146546-1-marex@nabladev.com>
 <aoSFjbydIiu4KyW0@venus> <dfac3134-920e-498e-a59b-720a6c51b82a@nabladev.com>
 <1aeaa585-79f2-4f43-87b1-2ae3925b176c@oldschoolsolutions.biz>
 <71fca17d-9b6b-4c9d-b595-ebd1dc6605de@nabladev.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <71fca17d-9b6b-4c9d-b595-ebd1dc6605de@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a6TAyRFwS9BnnIzj857LpTlBmY7jtBAF/1pziOtR27K+wUOJRXQ
 wT0wULh7ul5+8itjVOX6OVYSoksrCOdwkkY73CigdpuV7Q7gjblXdi248SiXH5e5J8EsMKx
 /jLOPu4abKeYYatY58s5ZB/yveRHfriVbdht1r4Cen6dB3+BjtCbqTeOt0wN8DuW7ald6KB
 bpRY3Za0QdBm1aT6tSHZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5K73dGz1qkA=;pIZSb1loKCDQMJRC5Jn11eMbKa3
 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
 HuOPkDPpJFI6sTw5QqkKq+pFN2U6FfAD1PGwD2I=

Hi Marek,

On 8/18/26 19:43, Marek Vasut wrote:
> On 8/18/26 7:05 PM, Jens Glathe wrote:
>> Hi Marek,
>>
>> On 8/18/26 18:56, Marek Vasut wrote:
>>> Hello Sebastian,
>> [...]
>>> Could you revert f576c75f95a5 ("Revert "usb: typec: mux: avoid=20
>>> duplicated mux switches"") and apply the following patch (equivalent=
=20
>>> to this patch, applies to mux instead of switch) and see if that=20
>>> fixes the T14s for you too then ? If yes, than, I think this might=20
>>> be the proper fix rather than the revert:
>>>
>>> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
>>> index 4a4297f15aad3..afa6fc1813978 100644
>>> --- a/drivers/usb/typec/mux.c
>>> +++ b/drivers/usb/typec/mux.c
>>> @@ -294,6 +294,8 @@ static void *typec_mux_match(const struct=20
>>> fwnode_handle *fwnode,
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D class_find_device(&=
typec_mux_class, NULL, fwnode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux_fwnode_match);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ERR_PTR(-EPROBE_DEFER);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip duplicates */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < TYPEC_MUX=
_MAX_DEVS; i++)
>>> @@ -303,7 +305,7 @@ static void *typec_mux_match(const struct=20
>>> fwnode_handle *fwnode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev ? to_typec_mux_dev(de=
v) : ERR_PTR(-EPROBE_DEFER);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_typec_mux_dev(dev);
>>> =C2=A0}
>>>
>>> =C2=A0/**
>>
>> I will test that one with the=C2=A0f576c75f95a5=C2=A0reverted on the x1=
p and=20
>> sc8280xp boxes I have here, let's see. T14s G6 shouldn't be affected=20
>> either way.
>>
>> with best regards
> Thank you

I did the test: switch patch, revert f576c75f95a5, mux patch. Afterwards=
=20
let it run on the zoo here... ps883x devices are unaffected and work=20
well, and your proposed mux patch appears to fix the problem with the=20
gpio-sbu-mux, too. So it would be a good idea to do this instead of=20
f576c75f95a5.

Tested on:

Lenovo IdeaCeentre mini 01q8x10 (ps8833)

Lenovo Thinkpad T14s G6 21N1 (ps8830)

Lenovo Ideapad Slim5 14q8x9 (gpio mux)

Lenovo Ideapad 5 2in1 14q8x9 (gpio mux)

Microsoft Windows Dev Kit 2023 (sc8280xp, gpio mux)

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

with best regards

Jens

