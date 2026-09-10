Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4244A0F0B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051934; cv=none; b=kW/zwo0Eu9uYyk1/UyfwXSRK69Uo0Ew2BI6Ev1JG/hiObgRdVcd7zzIx14yqgnsCdf5KbxEp11a+6lHrWwtc43kxlzNg4D75gP4usUMUPcxvyyJPoCBE6MNeKQfj+jqPNx2U3CQuGzo8XMjNuzTNRiR0LpSchOvWoAvccfuGqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051934; c=relaxed/simple;
	bh=oL4ISteGLta73I0DppH9tBtmzkKniaXiRyjM8T0tBVg=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=oXVVUnspFoy9xFiIw5Ja/DGU+TjTBLO5VAsk+srP60B41I23Vv9E63NbPrdyTzVCAI0+2Vs3hRFsUKzeYnkgJb6jQNo+v05gSTbArTYYnYAwcRPC4r4y3se4lN9av9ZMgHhA2s28QundXGL7aM7F/RQQGqUOvHxp3GNzSnJ/yOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz; spf=pass smtp.mailfrom=swiftden.buzz; dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b=wFoo4zg4; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swiftden.buzz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swiftden.buzz header.i=@swiftden.buzz header.b="wFoo4zg4"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66cf1f9965dso6201276d50.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiftden.buzz; s=google; t=1789051932; x=1789656732; darn=vger.kernel.org;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oL4ISteGLta73I0DppH9tBtmzkKniaXiRyjM8T0tBVg=;
        b=wFoo4zg4NZAU3u9daBOH6PHwd7Jpe62iAhuUssoukG2L4oaKFYx326C0iJrinrQ7uh
         7Qcf2JpHQrlsBwSeqK72wWcaC0hbKvqZqz6BBJqsfcZ2msPVQuGrK+mxpexo/A2EkH7c
         zp4vUQk/NLCt4LtCHMmHxmFcVbmXvWP48iQUVPHkWN4f6Vaq7GSLfrgxzeZtq/Sq0TRh
         rrYW/KHKkzaONyLkx4JetLXQEyhcu9M+Cymeyn8ecHTiZzchVYzVc+d5trdTOa3OOvEH
         3jl5SbvoPuESJoVyGJHPZGghgjquQ0VSOxeE6EZZTHuO2YKFZJgeGmDXgZEVZEZjPovX
         UGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051932; x=1789656732;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:references:in-reply-to:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oL4ISteGLta73I0DppH9tBtmzkKniaXiRyjM8T0tBVg=;
        b=SGClU7Ggkk0JEh5NGqR7F0xpaJSrN2QB3tsFtIdcu+XqLOw4NjAhRXejImkI5kUoe8
         uIBZienSTyYw55WyYcLVc1kc21HQAcEMoMDAfF7ic0vnzpoM5xcCbhmdum8mgAk8Cm3F
         0WkTjQrmGv/r4KKR73PstwR3w75u07C1oK039+zXdpe3bn5gzITDJsWl7erXJg7HzXk4
         eSr44P5EGHa3gbL7tH+OLNEeJzw5K61oYQ+mcPPdSFfD8eP5oKRvZzjbW/d4nUv0piwk
         h70U+5V3BM5ja2Nm255n5ElMikL1YX8lPzKgm+vhco32izpShkpzW5/DRC8ansW5Y05F
         PZJw==
X-Gm-Message-State: AFuF++m12RYmvHR4rIA7n4Seh79cTU9bvMrpaGie7id7Xc99qLc0gRe0
	NvkEOfWoGxISlCJWjPr8EnrU/NGBqH4Y3M+SkQG6HcySyPupc3+DQkNj0hlWYCoKjtUQSdiNtY8
	Lt3XRZQ==
X-Gm-Gg: AYBFou1Bon3bxjah/wjwdNyBM8296/ywHP1iwyfjpioil0zVqcYBJxkhsMuyE/3nTqc
	IsvcXPkb73EjM4fNEV6bbPyzWwrTDZC2ynQvtCGEfp/uuesn6omzKLENP8tqec9ass+IHCJNAB4
	siAB2b6me0zVakWxmMMWlK/10xfww7HtnDVPUb0NyNLOs2IWACPZKSgEiIp6kanlqSrG4Ifk8Hw
	8P3wKcjZJFhMYdDbyQxd9gvuBKOncKbJzi4c4/2HFhSlUhWBdjAqdWG6off4e9zghSaYlsNMMx9
	FeqqvBBwZTRbNhIbwwF6eVrLYbvRdBuGLWYtzujQqiPRclvSSwC+7MZZkfRfggxR1t6emO3l5EW
	YtkkdRoNIy0BDt/brk9vDz5xKAiqRfGI5+SY3uLfWs5D2xwZC6HS8dSfgP2UrgUXU16D05BTNQ1
	HrwBFjoJUnpYQiEYwchrIqTCQ7x4POf9Ie81LnW+0fjQfBKG/9J1/2RRuEiAtDjLCesmLf6iqFS
	7BSxmf/2DaB/r5V3N55Wl1ih4Im5VKp655AvpZqjSzx1fxw/Mf5hEwdQi3Z8+5JB741/N5nBtpq
	cX4EW88eHW6IG00=
X-Received: by 2002:a05:690e:b85:b0:66f:ca93:eae4 with SMTP id 956f58d0204a3-66fca93ed15mr10134787d50.92.1789051932082;
        Thu, 10 Sep 2026 07:52:12 -0700 (PDT)
Received: from 01a08bce-0a4c-7572-824c-296398214cf0.local (ec2-100-48-62-121.compute-1.amazonaws.com. [100.48.62.121])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8b8fsm14065026d50.2.2026.09.10.07.52.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:52:11 -0700 (PDT)
Message-ID: <01a08bce-0a4c-7572-824c-296398214cf0@swiftden.buzz>
In-Reply-To: <01a06306-ee90-713d-888f-101a10980a7a@swiftden.buzz>
References: <01a06306-ee90-713d-888f-101a10980a7a@swiftden.buzz>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/01a08bce-0a4c-7572-824c-296398214cf0
From: Todd Ford <todd@swiftden.buzz>
To: stable@vger.kernel.org
Subject: Re: Offline bad review
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:52:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey, I'm a real person not a bot lol

Would removing a few of the negative =
reviews help bring in more clients?

Open to explore this?

All the best,
Todd

On Wed, September 2, 2026 4:49 PM, Todd Ford <todd@swiftden.buzz>
[todd@swiftden.buzz]> wrote:

> Greetings, just wanted to follow up,
>=20
> I also came across Wendy left a review saying "This was my first visit to=
 the store. There were lots of cute clothes and some good prices. However, =
when we checked out, an item rang up as 25% off instead of the 40% off that=
 was advertised. When we questioned it, the cashier said that was how it =
rang up, so it was only 25% off.
>=20
> I walked back to the sign, which =
originally stated 40% off, and it had been switched to 25%. I=E2=80=99m =
thankful that the customer behind me in line spoke up and said she also =
thought it was 40% off, especially since the sign had been changed while we=
 were still shopping.
>=20
> Another employee later told us that only the =
sweatshirts on the rack were 40% off, which was not stated anywhere on the =
sign. This felt like false advertising and was very disappointing, =
especially since the only response we received was a brief =
=E2=80=9Csorry=E2=80=9D from the cashier.".
>=20
> We can eliminate =
multiple bad reviews to strengthen your online image.
>=20
> Can I give you a quick call?
>=20
> Best,
> Todd
> On Thu, August 20, =
2026 2:35 PM, Todd Ford <todd@swiftden.buzz>
> [todd@swiftden.buzz]> wrote:
>=20
> > Hi there, are you in charge of Offline?
> >=20
> > I was browsing some of your Google reviews, and one from Angela Russell=
 caught my eye. If you=E2=80=99re interested, I can have it deleted for you=
.
> >=20
> > They commented, "Had a staff member order me sweat pants to =
ship, but they ordered me the wrong pair. Apon the returning I was asked if=
 I wanted a refund to original payment or gift card. I asked for my =
original payment refund and they are now saying a week later they can't =
(only able to do gift card apparently) and now I'm out my own money because=
 I will not be returning. Worst online customer service with little to no =
help and a bunch of "I'm sorrys"
> >=20
> > Would you prefer this review =
gone from your profile? We focus on removing unfavorable reviews, and I =
observed you have a couple of other critical reviews we could help remove.
> >=20
> > Looking forward to your thoughts
> >=20
> > Stay awesome,
> > Todd
> >
