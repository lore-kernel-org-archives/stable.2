Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499A3264DA
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778831; cv=pass; b=SvYRAIV6OLECESRN7Q/FlSsbqGPElMHYUx4A5g69u8E0xnpbWOiu8mTO+TBUL7URZzaxoFaiz+mo5cGz0XoUVIIR8Ec53jfc/9tdOUr73+KNcVaeYPLvRTO6GV+T6feOdXJr5cSpUPnHBy1SNJt8mHyQxJAbOnK4vGw0LqhSchY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778831; c=relaxed/simple;
	bh=ULS1O9H2vl1xXhjc8PA6+XCr3+Fn6BHRdst9HWjSmQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGpZXXCEYU+NedT0cXDenb/jPdGM+Z0N77RHPKaFOnTJqY3+KiA12EZuxTSo13d1Z0+/Dh47iTQHoVj2XuwyNBBy4ligJSMTFc7t1eoshCCONv539v1+w1f5/OYZo1YnHvWE38ZyQyY3GKDvYml7CyB0yxoF3KTuqUs4YHaGGtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kpn0g1O9; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kpn0g1O9"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b76694fb7aso1168189e87.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789778824; cv=none;
        d=google.com; s=arc-20260327;
        b=k38uBe8aTn7Ke32M5mIUZeErgClANR0PYFIlHcDKQJkOEwbeKgR7M238IsLwqaXVBb
         9jZ3yQVnSdk3wWNfmaNkFsLoBZRejpEONsfwU0g50aqOqPJPcczoXbUu9er3U0UCMY5f
         qCa4koIkX5nB+xR06H5m5xr4N4EkOx95NjIWm1Iyd4KB/WFoUP4ZFQiCK6RVwNhHa0Zk
         t8LjFMbQpsQmk6PcCzKIZ/628Hol4FLISDc9wsS90kFyM7IEnTyicL82mAmrElTaupw7
         LGDBxcg8GjGQ5Y8TA8ugfCXuL/frwkNswBlX364Okr27F+m3VCtIH8ATNjW86lU9UZJt
         oRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULS1O9H2vl1xXhjc8PA6+XCr3+Fn6BHRdst9HWjSmQs=;
        fh=1UpTrhs22TVHYLSObIsWrDiwbRjDiqgg7lQB6N/zfGw=;
        b=GLOYTzTAbctZk72WStBEtG4ULTTmZLvSH7tiB+EYPjoerB5auiGFKhTenA2b4FVLRf
         7aRRDkq5YjHKO3aLHoRajh/UpUOXCPMV4nROshB0Q1IkxH8rER1iaNgD2583q4MHNMr1
         /OAEnbsmEjuTTkAxs/W8nK9p6YX8Oja56uUorhsBRrLDJfCQ4MtRJdmbnL09aBH/4zYu
         ZdCULlTfptkXkPUeKFQAGisi/0rMKRohYpbDzS+oVdkZQHCIuSGHvpK/JtCX3sj846jU
         YNIp/2wbmT3JvbGX4WvZs9jGqzbdOM95+HyQOVPIAdjixFNQ1ypgVVQVnTUckr8ysnm2
         GSBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789778824; x=1790383624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ULS1O9H2vl1xXhjc8PA6+XCr3+Fn6BHRdst9HWjSmQs=;
        b=Kpn0g1O9/UWfCTZBkJUmCb365BAxASdEW72zhbBFwtvvJ/oydoACBLO0Dt6FNC0S0c
         4O1FhJIO66yaoCNjPx1lwDg2bmK6nMX1BAs8HjlTSsuGdUu9cxke5NogT72PLBUVENK4
         ts4bMqbRZLbYWA1WS0bv/oFvzAPtBAmWhAe9mEE2f7Qd8DvnkLfNEfeCsV6Z9TuZ48B0
         8ZRBMcU2B8YHtb59Qq8qzG9AewLT2kdCw+3Ck9XOlpIPRU6M2xihUnHQher5pnSosdzZ
         bZ9ahl1YjKSgRRO0bvRbZ+JPW3zXWZjAJPcHh9z5Jr0UpiIV1agd4K0f+QCdLMo/+FzE
         zXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789778824; x=1790383624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULS1O9H2vl1xXhjc8PA6+XCr3+Fn6BHRdst9HWjSmQs=;
        b=ultLH8B067zLaroEldl/y2WohrdSPWUpxoxuBFNVC9bHa5+mlbkMHAUVmY4h4Q7PBJ
         EzA0neJUqoVNLIIknJUAZyZk6nYqE2j8IbvGJSM4DNruxrz/1h2S9wPeqC0fE3b5e2Oe
         oRtFdKspnNy3qPENRKtt1JREYhleiHezhF5qbsQ1Md/Vj7F6i8PErwI22THeS2L5MM8q
         WxMiDY/IlXFqnthjfjy6DM4NfBX7vWuj4IriF8DMbKLSpx5pGWh0LfJLd2TNjTQK/42X
         q48KjNcX+6CPoXX6ZyLIyM+BwSsJxulMxyhcOr0CVPHI9FmkQFkBXagdXWbJxht6ssUZ
         2Hqg==
X-Forwarded-Encrypted: i=1; AKwUvByswgFO7VWUm3tFp0vkrolNDHi4n4O0hcNdn6KnWLVi8kmVbg3s2apr+ugMAo3zzQ9xvHDq/PQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lW/2QAyIVuZ8Aljai5FZYhGcmIb4qmBpvRl2KqXqYvS9iUYiQT
	rq0DRfES/sCo6s5IzBMTKKri2e0DX8n0NQLBRYKABneunzARYNTLhrgmnLIIhfokI06vfyhRRql
	pKFq910B/qlGqGBRBLazpg41M0i5Jefnj10CO9n8=
X-Gm-Gg: AYBFou1HbND+pL5H0G0h7r/MVw2tYOigxKEhugsx15wX7vY2uus+IxZ9jXFMbQ5a1CP
	/HbFZsf8wf1TuRJh1L4ueEg34vJ2l4PqTo0c57OSX36sHVHWU3YfiybTk0q+/cHC2bNgHhYShhE
	6zrLsIk1RA7ia7+80z1VytVQFp882IVHndA18zv+LccdFu2BUNqjM/zQzg9MBBw/RvCNyyn8/4w
	GH1WbDuZR2LjZAO2HXxfF3aHLLLsw7T8+mjAH3iuaVWGmpA3uzIwmRcIfDvcdOgdY1UtRZcuzPp
	P4mPWY4NaoOfQUnqIFM1TgKDd9wBi0skUgxuqowSUmW6VxjcfeC8qk3H
X-Received: by 2002:a05:6512:219:b0:5b5:e2c0:510b with SMTP id
 2adb3069b0e04-5b8ba5d1c46mr1750846e87.4.1789778823638; Fri, 18 Sep 2026
 17:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915111351.2726334-1-qwe.aldo@gmail.com> <CAKFNMo=0hDANOd+DxxvKA=RNbiG-zygkWh6EUC6Vr2MYe4npLQ@mail.gmail.com>
 <e197037b70377be78b296380bcb31b8c3e8f8d74.camel@dubeyko.com>
In-Reply-To: <e197037b70377be78b296380bcb31b8c3e8f8d74.camel@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sat, 19 Sep 2026 09:46:47 +0900
X-Gm-Features: AcwNN1XvQ7oA7wJs8qNTVXqjcIufwo1diKErI4eQMLUq2UxbIuNp6roz-nIE5Rg
Message-ID: <CAKFNMo=0-rxN0BKG1v+KhrGwnh2ZL_Hn2Jbcqc9sWRV8cwxPrQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: validate file block counts during recovery
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 4:33=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> On Sat, 2026-09-19 at 00:44 +0900, Ryusuke Konishi wrote:
> > Also, please replace the 'Cc: stable' tag with the following tag, as
> > with the previous patch:
> >
> > Cc: stable+noautosel@kernel.org # Non-fatal bug fix; defer backport
> > until a real issue is reported
>
> Damn! I missed this request. I already pushed the commit. Are you OK
> with that? :)

Viacheslav,

Since we haven't hit the merge window yet, and linux-next (the
destination where your for-next branch is integrated) is a daily
integration tree intended to be rebased before being pulled into
Linus's tree, updating the commit message on your branch now should be
completely fine.

As documented in Documentation/maintainer/rebasing-and-merging.rst:
"Some trees (linux-next being a significant example) are frequently
rebased by their nature..."

I think it would be better to fix the tag and overwrite-push it now
rather than leaving it as is, though of course it will need to be
frozen once we hit the merge window (or after the official release).

Thanks,
Ryusuke Konishi
