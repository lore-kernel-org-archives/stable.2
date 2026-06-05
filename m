Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357453DB651
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652879; cv=none; b=YGPrhO295O99Gt3/1/n9xHhhkHej2gTcKsKn6WR+uo3n+U0zSyRX/hIXlliisuiIzyBHVXufN2CvOnFlwiQklpGNhm5Fl1j/zkshPnZhKAvn0v1J/xfpEcjK2dL1c0ouV5wOwtSFNHW0UNrnGAI0ID+Cd4k1Apy3B/JwRPxNp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652879; c=relaxed/simple;
	bh=XegPlP0QUg8N4ZbYcx0a/twqRUS5iUtjIM8XQ1lg9EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LS55DPYMlm8G4tTfoQpk/Aa3phAWaZPN3PK9FjO28ylp4Ypxmb+KjDVtkKkxTiNe2O7vo77YYe7PotxEQbdIOWZXw0cx1dNzNUlcDxptuhG+QAHnIlYaTN/JdQI46KGFF6dyYVfkakv50i346FxuAymBiV6zyX3CbjoIWx4cq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-59ebf30a91dso590806e0c.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 02:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780652875; x=1781257675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frpOI/birEQQyfTPmqA3egHq/XurZUvg89/zJvb+Gi8=;
        b=FGHunghYzN3eCmQVd9Vnv6wpV2UAlt0dt0mTUYA6c+c1GjNh/wAhHErOH50B5KN/5y
         sOwRyvuUaGWDa0fit/uumpmlnhI5z7gdRpk3BjwLLwaTxLuONRoOyDcCgKcsa3i+UgAD
         2+W8X6e49Ul7/SU65pa9YAdB5Rjfe4hLXtKriSI3qOpRiFBTCK3lOEmhCMhP/gP7ssWM
         bhVDsslPCaomZuA1trfxa5bqL3jg8yUzLZ1gYONw4DRz2BYPbk3oEmjxqEpzR+1hunRG
         2U+J6ChMDHgd/kE2FU6qGzeZb5NKNchJ9XLiBIaxdwPjXM9O3uDowcptidx7vxpNY78m
         Grng==
X-Forwarded-Encrypted: i=1; AFNElJ/LlAbpTPtLSJJVByG4mSTfxhRBVPEDpsPnTaoGP/KBTfk2F5FdaoE9c3fl1m36dIpUwG6irOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lch3h7V/8sXYs+itNJnqT/oxTGXwyXj1O0V8Nu/d8LyS/Y4i
	0EuQIGurXL5UIQGweS6jwiHlGMrL2WGHXExFcyDF02wMhbrLpd3XqH1e5M22l/DB
X-Gm-Gg: Acq92OFeKamqqcjHTksBoXLdLAgtOyNuccqf1St2W2HEIqK0vXV6AiSFvuvM4tQ8Ked
	QNVvX6rSKTscNO+q6//hc7NMaraGiiwaajg9JWgtvpBnDW0nBl1aAktqpUDzGOsr++LQq+ou7m6
	nMh5g9dbi9aQAcdrE1U+dC6piW1OuK7nndD8sT4WJZvioUhUYdquD627oxNHIEFj4jj7A+yQr40
	1ukJflTzc7TlLdl2bVE6fdgGUVSrcmkgFOWBNcGpVlEeQqlhO6gkL6RVKXHTD3EhuNxRziCk9aR
	nJN6b+xYKdDKtLDb2yaZ48eSybjyuBVAKl34n1TETXqwfTQcUrltInJFxTSIyWBSI/UOOzVjcfQ
	6X50VcpCDg8vQPke9Xz3d502jxcGk9vNsUaQx7qXOSglFVfZdZGK05GIxKteUuOP2tY60QYo9t/
	9v/JTxflz+0UbKNWQ5VDaDS/0txTbGE7KPUwWmpd68eOAM5QO7vkIs4Ar6dVKGbk1YpSJu7b11r
	+og5GiU+Q==
X-Received: by 2002:a05:6122:7c6:b0:5a4:c20a:ba4d with SMTP id 71dfb90a1353d-5ac4ee91209mr1187497e0c.4.1780652874968;
        Fri, 05 Jun 2026 02:47:54 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d06a491esm7163987e0c.0.2026.06.05.02.47.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 02:47:53 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96395a59ff6so605045241.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 02:47:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+a6RPXr4XHLL8hdp5v3NKJzj0FYRLqRfnCp+w2IFaY6gneB6/3lLYqOhAd/Pl7J5nGJs+HQXI=@vger.kernel.org
X-Received: by 2002:a05:6102:5094:b0:631:26f6:701a with SMTP id
 ada2fe7eead31-6ff156acf6fmr1089364137.29.1780652873088; Fri, 05 Jun 2026
 02:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603151642.4075678-1-claudiu.beznea@kernel.org>
 <20260603151642.4075678-2-claudiu.beznea@kernel.org> <CAMuHMdU_T=G7os6KBG6xTnphnhQ9pQtd88BUkg61S7286bZmFw@mail.gmail.com>
 <TY3PR01MB11346903E1B762B66EDB8CB8486102@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346903E1B762B66EDB8CB8486102@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jun 2026 11:47:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5SE7KsiWsp+6eFpO2R_pA6k4+sjAQcOQFC+pgOY9chA@mail.gmail.com>
X-Gm-Features: AVVi8Cd8crXCTmvuTR9VXD3Qx0xyM45BlA1nZ2BpfmDiwjntvYP3B16PpfLU8T8
Message-ID: <CAMuHMdV5SE7KsiWsp+6eFpO2R_pA6k4+sjAQcOQFC+pgOY9chA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] pinctrl: renesas: rzg2l: Use raw_spinlock_irqsave()
 on power source update
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea@kernel.org>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "linusw@kernel.org" <linusw@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"Claudiu.Beznea" <claudiu.beznea@tuxon.dev>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 4 Jun 2026 at 12:58, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 04 June 2026 10:49
> > Subject: Re: [PATCH v3 1/6] pinctrl: renesas: rzg2l: Use raw_spinlock_irqsave() on power source update
> >
> > On Wed, 3 Jun 2026 at 17:17, Claudiu Beznea <claudiu.beznea@kernel.org> wrote:
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > The rest of the driver uses
> > > raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() for locking. To
> > > avoid concurrency issues or deadlocks, use raw_spinlock_irqsave() via
> > > the scoped_guard() helper for power source updates as well.
>
> Just a question, will rzg2l_set_power_source() called from IRQ context?
>
> This driver does not have IRQ. If any consumer calls rzg2l_set_power_source()
> in IRQ contest?
>
> Have we seen any such dead locks/concurrency issue during any testing?

All pin control drivers use the irqsave variants.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
