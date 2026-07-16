Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AB33262B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204299; cv=pass; b=ddDQyfoaIEnGjWh5708SmeFjjSfFUyDcsTw1dk1fiSU7opbS11CSF9IEQhgtL9ar48uW8/MymPzjCGLiloKJt1JiBSfx5wwvN6Adboq4KOyKnpesL7mf5a0PFA2W3SD4QnHmHquh3NLLNsv+PzCt+QzJHxTDoJpxZPcsIgTvbcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204299; c=relaxed/simple;
	bh=qeCZE0Y3mr/J0JsfPOHL/DiAQ1YvkRmztyR1MwtxFq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Flm5y5/xDlzk9qyqmEwYSD4XHxyWDHR3J0cB3jtstO8QvCWhKHA0pZvYj3b4OhjUCOqDW/5jhpzdGIX/JMT0tve4+9L+Fe0mFfaEowLOL4d3tLsqhuaDYzLNZTkcq2ejO8j12b/8A1v2IfYvjm1d6eCSYqMpdOcsbSfKvWquWqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHbCgSVA; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHbCgSVA"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca6d9c91206so543663a12.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 05:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784204293; cv=none;
        d=google.com; s=arc-20260327;
        b=gWXNt/Wea/ak/kra/cOJX4u4fzhobitE9tq5uhlclKHxN151mt+pXB/1g1e0offuHH
         PYdg0qDv/k0lnOGfbtaJ5+GvCCcpZebSXyGycGyLrm57Q+Sg9itDufo5CnS/+y2tPLGn
         bw+EmAYyiq8RvCeW+bHwd7J5p+gXop7+uGc2b4hyvodaSQl4MA1LupvrQOECPX+Qfp/u
         jydpmuZXDvQoVbQpw9HWrY9T/U59CtH/f102ByVpf/SDIxoCWe7krIoa+0hMTQ6UWUk4
         Wp0PAqonvuG+lud65MmajsBcIMbQJzaTNnwWzYSOO2rjuWp9sC+q8Yum51oxLpevr2Xd
         ZBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c918aQ7k7uX1GyNkZQnbAfatOcsaumnLiScuoFWDMmw=;
        fh=GVIeFBi1oar/IXyenBJlH8vDKZjb5Ry8bfq5znFZ+Xo=;
        b=UbzDRVmtZEKozpJuFbatyf4n3qA531gBsHlu6FTs0CGFwmTx2w3wxD8x45m1WMFIE4
         /lL1YdupbNNHp3TsFHaruHbVOefW5wpm3hzJa/ACTOewwudMohmjBLr669lJmzm2mAHN
         Tz3T/086jrnwqkoTypXsOjEC0kwcyJw1RCRMUAWIUCt80LjvzAKbYiWNM/uZneI4qwFb
         RgwlL5jW4NBZf7X422AFWD1Lt05/XPjD2V9+BfYXxSxOw3DKUDqqFW+aKuGQ5tVWpAYP
         Jie5/0Ul/UIFca8p5/HEfAQUEs7Js6cUjCEfc5C8of7uRLX2F6pXafXjLv5pFYNok9kL
         Ds4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784204293; x=1784809093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c918aQ7k7uX1GyNkZQnbAfatOcsaumnLiScuoFWDMmw=;
        b=ZHbCgSVAJRrVDroM61OXejFv+TyuGWsK1WmjIl4p8ZcpGbCui6F/ZrCZGkA79NPPsx
         CJoI5KgS+ERcRu5tQoDdC4j7ng54hQkmg0wzqIqkdAp10iFVBPSLUU1+Ab/+vNolC1Kq
         rE75g9sgxJqMTiT/wF3GG7+UQJaAmlpaSACExKryBiBNX17/7ukvn2H/Vc90Fd6ERqqR
         MCTRo1ermQcG004GyEEjuE5rg3cG6YHQGFJNFKE01+OEqpoAygK/TZX9AePm2IZy1Lx8
         nYCsq2UmLJ9pczZuNE7hSVtR4DA9uUhyrXvJkBJiTskVpTEbgl9XPAp2JEtrNRehtK0o
         SiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204293; x=1784809093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c918aQ7k7uX1GyNkZQnbAfatOcsaumnLiScuoFWDMmw=;
        b=sv8cx18SE37qOtOzEK8NY9pdHhCj5PflGQbe2oFeAo/g21NqQ5XuVsBi3URUH1dseg
         vuf5hm8rJ1nFtM6GFjCP8UPnHPETgWPHQ0YzikFFBhmWGb8L2fwhHfPPsLb2lXo/oxi4
         Yo/8TW3qWkGSy5PrTIPCCHaSVzw5noRgSav4AC5fqTql4iTL3P3bjqvbODhZBBxJH1yK
         VMma9vJ/7d85y259IAsoURCZZL3PpEfrKehkAte9TBuBKdNfexcXKVtNOedJIT3nDo2K
         S/EIN2sCD1iVHRJb29usJ4SJ4zslknw/xFu89rm9jILUOXl2I+8GiSz52JtdwwiNgbHP
         cIRg==
X-Forwarded-Encrypted: i=1; AHgh+RqbRRDeE+kO1cOCTLuEV4R+/ApXkLP2b19M8n1WXB4yj/6TGN+Xtuco6hb2DaIWMjFNe2c+ukk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxEElT80q0cVZisnBEcaszLBvS8YUph8J78Bm9LVqGCiEmV18
	p6Ua8WUW0nZGGW2RwdfLGQ6YP6eaojJU0WSVR90J0B23fd0xYQMwDUow7Fnto9AiiX2sb7M3tqy
	Zpt+6Wb2WhWLTSJRVEaF4wZV/A2YaCk4=
X-Gm-Gg: AfdE7cn1tyRc7lGKOLlHL7yVLkb5qM7GwgQF/Er5k+4l8EOwSM922v7k0W9GYXnZxvz
	O9Ea1VZg2pEVvmz49dit/khUMAKn1B77ZjaFcI9zxqhpjYq0ec6ij+EB1HapgpZ1z24BLidKQx5
	zHAGhipXx6vOjkfL9ou3FR0n5df9DQRT1fN+AWaxORP1DJ/IiMJXWWWKpYk/q3bjY3HRxeiSYCm
	sIQhnz4kRMyGIR8d27iTBatoD6txCEhh5seXYKj71Q5/uONqnyVBeVUKtOEXP+p6fIOgrHpRjiu
	b4TtqKFkno2UZ34DKnu7GuD/b9W6OF1Yp2JjvZSTWZTyUeXj3F16YpMZUGnh5C61RqTy4WvPE9y
	ApQ==
X-Received: by 2002:a17:90b:4c0f:b0:37d:f70f:fbf8 with SMTP id
 98e67ed59e1d1-38dc76069b8mr14068130a91.0.1784204292951; Thu, 16 Jul 2026
 05:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
In-Reply-To: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jul 2026 14:17:59 +0200
X-Gm-Features: AUfX_myevnsR5Su-h4NLGTu3-mxvvsCDC3uCj12Aik5QGhF3XPcyxIyrYw2aShM
Message-ID: <CANiq72n3BYGfB9VvLk4-bBQzGy9YhDxFvCrjkjJqBbcJa5YRYw@mail.gmail.com>
Subject: Re: [PATCH] rust: device: avoid trailing ; in printing macros
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 12:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> These macros are used like expressions, so they should must not emit a
> semicolon. This is being turned into a hard error in a future release of
> Rust.
>
> error: trailing semicolon in macro used in expression position
>   --> drivers/gpu/nova-core/firmware/fsp.rs:79:34
>    |
> 79 |                 .inspect_err(|_| dev_err!(dev, "FMC firmware missing=
 '{}' section\n", name))
>    |                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^
>    |
>    =3D warning: this was previously accepted by the compiler but is being=
 phased out; it will become a hard error in a future release!
>    =3D note: for more information, see issue #79813 <https://github.com/r=
ust-lang/rust/issues/79813>
>    =3D note: this error originates in the macro `dev_err` (in Nightly bui=
lds, run with -Z macro-backtrace for more info)
>
> Cc: stable@vger.kernel.org
> Fixes: 5c7ca6fa603f ("rust: add `dev_*` print macros.")
> Link: https://github.com/rust-lang/rust/issues/79813
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I was doubly surprised since upstream made it a warning by default a
long time ago, and yet we didn't see it; and since I hadn't seen in my
CI even yesterday.

It turns out this just landed into today's nightly:

Link: https://github.com/rust-lang/rust/pull/159222

  The semicolon_in_expressions_from_macros lint previously
  suppressed warnings about non-local macros. This masks
  a lint that will subsequently become a hard error.

So that explains it. And this is the one that will make it a hard error:

Link: https://github.com/rust-lang/rust/pull/159218

Ok, I will land this into `rust-fixes` then, and send the PR during
the weekend after tomorrow's -next.

Cheers,
Miguel
