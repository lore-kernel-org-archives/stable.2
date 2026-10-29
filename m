Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261970;
	b=XgETS7Lv5vORqtLrv3NcJqsm6Rvg6VsTtn/8EQpHJ3i5ERUnll98kMr0G1VyYmsza7JY
	 XZOOIjiZZytiJGg6ZFtTNfSjLsYp4FzK1EsxUQtfmsLXpxbEfM+UNp8WjDr2IktLtJrrD
	 O5zSGvxFNRFOBAKxkLyyDp51MdnP4UKEWYQLFuPaIcucjkgdGr82XY6cNi3vbRWN7yul3
	 X5/TH3riXxel5RwaATi9dkIakaGEMimz477XllJMGKlWIf5AFHeBP4Ted/tKw76ZMyfsn
	 zrezd6VGNW9igsq5a+ftc8LpWIYjbr8rYAJvGnjRUnCnEIrXRYyYRolZelz5RMGL29A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261970;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FeXIiIhrvwIbQYpkMBfVZTtFWwz8pmkJmpDbtGyoWCM=;
	b=K5R1ZG5HMASPhBF+7Ugzghot2ocMnjF1FwHDSv+vcPEGQNQeBJViNvLzqv85dygwlUsA
	 KmqY6Yl6E+Zc2ld+Ecu4iBnotTviACP/wEOjgfwogtp/fjTB+k5DXsGBtx6jQuZyTsaPI
	 92RvsKQVePmaUb+Z/+pxCy8mPZdQzl7LbhAJOV1mGD2i6+ozNDxJU++M3uSgVyUK7puN1
	 xMwqLiOwWmtwoCu+Hr6a8ftH5pHdFKGOafwPZ0j7hN3zz/nkFKtQ6oy86d7v/MxL2U1ba
	 i/+1jfJgPXMqpbmZhNd9JdQRuz6WvbjkNqBc6dFyBfXnbgjdqSd0bo5kwSveVbGDIBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaS1trDJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90D606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaS1trDJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331D61F01829
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793261970;
	bh=FeXIiIhrvwIbQYpkMBfVZTtFWwz8pmkJmpDbtGyoWCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SaS1trDJ1gzpH2U0IGvtIQG3LLppT2u2ZK7Xc53HihvkiYLkdwb9aAzBz3yolfStB
	 C+qdRJMnj+8s/u5mu7VKoZajBeywc20wIPRj4qHjp6aC7Aejh9PfZ0o3xV3DQnzeQO
	 5uHcAErIy90MHIduVX6vVyt+oe/pDa9TeRhdevpt2X7IriDBvfVOQQNwMLDokKQT2i
	 hQy2qAhWWYGTDFa6Rghl9T6RcB13GdA0r9rQRM5XjcNKSBc07rzL2eacqUyUGAFmG4
	 L/OhGuk7kHzuizwgqX15M2B+2gwt+BdnywdgLJnUOAkZbaBwG0ZN8nDrSwEZQtYeyA
	 kdSIF6XEs71kQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so2561952a12.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:19:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx11TS7H0zOuscShiFgIo3I39jf6innjSjPq5A+MGRxKYrkF1gDLTC/47XO5p3QbQ3lPOUQyCw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcbmRKBGyMq0ih3z5IYg1+mAqvRTftx3n6a/WrBKhRqqzvYTY7
	Iqn1TNag/MEv2FCtdHv6cxLt4nPti0Xt9/fmExy7Idrsuekv/hGAq3LbXsV9lyI7u3Q105vH2dz
	NbxDQIR8xId1vnqBKfmKGiiwBQtoVQTY=
X-Received: by 2002:a17:907:d78a:b0:c49:8fa6:f585 with SMTP id
 a640c23a62f3a-c49be05b2f0mr389440166b.38.1793261968871; Thu, 29 Oct 2026
 01:19:28 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029012532.222013-1-icb@fastmail.org>
In-Reply-To: <20261029012532.222013-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 29 Oct 2026 17:19:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9ne0aJudrs2GEqOfTAzquTRN5Q4qfafCFgAo9baqH8OA@mail.gmail.com>
X-Gm-Features: AclHuK8ji3dmaGQDuALVjPa9jyjsHAG8Ln84jsSSYMUvBfi-wh1jPoXMHUmzyQA
Message-ID: <CAKYAXd9ne0aJudrs2GEqOfTAzquTRN5Q4qfafCFgAo9baqH8OA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: enforce the read-only share flag when creating a stream
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Gael Blivet <gael.blivet@gmail.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:25=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> When a share is read-only, smb2_open() rejects opens that would create
> or truncate a file. Creating a named stream on an existing file with
> streams_xattr sets neither O_CREAT nor O_TRUNC, so it passes this check,
> and smb2_set_stream_name_xattr() then creates the stream. On a Time
> Machine share, opening a missing AFP_AfpInfo stream also writes one. A
> user who can write a file at the filesystem level can therefore add
> streams to it through a read-only share.
>
> Do not create a stream or synthesize AFP_AfpInfo when the share is not
> writable. Existing streams still open normally, and a missing stream
> opened with FILE_OPEN still returns STATUS_OBJECT_NAME_NOT_FOUND.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Fixes: eaff8e924f60 ("ksmbd: synthesize empty AFP_AfpInfo xattr on first =
probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
