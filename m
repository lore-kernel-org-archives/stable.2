Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042E2E228D
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781476892; cv=pass; b=lM1GiwluAQ1hXZ1cSM3joXcfOdY6xKZAus2vtrTSIQHdjl6YPpcq4yj1OI51P1Gmyc5i7pI9m/ORgYtA5yX5iN5ZN6apXolKcsZvzHlsJBnHACP0fABcAQyOCsHHrcc8oDu07C+2HMwM4dqiMQE37fn9hpSw6tCRhJc/oZGJM84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781476892; c=relaxed/simple;
	bh=8Tu8HEOwDGsG2Hq2gF5ZhLKZeg2lUpEAdn6TcRtkruQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iu/M6JO5Zc8jzbiH/IFvUMDNBotBur3QdjF/ab4MZtNn/lT/A2UaVT669GSHaqn1gc2noP/RbJ6MxOzg7BhoJXbePqMPyQ8P0/frEycIPyHl5jA9ZioxOnmZeo/N36TQHv6/78bY6U8/lmMoJCk4+osrHSpZwEYie24skJHgfQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPgsPwYl; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPgsPwYl"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8cceaacd07bso34562506d6.3
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 15:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781476890; cv=none;
        d=google.com; s=arc-20240605;
        b=YB9y3IvYG2OoARgHNkm9pwh3cO8o5NShKSBgocwLFMAbsNylWUKBi23gxf7ZXvOOvw
         MS3+GS+g7acNnIktkMx8kffhy1F1DVjuPgx0Y+TjjLId+6jaZW+lqIzt95eGKx2B0s/A
         5qXxpD/MfMEYDIN6H7nlJW6Qi2yE31If3rJSQIWGMv0s25mHYHbmsTOK2k5BA/fleHd2
         HYyXG7rbcaP/BOGqVCzME+rdKj6Nw58npAeufFNVRtEOhPtWPx95oMwz9oSp87eetKt/
         YvS3CiXpYoqCbcRTCcckRmwbPiJKRIU0e45hQJh6Jn++x5gUf4MqRBtzqJm5yE3EfMd6
         JlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Tu8HEOwDGsG2Hq2gF5ZhLKZeg2lUpEAdn6TcRtkruQ=;
        fh=IVC1UZEkCl3h0qLLJUrovjq6GIJ/LtQIrdKVNmW1e60=;
        b=anv3syqyubHdnvFVBtKWfGiQrNDzUksNfad7BvqFBtvbfmUYpvWjFwIcCdKnTh19ap
         L4CmeCigfS7fnbdv3As0ehzMe70LrGLtOZUIxWo185cuHyks6NeMkMuXx6GXu9RlSUx1
         fG9uIZNTVlKA0/+peALBZn/HvU9urO2FIRfHdwfHINJ6aXbJlT59iEofI2M/4TEE4Yiz
         pzVEpsR/frMFT/1AjboNNIFhIaVmcuCovOTz0UA19RbL9AbF6JF1nQo25QrTXQbgo5sg
         PYj0NsbdA4UkSLUSdaL4gSRkheefXUOHPmCJhuYaqufvdy1TjPgmlnWfqqz68+Ak+lnI
         FKDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781476890; x=1782081690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Tu8HEOwDGsG2Hq2gF5ZhLKZeg2lUpEAdn6TcRtkruQ=;
        b=lPgsPwYl5vnNL6YMbKXbMXcw4J6c4XGZw1LoZfJvd4PJpmjqMPLSjt5tP9fVb052E0
         sQ2kzc85vc299LyvbmjVrisYVwhe0wsfyAcesPIE1I7cVZv8ozqFtwHSbM23DkBMu8GN
         5id+yYSIySjdrNTuG48ODglDiwNkpV9z3TT5BvbgkaABruem+00gG2pkxyM+S7q0lc/7
         9SvQ4o+p113/3MhuRfdyCdZr7Qz9JWuO7WqJCwAm0vyrLEtyEiOQ8j0pHHoE5QVj5PiH
         LAZ6aGmibZ2dRYboUlkZx92hcQe+pi6I9X/VC4l5rcbP9irtpEsIU1CYbr/Q5B/4LUY2
         73Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781476890; x=1782081690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Tu8HEOwDGsG2Hq2gF5ZhLKZeg2lUpEAdn6TcRtkruQ=;
        b=Gvw1Maed0/hqWJATOH/QokixF+aID6SjDcK+9k6ooAQoMlR+c8951VucJ1dNo+HUD0
         fNZLi/nD0Wo7mRvPmJFPBFr/6KV4dSShYOPSzzQp1kEIvh23hsdQATqrNgIi3kK7ivLl
         Ws4Di4XX/3BveVsykMx27KCQIXslrgSKAofxQP9tgFEW2Xjmpg6FwPGcZL0tVW9qVwtC
         5OCBsvp7nI2OGfK0VoBTRKR93TftQk0iJKkIxUSCngyDN12IWtzkPq+2GwsSgtLzRrKz
         KBxpEiPvCmqdWQjR5BRQl58EmjK7gzYYI6j61uEyNjkF2rTnftwk0aXtQT7FRNFxFFrM
         COmg==
X-Forwarded-Encrypted: i=1; AFNElJ+FdC0cyHsXOq0ODRxyGcxa/RIBEOBWthkAZJRZpVpHaMpDE8nEtzQ9NGCBjvU6VYSsHJcexME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnsXrm5hnU86BjXAmg/7ZGKpwtekvhGlvS0UIe8dQcdv3U7qxp
	3yHICeI9KyMRa2q87XFrv1uKgryJsFKvPpTa3YRk5lEkog1trOViRiyvcBKxGmFTbE9zoUorAVJ
	njnIGGTjp8D/gAO1qmPaRxi/nCivFPkM=
X-Gm-Gg: Acq92OFY/p0NRRrJ8Xx+a4vRj7KRNJCJY7oZ0xHnD7IgSA2QEz+q61I1tHDIBBKehHf
	ZnZs/Sa0F8DY2fB7/dPoYOua/oLZSTnBt/fuTIYeZM5yyuJi04zz1C0dyISwtlidh0M6M+Nk94S
	M4jYKEOU1H/tvC86aFCEVekq7gN2iP/FbSidK84Udc+CaW5iDgBarKE1PkonoqE1409qMHjvYpk
	ExWbuBKmEWG++/OJSkmCqtBWluhL2MOo17wkok4Be4mGuQ2fQ2v2VAPzPUfRXk4hegmE6FU+6lP
	Y8DcxlbXfJFPiBjUEHR/vSt9HQ7lmE7n8QIU+OLoIxXgy/vGxuK3l/OZ5dIQ7xw3I92f30Pp+mr
	uXWc=
X-Received: by 2002:ad4:5ba5:0:b0:8ce:9cbd:b0ce with SMTP id
 6a1803df08f44-8d32e8e00a9mr187888716d6.34.1781476890554; Sun, 14 Jun 2026
 15:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518014920.135011-1-enelsonmoore@gmail.com>
 <CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com>
 <CADkSEUjsS8bOXDhgZ2EW40xifDZ-pk5y=YqyWT-+vQNd8JikUw@mail.gmail.com> <ai8nrc0ZUfPaqC_7@shell.armlinux.org.uk>
In-Reply-To: <ai8nrc0ZUfPaqC_7@shell.armlinux.org.uk>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 14 Jun 2026 15:41:18 -0700
X-Gm-Features: AVVi8CeloLf3X89X-vuKdzus8DF70VSI7924-eHPEfeAfFNfJzWn8AlfAejHrA0
Message-ID: <CADkSEUhx_KDQ6LGEqEfGuB38HM-Xg45jYSUDcp6T_QLbS+ZWeA@mail.gmail.com>
Subject: Re: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Shubham Bansal <illusionist.neo@gmail.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Russell,

On Sun, Jun 14, 2026 at 3:14=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> > https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D9477/=
1
>
> Should be s/arm\./arm/

Got it. Would it make sense to make the domain with the dot 301
redirect to the same URL at the one without the dot? Right now, Google
is indexing both, and this would remedy that.

> Also, you can use:
>
> Link: https://lore.kernel.org/all/CAD++jL=3D0qYGoygUwGEXQL7C_ROnC7kfpRv8R=
A+H5tNWwYu+pQA@mail.gmail.com/
>
> in the attributions in the commit message to indicate where more
> patch context can be found.

Thanks. I knew that but didn't think of it at the time I submitted.

> Lastly, too late for v7.1 as a fix, I already sent the pull request
> for that, sorry.

That's okay. It's not a particularly high priority :p

Ethan
