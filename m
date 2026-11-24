Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538924;
	b=m2iHfs2nttcvTKlj8371Scs2k3t2v4A/8fkgI11kZjRA/arlQGoxoWgNZEhLnFtv4ybT
	 AjwQevKZVJzZcRYT5JJtAdgnU5LHDDDk4/aUoLsT+xMbrixx0wInsgaFiZCHMW5VTVnkg
	 V6OARAlKVNEUnhktVdOavgymOs9JkOq1zD1S93QfLJ5pQQh6LKWT69GfEVF0pPZgfrxZJ
	 27QgUMt1YIaBi+CcajGaa65XSXar7k01lbIdhqCdOHzDexfipsWQbYSzK9Zpm7cwQpGhA
	 MMlMMLjjJIGvEQ8SsCq9jjrXQ+T/tDEqAKjtbdGwF5Jnx/K2Qo2vgDYh/vJTqVwt9fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3a1UzAxON6Gb0wbVEW/7fTu+LaDAW+iOda+qUlDV++c=;
	b=vy3I8fvZF1ZSuwhcMnwQ+sMsMfZJ8ptvyAT1Sq6KCB5sozAkoq671oK5T14m68MkTza9
	 bD5kDOmC/5DlCOOr0IUKTZ4Y2FYgdXUypyr3Gq0+nvNzwXdn/uxfrvn8G/EYZuoNmXSDb
	 XRAuyZ924/+8C5EudLSMhV/5OB633Vl7n7Iik+fxYpZGltVjVY6F6mtJOGz9vrjbQCyrW
	 wve236Uq3u68lofJzbY/yr5yokg4Ee88ovtBU8mpqgAc7bshK2cxtWobqy0hhP9yQES/6
	 q9EtvKmNq1e+Lf3KtQ63wilR5hbwRWm4h5WQaBQBCnlQcAmvL+VSvVsHyOkk9Aot1Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j802lkn0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E6606A683
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A40E6606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j802lkn0
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc81984fceso1867521137.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:48:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795538922; cv=none;
        d=google.com; s=arc-20260327;
        b=R8MCr7VpnvE6MmaO9+J8U/8mX7UXKJV5VEuMY+BEab397nyogVdj3fpqZJLEt72Ciq
         mmkFj6BRna7DmLZxQr1NR9sUtS6V4GjAEmrrZroB7M8ZVD3bQfbf3gzHdi3IOXeVzdEv
         BQ2isRhXkwxh/T3kW5eDmebpUl3lCtO2JqrdrZf4Pz9I4vzXh1dyD2/3TQF2OPw+AG+w
         KKNzcIL21HLTB1DJmem/eETQLYoljrHmS7vE3+og0sq1Z78Zpt/IzedHzFj2Nr8lAHV8
         r/L5f8ysFI+RBFm26TsONkoCLxzm8MeLl7FntBOU+CTgKGbnmcFrWu2MEqDUvW57F9L6
         Y30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3a1UzAxON6Gb0wbVEW/7fTu+LaDAW+iOda+qUlDV++c=;
        fh=CTTgYvseGA5imYbFgINvDIKk/wzoN7crRjElq4tOGYg=;
        b=PWHiQNXy/VNpXbL8i0ATMzieyQMaCtJ2EsUmDRPmaKMMisA3uni1k2fmu1i25fX23t
         Kn3b5vr4/u8E3A8uNiLA53FrrCKZI+Mqs1MJZ9jV5MRtpm6t4+uFOlcjhWYOt/1/0ugw
         h3Sa9YbHXgSU7nTtAmmFBWhNijvQwDdU1Yxsp3TnOHXBZCNeraWdHF08hp50tBkASKdP
         3VSQe94XamJAYflA66vRaq7r1Ec3w1udrpUjJjAN2GGApGvK1nD/FfI4mshk9TxOzrK7
         CqtsjWn9zuhG4PxHeL9vonMILpjZSdRdqDKm9YTT1/p4Zi4XuhpvANF2QPRLkXdRtzrg
         3A2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795538922; x=1796143722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3a1UzAxON6Gb0wbVEW/7fTu+LaDAW+iOda+qUlDV++c=;
        b=j802lkn0jn13hyNcrrnqRcyqOAZuLpLL5wL1qn7j3+kERPxe/HCWDG7A8dJKb+dI12
         sDqIV66GVFqV0JLzhTvfzgWEYUSKU2vhh3aOdBsG9Jg5EvdKArdrrnCepqknZlF3O4rC
         s635dBIFbxlye3QzObbDvfB1aWlSqkfcxd5Ko/Uq+pfhB3V4BXXx/IPWroWx2etBmruf
         8cbbgZoejAeKFVxwetlXtD6DBzQLCJacugRDd5shZcJGvk20LhYFJ722vqRMNofy1ZV4
         uRRf2HKSrRwdMwFHrg0Nmn6ycT5NW8/dFAeJShIT6qnj4VgSnaxhsN30MT35t3DrO7Ze
         uD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538922; x=1796143722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3a1UzAxON6Gb0wbVEW/7fTu+LaDAW+iOda+qUlDV++c=;
        b=2WFjIx6viAAqPfSNYxRGMh2nagmahYbD7vSHUHfqFOlEf5KXhoR2eFLMp7kdChhRSO
         rkF4w8SPmgUElH6/TLH1FfejS7CfKACut47xyLUQjINuXtEu9l+xWKW9TPmfdlJAmbbJ
         DUP/cXv1Ai2YVijorigfXjZk/d57f34Y7Aeaf+KgmGz3XmkA9NFzx97xDCSqLonNTl1t
         0g+L5RZI37hOQbXMiw+7xD3XMA6dnIOprs7cPzi2Ga1g8bfOeihH9lvH0ZN9FxJkeXK5
         oFYJxi5nbIZ5OAdmsRERLWDWkWdCDdVEDK6xb+fzSlBIGOIJSKrSgTVRZCuuMKPsfgAi
         fh3A==
X-Forwarded-Encrypted: i=1; AL+hErGH5GaMuptbzhRv+U6PBWeWJ5dsfdgQNh2FMKNPKv1YwebjtdDYbNJhG58uNBfhNlqt9/AidNI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LCT30PliAqYtvPUrNcHSa8QZ9a1/KDHfG7UhvYeRWFYp8PTmv
	36IW+hArsRb6zS30ePDMCqsaw2Prb1PeXk/aL7V+JWGRPh38522F08zeP2N7qJtJnv7+luDO9V+
	33UF6n0Y/8+KHLGSKlL9scMU/5Wg/oRQ=
X-Gm-Gg: AZFdTZekYQn3KOFKge83FBFAJgT1VdPzaHoZF/pkvJW7VPBL7q1fjbuGZbJO/xCuJym
	gqeYTRKD4pBiVQE9wOaD86hLiTWCrNNNEypghbyL18x/6B2O8ryKzbP5PveLC8pWB0hXf8RI2T4
	0vGgiN8L50BqUsT9vXTnGEqdPY+rFrvu+IoQeqlVYpMT69vdr/mvYq4/CxYAPWsXccviPKNdLZL
	ik0av98EjH12piCH6qoLBzBksTlk2fC4bJ26WFwqd4hRqKHDHZA/ohoY5iBYpxZ2juVnQwFhI7h
	1kUpPjiiQehvMt3Y3KCD8Eu/y7TyZMuWEC5R9O7C2RV8f5NwfmvQzSyd0UJ1wDDnOT4Ft6QkWHu
	fiCW2XyML7LWyb91ba+ww7QauUgSJm3Z9bCH2Z5ebA03QRsyMDCf5dlGlZF00nCRA0DXh4UFM6h
	vbBS9QH8N91dV8SJntTJP7nB1EQ4asPWT9EHqAjtiM2FhsqTo7B+oa7sIUmYzvH1+rx6+2Lo8iy
	DViCOwYE1ZyonhlRLsjpiO5rSbaCg==
X-Received: by 2002:a05:6102:a52:b0:7cb:bbcc:e52 with SMTP id
 ada2fe7eead31-7d71e34b0b8mr6779532137.0.1795538922506; Tue, 24 Nov 2026
 08:48:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-submit-nvmem-wp-serialization-v1-v1-1-539d121f8f5e@gmail.com>
 <8c0a616b-e7a5-4043-bc86-3bee5d0c9e48@kernel.org> <p4nohmtiuicrys4i2ipwstdjt7sj3g2yyli4beygutkyn5ghky@d54oxjwiyzm4>
In-Reply-To: <p4nohmtiuicrys4i2ipwstdjt7sj3g2yyli4beygutkyn5ghky@d54oxjwiyzm4>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 24 Nov 2026 09:48:31 -0700
X-Gm-Features: Aa3M54rl89evM17dx3plH-kopVYIX-ZwZ8BLirVjwFm8RebbVDbXT4NQijY58eM
Message-ID: <CADvTj4ou6+gg8xK4p9623xr=mZecmrgPpV76pU_-h=qS23UUrg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: keep write protection disabled while writers are active
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Khouloud Touil <ktouil@baylibre.com>, 
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:04=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Mon, Nov 23, 2026 at 10:56:54PM +0000, Srinivas Kandagatla wrote:
> >
> >
> > On 11/17/26 10:09 PM, James Hilliard wrote:
> > > The core deasserts the WP GPIO before calling the provider and assert=
s
> > > it again on return. Two concurrent writes can both deassert WP before
> > > the first one finishes. That writer then protects the device while th=
e
> > > other is still writing or waiting for the provider lock.
> > >
> > > Count active writers per device under a mutex. Only the first writer
> > > deasserts WP and only the last one restores it, including on provider
> > > errors. Keep the mutex outside the provider callback so providers tha=
t
> > > forward writes to another NVMEM device can still nest.
> > >
> > > Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> > > Cc: stable@vger.kernel.org
> > > Link: https://lore.kernel.org/r/sashiko-outbox-219526@kernel.org/
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > >  drivers/nvmem/core.c      | 35 +++++++++++++++++++++++++++++++++--
> > >  drivers/nvmem/internals.h |  2 ++
> > >  2 files changed, 35 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > > index 7d4cce8e2742..c0da902d909b 100644
> > > --- a/drivers/nvmem/core.c
> > > +++ b/drivers/nvmem/core.c
> > > @@ -70,6 +70,36 @@ static int __nvmem_reg_read(struct nvmem_device *n=
vmem, unsigned int offset,
> > >     return ops->reg_read(nvmem->priv, offset, val, bytes);
> > >  }
> > >
> > > +static int nvmem_wp_write_begin(struct nvmem_device *nvmem)
> > > +{
> > > +   int ret;
> > > +
> > > +   if (!nvmem->wp_gpio)
> > > +           return 0;
> > > +
> > > +   guard(mutex)(&nvmem->wp_lock);
> > > +   if (!nvmem->wp_writers) {
> > > +           ret =3D gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
> > > +           if (ret)
> > > +                   return ret;
> > > +   }
> > > +   nvmem->wp_writers++;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int nvmem_wp_write_end(struct nvmem_device *nvmem)
> > > +{
> > > +   if (!nvmem->wp_gpio)
> > > +           return 0;
> > > +
> > > +   guard(mutex)(&nvmem->wp_lock);
> > > +   if (--nvmem->wp_writers)
> > > +           return 0;
> > > +
> > > +   return gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
> > > +}
> >
> > This refcouning belong to more generic framwork, I see few more drivers
> > doing pretty much the same.
> > @Bart has this been discussed before?
> >
>
> Well, we have a use-counted gpio-shared-proxy, but this addresses real
> hardware components sharing pins. This is a case of "logical sharing"
> where you have a pin requested by the subsystem, which is then used by
> multiple consumers. Normally, we do this at the subsystem level, like in
> regulators - which BTW probably suffer from the same issue - but here
> it's more visible and more likely to be hit.

Both NVMEM writes use the same WP descriptor. They look like one
consumer to gpio-shared-proxy, so it can't tell when the last write
through that descriptor has finished.

> We can either address it here or we can possibly introduce a use-count
> helper for GPIO descriptors at the GPIOLIB level and re-use it in
> regulator core. In that case, we'll still need serialization but I don't
> like the idea of using a mutex and holding it over the entire operation.

The posted patch drops wp_lock before calling ops->reg_write(). The
mutex protects the writer count and the GPIO changes: the first writer
finishes deasserting WP before a second writer can enter, and only the
last writer reasserts it. The provider callbacks can still overlap.

One detail for a shared helper is how to handle a GPIO error on the
last user. regulator_ena_gpio_ctrl() keeps its enable count if disabling
the GPIO fails. In NVMEM the last provider write has already finished,
so we return the error if restoring WP fails, but there is no writer
left to count.

> How about a read-write semaphore, taking it for writing, checking if
> we'll need to set value and keeping it for writing during
> gpiod_set_value_cansleep() or - if not - calling downgrade_write() and
> running the actual nvmem callback allowing for concurrent operations as
> it is now?

If every writer starts with down_write(), a second writer still has to
wait while the first holds the downgraded read lock across its callback,
even though WP is already deasserted. Did you have a way for that
second writer to take the read side directly in mind?

>
> Bart
