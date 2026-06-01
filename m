Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEDA340401
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294952; cv=pass; b=MKHgsVBE5ZwlscdKh1d8oBQo1RnLsqBjXvfm0l55/Rrg8SLVzk0A5ukJtfphZR7qchdCxZVMCWSjjtGbc7GQG4R/3/UzDVeyve0I8vkeKzYwWuB93W1cL/xl4KfNBWS+k8C/I7D5EZ4i+jm/HBsJQt/ZEfwi/b7AULqbqdmbmTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294952; c=relaxed/simple;
	bh=rDizJErqrmQNdM5KasAdxwRqqjmYM+IPstQR76bgPHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7Jye6OVwvkLpJBbH2/rMiYYAX0eVvFOcRsl3hpRJduNck0TUOw4K/WD1al4N5e1bN/1D7RNvrnmmFDWRCz0sNcWwoqx5aIRvC3CBf0Xhh2f+OjTdKAfa/gCdJF+CETvh8virqnoLxKbK71B0Su5KYAkYhe5ZCGcv1XvR0hS+Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8lc/XjC; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8lc/XjC"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137dd54dc59so61111c88.3
        for <stable@vger.kernel.org>; Sun, 31 May 2026 23:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780294950; cv=none;
        d=google.com; s=arc-20240605;
        b=LASi9iUJIwS2xdhG0aFP7EUU8T0fwIBGs9HqjnXy8bxDSOiUm1RyIYF9dGELiV0GRb
         UnbK04daYF4MYohiz1Rpy9lsbVo+zLucvOengN7n/K3djhVagrqBFDezAzqtOyIQ+Q0w
         Yi3rXJJksMRvNYbtIh0NvfVBbuT1KfhpBSLbSCvLOCSaEVup9e/efzc9R2YHpeTqcRjM
         g+EFAuxZ69zM3UO0e1Eo51jhgUveYZiZbJUP/V15aV932rU5ejk27FzIt+XXcRjLmROM
         hPQTHWgyEf72F/YYNmsG/sh56Ev/cjw7i/GnfJyBcMJOudsYHOQEG6zAN+XnQJMx4ACN
         i18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGx73QraS4d3NwxPqGYPl3kROHfaW+2ydJcmeDAJZc4=;
        fh=yv/MWznbf3NiQX9L0jN3QVS3TCneFFgkBi7WdDPnn0s=;
        b=jSgOnU6NH5taF+e+B5P3NVITmBnH4aB/1KaRYU2FJq1/prioqEPSbCtF6FpEcXVtka
         eFFntejZeSBKnAwgcIZH2nfO/UOmNhM9hD1Irzx6aleGL138p/U3m9OvnDaeBVxxWACM
         F1miWS2qIxNrBkB/Wd9wsdutnVRseiahu7esxcR0NB0NUbqlzV8LhjsK9kdE0X2FZdfI
         wpPtM4BEE+aL14G6hZS8DBqNF7tU2/t0Q7s/8wCtU2nDui6Sfb0CguLsicRRPmjJIYis
         7wN3pZe3u5YPtjZg3Xq0TVvgkCWcrvQ5F7J3Y9DK8i17imKJlrDJjamM+kpVUOn/L7tD
         3NPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780294950; x=1780899750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGx73QraS4d3NwxPqGYPl3kROHfaW+2ydJcmeDAJZc4=;
        b=D8lc/XjCS1sX/vOZDYtCPJ8o1w/4xcBFBLkVfIazdmjTuj9cVvzswffeSyNT315ydC
         mLfinRIVj4VBbOdbihJdQQwRjYYOhUza7uCfLjQnu9VEJAh8lMBbZ9w9Ynu8Tx5XqO/A
         5udKRuHdIGThJlsCcwheP2d2GvmH9pteG9Q5H9A12ZbRQDXlIPQ90WbozHV6rSI2NnHM
         rRY+Sn3gFwu7Tze478imdtSZRMm+yx5knO2tj9Lvf4JBSHY8PvfeAcWhLqb2TmtRnjRk
         9In2SNAyCavOjt1hiLCze2ScyTalzLPTcQ9Qhuu64PKJT8YaDP+a3KhKfVSyPS52NGnz
         BBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294950; x=1780899750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGx73QraS4d3NwxPqGYPl3kROHfaW+2ydJcmeDAJZc4=;
        b=ls2Is+VJZfB79j05EC1ZaahARagWNdvWiSQUjfZAzU3FxcpvWSIAxN6m50F3QkyPUT
         WW9I/4MUSgTBisTw4iBcfvQqMMx/9hh+070VNtNi25hvL/oPfoWO2kz+5urad9h5l/xa
         n9pp0Z19A+g6MIgt+CZAmPXS8a4wC7Of9L2Von8/TvKEHuXmOJGoC6Gcfo84jUmqQcF0
         E3YlVCVJkiHam/DThCOEGADYfRhzMXs2D6H7V8FcVl7mUd25r68n4Eti4+m1swF+Eg4T
         mmeylq2lmCigf+lgUwWdL+2PUGZa16dnSjEUDjbkyDsFn8MSAet+DT12UeJNuCq95eGD
         BRSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZnLMznlh3RdE3AzE4Y4cPZMuw+AQlBg6NYmyt4lP0M+hj/yo4zUDFwwRW4tHVNalSUTKrgm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzo6paziZ/oNH1BMm24egOGFnCfM19wrrjpvX7trTDer3PXgR
	RnSjpxrXGd8O+Di9tqJWscEfrB85VV4p7EdQ9vbrPmhvfZMYj/O+Zkr30qD79+JOWtrt8ZU+W3F
	s4S7xq3o7lK+raI567ARBx4E7UeA7+QI=
X-Gm-Gg: Acq92OGuXiyxgGX33VZqHU4SiGqewpTKQEn6h/XykvV2IMTk+fiFhDotNEdPgm6RaAX
	kjoA74k0y36uJweYve3RSY5EeDyLxASNr7rbn22WP7EIQvfuRPwAWn0Et+djxrL8IAToxI4UWbV
	HBFRY4pYM74Jq5lfkyztehfTFZseFYCcy61o1wwAsKhC67GJnm0jVN3poDSKyu4XCgpyVJAdMwa
	kJStBK7MLzATXYBeussd+T496siOf5jy6UQq40GIlcX/FMAqg9Bv7XTY9H0asNebm9A8VHMQjSb
	dyDbFKU1xto/NONPNmK6Yy+toN9B1E0reL1gHMmzMWA+1UaAXLmptiRheB01kq5snpOHnNYIFNQ
	NflcCcviPS4o7/yxO2iOTGLsi3fuOuDyX8A==
X-Received: by 2002:a05:693c:2c8c:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-304fa31c4a2mr1997529eec.0.1780294949513; Sun, 31 May 2026
 23:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530095809.213611-1-ojeda@kernel.org>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Jun 2026 08:22:15 +0200
X-Gm-Features: AVHnY4KP0YOUaR4NJ1WZ9OpAGjVDV2NNLjYAMpqZXvWh8Oba9IqjlLwbsWvbpmE
Message-ID: <CANiq72ktxVkvECrfK-y-+YkOANXjV_qQfzPSOJYzwZwiG6xA6Q@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 11:58=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Starting with Rust 1.98.0 (expected 2026-08-20), Clippy is likely
> introducing a new lint `clippy::map_or_identity` [1][2], which currently
> triggers in a single case:
>
>     warning: expression can be simplified using `Result::unwrap_or()`
>         --> rust/kernel/cpufreq.rs:1326:60
>          |
>     1326 |         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).map_or(0, |f| f))
>          |                                                            ^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          |
>          =3D help: for further information visit https://rust-lang.github=
.io/rust-clippy/master/index.html#map_or_identity
>          =3D note: `-W clippy::map-or-identity` implied by `-W clippy::al=
l`
>          =3D help: to override `-W clippy::all` add `#[allow(clippy::map_=
or_identity)]`
>     help: consider using `unwrap_or`
>          |
>     1326 -         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).map_or(0, |f| f))
>     1326 +         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).unwrap_or(0))
>          |
>
> The suggestion is valid, thus clean it up.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust-clippy/issues/15801 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16052 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel
