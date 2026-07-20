Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB143E4B5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566311; cv=pass; b=o37fDNTmQENAQWGtsHAxMj5Ys6tmfITBmD3Yd0wjz3L0AyTy+AZV85MD0kerX/tJiRgY0huhOM8nFQB9Ed/H8em0sDkI5OQ7aAVoGTZgVwJEsSYe5ulcVEKBU8Xc2VZUtfJChYhdIHcdpUbrZXnvCjmyLL4K6VggTGofGoUQmKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566311; c=relaxed/simple;
	bh=h//PlCpI0ud1F5KsjJcqmQMXG40LlSIcqpcNuGnT1H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCEaQ2W8g+Fv22574ENTHxxy0AL1NZPe2HocYfLW7Zd98VuFLm1Cm+Ab5xA3T/dygTiKX05o6GSdSOCFTrpn570t3tKSLBSyl0ju9tTtKS1tmwTALnG4BvhKb/1v3a+EW98qsj5HE/Jh29iYy4FcbX5yl+4qBf/68NSoUNtM0qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uf68WFyY; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uf68WFyY"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c197e7e4e94so152987566b.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784566308; cv=none;
        d=google.com; s=arc-20260327;
        b=dR5CVR7KxXzcK09Sx6DoFgCT8lekHi7OPaEopTRMyxZn0wxCIucl9PybHbFIF7yoDs
         uepnrpuowoOrYintQN+tJqbGm2YogATQE+0Z8arpZsrpdHYWK86Rs2GFqR0akyzsZY3g
         PUTfH83fAvwDewRi1DXdWbwCpZ8AAl+xRm5foxEpK25TZOie6i0o2jcQR1wqfGVTfVPE
         XtYYFZxFG9Rf9ILanEYIZsYZJVV5YknqayD9g5GR7V/ZDIGSWdCAtDdlQ7NTMXzuasXv
         XlYCTvZ027hhs+FZsCYI7wNlnN0nlG6KW/pZw47MVkurvX9g7tJATDTpr7nyOinVgfas
         TUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tY6y2m6mRP/UJJ+mAovKHgHIAfizO2XUbqAv58WxDvY=;
        fh=zojEJ8FoegReEiP3QPz4hgOfer2/yQvMh/7eIr+YE94=;
        b=S4Uwwr0As6r3uvAl4Gqmfe3+OPf27qbHLifggB9pBPxvbdLCP9M05B2MhB06SRi8Gm
         /85QZFPhjvWtISSLCydlo2/ZMYHEV9THbq+9/LrIkhgEeW7MFdJeUtcdQxgvy7EC8Xg0
         E1xNGgxRzwSeXyLZ3ZIHahgkml86kU669BzVdur70sDr8qS4AOv0KLxyJZ5ZlkardYRF
         hkMlMWY5yOAy+G41AZDR3jb6IorYWAa9erAoA5nSt3bicN8STg0/ylRaDCZd40c9j4xo
         v0vrw1IQ4SYV6PHOaAyUc1kPzpufRjj9fVm1qeQVxsnWCARxlDP31OE8b989rqEi6wsH
         HXJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784566308; x=1785171108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tY6y2m6mRP/UJJ+mAovKHgHIAfizO2XUbqAv58WxDvY=;
        b=uf68WFyYEDuXdjq90kP1ehF7rWirneN1EUWEu0qGiU8QS3mBkHFlrFvkaikY8UxaaA
         rxMXf1FDRd7t7PSw/c8aP94XG+wH6sV0ZhhXS4/rEC9bhptVqvP1dAzjxatq+in/NkK7
         6OSrs8L9kggljekLb7gVG78gcUxxsZi8z3nS73UIZRBKb8cmvAyXeel19wAx5xvm9XaY
         Bx4rMuBeN6m1kKYpYiJ2AjDlJpwBWgecnCnBgSpsOgS3Oxyf6nahHuR9UvmPPtwoDQW6
         EVFhfBtI05RN4b1yT1fWi98oGqAwZAB2iTeqGzNdn4WrGJ+hl+8VoZs9IXgiz6qDh/Q0
         vc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566308; x=1785171108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tY6y2m6mRP/UJJ+mAovKHgHIAfizO2XUbqAv58WxDvY=;
        b=YeIpl9GMspKTTLwSGdk0WZC22+8fafUGSfo7fI+HGv3ndLUF+B7enG3XdlOc4QEmyP
         3dI9vogpIzOp9k0R/BGkV1v7kEtknNR3KDNzJSJZlYTO23iwSN+TIfE0msUXOX6MDk9U
         T4/1mAxPYjnrl1GEoM3WfmJeAJWrsB2fUDfcEnJANJMoJexs6A76MScaWLTGo8Gpgp5i
         W5FpI6IOBWo385N3gxA8Du63xIgyY1sGPHUL8/d+GDsTqSSBiGr/4ycCehg03CHlhEQw
         Mb8CLoAE40XYbS2djj3IPENG3wlNw5zzeFd4KuSbBPAKXLuWgKSFuf1TKCl/WhGgoHtB
         Q7fg==
X-Forwarded-Encrypted: i=1; AHgh+RpmRn/EuIXle13ifYVSTosYX1pp5kSMbBpRO+sMk6XVaLkyeYX+rsP+yCGZ1cZ26pDb6eztHag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlERGaGjnkQUayYX38WQtR8bVoGNkIJn5gbxxsuTt2iIw38lY2
	7kIQHZPxZz4beWhWTmsKMrgZ5YS+3k4ANuGGFjfjzaze3WvK3rOHoZ/IInxSdvYkww0LnuIELMY
	OdhtRLhkHNP+qSuIbuFa62Ge/R8cuqfWUYZwRuzzl
X-Gm-Gg: AfdE7clEb3EpU3huSO4V+mLGqbg+HvMhiqd01b3yPzgxICugCbfLh7wPsPH3JNVYrW+
	+N5mkeLU6Yfhb9/S+ZsF+Z9acy5NDpFLM15D4c/zQAX5KxlnF+iok/TZcrzqKmuMAYj83sflprt
	Au0KDF1bZf886hub403M7IhlcRvtAoQqmU+M5FZ3MBzpg1yFVcQRNj0i0k9nRuoVu38jjTb2msM
	uHdJ0ZtNVQaJ2XmX9xF6acHmqm9JeFCmAjExXrVM2hDwixvXeX8Yx8TbsWNLLnHalcd4kNuti0a
	aiS2Vv5aygduXWlZ8ab1+ig2M5TQeRgFM7+z0Sz6ZsCoE/zruB0/at/fuPc4BgYeKEYcdnLwjd3
	l
X-Received: by 2002:a17:906:ef02:b0:c16:5e73:b3e3 with SMTP id
 a640c23a62f3a-c16b46b6f5fmr615505966b.7.1784566307098; Mon, 20 Jul 2026
 09:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717141648.1007059-1-linux@yoavmoshe.com> <CAKwvOdkGYLWAR+5q+XaO6VZc3-sGEm0nX0MvXoJOghx7Gn1tRg@mail.gmail.com>
In-Reply-To: <CAKwvOdkGYLWAR+5q+XaO6VZc3-sGEm0nX0MvXoJOghx7Gn1tRg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 20 Jul 2026 09:51:35 -0700
X-Gm-Features: AUfX_myHGrPuTu_ujS6tW3mC0SHvE_GdWe_YqayLYt46d3sdd9_DfoxWORNfKQw
Message-ID: <CAKwvOdn5xgtqv9NvMew0yBnH5E0xQMLaX+Z=bX3L_a9_K5orHQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 9:49=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jul 17, 2026 at 7:17=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com>=
 wrote:
> >
> > Relocated suspend code in OCRAM lacks compiler-generated CFI type
> > signatures. When CONFIG_CFI=3Dy is active, the indirect call to
> > imx6_suspend_in_ocram_fn triggers a strict CFI violation panic.
> >
> > Annotate imx6q_suspend_finish with __nocfi to bypass CFI checking
> > for this specific indirect call.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yo'av Moshe <linux@yoavmoshe.com>
>
> Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Ah, looks like I'm reviewing v1, but there's already been a v2 and v3.
Disregard.

>
> > ---
> > Tested on a Kobo Clara HD (i.MX6SLL SoC) running postmarketOS edge.
> > Before this patch, suspending the device caused an immediate silent
> > hang requiring a hard-reboot. With this patch applied, suspend and
> > resume work successfully.
> >
> >  arch/arm/mach-imx/pm-imx6.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> > index a671ca498..d9b0c1803 100644
> > --- a/arch/arm/mach-imx/pm-imx6.c
> > +++ b/arch/arm/mach-imx/pm-imx6.c
> > @@ -360,7 +360,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
> >         return 0;
> >  }
> >
> > -static int imx6q_suspend_finish(unsigned long val)
> > +static int __nocfi imx6q_suspend_finish(unsigned long val)
> >  {
> >         if (!imx6_suspend_in_ocram_fn) {
> >                 cpu_do_idle();
> > --
> > 2.55.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
