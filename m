Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010508;
	b=mdW97KlRJ1zuDm78srysVHPLAzpgTR24wMK7oCys4z8r8VLWl35vuwnhsiPSDzzp06re
	 dfF7UYf9wmCg6FE+mWUEVLvaHfAqoQSSqzygbGtuRYsufWEnU7O6Z4R9/xJYDdi7D9C9E
	 9IXfDUoy+pprGh64B6c2D5uxFvsceh4yi3gGaV+mTbwd+wC8P/UkSMPStc9w8ShcruJgQ
	 T3U3F4IcMyjlDaOvb6kM5km23F3JeiIQtns358U9PZ3k4oCJxRIlo57FQd+h4AmW/Lz+Y
	 rZ9bjgB7xLkoPAtgrnUhutTgi04ggyUG5qSSwk6GUYOek2DXh3KKWAUfd7P9s/wLKJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010508;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z/Nx//XuiuZSu05RUpnkPaT9G9UcEiJqWLgdwhD3/Cc=;
	b=L/v5R2E+tHZwLOIVmegbmfAQP/7oI7vEd0o/WL8QOmgh1rOuQPQ94gNk2vR2ounptRLL
	 InmdH2WHKLDt6pQeIF6IqNJAE8HP4Hi1B2mCCKUdZ8Cg5iiVi3Y7T3uGOl7usUu/2tR1M
	 h7UMMYbKSYR839OLEBKm0uk0nnuiVxrsrUEQyjcB/5z/SqFqRAhjBIAV2XDqDcIsjBNQ/
	 IqGvooaroyOp7+n76iIBVuHr0tfmrP1twJCJTCD4Cug/o/YFRTJLhoZmJsGcVUDGTMqFk
	 UnodiYZGxPoJvFRkjiMCfmUSHEfiYYpYcwQ+UplP4tkt6feifew0eChaZd6NCzVWRog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddpGZjyA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70133606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddpGZjyA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022B41F01825
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010508;
	bh=Z/Nx//XuiuZSu05RUpnkPaT9G9UcEiJqWLgdwhD3/Cc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ddpGZjyArUV3lMPf3+abTXA2RxrX7mbnck4xVxteZXt6rcbX8IZG4Wn8BBaZlTsIp
	 iZIG6XY0gaxWP61LyYYFLqfdN6wTtwjY8o7bNMweP4ryx5xqecl9K8YtkbszT4FH3X
	 FDcH0xfvBNgknyjKa6WzXv6qq2o8ZjKeEeNFL6Oo1txAxbl720MU6PEgj4wK1R7zXf
	 mo6ho36rvr0GaZyViZsxF0t/F8QRTm4EfmqKGax+yGskx9lo/C10iUO7BbohLf3wOQ
	 gaUt2lDG3Qdb+ypsL6TOJaU+2Y99xcuAgtIiWGqsQN2EYDTKZD7BS1q3wWShpzaXzL
	 7NVr8bBLNB/CQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c45551fa84eso410504266b.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:28:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxw//RDMdZMowjJqena9TnUA2JQ7C7IIt6wC7oekcvtnFVQeIuW6HrCZduKCbRIRyiAeRTLNDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/XbZ3xtILO2wHfAxLA0lX8agI9KRXYE4GgiaxSvzK403vDdO1
	shx002Nj4XCKxpUe7AFTquUq13Qn+oVTGICAOpr/jdzSbFlInaRW2ScPue5QBlvIchrDccDONxI
	Gc/mNnDB0NLGVbBVg+agkvkmGP/0v7Ck=
X-Received: by 2002:a17:907:100c:b0:c46:8063:220c with SMTP id
 a640c23a62f3a-c46bdbefbf5mr535736366b.11.1793010506723; Mon, 26 Oct 2026
 03:28:26 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026053422.61138-1-icb@fastmail.org>
In-Reply-To: <20261026053422.61138-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 26 Oct 2026 19:28:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_muFKkpGfhLuWgXyKuzX6QpJmBBueNa=7SE0SjZwmixQ@mail.gmail.com>
X-Gm-Features: AclHuK-f9k0Uqwon8K6YmJaDhDSPEnRRv4EIXQhAmDV9X7iJqeJ6j76El9biHj8
Message-ID: <CAKYAXd_muFKkpGfhLuWgXyKuzX6QpJmBBueNa=7SE0SjZwmixQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix app-instance non-durable supersede session UAF
To: Ian Bridges <icb@fastmail.org>
Cc: Steve French <stfrench@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, ChenXiaoSong <chenxiaosong@chenxiaosong.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:35=E2=80=AFPM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> ksmbd_close_fd_app_instance_id() supersedes a prior open that has the
> same AppInstanceId. It reaches that open's session through opinfo->sess.
> This pointer is not refcounted.
>
> Session teardown detaches durable handles before it frees the session.
> It does not detach a non-durable open. That open still points at the
> session through opinfo->sess after the session is freed. Another session
> can supersede the open at the same time. The supersede then takes a
> write lock through the stale pointer, in the freed session's file table.
>
>   BUG: KASAN: slab-use-after-free in _raw_write_lock+0x71/0xd0
>   Call Trace:
>    _raw_write_lock+0x71/0xd0
>    ksmbd_close_fd_app_instance_id+0xd9/0x670 [ksmbd]
>    smb2_open+0x3e10/0xd910 [ksmbd]
>   Freed by task 212:
>    ksmbd_session_destroy+0x38d/0x480 [ksmbd]
>
> Fix this by looking the session up by opinfo->session_id. The lookup
> returns a reference, as smb2_break_collect_channels() does. Recheck that
> opinfo->sess still points at it before using it.
>
> Do the lookup without m_lock held. destroy_previous_session() takes
> m_lock under the session table lock, and taking them in the other order
> here would deadlock.
>
> Fixes: 16c30649709d ("ksmbd: handle durable v2 app instance id")
> Cc: stable@vger.kernel.org # e0386cd6498b: ksmbd: validate AppInstanceId =
takeover target
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
