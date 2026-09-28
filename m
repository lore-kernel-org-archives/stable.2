Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA64E06FF
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607368; cv=none; b=Cp8owpNe+vOzkDfK7yLFvivW9PUoFQpBN82vzhlvZPI7V1TJHen+L64lFfLtYycjNC66CtFN7MbhM3RFIZDzZ6r8Y7fDvTsS0R7DAYxAwzctV0cijlBXqL0o0d3PhGuZGg566FEP63zPKQSf0LU0Ut4nuvysqrctk4MLMGew6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607368; c=relaxed/simple;
	bh=W9jnR9BJhKGpIRqXrrZ4r8QXYmv7yWwOZsqTB6Dh6W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LidqtdMcluycTRHn53NhSKEn9p3YVUwmX4emEPmJ9+MpzE5mRwiYqeSRwP27LHynFalc9bUS9l357A7n3PjeqOu4VrYCK7XzRTsUmOHamejn8gh2pxPCGbQ9hN0on++lyJ3/MioB51eiGbdJwaRASlRcTrtvBsUTJlOnhVmVHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVfXtGQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVfXtGQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BED1F000FF
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790607367;
	bh=W9jnR9BJhKGpIRqXrrZ4r8QXYmv7yWwOZsqTB6Dh6W8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SVfXtGQ4Qb1xDudO4syPZVJfa+Km5HfNmHoU/XUTEdZwJ4xYO7yOHELwPZ8NPwVD/
	 m9olEVz7Jh06vJvYuENNKho15Ou1HxExUvqqMWfYuOvqRYOZ9q0irpTsKWw79zsfdb
	 hhoR6p/ntV2BxrnXli77r3p574t5OdWBB8hZH7gENKk8ZuU/qmjT1V9CTPkYmVhPks
	 QJykcR5U7fg+6Sup3BqjNAHkZqQCYZmwQBH9DnRjEA54g97MvzoSbueDzQQw+lDUAk
	 yQS+VmmcODBoD/lrKR+uqoTVz+nvvKb8q20UqiUrMrS3IBTV1MXWLdtH5rmAtNtYi6
	 pjjAXu5TMYNYw==
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab0c3c3af6so2767359a12.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:56:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByslw77GCOKBt98SnTIyTmYuF0gsnjRuuAl7wP/tYPwXl3Gb9PwCJjhrUzalKmdUuGS0b1pEIE=@vger.kernel.org
X-Gm-Message-State: AFuF++kB8ePvrrXcTgbiP71o5GRR282gFOiKq5n9PRq0we6IvwNYfmg7
	IGdct68BZha7yzMDezi5giPZsbzmIzkc9Jn85yFEPI24keIYfoiy3rrtC9AA3FH9EAlqdn1vZrj
	MKqz++RhYBNwtwDUf4z6mQKAZnjc5zHY=
X-Received: by 2002:a17:907:e00d:10b0:c2d:bb53:239c with SMTP id
 a640c23a62f3a-c2dbb53269dmr305102366b.21.1790607366142; Mon, 28 Sep 2026
 07:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927063339.1731061-1-zhangdairui@gmail.com> <20260928052026.1789765-1-zhangdairui@gmail.com>
In-Reply-To: <20260928052026.1789765-1-zhangdairui@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 28 Sep 2026 23:55:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_NZS0qn6ErXHUJB1ubLy-ioEL3_pNhYwLnMUyT6mRyHw@mail.gmail.com>
X-Gm-Features: AclHuK-_2Nmg2CyZD2N4nKZDDkeVtWvTmm1Coxqwduag7p-kXXdKSd8bwAFt0lY
Message-ID: <CAKYAXd_NZS0qn6ErXHUJB1ubLy-ioEL3_pNhYwLnMUyT6mRyHw@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: fix OOB read and cross-share confusion in ksmbd_validate_name_reconnect()
To: Dairui Zhang <zhangdairui@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Paulo Alcantara <pc@manguebit.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:20=E2=80=AFPM Dairui Zhang <zhangdairui@gmail.com=
> wrote:
>
> ksmbd_validate_name_reconnect() indexes
> ab_pathname[share->path_sz + 1] without checking that the path is
> longer than share->path_sz + 1 (d_path() fills the buffer from the
> end). A durable fp is not bound to its original share, so a client
> can preserve a file from a short-path share and reconnect it on a
> long-path share, making strcmp() read past the PATH_MAX buffer -
> with a long enough share path this oopses the kernel, and on a
> mapped page it also gives a byte-equality oracle on adjacent heap
> (the reconnect succeeds exactly when the out-of-bounds string
> equals the requested name). A same-share variant with the durable
> fp at the share root reads 1 byte past the buffer
> (strlen(ab_pathname) =3D=3D share->path_sz).
>
> Check before comparing: the path must be longer than share->path_sz,
> it must start with share->path, and the next character must be '/'.
> The share root itself is accepted only for an empty name.
>
> Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
> Reported-by: Dairui Zhang <zhangdairui@gmail.com>
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
Applied it to #ksmbd-for-next.
Thanks!
