Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794406457;
	b=1USHF7o6sDzkYYzfYL6TMXaI2erbbu6trPPglBWueSRZ1s9t2DqUU7hyirKAJak51b6g
	 EJ4V/BgteBlhmHj8FZatsO2a6l+NrFb/n9QVq0i8g5Qgk9YGHKGF/X3jCMoK+6WUf3yI0
	 mdqTsuEhypftNpcY7YNCADhaBSMuCMgX5O/AT6A+LQDPUQKvlT8lcZsTN8g+x3HFWkz0d
	 7fNkybMLFi77NUnGEex8AV7yyyu2HQShgcR+5QILcqLnAW1WyizrLv0R/57F8oYB+Q6rx
	 SvfRd4c2molrWFVYFVHPxye54CGr2SQ58a0pRpwXUWVO4fjX06Uq3+sz56mfamoFPAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406457;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=tJEwk0yeQZ5BY0HMxF5cN+S8qbdxO56EHI6uRg64h7U=;
	b=yDUl8iS/LFZRPRIbeqouX4XDLao5u+9ppVKHAiYHBN9O0RCDoA4m4+TiiRsmviO5bmgO
	 ea1pkZkpSHtbEjbI1ycC5pIZfoTD44TpDJKxts8jHWnIyAWGytzgQKhvXHekh4eV3s+WI
	 bxeWOnpp4RbxLzRvsDR3TeTopJbtPSNU2Iyq5TaoNQrgQlFrJYYe5P747NXCGJ0yG/TGZ
	 Gb3mJHUxpxu9pZ4odPivwqquYzWw6TsHQhmcus+It+GDFqr+oBlN6j6NjL6sZ10gtOcjH
	 dq64K1hvVVsPEDC9oH5F/IzHt0JkPSLEC2v3tTd4xVgnygzytzyowW/mU69Rvk8glSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9DIM96a;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O+Cibhiu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232C60A2608
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2232C60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9DIM96a;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O+Cibhiu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794406456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJEwk0yeQZ5BY0HMxF5cN+S8qbdxO56EHI6uRg64h7U=;
	b=L9DIM96ag7eNSQenf9LvhuxDE8Y+okz+V5/UDdgvs0et6BG1+XFbQxh91+b4nbcG5Z7zro
	S3MZw+eRa5CwXGN394jasjX27Ddizuc+bCh/bWIdcCZTQMZGVKWSc9L99LOxyoHfbk5KR0
	XLKinpTkDaKOlVZnTY7RU1QqYKTc0l4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-kGAny8aAOaOOPPfBd6JKAg-1; Wed, 11 Nov 2026 09:14:14 -0500
X-MC-Unique: kGAny8aAOaOOPPfBd6JKAg-1
X-Mimecast-MFC-AGG-ID: kGAny8aAOaOOPPfBd6JKAg_1794406453
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c50715e8328so30651166b.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:14:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794406453; cv=none;
        d=google.com; s=arc-20260327;
        b=Qu6tgZOdwtI1NJ9xBe9+t+ErUfelkGfAEvRqvUpttj+vdaTvXR+WS8RuNCG+Zj9zE+
         tQ5MTUn8Fx/nDvSHFiUL0lgy9yu6pcU5Wth5KXVJdcrqbsWcHG8yHPPW1xpuZbFhywhf
         hchw9ruCO7kCg42Efyzv+vWehoNZP3v9yYlMFJYmBjmcqfdVC0pZufhJXr83TlUIZbSq
         h69U3olFEalieA4NuzpLOacJNAyoHQkEgEnDT7o+b7nq37cjJQY9rWEvPFudU3WLRc6Y
         R8Duv5M0FCUIajGCNGI2jpsRXImDmBylSWYYC74YQqnWl8WT7YUg0VXkbGlNHBGEHHBu
         sUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJEwk0yeQZ5BY0HMxF5cN+S8qbdxO56EHI6uRg64h7U=;
        fh=nT8ZtNPJZrgiB3+40lttk0eI1YkRXZ3m6h/qRZdM+1g=;
        b=qZCSJQLE6Xy3pWVf5sV+4VK3UwZvjt/J39hw2/OxSAuO6I2KCuoPrgp9z7T3KXc6ap
         fp0CqKeP3VSp/vNtYbANf3OhJ8voQH1Xnte/k+4EcAJOj1UBu0lTd4KP0zaS3POFzW+B
         aHezF/dPv6drXZa7jMlyfkzGucuaaqjgrpxOb/LcdsStKttC/8dQKTSc/Ly3g80EehUa
         Kglw+vtpOthZ9S5R2rbH9fnfmwi8KL+4D10OP6Oxpg2bwdvpTITTZZPYA2Hs/JNLd2v+
         Q+wlScG9XkgvA8bPifo6ct4PRRqb3MuJQxQza5i74KAfCg6ghIZpnRjSw38W5lPUvSFu
         Btsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794406453; x=1795011253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJEwk0yeQZ5BY0HMxF5cN+S8qbdxO56EHI6uRg64h7U=;
        b=O+CibhiuAUairrUxpqFZ59nnHHKKYUe4X/WfhOlj6LbLJYfuA1x6nPsSxBhYr+t6QM
         tkmz5vsSWUYkGpZWr2xvI00arb3Kf0IJbcJW+gyDjpDgcmUVAzSg25m62Y821uAL9hDw
         jd73R0O5nKUgiBMjAwqxk14gKmiaEqZtIrj/4eeEt9MV/Y+RbonPIzxMVrNfIoPZQQZG
         quUaQItc2xzB51JJVKYOA7BjmvqHsoqzeFQNK0O6ym/1jXo5RuYtAKqWZCnsA4gIR8sg
         w90roKWOP9Mh8342NPkyALH5Zf2TGF4yS+EGGbUJyx/YI8ZgW+2gs7mSHsRVfEubFNar
         jRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406453; x=1795011253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJEwk0yeQZ5BY0HMxF5cN+S8qbdxO56EHI6uRg64h7U=;
        b=2pO959e8upwQGPqnP74ZqZ0dqxMVMEdaDG+ada/+yElv8wMtvDNuaOJLizcDZye/6m
         H+sPPcPsVLH6xO3ZGQ4YDUQKhEs4d7lk7X+tAH9PowRh8lY9PmHpgEetjFLgO0hoWDVE
         p3EAKzAaFC6aTcr9Ggpf8gZOt9pFlMjnp8EFnOFJoYLlTS+M/ZK4Fe1bCfCs457tKiRO
         OhnkUw6qfYLGOqKR7vHUxD31Xnmj1AYlOfjA2d4BBU944+i+vQgX/FLtIc15Ju8SPpgT
         BZeUKhvQOMPimi/xYVwdWOIYZNaF5Yet2v8MhAjs0rqB0DS+u6SBbG4wyfqBPp4/Ckb2
         SSXg==
X-Forwarded-Encrypted: i=1; AL+hErHlZDGh4bLQaYTH8dr+8szooEzmPlu7p0l4DG7jrNK6J9KUD555bpIDl9Y0zenoP2Mite/x7D0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0AHKCXfQpCcjZ7G9tIyCIN2r1bJv8ZxDzuj7C0XeYjHsmWs9y
	yxp8zENqN0MCESQgJs0Y7LMazX0eUzYqUEFshCmk5Ue5pdl0ZHPo6wNA4ax28NCDz4daF9gdHX+
	9RdftydnuXbcfwgYVb2BY7V5J6PpaGS+hdt6IIcowAzq2eMUKVJCbPQmKAfm/E/ZEAQ2DzIDJNb
	etDvgLTq2KVXSbOcB/P6NO7b39XQr7ODJS
X-Gm-Gg: AYBFou3Awi8UPbS84KP1MSi9NdQjfA2bGcxTwBGnJbzkiu+aqij2CeOLCU/lHgClZUt
	7e0VEHuxNOt6YG6RA/HCNK8gSEE+1u+yA5pcYynNnW8rCo9UPzFQYkkQfXkYwRHKz5q4R3DLdbC
	7Kf5XQKurMl9baArn9CUvtGSMTrQglO2R86vDZRdEzfr69v7xPs9v6QtO9gewTkhyC/GIZFxwvs
	QpDCr7nY+dPyKftRtSU9/K9hhF+sp2QRAzkc9sZkXZKIl8nKkyOeiOKI/CYJ3kaf+UFcaZ0Bsar
X-Received: by 2002:a17:906:9fd0:b0:c40:5ee3:8698 with SMTP id a640c23a62f3a-c5066b563cfmr215905866b.31.1794406453460;
        Wed, 11 Nov 2026 06:14:13 -0800 (PST)
X-Received: by 2002:a17:906:9fd0:b0:c40:5ee3:8698 with SMTP id
 a640c23a62f3a-c5066b563cfmr215902966b.31.1794406453032; Wed, 11 Nov 2026
 06:14:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015113738.435986-1-juhee.kang@redhat.com> <a626dba9-6aa2-4cf9-883d-8c6f94770d6c@oss.nxp.com>
In-Reply-To: <a626dba9-6aa2-4cf9-883d-8c6f94770d6c@oss.nxp.com>
From: Juhee Kang <juhee.kang@redhat.com>
Date: Wed, 11 Nov 2026 23:14:01 +0900
X-Gm-Features: AclHuK-LaKGJTHFBtUxEsdfkP6i27gB8i--xEgkyocEdovtvbwJs8a06wnvjStU
Message-ID: <CANBgpCxKYVExEgpS-8PqWqHvXV1nkF+1CzekQKnHGsTJCq7WKA@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/drivers/nxp-stm: Register sched_clock once
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>, 
	Dustin Black <dblack@redhat.com>, stable@vger.kernel.org, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Just following up on this v2. Ghennadi reviewed and tested the patch.
Could you take a look when you have a chance and let me know
if anything else is needed?

Thanks.

On Thu, Oct 15, 2026 at 8:40=E2=80=AFPM Ghennadi Procopciuc
<ghennadi.procopciuc@oss.nxp.com> wrote:
>
> On 10/15/2026 2:37 PM, Juhee Kang wrote:
> > [You don't often get email from juhee.kang@redhat.com. Learn why this i=
s important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Each probe updates stm_sched_clock before calling sched_clock_register(=
)
> > again. The call then subtracts the counter value saved during the
> > previous registration from the new STM's counter. If the new counter is
> > smaller, the subtraction wraps and the timestamp jumps forward.
> > (e.g. from 0.4 to 32.9 seconds below)
> >
> >   [    0.403653] sched_clock: 32 bits at 132MHz, resolution 7ns, wraps =
every 16243448316ns
> >   [    0.404056] clocksource: timer@40120000: mask: 0xffffffff max_cycl=
es: 0xffffffff, max_idle_ns: 14456668980 ns
> >   [   32.890509] sched_clock: 32 bits at 132MHz, resolution 7ns, wraps =
every 16243448316ns
> >   [   32.890882] clocksource: timer@40124000: mask: 0xffffffff max_cycl=
es: 0xffffffff, max_idle_ns: 14456668980 ns
> >
> > To fix this, register sched_clock once at the end of the first
> > successful probe. Clocksource and per-CPU clockevent registration
> > remain unchanged.
> >
> > Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Tim=
er Module for the s32gx platforms")
> > Reported-by: Dustin Black <dblack@redhat.com>
> > Signed-off-by: Juhee Kang <juhee.kang@redhat.com>
> > Reviewed-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> > ---
> > Changes in v2:
> >   - add the comment
> > ---
> >  drivers/clocksource/timer-nxp-stm.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/=
timer-nxp-stm.c
> > index 6fe098a4a33f..23b2d44e4b78 100644
> > --- a/drivers/clocksource/timer-nxp-stm.c
> > +++ b/drivers/clocksource/timer-nxp-stm.c
> > @@ -211,10 +211,6 @@ static int nxp_stm_clocksource_init(struct device =
*dev, struct stm_timer *stm_ti
> >         if (ret)
> >                 return ret;
> >
> > -       stm_sched_clock =3D stm_timer;
> > -
> > -       sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->r=
ate);
> > -
> >         dev_dbg(dev, "Registered clocksource %s\n", name);
> >
> >         return 0;
> > @@ -473,6 +469,15 @@ static int nxp_stm_timer_probe(struct platform_dev=
ice *pdev)
> >                         return ret;
> >         }
> >
> > +       /*
> > +        * STM counters run independently at the same rate. Use the fir=
st
> > +        * probed instance for sched_clock to avoid timestamp jumps.
> > +        */
> > +       if (!stm_sched_clock) {
> > +               stm_sched_clock =3D stm_timer;
> > +               sched_clock_register(nxp_stm_read_sched_clock, 32, stm_=
timer->rate);
> > +       }
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.55.0
>
> Thank you for addressing this issue!
>
> Tested-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>
> --
> Regards,
> Ghennadi
>

