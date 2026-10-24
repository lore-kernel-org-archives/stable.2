Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792882063;
	b=GAVX0tNUDBa+bCDNsxZ+HrGVb/4nlcp4uRyDCqDGRPsMUtlZYSTosYImTT9C9MzbGpUK
	 hQBksF62lH0CLY3aRdUd+Yty/NE2kqovo7MlqZMAK30UqtPQmtPy1bgorhKiapUg37ueo
	 fWzBLgmrEFR40kxxJzL3mW56bIV7XNzypd4e3Q4m9/KVc3Tl2qUalnv9LtDeieUlFm6t7
	 N3Ug4JNX0VJiYlG23wRZMecgR98SdKiH/Xs5DvZ0iNygkg8dGmBmpOKUM6ONlm0SFBZq8
	 cs/1YPXHsiTX5VBvxeC+6W/q293K0GtQ7YAtpCfstJDC0nrZIzUZG5is/Nkxbmu275Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=NZCf9o2Rj196Ew4/tcSd/wzVTA4Lk6Bgp5J5f2wGqdU=;
	b=UYE2bmHumAEkn8GmTyDhMx1Z9a/mInHTjEb40WH3qF9WtKH9NwQHbxjsVGXKFNJiNrxL
	 4M7EED0E433MRmnl6ZEiSz//U21+rol/SDHFBz+RfRp4f+okH6rOpZGT805r6G07v5tIJ
	 T5fRG4I4kf8FPomNmv3t9C1QkY2xIgQ+InDxqnq5Y68YBEQ75ERmCuN6UxhGI4RtTVaxc
	 cFAjRwCy+3gNHkhv7Ksb90UbbazdmjD99IxtahwVsLIf6qOoCeg7czfoSwVMU/vQZ9UJH
	 lgqfWWmb9PC79dTdA7dAV1rdk/0598UtskNbn9OI80/zbB7Y69D0CJgbSLQm8OjrphQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NvNTK0Tj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E399606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 22:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E399606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NvNTK0Tj
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso3695981a12.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 15:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792882061; cv=none;
        d=google.com; s=arc-20260327;
        b=Q+rGx+stTL6bHOJT4fQSHzY9Pu+CvPHgwZYWWDHD3nz8jSBxQb/qCzSzH1zprdgapp
         z3HA3WPLLNJbWpkkmOt87Q2tbEPbtdPIFrtpE1AA3d0AEBDlw7xGK8v/W9DBM8vqZ4Px
         PW5CDksr7Or275ZNMpE3VvZo4Zhluwli4LbgQoTWnNtjGcj7zHGzikCcDXRf+ESIVAGe
         xQbEstISS+XT8Lz0Pd9LR/pCx8yx49uO2j8fr9NcOmF5YQ9H40ZHvSYIXRNP2oggGE7L
         2rVQum7C7dq0avVqFDQ24BVKnNVirmigVfq/F1R91lVSmUDTm+GYomXpsq5NvwvJqae8
         Ls1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NZCf9o2Rj196Ew4/tcSd/wzVTA4Lk6Bgp5J5f2wGqdU=;
        fh=1DCwBJZjL/I+NYZZQ5FpE6GXuTKcdVnDGI/LgafyCOs=;
        b=mXHAJhUOevkJ/ohz5WVVqdbkLIipbm+c/cN+6keaqBM2hyMQPG6I1YBQYxLtXH+h+H
         5p+RVCUZGUAr4jyIeSrs9socTPNPijPHZ2Ofd4OtSdF8+W5EJSqqG6SyJ5z3MD99ukBz
         L4jnFvl8QXpboZqtGEZTIxRfLxeFBRlTqAZg38YzWbXJ0IuQM7h9AGvkh1E5dUCaRnhg
         3gRC26TAqYS+GolAg8cOeC6JHK35xO63/odsVyU8CpIX1ujdBZPcUGtkB9xe5f2q3aHL
         PHYCNLizfm0AcGoVzug1Ue8GQYomdzFbroX0rzAImMn1yOHBc/phmJN0BhCAQeX6+y35
         TQLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792882061; x=1793486861; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZCf9o2Rj196Ew4/tcSd/wzVTA4Lk6Bgp5J5f2wGqdU=;
        b=NvNTK0TjEDCZAqtWBF3om4HvZP/pnShex/+wJo7ZBram22JM84GtN/m9XPMVXSI/oV
         uGp6mxzSnuWDDwRFj9rDsShNCJ2sf2Pry41W6xUT2LjGSDhiOk3wVTCn5ImKnYoUhbC/
         AygTaRA8OAi5t+JVy9hgZfIy9MaCkpCeSO+ixdjnI/L22F1RqqQnvH6VYG/UadgCdp6p
         fV5mVk9FLFTmdxQu3oToqQIKtzc70RARiqdbgws57TDgCWxaoAWgklZbIyr0Ypz/7+U1
         xhhKFIp/zGxFXNPxTRC/vIBpcIXPiNOjZ/zmf3qttdAmN+TY1Y3uWLYWBDy3wOOchqSO
         H7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792882061; x=1793486861;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NZCf9o2Rj196Ew4/tcSd/wzVTA4Lk6Bgp5J5f2wGqdU=;
        b=sEJP57p+UDyx7+orZEeb+FDGq35GnuGESBREeqyQWxbbDMeYLJM1514fl05PHG6m2p
         8FCbBBMC3ssDRPWKim+3iuiJEjAm8o1ppQz3ZR/RuuZXl0gYjhkoMc3ZutOP1VHt89c1
         qxXIycFYgPgfvNEsu1Fy2ujwdAnMTQSVS/NY7lVWhfGq+LjpVkFy8i89VrI3f+LGN2km
         iWInN4Zbp+3SGlXgEp63Xw2HIMXeArlrxpk8/+puFgvlgWJwnOsfj/E1O/qsxsfLrFq2
         sXat4HoLxyHiqjGasWL4h7dOV5IGD5cframUEhQjgWsempMJ34nRjx+PWAoLb/Rc7GTj
         KWtg==
X-Forwarded-Encrypted: i=1; AKwUvBw/KgXYWHmyRz/lu+F/nFjVMrhGp5DCY+JnUiY34KavQBMS+dW2m11xzsPCBQyDezQqQyJj3fA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwrvKqiRfnSm5fIgAd1AYfohXsVV9p6r8O6vF1RARP+qsR1qf8
	VfLZtHER0kK/f3G4jInPAjZYiS10NuT7goQGq7JYnlY0dwtg8tABfLIdS6CwqFSTDf09on9P1bS
	myjANdDCMGcQQfot0eWlzQ7AzL/+DR921PEVnrxyaFA==
X-Gm-Gg: AYBFou0FHX0JJ9rYcIqp0CBAWc6romv6ZAA5kwwEhiqiNaIk5B2Laj0Z2xtBDMQp4QR
	oDmMJjg3efdyNRRN13QzvK9oiay12Zwb+lCFZQd5k+hQf3m7nffVIOLvQB9Kcl2azL21Y/RJc+B
	oiXgXZy0J46tldKED5X83gdEjdqFbC43egKx1z2mPd1v/LoY0ueaA6fix9Ng+RtYUbRQO1BvGAQ
	ihcraC2agDZ7xO7ynEt1WGp8MguUiu1Fv1zL+3mXFWJTjwde/UKefL322oVp6wUcdct74zQjscF
	6w+1vzYh+WVXgDVxO7OeJZXJu0KnflMKUCtQuGW+0sMyLa9WsKoD3MZs9ASN158Drx7UrWoLill
	D2YDa41hoQax1zF/cy/RkcmzsFBssAFISkkEEhQ==
X-Received: by 2002:a05:6402:e08:b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b443a2fee7mr3591780a12.10.1792882060790; Sat, 24 Oct 2026
 15:47:40 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Domenico Suppa <domenicosuppa@gmail.com>
Date: Sun, 25 Oct 2026 00:43:52 +0200
X-Gm-Features: AclHuK84iwYwcADuMVCUOUYb8Pad-bbbUjeJBTQvX6wwjDeQ-jqJnqjt6Unj6PU
Message-ID: <CADP5X9J16EYxO94eH6cGJT70k1s_QguPPPGEzH=s8hfQ7dknQQ@mail.gmail.com>
Subject: Re: [PATCH 6.18.y 0/3] ACPI: scan: fix the fixed event power button
 since 6.18.57
To: Ting-Han Hou <ue081723@gmail.com>
Cc: Domenico Suppa <domenicosuppa@gmail.com>, fredericmariejoseph@protonmail.com, 
	Greg KH <gregkh@linuxfoundation.org>, kernel@ametros.net, linux-acpi@vger.kernel.org, 
	linux@stwm.de, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, regressions@leemhuis.info, 
	regressions@lists.linux.dev, sashal@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested-by: Domenico Suppa <domenicosuppa@gmail.com>

Hi Ting-Han,

I applied the three patches on a clean v6.18.58 tree and built a test
kernel (6.18.58-acpifix). The patches applied without fuzz. The power
button now works correctly on my machine.

Here is what I checked after booting the test kernel:

    uname -r
    6.18.58-acpifix

    dmesg | grep -i "power button" shows both lines:
    input: Power Button as /devices/platform/LNXPWRBN:00/input/input2
    ACPI: button: Power Button [PWRF]

    readlink -f /sys/bus/acpi/devices/LNXPWRBN:00/physical_node
    /sys/devices/platform/LNXPWRBN:00

    cat /sys/firmware/acpi/interrupts/ff_pwr_btn
    enabled (was invalid before)

    /proc/bus/input/devices shows the handler for LNXPWRBN/button as event2

I could not run the evtest check because systemd-inhibit is not
available on my system, but the ACPI state and the input device
registration are correct, and the button behaves as expected.

My board is: ASRock H310CM-HDV (Slackware64 15.0 Linux x86_64, Intel i7-9700).

Thanks for the patches.

Best regards,

Domenico
