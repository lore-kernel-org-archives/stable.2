Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C37369985
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704196; cv=pass; b=BTOZAJ9CU5oTOXLXK1u8BLkmn9LIBAyBW9Pv9ByVeucVRJKaKswlKwUZRDlFVfq8xrk6Wiu/QKmxqnOnzpVfuiIM2PwKTSK45Cku8clysxMziHVDCEa9jJH7Q2+6FC6rtHkO3Ngit3nSlgmlPszdwTMPl8PH6R4K7zdcLDaMWYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704196; c=relaxed/simple;
	bh=f3jPvUnTp7pZHLKgu3GQqV/OfFzjQtSwU89KhbiFQjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kv25cra1XVP/rBbxkdl5NJFdvqqsFSLrCzmRWvU5mG0G8D/B1J5VpO7HngY6hUW9OFxMcbkhcIPv7HMbuFbSzFZC7yyvkN4i2UmWi/hXkSRI+jvtrxIONIuP7Udhzrg6IeHuSMAxt2PmP2SsfYMCh3IOs1MOIS+wfkc+cE6g7WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sEPOvzym; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEPOvzym"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso247a12.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783704193; cv=none;
        d=google.com; s=arc-20260327;
        b=O6cQUYBAk8pwErtTUpXNOXKCzSrMr6N3YDu0QqShC9/POaN3hK8SY9awSkA4VYi79t
         +6AOoLKdjGiQm1iFaxQR7xcwc/yk4ayk386lMn8g6OIN35P6ejR+A3tab62GfWZRnXV+
         eM0US//GVoVqKErRkPvkPWzgfT9gMdGS+Shd2wTtzOEwVFXCXvt+ZAdQ6qeoUuIuTbwi
         1rby9wQzT+ejn0DSRbC9X2+0IyZV61/UKOvbqlwrBcsmGfgmzvN4Mvat0wpKhfjymBhk
         TlPDpEBKhK5FVoiiCGUlKPfiAG7NXPV1oMh1PTmyKROV8ZOg1vBvst8Cr4HT39+NfdkG
         +grA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z7AFl+xfaIV4qDK/vCa6ZXugiVbCy0b5jo7a6tQbsI0=;
        fh=aZv8Rw9TliGv+EwGcOVRe5gZ1QYqS3pU4aoWIh9waUc=;
        b=CodZog4sVwfpr8mEVQfr3UA1YWH3cCpdP9kZ0ie9uVdQu31glvybAcoSEjZXRFGdi0
         i5ehhT4/RUEcWZE/56449KvyoWCoVqLgxrhRyhTR3Bj90gGSwhXzqu2EDIRkJGRnZ3rz
         1RGIKKclDsiPqo7hCMD96pwucV2wkL9/VGPitgfW9dg4HmsF76J+89NROQPhycomAZO4
         0ZsnsJHb0GRZU60Nvr3PQmDIM51q87GZ+tDmeq21SLHX3UwH5MHszskR7lHAzPyPfs0J
         r4wP2n/aHUZ0n5UR0Us43Y+1wEDV8TJzxO9Dp68y0Ahe7auuO0rSWdbGSn6YOvwJvuqm
         2sDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783704193; x=1784308993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z7AFl+xfaIV4qDK/vCa6ZXugiVbCy0b5jo7a6tQbsI0=;
        b=sEPOvzym5xCP9zmA95i9I6SHatabSYIcqNU//GTqBRZC3HOX7ye/nvzXA9ukBQafWv
         bOtlQobP3dqEcZgY9SxbO3cg+u3qxNNvV4z1o8A0Uef2FU/k/jSEBTUwtNYpyUf88U/v
         BgmFrOSgsJQGNHqzA0cZ/ONIlNo67rKWQ5pvkyuJDivhx3NHRtALPevSQbOCv7RqZyDD
         ZnHYRr4r1LKkIfD1duYtG4vc56bBamzkZpVFZ7fCEH10rdqUHx6v+tq2gqdzDCW90ABE
         pm5URmVKEkbzfK8oQIibDs0mwpaMaAta4+VkcWMi4i7EbD++IvUVN1tLu5K/tu8hc98J
         l2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704193; x=1784308993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z7AFl+xfaIV4qDK/vCa6ZXugiVbCy0b5jo7a6tQbsI0=;
        b=pEM2UrgmdV5N5d482OPCV1lLGuu0EMLegNEnHV6pLBia5GO5qw2PvEnDukg+5mNyrV
         Ha7/WDwBLOuXHCbjB27zthduaapn84Ao7x3hDZUkubpsPAtCvZKZ1eqM17CFWEEtmR5v
         HpM4h+RG4qdE9UF0xI6GYNe0mirIKdnIgoIlSn1/ZFXM2gzJzme1pmEYbH4zg9k5088f
         G2o6yT8BJ6ng8vQyrPVmWsBCnoHUriVTE4UO9bUWQR36xrAMKj/HuUtiFL/zrKn3Xh/t
         9l/arnNAV13o7K/YSq6SGaj/dj2lC5UK0bYQWPOoTRLrfB6zhSPE13SWykt29tSVB66M
         h1Tw==
X-Forwarded-Encrypted: i=1; AHgh+RpQXTHdl9wjSXTvAg5Bx0DfRJAyCaz4aSxyZskeTkhs0pJVuocnmQ5mnu4fN828tInBOTNFlEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZCL6LGAuyIcnmdCPGZl21moomBqGkWh92mLW7hEk1rbA4a+w
	KusxM3m3chKKQcwWLPlZrbV3LAmjQ6KPBa3EzaDAmqFxJbxXAdkZw3g8tk7UyT8tM4BPnvitIbY
	ITrRAXkv3UaUSAMFdwVWE4aL8mSeBTg0ROqX/F/t/
X-Gm-Gg: AfdE7cnAn0c6KRVhJ5Ox801aCHRPQAHWepHM9XPpjChVc1Wz+7alTCTQyCtHXHmw8IZ
	xMQWQ5Kc1ETo4ga7WFn80m5jfI3Ff7YtJKrblv8b76W7e8R+GEAhfa328smumBrqh0WoTCFpTT7
	avKMQ/8XSS0vJC19t1XK7sF72YdMMiImBXIR6na5KQCscW7ob3o/HW6B7DPCS/Rd5e40TBryQ+Y
	U8RseRYzbx9Rk7rpjHUaq2IrJESJPdIPhsqkaTqorZh7nqM8DoGy6tQ+UNEb2icQEP7D8aruDDQ
	o7rVAmmFcNXIb/iGGM2yUuP1k4UfJZ+oJMN/J/7PfDLGTxP+/hhHmnC/9Sk=
X-Received: by 2002:a05:6402:1a3a:b0:69a:f1cf:4849 with SMTP id
 4fb4d7f45d1cf-69c5f6b1c4bmr1233a12.2.1783704192940; Fri, 10 Jul 2026 10:23:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709211906.3322883-1-hramamurthy@google.com> <0f0e1e47-2f96-44cd-9337-c3d910f1e202@intel.com>
In-Reply-To: <0f0e1e47-2f96-44cd-9337-c3d910f1e202@intel.com>
From: Eddie Phillips <eddiephillips@google.com>
Date: Fri, 10 Jul 2026 10:23:00 -0700
X-Gm-Features: AUfX_mwKgbiS2RO1DKhBggA5wOG5do90vw8bXFAZKZrEMlciIvxhmOXrVksnsC8
Message-ID: <CAPBb8HkwGTC_A1RVVHUVmtbhUxfUXn5VNYxdD-RTsSkN=dHi6g@mail.gmail.com>
Subject: Re: [PATCH net v2] gve: fix Rx queue stall on alloc failure
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, jordanrhee@google.com, netdev@vger.kernel.org, 
	nktgrg@google.com, maolson@google.com, thostet@google.com, csully@google.com, 
	bcf@google.com, maciej.fijalkowski@intel.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 7:24=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
>
> > @@ -400,6 +414,26 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *r=
x)
> >       }
> >
> >       rx->fill_cnt +=3D num_posted;
> > +
> > +     /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> > +      * visible to the hardware, the hardware is in danger of starving
> > +      * and cannot trigger interrupts.
> > +      *
> > +      * We use a threshold of 32 because a single maximum-sized RSC
> > +      * packet can consume up to 19 descriptors in the Rx path. Lower
> > +      * thresholds (e.g., 8 or 16) would be unsafe as they could cause
> > +      * the device to drop/stall on a maximum-sized RSC packet.
> > +      *
> > +      * Start the timer to periodically reschedule NAPI and recover.
> > +      */
> > +     num_bufs_avail_to_hw =3D
> > +             ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> > +              bufq->head) & bufq->mask;
> > +
> > +     if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
>
> nice bit-arith tricks, but perhaps a simpler condiion like:
>         if (num_avail_slots + num_posted < GVE_RX_BUF_THRESH_DQO)
> would be sufficient?
>

Descriptors are only committed to the hardware in batches matching the
doorbell notification stride. Masking is necessary because `num_avail_slots
+ num_posted` falsely includes buffers that are written to the ring but not=
 yet
doorbelled. We don't want the driver to overestimate the hardware's active
buffer count, fail to arm the watchdog timer, and trigger a silent rx deadl=
ock
under memory pressure.

> > +             mod_timer(&rx->starvation_timer,
> > +                       jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_=
MS));
> > +     }
> >   }
