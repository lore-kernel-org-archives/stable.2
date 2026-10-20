Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483350;
	b=WroulXWq6VzbKfOSozQojfz6GTnX2BHm7Nu3ncCd7U6S1ytxKOMIBxozfqsNv//0HEqj
	 B0P0WS228tKxLhBCzDWFYC74rwfyZOilSk+0IafykKB2U9DXaTZ1SITqGLN3Z0xQ9f82I
	 dFonkny+BayqvH8OPX9mqocCgRMfVoK/eJz6aMbpehU/xfYb1UQiVtvbuuKKm4Ks+wPJS
	 xbae8CCHEmYoyFoCtJjROvKU44HQlMXphjBsDVQBqmTuPAjZE/Ej+KRBMuqydPnd3o3ei
	 QrCJZu3HbEX67dd9WhPpciHi8S7sjyNzAdiasE3vOPpRO/s8qoEjnyO0W70edDXTvig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483350;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=Fo3vwrE7fHnIYVTUYb0Nag0rB104aRrYkLus86COehs=;
	b=B368DiJx1g6w1zM0t+ket3fOVCD+HiqHiaa1FJZYr4YsbEF0KisSLKE3cLTNdTDKb8QW
	 IngmR9dQxQZLcAd+aVWnXgSJBi8neIrY4VgQ1rxUv9GkwQPHZ/0u1ayXlHl1UbIzWg2NN
	 zBe5oax1OkgweNeBdLhi23/1UCzuXzt6pRs2+qPQPD/UHSHyK2BLWktamcOCShNCrqM4l
	 qeu0X/k94oYlN8pIiEZyP3pTvAZ7wunSGgwFSYV6qNu6zOIGlyBQpKHQOv7d3MOW8hPG6
	 94fAg2gxRG5gm27dq5w/ndbVTlyjvyZdedk1yLJIsMLnd2o/7Of8FCnaU3ips8CxGkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GgQIGnOX;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA3606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8CA3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GgQIGnOX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 89F34C63454;
	Tue, 20 Oct 2026 08:03:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E90460393;
	Tue, 20 Oct 2026 08:02:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D54501032840C;
	Tue, 20 Oct 2026 10:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792483344; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Fo3vwrE7fHnIYVTUYb0Nag0rB104aRrYkLus86COehs=;
	b=GgQIGnOXA18Lmuu9VwsgPu8TONd4flhmla/Re1KJ7Ha+IXljck3OYIDdKLz7mzkYfLPB87
	hJfbMwtlU9RJ68ggMah+xs9Uth0a9iJvmQZiGVGY8H2EPnQ+GQnnBnDcFfgohNjND3RvNJ
	tBBVVhUHNYgTsbKxVarlSvbkbsNlOPE46zOOKOcx0+6RFWD1/yd1foT75IkdgB/TD0LH7y
	GceC46n793POCNUBXCQwH+VXnYWU8v/e08ZFYwi9gbVdso+dTXlo//JoMm63u5Mib9hdNh
	4GHoWw1nLfmhu83ItJVURSHcgzGB7ZVJ4tAL+7EpJc8K+qORaUL2Yg5UqzeD7g==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 10:02:22 +0200
Message-Id: <DM9IBBKOPUC2.2TAO8GMMX63MV@bootlin.com>
Cc: "Tzung-Bi Shih" <tzungbi@kernel.org>, <linux-watchdog@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <stable@vger.kernel.org>, "kernel test
 robot" <lkp@intel.com>
Subject: Re: [PATCH v4 0/6] watchdog: w83627hf_wdt: Convert driver to the
 driver model and add minute support
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Paul Louvel"
 <paul.louvel@bootlin.com>, "Wim Van Sebroeck" <wim@linux-watchdog.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com> <3e233439-d05b-4d65-a527-882043d64d7e@roeck-us.net>
In-Reply-To: <3e233439-d05b-4d65-a527-882043d64d7e@roeck-us.net>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Oct 20, 2026 at 4:00 AM CEST, Guenter Roeck wrote:
> On 10/13/26 06:58, Paul Louvel wrote:
>> Hi,
>>=20
>> This series aims to improve driver readability and convert it to the
>> Linux driver model by means of a platform driver.
>> Furthermore, support for minute-based counting has been added to allow
>> timeout values longer than 255 seconds. When setting a timeout value
>> that is not a multiple of 60 seconds, the value is rounded up to the
>> nearest multiple.
>>=20
>
> Please address the issues reported by Tzung-Bi.
>
> Thanks,
> Guenter

Will do.

Thanks,
--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

