Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD544A3866
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873136; cv=pass; b=XORncNDsceb5G/M7xva52ytHb1BrMFYzsnQOuvCS9zvF1dqTR1KGcxIjpEAJpbVmKUeC98hUaynUA5g+RP35iLjMb+uAfHJA6lmjNs/rgSscmu57QY6ddHOlmKAwO/cQcjvsbuZwV7SKpDaucrpQoUZAtDpANNr1kKxcH+y3zas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873136; c=relaxed/simple;
	bh=skO6HOeEOlSoI8HYXQ1xBxBxbaOcIwy1hi5C/W8lSm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7/sefnap5K/wWAjgLReCJsslB/Yu74w4uQ8mpzKX8My3/9BHHlN68v2CoMIIcu/HxHB8dXNtq0ba7HBIlgxSuTWoXlmFseK9qRZK8eVj43Rcn4i99p53KPxQuxWPP74g/HsHikqpJrNxpR2ghJ26ZZBzUzdpc1nmP2VhjxRc3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSHQvlV3; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSHQvlV3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5337c7b9937so1101cf.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 09:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790873133; cv=none;
        d=google.com; s=arc-20260327;
        b=So2Li9fAjA0V02iv6svSwtYJ3DqjGPl8H7T0ydb4dCa25Fm3JZmR3i3WoF1dHdK6m/
         vF2ulBA0Ndy6S0R9KEDwtgnPD5L0wp59Il4QrqpPTWQudnmD99JqlNKgc33YtopJc2A3
         cE2DtMQbEfnjvphsaiYso0KD2xpTa/oMie1PIyy8f3xXOiMPt2GIWuZYJ48YO9SEvIBz
         /PmthtFjXiBYhy74R8axsS2qRfzZOQX9jQLVMKyEUuu7jNrRfbQW6O+2VH+j8LNFytz0
         hqw3ott0o6KR7nCCyteLoe3aSQHT4yX/MDQ9W969kWDFVlRiuBpuTLHVRnbxKP9GnfRB
         rsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        fh=EZdqFnzNvpH0FhczwpI4L2RyHaURdN3swMpouFr4zng=;
        b=Kk43bejejv7XLDXLEjmYbta5bO5eeZbG/DnnT9Cgg/EZn04amaWwiE2Tc6N6v0AjO8
         T1Nfyi1cVCDa5SePYRoRGPN9CIxl944IWvY5B40QDZzpGV+f+qifVX+FWwaBlohQB5Hn
         ERYGLwuNuWM/9Czvu9rvnCTbB1b+CAT5aUQoiSRQK7jsg4WgwZV/EBi35AGNZ9ci1ptJ
         klwFX2+1ZBy51ssImnFXUC9DCFKKOSH65V6F+xCbJ0VfyFP83jfuPSiIrGcrIHhhyZPY
         bVfcuJT0O2oo+GhinjQ1dQSKc8Iy7wm2b0BjXmT4SrbKUwOQ4iF70WtbLNAtXuxzorbT
         uR9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790873133; x=1791477933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        b=dSHQvlV3ttXf+p0UrKNvkc+mwmTE521P+vXOYLKzyAFQ7uoAytn8r+U1gLRKQ5iyBt
         Gjretepz+PLrjFNLaNi9m/aNN2dfHPwCeNxI+sPGsbyY5xmyBUkyalmsoZzzWOQZTGi3
         vzIo96mKt+QGBeyJxX2juiUd1AJZujGhWGxro0WYQG4gmF4/lcJoed/1a5KjkY4ly8SM
         A61aUTGBspAU+wK0M/GpQRhHs4Lk4rFehX/PlJJAqgCJXUR/PuzYT0Yodf928IYWRTUv
         wbmhVrzViTLgEteqKxdBbCSg+l6yj9TrSNj0bl9F4IpsiZSwC/tFQ3LKKDNiaLcM2vd9
         73Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873133; x=1791477933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        b=XVDzksNRki7lYzB7w/cROhLF1YlXFS9adjZLYxH5wONvy0gb5XIehWWg92pm/o2Wu6
         hyvsKDYvGbEhGTW43k0h/FhGNelr9C7vHUdRbqNkeocPbrBoW+agzn4abrqN2GPshzvQ
         stayfOGMUXNpV5KKwscqHfuBHDwpBcOcgephQIdPcfPuCwl4ZZ9HVOObODWmN7nArejd
         BnF5T0IlPhwgAQQ7ly/6Umz7iysHwn1t/nvRKxB3Q6HCRUjciumzwAkf+FV548Wj0r1U
         j/wC8B+mhb3Y2dU1tamCdTx/1kMT5obYG0CFat3q/MzzkDFQfOifK4ihv6q+nAq2rvmz
         H1Ug==
X-Forwarded-Encrypted: i=1; AKwUvBzXfkXFJCRnVqJVA42RF1DaqyZ+CsjJoTQ1TOQ+39nTfswS+LejzE6zxUxCHnYo6wqE7KUosgc=@vger.kernel.org
X-Gm-Message-State: AFuF++mPehliLPv0GdZf+igSuNkotoBDbEMRwAsU+A433LXbTSxL5F2N
	NvZnzMjdob3DTujqPEWWxLM2lLvidtPTPZo6jeT8aHf6foZaLXszu2QzbOrkAk/S95xQ0Eh7e8s
	Hl0Xhh7L0ESsRlUXuaPSba/qSq0kN3nheK/AYLx1v
X-Gm-Gg: AYBFou2IeBzCJ4mE/6xbG4lrJRdaxdx7J+JazZMwfLHdVirFXFWiDkr0sC3fN9JJ48f
	41IezstotXquo13SyOk0YRzL8oyi4FtobP18I78McgEzCLjHfQ+BovtJn2xNndtx0OOqKloUPxT
	TUPVJjPzZ9GK5RCGbhMpY8f1mJriNIRiqIWIq/1g2vmTLLeNAgS2Ah3Aiu8pRNHOhIy4nzX8uMB
	H0dt3b8MkO4ZUxPpWjZ8J4fh/cXt+v0yheRCK4psjKiGUi3G6Yf8/9XNW+wYk+u4Ko4nIfix0bp
	tSQnXtTf+j5f1bf+bi+tmjRM2BTO2brfhK5H7O+uYZEHDxLPq6EDBaAkZQfVbiyw
X-Received: by 2002:ac8:5cd4:0:b0:532:858d:e791 with SMTP id
 d75a77b69052e-53389203f68mr14532881cf.8.1790873132647; Thu, 01 Oct 2026
 09:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929182108.794434-1-irogers@google.com> <20260929222332.973435-1-irogers@google.com>
 <20261001070755.GQ88198@noisy.programming.kicks-ass.net>
In-Reply-To: <20261001070755.GQ88198@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Oct 2026 09:45:21 -0700
X-Gm-Features: AclHuK_uPGIN6Z6xFRRwa7F-fBv3kGJch6oICz0HkXG7IE_sZqEVpHGVInH4o1Y
Message-ID: <CAP-5=fXCL7bd08B_i676eVwwvQ7XJua2XTvck2Nu3_ujBD=uGQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf/core: Replace perf_event_header__init_id with
 full header init
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ast@kernel.org, bpf@vger.kernel.org, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, song@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Sep 29, 2026 at 03:23:32PM -0700, Ian Rogers wrote:
>
> > Rather than splitting header initialization between callers and output
> > callbacks and saving/restoring mutated header fields, replace
> > perf_event_header__init_id() with
> > perf_event_header__init_header_and_id(), which initializes header->type=
,
> > header->misc, and header->size alongside the sample_id fields on each
> > invocation.
>
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 33210aff3ee6..c1b2d0c9b2af 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8119,13 +8119,18 @@ static void __perf_event_header__init_id(struct=
 perf_sample_data *data,
> >       }
> >  }
> >
> > -void perf_event_header__init_id(struct perf_event_header *header,
> > -                             struct perf_sample_data *data,
> > -                             struct perf_event *event)
> > +void perf_event_header__init_header_and_id(struct perf_event_header *h=
eader,
> > +                                        struct perf_sample_data *data,
> > +                                        u32 type, u16 misc, u16 size,
> > +                                        struct perf_event *event)
> >  {
> > +     header->type =3D type;
> > +     header->misc =3D misc;
> >       if (event->attr.sample_id_all) {
> > -             header->size +=3D event->id_header_size;
> > +             header->size =3D size + event->id_header_size;
> >               __perf_event_header__init_id(data, event, event->attr.sam=
ple_type);
> > +     } else {
> > +             header->size =3D size;
> >       }
> >  }
>
> I've renamed the thing to perf_event_header__init(). Also, I've done:
>
>         header->size =3D size;
>
> and restored the:
>
>                 header->size +=3D event->id_header_size;
>
> and lost the else :-)
>
> But yes, this is better. Thanks!

That makes sense, thanks Peter!

Ian
