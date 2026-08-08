Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7B37C11E
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218064; cv=pass; b=UrXxZwR7AgHe0QaOUutU+ZJyeOeKQ18rd+k7nP5wBak2xr0QT4D8jbdChOqix0nOuPOlScVEgT/Pl1yXYWJZKL3fI0eVNTblPFr64xOlemdx5cChdJJ3uFk0J8g2Zwh5QeDa21QiGq2w+rFv+0RQSFbYha+lQkUAeRsMpX83OaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218064; c=relaxed/simple;
	bh=WKjEzMmiO0snanv+t+uNfhShpP5xYF0n9oP12NeJ3Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRKtAtfi0Eds+pxhyrfFotq1FQ0R8iHM/ly0evdcvCg6MmEa0Zywk6QkxLiDiuYYDKeHYSWlhQe5TnABa2pThhMfom5E0rznL0UhggAq0I2eYoKPz4/GNBvlCoHV5reSBPe1XDHEzcyrFp99Zg0kAjMhOahWtiVkvI73wqw5kQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6DH8DbX; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6DH8DbX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38f0f3c8da5so174006a91.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 12:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786218063; cv=none;
        d=google.com; s=arc-20260327;
        b=CiJ0WF+gSM4GBUFqikjuF0IJFK24sarRlufX4pHkNHaLajkeZTZDb8IyTUWcaSKKQU
         V/Ji3vESgDNhzvB7FNiBpFKQmFW1yaYphuK8tnhesMSEh1MA+xY0s2VvJZBRY5Kgkw2W
         ByqDGahz3IhhfjEJoYFyMI5YyP1zCZmj2SVvhZinl3z9aco8F4JkFcLzEh62H1+NkfxA
         TgnD/V3AdLP5RObSPz7x0UNCBfYdUvgZ1lI+2W0Zq72u71pwdQo+4Ew65BzL7UlXkLTf
         mACw78KLBOf9rnkugxIsTJx3VuyIffW3PAYf3mVdSiu8YskrtOr2+JDsIuAMWOP4Nd2r
         BLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKjEzMmiO0snanv+t+uNfhShpP5xYF0n9oP12NeJ3Ok=;
        fh=ZCnjgQYwOoJAbLPp2fBJ7L0hGRTEGvqiBuaF0avQPiM=;
        b=nskba2sMP2SHXbHKf5AtR16eVEOBG2OnOTDlnq1iLElsxT+32lmxGEmcDgj/nk/rby
         cOdSH6Rot9M5uonMcZmUep6whuahawYoVo/riPc7JHCMcHK4h8mRA+Hm+XZNb2t71KV/
         G7JliG0MIuy0c0liRAZtrhKksNyqtrA3J0lwJP4/zqe5FdCFtMPwBPCrLt6Dsy00O3pY
         dD9ifKvJmF3o78vU4lP4rgTRH2pjRO94mtGj9VR5PGkXVrkc/qkuQVu9JjDEgwMtv/3P
         5XbygxT4hgB4iMWKRYQwM2dT9h7E7LeZVVqhQFs8iHN/ZZH8NDUfLzqTx/UXIzKie+hb
         3FTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786218063; x=1786822863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WKjEzMmiO0snanv+t+uNfhShpP5xYF0n9oP12NeJ3Ok=;
        b=E6DH8DbXJTnsA8sMpBXpJFyAkHo19ttNbSqPD4Qe8pfC9A2tNTrW45K2oX21xwM1Qo
         8stpdolNIvag36gfd18JmCoDEIBWBT9d0mt9ipPSVVnQBZSf4vwfzHkg6HRFFbVtv7QY
         yr+lVXVLLjVlzBAY3RVIowdZ1I6nuDNimvnyquueimAG1uXRrjdvbKPbvHKhYkaYXB9O
         8qDIairIbCZubVtfoYK23IE+OzHahEWB4KTNUdmWpbA7QY6LcUbeIwoeahluTOjQcvfu
         dDTE38RjD4GNgIZ+y34Ws5V0l7ibRNwY5xRuK+H0ChydzrWHfiVpw26IXarDgHfGhAB5
         clYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786218063; x=1786822863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKjEzMmiO0snanv+t+uNfhShpP5xYF0n9oP12NeJ3Ok=;
        b=bIjv+3QYK8OOkDJ7BFxR/QbiutLygW5YpBERH97Q10W8RokhraVB6bkrsn7TpWlrE7
         uRr8tuPjtbmXG/qspJZPpe7hC10eFspsSeZaqiLiMcgiYlngcYq3sjyqEOl5C839ryIz
         7zSzqFN/VCxzvPEp2JTOFgFhhe8pkj2+YJazgdV1DXUyxWvottYmQx5SxTOwF6f5XRg8
         S6VM7cLi8vcW7ySQ16AuNxYk3TNfnv0gM74ortqfcATphbnOHQCWr9trFWLZpZXK2y0A
         ZQJV+ggwfwMESizfcjt6l/Sgv5weWN49f8YQS+q0QOlmVDSJ1GkrPUq6JA8tE5qwOWsf
         cxAw==
X-Forwarded-Encrypted: i=1; AHgh+RrYSglDrDKJ2zMorEZem3K6jXMt4N36GiQkHlvAmRqz7EmV86SNr4mVDCw/POtpzNdTbybOCuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdWgmla9u34rf+bVM946M1EZ+qADJFF4OXMQQ7sTHOD/fVFqc
	s25w/h2NfIIqKB3O5KEcsoETUvhiL4rvl4Gcc5x+EriH92Q8mManqvXwdThPYvSmq9Da0jlKj7C
	rpIklJsBh6IOkrDgZwjTC85ZKS5jn3EQ=
X-Gm-Gg: AR+sD12iE3Xvbnb2jGMIKle4WXzgQP/W93VbkINSUfVJOVFhp6a2qvybjJXOlSmkRdo
	Tj9+BRI8dcQMTOGY1fISBMpivmmclaJ0R4abU1fKbgA2uqBKNBg80TsoEn+/yD7Oa6iJRtSyrQ4
	RpKAlckWby5zcyQZWfzTlzRi3e3iDOGO4GUBL+D0e2JCZ3isNjsOjZ89KL4K4dctrAMNbCIK1ae
	0CcmVKDJ4tpFNFyZ4uR0zyKWJSvc9COCGpRjW7EV7+ZpHt5fPOiuzz7+g/iBI1EDgfzROhMTJ/E
	kR3/Jqf7xHHd6FpUpvJOq2umpY7BVdEiN8kMHeNU4Cr8NA4RMjDGcDO6kGi3TR70YG8m0q76u0s
	mUMFtuvrVXMl5IVgRpygXcZgyKxFZAxQNx+wgKQ8uukN3gEJcYbhfTSPpalHz
X-Received: by 2002:a17:902:ec8a:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d0ca1658f2mr275615635ad.0.1786218062739; Sat, 08 Aug 2026
 12:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807221429.155946-1-ojeda@kernel.org> <20260808.074341.1056015191905819805.tomo@flapping.org>
 <CANiq72n4=fz=JNKY0Jdm8BnLa=RmHB2B7s0bO47YTJ7hygqBZg@mail.gmail.com> <20260808.143013.1251068388254615351.tomo@flapping.org>
In-Reply-To: <20260808.143013.1251068388254615351.tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Aug 2026 21:40:49 +0200
X-Gm-Features: AUfX_myY729uYjJW5IhCmENfsQg8ijuPS9VLtcEZjSqkZiEXciXEvujLP3Jq8gQ
Message-ID: <CANiq72m70uWCRFnhs3axdymSTGCirBrYAvKh2BiT0xqW2j_3jg@mail.gmail.com>
Subject: Re: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, arnd@arndb.de, krzk@kernel.org, 
	alexandre.belloni@bootlin.com, linusw@kernel.org, chenhuacai@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, fustini@kernel.org, 
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, kernel@xen0n.name, 
	loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 7:30=E2=80=AFAM FUJITA Tomonori <tomo@flapping.org> =
wrote:
>
> Is this the one you saw?

Yeah, exactly.

> I posted a `cfg(testlib)` split for it:
>
> https://lore.kernel.org/all/20260808022608.1125174-1-tomo@flapping.org/

Thanks! It seems good to me.

> While at it, a question: what is `rusttest` meant to cover when
> `ARCH=3D` is not the host's?

`rusttest` is meant to run tests on the host, regardless of the target.

There aren't many tests there nowadays, since most of them moved to
the actual kernel when we got support for that, but we can still do
there things like testing proc macros.

We could also use it for more things in the future, perhaps...

Cheers,
Miguel
