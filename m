Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC431F986
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567948; cv=pass; b=ZXsp7lrZo/SxErSX0N8cf8sVI0ciZBPZFEzQH0l+B6bqnQPkC3am66l+V1AN4gBXC9HNeScWPpbHdSECOEkrbDMBQhTIDJzXiLoZJcf2IYN2lN5+2DwPOFJLE2nFBOWYBPeLEC9C7cG5ap3KW9nxFk1zaOmYw8n42KyvHxDeAaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567948; c=relaxed/simple;
	bh=BgbFX67wDVJkTsdj/9SCJ2EKpleloJIPnPNPMGXZuv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lx+bAPGIvW0Q1+caaes03Aop01Tn9QvgQPJxOLaJBzfGWVh+kcjaxE+emV7bgBxKPCUa8RmZv9Bbx7ntqoRJNT98r0/RbZOtUCTuIEnzutvPrX9NDQPGsTyxM+DSk9u+FCfUQ1HVbrz/sQfnVa22wwyuqXwOu5Rbcdo+IewYXWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyie4fO6; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyie4fO6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d590f4c291so5337985ad.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787567946; cv=none;
        d=google.com; s=arc-20260327;
        b=mnK9YY3C1Y9qRzciSondJYLdWdCWxZuryYJr802TPtdVal/7OcSH4xOwcZ1Ymtxc44
         c3RG8pin+TuoMWAYkeHuVoqB5c+t2OCz2J9eWwVoFFB3q3lejs3I76VA+xTbzV/UQPJJ
         hx2V8Fnd+gErcpIYoofL73iYrckwEd9qJy2k8IoxhwTW8JNE9/SFnNIR+Ti6ZFgQXC+k
         BH8ygRSccCvML42N0yqWmW/cDU2SCnz8bA6hYQeqnNpD5H0vNyBRbeWv6cH0imDZJvjL
         e9lnxPhP/kGwJMwt7N7Iusi32jUPACEJHmxPoFI0EEDPGZiP6E7HPGsZ0sFCeGCOMIVh
         Zi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1d4kH4nic3HhhxSGmm8stA+Ap9zvMH7EPicZmp7UdXI=;
        fh=/TDzrjs5+IYuji8LF0iE9pgMSl+17ZUJy5gRvS4YWGQ=;
        b=l5I0PMbW7uw6prSEgIOB1SsJWJisbl7P/Xn60hyfrqJi2+tWsrJEcHBBJiP388iiNC
         IKGOXuugmDtTz/4RZLcjgMtGZLZV/VSet6IbtbFUMa86yDw92fw0vXMFRK0hfEXNr450
         w8DbObzTOeHgNI8zJhY4uVrPbMUDaguK3jC/6ypURRUoe/Ru9rfUQrlxIhy0Revg3Xur
         QP9KmZ0k8IkRp5E7SLnAw1b5m1Xin3sLBhMTt0j77Xe7VfZK1poRBVIz9NfYZ+2sx5Ey
         B5L2tsD3gdxX0iz9QpRKZ2nfwVh0iV69N4RCncsg6//8FLuH+RoBXE2c87W3VympB8Q8
         bdSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787567946; x=1788172746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1d4kH4nic3HhhxSGmm8stA+Ap9zvMH7EPicZmp7UdXI=;
        b=cyie4fO652/D0oNZUMAUomGdhRC0ZsVoj75Y7G9VvDgjBacdzG9kr77NG4KgvRuSfU
         Vv00JMNyT1iuLLIq14+zfQzF914ZgI5xomLOxoafaqC+gpxtqOTMNyFPQrvTwDhJfCjF
         6SCu1W580c5qtB9B2FFs0aXa6JQZvkU7w006OtJtfJAbyaxlwz76VQ8+LjE9HRgozZ6H
         qfhuqpT4Onysn9EkHXUSaMW8eoLtglsWUDYk3V5IC9mPP6xhKv497YCziqU6FMocnpM5
         wj2LTW1T9LfdYFOMajBukMZ9ozTPyh50DRksaXG331amXiLE/bLnBtavWWZiaTF5s33S
         21Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787567946; x=1788172746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1d4kH4nic3HhhxSGmm8stA+Ap9zvMH7EPicZmp7UdXI=;
        b=IS+XLzVDF9DYUmaMlHSom+jH9itsEjgpoCKxvENDd/CkZnLRrp+JSFHPDuFvfq1aWB
         SAWKdZa5yRF1qm/kXi6Vuh0KOwyOvZCn+rmx6YKPJtECWKacwx3G/4lWSho+hpfSjOM+
         FO348Knky34fZj1uY3dimjlhN5aeSiIgKbF96a1mp0y5elMCtkMtJYkDAPpl/5/Sk2/v
         0i++MPpz+pwHK5fbdZiIIhbcnojUOSWEXipNAp3EwGBIaoOnOixAOVptvt6NPTzK15I8
         pIl7WyX1x5B0QRdkdRBOFOFRsX/YIH/iA2ZljdYdF12oY761zl/mzDXfSrlzBLNM5Ll+
         to9w==
X-Forwarded-Encrypted: i=1; AHgh+RqYuQIBEpt3KU/+2nPtss/qA3SyjjW95HycyHnJzuhxI7ThWBqi7T1vjmtt61rykJmdI6YvqGw=@vger.kernel.org
X-Gm-Message-State: AFuF++mMQ0aGrJWfY82MUh13p+fP6yWDc1Tq1cSTp8jbm7B48Q74/oPf
	2OuUh74B1cwCxwf1EtdO3rIHhmLzECxt4O644rCfYowrZ86Os8wG90+1W4cPQIBVbQjgkTtIPIE
	f0zwZC+MJZufURvDaZco8BkTcix+Kb+g=
X-Gm-Gg: AR+sD10Z1hTX9nvpUYZAvssosEG+e0PfWw6NSJfaYYDjOdnw4It4/EtybUXwzJaY3D3
	KrAkrtj7JXweRy+u90LgQRl+tIsqupKxi0vx0cmxlxuQFDaEJ7t5pSguQwEx6O8kdomgku7e/yM
	DFJiZ6TbhK98yEXyB//arz/CTzd5YJQ8uRnyma8VseEwVJKBIAZ0Qk7vex/kMpnA46j39CerDi1
	S4UkZJxZir5c7IPv/6RjOxd4ptvTTOXsEL9Ymwwbm1Q6NvaHA1x3YDHsyRlUSgp5P6u5fvaGfSH
	DYnZ39ClopMuLq3WEZ7afbs5zl/DUQXj3sxfa/mgH1gpVvPO/O2lxJLa9VwJ3pmP3gM/JysfYsQ
	BpgGbmUglzIwF57kwi20x446f3292DnAI/cxobdkrtEHFOhVYb6s14LgcB0VS
X-Received: by 2002:a17:902:ce8e:b0:2d3:a50c:5e19 with SMTP id
 d9443c01a7336-2d64ad815bdmr230932495ad.1.1787567946515; Mon, 24 Aug 2026
 03:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816133233.197500-1-ojeda@kernel.org> <aoPOqlGAlLOJ3wgx@jpoimboe>
In-Reply-To: <aoPOqlGAlLOJ3wgx@jpoimboe>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 12:38:52 +0200
X-Gm-Features: AcwNN1WICBTdtFPqyjjwqdJ37MyeqFlctpOt_QKR5j4W0Iv0235s8zfeWZyWNvk
Message-ID: <CANiq72=tKp2LBq8ThjRRZ=q+VPb9F3Sg=v1yrVZ2dpWPC2SE8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: preserve unreachable traps with inline helpers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Matthew Maurer <mmaurer@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kbuild@vger.kernel.org, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:18=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> FWIW, I've been working on some patches that should hopefully let us get
> rid of all the objtool hard-coded noreturn lists altogether.  I'll try to=
 post
> those soon.

Echoing Gary's +1: a good solution for this would be very welcome. I
have added a link to your message in:

  https://github.com/Rust-for-Linux/linux/issues/355

since it is one more possible alternative, which means we wouldn't
need upstream Rust to provide that `noreturn`-symbol list in such a
case.

Thanks!

Cheers,
Miguel
