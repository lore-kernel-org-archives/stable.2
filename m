Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793858706;
	b=EvpbK3STKSbL47KX6p3KZ2XddrizsJm+SlYtd+9NCLZD5qz7H1hFCp1KWpMifzZ2q0UP
	 50HYkmCvUttxbAZwAQ3M9dM6W0Ad4qSaA5jbphmHhUcPp/e4RYthgMcrAmfFjfLAxkqIM
	 WVeuE0a0zuxEUUBG/VfsOJ5g1MkJiM1QHPMJK0vUN4R7oPQiRoWFTlc26hzKnuWnbBeSu
	 DwLz6g42QU7eqQWmQslsTtOhKAbyGW0Uouq6z2Ep412uNiljayb5YMjcv6TdYrMrcRWaJ
	 ROf/0OcywBKreIeEr/7ESoLuyto3u4UzTL3GlA06M0WI0K06GXosdU0dsuC+/GxNdBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6CvS81jcXvcMzjusuBb3temDMl3RUTwUEKg0ZWsbrIA=;
	b=zrPXdr36l/S/sfMRycnxoeOwnaZ+UMt4dH43c3s++PpIoxDRqm82m+D25lfpB0kowrMj
	 lcgxmVuReYEYl/MvTqSZ3F4+1VY02pCGKYOcch2Kb9dIu3jl7kahsvD4kzwWqLYrwZtwR
	 BuTuLpz5La8sUvipRMewiJQw6ztCdti+Wc0SlCugrqT4VoE0XuI6pqcRmJZ0jw+c6dGlV
	 oIRLlktDQR8xRTPk6M+Cf/igTNmqkPsdV7/QBr9OPKqWHLKPmbXQONWGyyKog/0Qu+Fs1
	 RVOUZvBMXx1uiehRhHoSq2oa/eKZHTZvUu9/wm095i+0KPuIw7mFS9c0+onJY/SWJsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l057ZxTg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A7606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C8A7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l057ZxTg
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ad47c246f8so128254a91.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 22:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793858705; cv=none;
        d=google.com; s=arc-20260327;
        b=K/yHIJDOzmEX4JoKBMBTKyOvPKSiXez5b3YuRI3dOjKFm201BEQziSRoSC68aKeF4t
         wjh+1SLoNrUTAyv/mbKXkS3Si8+RPZ5uHXC47n9H5MZvK3zQ/1ALTfh+jNV6GA7iTEvN
         H2C/AycoQiqcZkx05yt3inshdnIsygWUx+FX7cr5eVLvmK7GVqf7UhNVvFhDiYmoL3pw
         /g2gXhnKuNSMdQNbnCQ56+1yuL6s4mDgc1L3RSrGi/4VhsxJuR6TbeV5NdftAY0Dt5pE
         i6b1djVtEJkLn/6UfpXnphTrYcEwqYanZT94evP/SwtVr2UCrw1/nmgPyqs3iXRCBgpt
         6IWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6CvS81jcXvcMzjusuBb3temDMl3RUTwUEKg0ZWsbrIA=;
        fh=vV5nWFvLqMl47lSGnE3VtOC+SibQOTBdqFdaGeqMXC8=;
        b=kd+YLpUdFcJo6IPwbr4A3Tz2bZWVStGqPo3q5EwcNaEI0Ky3Bb1bGCnZ4W5rQxlHSD
         Guos01CPjl7sUGYkCf+6It7r8N6QXJha5jT6Erdt35tgo5vwarsszvzx4CaSzdAJT1+l
         1NdXB6TlDtt9EfABHjufLXNg3pub4SFvwUtogDVLXgteDfsxSCsE2gCSMaPrWd+kJ7Vm
         g/99sh610Z2JlDBSLItHLEnQHRNPn0dAZzSjMz3jfAGkbmaMtpXSWg/OYhaoOfp0yzvK
         mkp4tDl2FM6/CFfyCueXZSjDFbmsbO3QLUH1tF+E82yeqizBe3NT7D0dY/mSFy3hDqxn
         f4DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793858705; x=1794463505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6CvS81jcXvcMzjusuBb3temDMl3RUTwUEKg0ZWsbrIA=;
        b=l057ZxTg3QN/np6dUqZySIm+N0SXAf76cTleTp8vLHQrJyDJ8SVCK8PJMZ3jPJyqJE
         wW2+7DMxFrIREG9sto7HZM22J5XsEjhb+NMn5APKRZ+MgB7Bo0JP442zJmoJcPP/624o
         JzMcGCjAIqyanaUZ3pJTjQ1iy0gwI7+KKXnkqCOyMz8N199z+5kbOR4H/5UZ0GpOTIa0
         kPiCdzeQR72GiFJWTmdbGEI7Rp5dOXwwGfI+xEKo2SpAoR7oqMvm2LqvAJByTFpq21IA
         KD93QJqx9WZ99+mEnX9Fs001LLp+K4+hZqZQEVOZ2OF2Xs98dqyh1evLF2hk7Ypox6AG
         +4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793858705; x=1794463505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CvS81jcXvcMzjusuBb3temDMl3RUTwUEKg0ZWsbrIA=;
        b=ga6ZTs+FkqhxKH43w2c57GEGgzYBXjfvVNojrd51zlR3e1jdZM3rFT7PYlrkegbJbf
         /P1I7lYB1UxsM3gm55Jg/BCqoADALMyCGRSrQwZjO0ztCT03YniTn563UH8t6rTUrnCr
         s9Y0GEPuJDNGFsvbheuryKpsc6i7us/WU1xVcm715LGf+eeyGFo4af5GlcP8K2b5147U
         r1B2d2I0R03RR53054d/q99Ps2uOaCsnLrbtLvExPFNxJKY2Ocb9bHNdhnVJc4aUILcB
         JMw6WSv2m5lGhHb6O4cLXDiuCqViu4nG3vk2ET4CDo5V0u2v7EVFPgAH/uRN5nEzNss/
         LO8g==
X-Forwarded-Encrypted: i=1; AKwUvBwJVvHCErFHLs4GQysNASHzRuwl4BxOoI7YIVBdW1nloDNBZDGDx+VqIfjpRb4nw92LWbgTHFE=@vger.kernel.org
X-Gm-Message-State: APuU4Z93ioxaDo5fFXsVkOyhpN0cmj3yvWaQHE/9ljV+DfQOIGy62bSE
	h6W489F8L/0/3MCXa1qTcGmCpKjtTsBZt88yPGjY563R5jyMuY/9jJ028jV0s7ZBHRoBz+kkD9d
	b2C9P3Dl3MTpdcfd6ZhN+NgceS0B3v/Y=
X-Gm-Gg: AYBFou3+aTDqAX8B/exR4VcA4CoZ1qY6CSRIibvnSeWvq5MkXS1yMIfzgHc96JMrXsL
	A8aMeXhoCgeXe6cfo5+MHab/kyXXgaxbTyPTxm23fG9qj95puBXq9UZQMnWsoGFmUD+0dXWlfFO
	jTKT0UqchH+Ndmg71HIKJiQmoT7Ydo7UPLusgEPQJWKQVxAMTWpj6SQPVlj+OmHs2mPv4d+tFVC
	adFYEotprr5bJ9fPk0sauW/Uweq33NsI4qDoLU7y7monje1qhZqp/unhg+tYPmiKIJmNu+Zf4bP
	mwjRRvYxxqortZxdvafDnfA2bq4efbv6XXmoSKOV13ChOGVWikP6FpSiIgS3kf+V9iQ9H165ubj
	IJn+h1vJuGW72zdJZnvKj/Iwfk1xu3V9g2cRmzg==
X-Received: by 2002:a17:90b:1dc9:b0:3ac:9e76:aa96 with SMTP id
 98e67ed59e1d1-3ae897c3585mr26038759a91.3.1793858704906; Wed, 04 Nov 2026
 22:05:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104073311.1617823-1-lui2012qwq@gmail.com>
 <20261104073311.1617823-2-lui2012qwq@gmail.com> <autMrRaeVWRtBlMP@intel.com>
In-Reply-To: <autMrRaeVWRtBlMP@intel.com>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Thu, 5 Nov 2026 14:04:49 +0800
X-Gm-Features: AclHuK8ozyuxeuE45nFShHA9M9CtlCzBTDmn85bOzlVMDFkVYC2_DYt8S7C3UEg
Message-ID: <CAE=Q7=542V6Sf06r_WvGb4Hw0VrPK0vV=yU1OmoW6yhSiD4jEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] i915/gt: tolerate ERR_PTR pd in gen6_ppgtt teardown
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026, Ville Syrjala wrote:
> The correct fix would be to not assign the error pointer into
> ppgtt->base.pd in the first place. [...] one should always use a
> local variable first, and only assign the final pointer after having
> checked that the pointer is valid.

Agreed, that's cleaner.  v2 does exactly that: gen6_alloc_top_pd()'s
result goes into a local first and ppgtt->base.pd is only assigned
after validation, so the field can never hold an error pointer.  On
the failure path it stays NULL, and gen6_ppgtt_free_pd() now bails out
on a NULL pd (the cleanup path is reached with nothing assigned).

(gen6_alloc_top_pd() itself uses the assign-then-clear pattern for
ppgtt->vma you described; this patch doesn't touch that site.)

Chengyu

On Wed, Nov 4, 2026 at 11:18=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Nov 04, 2026 at 03:33:10PM +0800, Chengyu Liu wrote:
> > gen6_ppgtt_create() stores the result of gen6_alloc_top_pd() into
> > ppgtt->base.pd and, on failure, jumps to err_put with the ERR_PTR still
> > in the field.  i915_vm_put() runs vm->cleanup =3D gen6_ppgtt_cleanup(),
> > which calls gen6_ppgtt_free_pd(), where gen6_for_all_pdes() immediately
> > dereferences pd - with an ERR_PTR that is an invalid dereference and a
> > crash (in the async release worker).  The free_pd() right after is only
> > guarded against NULL, not ERR_PTR.
> >
> > Bail out of gen6_ppgtt_free_pd() for an invalid pd and skip free_pd()
> > likewise, so an allocation failure under memory pressure stays a plain
> > -ENOMEM instead of an oops.
>
> The correct fix would be to not assign the error pointer
> into ppgtt->base.pd in the first place.
>
> Looks like a somwhat common bad pattern in this code that
> received pointers are assigned directly into their final
> location, and if the pointer is an error then the pointer is
> cleared. IMO one should never do that because it's very easy
> to forget the clearing part. Instead one should always use
> local variable first, and only assign the final pointer after
> having checked that the pointer is valid.
>
> >
> > Found by static analysis.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i91=
5/gt/gen6_ppgtt.c
> > index 438cd4724a..72a9ad4642 100644
> > --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> > +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> > @@ -259,6 +259,9 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *p=
pgtt)
> >       struct i915_page_table *pt;
> >       u32 pde;
> >
> > +     if (IS_ERR_OR_NULL(pd))
> > +             return;
> > +
> >       gen6_for_all_pdes(pt, pd, pde)
> >               if (pt)
> >                       free_pt(&ppgtt->base.vm, pt);
> > @@ -271,7 +274,7 @@ static void gen6_ppgtt_cleanup(struct i915_address_=
space *vm)
> >       gen6_ppgtt_free_pd(ppgtt);
> >       free_scratch(vm);
> >
> > -     if (ppgtt->base.pd)
> > +     if (!IS_ERR_OR_NULL(ppgtt->base.pd))
> >               free_pd(&ppgtt->base.vm, ppgtt->base.pd);
> >
> >       mutex_destroy(&ppgtt->flush);
> > --
> > 2.25.1
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
