Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55A37BE75
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601370; cv=pass; b=IEyn9GrQZmQYQbaqGbTLbRblrdwVQ/6XH41cVnd+9WwMqVHgb96YiyCWZ2r3uY904urvITiLXikgkvrHl00FNF2niJL9UL8aXvqp8qzhcRWNmE7/PfyTU1a/LE+c0xhhC6oRjjFE0pMycoQtYmREEadCBA3CA0OPk7HWZ8Vt72s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601370; c=relaxed/simple;
	bh=D7Ge9X6Ztqu/7FdccyRhbKVgUi2xAiktn40DLZZXjTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ9Fx0pG4dUxfOG9clj4Y7pvLBsam4QeVWnNieEHNGqFjsYjeNUIggZNN+FDEl/YvmSwelXIv3iP5Le01HjhnyxXCCk36dVNhIORa38T6cU/gr05eX9h4t+FyGRi3zZzQft4LrxCKeip5LbESRwKjwkf7vC9U6T73s41bQEbQ4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nev/0QPB; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nev/0QPB"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so130910f8f.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789601367; cv=none;
        d=google.com; s=arc-20260327;
        b=T9hQX0+GNldQMCRp+36daiqUoxGRvoSJ6vBp89Wsv6Ab4WW0Xk18vMnDVAHPFVAlEN
         qGeegD60ZXwGyml3uT6Rg01EdQLBIijr6NYzQgW+OjJjnXlmzClIg/EZo9ZmxwSbwI5q
         RIHO78IV9XZRHjvLAXDInGptUir7qppedLSfbY4o8kb/9Y7auSMP6ixsK1ljjZLr7yHU
         4cA0kGCbMr/SwTuSxT0hYHmpyGzpsQToDTVj7bJ2GFKtSwtBsqxl05BsWlfBL7MmgQUk
         Y/gXPf6pZ+rfTcT2ChgrUbAqSDvmvf+K+TOMY8x1MBTBLpKT4F89V5tJW8KqfCjg28iB
         0Ubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D7Ge9X6Ztqu/7FdccyRhbKVgUi2xAiktn40DLZZXjTk=;
        fh=POOphwEVYGzlHRPIsys3UH85zC88NE35Vq+MDMsU0EY=;
        b=cPYlQcJiybudMOrhUUyHVej/3BLu2Av+pa6ojRWToC0aRAgMc/iyvIcPYYsBE+aPm4
         CnjN6PvGG69g9JBpnXeQd/8yswKOsE0rozHg3Ws8N/Fx9NZEg4nElAWaoV/ArEV8uoNi
         kfJuhJmj+aguhCc7lQ5N7dyansv9cyeYvDmQsvWsXjnc+pVVEKrtZttJjGPSYsw6Ok6y
         Zh6pgks0zKFv5rjdrJJN9VdAvb1u8cz92vCnjOJYA3P0/6GqQ67wya+IWIdlaDu0lcwE
         dKQtx7YMZSd6rPkyGpAse8o9d4b+J8ZI4tLnYFu4Qgt7Tv3rT59lexJruVJsG7pyjDAM
         eTrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789601367; x=1790206167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D7Ge9X6Ztqu/7FdccyRhbKVgUi2xAiktn40DLZZXjTk=;
        b=nev/0QPB89obwouNCN1NN4bGfl3wgpsyy28lADnEX3Ye8D0rzEQSJ3FogELwuLBsy3
         LCx9ptU4JJrKEd3LtzzdhoZGurIGhLFLLJKYKi2Rbg+NKcm71xEaFaXDgv6oN8+u7mn1
         Hk86e+2OxX70Iy6Il6W1H6qwJV+uyPBRxSellixHMyRM3sdumRArJSfnbCbhHyiv6YO0
         GkayeUVu1OKbp3Av9qj8h/KTbXNcsC9VQJAixfpEYtoqzaD2lMhrymJgzlU1/Eu3yPkQ
         LCgj+94B7n5a3dkQy4piGCYPRXAHO7IjHt3cn/QJH5MeU2MG5Cb0YGmVB6/0Icu9RbDK
         4KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789601367; x=1790206167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7Ge9X6Ztqu/7FdccyRhbKVgUi2xAiktn40DLZZXjTk=;
        b=VfWe4ZOrTwRuihMA/2J485nGkGeSiApP3r43t6nwjJ+trrcL0ZRWEbd5CB5xZHqZUC
         UcJHcC8TDy1I+04B3RTur26eiYb0jKp7nUiqhizwCV3OrbzMUDbIT8haTHQa9pe5vlmx
         HIv/Hbiffea5XCgLnp5430zw84Toj5ezChRRLX/O/TyoF5RxzTfAcafEV57tFvdxel2l
         Mk7R9JJQzf54Di8HofAaBJRNR/eXE5miVgPjLjGwXfgBA08foMDIvsHql88dMKDgjCwS
         +Lc7GFwrQJknTR/cFiGYbJSyM24AsTca6DbRm71FGanec6V9P4iMvEKlXiDea/iXX0e+
         YWCg==
X-Forwarded-Encrypted: i=1; AKwUvBxR+sIxdOPiznUMFynSFSHaZCrVFz8jRyKM6pTF3P8yc8BknT1TszmjdHae0nRUX7tb1NKPNrM=@vger.kernel.org
X-Gm-Message-State: AFuF++lrnXAbexGHG0Mu9MzGP9W1BmBUFTcy3Xkbtpw56XhGJNP4T+zP
	i+93XBUyIpU81mzz1SdIF2B1fb2yM7tTuNV6HvMnsPWd7aEzFgc/EefmmTuQGK0RV+E64dZhR2z
	tz9hY4t3FiypzW7bCTuK+n+Ng4u/1XKV68dFScT3e
X-Gm-Gg: AYBFou0QQ13GvvhPqPjNlfIL3rdzd5Q4H5YrDDVyImFLe1txTY0DztOulPDi+uap0Kb
	A/x8oD1XVSh7E2F7vxrz67IRpHEQ0Fz8bhRSYKPpNHeFr32Lhgu6HuRISlP9wefwJmb4ISClLIu
	mJ0UhZ6u3q30ZwCILcmdRv0PUvM+rPb1aR4/dI5hgQ6Lxt+nbOrbvABlGOZW6zExvjyBbZ9ujQY
	J026npsPtU0YW6RZK7Fx5Qy1dtmiogSD28khFk0iy3NqmOynp9vavDjjhH0KZiMMWkvlLo/F1oI
	9jB1Vd3W3Uj+RGfcK0hga4g/JQ6nolIzcpi1YBMUCgnkhvAKptSAoonEdUViSi4+7BMMFvDNmyW
	UPMUh7fQVAT3XIgdr7NgNKA==
X-Received: by 2002:a05:6000:26c1:b0:486:f778:6c85 with SMTP id
 ffacd0b85a97d-4870cf09d5emr5758313f8f.6.1789601366474; Wed, 16 Sep 2026
 16:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916120833.593407-1-cmllamas@google.com>
In-Reply-To: <20260916120833.593407-1-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 17 Sep 2026 00:29:13 +0100
X-Gm-Features: AcwNN1V9N7YXEIm0W9q5OmEBgRhV0s-HOmOy_FIv4QrXWCM7mnZqSF2SW0U7XeE
Message-ID: <CAH5fLghBWzoVUqQ7oRezwM+5T5j-sMTjNi2w-urNA=YAT9yM2Q@mail.gmail.com>
Subject: Re: [PATCH] rust_binderfs: add transaction_report feature entry
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 1:08=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> rust_binderfs is missing the equivalent of commit f37b55ded8ed ("binder:
> add transaction_report feature entry"), which adds "transaction_report"
> to the binderfs feature list. This helps userspace determine if the
> BINDER_CMD_REPORT from the generic netlink API is supported.
>
> Cc: stable@vger.kernel.org
> Fixes: f14e0c8183bc ("rust_binder: report netlink transactions")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
