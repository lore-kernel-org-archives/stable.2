Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810195;
	b=XUDHe7zNvtfWF2uLuRCJ/vU61OoPCqM2yPeZSpjrOOqLelZrmzO6SoCkSX/WSj5WqF16
	 Rn9zSxfqGwpwjOsEWnIop98BjXLMi3Tu5a0yyIRfnNNM+x0seBGbQwY6TalMHGMO/u+dU
	 8AYuZTR2PhLw2smL+9n3mEUo98LRkQDwcgJkfqMUyeIzF/ca4p3F4tTFYyPybscGt0gcd
	 Az/KiwAG7e+OQt9T53Oa/mHr6GDIrK+xYPjQW7ZysT4EHaMu8cbi0JAJQZunjiUGLuJP5
	 MlOqEv8MmCWUCISuQUje04XWBUozS+3JNE32YL1saHAHxGxIWaxkKrOqOtK2ivJ/Jjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TYgm2qFe044UpfvwwJj7/YqIL4ACLlokwv9PNbM6nXc=;
	b=d1VrYixjw9fkWheXRvYHsdB3VowP/16+r7X/meYUL0bVdbMdtelQUb+L8j/8kEttDyB8
	 l0sR0UGCE2d5s24DF3LMXkO36+BygUi8+FZjH+IqVcqcPGy7uL+75WHQthbvRiboALTDi
	 GOhLRiRM69dgd9kPYFTK691mHHjDLZo4BTwne54gxdbrG4P25DEGTtv/yhT+N5lH+ZFsq
	 u2MqUIU4ptyJcTfrkQjgphgxDR9vbCebcJ5dOpK1N1JSJbiLEI1vEzfonD49D2VpmwoL6
	 LTpdW5UgjU7UR6TKQTuBQX/MPKQgk7+bbbCK5GVr6fPCrQW9eZ8L1xqn6lQj7fcfuvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kqwHOc00;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375E606EE9E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F375E606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kqwHOc00
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550c917fd3so1304356eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810194; x=1794414994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYgm2qFe044UpfvwwJj7/YqIL4ACLlokwv9PNbM6nXc=;
        b=kqwHOc000T/2Pa9KHyv5aY/uESI11CsN70YBPvgz2TcfP+xJChbQx43TJi/B+Eg/pr
         dm7x1fapTk6PxEBNAcTFB90GRwhgescuLWN22pjmerNU7pQhbtJOXQYUsBqR2IDbHo7/
         aTyDvfO0tDTzCHb/dq8dtS7D1mb1zYmIXNQ88U/JbPizbL2sPBx0oBydwgDoGQzCcmEf
         DC4UhoIrIIpDaKQKSZ3D+IlXuRgwy037sYnE/A1OW2gdBRE05VmR14NWXyZaSLpQlYCa
         ufu3Xy+CYRIY0m1DAPtkim0z3wJMYOIW6n0AumOQ0VrXKevcGp8wNH7M2/+6uW308qlz
         dUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810194; x=1794414994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYgm2qFe044UpfvwwJj7/YqIL4ACLlokwv9PNbM6nXc=;
        b=l1A4oZ3vx2gi58vJP3wHoJmq8a0MMrASgK9Xq9Htbg32PlOGSJ9oRpHci5DOe97Le6
         GijhGy4Gz3fbPFmS2ProfjoDmYXHbTFEStKdnjSzo+dENedxZZ0tBGoAQwsktDymgJzx
         nuvyl5cUDIVJhRaP6MaMRyKjKMPcHL1/9Lx41C8S1PtpKagF/i8CzAdb0cyBbg/9VCDr
         pXl2/y6APkQ6Kvye1VDpiJyIlyFXObU6RqkkA303hCUEsg+TabSFCoSOixxo2o1WKusa
         9+DkOA9vZeDPaqQA3bAuiBPBAf3AljMenuJZU+0xzQxnmJOsFg94I4ehhhDWXZULr0XD
         6WSg==
X-Forwarded-Encrypted: i=1; AKwUvBybVTP/Z5DC9vORP1Wlwh+nQtFiEYRUI/+AcdW9lTfP39PhzfUmDjd0X0Jv0AEI8wGs9btH/Es=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f4kys0m4/LSV6rpG9O7xoTx9+XApFdddXhaxTdoH8T6DbMPjy
	SdTuJV2aof1+RcuOZJHDYDFwcoaGw2j1nmni2PNYoUu1PU94fz7Uh12I
X-Gm-Gg: AYBFou39k4tMWOyd5ue2wj7HW2HaXLztjAFZlLYz5o/3PKGTBKEeslL+561r5H7j/i0
	Hl38CehT+vr56IIm5aaCGcD7YvQXNM9CAiGHszItL24/k+H59YTLc/fVsbckHUKVYXoocteMZDN
	+l5qtXrdP9bboIy7eaCeeRXxqRKCekwC19A8VdrmF/ePF8+BkJfCQD5CN/W2SSBr+ZGQ9zM6QP7
	t5YUGZf194D++47UuBMexl5xM7QQY/uznqsKLG1z9w+EOgVH+ArnlhVR50dunpFrZddHRJC8IGi
	uYfp6csw12RxfKo64+91gTJKmJ4WTEjhvthCCDKXpP0hcotJVd5kihgFJ0CKEgdyhvGpcDXZwFH
	h+4nnzr4aZLY/b9ryJD4nEiJcxeW5OU8bxP4Af6OFd87T+VR+jw0moxlQHu5x3rS+cgtDiazhTp
	gaoeJl77TYgqImhzwb/kMi73zwcpOx2/XNSdXy0NakRPDrwzBodHpTVszB3MOtb94KlDh5+5RXJ
	cvHoBUSnWiVwsNd0TKe6xANHZwppjRgkwz9C7Sr1H01TWTRIgd1LgGWTeT+uE06L9bOkr7NkZ1u
	QU3j5TlPupJFdtr1oIhp0u17E1uo8V9TmZHFJYaS9ISaWBpdmCOYePOEBYR/SrfXsYWeGMSPQbZ
	j4vMGgw==
X-Received: by 2002:a05:7301:103:b0:36c:9af3:22eb with SMTP id 5a478bee46e88-36c9af32cb0mr6408365eec.34.1793810193837;
        Wed, 04 Nov 2026 08:36:33 -0800 (PST)
Received: from localhost ([220.196.228.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3958746sm9327852eec.22.2026.11.04.08.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:36:33 -0800 (PST)
From: Liang Hao <haohlliang@gmail.com>
To: ralph.siemsen@linaro.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	bartosz.golaszewski@oss.qualcomm.com,
	sashal@kernel.org
Subject: Re: [PATCH 5.10 159/595] gpio: dwapb: Mask interrupts at hardware initialization
Date: Thu,  5 Nov 2026 00:36:27 +0800
Message-ID: <20261104163627.92404-1-haohlliang@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <auj7ZUcOlNC-rEnk@maple.netwinder.org>
References: <auj7ZUcOlNC-rEnk@maple.netwinder.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 2, 2026 at 16:06:45 -0500, Ralph Siemsen wrote:
> This causes a small regression in 5.10: the gpio-dwapb controller no
> longer produces interrupts, because nothing undoes the GPIO_INTMASK
> added in this commit.
>
> Only 5.10 is affected, because the following commit was not backported:
> 1cc3542c76ac ("gpio: dwapb: mask/unmask IRQ when disable/enale it")
>
> The earlier commit does not apply cleanly, due to changes in the
> context, but it is straightforward to apply by hand. For reference I
> tested with the following and it restored the interrupts.

Thanks for investigating this and providing the fix.

The proposed fix looks reasonable to me.

Thanks,

Liang Hao
