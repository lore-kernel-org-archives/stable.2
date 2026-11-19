Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795079816;
	b=jSREe8tEl7anMGn3OP4wOGRXU+EAPYtf2qNEKnvSlpDc5OWSC0zei7rFO1BrOvbOsLcg
	 7Ok+S8cX8bl+d12JYTj5zU3LQ3YT4k55dRSvjWtPe/q0sBEkPLiuFyv1vAGhAJQ4AAsam
	 ubY3LjU2M9Cb7/qSYgiM1Dxmz329tB4QNOHTNd7m8k0BMi8nELop8/vqZD3TNf2ENzoAu
	 bvuMDE5ybC8dMwGjmDehy+aiK5Zr6IUfXQrsLTMKcPKJ03MzhGnf1LjEcV2Q5+WPpw6vU
	 fX+SvErhXut/Af44q8Ox61HEp5FEeDhqyR41cujWC/7IxlQRvi+gzMcJYEgdEgILfpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uOnm9VgyV9A6nAmgpwHr/sD2iGFNDk3FeSWi3tD2RIE=;
	b=5ImrEHGP/p5LXztiyJyafkA0ODNy4bvPHjekHo+oYl/xsF1kjpQxmN52FH4wZyQUWaaE
	 /QHpTS7h/NDMe5qxM/G1bJI/3wz5qWC8gFlSICkFiZTZSXJWJ8v2d/yuGxwHbP3NLvQZc
	 7mSInNSSiISIS50yYyL/qtUmpgJd9ftsdwj+ZHpLkrhDGRumP9yhTWPj3fge5WVaXSSef
	 Xvn6A4a+p6shArpF9lEu/oUFw5a9cqic2A2Z1xYd1CPCefjpoh9hd7T+VmN02Xn4E0riL
	 mvHkBALesFaNtN8zPLFUAxUAo/Qt8EFkgY9tOefRlisUPu80bUG8bo5G95TQLKqveVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H596OWh7;
	arc=fail smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E0606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB0E0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H596OWh7
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c0ea47f5b8so207184e87.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:16:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795079814; cv=none;
        d=google.com; s=arc-20260327;
        b=kcMxaMzESkNyJJBJacBICHAoheQGMI7nD5p9zGH4ynR4lfDL8qcmtrHJjZ5jafhyX2
         qrd2y74ACBJglRABKZQJcFF40skh2HZe4n6drsaq2GzCsuakzWOWg5I/ZZRt1meaQIaW
         rUqLW8bsT3IXJ2iCLW2jPqFW8FKMe8PlI16V8NOF4vUE0Td0tu7WOSDJb/ZMvSKrJk/U
         4OOWssWqvegNCx2/vnYf58w2y1b6xr+XFp5ViViAx1vyctFmWJ8FcUE39eUetHbXDln7
         B0b8Toxm8rjb7zeWpM5LT/g27FolbysmWU+UrokU97VqGii29hS4gktJ4OcR9NG+CZ0f
         5d8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOnm9VgyV9A6nAmgpwHr/sD2iGFNDk3FeSWi3tD2RIE=;
        fh=9rlZj5smMiC6qq9F483LnCeQfEPlOOSipEApneeaZeE=;
        b=G4IfRxIFhYTKij5u9iJ9Llw0IBDEXduqlrNyd9G12CDgnz+hUapXdi7/B1NHrEyR50
         n+os+8AuoNqP47bzXVCo6a8bBuhCErrgJ3XYBw8Nf45fG7aPuKolfY8ihDDLLkZjqbGK
         FgQKZFJnqmm+4xNrt+H7LqLnHtBEHJCH22KNRr7Pix9b+95cZ/z5p5S6zR7g1yKctgzl
         dap6d5AEoe/3Xb2R5eDTgnIuqOAN+8ggSHRQsDglUIh7Y5parsqoD7ko3823KalU99L6
         MUxZ6+zigCx1ymjDA+n5D8cqHFRryuiWCUiNenzTRQktAYRNPobrdfhKTPxjqAf7ZF7m
         5a8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795079814; x=1795684614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uOnm9VgyV9A6nAmgpwHr/sD2iGFNDk3FeSWi3tD2RIE=;
        b=H596OWh7WXxL6ryFZecYsvKcas6rAUTOPK4ZTv5ocNVMX0XURRu/lYyz7NsLH4fUML
         zMDv0+OZhtGOsgKTeZvgmDfJe+bvPesZAn3gCEqbgpSXVN4oqX1wgJG4FoJr9gOceOjh
         xpI7dwtooFHITIzrQsWYgFLp/cc1/bNJESflFInY7eH5cYorVOLC18K1geyh7wVqlFNm
         bo07JTjebS4lSHVfymO+dfiyAK3Tiwb6HCGe3WwDgmbkBLN+F6gmNYmngzOatT68+8AA
         59Zx0D7Kl0eEaFFBuAKVJKIpIaSXpBHif+UrISihXARPUJraW5zH7oaor5XJCSdnhO6j
         cSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795079814; x=1795684614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOnm9VgyV9A6nAmgpwHr/sD2iGFNDk3FeSWi3tD2RIE=;
        b=QkrArvBxJkFIFmcvkN6QYHocpiAvpALHr1GGRFUO1XsjKABpLPRiKkygJ4+6UbPBxq
         Jje3EDjjc3qLoGq2iiIoSvSX95QSiUzjIsf+twOtQUn7yu0w8v74SwHMNYDf9giI848y
         dswlf61kDjTFUyqfwrhU+MiBphQ8Ocnm1/W+HjYlh0JWRbl6TWh55zNUIY3qOyF9a/c3
         j3maSK5oMj4soTb4n4qHOryH2rpx7/ObZCDdhbaBREyRE8xQfdBqPeQVTqY03XY2/nVc
         1jgPqw0fHxNm2SZNCAC5214N9r8Rr5e5qCyFoo9VaVD0cPyEewJnLNJcMoIKIReiEcKO
         8ntg==
X-Forwarded-Encrypted: i=1; AL+hErFJ+tqGgfZxPGoigyBJrB+cJ174rmIMChcM6DOfbJ8hbJMfR9/qlM13v/If0mshFL/26eLSQe4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fofr3NMyefDcmRdXDmWD4b7KMsKeikhyzNTJW/toHIz4LwMEB
	fDqQnp1tFaMzbYQJBQ21SNT1kWKKgG/CfJ1RfE6qW3M7b2KSsuwz5bSM9f0GMyyQL7IrVXhtOA5
	A0r0xUnnrk9Kpo9bcq/Lq4Xl8+0AGYtM=
X-Gm-Gg: AYBFou2rarUYe6VGI3O5KR9fG2M5tGgStWqDuFupIuM1c1XzBW11h0cQ2xYsPtMvHy8
	nqqo2mX59EA4FKK6QfAIQVuSA40BnqiE3WWXUjY62OxFIrp6v7jaqxNZ9EPphz6F2hZKxLBqNLR
	40c97LnEZ5718ArUfJVltyfnvKQnNtyB+Iv7acURxyQZsa+lgPv0XmTos2IU5yOBzksKL63m5tg
	wNB7pun9LlHZINnMRbOw9HO7Uwm2BLGRcozKEhHOildL8Ddh2E1ljpOaWMJDgD/WKVc/1cVgnuC
	AW3kq3H8R6peGRLfeH3ea817cLTXq5bQtHYQZsNk82I84yb6Ts1jwy4Ldtyf4cUb+8h1hB0+4gH
	pn7fxaRNXtIN/RptA7wKBsN/tafVguuNfUC0csNzse7HCFj+jCcIgHk5HeEnkEfnO59Ep8xJfIs
	k2M3MoBeerE7IV+Lh65CqS/iCPVE1JR275ylM0JudGUN6GHoS6qEqOYkGI4EqQJX6oLbLPP8HXM
	PGPDyc4LiR+XBHdyOn0ozYM8BLHMTyxL82NL25kqCYUwTceZDrghPyqz1lhAxUJcKFu30cD
X-Received: by 2002:a05:6512:6201:b0:5bf:ba43:fa67 with SMTP id
 2adb3069b0e04-5c1aa031659mr2118221e87.6.1795079813531; Thu, 19 Nov 2026
 01:16:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com>
In-Reply-To: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Nov 2026 10:16:41 +0100
X-Gm-Features: Aa3M54o_6SezOlJoJCWSx-bUjKVqZp3a5XNbhlqM7Ub90ktijfyQoMBmQTdWto8
Message-ID: <CANiq72nfu9-4PzxhFeVZBdzFOmowWw0VRLeYAGxv67wQ0xAeNQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: str: tie Formatter to its backing buffer
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Georgios Androutsopoulos <georgeandrout13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 6:57=E2=80=AFPM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
>       rust: str: tie Formatter to its backing buffer

Applied (just the first one) to `rust-fixes` -- thanks everyone!

(The other I will take it through `rust-next`).

Cheers,
Miguel
