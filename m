Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B147CC85
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788294991; cv=pass; b=TfrBhmu1F2TCWJPcb3hXvE2HB3Vt+oWNMRktHxjr7pXpuhuAhCsdHzAIhFluQ28ToJ8HLYs7LxX1HBPu9L8etnQnwce2qBYhAXYMbouYrAg+YX61Ae17/Vg2Z07bfMYpRo8CCGdGdXXs0gl0Hpaug7p682Qi7JzoOLXHOLTVT9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788294991; c=relaxed/simple;
	bh=HdDGW1g39cCl6eGOp/7kmX7YZgzSXGwniWQDRTw+uXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyXsc9JV5v1nFTA08Sgv6JATxaDypSmbWtL2SSXP3I4qJJ/ExPd5XdKNTs04ra13OoeO2ZZIe6+EHdQbeYkAv1grXLuW5z193Z8G8gV2HRdKzfbOP6oEHZt4XsbEr4at1oDSmHgzU1PaSZwDVpgop7GyJx+IBVDa0LHEEpLL9Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcgLPumx; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcgLPumx"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48436251906so386936f8f.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 13:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788294988; cv=none;
        d=google.com; s=arc-20260327;
        b=COYI+DaVifbXm4IeIVmApIJQW//vL7qPuDZm99Qnh0TgPuoZ8KMZ91C79rUPwApKlJ
         Fl8Ci9fzx3jRG/mPyHDOsozWSosiIqbRlJDUgi1HfMxegp+vAmaR8lesLA4vx9iM8JRS
         kQEkf+lWMQIfrnBNW06txrIlkkl+k7p3CJIFsy9occhNAsUwRmbyt6BpQ6uRTi++EW17
         9Wr7YvS6lcvyoix3lCrT3CI981gJZQJOPW02urRMpRigvsbDQRgk6b7yFAjfsXMwfg4e
         5/p0pUPwtvAEqNe+/fETyY4xRrKrjg5i3S5NNEBj+oFcNah/oLOKQCus4nxB4rUe9ACA
         kvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HdDGW1g39cCl6eGOp/7kmX7YZgzSXGwniWQDRTw+uXI=;
        fh=1qIpUaN7GsuUN4u1lfmIdErUaPP69/IFJ0/3GTH2CQU=;
        b=Hk6TvMJbkUw6dhfj/sHRiHED8EdEuyx7+CNmZYEuwwRNYf3XVUvww+UwT4Vd3YUVS7
         IjMeumvLXOBOCCLkNTb7dALWk3UJruLqJE6JFnRLLWFkSFR8iPYgTReEqAQcFUgdlMFX
         6TMI+qyrORFBYQUYiSea1mTVL13tOXARKaiizQQ6EVao8uej1SxxsdKn9J5JZLgPuav3
         YveLkq50EVyhsRL9RKVuDMaVZ5HnAaSDx2ffCVhtsbKrmckfLL1o6NxmdKW+hkMYdcif
         P8hgTthjGdZIr7YuG6ADvrDr8pY9r/f5/SIH9mgKMnYD6fIvGuA7tgY5nvMkXbeKZBwd
         I/mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788294988; x=1788899788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HdDGW1g39cCl6eGOp/7kmX7YZgzSXGwniWQDRTw+uXI=;
        b=LcgLPumxXUCU3LWs4oRI2gkX95yDO9pKpGigrUnGgcxWrh/9hnc496ZzNZZmPdt+WA
         BMwQgMBuN97GIWU1WAnp44Hl5Tcg9WrwBh5cSUcozA8/kko8FnJJ9e7EKlz9MWW0UAMB
         CItw7E2GKzqhi3DE9MFfmxAOeHFR4yKI/6VX54hVg4dXwlCnW5TEMyS1z0w7uhgzyKye
         RcbCG8oh0qhqiuBUXd7nO1+q9EKI5+qO8IhBeYIO0beidmNlpEUBnZ4ynrVBm8q3TYTe
         WNILaGmBLjRxINRQ3cU5yZgVOJkx6d1To/TX0iz59cXw/oddxeU4oZhNtWRBVM/bLNKT
         l71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788294988; x=1788899788;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HdDGW1g39cCl6eGOp/7kmX7YZgzSXGwniWQDRTw+uXI=;
        b=nw9rOcKJee3c7zgxYJflwZJZkjPq8ayvoHbiSNgPghtrPvxghDozIc7bTEhA0ApV4P
         dgVPGoLrsGSY6taF4QMU2+u1YMqzNOm3BFxoVHz3rcDS4dBlk8mSGEAOGKhIS2t03ajv
         MKCJllNsaMndAqN/lNYdqsSAhFefwMeLW/KBExj2CwWNm8AucLuarVL+K7KOJJQmE9W5
         e+zi0lqwTEfszFImROfuYT0Et+8N4nysPbBBW+cdtzTYKsoo0FuxAP8sVR02SVWCbbSU
         HQNXNXB7on7pBX2eVCToPPt/0iQKNGNYJRlp4VtVmPvLgk2I77u3U7jhnTaqiYkAhWzM
         E7hA==
X-Forwarded-Encrypted: i=1; AKwUvBxvjhAOCO9bsW0yjl1ivrF5m1TBJ1OBjzgaE1Z57M6u19s73K3W8JQY+LtHIwl38yO+pex6lwk=@vger.kernel.org
X-Gm-Message-State: AFuF++kmeuG8jWOYBRiS+Fv3SU8vVuPpz0V1iVhsTwLZ7srt8QmBGe2P
	wheMBM4GdcQH7dlPhmwJGE1E7IFCiom1E7Sk5BGilf2vqamQ+ePKwwwBablSVkuRPLqXrMXZIw1
	1EJn0HCFo3u6OdY5QcwDFhsMUX9r7sPeE1USRFXI9
X-Gm-Gg: AYBFou0d0XaUTqE/jCGtHM0AT67FYDXIRsIpV8lp8WG5UPcLQ9m5/acE5OnpzFQS5PX
	Sktzmr8WHmssG5ACWXNx1KHTy8l89f1nVAOUVW9WHuLG66ii2zx5T5KuDRjObbBLPQJ0pndAxoM
	8+U0XACot/EH92hBZu1hXbOJ6dGl0L9y1CpipinVgoiu5ii6w194irkAc0zftyx8sRoUB0wzdeT
	yzog1Bw7v6YV8UuzBqoSh3xiXyStVie0uWsHlgHkCLh3MlT6x5DY5Gu/H3SX50pnI4fh8u0VopJ
	gVFcnhvWkuRgXcNtUCi1iKSkE3Iyry9NXJ0ereJ2WUaVBE1VX9fWioPRUQAweU7OywXZhhkTsRY
	mQC67tf5NGM/RGg9KB6Amm7K5iohNZXV7kdDkPPT+iza2LdUIAiXQDNM=
X-Received: by 2002:a05:6000:4910:b0:482:f61c:7cdd with SMTP id
 ffacd0b85a97d-48488df9e0dmr42483f8f.4.1788294987371; Tue, 01 Sep 2026
 13:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
 <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
 <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
 <CABCJKuezb0HtOcMBsObczS=HBaRvMszagkOZGHyOVbXBqtJi5g@mail.gmail.com>
 <2bd0c842-d0cb-4ad7-b3a3-fed2000dea83@yoavmoshe.com> <CABCJKudb5RegHcNPkXG5p1TcCFAe5_8+hqBP-2GyHVK19oB94g@mail.gmail.com>
In-Reply-To: <CABCJKudb5RegHcNPkXG5p1TcCFAe5_8+hqBP-2GyHVK19oB94g@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 1 Sep 2026 13:36:15 -0700
X-Gm-Features: AcwNN1XLVY2qNNwpmvPqR9vii35HawK0FLdCW7a8C92cPutToPYaUpHoOUGoDJI
Message-ID: <CAKwvOd=OLLO5AXiR54o0nU16e_pTDt_yiEPQ0GgnX8DRGJXYmw@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Sami Tolvanen <samitolvanen@google.com>, "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 12:46=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Sun, Aug 30, 2026 at 9:24=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com>=
 wrote:
> >
> > The sashiko-bot's comment on v5 indeed pointed out that imx5, at91 and
> > omap1 might suffer from the same bug: their suspend routines are also
> > fncpy()'d into SRAM without a type hash and called indirectly. They're
> > all ARM, so asm/linkage.h still seems like the right place for the
> > macro.
> >
> > Do you think these need to be fixed as part of this patch, or as
> > follow-ups? I only have my one imx6 device (a Kobo Clara HD), so I'm no=
t
> > sure how to test the fixes for the others.
>
> I think separate patches for the others should be fine.

Without devices in hand to test on, I'd be hesitant to claim 100%
confidence. Maybe reach out to the MAINTAINERS of those, and see if
they have cycles to help test potential patches, before
writing/sending patches that potentially don't get tested?

--=20
Thanks,
~Nick Desaulniers
