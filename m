Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7C3976AD
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140859; cv=pass; b=O57EulctMq7edwmnjd4MPHMGkgkmJdb1Q3fIeQpQxBELfe5wPO1qfqhgK+XO65IGUe5sh8k7A35KIl7sjVQPzxUuG30mWKgSOLPl8xaFG3wAv+ie0ndajNaFmcVVTG2d4WmCzXOgZd+mYkKhxZT9dzF56AIOI6fM5xPgiRZjUD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140859; c=relaxed/simple;
	bh=7juR9p8Xv5arQajgMs8TzRWY4io96iOYQct7TEDteFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWbeDYe8GGvaAIRfzCzVR+vFTSxxKmBMesCHJ+KzOJEyafTbj6K+fyTsQfh8ugJlvFS+81w6ol7wB9aGE3eGcdPBUet2JAO51Bp6My2a9slDB4Bs7izo93qzdQt4+RaZ+1rb0pTumztDjmQhkSCAHFxF+bABKttGQvFNoMI9eBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C12T/7qQ; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C12T/7qQ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-305056ac6cbso37065eec.1
        for <stable@vger.kernel.org>; Sat, 30 May 2026 04:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780140857; cv=none;
        d=google.com; s=arc-20240605;
        b=ZKIJxzcLzwGdmc5DUxpW9zrmhn7Nn+auxKvbRo3he+AM44DkXzfPGs3z0FZV1Q7JvD
         pYS0IqNcAJx7a9fsoJn+u4B8hEvvF3h3RnOLO5ueVZ5l7NFsbRmsp4ktNHijoP54f8Fd
         YYcYbEgyU3HPxBbJ800aXjl4EcWEXxyztP70aSwk2RqkDH11GJm/9KZrSeKnYLHBVSaL
         p8Yl9ZhsYnD8N7iGdQ4+W1k8TQPVY4kECb7TGu09z0PwzKnfZqj9IGJKN5Yc2/XJ01Tz
         g6BxwInpt9n0jKsu2DiIoj4JMqc5RV3iV/TUZIWWYKbF6X/LrprsPBoE9MzwiYPMT1+d
         /47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yoaIvqz3mqLE/33YsmI2LMsK8ApZkxaDEDAycdVwp0U=;
        fh=BBDEEMMerGfFJ/0I+l1eR8U8Q68eQVrdU3Yx4wkZ/fw=;
        b=amRe/kHb5TjJjiU/nrfdFYY4x11WjiHq4pSzYLaFOlLG3ga5orsBnTBkNRjs5KXk6K
         rOaKCZj9KmiiUZoDIW3rQP1Ei6KIbKRjYfdRtlNNf/qx7phNa5CP5pfr8VpYrpQTb5GJ
         5cnaSt0oRn4VDSDZRgj5i5PL5enHYUCTg5P6vA1dh6J6G2yhEePQ5WxH7R8raq6vaxVU
         yGy8JTtBbafbHAK5Sp9ePdMt32WxMAdndUITiU5Kh4oim8RZLKTSVIjRlGZYR22cqINX
         mty+Gt4a8ie05uZODFbXIIeh4W+MOswjaWJMDBzw9Z43BTXgnprgVv4HQUngH2BwNC8X
         x3LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780140857; x=1780745657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoaIvqz3mqLE/33YsmI2LMsK8ApZkxaDEDAycdVwp0U=;
        b=C12T/7qQExF7M+xAh4jbzmbwcYR6l6S6usG+T5rrx4k8SNonk1+upZzrj86aSZteiQ
         KWLQt8H25JQ4/Odg1wmQMDlA+ryvfMq72Y8Ia4xin2cSEo3rlNGWLPVCxXRP9jBK+Xyi
         XrDs5QiXpDubHQLDBCH/IHVJd3/rpnsD9jmgTPPryB9V2xg1Y4I1UzQfxrF40YmFphJg
         M2EVkWFgQ2ErM0PGpCAfIECLY4eYiPTqV5HRSrH0/G67cWRSoPR1hF1M3DwMFgiy6jjQ
         uiEelKH9suYP8mDLs4A7h6XS8vGMGL8Rv+/xcdilq4uMhHNdB/HhNMvugDyYvZep4TNf
         Awdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780140857; x=1780745657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yoaIvqz3mqLE/33YsmI2LMsK8ApZkxaDEDAycdVwp0U=;
        b=UK5T64VnAWXgfHvKY9g92KwCjSpOF4iVUiXu60hh5L6eljkXjdDR8dorKB1rxadOrs
         iCyWW66ebeDrWUNGE7f4QhWi0XoT2/GPBrmlX+YfDGDLVo4MvjaLvxNLJ20a6xLKnhRD
         KKyJB0df5SZeN8Du8v3dnQOmLm9rmKvdyrzp0vokvs8eJ92SNT73i7YyXmhNtr8DgcFh
         zIeDHuj7iWQV+KvvQrBGqSZ3DVePP1F0iB7o9HpT58+7cVF3GfNOvJNkZKYZ3Q0hA5xC
         o+G+boUzRSa5CCyDaNCCshzZ0amRlyQDTXayP2KlIlpEAcH/A2vG/D+/qiqwc87025n9
         CftQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CmR1wzzLQ377sixqRzJIoU6dfQdvvQLtquhbrG5EljbdpxTzEj1ZRFxQI7INgDTIUqm6zNlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1vHcVG1Y56pihusbyK8usP98xU6i7ku25uQeZjW4kYWkHlA1
	4HWL8LvXzQkxw2HRa0Kz9ab0a0NGQmhvNQFgg5uZc7TaBl0jNP5cXySkoCPbHv1BGCX+kSQ4sWX
	7qTlAXr0MpBNyNe8I/7w1v2duxMyVtbA=
X-Gm-Gg: Acq92OEh3+4+dZMZJzIDI20h4j4LEi2Es1XH9s/dLPEbU5gZS2maJSq44S2uF+A/5hY
	MITMxc3Ebp6j+ARVTYeCAYge/ivJEaXtBMnzZbqLXm40NlzCbBWVtFa4m/vlgX6W91KXOmQfFri
	OovTNUxduTSzeSAPo/p8iE8rOKKfhosCylMtHFHU/CzzI4Y5wrQg9VKviryqmEv5y8OP/MPaP/8
	wZdKX5fvQuwgOOTf4muOW57PbEzZY+DyutZGcM+KvkNjj/ZUgJrzLNfLjo7pVTJB03aCv6Dtvoz
	vRd11SHxvkyKwtQn+Q0yMcY2Rpa5HXobsVpMCkywGF1AnTqoG+Fdy4ZPnvOpvrZgBJCDJwp4sQe
	mzURC603cZ29Q0vkhHsZiFfya4FDlVaHNEQ==
X-Received: by 2002:a05:7300:6ca1:b0:304:8860:74dd with SMTP id
 5a478bee46e88-304fa6c4509mr884143eec.8.1780140857291; Sat, 30 May 2026
 04:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530095809.213611-1-ojeda@kernel.org>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 30 May 2026 13:34:04 +0200
X-Gm-Features: AVHnY4KQK2kRwQKYuYnJGv_YwzRpnyRzJ6oFPD1S0YuI_SIHE6subfsnC0txmV8
Message-ID: <CANiq72ncuqxjjx+1SMV977UC-TZL9aPrbFECmCPPdzSLi-Oc=Q@mail.gmail.com>
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

Viresh, Rafael: I can put this into `rust-next` if you prefer (I
considered `rust-fixes`, but it is not important enough at this
stage).

Cheers,
Miguel
