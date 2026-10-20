Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792539548;
	b=4hrzwlGpV4juSMMtFTkm38AQpd6Qk6PJc5iXtAVZ/eB7W46NKXJFZ8O7aerwyGF3sw7b
	 PHsjag04YeHAPh1oYX2CI3Z2I+ShOeZchg7eOmC60MXrsiwrZHQhGZifQDs74WL6jwfeK
	 Nw3qSogPHqQP/SHrANUkCPk8SReBwI6AdKzHCT2lSI4YnjMfNyx15HTc6d5PrRGthSoyh
	 lf9J1apT3y2DFzbBFbOZmacCZLbjGSAiIeINSA0LOgXOzv2iluEVP15wG74I1T+9TCcsI
	 XX5VLx3aX/ZDyng+ENpSKisnrke9LkSrfSZYGjTsLbhABs8tdBhc5KdsrFBI1paNcFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0QsbV+4eS5sDEhfqWeQ1tQuP/vIQExpdlAmYVuAUHhs=;
	b=LBv5nnUmmQm4zrUNmC0iW528mj23y/sX9O4i8Qf9ML2qut4bI445WX767jPbxxrwQdJM
	 ncI9yziqb+RcQfe6ykQNQ0fok/ZRLsmHJzl9IiOxk4uKpvGDbcZWUN5pxRRL58RPzqBbE
	 28jS7mwJaD1df3OOs4J5AR2nlcWj5z1UHyy4Frf6GVoY+A+bH+ikYGsATam+dfnvo0HY5
	 OnfZXp5eyc+81ZFqrQqmCWxOWWbpej8iZNJDPGksY4krM1RJHzEONs3fK9utVji1NZR8t
	 O3G/YC3371V+xdSi8s/IRSCyxD9WvWNjOKx3UvTaHclAE+6QWYzFR8LzBYcCUXu1ykw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hIfeR7ek;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC38606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 23:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC38606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hIfeR7ek
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35159e0092aso14431eec.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792539548; cv=none;
        d=google.com; s=arc-20260327;
        b=ObIF6QqabfOHLzGGvjfePpyQFYA/ptzjTeAUFftnqrgAjuxUPKpflhE4TBB9nOr4BN
         gagrwHggBBcU6ZybPlMdGPH+hdmYROQumu9dj+pyXqmSfmU4d2zE3E+aSHBGlfs+axVu
         oC+eWV6H1qV3QkfAHRsoS5CtLwViZzgUbKlazGgRfXm0oLWONL6kFkUl4R0wRTUID0bV
         NtB+7K/Fr9oBOovoTd/uoSrTx71L+ahlu7zU5pqIVArA5OCQx3Zn9A/uxfDQsXEA0crV
         dvtWOJ13gZdAgB9UE8cJV/42jdwcVtb5rtRwV3wZCZ71a5JT7dEcLF0DZZXHoBmSqD47
         x28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0QsbV+4eS5sDEhfqWeQ1tQuP/vIQExpdlAmYVuAUHhs=;
        fh=sxO+HAxOuUe1ChzmWg0iIAqrd6SvkrWE11hqOAjZrC0=;
        b=OrLb2iIyeietjf5AV4Pgho9G6QcrCMDr8ywhHWuaKut3ktHzZBorVhTMALI2mn3PDE
         fA+qIcIK+mwxqv60kWgVGouMaMdgCZkeN5HVkiTAFprJ5X3w1hFQqoqw8DwEGH1hUO/e
         vlDcaO1g/NGLzF/5uN1vP6ayq8PLKON7xXaOaUqaCpfj1otkwtNihVjfdAkushw2S8pW
         IARWEbRWk5dDZeP3eV2+8tGP5xBJ1WJrFW3ZhisbnsmHPsTNALW5w5RHFwv9+0sxpQeM
         9M4K6UrBXE2uhVBTgFFc9OcDvErtAOjuVKpTn4oTG7uuAysNzrfWHF6QR3iL7qF4YrXF
         w3ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792539548; x=1793144348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0QsbV+4eS5sDEhfqWeQ1tQuP/vIQExpdlAmYVuAUHhs=;
        b=hIfeR7eko7mYwPUSSYNG76Jw1jM5Rf5GMf8HvzVDyJDFldyrw/5Q0O0MBXeqNWYcrI
         NRVNT468KlBZIEwn1GByUSToEzMQgRiSsApmz/sjdu37KaEH7jcjTEj3zntFGiJLY+m2
         CBePTmAuZ4PqoA9HZqM3ccV/ouerEa9LygyMy4pjYyH7OzJiNHm0b4EfrHrI66rOuVAi
         soyawgK4BX6PXtzXjARtbd4cF/KRc2KaKFnSHAIkm1fIXMysmGzfOgdyurnjX8JphMIW
         jw8h95fbE2O/s3CzSXMWavSIFJ/ccuq9hZ/5gc8vaSWxjwiOSK/UIk6tvPiUF0fhgDa6
         589Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539548; x=1793144348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QsbV+4eS5sDEhfqWeQ1tQuP/vIQExpdlAmYVuAUHhs=;
        b=TaTKbArMuHj9b/fAjI2axy2DcuOdVdapX9Aedj+QBMiS9FgEWARL/wqHqDzDLdauJF
         O1bF5sX0DzAZRigjZZp6wUYCGrNKtPbBnhNmuLs+iABeDeV8IDQTj5Tzbdf7Hpf0bD6p
         1VsnCKObORL4FvqicT1/knBWTvy1wQiw5Pmk4vOnTscRL4X1VQlFNriXMBpTFg7cCTw2
         gyKf8h+h2xb9kTY4VOrPrJQVEBrGwdnUZ6Wl17puPSiPKuHL4HIcybb5lP3OOFmc50ri
         389i4ijBiGD/Qz5eIkuVBZyXebYJUdnFRJOwaqumHNps3Seq0tb762OeC1yM2kbwHBM2
         nCoQ==
X-Forwarded-Encrypted: i=1; AKwUvBy90D9UVCleSKrf+32DA096Fz/NX4Y70m7kJ7Y2YDKEvSSzWRVAZODPclvEAO9W4vWv9uERLgI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK2xeXZccTG7Q3RuZfV3zrup3r/0GnOiPqxSkz1lBWlQdjdTL8
	8e9LEfyVotDkzSHv3BP5Wr5PK8KT0zIGH0/unOd1C0p2B2/mfyweynQZAdNRdc3s7SbIKLsMAn5
	VqLZA6uD2nAi2IN8fBDCn8fAeVKDL8So=
X-Gm-Gg: AYBFou0lDRJtQHiIq3XJJy4+fnVnMidoZpVRUr1cD0mpE8fsOsQlTpiepI2Zk7Vt0OU
	rSTUAfTmYY51nR3qa+SUiX9dagTaN9C52hqiZGIOK5fckZkSunHwyXDrEBibarir9j3qb8ScAHE
	JuJj1OOIj2xzONjDzKQXem/Vi1bLCvwsz8//bfvhsYhGPvWQR0lo/d9+jPTwBmyF4PrIIKcfuTS
	QM0KttT6w7LhHJ8HpTpBIAaa6ca6GCpZDUyY2tgnh+epgTIyQMymUHG81QAl4o+Zj71ieLMspMI
	R7o0yzBbB5FipxdLrvIFW4YDij4ZmrLsSCd56Yq5xFLcMMwBjE7WZfz0tYhJO8xyu219vGweNE+
	QYx7Ye71MNPnTcDDMWzHDJyjQ8SJdnfSzxyATFYlzkGPzImp2/urdqI3uLp/A8pN5C3oF+wo6rP
	M8cHKvEsADr7hYhwFzE2nNb8FJpe/tZpK7ENqNhHC3ekqa1ODk/JY=
X-Received: by 2002:a05:7301:18a5:b0:35c:492b:e310 with SMTP id
 5a478bee46e88-3674866f609mr1510231eec.0.1792539547565; Tue, 20 Oct 2026
 16:39:07 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018131313.59391-1-ojeda@kernel.org>
In-Reply-To: <20261018131313.59391-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Oct 2026 01:38:53 +0200
X-Gm-Features: AclHuK8yYamw4gnf0-K8VwIxz8gbaA14LOonPBIXFXHfecsWiw-2OkqdsYTLYA8
Message-ID: <CANiq72mJs3=z86wp2kNLJv1iUOiqxWnGt2KDhnwrwOCSkOUY1A@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function for
 Rust 1.101.0
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

On Sun, Oct 18, 2026 at 3:13=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.101.0 (expected 2026-12-24), `objtool` may report:
>
>     rust/kernel.o: warning: objtool: _R..._4core6result13unwrap_failed...=
()
>     falls through to next function _R..._4core6result13unwrap_failed...()
>
> (and others) due to calls to the `noreturn` symbol:
>
>     core::result::unwrap_failed::unwrap_failed_inner
>
> Rust introduced this helper when making `unwrap_failed` generic [1]. The
> existing entry for `unwrap_failed` does not match the new helper.
>
> Thus add the mangled one to the list so that `objtool` knows it is
> actually `noreturn`.
>
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Assisted-by: LLM
> Link: https://github.com/rust-lang/rust/pull/164059 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- tags still welcome!

Cheers,
Miguel
