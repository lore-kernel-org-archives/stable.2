Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094634;
	b=yeagc25ygeFYojqnrkYe1l//foRUL6/cDyFH78+M3OEto9uopSjVpJ4JuMCSJKyiGKaa
	 b1F7FuwjPvTJwmL0UAA0ZWNo0T9ynPDzTHnbYSIydzh2E9nsPZPFeg/hDqucB2bC4YciG
	 aJWQFOchuIiMlwxF6Qx5NmutzNHRDxsYLx+zppoQv2K2/B0jgBZQxT0Efd9jm55ZMepoi
	 45Q/ar/EXnx33toXIny7Mukzb+RuGE6ekTmV/PLAw5BPL9j7lFLnaR2tdssSJ5eOH6169
	 4EAZ6o+tG4GYU3Usi6mGICuARy+aS5xkt7xoZnTjm2gImy3HId3h93gsmoAd8Ck9zHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094634;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0RqTFyVn/l364Pu7jS7dFXzz69K6cCLaLO+gjoUqCcY=;
	b=mzFvMtqNeLoq2TQjLUq8CEhOLJMf/N1FCfGciJiVoe3MBM4ewVzUFIRzRtIjpqLW4Ux4
	 6yf8JzXcz7ZgX9Q922ZsojMa6euiQsv0Y93CBP9wb5d3D6/hEWDDtcYkNESyJ5IWIWbN7
	 TaBCeHZWOwH+IJT2eV1rg+XZxtL1rfBp5fRiko8PLenomjNNCGdSDONlUxd/LtD2KcBk/
	 0OsiiVsKG/O5dNxuUyy+LldSGpQgzBfKqNtdXjUgoCZ5Hw9s9kIRQHBs8nwBEckJy5Uaq
	 EHicCGDTeUUYMYpjP/ShjMqfh48u9QTLuvrsUKVYVxdu0gMBVjgQk1qfOAOpzFDBGNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBUaD6VP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0BF606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBUaD6VP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A401F031E2
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094633;
	bh=0RqTFyVn/l364Pu7jS7dFXzz69K6cCLaLO+gjoUqCcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VBUaD6VPoyO+o2vCfbg3pqKZqdairWQdoPhH7047vnPN/R4AvVaoawlC2ObiO4grJ
	 b0uQ59k0nCwUciSk/kZLz4hA41dOTo6g/+R2yQ3lh5YC4BZuY8eh8RkieLfMXiEFQr
	 OzQ5jr0W1b6GhytEyOgf9K39MrfsCgKxh6tKTwVFerNWlvt7Xy1xiqx3rbf/nOxrJ2
	 J9I7375tSJoCdeUf2UL4pB2D7kuAnPDz+JMfA0LVhl85RnYqamXRjrTFxf8fR0ctpr
	 Qwih9N8jZm2AascskDG1rPL6MGwhj04mG7QGQ8H5aNK0lYQHbiMxMn85/esD/E82Sg
	 B7h0OlZUpbqPg==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679a2b540f3so3546330d50.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:50:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByy6YlBVL5RW6VgGCI1Z+0cVmcXpeLknBSI4I+SWZee4k8deMy7uL/yyHYz/wo+sdmIC/0FxYw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoz3+rOvHjYbJfpEqH8kvjBdvqNLaKHZn1eEo20BB3i7yQVAKV
	SaYQ2sJTgy436WnP+jUWNJB55XXprC/i6uJblUip+HKD1CiiM0ND0+QCjZSh2tI7mnUxD6sgwJg
	QRyhRtsECYnAhGOu5x+wC823JyfX62gI=
X-Received: by 2002:a05:690e:2510:10b0:679:2ec9:9b1a with SMTP id
 956f58d0204a3-67a4543d42amr3823226d50.64.1793094633129; Tue, 27 Oct 2026
 02:50:33 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027014021.108390-1-icb@fastmail.org>
In-Reply-To: <20261027014021.108390-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 27 Oct 2026 18:50:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_03VQfaneatZURH4hLVBZA4f46tjTubPeG-Tt91cmGMA@mail.gmail.com>
X-Gm-Features: AclHuK90c9Mz02fa-V3lujObRHgoXJIiCvz94FvKUdOCqBAu-HVrqlSq8UtgxKk
Message-ID: <CAKYAXd_03VQfaneatZURH4hLVBZA4f46tjTubPeG-Tt91cmGMA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix out-of-bounds read when padding the final
 compound response
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, Steve French <stfrench@microsoft.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 10:40=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> Compound response handling pads the last response of a compound to an
> 8-byte boundary by growing the final iov and the RFC1002 length.
> smb2_allocate_rsp_buf() allocates exactly response_sz. A command can
> fill the response buffer to within 7 bytes of its end, for example a
> QUERY_INFO whose output is bounded only by the space left. The padding
> can then run past the allocation, and ksmbd_tcp_writev() reads those
> bytes when it sends the response.
>
>   BUG: KASAN: slab-out-of-bounds in _copy_from_iter+0x744/0x10e0
>   Call Trace:
>    _copy_from_iter+0x744/0x10e0
>    tcp_sendmsg_locked+0x2290/0x3f80
>    ksmbd_tcp_writev+0x10c7/0x1ab0 [ksmbd]
>
> Allocate room for the padding when the request is a compound, as
> smb2_read() and smb2_read_pipe() do for their payloads. response_sz is
> unchanged, so commands still fill only up to it, and kvzalloc() zeroes
> the padding.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
