Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868123;
	b=Qi/yaUkK/eAfWSYCFMxAsM6NB9EzQV4e7nIG+1jz9n8msOh1jR1k5C3M8eQLJTGG3Zwt
	 Ihk9nNIbb1yS2OpZ+DAIKwsIt/QKNKWzJZGI0/8bU3CUHH7Y/aBFvhdRgI4JiHNzCu2+R
	 1r6hy1ykI9yEU+2TWyjc9T5lSQ1q0Ou1gHrwfrFQ+XTzItjaBK7iSGt66/UaLcTtk55Uy
	 iJk8Z4M/SEoa4KLBba8fYPj2q445j7/252o8W9vwbhtp78Xtu+8eSdgD4bQFLNpnbHZTS
	 lrR8+L17idYZOceD0dim3Yu4CllD8groG/M+WcatGoYCxBsnJTYk/iKBrMERilbHFuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EN+xjqjb98UaRHMjBVBOXaIhAP0+1stF7wDJi81/iGY=;
	b=nF9TcSqgFnxevSj7CqR3XAnx1RIPfdZnHN8eI2jMXy2fcFfJOs2z3VbPeDyXG+HgvniQ
	 jw4X/rP27Tu/xUNG48QgbYTQjaRFJ8Zj66I03sdel17wMjUXRCHdTftikg0QyAJt+3F/S
	 OOG0w9ilPzAplsJmyLCselT8cYfFgWKR6EQbbW9csPVAtQ+taQwT4gVrqFK3qLiuKSXrZ
	 r09peDETx3AQ9xLa7q6h6xrNwyJdyGo0xTiBcxe/B5QSn+YThTE4trf7qzWfZe2+CNh/z
	 zl9/Hfe2WfYQDCQuMH6PBYdUQU/1x/RICJGjPEP36aJrzVkjlrNopXcrGBXsCMB5zTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DS8ntiIb;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB158606A332
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB158606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DS8ntiIb
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so4223315f8f.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794868121; x=1795472921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EN+xjqjb98UaRHMjBVBOXaIhAP0+1stF7wDJi81/iGY=;
        b=DS8ntiIbMjgXy/fvT72WvnhHCiEtVQV//0o1lwqzzhWXt7aHFAyu/GMtRGLqnS1Blt
         T8TaHlU0utThuxFkOqTcEftXdmS2LuYBYZwSQ5bLwaNl7Ut5taROwUrxq6hHnsYgMHGP
         g4IyihxhDqsdice7WXk9cdjmBlg96wWQ6Qox3lc2qgO+77waI0OBsG+AAZvYHfWTqxM4
         /mSZaFGlukGthyhCm2HideTsMusaPabxjwykJ8PgEQpc175YRJfWrim+WreubP3xp5uj
         P2neVj3C9zHdpHYsqrPtWDiDKL9Do6z4h4+nYbFKLMEakGe1GWOk+3bloZTjIKVOsy2t
         orew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868121; x=1795472921;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EN+xjqjb98UaRHMjBVBOXaIhAP0+1stF7wDJi81/iGY=;
        b=vAS9eS6qbTLaXgv0pJzwbTERo0RvvHM8e61UUs/m7BKM+KSqEDp//EnxAAlmlOdFi3
         rGn4UJN0KOrmPK8XndmNVlermIDin1eCBmvGmNG5WtPOHEl59S9QfqYOICnsJS2/Q9Ei
         XwxzlA0FFIVNnRMqPrvZIQznHMxxbB6VxAzk/OEEPEXKJ7D9mIRmCWTgUJyjE02rsU++
         eGpxu4lE+g48F3JYv1r8bpgV6n3leP7qnFLzVH2gGA1fNyZTgX/tnBLSD0yZe4ijkjgD
         UP4gxadcRylhtVzXLdxu/drFcHJGB+R/Grp51b+BXI8PEfsul3IVy9WaVzmZQEIUZ++H
         62bA==
X-Forwarded-Encrypted: i=1; AL+hErEt8V9SJAvx9mR5AOds7KVUtGgF1+hiLTvWH0K22Kv9Es9GOguV77O+6twEM3lLcV5NOnBSDlc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Jbm0wFgNfNYo9oZO7P1BbRJIdrHFck1UOhgzdnLbVnVgq0F33
	BPMkdt6xmiEE0xb+NwLPcQlxifensvc7fRPv3yxBjhIGmH15+fsPe98p
X-Gm-Gg: AZFdTZfFDqWr8zJPwUL5oDLO6zjWKzF7eEL6wc6IprHIpRCJzccC9NMU/kGoGzW2H7a
	q+rzbj/oipTVtkEqs6SwRwn50sNg1eyOCGgWaxbhGuaST9Gn3qa7LfAVp7zg5YiWpvsb2JMaXZp
	q3hioWdTMzMGH3K0n/YpmoVTkxlwuup8+MtU/9+KQpRVlQqkojKQ806HBiN0fZ1zaEGDT65zIUI
	JfTw6+TS3YXTc0FeU2AQv2zNMIQlIygBfG3Oi7QaOAu6HQ2/BYZeVkT4hKTAUuGw4t5dhtoQ9Ze
	PYLd0JRicn90zOIz3XJy2nCD74Dj8o8/gykLMUhk9UTindNV/ghY1alLBp43XkGjgM61160lQcA
	B1Os/PooMxKaRC5PbFBbIrf58aMYgedlqta/8TXcCon6wDxlubSh8Tp4YooE3irf3VGvQ8RQwsc
	/0tx12J5Nmouw97O1h/4LHmmOW9F41MYZAFbBxaICx3UqHxShBReMUiWM2bE/55+L/m9JBt0dBo
	jHYJbeYko5AQI/u6X728ZG/8PgqrcdyOGr2i6smeCmKf50h6Hn0b9U8q4zFqa+g8NffyAqiszqM
	0JrTgSnwr7csEgYRuNdRy8ip60Uns0W59gIiee/RxKIAJEgY0EpbJUmerZGrhJC/8Q==
X-Received: by 2002:a05:6000:2513:b0:48e:47e6:fdfb with SMTP id ffacd0b85a97d-49c70ed7c9cmr23140856f8f.13.1794868121017;
        Mon, 16 Nov 2026 14:28:41 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a32155283bsm2125683f8f.37.2026.11.16.14.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:28:40 -0800 (PST)
Date: Mon, 16 Nov 2026 22:28:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Borislav Petkov
 <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/build: Do not allow X86_NATIVE_CPU to be enabled on
 non-x86_64 hosts
Message-ID: <20261116222839.4b4a04f2@pumpkin>
In-Reply-To: <20261116191120.GC1036192@ax162>
References: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>
	<20261114202524.GBavjDtC9Z3j7PrV3Y@fat_crate.local>
	<20261114204605.GA173332@ax162>
	<20261114205806.GCavjLXgsKNNwK0zLz@fat_crate.local>
	<CAKwvOd=f+ib1XVvFfiW2mF8NoWo1jr55fJo=QOuZCJmzQCVmtg@mail.gmail.com>
	<20261116191120.GC1036192@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Nov 2026 12:11:20 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Mon, Nov 16, 2026 at 10:28:54AM -0800, Nick Desaulniers wrote:
> > On Sat, Nov 14, 2026 at 12:58=E2=80=AFPM Borislav Petkov <bp@alien8.de>=
 wrote: =20
> > >
> > > (If it were me, I'd simply whack that native thing. It is such a wast=
e of
> > > energy). =20
> >=20
> > There's always KCFLAGS.  i.e. we _could_ remove it from the x86 build,
> > and <whoever cares> could still do
> >=20
> > $ make KCFLAGS=3D"-march=3Dnative" ...
> >=20
> > (I'm agreeing with Boris here) =20
>=20
> I have no objections to deleting X86_NATIVE_CPU but as Ingo notes in the
> v2, people do use this and it is much more convenient for a regular user
> to adjust this single configuration option in their local configuration
> file than fiddling with KCFLAGS (potentially having to modify their
> distribution's packaging file in the process).

It would certainly also be nice to put something in the .config file
(or at least in the obj directory) that selects the correct compiler
for the kernel being built.
Otherwise it is easy to forget to request a cross compiler (etc).
(Maybe there is - but I've not found it.)

David

>=20
> > Nathan,
> > Was there a bug on file against clang for this?  I can picture a fix
> > in my head for this... =20
>=20
> I am not sure I ever found one. I can file one later today.
>=20

