Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8F137F8DD
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339490; cv=pass; b=IjCTIpRk5G8wlRKGfgeMupsCF5Ufv5yrcz6hPSWkkPh9JgVtfiJ6/gv1CMB8uzgOpQ0Osu2qQ1mscGec1Qr3xN4lJE+OXrKPFnli+cxg9U4FY0rT95kolDUPAZyAaarsu3bcYOUqPmeFDg3qZ9/LV4HVvEg5z07QXZDx+aODh8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339490; c=relaxed/simple;
	bh=bZvxI371yzjLmrtA1r0PYP9BeElhLFWaV7GbH2Bg9TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjZvL1tCIINQUefNeaLyVhzqkTM2oP+SQEHBdje8Ui4q1b/MuCQKrcYsvbHgT2w5rJsnKN67K3EcL2YIHhyqkK7vi5sDFpxBlgUDDo87PzvYaIO++8lTC8BYMfvGFA9paYKDxuN4CWazRjNIv7vn8yPucHSqrwc8eyp/hJ4GXQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVU4NqAr; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVU4NqAr"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384c94c9423so213191a91.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 22:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786339488; cv=none;
        d=google.com; s=arc-20260327;
        b=PD8xczJSMVBfw0MFA7Lq+ILNXpUOAh3WBmSPXZfrbVU2lZPPS3tQya5vhC2fZqaOG5
         TcuWCaJ2KktamRA52uXTFLCQycTsnFP5iN9uTIt/J5ilFqOQMN2r1WKV4oSFmOjj+k5s
         mCgWzqaxh4mIxd7RXK3M2i3etduHl632PJdBSygqYh7Sd7nmqx8NmS3H+5+Y2YlLKSfm
         yR5mtZC62jw3eB3H3GPeuwn4uAkrFiTZ/D2ocRj4YO8DTK24d4d2zajKDHPicpeI5tL0
         j1RfWpLzoNFkrpUrpTtAkH1r0LO5mfJ9om7hIABTfE62Qr8bmCtufpuBcNQt+KkauDep
         1eAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c+9qb+gmHgWyqJTPB8ymjSF9d0A1Q/E/OrWgDvL7X0M=;
        fh=schTk3QfQqLwRRmqU4N1PI5Cp9A/oW7Z3mjoWUxZB8I=;
        b=oiBoJrP4eCEswZ4sZb7FLofYgSVn1BDYBdPRcIyx8eOoVLLsL4XolaJn1AfcycVnnZ
         kPJnOnuIXfoyVJz7HbqqmIpU2VNe9dq9X/dH272bjXxGp2hGATuMF/iNHZ+93TbXG+yq
         4LVLFXVGTIBfIq4L3cmgMKSq0weK45W/5lzdH3okUPwSdjqNe+FYqgEPXepvhTCTtM4l
         7r9LyL+GSo4RU2wL4D7mCDBVNZrmgXRVL6xzvzgGXjTPOrgtfBDFZ2yoJ9L4cfdOwO57
         22zOYkIKZoKJzw/L7l/vVhjglzO0lcBr1oyEzVKzwL32v7MXAMhcULVd+Yo4mqbEBUJj
         TFew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786339488; x=1786944288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c+9qb+gmHgWyqJTPB8ymjSF9d0A1Q/E/OrWgDvL7X0M=;
        b=cVU4NqAr31Kw5W1S+1fgN5Bew2PaPa5phCu6/CHsft9gRkF52oiH0GeZsLO7JhcN2L
         jW7xyFWzotcOo8gMRuEpjceL0V6PUyCYy5I1UQJZT6ugR4YeZc+QIUIFQh+nUV7Zc6WQ
         GT0ubLp9Ev9Pc6HOfMMfkntFyGAm5AGuOTD6lDodhIReWi2wHnVV5xoNqBP87vVWXO/R
         TPodYof/1vdtyHzNDbWzg/r70nYbuzbvxP8XAjNDljeyfiIjWicg2LO1ITfKeNEtiwuB
         Qbqu2MYhbHalp8OvxHAwTVGixCMliUbIH5T0iGdAsEKTdwlqVbLnn8DPZlXac8j/jx4F
         8x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786339488; x=1786944288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+9qb+gmHgWyqJTPB8ymjSF9d0A1Q/E/OrWgDvL7X0M=;
        b=lFi1LaVrXVH1TPl1W1FPv907WSG4RRMFPbbD7+LshPuNnuarTTAMMsU1coYdFsXMcS
         xB+IQKvzmUtt43x/5yNe/nxWsf9nPHihMm6jQExerTyif7FqemeCutUj/o/2CB1Tvfqt
         O8biyzSJn9UzWACgtn2eZ48URRue5tLa4a/NaIwSjrM4P1cegv4eBnQSzfYaLoTPLLJA
         Ff4o6Z3ZNFL/su3uuFeW/wZVxycq+UhZQYNRwIkb3vfkNY0B/WW9Ohaw3QqDJ82E4968
         o2ryCS9LoZTWI3bhpm+bHJv90PrCS5fUY3Z44TWRezJYDtnO0Ddm1fhXWLITLtwrQR9k
         UVFw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+4L7+4/vf/6hpvD8sAJQDRvKXDvMhP5XbL3SsZN9cS0UFxQxtXPh6Kkf6Srwt7iye4LIEzwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6hUKbE6UYraE1M/wvx29dkrbh9/bcX+0IWp11wJW2VpmyZO8
	B87xq5Lu2shiwpW1Z8kEd2+XRHMPgOKJjW61cAED4gL5EazOsyRUC0NrEqAOB4wOWX5EXXewqzJ
	w1KSyzV255rFOBcQpHdSIZIsT/EE9/s8=
X-Gm-Gg: AR+sD108POB2tjgBK2G0KRduKIkO4K+dJWYngNGEeypaMSxp8ZcWSvTxP74ZL1lMC2Y
	jgJC9rnpnmmUiUON6+GGMjcNWqKrO2GS8HHi685dECe9BdZ28Jp7lsEz3+WvWs/l5xZDgzgxycQ
	AtrP+/wr2xWkW4QGMuTRDOD9XpC/Zuh7tT8szUHhICwXgzjZo73dbVvUeUebC2DZQd3X6eCKLix
	yqxWTyJriqp0otTWOdUxiOCAHIrcxK3EsmDdn09ejkElka8Poco+ISgaa21ji0JSYhBNh8TmweF
	ER79LJTDEzY46oVJl6cHGxDDg/ExOY7BL3odoDFDVaI//CfGtzpWDDR907QaHB1iNDeHRabIcpH
	iD08hXEJ/07ZNS9NfD0hR8aF0TH9lVvFDZJYg0kSn0/iBt8Me2JHPm5Eh6l1d
X-Received: by 2002:a17:90b:278e:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-3903c721be4mr29129032a91.4.1786339488193; Sun, 09 Aug 2026
 22:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807112427.1039056-1-tomo@flapping.org>
In-Reply-To: <20260807112427.1039056-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Aug 2026 07:24:35 +0200
X-Gm-Features: AUfX_myFE0XC3jbpMGRLKGxOkMimhm0MgaPuDpOhudzagj1zX_me-0Do3LrTYK4
Message-ID: <CANiq72k0iFw84GTq+PUUnFb-+3NfeSJWoGFOua9Q9Q0umceU0w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: bug: fix warn_on macro build error on UML
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, david@davidgow.net, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 1:24=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org> =
wrote:
>
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Callers that go through `kernel::prelude` have `CStrExt` in scope, but
> code inside the `kernel` crate imports explicitly and may not. Using
> `warn_on!` from such a module fails to build on UML, which is the only
> configuration where `warn_flags!` needs a C string pointer rather than an
> inline asm bug entry:
>
> error[E0599]: no method named `as_char_ptr` found for reference `&ffi::CS=
tr` in the current scope
>    --> linux/rust/kernel/bug.rs:83:49
>     |
>  83 |                 $crate::c_str!(::core::file!()).as_char_ptr(),
>     |                                                 ^^^^^^^^^^^
>     |
>    ::: linux/rust/kernel/time.rs:427:9
>     |
> 427 |         warn_on!(self.nanos < 0);
>     |         ------------------------ in this macro invocation
>     |
>     =3D help: items from traits can only be used if the trait is in scope
>     =3D note: this error originates in the macro `$crate::warn_flags` whi=
ch comes from the expansion of the macro `warn_on` (in Nightly builds, run =
with -Z mac)
> help: trait `CStrExt` which provides `as_char_ptr` is implemented but not=
 in scope; perhaps you want to import it
>    --> linux/rust/kernel/time.rs:27:1
>     |
>  27 + use crate::str::CStrExt;
>
> Call the method through its fully qualified path, which resolves
> without any import at the expansion site.
>
> Cc: stable@vger.kernel.org
> Fixes: dff64b072708 ("rust: Add warn_on macro")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Applied to `rust-next` -- thanks!

Cheers,
Miguel
