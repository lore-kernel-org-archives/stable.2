Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088240;
	b=PzMWMgOmRzyeXNc8+eSlDMhGnKcf8wAo1F0L70whhLX1WhoWoqziGxUcTuq/8UNKY/lz
	 LmzsVJI2O7WtM1VLwRsWclYeBGUkD2vbU3Tb5OmpJVoRkco/B7Wew78dLTxNCWIBurQyG
	 EA0w0IxaoODX2ztWC1ky1MkKAnvErkp/tV7Bf4acLncNKg2tky7HcOsgFhSi+oKYRaxQl
	 coJ9/uoSlZbXeYKS3qtwNpr6kdf/bFRjBuxHOH9Fz5VZ6ENtRHt4rKummcPAqBIBqzjGC
	 Qb58czs3/DkGqOOYaOX4prU6DwyEuZ5Mwn8lpXZ95jAa2ZFbwQ1tk1kZzrENc81Ckkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088240;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rcqc+WTD9IhSKmFqP6R73mZ2Ro+j/JKdXcfJz00sz/A=;
	b=V0kigBsa3zM3vDElreXwaic9qJcC9j0zRJBZMt/g7J645nr1tTevbXwlrDoqsSIBxuHr
	 v2df8eT7MzN/Y0IRwqHcaqwpmSj/VzWUSHhhDOjKpvOktZUCZd3eK6EZNMB8eaaDgbY/+
	 1DxKeCOVi7uZ7m4srwUo7hKS0DqGrPwmU6PorBMhue545jxam8UVEpj3TCwmqJJ0+t9qE
	 it4Q3gRfMJ1Iyad+jCIjG939ntdE6IRtBRM3wTC+4ngUXuQJOdo5b7wbVIFGS6dkqxrmi
	 DWFK3t8zGtjpUR7BPQPMZ+QHp1X44rmzMclYM7W8RypQ7foklVzEjkqG+veNEDhSIDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOGWVJLQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA5C60A2600
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOGWVJLQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628A01F000D1
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795088240;
	bh=rcqc+WTD9IhSKmFqP6R73mZ2Ro+j/JKdXcfJz00sz/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oOGWVJLQMT9MROIPnXWFDxcv3oaPUNR2WPe+Ll8j0jzvaScGvNqyaM+ldHjR6d4ji
	 z/IesoVV0lESGfgeQhdoQBYDukAL7Wtn6MQjiLpMTe1Ec8vn33HxTNrmS4c/tIh3YD
	 HkDovWCXRcOR39ezWfIITSFy9CJpUDh9waYhNRHEmAfVVBsG/Id2L+dlQh67Pa8weY
	 LAamJ5FPJZCIUkuOxJl/0RDszHDdTKVLSBnkx5lMXF2hQFAzmNIJ+HPpZWq0JrFgY6
	 tP1N4xPK0SWsUFQuCqielT1c+8MyKoIwu9C8wFK+AEPcRTh1muMJFg2saCpdpd7MYn
	 kuT3br2QhN89Q==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso2625671a12.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:37:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEyfM7g+3nnlO+oMbmEy5rH3u3t6bJHvpUTihLZCmwQAywPAfOAoUy9zPQshksK36ltNUyB0wE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3gIFaS9BDrswEJiDViu3RgckiCps6oc7emh1uZeJ+YbYP2BA3
	VWqPLZvndrjnyf8tCk40GkBirzz76P9D2GbH2s0ruiV1FA0c8HkCpJUOdgLqLciG8+SYLzCl+T+
	FCVsqFU2FiAhftYl6s6ElKZRyFd2D46I=
X-Received: by 2002:aa7:d94b:0:b0:6b7:853f:5e9b with SMTP id
 4fb4d7f45d1cf-6b887f0d7fbmr3413317a12.16.1795088239018; Thu, 19 Nov 2026
 03:37:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119073534.118732-1-icb@fastmail.org>
In-Reply-To: <20261119073534.118732-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Nov 2026 20:37:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9FoDgXmR3nedUrjAJg8dYEUbKkO+E-N1U2a=wxn-EpUA@mail.gmail.com>
X-Gm-Features: AclHuK9osdHfklEjXswVGiM12TtcQ7-egTgsmLQIDqk_Uo_EuHbRQJ108BRcSQI
Message-ID: <CAKYAXd9FoDgXmR3nedUrjAJg8dYEUbKkO+E-N1U2a=wxn-EpUA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: build an inherited security descriptor with its
 own offsets
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 4:35=E2=80=AFPM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> A new file or directory can lose the access rules it should inherit from
> its parent. smb_inherit_dacl() sizes the child's descriptor for its SIDs
> and inherited ACEs but copies the parent's offsets. The owner and group
> SIDs keep their sizes, while the child's DACL can be smaller or larger.
> The parent's offsets may therefore be wrong for the child.
>
> ksmbd preserves the component order sent by the client. The Linux
> cifs client puts the DACL before the owner and group SIDs, so their
> offsets depend on the parent's DACL size. If the child's DACL is
> smaller, the copied SID offsets can fall outside the allocation.
> ksmbd then uses a default descriptor, losing inherited deny ACEs.
> If the child's DACL is larger, it can overwrite the SIDs.
>
> Build the child in owner, group, DACL order and calculate each offset
> as its component is copied. These writes exactly fill the allocation,
> so the checks on the copied parent offsets are no longer needed.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
