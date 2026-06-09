Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261B43E9D2
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023254; cv=pass; b=I5kpT0Y4bB4F/KB35CustenAoi4FMq15d9Anjq9AVhU6fBzq7RrvYF05UHJleuQuHnexKh95Np7ezJ3gGmOKZXLqBeGt6IAsNReTMoP82OVtCxZkxFPShN5+uqmXN6aw39+mqjq6kPQuh9Sy/R5ytqfC72RxR+2AOQqdaUjhxnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023254; c=relaxed/simple;
	bh=MsVStE+8JmV+WuKyEllfU1CqZuzsm93hb5AP1UfLNp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3r9o0YPlprTLIQjg5kGG57pYX/MxKPyAHP8zA4AuMuBsLmzTxgyhe0gtnGUKurrHccNTuEWdulp157J/WiO05M137b9XSQVsBWXPq/TU0tCKIH+UfeoK9jss+F9PJk1vuAuMXEDgHPRDHwgG09vUnIR/Ckak85vP4Unxp2ciM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl/cRyg3; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl/cRyg3"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so10301746a12.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781023251; cv=none;
        d=google.com; s=arc-20240605;
        b=DCb0Jhn5IRbBNPeacj0iRHJb44FrVCcG2Wg3fiv8VIlZW6SCgCr0gpFIWfm26fpyzz
         IabG8WRDxjnRlMzJ3bcnjw8jNDdUM6IQS1hx5hggbHxqftY8MFzsksVf7DsJkIHLm7fY
         ygDE9bHD+/RnksiaG9Sf/7JMf7cdDZhpLh5JWlVDCN2cf1whmXI8TWxxRbAHqfj/uKwR
         mtlkoqu4bEHeiIsfgwen2Q6Zo0YMeyyHUbJ9XCiE8EbQr+4hlb+d6B8fuguBNs7HtX+Q
         o13BfpwfoWYjBMudUc8PRHw0x3nPzqao/vFoJlimQRGsW+ZhJW8hsWfjLOF0zXZupqJr
         bccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kCvaSfNh1ZRYnMKcF/LlJFV1y8GsbcWqkLxm+7NCkcM=;
        fh=r1jgOfW7V4TSLP3l4EnbxyFRw+Ra0AoNDje6W29dZGQ=;
        b=Zt+K/ZYsY+KNaNchnAVfAzqN2G+RQ8CekgFsrKYM+4Od9Iju3D47tuWD9vHKVPasRR
         kfW1/fBPO+PcMgfjP8xmOOHCz0vbqSH+JmlqRSBrutm9jGgjef+gyMVvLuAMxi5ijF+n
         Na/2t4W8pxZu9t9zl0ibEsghh3Ukuzcyh53a1dI3xx72yl9gt0vM0v6DujKCDKb0PYBJ
         LWmsBgwY2f/SJ+8vEVmYdtZy8Dia25KTYGRrPq956czfTBChU7k4Q7EwfolDOlRaRa2J
         +enFDlxeo63PdyqputwVPER8007lHV949DqOG+7ygmI8N1G0DPr75h7Gc+MasfBcRF9J
         JM6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023251; x=1781628051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCvaSfNh1ZRYnMKcF/LlJFV1y8GsbcWqkLxm+7NCkcM=;
        b=Yl/cRyg33fbj6Ykv47sgN82ZekW/TfQTlzcijVwClikrmv3YOAuT+g6a419gTw5EJZ
         TmNVmBN1UJkCK2O5a6+6wvopYd+6PgjnLfLy/34gYswmM3Qo6xrjmPflesmfg38LOx8V
         lWqTEwqdqfj//kQ3VIwahEMaGiC9e/e7RnEYhcJEYDlhTm+Yre9BzvWUTSlqXOsZjr/W
         d6Qtmkc0B2DNw/pgpeFPqV61qOYsXvZ5++jh7ZtinwjGO2s/1uBJ9Gg6AMmmxw6PwBjh
         wiBYKAjjI52HDN+txeq1xHb/c+HPL/kL8+UwWaxTLWb4Jl73yrnqeAB5IDa+Vg9yJa5q
         iLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023251; x=1781628051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCvaSfNh1ZRYnMKcF/LlJFV1y8GsbcWqkLxm+7NCkcM=;
        b=Le94ifRdpJ5qgr19M6XzW24UA+8YHSuoXSPxkcAuSs56oLPZF5QnFXRvDouKXfHIua
         fsY0Y/SFJJH6a4f0BGD8nLLvGpf07gxtq+hFWX19bO+6cThmeIR9QeYZ8jWUJ/9NVNfn
         CB79XO0pO7YoRJC9A+jsxiDyJIC5uVQ7YEdeG10Uuxl2sUlTDfl6D1S/xKUVOWOSC0P6
         Opth0WGM5PG1FrEsLZbs2Doanm5yvbevxwUKFri+VWdY/lRzwtHY/K1EuvvfwvmJvFwP
         tEiFTRRcjQiDAVQ/WhrWNr9AVLJwui1ioXUd6AnF1f+Ybr9w5s8eesvaAVfvWtYCs98z
         H6WA==
X-Forwarded-Encrypted: i=1; AFNElJ/Q2t92RtkTr7wPorK6qz7yQaRTfL0YWX5rmjrGYgW5KanpB/l7qov1UJYxY4XBBjRLEraheGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+ysMSPOi86LkOQ9wi3CzzhzLauGUOazyS9rv2tLGthU69uT4
	8KvezJ4qloKoIKhfDc30xYLHJvIsax9rg4pPTJxQiQIJ31/4fuusFgUDyVnJ+tn0aC7381nl8cb
	lj0WfqRP4fqzW2c6gDFaD7gqrRSHjjlE=
X-Gm-Gg: Acq92OGQabi4QY7ypJzMvS7vwGUcwbvf3mCFaBatNG4Oh86wmkNFp2vn62R8yVkq08H
	0wR2ANx8ljgOHx/NhyrE6nEYnIXOJyYhU3IEl93V3n711P0BLTVwCxRpQCdJILC4IZe9IPEu2cL
	Olc3XvK6MjZXJ8JZfzc0kaCtMskzZO80/LinezlMjjVBdtNplg3NcNoZjoiLmgctb1tzghaNZau
	6tGbJIfNJNJ9mGrnsqUVLkqRm/Cr7iee90PI1i+qZ6NyG98e35vyzop2cOOpd+fpwGzc2e07iRO
	jzkx+CLNmcgC/H1bZR0=
X-Received: by 2002:a17:906:45a4:b0:bd9:a087:730d with SMTP id
 a640c23a62f3a-bf9365c7926mr130649066b.8.1781023251029; Tue, 09 Jun 2026
 09:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608190700.85755-1-nbakuradze28@gmail.com> <aie9bqpiNDJ_IU0M@ashevche-desk.local>
In-Reply-To: <aie9bqpiNDJ_IU0M@ashevche-desk.local>
From: nika bakuradze <nbakuradze28@gmail.com>
Date: Tue, 9 Jun 2026 20:40:39 +0400
X-Gm-Features: AVVi8Cd2CjAsOi7TQ5hd3PT70jSm3B7lBtg9-vrkR9kT7vrAHvbDH0sBLQ7Muic
Message-ID: <CAHyzTT3R-cOpJdE=hKPGSBSdC-BiY29y40DURvKjCN4V+w5EAg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: core: avoid NULL pointer dereference
 in c2h_wk_callback
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Khushal Chitturi <khushalchitturi@gmail.com>, Archit Anant <architanant5@gmail.com>, 
	Minu Jin <s9430939@naver.com>, Kees Cook <kees@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right, kmalloc(16) effectively won't fail. This is my first
kernel patch so I was being overcautious with the framing.

Should I resend v2 with the else continue form you suggested,
or drop the patch entirely?

Regards,
Nikoloz Bakuradze

On Tue, Jun 9, 2026 at 11:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Jun 08, 2026 at 11:06:58PM +0400, Nikoloz Bakuradze wrote:
> > c2h_wk_callback() allocates a 16-byte buffer with kmalloc(GFP_ATOMIC)
> > when the c2h event needs to be read by the host. The existing guard
> > only wraps the read step, so on allocation failure the loop body falls
> > through with a NULL c2h_evt and dereferences it in rtw_hal_c2h_valid()
> > (via c2h_evt_valid() which reads buf->id).
> >
> > Restructure the check into an early continue so the rest of the loop
> > iteration cannot be reached with a NULL pointer.
>
>
> Not sure if we need any Fixes tag. kmalloc(16) won't ever fail (otherwise
> the system is already in the state when nothing can help).
>
> ...
>
> >                       c2h_evt =3D kmalloc(16, GFP_ATOMIC);
> > -                     if (c2h_evt) {
> > -                             /* This C2H event is not read, read & cle=
ar now */
> > -                             if (c2h_evt_read_88xx(adapter, c2h_evt) !=
=3D _SUCCESS) {
> > -                                     kfree(c2h_evt);
> > -                                     continue;
> > -                             }
>
> > +                     if (!c2h_evt)
> > +                             continue;
> > +                     /* This C2H event is not read, read & clear now *=
/
> > +                     if (c2h_evt_read_88xx(adapter, c2h_evt) !=3D _SUC=
CESS) {
> > +                             kfree(c2h_evt);
> > +                             continue;
>
> It's too verbose way of saying
>
>                         } else
>                                 continue;
>
> here.
>
> >                       }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
