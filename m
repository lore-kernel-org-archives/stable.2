Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF238437130;
	Tue, 22 Sep 2026 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068073; cv=none; b=er8i+OA/c9FDkjvtuDJl+rdvfdcmrb5CFFkMuxl92ErELUMMiFY2L3EAcPEFV/cVSWN0or8xfs3k6PEDrMygoj8X5YytHmi+fAxesCbbgYgD2Y7znBZJWdZzTAA3fOrHRkMXLaOch8htGvQ/gi2S1KpZdZeiebtkI4zwFeLnakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068073; c=relaxed/simple;
	bh=UVAQGIca5VWKSCNT7YEDdXCZ+KM7/2fzl7Rn5zW4Kik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUanVU7vQRE1RS7oNd0H2/jqjS/Mos/qDWgQ1CMGW0lB/ObLHYSi3bqtpzFpfYADnt5TsiWvO2fQ5spHg5uphjWhko1QL8mGx3+f0VD3txhgP2wbpka1u3j+mEi829aXbV5uccQQg+/WGMMONsHWIHPuVcet/jlYRM5OfAbZuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WzaDY62/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WzaDY62/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790068050; x=1790672850; i=markus.elfring@web.de;
	bh=ZpeZmx6qMtsJjdwBX9521OYFfWQPRVX4NgiXC90ZrP4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WzaDY62/hWqnkCD/cKcSUHDHtEDnTw83Z1P8v9KYtQBCX2dSyY/K2f5GSdcFjSzw
	 Dz+sOukEO0GSJI3rC2K2mkeCLi4oca86hIbR0mNuCujPMSPWWAWOyLQ55lllHEbNf
	 Bm6j6hzUPcYl9pKCdCq/6eKHgoRodjsI9E1qCUesooryMrgJbrIpPTHN6QfDrNApT
	 ZPLhj4I2pbUlLxUQ2zZyhSaaOyahljAz4CF9NT7LeS2lPG2ZHohYM8G2jx+EPfrM3
	 wFZHvMsEELI15ryJAAkfU5ul4Vmn0Bfi7c0bd/EgugP8G7iWM+Aq7HqpyiBVcOEe5
	 oJReXSChM8+UZ5f3Wg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPUE-1wSmIy1Okk-00bHD3; Tue, 22
 Sep 2026 11:07:30 +0200
Message-ID: <9a96d707-ee9d-423c-86ad-2a1328b88fdf@web.de>
Date: Tue, 22 Sep 2026 11:07:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: simatic-ipc: fix platform device leak on
 registration failure
To: Guangshuo Li <lgs201920130244@gmail.com>,
 platform-driver-x86@vger.kernel.org
Cc: Bao Cheng Su <baocheng.su@siemens.com>,
 Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
 Hans de Goede <hansg@kernel.org>, Henning Schild
 <henning.schild@siemens.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Tobias Schaffner <tobias.schaffner@siemens.com>, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260921075312.120983-1-lgs201920130244@gmail.com>
 <cdb67eed-9e75-4310-ae4f-21ca67f20bd2@web.de>
 <CANUHTR9+rLuPrd1aifKws++POOKSm+2jxBaJaC1iF5z5x0e13Q@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANUHTR9+rLuPrd1aifKws++POOKSm+2jxBaJaC1iF5z5x0e13Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XuEHa3VN2LJpQiP48q9ctz5EtuX4ss0zjc7wkOlj7W0Kcd0pMWu
 pFbEg9e4yU+qJs183OU2sftzw5V9T0sqsZ+b3LnSeZRGHI1e9CkVy91BclOSYF71kOPKA3y
 dN5fO2GHbJgIcTf7fr1dLUN3SVeM8Khrj6rI/fgE/QTEZSeKWMVQSLGyvZ9ugTQ1z0/KsC2
 ryFPk0FqMn0PzEhdjVAHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZqnABTHnTqQ=;sSOQxmthe7xEIdJg3GgRr2zo/DT
 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
 8=

>> =E2=80=A6
>>> +++ b/drivers/platform/x86/siemens/simatic-ipc.c
>> =E2=80=A6
>>> @@ -118,8 +119,11 @@ static int register_platform_devices(u32 station_=
id)
>>>                       platform_device_register_data(NULL, pdevname,
>>>                               PLATFORM_DEVID_NONE, &platform_data,
>>>                               sizeof(struct simatic_ipc_platform));
>>> -             if (IS_ERR(ipc_batt_platform_device))
>>> -                     return PTR_ERR(ipc_batt_platform_device);
>>> +             if (IS_ERR(ipc_batt_platform_device)) {
>>> +                     ret =3D PTR_ERR(ipc_batt_platform_device);
>>> +                     ipc_batt_platform_device =3D NULL;
>>> +                     goto err_unregister;
>>> +             }
>> =E2=80=A6
>>
>> How do you think about to avoid duplicate checks and variable resets
>> in such a function implementation?
=E2=80=A6
> Would it make sense to share the cleanup path and rely on
> platform_device_unregister() handling NULL/ERR_PTR, like this?

It probably depends on corresponding case distinctions.


> +static void unregister_platform_devices(void)
> +{
> +        platform_device_unregister(ipc_wdt_platform_device);
> +        platform_device_unregister(ipc_led_platform_device);
> +        platform_device_unregister(ipc_batt_platform_device);
> +}

* Would you like to avoid the passing of any error pointers here?

* How do you think about the relevance for variable resets?


> +
>  static int register_platform_devices(u32 station_id)
>  {
=E2=80=A6
>         return 0;
> +
> +err_unregister:
> +       unregister_platform_devices();
> +       return ret;
>  }=E2=80=A6

Regards,
Markus
