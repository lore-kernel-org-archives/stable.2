Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7150361650
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318237; cv=pass; b=kI5LdU78ttiXHdNpZYgeqbMg7fIDx9flTy1OtWXfVPbxFSMZ0OB4rLKvowKTayolzwonad62XAsmrxsEwBnBJGMsSq0hxcEgVNAyRzn3qZ4BS2YBmlvfHT0IW6I/DLlSfCYaIDkad9yd9ulc1U9WdTWX7BldUopuinIFTEHDwbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318237; c=relaxed/simple;
	bh=uuOeXfineAaSKEkzm9ZAfY9YAcij/EcCbR2zNaGpEpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEO3jH7bqanwJ+YpVvmdZmoMrfCgl8XWbDwbDhGjIDJLg6v8NNAvsJswDBf+Xlzv9OTN69WIQHcDj6bR+1h1IkJyFsigDohj5WPwunnK/mVAFiF/xk5Pcg8/xVxNqpVWepUBmrs24PSex1kY7dDX0lWUawc2lQkySSZ6tko95vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNyTUgU7; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNyTUgU7"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80c4d1520c9so7412177b3.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784318234; cv=none;
        d=google.com; s=arc-20260327;
        b=XtMch883AmT1qUQCINhKz0Tut7eLGFfl9heRBYtekJ0GvrIdx3fvkUnGfULKVkZ0EH
         h3qG+OnN2D4qKC3Go459EW6PQ4LaXMQ2LY3D9meoQaSMv/xVe8nPv1upJ85c8o/SdzZN
         oNO4oOZWUVaOewUKpCqi5SpeSVf2t6WubgUr0QpctG4Nl9MTN3GMKY3hGwp/M2/k2xmF
         XAgphbT2P45sqzyRlI5G00MvN2ANH1b7b1QFRCAWCc/iwmyEVqVekE2YJt6xMFCTpqjI
         xBgh3mA0rAq2+G9P+VLeA2qwLf5jtGQ0CVPUOFkBAK6ufB0HjAY/fgi9kmYFOB118W6A
         Q4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4r4qpI7ZYUqwhCzIi/TmFSyDrOhyXUmyBS8Pxgob6U=;
        fh=IeT9I7FLBVi5GY2unxeiG2YvpX3pAdJTU6Ksa1Sk2v4=;
        b=NlVGorWtjkxKcP0Kd7YmZy7bpM6OQPguFfj0PsLCrEOLudJbMHj2VZBTxVYjpkkbU9
         BXUUd8M6deklm1ItJDJVOjQkgZRPEKb2gMZvMsHk6wlW+st/4wOq0gZPq6uIlstrcToS
         HMVVIVsZ/SKtJx6SI9U03t8KMofaiab0YGtcnQeAE0y2F/H90U0Xd4HNK63QqqcNsZiV
         It/NJr/u0TnE1LIH0k3uvAE/LsKRNq7Ta6Tg1jKKZXzoqrKuU3fosTqxvKFzhvZPvPN9
         6oweU6qXiwIev1BwKR5NtQlazCJeWiz4L89p8hffdaExYnewqZb6TKDrIYNrcCtoG/43
         O0zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784318234; x=1784923034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4r4qpI7ZYUqwhCzIi/TmFSyDrOhyXUmyBS8Pxgob6U=;
        b=eNyTUgU7+U1nHHE1U6fzUA7qpVfYDsJJijHQjAeZO0w1wW7uOJ41TEqaFbAzE+BS+d
         d09C3s/Z1dhWrBSqEyF03kqvbjLIM/edSCUE8o7HIPrVfHsJvTKWnC0huxT1dLsXvjGn
         LJDMiEJleiYcAZp2TTXA+q+tgxucslh4QgJdjVLJtCuTeWKyzrDDMc2HjSFsOLGMks90
         9IM6kIdiSI+vno4ut+CVj8hnqDRSLWEBll2k3SovxxUB0KsyTsP9x534BwlcxY8YCpUt
         +yXwacWfP/aKsYHUvFPncVjv3mlzzSLzO0FuCyiEdBnHVOqmtB/pZk4GKbzV2qPP2cmI
         xo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784318234; x=1784923034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4r4qpI7ZYUqwhCzIi/TmFSyDrOhyXUmyBS8Pxgob6U=;
        b=qa+K7BwQExDVP0PDwYwr0BvFiIGDn982G+rhTqYfnb/5t6GlKA0CpAc8bYqh4E3RK1
         wTSZnBZu4urCqnOtxaiV6YOm3dKM8jDaQCkAlJ/1lxVF3KyZc5sZLsrmnxMH16FhGJdB
         VJtVrqzrbInoXsJuVBiTnXLWGvl0nlc/x9/Q7ak//JtmREmLHz53mVG/sYENTAQvcpsd
         FQ85KnHEC9TdPVEEcfHm3tJO54FWiX77jyoiOc0PTR+cSVi3UNXgeegr0dvgCO8qT24S
         e4vZDIBIFSlVmzzYgzSwgNhI2kHyOT3Y1e9AHYIqlebZiVNMurI7lfXjY20CO/mANXwp
         5row==
X-Forwarded-Encrypted: i=1; AHgh+Rpl2MfHTxASTQ7ZlqXDAeiRIa0U5VWBrhM0mIug3054YeSC0v1WHeNgTWE+VA6y36L7N66XYFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3GbqC0nJ6b3IqiCASPvB58QSN9+lsTvHEr0Mnt0gdNh0r+riI
	pdlmnYQYk8zSTL0A1MAsT3VOV4Pd+rnU4zpOSQHQ+gNBLxWnna5Hh9y/e8aZE/o+ALdKtyHntQj
	WlY45AfmNZt8yHfcjHuax1q3hOA2Jzfc=
X-Gm-Gg: AfdE7cnxHQJr4AhVhOD6iYDnnKTTr3JT+REKSTQ5Y2aYdxHCHwqaBfy2JAMEvqHVkxE
	whCUS0wT97EDjaIGnmxxC8Zw2Slqeh3qfFNPj39iyliGDHvFT/0gFLF++C0oP7udf2TQC5p7Zhq
	wt3x5XY/z8pYsZyWYmJsniBsHXNXLZaBze3wdW9iBDKItFyEvo/UvE9Rf3KTOXHKB7C6u58IxTl
	Aamj2iXpt4lJ/GeIqVFQmRYJuynnb7wQeDsIjSt6nDG3pfBQYzdqFXWtgW4lycb7Ylzn6XcYMQ=
X-Received: by 2002:a05:690c:60c3:b0:80d:8bad:2ceb with SMTP id
 00721157ae682-81ef217a008mr13797247b3.0.1784318233761; Fri, 17 Jul 2026
 12:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710194638.1502-1-saileshnandanavanam@gmail.com> <bc13f78b-287c-4832-b2f1-a68e7b35b57d@oss.qualcomm.com>
In-Reply-To: <bc13f78b-287c-4832-b2f1-a68e7b35b57d@oss.qualcomm.com>
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Date: Sat, 18 Jul 2026 01:27:09 +0530
X-Gm-Features: AUfX_mybpP0ipFenvhQ7910IFz9oFbDJFCxR2LMB6JHjtp_vKzBdXraXDoqWrzE
Message-ID: <CAF+TLO0F9jQ0+pPei7iFDqcC-gKd44gc5SXa-o_dBKzNsHKU=g@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Fix off-by-one error in
 regulator error cleanup
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	quic_akdwived@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 7/17/26 3:01 PM, Konrad Dybcio wrote:
> The first two labels only unwind a single regulator

Thanks for taking a look. Could you clarify whether this is a
correctness concern (e.g. the fallthrough from err_enable/err_set_load
into err_set_voltage not doing what you'd expect), or more a
structural/style preference (e.g. avoiding three chained labels in
favor of a different approach)? Happy to send a v2 once I understand
what you'd like changed.

Thanks,
Sailesh


On Fri, Jul 17, 2026 at 3:01=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7/10/26 9:46 PM, Sailesh Nandanavanam wrote:
> > In q6v5_regulator_enable(), when any operation fails for regulator at
> > index 'i', the error cleanup path unconditionally calls
> > regulator_disable() starting from index 'i'. However, regulator 'i'
> > was never successfully enabled at this point, resulting in an
> > unbalanced disable.
> >
> > There are three distinct failure points:
> > - regulator_set_voltage() failure: voltage was never set, load was
> > never set, regulator was never enabled.
> > - regulator_set_load() failure: voltage was set, but regulator was
> > never enabled.
> > - regulator_enable() failure: voltage and load were set, but
> > regulator was never enabled.
> >
> > Fix this by introducing three separate error labels to handle each
> > failure point correctly. For the failing regulator at index 'i',
> > only reset the resources that were actually configured, without
> > calling regulator_disable(). Then roll back all previously enabled
> > regulators using 'i--' in the for loop initializer to skip the
> > never-enabled regulator.
> >
> > Fixes: 19f902b53b47 ("remoteproc: qcom: Initialize and enable proxy and=
 active regulators.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
> > ---
>
> [...]
>
> > -err:
> > -     for (; i >=3D 0; i--) {
> > +err_enable:
> > +     if (regs[i].uA > 0)
> > +             regulator_set_load(regs[i].reg, 0);
> > +err_set_load:
> > +     if (regs[i].uV > 0)
> > +             regulator_set_voltage(regs[i].reg, 0, INT_MAX);
>
> The first two labels only unwind a single regulator
>
> Konrad
