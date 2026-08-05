Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BD3A641F;
	Wed,  5 Aug 2026 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908460; cv=none; b=XiwOEkX+cK3j27aATHelXpXHMmsqcPLwPyJzsCIhqq130EHX59qPCG0s+TZoWIyf/UCLeB+ywk8SzpVn9NX9mdm169GY6KZnOJZq3+Ik02tt7YDlp6iHdL3UIJN7l9Og02sEtSUc8T9BpdQ5oGbB6j+nGAkalcHnC6sv2XF0qEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908460; c=relaxed/simple;
	bh=KLD7aeDNpCWZeixms3o73m4lwKNfa6f19RktPCodg/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCVwyg/8QqarDrMEmJvfENel8eaaeZDx+O3Jc9701NX0wAqyeqPCSysEsN1MVUqbc9yp/FoVjzflmeSmhe8IS3dMzwhpje2Cb7JQc27TtjfiasmMr2fhO2qCzMvWRMUTL9x+AFZLunCo203RFGX8dPY4uYHUQir7iTX6KqQfICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nfPpv6nS; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nfPpv6nS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785908424; x=1786513224; i=markus.elfring@web.de;
	bh=KLD7aeDNpCWZeixms3o73m4lwKNfa6f19RktPCodg/c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nfPpv6nS4O4GpPZVmSasSZFOGvRYkm0zzFICDjArW2RnTh4/SzOcsykHdVf/e2Oi
	 awqNo9ol+acYTMUdpfym2uxpVGR1MHH3EGmg/w9JK6XrkG8l3DTPOWMTQGb8jDOzX
	 T8jLGnjYsolGT2ZQFfPrIwcSs+2a82w4tZRnXRuD39aIgKoslsNrDnAInJAnuO4W9
	 PoLA6ZLxSwZWy0zzr3JqVqG6iJsVtWHQlapFGC0eRDBkHQyhdD7CpmIET3LPxJlmN
	 LYcwygavAMlkFelZWQ2L9wweidhFvEDQK2gdFvQVyTCyz5kot12XS6UuEPpzF6sab
	 xe5/pNATYvajUHREKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1xMALw0OTg-00Zipc; Wed, 05
 Aug 2026 07:40:24 +0200
Message-ID: <f872c251-6558-44c5-8be3-e892afa5664f@web.de>
Date: Wed, 5 Aug 2026 07:40:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: solidrun: Free IRQs after request failure
To: Xiong Weimin <xiongweimin@kylinos.cn>, virtualization@lists.linux.dev,
 Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <178589471328.1556376.15570536900532373521@kylinos.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <178589471328.1556376.15570536900532373521@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iN8HX9pDmUxKhwmoHf0WliofVci/F50YpxNXxzGyCZeYLs7AaRC
 vDO+7iTbGJwFwjimh9LBp2FQfTzCppm3OY75a5pnXN8lWTViDHBbyFUfW5G1BJ7jUc92prh
 wmliBBadFq5/aPUXxACeX8wZeX7nHlAnQ5RCrspbkLUbIjBhe7tdnHb8ONB/HPjww02DBMt
 9dt7pcuWQB9vJbcQSuOhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4ZRVAa8Qauw=;bmuiuN5c4xRyFB+tNHQilGMYrMJ
 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

> Unwind IRQs already requested by snet_request_irqs() before returning a
> VQ IRQ request error so a later DRIVER_OK retry starts from a clean
> state. The IRQs are requested and freed while the PCI device remains
> bound, so the driver cannot wait for devres cleanup at detach time.

I suggest to avoid duplicate SNET_ERR() calls for the implementation
of the function =E2=80=9Csnet_request_irqs=E2=80=9D.
https://elixir.bootlin.com/linux/v7.2-rc5/source/drivers/vdpa/solidrun/sne=
t_main.c#L400-L426

Regards,
Markus
