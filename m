Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD71FECCD
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790483907; cv=none; b=lAL5abd8UGzbBMGEHAD9cvi8I2Uz+o4oiBd61QHWDw2cA+nN8fVsl/AdJaH0DHqwq2sNktReZQhupZQtHL03aVdkC6qIXAy4BC6bFB+llutlXVPCMThLRPWrX4PVvQ7Bomq05Vu+6mTkwAJZMda117/1fIzMtG2fsT8GfieH74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790483907; c=relaxed/simple;
	bh=Ajv7AzHdWi4VdbT9O5uOTid4ZouF7coYRBVwDJrgpFE=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Zf16sWtzNAulTocjZBh2HTKq4GyupQWHJpIsYPKF2Xzv3dLlZtonXvwjLYaefa4m1YpyVwwqcQTGOe8Zi1WpwqSUXjOHgne2wI8LziV3lkeKfR/1pRg/icTWR11uKw52r3oCS0Y3WigHcAXTfVJDlkI58FuL9s5KvLVbXQbcKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVkBl9YZ; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVkBl9YZ"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-482f6351831so1112659f8f.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790483903; x=1791088703; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:content-type:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LQfLTONnpPcPqJNkX5STvP3m9LYisOqIEmCiMINFFRA=;
        b=FVkBl9YZkf0LaujFF47w1d4NM4LmHpZ5Qiu7gGLGSh4ve+L+i+JgttmJZfHDPg/v5R
         Danus72wzNr39MzXIw1v3qzJLlfNrA+duDarWhUYmru4riXac887ZMcPpDWRjgHQV+TV
         z5xnopz8EbPtA9xOr1rZq6Dr6I8Hqr1BCbFc2URA3JQr/zh1TsyZxiR9uGaom72mmqd/
         gIFhuKoD07eV9CU1Xq8cAhDOa5WKpFemAnLbtoX3Ahf/1nzpvMyBa9DfK3DYgdIYrAyI
         IzphSiUzYYG+8WYTiJZPC2GN8zoikrUJc56AAmTpECuZA8zJAxuDIuj2QBd4CVfbmy4Z
         HwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790483903; x=1791088703;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQfLTONnpPcPqJNkX5STvP3m9LYisOqIEmCiMINFFRA=;
        b=alOp7gYY2WrnC+WMI5DjsURNTaNer0s/PGfRjt29ymyBP+U+xSEGUJJl2QEry/7Q31
         7vch7q88ko1GLOT2lLx3a0ZTJdeg8+Ig7q/LYT7wkp5wNuWA8Xd9P3h58+X/W/QcV85K
         aDr/mFPkiHvA8bW1D8R7r0QIUaAel87NGBJJcDA60UHSygvDvWubRMTNi+tJppGUqXKV
         9IavyWzXBfpO/ScKbhFZcM7PuBD3gwiFzusN4RoK9MCgjz5KcVyea5iO+Gb8+lTq3lI8
         A8kVEqnjSdjBx8HRJBp3kwf9N8ew76i1kSKAW8cLheEDD4cF5C06NMGx8LJVYeHY/EAW
         TrmQ==
X-Gm-Message-State: AFq9FYLtD+bPYP0N0tNVg4wPNZcz5RX1PwdG2YFipmCiFdgQfqayddr6
	Lcfxla0CgzMT9t5AVeqh9MofS1seSJh0BAURKGGEIBKql9tZCBxUXFbdjix9XIoZCOqCXw==
X-Gm-Gg: AYBFou1D71zK+pESB+CU+KZ/v20annl6Qw7GbcKWVrAg+o0HoKIOZz85HzKRNyotth0
	snxj1R0sbSAp5LHIiI6wKDjnXzseel2u9Yocqotjna1NxOiD7h1zLJ/RcgEgrW0GXTFqa0+qSjW
	w+GbM+PBS3wv2GV0L1yJmELgkhsRXoysJVhX/yLjC9Q9VWkfzYw9acx1gdKhrp73O0Xe6puMHUa
	AWfW1bw1AnJ1l+AGaEZU0/ts+8LJHpGjZgld0yTcJofeeNkgbfl0aqdohbmr7I05BU55/iiRlcC
	ZqoJozNnstOMImSL1BeZWpyDHBX7wnGQXuzP/T2CNa3m59DzGNxIA3hSkAvMHTmcU/tCluG+t6L
	x5lzbv1kHxRwyAlwwoEPLsz+5+6+vzMYxT/FB9RszWmj/FK08J21mn46zQnfvTIgRfGjQ1S5IZn
	lMYJYqzdzMvsF2ASRzM1nv32scxFvwl6owg8xm2La58B4ZjDglf5/3cfYs3zndyzr3DsQ4pfoC8
	7SfarLld0F9IOo8V4AqVKJQIHPR4cS6Y/Z3QDLz1i0K5SlbZ6uJjbB3yf9efOvdQlkZkXvTQiyP
	IJ0l5zSxAj5w1jWvoLO9cvyxrGF10YEuWXWnflheFpZ6FvK+3jz7MK0t9nH3ogiLOirEHfHAuua
	PJTR8MvCvhqXT8Mo=
X-Received: by 2002:a05:6000:2608:b0:487:c43:e606 with SMTP id ffacd0b85a97d-488717165a5mr18078449f8f.15.1790483903343;
        Sat, 26 Sep 2026 21:38:23 -0700 (PDT)
Received: from smtpclient.apple (dynamic-2a00-1028-c000-0ddf-c45a-e144-7750-6d8f.ipv6.o2.cz. [2a00:1028:c000:ddf:c45a:e144:7750:6d8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a354c47sm18990923f8f.15.2026.09.26.21.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Sep 2026 21:38:22 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
X-Google-Original-From: Josef Schlehofer <Pepe.Schlehofer@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH rtw-next] wifi: rtw88: extend the TX report timeout to
 RTL8822BU
In-Reply-To: <3d24a4e461dd4e5fbb7aaac66aad1b0b@realtek.com>
Date: Sun, 27 Sep 2026 06:38:08 +0200
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <91FCAEB4-16A4-411A-A436-0803F89F3B7D@gmail.com>
References: <20260921165343.8131-1-pepe.schlehofer@gmail.com>
 <4c000f11b23c4920b052e8513ad28345@realtek.com>
 <96f122e7-2004-43d6-917d-a07027f568a4@gmail.com>
 <3d24a4e461dd4e5fbb7aaac66aad1b0b@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On 24. 9. 2026, at 02:49, Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
> Hi Josef,
>=20
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 22/09/2026 05:03, Ping-Ke Shih wrote:
>>> Josef Schlehofer <pepe.schlehofer@gmail.com> wrote:
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c =
b/drivers/net/wireless/realtek/rtw88/tx.c
>>>> index 4e110a457..55d7923e1 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/tx.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
>>>> @@ -208,7 +208,8 @@ void rtw_tx_report_enqueue(struct rtw_dev =
*rtwdev, struct sk_buff *skb, u8 sn)
>>>>        __skb_queue_tail(&tx_report->queue, skb);
>>>>        spin_unlock_irqrestore(&tx_report->q_lock, flags);
>>>>=20
>>>> -       if ((rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8723D &&
>>>> +       if (((rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8723D ||
>>>> +             rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8822B) &&
>>>>             rtwdev->hci.type =3D=3D RTW_HCI_TYPE_USB) ||
>>>=20
>>> Hi Bitterblue,
>>>=20
>>> It seems like more and more USB chips need this, let's enlarge =
timeout time
>>> for all USB devices. Do you have any concern? Need your input.
>>>=20
>>=20
>> It seems fine to me.
>>=20
>>>>            rtw_is_8723bs(rtwdev))
>>>=20
>>> Also, considering SDIO chips, should we keep original timeout for =
PCI only?
>>>=20
>>=20
>> This too.
>>=20
>=20
> I sent a patch [1]. Please test if it works to you.=20
> If so, I'd take my one, and drop this.
>=20
> [1] =
https://lore.kernel.org/linux-wireless/20260924004637.9958-1-pkshih@realte=
k.com/T/#u

It works for me. I tested it on the same TP-Link Archer T4U v3
(RTL8812BU, rtw_8822bu) , so please drop mine and take yours.=20

If you would like, you can add:
Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

It would be nice to have it in the stable kernels, too.
Thanks!

Josef=
