Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D24772BA
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157698; cv=none; b=ScYWoMGMR1vOZJxQnJOUG6AKWSr0toBZBeyl4n3NxjFBeoOyteztXDz+K4a3Wh18N8jpzpDS4LuEjDCpIokCS7D+vqnSjGVQ3CXHBqIyqou6Mdqi2zMWtXkQwggU6fwGqv5vgX6Wxp/iGmdqGh+rPvs2bYKBezZFvwkhRNyjMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157698; c=relaxed/simple;
	bh=Z4w0jhcQvhCI0bosMo9w46ys/yNsvZhp5zSOIajIGvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JrW0yFBdIETgNM3tOHj0FOeihGWsdPIOkfbESt/7Uw1+W8IK9fXySbctU6Ljkj6IxjbI1Sgcx1ZfY5rRnMMj1RASNvjchWhcaQIt/EIsZtEV0GWo2zKcnu/HFaQppQYzeeNGVggY3ib9M360kdhv2rXOPGgmb3Ve32EDnj6jDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xrv05/ql; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xrv05/ql"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e024d2129so1952905b3a.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787157697; x=1787762497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G2Hz1YJdLVa7+hLxZtMeHXHTsMIJrFof6Tpk0CJAbWU=;
        b=Xrv05/qlyVVjlIoQe0a0aqODhxhSwJvjZAuAKTtW4AZyFT8nYFDlza7K2zyU08Gsle
         9tnwX2KpVBe9SIcVctBQ6ij5bc+Ibare0X9VGPjf4lACg6iZo+BVvjE8OzxTEHXoyEBE
         CXxLCGP5hO+QOdW4ELL+hupXj/5SDf843vm+WyRBO4HBY7le97x2hsG5SxnoMjTsXuii
         b42LvktGZJSCrdiMIvoFXK5ICmBSZBsibb8OsK8Uej6RNcN8FkhC59Hg0uwOAW4fFVFS
         0Kz0toVafLfDg/u3zx4/W2RQhnnojZB7+qxHOKlnZD/CANSAG9UKfkvryB78bHEJyPp1
         hGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157697; x=1787762497;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2Hz1YJdLVa7+hLxZtMeHXHTsMIJrFof6Tpk0CJAbWU=;
        b=HAix1Eb9j1W+HTiDzWobB0v9oUbY/2mt7x4vu6eXdmn2AZFKLxZCFoLdVrwqi8+/Mw
         V4+JjtZxvKLhc6Iy9NZeTPbFPX0utMan4trCKvYASlfF2bnW1bPZDMv5XWXFgxrvxiJk
         MyKQjwXbSxnInZYL4NuTZL68KNiNE8vFAi8jxRYoe/v0aod6zb5xvCppP2VrXwfMAkyh
         TWEZcr68xFvlvSzbeo1EgDJ7ACocS5YiwRw8qnhMZx39hnMKaIoukVQLE8w3l1QI1H0a
         4H56JJoPxl60Ja8ntPNCVaEoZc1ITjaJhy6tXerNMJGedhN5i7KGqU5PBAyo45O8N18t
         ylYA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/Y2hbL2XKLoaI5hxUKKZ2whDlrBZwvYZdJaBgrYFM+7EcLF1OBLaMnO4mcl+uzqeubyfghJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/v0MNEyLjtaOnuJlf0Yz1THTJkom8vxak6PPoQcsI9LO1XYgW
	/hqR+48beO5+98KjM1bgcN2+NYQG6buva8g23T7WRLepiJrDKBOgerHNlqZ5u2mhLiFeIfmudu2
	r1eOcJQ==
X-Received: from pfew13-n2.prod.google.com ([2002:a05:6a00:c1cd:20b0:851:c4fc:fe2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c82:b0:851:d12e:389b
 with SMTP id d2e1a72fcca58-851d39598c3mr10615556b3a.14.1787157696399; Wed, 19
 Aug 2026 09:41:36 -0700 (PDT)
Date: Wed, 19 Aug 2026 09:41:35 -0700
In-Reply-To: <CAKSQd8UyzWweM15-9ehaCaYYJYw+N8z9pFon2J+3sehqm=Ukbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKSQd8V=wfVrUxeU+fDRgKJBLdiyCkkY2SRY+OoRBNE68LFnCg@mail.gmail.com>
 <abe4535e-c72b-4df2-99be-064479b685ec@intel.com> <CAKSQd8UyzWweM15-9ehaCaYYJYw+N8z9pFon2J+3sehqm=Ukbg@mail.gmail.com>
Message-ID: <aoXcv795N-xmtTDl@google.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
From: Sean Christopherson <seanjc@google.com>
To: Christian Ludloff <ludloff@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Chang S. Bae" <chang.seok.bae@intel.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026, Christian Ludloff wrote:
> On Tue, Aug 18, 2026 at 5:55=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> > On 7/24/26 08:37, Christian Ludloff wrote:
> > >> My understanding is that the revert was considered because TF32 neve=
r
> > >> reached any implementation. If that's incorrect, I'd certainly welco=
me a
> > >> correction.
> > > Both TF32 and TRANSPOSE made it into a product that shipped.
> > >
> > > Not from Intel... but.
> > >
> > > So their CPUID feature flags and their opcodes aren't reclaimable
> > > and efforts to rip out their software support are counterproductive.
> >
> > What would folks' preference be on how Intel should document this going
> > forward? Just leave it as it as enumerating TF32?
> >
> > There are notes in the SDM like:
> >
> >         Intel=C2=AE MPX has been deprecated and will not be available o=
n any
> >         future processors.
> >
> > There could be a note like that for the TF32, I would imagine.
>=20
> Yes, that terse sentence works.
>   Once for AMX-TRANSPOSE.
>   Once for AMX-TF32.

Maybe use a similar approach as is done for the HYPERVISOR bit (0x1.ECX[31)=
, and
have the "Field Name" entry say Not Used, and then use the "Description" to=
 explain
why?  E.g.

  Register        Field Name      Description                             D=
omain
  EAX[6]          Not Used        Intel processors always return 0.       P=
latform
                                  Allocated for backwards compatibility
                                  with software that expects this to
                                  enumerate AMX_TF32.

Or Christian's terse version (I kinda like the terse version).

  Register        Field Name      Description                             D=
omain
  EAX[6]          Not Used        Intel processors always return 0.       P=
latform
                                  Once for AMX_TF32.

=20
> If you want the back references:
>   TRANSPOSE got dropped from ISE #059 and APX #007.
>   TF32 got dropped from ISE #062.
>=20
> In terms of the opcodes, it is like MPX too: no recycling for
> a long time. Luckily there is plenty of remaining space.
>=20
> --
> C.
