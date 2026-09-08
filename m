Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397605476D9
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872603; cv=none; b=QLKyuUvMbcLnW/eVJug6tKHD6uZ3ieurVX/+J/sQbODquxrzaesWIvKVHcAIMbYucfyq76Xm/UbVmX30V8Mcfb6S3nSFqP3T6SABAwsFW5bgXXZ0MS2DIC1dqzzwkRL2TswMh0BlBe9VT3FykhF2yo0nKt0f72bf+ekB7kZwhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872603; c=relaxed/simple;
	bh=/litBUCmykqlKIXM9mqB+Ix6fkKAHYidvnz5JeC4/bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXuOXlH5NRHTIQm1ndMiY+Jy2O8SWFcAZiHIogBdtBpVeoyD72BI4iB2FIYJEEgff4JBVHJTaYr48XittLqcfVdqMJytFLSeTtPPs/2YkMbRZ4NCXmagTzc/3JvlqVYemJ52BpCfYBWnqWMYgRVC6jvlwjSBTRzV17uLJsj9S18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqvrTgpA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqvrTgpA"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49557167508so55055675e9.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788872595; x=1789477395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/litBUCmykqlKIXM9mqB+Ix6fkKAHYidvnz5JeC4/bk=;
        b=aqvrTgpAcqZ0INMXVDRhgGYj+qryYPu19QHumQ7VoA/AnJJCIkux8bo5WzOgY9enYg
         savjeiDfENMq9D3z903FnLln7adYaM04WUK3ecbYK7ewTpH9EKmgtSUW2MiHXRCtWUMN
         MWfjqy7tp59ENjsGAWWuNAQDO6/E7IFCaK4WcQeXic9cGHLqMGUsfe2pIcEx7cY6Uq7N
         /w8SiR9nDAR0cTDIiaY//+GHenOnT31lFwXunNoc1OstiqYgJGKJzf+Ku7pJrhkuTp/j
         CzC2xobdBWOPpfiBQv+kyNnos53AtmO0Iex7NRFRm0tl0VLGdG4m0o2SGcjAMgMBv4ve
         cihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788872595; x=1789477395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/litBUCmykqlKIXM9mqB+Ix6fkKAHYidvnz5JeC4/bk=;
        b=RAzUGt10C8W6mAuOcn/3ohKbI6AiBf//RcjDJf0mbzcWu720GHWgq+R+LJ6pEKuRXG
         svpxIxQ+GUuivlQB2nV5eGsAQioVCk4PjhWU4nCRmqQccFJB8V54W4JPNwWmGbXQTIun
         a3UUnk51fMm3C4Orj5Evp+Esloq6ZXHvmElsMUjyeqrq0GOUCJwZklKMupTRqVdaRSYF
         zE+9av5oLrobOr1D1DoqFOH3woBRM37Ia2oEPOEcQO1dWA6GJLU7SgAk/0qhBM0xV3j9
         irhsP4ucy1YYTd33V/nfojFsgQFDs5VDRyXim5qOKIm7A9DlLHgpV9hTi8331YSR9wsw
         PUIg==
X-Forwarded-Encrypted: i=1; AKwUvBwKCKAiRrq8Agyvm3UJ8geVvg8E+1yEeRagqAANjRgFw9/YcKAmEt2ISi7WpQkyKRT+mgajqIw=@vger.kernel.org
X-Gm-Message-State: AFuF++kG2sK9gNjVzij/9/t00Ii4FGT4jMKtvMNJY/F9DLGJiqhNt5Lb
	lMBJJ4tAmlAIRKgAcy75Fx2Paopu8qvdwDGaNyfFK7MVwCcMW89fvuqZ
X-Gm-Gg: AYBFou2J3WBPZbKB8/QIyJdI1wSxq1kn/2MNTaydVon7rAeyNaau0de5CO7zn2xaPk3
	MiUOx1nlw9UpXcJGyx8cYrp2uGEjkUDYtovESnYBWoO/uRAidjYBHVApp90gORtDGMmfwuN79nc
	qy8zDPJajHo4sPF2wLbkRMk9m4KxjBAtacwYx9lTmrNosY55fd+HCdklZUvnOQZ/rjckK0F52Fx
	O7EsR3Q8EZ5qACA3VvST7rOsR/hvetl7X85bqgPdhAO29vCX/5i34XEKG5AlvFu65xBegjkK7i5
	XVrh2jfdy0ievShviOFmXWfBYE8iMXW0JNWpujN1gEKu3BekZ571tiWI3NLBIdDU+UG/W4w8Hv5
	lwXyS4kd/cnD8sjIA1viBZ7tmWQ+66wyP4HKp9tcIll4erjbKHwj5dt1rsVLc7srLGoZo7nQ9kY
	6aiESp/9AmQbMNFe6bQvChe88mN72Y4+vhc90Mo1g4C6preGswL3KvNyaoR/LjXorbnXJHdrj86
	psXniD96sihBXQq9kvUKiHaC2pbVpf7U+voWsMoHpM0+Mp2lt1CNPJ+MeB8Urh8YS9tTSChvXCX
	7RJfKuAmfoelAIet5rC+RNcf0L1Gj68gQ0hPbrX8gi6J20wgoLqZ/qhM+pfALKYu1FBCoe5bSZK
	1UMMMe+RDWZMXzM+vYdiQlGwr0JpaeHEQvQF/V9S20adjZVMaUkAXKt0xgjkDPcx1WagtHw==
X-Received: by 2002:a05:600c:6087:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49cf81e3454mr614754605e9.4.1788872594406;
        Tue, 08 Sep 2026 06:03:14 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm255179095e9.8.2026.09.08.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:03:14 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:03:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE
 macro
Message-ID: <20260908150311.00000da6@gmail.com>
In-Reply-To: <CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
References: <20260908114047.1360-1-joshua.crofts1@gmail.com>
	<CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Sep 2026 15:41:23 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Sep 8, 2026 at 2:41=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmai=
l.com> wrote:
> >
> > The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TABLE()
> > macro. =20
>=20
> Is this a problem?
>=20

For systems using devicetree, no. For legacy systems using spi_board_info a=
nd
this stuff, yes.

If you're referring to the mark for stable then I'm fine with removing it.

--=20
Kind regards,
Joshua Crofts
