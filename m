Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF943ED5DA;
	Mon, 21 Sep 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985781; cv=none; b=UdrbqSmf24FuOfDArAXSoNyNi9Mm1tDJfaXVxrb4MhrY69M2T+eyeKgXs9uK2Hq9XnwL14MjRg+ZbmdBfFMzjCV/IgzD+xSntdcppAnAPsVzPFomyXsNZ6BSkm21WmxmLKtQw/jOX3NF/oH4JAaL1UdTSn6bLildZ/bWlru1oHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985781; c=relaxed/simple;
	bh=+zxue4XundghdAhPo6uXDnd8g8TTcWgJPx7kZ0TNY3Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RXUsvi7YIOjf+44MchgaJYYcIttU1VX0LrZINKJmNjWEirCH4Ky3GQyFrE9gD/JdMDsBnbbMt0PN4vfz65EDTjzseN+CMyjUf8Yxov3LZNX41SiCcb0bByWY+NjAgsuwVddgy+7JQSFRCpW2BK8AiEOMhXpfTEFmqBEMnjbTtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PYJb/e/k; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PYJb/e/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789985777; x=1790590577; i=markus.elfring@web.de;
	bh=rm1HAeTC6ZoT91AJryEGO7FwwoHM06nAbPC2un7vNcY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PYJb/e/k8BQVsQD/vlYxbvz0KGoFAznedGYWo0b+rdLoicTS5L5eSc5Z9EDldUMh
	 kE7Wnzit/wHJvEwHPXDbOSgeeSs4aNRzbWRBWv2x0mEJ0NIBtZ//zFdsRE43eAe9o
	 EXYCr7KkxjSSFUgPI3mQGUTFe7IdbQ3uRUna2Ymz6j5i4amJoL3hGec2XjI0TGzFg
	 /Fb+uLvE5n76CoFOAK8swY5h3fTF7jZQY9cLlPE5O9U/WZeQuWORkEIDivB+FUlNP
	 kWheEC7VlYfYAYREwOdbsmxvloUzWQPMAH9sfGO+jd0fsEv1gmNj/9ljng4ru5OYY
	 OX5knnFxk7jv4JSr9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1wk5cY0hPi-014I9n; Mon, 21
 Sep 2026 12:10:36 +0200
Message-ID: <cdb67eed-9e75-4310-ae4f-21ca67f20bd2@web.de>
Date: Mon, 21 Sep 2026 12:10:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guangshuo Li <lgs201920130244@gmail.com>,
 platform-driver-x86@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
 Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
 Hans de Goede <hansg@kernel.org>, Henning Schild
 <henning.schild@siemens.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20260921075312.120983-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] platform/x86: simatic-ipc: fix platform device leak on
 registration failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260921075312.120983-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MY4LaKt3evXalICs3hy3fcoAgp8/XVPYVf56eH1SBBQoo7IH/ZD
 sfzZvqpp96G/9Q824tcGX8KV3IIkiIY0vC2rD7lt7bgLl2IVb7AtZguCkFoDezkn1dnsZIv
 U6AkXnHWUNmMCyzazcx09Q3nLrULYZl7xAvLwMSy+1OzbrVj9GrPs0TVSm8fS5QWM3cCa4L
 cjSOnzyOcltiP2+A3AImA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UaiRR6+Cqf4=;5ei02D9rpHpQ1N/jb+VfPw5LmC8
 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
 A=

=E2=80=A6
> +++ b/drivers/platform/x86/siemens/simatic-ipc.c
=E2=80=A6
> @@ -118,8 +119,11 @@ static int register_platform_devices(u32 station_id=
)
>  			platform_device_register_data(NULL, pdevname,
>  				PLATFORM_DEVID_NONE, &platform_data,
>  				sizeof(struct simatic_ipc_platform));
> -		if (IS_ERR(ipc_batt_platform_device))
> -			return PTR_ERR(ipc_batt_platform_device);
> +		if (IS_ERR(ipc_batt_platform_device)) {
> +			ret =3D PTR_ERR(ipc_batt_platform_device);
> +			ipc_batt_platform_device =3D NULL;
> +			goto err_unregister;
> +		}
=E2=80=A6

How do you think about to avoid duplicate checks and variable resets
in such a function implementation?

Regards,
Markus
