Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A524252CD
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600581; cv=pass; b=TySuJw7P6fZL3xl1T727Ll9xNAh8JzDPMXscSD0khkBEzSh+miGuh2kLU3xiLlxeyaTw9QHrxgG+Co8XNXQqJTBjx2yS+dhVH6lkO1gXKtQyNFaTIRkswF62Ck0b40+5Itnor+5fuy7ToOObPvsATOEgmYXv3Gk6O8tJopW5SQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600581; c=relaxed/simple;
	bh=EZnIMhyxq8/WSozIlMLiElkIfQ8ZrBt9dufg8sJD6BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaeonioklplFr++ysnppIQgW6R1ir7NUT0Xy9XHZIpcLnJSRIh1hdiqXkk81IEhJcD+tQE+WakLnqW3EdmZRXVg+dnMzOcVlCBHDxwgUj7HZns3TbwwAfEprGk1WnqUbOWjV8DbVdebVma9P94WE3mzeBHKVlkZ9vRpxnW+h5N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqUoteW0; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqUoteW0"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384caf7b168so277473a91.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 05:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600579; cv=none;
        d=google.com; s=arc-20260327;
        b=pZS+ZjOEfDqbUAUyUsvAILNIM1602OMu8X+hb01WNLXHNWOGmOhr/wytoq3qpb2C13
         BtcglHAF3Y7pg1QB0Ph9nml/hfBul6d/Zlh+t8aj37KYzQAJXAkXvIApP1oRGUncjLem
         2TeVsvG/m/B83ovtRwFoS4lDHzeujdkDB5grISAb+sYD6MmFqgTrZ9kPl0z7qmhAlCJD
         nIbF0Lq5VwHqVkvptM/bkweTiv1VTA6LoWSkZZbQTGNl1pOUJh7Bq2rh3RYhg7bCWFiA
         Cpn9QbRNawFXdJmc78QJkvbdbveTZMZiFtkQqbYf1fbYAz4kHoQu9RqOxyL2rstopULC
         gDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GmE0JTCOruYKrZQM4jbbugvhQ7RQl6mUUTUdc9aMHs0=;
        fh=Jir3LQpY6i66iG/1s572nKjoogwXHEqEYGF7Xc4oq1M=;
        b=Gn3/oEVe+eoXW9h8TulBamiGah+uHRg/ECv+wUWPKzhF7SDZgDNK5olGCsTlaHYHh3
         u8mSYlia3a0N79V0Ud3JcKV/wFkHABYTdNPnsKmG8ZqAGOSMyMT5U33Y87CFPuuxeNdP
         mNeclaHfGQpWw+WpqNFj5TbIZ2pwZXZ6ScJeEXGmeQ7F8O0RuqCwSHA+HRy/MZt/pV6F
         NmP+ABHRaSIjTqEtzx6qA4OyVeziy20MV3Mn1owsJkJvzQHsblWRxwcNTax0EkPx9sCx
         dzySDJfmJ0tTGBK+2cvO4bJh39YdodjwJkZJdbntwUO9Tr5Ui1o4Vt0dO0JWupkbnPKL
         1zEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600579; x=1784205379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmE0JTCOruYKrZQM4jbbugvhQ7RQl6mUUTUdc9aMHs0=;
        b=DqUoteW0yXh0DPAGBkdeFetSnFI5NlI2hib0zEK+cTY1WCusqUaohlx7lQfG1YLyGR
         disNP7ugJ4w2QdA0Ijf/bajJ+zH6K5UDHHnbl0FxVcuwU+yHRa/AgKO3xFdadNKCoOgt
         c2pqpi1Y0gYrde7FZilUSdESVMsZis6uLXdG1lNzieBslIFBGxn0EkWcGT7a/w0hPNLO
         HS8GzZWiK2of1kUfH2flzgoIi+dk2EONeCERDp1bccf0DnA+zk6bgrjKWdnl0edcna+L
         ddJL9Q0Lp08lIeCNuqjdBcuaWwNOe6eXrJEMAdu7V8SWPL5UGCcvjDY96pVfF75NPvgG
         NYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600579; x=1784205379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmE0JTCOruYKrZQM4jbbugvhQ7RQl6mUUTUdc9aMHs0=;
        b=Gnp9EVngG7goYqP5vV3wPQzGZVi7ZUb8WS+WKC5T8oXJyfKMgkWRUc40cA/VZKiiB6
         uGl8C22FDKhwffRhtBqrBG9XqmcwpBz0g7Lt56zCrNvRX7XWgey8HoeD+4LNYrUIWGVy
         zupmcgndc+6u8v8eXj+upRWBgatduYmKniTePOjAoIvv18nNoyVBBrWDIFbqj69Afodt
         EXvjgngQn38ayGiCH4PPUjHx7KLiiuodAUhG1/GOQtCn3oiOyALa4KdrU6myNDkOCw/C
         zI5RP9u3DVE+/p3rogVOp99aZzyMiMUqoeBxG/yLVHG0W8NZPK8UvfyPee0tmVbl39Jf
         6dpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJuw6iaGiSghJ6MNKY/RbIUTn6UUc96i9KPuJzO5X9Q4eGEqnD9bL3m3Hlhoph+i+KNjVpPTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcv8ll3BI+xdmWr7AeItJ7fjRXi50Ovsn9EDWnJhwQcvI6TFzT
	ozAlzrituczFDQNz8vpXzizlnWYZMK56JrVHkvg+Wd97QQK7+Zei5fGaVP9edzTmu0KJ95iw6GH
	F69cG4kAtOcg0OIN1MyKfMioG+QTDWFk=
X-Gm-Gg: AfdE7cnN+5DCZbaufIxmG7Kut1EkKvrOC7AF4sb8H2MQjQ5mgjNPybGxa5q9qpYyxHV
	CNgUIVFG2GjeIrFKtX866Gmz340nPAls0ugrqzlyNkeQb3F1ZrfFc4UbebkO4B1DEL/gi6wvuN2
	ZbC07wuN3Ld/Xkv85Axilt9eRWdKoEvl+Yvm/NfuyNw92E1nJPLDvH4FfWpEJ5DApYqrUSQ4F9I
	i21Jx8kUh5UFwlq6YV8dHaHH/0X01IX+fCPRHTswqHUbx8ZFZBwqOHAkItc55xYgqP7NSAkwrVY
	UUlRMhG3msRqe/bv+av5yliaazJ0kBqt/GeQzt2le++OLDe92A0AbYoxYNkopACKErz8L/4Uc0B
	kRqNzJf4JEkzQ
X-Received: by 2002:a17:90b:3fc8:b0:37f:df57:2ddf with SMTP id
 98e67ed59e1d1-3893f97f9acmr5955183a91.1.1783600579406; Thu, 09 Jul 2026
 05:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
In-Reply-To: <20260708211435.402426-1-chang.seok.bae@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 9 Jul 2026 14:36:06 +0200
X-Gm-Features: AUfX_mwL3bHKWtprsetd8vD3bzrJ-aNGwy1RO-GdBAT3lh0aQQKrh2dMlZPTCOA
Message-ID: <CANiq72=-HjYOoJPd=B+0OYrHuyCO+NpcjRvmmhT_ecVZj8q97Q@mail.gmail.com>
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX instructions
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	Omar Avelar <omar.avelar@intel.com>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 11:40=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> +        KBUILD_RUSTFLAGS +=3D -Ctarget-cpu=3Dnative $(if $(call rust-min=
-version,109100),-Ctarget-feature=3D-apxf,)

Hmm... I don't think this was tested?

There is a missing `c` there -- the flag is never going to get passed.

And while it is true that `rustc` knows about the target feature since
1.88.0, it will (sadly) still loudly warn about it:

    warning: unstable feature specified for `-Ctarget-feature`: `apxf`
      |
      =3D note: this feature is not stably supported; its behavior can
change in the future

Instead, we should be able to do it in the custom target spec, i.e. in
`scripts/generate_rust_target.rs`, assuming `-Ctarget-cpu=3Dnative`
enables it and we need to override it. But please double-check the
interaction between those and test that LLVM is actually getting the
right set of features you want.

Finally, we are trying to get rid of the custom target and instead use
flags as soon as possible, so if the flag will be eventually needed,
then it should be stabilized.

To help with that, I have tagged the tracking issue with our Rust for
Linux tag and will raise it to them in our next meeting, but it is
even better if the actual company pings as well:

  https://github.com/rust-lang/rust/issues/139284

I have also added it to our usual live list of features:

  https://github.com/Rust-for-Linux/linux/issues/2

Link: https://github.com/rust-lang/rust/issues/139284
Link: https://github.com/rust-lang/rust/pull/139534

Also Cc'ing rust-for-linux and the maintainers and reviewers.

I hope this helps.

Cheers,
Miguel
