Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC52D3EEB
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104124; cv=pass; b=UypOjnDbBoliBoHkCQLE7KTDXyjVFLN4sXbbFaenbnTsBfhmBfklFFzwIMXAqDPCHpNhhZK7Ovd8Ey3rFJBY80gKshfLdxSgxK6ZFTltnvBN+znXgwmXtt8IKT8ibq79mVI4Yf/pas7yMKJpQj/voPPDBEuNcxkR9sa9sHeRxtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104124; c=relaxed/simple;
	bh=0joFlQFKze2VUT6irZ3O1wZRJqUgaSpfC8SHNl1LCZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSFzRGNQV2tMCX4FQ72zwTxyFJ3SBp7dV3/fKK0aqxUYc7Gbrsr2ouf+K4Fqkfkz1xv6Fu2AyZ8MhxsuYh2JYifrBGt1O8oz8Udqcg16yMJHpAOEL1SeALINAzRI87R/HZ3lorjhlkrMaIiMedZlhkXJDzMNCyRFcDVB7otzIT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8sUS/vw; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8sUS/vw"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so307001666b.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 18:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787104121; cv=none;
        d=google.com; s=arc-20260327;
        b=GRReT82daEl5LfX+pC7F9tY0W7n6V/vxMyhHrw3Vyb8odeQ3lxYxR59vlqTXBvEmNY
         NUo/pg+OWOk75kE6UBXJ1NOzIYTgzvQgRPXjizLZn/pwwMLevC2d7qtVshdNzeEbuBqQ
         4uVH6D0PWGw2nQEeEXSMcgjS1/1FjJ1+/RQUA/65r7k91Lq64S7eVgqBMZ0wTLWLkd93
         PjMPnhRaDGHpx8Sz7Av5kNGYOEn+E2ZJKKaxYdjgAg6hQiSTmcCISG3zy+tmu/0flP5T
         WRovoIijgOjCi71WadjzS5gPmts0zgAxR/44OVoOg2UPtr7RpqszHN9sXK+y7Fr/oHLg
         ssLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=lsCtmvkS36zvX0w2r9pYrglPyEHrvikivJeQKgrGG38=;
        fh=ZwxvlfRk6oeXXg4dpPzj8D6M4vDGhKeEAVWrsnH1EyM=;
        b=CSs1fIu/S+fA+ZEmOTKrg7rxQSbLzZDwGRCOyn/W5jayviGiDdllGacdM71+7iJa3u
         VLuVWmv2jtQliS9kIOlHC/pTUTPPjAg1cONhSyrHPDkbeLpg2mCwYS7qveV60EjnTe5v
         1tejWhtRFjCEQoUuSkTN8d1epBrO6/71hbe0RQ50JMcJdztqbQ50VOS6PNn6RXc0xPKu
         ght31nJUwUKQSKK3o9bMVwEo4D+LZU65Z+MYg/hi8ADgTvYxnpiCDP7hsDkXWsvWI029
         rUTtnrO4s2Dg7sYarRK+F6EExqlOCafDq7kDJx5qW3dC/9sBWAiAOjd+g6eobUaB9EOp
         iOCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787104121; x=1787708921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lsCtmvkS36zvX0w2r9pYrglPyEHrvikivJeQKgrGG38=;
        b=r8sUS/vwemYzO8YHnfPCZnxrOz6R+5DUyUucBpcO/Po6JBzwjYqSSVhhgA/ZcaDnRA
         4pn0ZPmCciXgfhUlTXRzdo88hd/YFQFpE9jmQzcEK0NmARHA3+7Rr3EiZR3JfOkyO9Pw
         nvowT+715Kex6znGdrKkOHUpwy0wmRc2rFxkCOirFIGw8Z3GYYc//ieJz+18CwjIo2Uc
         UALOZZJmuwueJj7rV6Af/EUv5D9UR6ypM6YrE/RO67B3kH1O5ZGPwwY3Cq8OzwTQbibw
         m/aZGk8y09vopjHNjSdQgwEUmOPfS9KCnnaHWghPxjMY+kp4YAgJ0b2ZbLKbG7OE9B7g
         tdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787104121; x=1787708921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsCtmvkS36zvX0w2r9pYrglPyEHrvikivJeQKgrGG38=;
        b=LQSfqyVubK9af6K52Z8Eyzs0Ujsu6HxNdZrSFWEN0lWROypWG+4gs/i9n+WL5G+8og
         uYHhSBpTfT45zF+Bd4SP4At1SFjF7xnRDUbf2THXSPHUGXNq//HXngI8UtMDx9jlnE/K
         SLn8xOQY7WkKx9a7ajvJSKK9cyM2fZ95IYUEOcDN5nl2xMIojp6svmv+86VQVqmZZTgS
         KyW9zoSGCjb4Pu/XrgFVaWKZuiJbEf2OzaBqMKpwY1WnVQFEKpUsENiHw3eeqYnt2wGP
         IxRj/2VllOubOBqhwjp9qDQM9t0uZ2oqg/TGMg/rZdKP5vlRRUy9CTuUQkIZTwXRykGG
         F01w==
X-Forwarded-Encrypted: i=1; AHgh+RpN+Rt18BZHJYcDyFIpKNwvLESkEk/5DyPSyR4BMLzeRwrDHa2GtV/9rdzBpfJRHOfa1XWRoAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0pfI+Tyo3z5pgctqHOo2QdImWRC6IkB0OW7OEP9g+7hL6GDTY
	d5oogtIy4lhYlGWn0U86b501Lc7CyHmWIAZgry5bySLyUh1rKspJLYAzyUrnB66C+GM2TnUFsFh
	bj7sqzFhNMtJvNYGSYQTrcQjXzz6JbdY=
X-Gm-Gg: AR+sD128uYYyecT/TF71qPZDFJtFiF3z2/MmVXylwYrAFTukc9D2DDLWZYSBB0+MTTn
	L//KErCV6xcg/4aGnRlvpc1SDUNEoVpz6h3djsJCnDX6avBwjWX6Z1lDFUIxmnStY3VoY38pdqZ
	OV6dIJhOH5swU14+P5RzvdlzSPLXTkTmkMPBy2SUqD3HqopKJJomqzH55xwkpOxbFw1j5LfTFa/
	3FsvHAKjk3eOdFCB152fyWgnRDZlZNlZzKCu9/qWdZg+gYceK4pl3a3ernVUyDo+j9azmTPBrJI
	cKNHn0Fm6cQycL4RBf0qXw4tbbkgT09bSa7xk24vPUlNVUrDjYlUEd35SmIOvyHbcEw8NbCO53p
	Vgw==
X-Received: by 2002:a17:907:7b9b:b0:c21:4698:ee9e with SMTP id
 a640c23a62f3a-c238d4350f3mr56079666b.7.1787104120708; Tue, 18 Aug 2026
 18:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKSQd8V=wfVrUxeU+fDRgKJBLdiyCkkY2SRY+OoRBNE68LFnCg@mail.gmail.com>
 <abe4535e-c72b-4df2-99be-064479b685ec@intel.com>
In-Reply-To: <abe4535e-c72b-4df2-99be-064479b685ec@intel.com>
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Tue, 18 Aug 2026 18:48:29 -0700
X-Gm-Features: AcwNN1WStHFp7p4p1eOrc7FqRDLjsrfvmvwB_O2N-MMedPQitFU8wUiQ0JSfFx8
Message-ID: <CAKSQd8UyzWweM15-9ehaCaYYJYw+N8z9pFon2J+3sehqm=Ukbg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:55=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> On 7/24/26 08:37, Christian Ludloff wrote:
> >> My understanding is that the revert was considered because TF32 never
> >> reached any implementation. If that's incorrect, I'd certainly welcome=
 a
> >> correction.
> > Both TF32 and TRANSPOSE made it into a product that shipped.
> >
> > Not from Intel... but.
> >
> > So their CPUID feature flags and their opcodes aren't reclaimable
> > and efforts to rip out their software support are counterproductive.
>
> What would folks' preference be on how Intel should document this going
> forward? Just leave it as it as enumerating TF32?
>
> There are notes in the SDM like:
>
>         Intel=C2=AE MPX has been deprecated and will not be available on =
any
>         future processors.
>
> There could be a note like that for the TF32, I would imagine.

Yes, that terse sentence works.
  Once for AMX-TRANSPOSE.
  Once for AMX-TF32.

If you want the back references:
  TRANSPOSE got dropped from ISE #059 and APX #007.
  TF32 got dropped from ISE #062.

In terms of the opcodes, it is like MPX too: no recycling for
a long time. Luckily there is plenty of remaining space.

--
C.
