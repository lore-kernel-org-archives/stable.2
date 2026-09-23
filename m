Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1C486436
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181367; cv=pass; b=QglSOh9u0jdihYS2Wv/LdER2uSHpDE7g6/ynpFBKqXwqIpCrWHSqroAMGAlSonsd0Hajjk7DGakJcv1aPZkRow7i+lx17qYLd8cl6MeykB9clRliy00ktiwGkLiPpzheqgQ5Ak4XLqgrA7Q2YqC1LKomKA20+0s9zs/PHWIevjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181367; c=relaxed/simple;
	bh=roLRqtmK30tWGOrCTtb0TpnBW/NPax114iO2NAggdfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0Oy+PdxiV9NFozx0bsK8mJx8K0RPbYYE3wDXOzZgBEbjm9Y3h6p5GRIMHIqP8JHM7Suu2FENjVd4PqcXJSwtsEBGPIU027r0hwGyHlK4xVDuonJrq7gq7KzPXm/Bo73A3EyG51V3ATIXnbOUvoAl+FMUBjdp2iullJCiVlk26c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZklBBsP; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZklBBsP"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-532db7db0c6so9478431cf.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790181359; cv=none;
        d=google.com; s=arc-20260327;
        b=lbT3GgZrQhIoAENXZNqXIKptJAeC7arl8xqdFZnhevbGZ+1gtnkF0SfXnAFY5tQ+AQ
         sQYYdg8zQYhxXJI/QVipNWD+uf8c+SiSk4l+5pUawKcmy0XJgnmJJXEjWPeTmKEUPRSw
         liI9TaWKx/kJcF9KTWRy2rr6tkeJHrGW/jGa64hdG4PKBU1N81BmU1rAhRSdONZ1op8N
         NU+ffktgQmxrGBD7G6UlBWv3Ezu+RF2nCOXDa8LSTZc6D174Wq6J3lnmfSAjM6LKPHhi
         D34KWwNNDyehfdJEHpKhBva71wq+4drlYREJ9CL2qHw/e/rCkGnRF/VB71YLogaVo2Sf
         bFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqUG2jcYNXCjwbWYuITmLObIVZqMjnboowMRH3b6/zg=;
        fh=FWugnjso7S2cfhVURapckw0Pgg8ONhOce+mv/Fhrc4Q=;
        b=AMoY+fDAkvzCM+Sq5ZewNMAezdp0y4Sb3wkqI0yy5dYQOp4ImP72izqSxzwfxvPxhU
         cKU5yOyBeEHh9/MiBhDdC/oI2pEUsrjLnMpMVBY9YQ6HXObyn9/HLdwxZ5rTBmjl2wkM
         EUu2NtakOGW473q5/1uyYJwF5k+meydcCx0xlAdb+Sl4EzEWHnS7odFsHv5FYGS/iHCn
         gmQK7bdmxygi7sOrTQxqrIPwvOrMRTJmUrvoMgwQ+FXfYd02tPwmQQ4Y0uRxZ4/3O2Zm
         ldoFAsFEE/kQ44MUZuY8ZL2U4esVj5jOUxZcvJojjqQyD7F+sHiQVme78iAJM3Ab5Ljz
         qfNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790181359; x=1790786159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NqUG2jcYNXCjwbWYuITmLObIVZqMjnboowMRH3b6/zg=;
        b=OZklBBsPkj6hfOsnDKrghsOnExclEGlIRg9cb2bmhJCxZiA0FDnpMYrKQGJiOfmrXu
         jW7W+sjM3dllQwo0vNRIfIE+was+zfoYlxDVqjaT3lcjv774lqo6dXdCYGspb080Wk6P
         M8uC/XrRctdDPr0EmqKJrJL2RFz9YKawC8WReyrg/wznKkvTJlggqfPZB6bRmu1AB5RL
         eg0CsMtG0g2q5u/k12FuGV8EvpHEK7VTNwVYMQlXrPLZPhB/vS/vys6z1sA5UGAp5Zur
         0QWXXGFgpFt/a4X6c3auBxUm9DCKefDaq3zmd9Ns5kiAHahRhZIi9Vt7et1GkOw6WyaS
         iW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181359; x=1790786159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqUG2jcYNXCjwbWYuITmLObIVZqMjnboowMRH3b6/zg=;
        b=khr6UKM7OERT6XxJN77jrnoQmh0ZjmZzyK7IktBlpoB5ioMSxCGER1XlA8nyN8eTcU
         DDBRBoskQhHUB+IYvvMKLrjsDPk1fnGwLcVTr2qN8GGaCVcN134zwZGlJZ58LfSGTzER
         +EP6+7fElhskp75JqxHDjHkBHL7CEOArAmocwC8oY2jmhmV0Wdi6dWCn9v7ePC5N2Ygl
         ZXRmefkejArqRfr+j3OcanRv3HGyVeC13JWVHfp+8FE9hSd3Sj4bo6GtF+DlIe0EAKYt
         WWVFBtOkUfCKmG90NGBv5VznsHQqv9lBTfYvJOPCFGigKcSR8NBPEZIxjVbKb0ipNWix
         l8hw==
X-Forwarded-Encrypted: i=1; AKwUvByafRhDEV17pOhTPv3yb3b3JfHYtvtECs20XkPDugkklYFyQ6NwDGVvXy1k9WFbRa3t6Ad2AKs=@vger.kernel.org
X-Gm-Message-State: AFuF++nVr9z0aWKB2EgVDk2OugVYQvqft9eyI7FzsbxWkY5KwEWpJCOk
	r9HG3A4wBZLsuxBv5u2KL0fMZ40P9sWhwDHtA8gXhcSc/EUpz5uCsvNyyY2dLzAdrMpIjD+6h2R
	yUB8HzOc47bZtQ07HXKf8Cpy0w+RnB+I=
X-Gm-Gg: AYBFou1SkYJJKbvJVzRzfrnDQhpdFmqQjR3h+aAxGCMf13RUpgUY3s1BA2QNKvRZNgv
	NntP6HxFOSBHKKsONSZ4zP+wkqSCZX17stlfJjFnedcwQ/0CNMR0qUe3vqQiXadeyim3Rg5QJrN
	EkyPHF3YzeReHt51j1+5DX+z4ae16aD/Yw6DRaNa53tMNXVGqjMjo3cqV6zsu1TZ5beThHUC1PA
	ZbzSUh5NgbUxZRazLXFqIzPyu1LD3uuidvYxt7i4dkJq4MeUcJrivnW82Aktszmgryvp1OHxkj9
	SlCiiLgCG3U+Mug/GBEYJ00D6bkqkUfbeMFTw2BWr9Ac8lZ3fyNSabTyEnQ1aJE5qPTDg0Y7ln3
	SMQRLmlrW9tZf7PB8qntutW9mc+YCb7ehAnUfL53EU6h2GgAJ
X-Received: by 2002:a05:622a:1185:b0:530:3cde:b8b0 with SMTP id
 d75a77b69052e-532eabb20a6mr48549181cf.13.1790181359041; Wed, 23 Sep 2026
 09:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917235925.44185-1-diegomancera.dev@gmail.com> <bea461d6-4ae9-451d-b6c7-5ac7bc144651@kernel.org>
In-Reply-To: <bea461d6-4ae9-451d-b6c7-5ac7bc144651@kernel.org>
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Date: Wed, 23 Sep 2026 10:35:47 -0600
X-Gm-Features: AcwNN1U34VXKrFuYRGQT-tb2Y_0kpMMPgNyhZZEEZJQIbxLVfy69eVvfPsKtllE
Message-ID: <CALruWrUYnufzE3Lqm4=32_nSJVSVRRR9oeU0fGNhLfr7uyJoaA@mail.gmail.com>
Subject: Re: [PATCH] memory: stm32_omm: fix child clock leak on set_amcr()
 error path
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Without st,omm-mux, of_property_read_u32() fails and leaves mux at its
initial value of 0, so the "if (mux & CR_MUXEN)" block is skipped and
the child clocks are never enabled in stm32_omm_configure(). The new
check is then false and nothing is disabled on the set_amcr() error
path, so there is nothing to leak and no unbalanced
clk_disable_unprepare().

The cleanup uses exactly the same condition that gated
stm32_omm_toggle_child_clock(dev, true), so this also covers the case
where st,omm-mux is present but CR_MUXEN is not set. The earlier
"goto error" paths are all taken before the clocks are enabled, or
from toggle_child_clock() itself, which already unwinds on failure.

If it helps, I can send a v2 that states this in the commit message.

Best regards,
Diego


On Wed, Sep 23, 2026 at 8:54=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 18/09/2026 01:59, Diego Fernando Mancera Gomez wrote:
> > When the mux is enabled, stm32_omm_configure() enables the two OSPI
> > child clocks via stm32_omm_toggle_child_clock(dev, true); they are mean=
t
> > to stay enabled for the device's lifetime and are disabled again in
> > stm32_omm_remove() and on the devm_of_platform_populate() error path.
> >
> > However, if the subsequent stm32_omm_set_amcr() call fails, the functio=
n
> > jumps to the "error:" label which only calls pm_runtime_put_sync_suspen=
d()
> > before returning, leaving the two child clocks enabled. As this happens
> > during probe, the error is propagated and .remove() is never called, so
> > the clock enable references are leaked. devm_clk_bulk_get() only releas=
es
> > the clock handles on unwind, it does not undo clk_prepare_enable().
> >
> > Disable the child clocks on the set_amcr() error path, mirroring the
> > cleanup already done on the devm_of_platform_populate() failure path.
> >
> > Fixes: 8181d061dcff ("memory: Add STM32 Octo Memory Manager driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com=
>
> > ---
> >  drivers/memory/stm32_omm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/memory/stm32_omm.c b/drivers/memory/stm32_omm.c
> > index 84eb23c824f5..3599683ab04a 100644
> > --- a/drivers/memory/stm32_omm.c
> > +++ b/drivers/memory/stm32_omm.c
> > @@ -274,6 +274,8 @@ static int stm32_omm_configure(struct device *dev)
> >       writel_relaxed(omm->cr, omm->io_base + OMM_CR);
> >
> >       ret =3D stm32_omm_set_amcr(dev, true);
> > +     if (ret && (mux & CR_MUXEN))
> > +             stm32_omm_toggle_child_clock(dev, false);
>
> How does it work without st,omm-mux?
>
> >
> >  error:
> >       pm_runtime_put_sync_suspend(dev);
>
>
> Best regards,
> Krzysztof
