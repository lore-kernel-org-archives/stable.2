Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2B1FF7C7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737049; cv=pass; b=Cp29OO48JSyPFzVZE7ilyQHTY5bQ3Loki0z53kudx/3oohdtLdSbbg24V0siwoeR4Az8CanarTS6rAYMGFeTvMRZbEY6IT/VLr37VXmCmBBjM+0v2tFZRLxUM3yKaPOqA15mPmFo5+acmwbnYibUDuL75fuX6iux3Ae85jWDtcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737049; c=relaxed/simple;
	bh=Vud7PaT1VUqc41R/KxUTZRAgv7I11MadSnh5c1uI3AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFUz2aI1ZucV7W6xvQk5FRMAznqn+W5xj3I/nM/wjccuE+hjw8B5c8ZpNA/FkRODjEYAzJ8gPPJpaZo4jiG7IWvsLMf5hl3qTaTSA+o7jd2n0E0EOA5oJazzKAThQeObn8sleENXJKZic2jrFzlU1RjgbixcFpwRwknnAwdlr5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryWcCX8e; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryWcCX8e"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc8311c6ddso1693205ad.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 23:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785737047; cv=none;
        d=google.com; s=arc-20260327;
        b=TOH7IsEmsCKsjlrPoqcIag1alycH0alnED4tg6ZUAQaoNRaNxOyulpqV/gEZxN+wgu
         OFdPDESeVJ8wnuAp2FPEzzjBlaa4YO0GwJwFIRQ9ClRfQ4+vqBcNL5As1PuQSrr6ILVj
         /wVk8lTq6FXkdTQNaxSLl5JZtgYMHZDJX2WFe1J7sxMCxcu9i8t/BiwZ5KvgYJcARvXf
         N8w4VjR4+KxaegSKfUvpLe5cMuNX0QXkb26L1VsC1YZCKEz1C4rh6PsS/TqvyM5V5Qou
         hsQ72yedVXpKV0RTiq4Jp9llulvA8Lsb6PdhtoRRdfuXIo0eCSuFejSvQJgdiPrga4L8
         w4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=opkoRNulYp+bLHD2LANAtEBVTpeSMM/+YetLJXty+YI=;
        fh=uYCztzemtpIc1/Qq3QihI6Yg5hw4E3cMZklXMjWhgEU=;
        b=Pu35uGnRYHUWw/5rwt6b7XE8tqCKH3FyzrUrxEj5A1X/xCnq77CaBXxboSxE09OzsQ
         RcVBAbul9vQyc2X2PILypHZOhSyq1HXcsmUOLOCMIT/pGZLhQXqcTNGLrl5BcJuXZYZI
         ZmneYK7ZDKhHOegyO9XjpZvWU0rrwqXbs5NHpcUhcoySlfC56QC2nP3F6J8DSfCsI6te
         uXCgaHPqTOGDsYCMa5+5Lymj+iy/mPkCHdlHelBt6EVLqO5Xh/GZN40YnTpaQrJJRF6O
         YWUCLf9P7VRK/+rQJr95eLpVDMY7oH1CUP+SRz0pgV+6+Qy1qMWE109XRRC7Tu4Prkzz
         nQ6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785737047; x=1786341847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opkoRNulYp+bLHD2LANAtEBVTpeSMM/+YetLJXty+YI=;
        b=ryWcCX8etwfle55J6LMW3x5DLJ0bqNdZwfp2AyIjVPKTMKMv7010scEBBPZzGjh3rW
         bE+8dfeokNHoohaO0bC3o8NeNcLUhHtDb2QfYbsuGzneEEEhwd6Hiq6gnctBW0jycxOx
         +B75CU1sT49FA301mgEfnEdYEsFeNoEaS56hXxTvcJBxt3+7fVN1WY45eCVR2D3Vq0S5
         T+xwK/Qmk4duOcjgHeFxOlBUgVkaLcXn7jq/ko6oKVSZhicTJi3PompXXzpVhi33PWRH
         q7kKhffe+s8mQSEIFMHEUKiJ/GxHvhqZZ8TZTezLVKisfBnfPmYeAf0LkJN5p/JTzM1L
         vp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737047; x=1786341847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opkoRNulYp+bLHD2LANAtEBVTpeSMM/+YetLJXty+YI=;
        b=YWtbnVCsgJJZW6liKr60mEq6u6ckBoXkPAjODe0ONMFuZURo0uYQFyVJnrPNCWrO9G
         vHNp04tbXbgzbcdpUB6B0vx8V/YmiarbRT+m3X8ZeLovdfIjAZ5wV+9VfP/EqGfYJ5t1
         dAaMQ7Z3L9LEhK1Mq2AtX3Q/LekmzCQhVOStyLyYpCBzqpvh1CYjEAzS+7p4PToPuWzh
         7/yZ7kjzr0LpQI67QG/KJTxUtKSp4sVT5JGiBgBsiaQj0XdN0R/CqXhxMALQMoEGdYc0
         a5vJEvnaQjafxTfCbjdh3xfPIc28lS1HIR3vlKXoY/uMDriZ3NLESccto07BeoVDztC4
         S5qA==
X-Forwarded-Encrypted: i=1; AHgh+RrxtJDwMBTMzvHdrFV2vxU8CfnpmMhqNaes5dElOV2Z/DH5EM6w+6plUGbsuUbh1I/s1G1bCgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SJHGsKEfG9FQ7HZQTbe0iF5P7voaNv58019N0xYeZ/Q5/pzw
	YRNBm/rPqX9jLgeuJfkvrlsbW/SSln41J37xOoQNpvJO2XyMcsBoNTUggiH7OcDogblZeayfrQ6
	O98B+re6dVaioRuzmKNTKu7I4FUL8p4M=
X-Gm-Gg: AR+sD108iZj5AO905AzNsPIh/s9ZPIwfPzxIm4nblkuFElSlfKRowOzy49hlcpcCH75
	mDglrvQjTtWCXsmb3W3yOhotxnl71lKhi190wZk0p7Rge9pD1evBaVmWgTXM6KNTucfzMuxqtuc
	SkgAI51qUTL06Bvk42j6zN0nVsvenFEXFPizI4sQM3QL14GnO4ICYihA0wZ62f9+CkNg6G+l4G1
	2HMn9w89Ob+e1po7cTiYyzGNecJz6OPWRJ14gVq0rNoANDOD16G0mqzEPN693GiNlw+H5fAdiQ4
	+PUaiqQKf4ldvOf09ac4jVwnbDtU4Nx8XZrOK77jQS7AGozEyCD87tY2WjpTZOomVg3CQ6avfC1
	0AYv8XtcN8/6zIXqp31XJFNMCxbcuUg17rFHLkrWdwwjY0ZnlTeYrvUBinIqG
X-Received: by 2002:a17:903:2f8d:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d052064a84mr115238245ad.0.1785737047606; Sun, 02 Aug 2026
 23:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728191448.349241-1-ojeda@kernel.org>
In-Reply-To: <20260728191448.349241-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Aug 2026 08:03:54 +0200
X-Gm-Features: AUfX_mxqcdfWM3aLdK2D68JD6cYnTf-Oa20VFAYdnXMbU0EIgzsttXPt-hp0GA0
Message-ID: <CANiq72mLq4B530DKYf=tnb4zvaKQx_zVWRBY2+ARDwxMn64iNQ@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function for
 Rust 1.99.0
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

On Tue, Jul 28, 2026 at 9:15=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.99.0 (expected 2026-10-01), `objtool` may report:
>
>     rust/kernel.o: warning: objtool: _R..._6kernel3str9parse_intaNtNtB2_7=
private12FromStrRadix14from_str_radix()
>     falls through to next function _R..._6kernel3str9parse_intaNtNtB2_7pr=
ivate12FromStrRadix16from_u64_negated()
>
> due to calls to the `noreturn` symbol:
>
>     core::num::from_ascii_bytes_radix_panic
>
> The function was renamed from `from_ascii_radix_panic` [1], which is
> already in the list.
>
> Thus add the new one to the list so that `objtool` knows it is actually
> `noreturn`.
>
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://github.com/rust-lang/rust/pull/159554 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel
