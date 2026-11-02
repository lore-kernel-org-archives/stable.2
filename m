Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611538;
	b=Hztjm69DExYRuvoUtQoZchI7OHETW6zcquBoKEwSf1d7DDnXX9baVgbX84EPZqO/B1bz
	 XGY+JW5DtmnQ0tuXAwgKtc1+dzIAHfdwTUlKxLbaf8Z7fEhkKA6uO4wPempNsP+e19O1s
	 kv42HjfC6kyHejGm4ZAzSxbPSalPekWxkUr5ZErild3apcUIwphTn/Fh3zgVcay/uFLUE
	 MIqOYGU7kflgwIut2qu07SfKqYz5AEV43gZMQNsqCj/2l0vOpntNI3o9JkrwL60GgoLVW
	 SG8vuKsS/25CMJCephxvVegJBUmybpKtIbIBLeKC7BtySwkg2FgyozkuhclAaXDG4hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611538;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LNx9hSZ9We7ZO5wkYLxI8aesL/8TIpZpdBJMnBpdWFc=;
	b=W+TuAqK2Vpz1tc1TkU76ymjPJoGOT1fRwYIQ77iiNCh3DRQxVRPhyal5S5tXpCQUZSup
	 MjD0EqciVxAKfmKZNOu6Z0QUxa7nEO/F0wbw3M3WO91GCfmeH+2hSi/DvKr1qp7jp6vd7
	 3Nu6omSAGGma5SCqAIjbL0dzVJwn6bsLGKeYcTdVX9VpGYsKv3L8GteA6qQ9QHXLbdqbO
	 7n/Tj7HOsm/lYX2ZPJknq8mYRt7oEt/6+uO9LanYs/3B2eOA75Vp7Dae407cJKqe0qXcS
	 1wDPVGtl3JwARWsfaZ+3M62vQU0jW9Grv6KSnWZdsi7+HduumdZJfDviWiifmdTVjXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zaw+wRPV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2160A260D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zaw+wRPV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66551F01803
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611537;
	bh=LNx9hSZ9We7ZO5wkYLxI8aesL/8TIpZpdBJMnBpdWFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zaw+wRPVkCfPy0LP7ToojmYV1uvZ7wz5OITq7kyiu1Em1JIxJSEJfl8dQaRzd1TcZ
	 7AMTyoCgjsgeZNmqGbyu7S+mCrG6zavdEF8aTcehRAoT8v6geTMfxVmeQIsmfJ9MYo
	 Z583rAmA+JUtI/CW+3TcQgUbycp+AOuIs1cjeLb1SIa0+l8w/da20FjRAOX457+IcX
	 ibjWUlHAB+UbGauwXUuYlrr9vklJUcgoVS/+KUBUHB0bj96YNWAQ+eEa52/OPj/iP4
	 NVnrkgYqICtBjS/LiGwosCSz8qMjydieutKOJ4uaNS32LQeF/guuyCpA9AtDjJ/qrL
	 1bU9ACI9JZphw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so4861273a12.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 01:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxFhtolwIAFrGr9/IeWxOKDe4zh+/qhBdP8a2HmT0RAlrtYLYxtAsXhWf50x2Ip93vP4sVJnOE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmL1knBuH9b+2EoWDXfUz5vonrDQoLmF3n9NYjr26fQ8or92dA
	ZMBZh/WcAtzuP+HErPr1aXqVuhj8nT26NqNtbrBZf7GpCTRysNC2end+89876Dpizn2tNkXgqko
	GEWjlczSaN9mxA9TPyeeVwTfsIdKaU9s=
X-Received: by 2002:a17:907:6d29:b0:c40:3a99:3f96 with SMTP id
 a640c23a62f3a-c4ca7a16292mr723014166b.10.1793611536413; Mon, 02 Nov 2026
 01:25:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102061537.830714-1-icb@fastmail.org> <20261102061537.830714-2-icb@fastmail.org>
In-Reply-To: <20261102061537.830714-2-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 2 Nov 2026 18:25:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-f=SdVTA39eE94=+fNubJWeRXTs2ZzS+6-FsCeaZt9Ng@mail.gmail.com>
X-Gm-Features: AclHuK-hyRelR43z4vxIAD3_xqk-kPEqP5Abiqe2SZ0RUAsb6GnyPJCZfWkYyxc
Message-ID: <CAKYAXd-f=SdVTA39eE94=+fNubJWeRXTs2ZzS+6-FsCeaZt9Ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] ksmbd: let the owner read and change the DACL when no
 ACE names it
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aamir Ahmed <elb12345@hotmail.co.uk>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:16=E2=80=AFPM Ian Bridges <icb@fastmail.org> wrote=
:
>
> smb_check_perm_dacl() refuses the owner when neither its DACL lookup nor
> the POSIX ACL fallback matches. The owner then cannot read or replace
> the DACL over SMB. MS-DTYP 2.5.3.2 grants the owner READ_CONTROL and
> WRITE_DAC unless an OWNER RIGHTS ACE applies.
>
> An empty DACL allows the owner's explicit requests for these rights but
> refuses MAXIMUM_ALLOWED. smb2_open() uses that check for the maximal
> access reply (MS-SMB2 3.3.5.9.5), so even a READ_CONTROL open fails when
> it asks for that reply.
>
> Grant the owner's implicit rights on both paths, for explicit requests
> and MAXIMUM_ALLOWED, unless an OWNER RIGHTS ACE applies.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
