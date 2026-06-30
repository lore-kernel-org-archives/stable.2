Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99D3FC5C1
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828754; cv=pass; b=tiQU4efLEY3z3BbiCKR0QCtGRERKk9biqDC+cqgGAsKOzw/ySw2+VwqxFkmeKEg1+LJ9WeAS9MmwVxC6JjlMbmRzuy2PpCrnPLeT7O1RGu8DMCSQB8PfZn2WTNevxhcjs9CHCkXhCV+GCpxPUpf7blMmZiM/coYSrGKB8CHRTUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828754; c=relaxed/simple;
	bh=7G1fzJ+ZFmJWx+DHty2ag2OS3/pzbFUo3QxyCPb9IQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnsNmUudYc9UcLMnloL7i10zgqB0pXB/sPxKxspN2Vo3H8Ar5RGtb4PlFRcroCD8YfSM2Zh4GjjT9Js8OJ/EtCj1NG56LTpV7s+cZ+kgyqci33zPC6QFvMCB75pwkZhGlZP7ZItyWKhfKwXFzFg5W6mQK9zI6rVYgtLaYIBjYAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNvbT3oQ; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNvbT3oQ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139f3eaaa49so2273806c88.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782828753; cv=none;
        d=google.com; s=arc-20260327;
        b=H2hEE88soshEdya2Yld0nz9b2Nm3hcnUFRZAG/nXTtOwR2n16aHirD4l8Uume2ptOW
         +A7HDR9eDDXVzaPLbx83M382+j9nqYkIEMC9AVx/xY3Mt13OwtwVxxktrn9hJiA4aAxZ
         2a0kDttElzYezQU4p8Q68FGfLRlBRCreMFxVBQrjsYztVYQOH24+KANgCysmThjtYo6g
         4D0/AE9aUAIuTuOisuM8xqLJ7f0k1rjTxkP2Ih5rhegcWbkjbV8CB+26t4TYzhyKYND5
         F1eVb0qD+YX00EgPFfHeQjbqq9AS2kFw+glEyX4lkW7s3tDt8rQxN6kFTVMkjhgxPNQR
         JXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aqnGlzePkR0MOksxq+t6vlXeWc2XPb6gxKt2B/nD+Cc=;
        fh=cxOeX3a+C61V5IuS0pRNrFkAba7V3v5bZ6yDdrpr+B8=;
        b=BWcjijiJhSpikcaW/LkBxc6J58dVdA+7S3Vqjv47/xT/GpRAxARe3MzOTDyKVOTRZ0
         uiw6va1QbncVpePFSnjeGwGC9Ez6ViKcsGwB1faz3er/UG29gDLXCtqynAZczL7GQCLS
         WilYQE3QFgOwLKwQxNYbufA0xF4QDRV4pbsTI1yfI11GpfsJ9enxBtZ+1yDwWrQGSlDB
         MnIKF4WCPXTVxAQDxz9Lkc9y3+Hg1LKDR3HqChFQGXziEHoCrE1pR0WNaohMap7/I6/H
         JNGKyVZ6BMgUv6VF6f3387vDKKxD2M76J1VPu0W0U11cVRjyvbc6V/aS9ey6qFg0L/M2
         VB9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828753; x=1783433553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqnGlzePkR0MOksxq+t6vlXeWc2XPb6gxKt2B/nD+Cc=;
        b=ZNvbT3oQP/YuOhDZMFlHRb0Gd5T2HO/TuQtCLVzWI7ZzS75uulTa00uWwlIxY/DuSA
         DpNRiviydScPT9T4v0kqvAmDGe1wVHbZVsF0dpEsAizUB478rYqp4UbA9PnEuGWctREd
         cRP3FIgiwIwaPI/uCq7mHLlcccNmDr+kqkaBvOufJr4EerYELonHG9q321XHtzidC+LI
         I6VWjiAcO7wtt/avQDhtSwhHTgOL3f3rQb3my1Ad6OMutQJoBh0towfEDenxN1kWY8ri
         bYuXvICLnvHvsZ/0g4bTZUurdr8WNX1Kd8x+VhG8F5mMxpW944OXN02VHkzW35aBch/r
         5m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828753; x=1783433553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqnGlzePkR0MOksxq+t6vlXeWc2XPb6gxKt2B/nD+Cc=;
        b=FRAdkbCulasOSyRCzzmVvKSRY0xPit5eSvgU5U3VJD4IYNGdj6AZOEJ0vdfVNcPbXy
         +fzBG37wW59yzwu/t97ovrJDMOBGOh/U0taqP8VFLnyf3BxGaZ6GdF7Q3J0EVn1MroaT
         A8lLckoMBz/UlYbTR9sD2Maz2ghfspDZsQs3ZnJC4wvSG+7OBTQ0rY/QQanOGnSrjIVp
         yN79wMu3z8kk9cpCLso62FUg7r74d/EDaYugHDHU7WHnOJHhvuxbAFv7Sl8FthJH096F
         LvVaBHSlKYwWkWs8jzQq50462VuTE7ES3wKeW8fgDrP0swzwoSn3qCsG6Ka18Z3X6WDS
         Fz/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8qnMmFq0pkq4Yo67xDl0OuTlWwmrlxEKe+v+2JfSPJyGcsJZWs4JZGrgDTHi/XYd2GwiwKhfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNJYbIAKNmhDa+19it1Q6ygUYiauqHw/WPDh4wJETmXrFyrzZ
	RvktUOnWNvJ+JWFRIv7aspNt419Tg8nciwfZFgeTFxMUSwMVyMOCHwOLERn4nXzVxgg90QOFW/7
	Vumd6TlXtlieFamcc5EwO1hta6BXW2LQ=
X-Gm-Gg: AfdE7ckp3JX1V2xpu4jJWeaILNc2lXf11l/eutF9LDiJXy/KMvJMLLALDBcRt17MTQY
	1Bjkq4oMmMquvuZVavROECemvQBLC2YtiSRSz2QvUhs/cxnxSkfFwrdbRZ+CC7WNSvTtUXti4X8
	y+ub0Uc2JmOx5AeyegJZcqrbsMj6f22qWv8mAvo8Z5QGs7ZIhLTpUkgGuKUcBntgZ596Astw5w8
	s9nAIymYblzVIzBgbxeNgUfCAJesx4+6iMb6uPQcwms5611B+/GN8KOvDfpk0QWbnYS6A==
X-Received: by 2002:a05:7022:ead0:b0:139:ed5a:eee8 with SMTP id
 a92af1059eb24-13b3158ab71mr419877c88.39.1782828752619; Tue, 30 Jun 2026
 07:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626060112.2498324-1-sergio.paracuellos@gmail.com>
 <20260626060112.2498324-4-sergio.paracuellos@gmail.com> <CAMRc=MfiSePgA+Vc2GHz_5QUGZWFhnPrXPZoCV+32b9RJos5xg@mail.gmail.com>
In-Reply-To: <CAMRc=MfiSePgA+Vc2GHz_5QUGZWFhnPrXPZoCV+32b9RJos5xg@mail.gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 30 Jun 2026 16:12:21 +0200
X-Gm-Features: AVVi8CfEorQNyXoLCQb249d76lXmylw2Q4EtfkIwDk77XwEpQDExqE5pXUQ6zGk
Message-ID: <CAMhs-H-BByK-Oc54WZ+HtqcZCSJVntiW1bPwmZpjwK59CvkPkQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: mt7621: be sure IRQ domain is created before
 exposing GPIO chips
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linusw@kernel.org, vicencb@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Tue, Jun 30, 2026 at 4:06=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Fri, 26 Jun 2026 08:01:11 +0200, Sergio Paracuellos
> <sergio.paracuellos@gmail.com> said:
> > Function 'mediatek_gpio_bank_probe()' registers three GPIO chips using
> > 'devm_gpiochip_add_data()'. At this point, the chips become live and vi=
sible
> > to consumers. However, the IRQ domain isn't allocated and set up until
> > 'mt7621_gpio_irq_setup()' is called after the GPIO chips setup finishes=
.
> > If a consumer requests a GPIO IRQ concurrently 'mt7621_gpio_to_irq()' c=
an
> > be called and pass a NULL irq domain pointer irq_create_mapping(), that=
 can
> > corrupt the mappings or cause a crash. Fix this possible problem seting=
 up
> > irq domain before GPIO chips setup is performed.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Fixes: a46f2e5720f5 ("gpio: mt7621: fix interrupt banks mapping on gpio=
 chips")
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
>
> Seems like sashiko still complains about this one. I'm not overly worried=
 about
> this path but since the commit's purpose was to address this very issue, =
do you
> want to rework it further?

Previous complaint was about the IRQ mapping being NULL because
mapping was not created when gpio chips are set up. I think that it
made more sense that this new complaint about the reverse order. So I
would maintain this PATCH as it is. Thus, I don't want to rework
anything here.

Thanks,
    Sergio Paracuellos
