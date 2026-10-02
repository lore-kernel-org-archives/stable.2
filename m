Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA343B3EF
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970998; cv=pass; b=b2kzA/Feca9v+pySddUb5BOEqvfEHQBFJoPH8c4NhfpXCkz/KnX2z6IHw5I5Oq+Yc3UOiN2uJyUHThc1zQVuMnRz2J+a836I6oqDFg9BuJH6UiJGNJNAqMlEnPLqNdkQImCzOJ4Kqx29FyryS/SIMPbadfPfLDdL/5p4nHs06iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970998; c=relaxed/simple;
	bh=1ioCZTbb41W9FUOixCvFBhIck+r0y9BJGbVcKNL0CmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atZEeK9EHsjnLnFL9WDJrMhzhdJ8emEMOJskwUSPdckQeaI2Ym9LaTwQAe1JFAMmZhhY2ElmywahZG7SL3O/ei7cm+3tn9u47i7KWv2wIM7d/nCIkqf2vwUmstvl5Aus4RyE/fmxX1STJoO1lW2uV3XFaHayRU3ffOLEwvlT0qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shneLzs2; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shneLzs2"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6aa850436d3so2196772a12.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790970992; cv=none;
        d=google.com; s=arc-20260327;
        b=Gwp1buTBySFV3J32H0jlpI/scvTu+89G61NaoqnbeqFf1DlgBytHnTpGbw/OpG72VB
         5bX/Td7wWUJeBcM3bLfuWE9VPDGB2ikNBmbnWw+tbuxyHKri7l97HFUVDUQKbF6Avl8v
         MBlokm+Jud6SlKHAeuYTJKoOoEBH3xq6iJXK9S92AVecJ67loajpr4WNfubu7T2stxj0
         AsDDPnDSey1WROpIGgn3lj+ZJryY15BZ40mDNP3UrRQ4Lh7rIoCDhBXy3knUrfnPf39c
         p2XmiIoYDA6SVuAyr386CcL3SIkk3Vxm2aX2BFSFVF3GvGjyzmaAswMtTC1IwGJJVqlG
         p9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIxB+o9asvwUGZP/ehweqbShcz/sSoH+9KFLtoHp1eA=;
        fh=j/Yt+BxBiaLMCkSWRJs6nOog6Qf8Rfk7Xp9Oe5EYWnw=;
        b=OJJs1evDuesQ9O+mKHyhg7L9nzH2o4bH3JRXYeVb+8IaAwZZ5qp7ysUYhIfUFT6yaU
         Kk642a9pOW3m5/UJsubADnpnbpFf6q4124rZQtWPu/nPysz9/SXalHyaL1TMSmTTPUqB
         S4TBx7ifLBWhUJD9X4zY1N2Fg/PBSLqa8aTQo6Of5teJhyLVO6onuwF0/tsRhvKPRcux
         liRALboswlMcJPIxD0mfl1CsB3j1ZVugQngJJsQkSyv4xpNHe9kD7acuYshrNRaagqyh
         dl5/cYNIssK20mHHUxn0HbLFitmeuLhsWZBZivsKsKDX+hizS8J1pBDd/barFJND+aJI
         XX6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970992; x=1791575792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIxB+o9asvwUGZP/ehweqbShcz/sSoH+9KFLtoHp1eA=;
        b=shneLzs2LcbQqXPDXmIKxYXwzvwAachuoY+x8UQrViCAmsHLcjX1FXUmxsAaCB+kTt
         yrQMiLHtIa8sb8Im1a+kTcoTFRewgZu9kIJmtwi5xrHXdKGzWjwFvc2bcoWWxVI4fXhJ
         6vKVtkUGPnG7NZZZQP8huarE6qJiozTZaQZc9lUq8q1zRE8qYY6K7J95RJaK/sStE5ec
         8hBEA94tN8ozciaenW2v2o0yn4HIRbFDrrV7LAp0fog4ylNqUaBDun/nAgitycpXjuhy
         Qp5oAmSxiZldk7XSYPRdpgqOPxNCZ7gsTP26qQf/cRhtXmPV1fvhGSqhb8POCYQ0edbE
         2rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970992; x=1791575792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIxB+o9asvwUGZP/ehweqbShcz/sSoH+9KFLtoHp1eA=;
        b=B7p508osBAuOjOZAudmnSluFrLUH2w9ea3Dr7TtMZzrPlF+bJqnxGjm+SqstucP1sg
         OYMfdPJYtAT6SLTFVLKsrDrU4+N/B6ah/NESTvC5mPOPIrGivcu5/1lKiYVBG8VDCT2Z
         hkpRkbL+rw+QQqI29onOdDUmT+Ce7Rr/5yTkc8mHYuhRSgnm1Dj4UsR71LSHj7i0EWkH
         XGnhbJF+EHX5H/lPi5Tul6K9GwmKqCqJQPm8IgANJjLKndORSMbd4Yh9M47tlbqPih9P
         rSGRZVdgktqCeGQzp4/0bFpg5YAb7bkJzfxVmEBXwqqv02f9KfWrDkd8LPWETr5x1al2
         RFRA==
X-Forwarded-Encrypted: i=1; AKwUvBwRaexHVBB1MswXfMgirvznktoo7+SU4B5goZ4ch63zFqyz7w5BdI0WzaOuml50ZiikO4euTEk=@vger.kernel.org
X-Gm-Message-State: AFuF++lMEUgXlEQnoqgeDG+6SiE/Ae31cQa46pdzwEGruVIlFLxUPVjH
	A4N92sZYz3S/wFjnFdavKPJPFJT77g519EgDWJKlbBbOXQq7bMfLbWryb2xsmA0bPmJFBqFb6jj
	xwVkizpXtHPjYC+H1n8jxRMZWI/9Ucg==
X-Gm-Gg: AYBFou0y3Z3WfV3Phl90DVs97Mapw5xWD3lFJVrcMY/s+keIFhQy/lXL8IiIW3AkreA
	IdgjV/gfRzH/NcijK52U5r7b1VnSAyMh/gJsgXrlI459JEzPguXkSEJ6oeo2cpWy2m9OOsPFhjz
	AW78/2YV58ApTKSDTNs4l3RQY+MmElzTnUMHJSrwALrOTbFrSrglSjw8sN8J+vFnoXU61BTfEPZ
	SHv6Hw2xEuScS20te/scM65NnpObkPUWNqedQFApog3tO8OygZ/5OyxQ2jSQ0TbfFoC43QzeH3o
	p6vHR17ROXkD4HvqpBecDohlMG3ZXwL1Aba/xA+QLDEa2ze4I/howwrWS45HlZNb6fsdmqGU5Le
	Cgz0QiuClWAmLj3l3EADPVNnQ9Xy56gpFVp2p2i2uK0m+Ww8XfYCb73ap+mk7mbwsiATU
X-Received: by 2002:a17:907:970c:b0:c21:9b4b:2690 with SMTP id
 a640c23a62f3a-c2e6ed18a3cmr18544566b.17.1790970992289; Fri, 02 Oct 2026
 12:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917204209.97699-1-mhun512@gmail.com> <arpa-Ps8l8LOwbbx@tzungbi-laptop>
 <CAMMMRMe7g7yj1iOTOc+TCWe=+1cjFA1rG7H=VfjnrY3p7XCKFg@mail.gmail.com>
In-Reply-To: <CAMMMRMe7g7yj1iOTOc+TCWe=+1cjFA1rG7H=VfjnrY3p7XCKFg@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 2 Oct 2026 15:56:19 -0400
X-Gm-Features: AclHuK9fCvmhfjw1X8Jezy7cxwwOQzz6bhBUeiEHh3Z9gHIC1eoTF30hT-F_4tI
Message-ID: <CAGEsz8G+bdyroK=Fb=YpgWvp+Z3HOGbqkTPt-dYO8u_+26_ULA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Stop altmode work before
 unregistering ports
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. I've moved the work quiescing into
cros_typec_unregister_altmodes() so partner disconnects are covered too.

Pending partner work can still queue responses during driver removal,
so the port work stays disabled until that completes, then is reset and
re-enabled for reconnection. Final port teardown now uses
cancel_work_sync().

I'll send v2 with these changes.

2026=EB=85=84 10=EC=9B=94 1=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:40, =
Andrei Kuchynski <akuchynski@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On Mon, Sep 28, 2026 at 12:18=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.or=
g> wrote:
> >
> > On Thu, Sep 17, 2026 at 04:42:09PM -0400, Myeonghun Pak wrote:
> > > partner altmodes. Disabling also prevents a partner callback from
> > > requeueing the work while its driver is being removed. Use the common
> >
> > Would the work be scheduled even if the driver is about to remove()?
> >
> > > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platfo=
rm/chrome/cros_ec_typec.c
> > > index 50a68819ceb7bbfbd888ca919d678d4c75237c26..e91bbc219c07706729493=
5dd5602c1aec636cfa6 100644
> > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > @@ -378,6 +378,7 @@ static void cros_unregister_ports(struct cros_typ=
ec_data *typec)
> > >               if (!typec->ports[i])
> > >                       continue;
> > >
> > > +             cros_typec_altmodes_stop(typec->ports[i]);
> >
> > Shouldn't this be called in cros_typec_unregister_port_altmodes()?
>
> This should be called in the very beginning of cros_typec_remove_partner(=
),
> or even in cros_typec_unregister_altmodes(). The idea is to stop the queu=
e
> when the partner no longer exists.
> Partner disconnection rather than port teardown ought to trigger this.
>
> Thanks,
> Andrei
