Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B1394794
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663775; cv=pass; b=gQ+sUa4CqKCrHOchR6mDbbTOrXkCaZKGFFNYJ17GDOnLzMh6D+71Iz3XrQ0qpqZJHT8YqUSoPMJyvSRmmB3NNYkhdAE5B0qj5YBYpudXUILeEVQu7Po7ubkuZfE0Jv6BvmFDdxPK6ufaXml60e+8ItlxnlI6H7lwsIJv/HtlwSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663775; c=relaxed/simple;
	bh=dJOBLOQUqN6A2keWqFB+qT5VTZMw6IdkXrYBZAaa2+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjQuX9Wo654uNhplpTy6VxpJgmNLToi2pXVY2u1c8/mxrgfbF+Y09TP5q9tEW3TSiF+mekrcYcGwUzsAy4g2R0ZTu/0x/L89GhexYFZW95StVzFyzKFzZogczlkgb5hrr3H1yzd7vo0qk9ax+X32gJQfLrWGo5vr6J8lMyH4QC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IejQJV7R; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IejQJV7R"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-73a334d1128so63319137.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 02:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785663772; cv=none;
        d=google.com; s=arc-20260327;
        b=nuDZDmkCnHcihrqhTJ+RDuhfYWg3laRgBR08XvTDHgH6LUvXNfknRFNYIkAVWM9aJg
         Cq9Xa1AQlLAVZMevp/2Ss5Wf3UwgrVXZFM5Og7Q3ClDtLyTdUNMdT9egKuR8VZVyfBxB
         egIgK6nxkGMRohDZatcB2Xl3jK8ZB5UsHZCW8Fkl/wsla118bTe8EOs6MOuK/GCN57cI
         Jo1QIbnvAN08gTEq9bKGnMcAl9vi95OSv9DJCUvjxHCGiAWRLffF4v3vAVgY6Bjn5g6y
         wmn4LhiEaj7ARCHajQhSs77TV9xj5pDYPAM5CD95xw5kf2O1v2iiFitYhJ0704Qu1FvY
         /ZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pri826G5hCYV5/lZ6dHjcACUrXFqOhWQRiRJJshfs9c=;
        fh=+hT8csrFIVstRcJWIIhGqDZ64mGriiyU9hBI9WDVVJo=;
        b=Tmneh5s4OL5HD7++CG4RSjnLH5Hv2hnuFknlsJyGkGIzXTGUlxvSReh1L26J4bLe18
         s/8ZjZabDtvT1v6MjB4ZaWmVwB02qEfZLlwZIg9hfO5hNvRXrquA7n9lzPvxAx8BWhwI
         3mb4hOYrtMBDrGrP37Vbqzw2Ke47GoQW0TNabPr64WB1BhMc06oGP0E5gPzpgGuxf4RF
         +Mpsj4mu99BPmA+KPbDVFU2hmMf/VemFnHZqQni5IAuYVyUWty61JPkJgKOi6w3+6LbS
         KzMOUgqDzuiT1KfnOVDIeDl7BWDTXNSLPdfJlNc8K8e7sEaiEH7P/BkmCMRmc3EMDb5R
         GF1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785663772; x=1786268572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pri826G5hCYV5/lZ6dHjcACUrXFqOhWQRiRJJshfs9c=;
        b=IejQJV7Rj0U83T9r4pxml+OeFbWRiUJJMSxtZgIzGbfu4dqK1j4nHrgStYziTiEKMq
         BCcTmEzxdXFQhuN8mp0bpOQyWAOahx+esD+ekEmMkdf3FfAR+ABG8QBFVyUfG8+IFHAe
         rTDVhgbyQZrzMoQ1Odrn7KQGcQnKT9ksZunlHxcOs/R3h7KtgBPrqbfmrRC+Q8yiINQ6
         CZDkJM8+XVFr+tl4zUZ8fBJ8L8BgaNvNlelCrXoJSZdXfwhe0kgbh0KlbG1eVmx1PHRv
         KrodULNRQpn6O8/h1sZctKpi7+b7/dCUUjuXQ0/ZPxYZRH+dnGqgrgujW2P3r4Z5yW7w
         l/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785663772; x=1786268572;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pri826G5hCYV5/lZ6dHjcACUrXFqOhWQRiRJJshfs9c=;
        b=sgTsPoiaYoLPFEo4VZAgOXsuRgJycVECeMh5qSjyQdfBBV2HjeBTDDx71pogZO4Ptn
         yBA03VwHubWwlRRRp9kSTJIO3btXqjakyu/pXqAm8KTmy73c/VU6hpfb4ulokf3xy9qC
         JNIghByErgNI857xQHgAYj8hvIjiio4KrEN60ItO6ph4gOlcjmcsViUqMj7rG5wy5kqj
         w0FIzURyeylQNO1ocCsdVnVSs4VctngLs/TMfN+drw7DSRNlsy9YeIZerAHarUqmS9pk
         iV+QZUIlytaXY/qa4BCZ5RcrOVYtVtGU65aCXkxGfcjrMx+3Qd6i/qHT3i7xktiHieDe
         RzUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqt83Z/mXBRoMaKy2ShbQTb/C78H33xvrarysInx4gI8E0F7kazJi4D4dTL0MKcwgds/nJDviM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKLmwVLJCeeSD4s+e/nGiCkq3+ohXevVmnT6Ex9qbHChvfZHM
	f0MAJKoBFTMjU81UpZd9H+e/VFCLB60jHj4Qgw7+xKfJoOcaeZ1Qej2R/4CU9l0zleQwwIky1Va
	O0ytMTzRH03Bb4bECJq4YRtsgNT3jQ3o=
X-Gm-Gg: AR+sD10svw6MObSSrx9FJoX44nT98aUAQEA6d2HpA2yxly7pr8WelB2kzTXDQMrLaVW
	KbfGoCIB92U4Om+dwyytSzSAqtW3TDOkA/Trl2tRsxbGtskY6+KyL3zG8zzkjQhlT+mKX4JfGFC
	z4VXUnkX2BeJQupuLZGUYTSjoXU/LoCjk3T6cl8rTM/zfRF2kAdZsEfb4c3PXGtNJX3EugS+kXg
	vSwl1WuhM42iruyDGXI80AiNaLbpwvYuzVvlt76NbXlu+nImjk63otrE8yjzzW1UT/0Jfo73jQy
	3lvMbIiV3bXXB3eJYQYUO7/+/sN7qlFn4xtrlVr6r8DAn4A=
X-Received: by 2002:a05:6102:f8c:b0:74c:551:54d2 with SMTP id
 ada2fe7eead31-75b2507b572mr1757974137.4.1785663772295; Sun, 02 Aug 2026
 02:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710194638.1502-1-saileshnandanavanam@gmail.com>
 <bc13f78b-287c-4832-b2f1-a68e7b35b57d@oss.qualcomm.com> <CAF+TLO0F9jQ0+pPei7iFDqcC-gKd44gc5SXa-o_dBKzNsHKU=g@mail.gmail.com>
In-Reply-To: <CAF+TLO0F9jQ0+pPei7iFDqcC-gKd44gc5SXa-o_dBKzNsHKU=g@mail.gmail.com>
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Date: Sun, 2 Aug 2026 15:12:57 +0530
X-Gm-Features: AUfX_myUV3Xx5wjT5xpW_9kPbTIvUToAVZXKQdsgk1k18pyiY3j3cgrBd5FxHu8
Message-ID: <CAF+TLO0S-Sp9PWKhvGeRfnxMaV7ZH=Ncr-p4NAu1pvE8odLTjA@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Fix off-by-one error in
 regulator error cleanup
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	quic_akdwived@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Konrad,

Just following up on this - wanted to check if you had a chance to
look at my question above. Happy to send a v2 as soon as I know
whether the concern is about correctness or the label structure.

Thanks,
Sailesh Nandanavanam

On Sat, Jul 18, 2026 at 1:27=E2=80=AFAM Sailesh Nandanavanam
<saileshnandanavanam@gmail.com> wrote:
>
> On 7/17/26 3:01 PM, Konrad Dybcio wrote:
> > The first two labels only unwind a single regulator
>
> Thanks for taking a look. Could you clarify whether this is a
> correctness concern (e.g. the fallthrough from err_enable/err_set_load
> into err_set_voltage not doing what you'd expect), or more a
> structural/style preference (e.g. avoiding three chained labels in
> favor of a different approach)? Happy to send a v2 once I understand
> what you'd like changed.
>
> Thanks,
> Sailesh
>
>
> On Fri, Jul 17, 2026 at 3:01=E2=80=AFPM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
> >
> > On 7/10/26 9:46 PM, Sailesh Nandanavanam wrote:
> > > In q6v5_regulator_enable(), when any operation fails for regulator at
> > > index 'i', the error cleanup path unconditionally calls
> > > regulator_disable() starting from index 'i'. However, regulator 'i'
> > > was never successfully enabled at this point, resulting in an
> > > unbalanced disable.
> > >
> > > There are three distinct failure points:
> > > - regulator_set_voltage() failure: voltage was never set, load was
> > > never set, regulator was never enabled.
> > > - regulator_set_load() failure: voltage was set, but regulator was
> > > never enabled.
> > > - regulator_enable() failure: voltage and load were set, but
> > > regulator was never enabled.
> > >
> > > Fix this by introducing three separate error labels to handle each
> > > failure point correctly. For the failing regulator at index 'i',
> > > only reset the resources that were actually configured, without
> > > calling regulator_disable(). Then roll back all previously enabled
> > > regulators using 'i--' in the for loop initializer to skip the
> > > never-enabled regulator.
> > >
> > > Fixes: 19f902b53b47 ("remoteproc: qcom: Initialize and enable proxy a=
nd active regulators.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
> > > ---
> >
> > [...]
> >
> > > -err:
> > > -     for (; i >=3D 0; i--) {
> > > +err_enable:
> > > +     if (regs[i].uA > 0)
> > > +             regulator_set_load(regs[i].reg, 0);
> > > +err_set_load:
> > > +     if (regs[i].uV > 0)
> > > +             regulator_set_voltage(regs[i].reg, 0, INT_MAX);
> >
> > The first two labels only unwind a single regulator
> >
> > Konrad
