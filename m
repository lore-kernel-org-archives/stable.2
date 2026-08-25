Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2743A63EF
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653536; cv=pass; b=E/K80EUu1N2UnxrQi9HZDscEdM6XyyCgYRl0VoZf/HRru5PlEDnqC0dHXwH1Bt20gQJmzG0tWBnCKGjkEBX13lvSmNTMKOqVasdZe1T1WwM5r22A2l3nePg4SIjHb8WKIrv3/COxVU3lB4CjcvKvCQAYV6B8wbzjPsLdsgjTxxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653536; c=relaxed/simple;
	bh=HZodd8oSY+EzdU2Hvr+eLXiq3pe6OJQvkFM8hIxOLbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv3LDxkw/RMPIggSGFnGH4UHCMcE0g0CYinnzilvFEu30fvDHzKWb6W9nhDa5o5W2SDvXZhzVi/B05t2JtoVU/5FEUIBvt2odkVyPoT4QRSohHjniCEckApSFlquhjiteI+cM3aIPjEYX3l9GhdcUjZ1qk7ZhATYpT/e5YrVrY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOg0BrJs; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOg0BrJs"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1600d040e4so99366666b.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787653533; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMivnps0gSk0CZgaiDyK+iCyDEmXBxd5jpDyZR0ntftNQqsb8dw/aLb1SlZDhWerjj
         TNg0QdufrFXKlb+BG3ATUUXd54lFLjjG+biZADwJzJ2Fp7KrWh8xtFYr2Rrlo9xgANZ0
         a6BzT/fsvy6rXeRfvIEPee6S2xS/rkIwZms50pUZb2MG2sd3JDRXwWXpWupy/gNocevQ
         1CeL7lj7YaCBbD6istYGtdzquzo16JwcjGHDSwuRFEePE3LirpkyxflTblOFzJDIHcDe
         7piNucoLVXuZs9QPWbgY2P4SgGTDkOsqQhbJSDwUecGmBNZpWVwaIfxtXM44URLEiJOO
         vl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HZodd8oSY+EzdU2Hvr+eLXiq3pe6OJQvkFM8hIxOLbs=;
        fh=gCmDcZGUySJKdLXZ4g+YtsYhACk5T5eHMTncmN9V78A=;
        b=rhWocL0fZy4jnC5VA6WHHGrT7vzsPVmNw9y+892gDKEsRk1TOH2HSPoQycMhPU8E+4
         P0Ok+z4Fc8FZAiNR9oferEHr1w0fvnodnGx3uM49KipLaHwmm5+QC8w6yB3jCvKQ6y4e
         bx+z36FAe7innmKKPyRDbB3BlNlZwcsIHd2QG5A7Y1pdRtTxeewlPby2jEi+4v1y8bqZ
         uPlZISXOzR4jTzcJ0c8D+Yb4x9aVy6ptcX7U6JHixKRobtB1yUzUFMZ+N5V7cyIZ8j0R
         8F37ci5D5g0vdyXVEZ3moQQYrlTZaqGFrR19hmTSR6aXS8Fff/ufRTkxDy8AYwe/SVih
         bcpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653533; x=1788258333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZodd8oSY+EzdU2Hvr+eLXiq3pe6OJQvkFM8hIxOLbs=;
        b=aOg0BrJs0TUeyJzOtByLvDIBUWGUkj7G67xhXWbE4woNFjWSRnFG7ccOJdpeZt+r5c
         Yqrrjm3/l3h0rU6S295i3trktHliGtfDpHRNct4GxaWOiy8Au18xD1R9Utc85aNYbeAX
         +1Y1ivZcOyi6EGBeeatcc9Y8VV9L/CvseQmnXQbsgrIvr9aFUKaybof1qJ+lPm8YoRTo
         sEwzVOg/LLDMz0aMeiuX4a4+6reXWVXrssJQJ/+b+t64iYX6YBMCmZ1PYQoheZaGoGAD
         q7hcCTvAtoqfVWpITnq/bDP5fZotMb29ULLYhkHrReJcWFuY+cwfncLA4L+HZGp0bLvI
         E7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653533; x=1788258333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZodd8oSY+EzdU2Hvr+eLXiq3pe6OJQvkFM8hIxOLbs=;
        b=CKrcrt1rsQiKJt/swrHfWFZINEcXphEwOr0UdlfcPXOY/rE99yhSLzIIxFC6eUfoCg
         J7DpIdX+M6S/GAKnPaYWqFJrrkuJBj0yP4cTEemG/yMGr+rsLSrTVgTMbu+PYy7bxbum
         5waWhlJFJy8XtSUJzJePRqnUAxxUzLfMcyu1QpugsIa667zHITjRIX9iKWoiKVhUJ9rv
         fFPqlyEXI1FnVnr/V1dPDEb6fFfxDBh9ViTJ6DvilmZUIpNQ3jaEVFUQeAIFvgWqRAqk
         eOrhYIyWIInxvs78O7miCNT5g3JAF1kaCnc9awp4pUpOkTBD49t40pFRIPA8R0b9h2Gi
         YOuw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2meLEbkzTxKJtQ0OuQjqgaW9MVkDYAIF3G2YZCeFCYNkk+KiGtVHlTVlhVwqtf9Ozo7v1ZtQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lXALUP4k1oZ7xzqnKeoXdRl3hb/eHWw3d1c6WI5M7gOR3QadqI
	J2L/msPJsRa6PL/+J3ZqQe5cui28hEMjIriiMg1GminKZW6E02B4Lqkg+86GQEjTRalC89o/2UY
	QuatFOrmhh6aOUBr1Q3kQgI+ANB7VeAQ=
X-Gm-Gg: AR+sD10kAB+atxfCrjU11wnt/FjNLcyGPZb2miGgv/3Mj2GR0LwAYXjGJqjXwwLI48L
	4P7pKjAza5JIup1Tw7GyQWWBx0vqm9eSywz0smLNOarpKWVR9jmXMjKhfx6RwAQw5ngifkntGNF
	i7Rq2KsaeltNG5c48iy/SZXD+3PDN2iooxPh9ALIigIINyGvOnugJVtNVIrGsrXrs024cyxGu7S
	UhysHQ/nE26Rnz5N4quT8nBsjNo7zLq5/FQ8a5n6CtSRJq2hzXWlk1QXJdJNIiPJsd7XoQnhi7H
	EZyv97UU5TY9m4TcPlFaIhoZl7ZcL+hkzO7t+cYqo07qorH0d31ln64TEW49B3jBFR6q0d2Ricl
	uIN79J8UfGoLFrmIUs0VOO25kl6v6
X-Received: by 2002:a17:907:7203:b0:c16:6dac:a008 with SMTP id
 a640c23a62f3a-c24e2d80f98mr533963266b.8.1787653532753; Tue, 25 Aug 2026
 03:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728125456.32359-1-meatuni001@gmail.com> <CADqcGB=j8cSE-CW8dLC8My0rk70RC-Qidmvr-dZvzCUFE5wadA@mail.gmail.com>
 <2026082538-divided-raving-3346@gregkh> <CADqcGBko4B8hEXkgG6LCb9HXoW5HdcTNBAuWh6CQN2cURgkT-A@mail.gmail.com>
 <2026082555-balancing-facility-6e54@gregkh>
In-Reply-To: <2026082555-balancing-facility-6e54@gregkh>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 25 Aug 2026 15:25:20 +0500
X-Gm-Features: AcwNN1VF6BEf03xB8JKDvhR2JhGSl-RksLQX6Ba0p7YqIXxO3MxkYHBnZ42I6LQ
Message-ID: <CADqcGB=WuYuBPaX7SMeagm5G-OwdBKxwF3OBcO105zK-f2E_WQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] staging: rtl8723bs: fix multiple OOB reads in IE
 and frame parsing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Yes, I have tested this patch series on a real device with the RTL8723BS
SDIO wireless adapter.

The device was tested connecting to access points, handling management
and action frames, and verifying normal network traffic without issues
or regressions.

Thanks,
Muhammad Bilal

On Tue, Aug 25, 2026 at 12:29=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> Please do not top-post.
>
> On Tue, Aug 25, 2026 at 12:22:54PM +0500, Muhammad Bilal wrote:
> > Apologies for the context-less ping, that was on me.
> >
> > For reference, this is the v2 series (sent Jul 28) fixing three OOB rea=
d /
> > stack overflow bugs in rtl8723bs where length or offset fields from
> > untrusted wireless frames are used without validating that enough bytes
> > remain in the buffer:
> >
> > 1/3 fix OOB read / stack overflow in rtw_get_wps_attr()
> > 2/3 fix OOB read in rtw_action_frame_parse()
> > 3/3 fix OOB read in rtw_restruct_wmm_ie()
> >
> > It's been about four weeks with no review comments. Just checking wheth=
er
> > the series is still on your radar, or if there's anything you'd like
> > changed before it can be applied.
>
> It's in my queue to review, it's the middle of the merge window right
> now and nothing can be done until after -rc1 happens.
>
> Also, have you tested this on real hardware?
>
> thanks,
>
> greg k-h
