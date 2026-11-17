Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794897466;
	b=DEPZmaEKfPPExtewXfRcN2QRIZ3NWvm9/oyrfNFgppaW0qukMDxJW0hX1Dnf+N5Haqcn
	 qK6DrSA8eMsrRQyHih4kQMHnxBcAhyqWWAcN3Lghq4ivMMoCGao+rndUmuIIykITlHVRz
	 BctFGM9H03VfUhKTXra0fRyGpZlvK73Nuv+TkJiCTWgfk7oIUX1hGWnYmHzFyT3A9PDg0
	 4plqzOkWAPVkSwOrLt9nAYRzyFuDCU9UD+pWngLtGnovAT2mOw3HVtO2ZHMI/1VozOz/b
	 frqZidcMb6R7FNRvlfBYSVpzzVvwy5lV5i5wKPIbkqgyfvgLOwOCXjs5ikzwhlNo2cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YUlK9ZNpvQHltexnJRlNgEioE8zAmE1eGzod1N8ItX8=;
	b=IAMWcTZNoftBKIKIwBG1LFHVwsyW6V/1PnhzdaPMFXhkOVI+3BQVYq8lJ613bN6u8bGi
	 uUbSNiriULP7/TvktssJ5g5awz8QhdOxJOCYJTkfmbF+D4VFcGjlUhDPpBl8RchFM3URK
	 Dj523Nd0W+gdEg7EemX28DqaMuMICCUV9QK8eL9LRVj6vE+Olcs7h6Fa77fqNG+b2XmUg
	 w4TITw7Ay1rrKPsqOsEdXiuPqGMED0T8MihIZgLyIUQLNZpItfj/Ez8RIHQ5LZqCDrVml
	 in1v0WFtnLlN5tWv1hnVwSWIYzJd50U4UBUPJv36SXIpElYP/AtkP8ljLQtz5cLp7tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TRk53iVx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE7606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2DE7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TRk53iVx
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c14edde59eso264438e87.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:37:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794897464; cv=none;
        d=google.com; s=arc-20260327;
        b=jTT0jRGsKD6KcrjrF4z0UFH1sv3JzrsHeVfOzuYmPyPbmHdp/5AnHYoFtCu+/+enuV
         7uMKlFzuMUm9qfYr6KFCgEDNvgjTk06TsQbDUddrHOYBeyQ5hAz+7UWC3/bWjNG67J6Y
         rgn+nNEtD9qyPosidEf8yZ/AnpdVjzSzqwEaM1t08gU+xeypVrZJf6yFzcNI0AEz/iND
         jl1MTw5EEm/z8XMpP2XFbfFR2o/KPdU/x40Xa5w83h/qU84HFCL981lOSbKGDdCK8NgL
         yND7GwfnXO7ujrt62DL4dnyu6Br8EvLJLHHTwOMq/xRe9ZyedrIqbu4cLfIiozG1RLcW
         iGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YUlK9ZNpvQHltexnJRlNgEioE8zAmE1eGzod1N8ItX8=;
        fh=ykjlsy0963WoQovlCP/PTfNC55O/VPmQGqesgDYutpw=;
        b=kLkT+N2T4zi2mp6t2UUp6O7YtaodKWF8t2NFo+rA5h+5PMNC67Ib3XbzdD28KeX5f4
         JQpjGy0uL4CgmUZdSdQa/3dV3STvyGFIpDqw7b7yMyB4ltK54RZSQlegrVunKiUke0ff
         DMP+7OuI1PzydF21ahatXBhQSgKNjYrU9dHMwQiqKacrfLDE0QhvPxn7FGjqZ9A8O7C9
         lFm2XjAlIIL3r9LRrpA2UgXfvpCIrMyKjY4+aiUdLEC5z0hfOo6oqQpxSZoIPQyQSiVo
         S3yIsixOZDIfM++j1Zy7lmTC7zkeSPP4OArF7GJ+WN3jYR0VBuuk9xSK9KoQWmTHG5P6
         tSZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794897464; x=1795502264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YUlK9ZNpvQHltexnJRlNgEioE8zAmE1eGzod1N8ItX8=;
        b=TRk53iVxMjHe1ufTUpvhFZmlnus9n5cPzA7hFGRgZ5zqWCTfOgVQK5KSnI8vSKPJlE
         ukFAbEuPQF/yXgcY/qt9ZJN0KpFwdGlgeExtkh1pYvcP6PLieL/a4OoxyoQ5PNBT+o2v
         7IsAhe8+acOmTWANcROXa3ESAycHuTDowzl2C5V6fm2/zqopQ/Z1gxkWFf++CtrQOXMj
         GmWh3rsB0wf68j31nRC+Qvskxra4SwHzfVH7v1Ecr3E7i5Ot408eEWaFpzWelaoNmVYA
         QRSFodTIi55dykMLm54oglVr0t6Wa46zWtXTABtQddyPVH4D82+YYwg46K5tlEL9xMcq
         sgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794897464; x=1795502264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YUlK9ZNpvQHltexnJRlNgEioE8zAmE1eGzod1N8ItX8=;
        b=vImBRvmMZRx6SJOeUTpbNMUlf8vQ8XbF7yJfmj0324xJ4H+TSsn9ZUzS7r/pL5nRMO
         nuCScbLN5cKsrKQh5uZzoGUwYsm4GC1JkbT0JRh2D3saU4JbzRk0C28P6SNimfeaRit3
         +ysO75ylPboCtG5NJa5Yh7yNy6TWnrwamD0bUcxVxoCwbKHaZQZdsYjGi8QwJ39CvPRV
         n0Z/ItfdqI3bLDP5Fgkjxy27vKsa4m3KP16u9SrBV32NRFpOZe/HPZbH06xguFjLwJ0p
         q/69k9ZVxhs0A13H6zA1+YwduIZjTil9KkOXSd3fnE3fqL0eR4kgNaDa08okCAE/3Te5
         GhUg==
X-Forwarded-Encrypted: i=1; AL+hErEH8vjOiOh8/2abIMm6cQSlAdWUcUXXY5wuKn2ZHpF/z82lPq2t2ejNcyRzsa4HYpdFFWa/8WU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KlpgrCOqzid0ZfwLGCnv2u0l5UvBON8GP3cKodX/aXNPu7Ics
	U2hRTX6mr8fln5JlLY2KjT6oSy9TERaT7zdEIwebNkgaDBwwuIdEnjP1sj9wKIdFb6HnUKBZgzv
	1EfPPSNsk52F/LBfQAe0lOKPjIDW8aVU=
X-Gm-Gg: AYBFou0NZbMJuIa5bIoUC13OFqIGxPvJdapVJCRMcSAQ9fAUXXaTlXvGq/R0xMNMPkQ
	F2NTx8qBtaXmvP/alwkdAAOVcG3couL4tjPFjVvdmEJE/6/aF7YVnJkisdfOcL8Ut33Eo+g5vZa
	zJK4RnpnIDnP0GS0Ts6TICxOd4kMR1sLfF0WAABizizleqqM0WboJqEwC07GONaojfjBUj7dXAX
	PnNk0XUk2bsv7LwNfv+qghhHg8q/WVMXjF+PfnXD0tm9Xx+KX22OiFZXOTcT2ZMUBAX0YKpy3lc
	4MyIRopeGUYv2nj7F++hv5NonWKCsc8aRNllwcW88KfvqehjtDUVl25ZUZ5tWy1+YZomqQjxtvW
	DWio07Wl62zlrmU8LV98T8PSON/NdonH6NuaVMQZiKjK85uQefCy8u/T9V5VPb0YaPU4ELucpMa
	k5CybreDGjK3FmCRGjx6Iq2xP6obTtpdGLjiUTf17GvRSh7/Xh3pnD2a5oRtDTAI53glOYsnCBX
	hao4JlSy3uX17SDAlK2iRcmV/KpJjgxB0fLfHv/9GnmZByqu7qxGq1e/7fQdy6TNLHvl6xgSQ==
X-Received: by 2002:a05:6512:3d0f:b0:5bf:e6a1:3115 with SMTP id
 2adb3069b0e04-5c170771fabmr5742091e87.2.1794897463748; Mon, 16 Nov 2026
 22:37:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114001708.80599-1-ojeda@kernel.org>
In-Reply-To: <20261114001708.80599-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Nov 2026 07:37:32 +0100
X-Gm-Features: Aa3M54pSxBLoIp39ohV3UVQZCVKgqxmPHHIMH-JZdEmZB-mCRyeG6lnfgzwCdDc
Message-ID: <CANiq72=+ZC7DBx3rwTHQaKOL3JfV-bC7vUq5dsy3itEgoLiXxA@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add more `noreturn` Rust functions for Rust 1.101.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 1:17=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.101.0 (expected 2026-12-24), `objtool` may report:
>
>     rust/kernel.o: warning: objtool: _R..._6kernel3pci2ioINtB7_6DeviceNtN=
tB9_6device5BoundE8cfg_size()
>     falls through to next function _R..._6kernel3oppNtB5_3OPP18from_raw_o=
pp_owned()
>
> (and others) due to calls to the `noreturn` symbol:
>
>     core::panicking::unreachable_default_msg
>
> Rust now outlines the constant messages of the panicking macros [1],
> thus `unreachable!()` (i.e. without arguments) calls that new function
> instead of `core::panicking::panic`, which is already in the list.
>
> The same change introduced the equivalent `noreturn` functions for
> `panic!()`, `todo!()` and `unimplemented!()`, which lead to the same
> warning when those are used:
>
>     core::panicking::panic_default_msg
>     core::panicking::todo_default_msg
>     core::panicking::unimplemented_default_msg
>
> Thus add the mangled ones to the list so that `objtool` knows they are
> actually `noreturn`.
>
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>
> Cc: stable@vger.kernel.org # 6.12.x (Rust is pinned in older LTSs)
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://github.com/rust-lang/rust/pull/163766 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel
