Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C83330668
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744833; cv=pass; b=scQVwNMTANPfsJFHZMV3ZwkIRbjum+758hvSZkWGg0U5SWlKv2YwKeWxJUmMFscwUobG2L3sBIajFLEIWdiI4NUjYIy+QALoSXkn2ZRR4eRmnpwdOzwsxJ9Ii4YpkdVFH9YIpzDUaM32KsZjDvB8wDtzh3scJIr4jP+OCDQQGiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744833; c=relaxed/simple;
	bh=6mne82aAJHtUr30KWi7im0zCitkiQ9PmVr7Igj1yZn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSb4JoaPhI6Qrsq+EixIB69pJaP8hVo7SEbqVZTyUb6EPISo74zqG5Iaw89IXFjZwIIUbWLMbh7PHSIrKZsF+9BTc1d6KBpUAHSWgAqpS7GpqaMbju6zHQVS122JsvFnbL0XPAEFvNf2dvI3hXfVaxXei46VTL5coGboqYnjUFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF3cKRS9; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF3cKRS9"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f186025973so14017466d6.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786744831; cv=none;
        d=google.com; s=arc-20260327;
        b=g1AIe2ZFEU53ypyQN1c8H2udjzm8CcBCTA968vFdEDM2E9/UpSiqtyVjwof1yWbR/i
         uciO1ELIRkbxFNcUJmHT+ep6bDCZUcefr8FwCy7C/2a2bzlXbdMgl5fBYboIXOWkLbs0
         UVaiH3oAX6iGmKzvjE70MizeSrG6IzPOLe3cZ6P2gtxzYvx0YU1epZ78T98/kcwQnvvA
         4jqYHPUJ7opS937uiSS/+MhDO6qtDTbX+QzdcRq+NKwSL0TaRGU5Cd+6M6/uRYzxIbq8
         FVdry2F04zW+OAcHCPDnlf+9wYQilDqhwaX5q8F6xmpCe/OJzzZJxXJ3uUBox7R3mllT
         g8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oODB2AjBhLLjzDgKnazTq3JE4KieXBOg7eMpYzfqPKc=;
        fh=d2xuWbG+OIDqGABa/K9lafVkRlVR5s6pip0/gbKp34U=;
        b=mcO1dwUJ8vOS7E1mBm84alCBqthjB4/3cArIb8b/NJFqO2iWF3udhZK0cR8G/0lyYB
         /RMJjlRElucWdpq2HEBTs9L2wJ9acpuYoRVqVtlSeTEzMM+rzot3U2dH481q8FdPvDXG
         D87ouU3KXGsfC848ixgg8B2naneOKdWGeykCKtgUPZp9VUaHncG+azSTQU/6HxKeT6BO
         bxFvj1H4IttLJJeIEar4H0zzYG9DZQcBzIbWkEt39nFpiYyHbivIFGrKYBga2qHtrYuJ
         QuEPDxZyyupwEvJ+qY2zjfXndf4A6qjcNrgdxCN/jYfdoxCU2JkzvkEuNRalMwmkJH4u
         SYTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786744831; x=1787349631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oODB2AjBhLLjzDgKnazTq3JE4KieXBOg7eMpYzfqPKc=;
        b=WF3cKRS9CScoS4WnQ1cRBD+HZY9urIpF/Msg9sc70Nj0zfYln7Jy8doXjp8e9IPOS4
         KfezoHDq9kQ7JT7k8ruX/7nElJ0+jl8e8nrEssfwKRx7alHVbHn6EAFKG+F/pyLr7Itq
         4ljUD0ce3vpnQ8epxZrjlidYn4aW8TSUEWgLA4SKgdqbyj/LagP4hyw4Y/9RRDfEKLUO
         CVZRxcyHkth9KwdXMLW73JBrHCs+1Vn1HjY9V3PiOnFChxiyY5L7RE/4PwLJ3fSbWChA
         c/kesoi3WzSY7llFMsakqox0CxhS1pibms8BbHkNWgN41ILLJ55Gf4X4H12ih3KnEERO
         zEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786744831; x=1787349631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oODB2AjBhLLjzDgKnazTq3JE4KieXBOg7eMpYzfqPKc=;
        b=O8hOejtxk7F2i1zwNdUPWpPLaKR3XWjZPtpa3eIE9tSbi3EKPmsJNW/Gi/jYXEBsi9
         uusC7yJBlyza3jaUhKeniFqyPO5INDuMpb30QcA1aZ1jDhAIlfkQRmvlBCBFKE6+h6X0
         SbxqkniVGghSUIpiZ7Tm11SF6SdVHOORDDs648iJOtaND8d8qjc6LRHfZwnQCX921p3+
         m0fkXcD3oOkNq7/6XV6oNeF3bz6x/K9zC4LzgMS6aihWqt2il+pkYB04wHIft4iA/lVm
         ICvRHhLHzJUKPeck+HKaQhdi0owKqiigAkG9OJdzMRaHYtz5+8KfIVe7wAe8ucAkCLpH
         lohg==
X-Forwarded-Encrypted: i=1; AHgh+RodkUY3iJEgEtXBhypde80VTZy0oDbDgJ7nRtyxEmOIEscScnIp1ProDJ0DveCYt1SP3PxMVgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVRg4YSTq7mxsAjE/jvCBkqcEPYAkGBM0Sk1xwIVwhlYYbQeq
	VNtyY7mgkZ4HspdQTp5htteqZdeNhml1+iR/QgfuoVrUwZ9vdgaag4rNCPGC13uXyNoxoo3rIf2
	RFk/Czj82pq5Y+i4QxTGeARU/4K6f3OU=
X-Gm-Gg: AR+sD12CRFIxAYrEelday7X871obWYrEdiqLBJ/6AsaXdMFx5gvY+tZIoNUqtQvetts
	kc1CHFmMdMHZV+O+e421wOyzTioNW+DgQ3YNZivsPSvi4rfdBcKzeUDqPUqOeSpqJ5H9thVr1co
	j+XcmE3yMBqMzKbQXXEoZRtA2k4lPswVfe2cG6MXgMxvFq5CpbfzfDCHCMFcyi1XyJ2ClOaxESI
	hdtl0Nam4g1MTfWgADhEuSdthz//sKA+fDcoQZAY3nHM95bStJgClLODbew53nsGqE6nTXJPuvo
	oeobMc6F6sVnz0xgS/u3INHrJOvDaQzjo9ThB0gNcDlb
X-Received: by 2002:a05:6214:2c08:b0:8f2:940e:2423 with SMTP id
 6a1803df08f44-90a91d1a557mr123266366d6.11.1786744830628; Fri, 14 Aug 2026
 15:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713075110.92469-1-security@auditcode.ai> <20260713093414.94337-1-security@auditcode.ai>
 <36s07n6o-3n6p-p438-6qq7-921r98171q40@xreary.bet>
In-Reply-To: <36s07n6o-3n6p-p438-6qq7-921r98171q40@xreary.bet>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 14 Aug 2026 15:00:18 -0700
X-Gm-Features: AcwNN1VyQkANU9yxbEMoFSqZ9QhxR0gDHgX6WoklB1oekCay5Qss2SGog6-7A10
Message-ID: <CANRwn3SJawDyXOgvWg69mLZspQemMnFNxSDa3OdpTOzzf89ddQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: validate report length in wacom_intuos_pro2_bt_irq
To: Jiri Kosina <jikos@kernel.org>
Cc: Ibrahim Hashimov <security@auditcode.ai>, ping.cheng@wacom.com, jason.gerecke@wacom.com, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:24=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> Ping, Jason, could you please Ack this one? Looks good to me, but I alway=
s
> prefer to have an Ack from one of you on the Wacom HID driver.
>

LGTM. I suspect there are plenty more similar cases that need
cleaning, but this is a straightforward improvement.

Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
> On Mon, 13 Jul 2026, Ibrahim Hashimov wrote:
>
> > wacom_intuos_pro2_bt_irq() receives the wire report length in `len`
> > but never consults it before parsing. After the report-id gate it
> > unconditionally calls wacom_intuos_pro2_bt_pen() and then, selected by
> > features.type, a fixed chain of sub-parsers, none of which receive
> > `len`:
> >
> >       wacom_intuos_pro2_bt_pen(wacom);
> >       if (type =3D=3D INTUOSP2_BT || type =3D=3D INTUOSP2S_BT) {
> >               wacom_intuos_pro2_bt_touch(wacom);
> >               wacom_intuos_pro2_bt_pad(wacom);
> >               wacom_intuos_pro2_bt_battery(wacom);
> >       } else {
> >               wacom_intuos_gen3_bt_pad(wacom);
> >               wacom_intuos_gen3_bt_battery(wacom);
> >       }
> >
> > Each sub-parser dereferences wacom->data at fixed offsets. The furthest
> > byte touched on each branch is:
> >
> >   INTUOSP2_BT / INTUOSP2S_BT: wacom_intuos_pro2_bt_pad() reads data[285=
]
> >       (the touchring byte), so the report must be at least 286 bytes;
> >   INTUOSHT3_BT ("gen3"): wacom_intuos_gen3_bt_battery() reads data[45],
> >       so the report must be at least 46 bytes.
> >
> > features.type is selected from the VID/PID id_table entry and
> > wacom_setup_device_quirks() force-registers the pen/pad/touch inputs
> > for that type independent of the report descriptor, so a malicious or
> > malfunctioning paired/spoofed Bluetooth peripheral can advertise that
> > VID/PID and send an undersized report that still satisfies the
> > data[0] =3D=3D 0x80/0x81 gate. The driver then reads past the received
> > report and forwards the bytes to userspace via evdev (MSC_SERIAL /
> > ABS_MISC / ABS_WHEEL on the pen and pad input nodes), an out-of-bounds
> > read with a concrete userspace read-back channel, and a true
> > out-of-bounds read on transports whose backing buffer is sized to the
> > (small) report descriptor rather than a fixed-size staging buffer.
> >
> > This is the same class of bug commit 2f1763f62909 ("HID: wacom: fix
> > out-of-bounds read in wacom_intuos_bt_irq") already hardened in the
> > sibling wacom_intuos_bt_irq(), which guards each report id against its
> > minimum length before parsing.
> >
> > Guard wacom_intuos_pro2_bt_irq() the same way: before parsing, reject
> > reports shorter than the furthest offset the selected branch actually
> > dereferences, warn, and bail out. Because the whole pen/touch/pad/
> > battery chain runs unconditionally per branch, a single up-front check
> > against the maximum offset (286 bytes for INTUOSP2_BT/INTUOSP2S_BT,
> > 46 bytes for the gen3 branch) bounds every sub-parser. Returning 0 on
> > a short report also skips those calls for the same malformed report,
> > which is the safe, conservative behavior.
> >
> > Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetoot=
h classic interface")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> > Assisted-by: AuditCode-AI:2026.07
> > ---
> > v2: the v1 check (len < 109 / len < 43) only bounded
> >     wacom_intuos_pro2_bt_pen(). As sashiko-bot pointed out, the
> >     unconditional touch/pad/battery calls read much further --
> >     wacom_intuos_pro2_bt_pad() up to data[285] and
> >     wacom_intuos_gen3_bt_battery() up to data[45] -- so a report in the
> >     gap (109..285 / 43..45) passed the guard yet still over-read. Raise
> >     the minimums to the furthest offset each branch dereferences
> >     (286 / 46) so the guard actually bounds the whole call chain.
> >
> >  drivers/hid/wacom_wac.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index da1f0ea85625..89a191cf1924 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -1548,6 +1548,19 @@ static int wacom_intuos_pro2_bt_irq(struct wacom=
_wac *wacom, size_t len)
> >               return 0;
> >       }
> >
> > +     if (wacom->features.type =3D=3D INTUOSP2_BT ||
> > +         wacom->features.type =3D=3D INTUOSP2S_BT) {
> > +             if (len < 286) {
> > +                     dev_warn(wacom->pen_input->dev.parent,
> > +                              "Pro2 BT report too short: %zu bytes\n",=
 len);
> > +                     return 0;
> > +             }
> > +     } else if (len < 46) {
> > +             dev_warn(wacom->pen_input->dev.parent,
> > +                      "Pro2 BT report too short: %zu bytes\n", len);
> > +             return 0;
> > +     }
> > +
> >       wacom_intuos_pro2_bt_pen(wacom);
> >       if (wacom->features.type =3D=3D INTUOSP2_BT ||
> >           wacom->features.type =3D=3D INTUOSP2S_BT) {
> > --
> > 2.50.1 (Apple Git-155)
> >
>
