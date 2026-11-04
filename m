Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757183;
	b=0dULgoHY66FpcyP4LJ8gi41ioUxxRwdMgxhF3kvgwxy0iTSMbHVVV7HtG/RPWUtVKxpz
	 f+0qiqy6N4sUTE3klA2/GvTFER3LWciua9sSorC4sKvi1AgTxi8lHOxSTrffAwEYYkQc3
	 SdL3kV8Lkyru/cQZ23h4gjtjAwd2p2hnJzpFH+pSJ48xlPPGjYY7P1iierqsewPwuo25w
	 lGZRj0rNTPidX1XOrsLxUSCwCAlUlkhRJFNzEmfxgHtIRx2gcwb3gjbP3Kl7hgfi2rHR3
	 i1WINsMILGvGfV1j03xIYC1CIJjWEQ9/tIVzTXYqHo7yz8Kl6AvC1qvbruOcZal+C6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757183;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GQ4mEHI7sQjBBaEIricpvMN6RFFxM9rPq7clRjSmwKg=;
	b=ohQ74+oUEt2uoizpglGyyKQ97QdhjoH2EPoe7jJI4hytfMMwNgEnV2FzLwXZ3cV8mHmP
	 +CNqgDMNXa96Eo3NdXMAFew9v7Xzy9BiUOPM4VTOz8+jas5hgFA75JbXcqIbrWR/DHoqc
	 9BVSFW7QCecua2TEydvEPXg8vBhLYr2XXeIAMSKau9bp5pn4AhGSrY0nBYdDLKMbJ4K/W
	 sRt23+Loy5E7yFUyf0pUiGurey2vRLrqXdw0dDYJvZE3l9dY1ltblvJCACL8hSng9FMx1
	 tzJKRdmNjU3ybQBSmFUi5lilaXqc2KTYPgvw2m85jWreFE1evLK4LVRNEIau043OzNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMKkVY3s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21274606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMKkVY3s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61581F00A18
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757182;
	bh=GQ4mEHI7sQjBBaEIricpvMN6RFFxM9rPq7clRjSmwKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NMKkVY3sFk5NieJ/HJQbEnMH0jt5LRjMXJGu/Nhi1+qt6+Hiepsyn1pZcY9uBWNnb
	 29IF4NE8GU83KH5MZHx6nKGUfU9kP8Fch30m6xVAEbZH2gsEP5CLltbd73u9lG8nMN
	 6hNpTQRUKxx2EQoi0Hv6xBsq+/35qz047oSuv5jE+jbH4GL/oCuJYt9MnkvVMQ8XG8
	 BN1Lj4xrS3De06nISJmQ24Uu/5lFqYk3WisKQU4YifirKKVmC45qFYvNVH7fRG6uDJ
	 kfDPyem7anvLkd7BsoB3ByY2Op0KyD7LvdYPTcj5W6TdsPieLxY/ENOp+yiQOTnGNs
	 EdfsJ6K2mc1/A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e8c710847so34706366b.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 17:53:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxAENOXTnex14GLzVajkcOsqwgsdLUDQ3vnv9ovS1ooI4FVqWR/5oWmobNTCKUBW4ECwJ7Anro=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vbSCklbOXA5thxXE/xyBSVNMtQWYx3PVZlRuLsz2aMQS8jXiS
	gDvIJliZqKcU/kmHI1oOsiItv+zZ9sM0O901ZKAYZauzB/aK0Ehk3t/QVRkO9cuabVm7ltBznwT
	lNVwm7yaK0CTEXx2RdPDABVc2AcDo1Tw=
X-Received: by 2002:a17:906:ef06:b0:c41:1e13:8891 with SMTP id
 a640c23a62f3a-c4ca7a43c0fmr1236027766b.9.1793757181430; Tue, 03 Nov 2026
 17:53:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103110803.2517085-1-joseph.qi@linux.alibaba.com> <2026-11-03-1-daily-reply-0014-re-ksmbd-breaking-cnt-leak@kernel.org>
In-Reply-To: <2026-11-03-1-daily-reply-0014-re-ksmbd-breaking-cnt-leak@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Nov 2026 10:52:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd__FvF-bCzzq_JHFqCF===_qrVZC8RLjrp4nh1s8sXq_Q@mail.gmail.com>
X-Gm-Features: AclHuK8LuxqZ51cFZaXEAg-WEfk--Vr4t3lFrt9KWk0uDBpkuGwjwHPpOGXYZf0
Message-ID: <CAKYAXd__FvF-bCzzq_JHFqCF===_qrVZC8RLjrp4nh1s8sXq_Q@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] ksmbd: fix breaking_cnt leak on early return in oplock_break()
To: Sasha Levin <sashal@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Steve French <stfrench@microsoft.com>, stable@vger.kernel.org, 
	linux-cifs@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 11:52=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > For leases, oplock_break() increments breaking_cnt before calling
> > oplock_break_pending(), and returns early when the pending check
> > reports nothing to break
>
> This is a stable-only fix, so I need an ack from Namjae Jeon on the list =
before
> queueing it. 6.18 and 6.12 have the identical bug and this patch applies =
there
> unchanged, so once it is acked I will queue it for 6.18, 6.12 and 6.6 tog=
ether.
I agree this fix should be queued for all three stable branches.
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
>
> --
> Thanks,
> Sasha
