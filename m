Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179330;
	b=qPfJLsicN5arH7q1rIttCh23iX3iiCu6Ns6prhA5l/QumD1nxBmlo49BZWSOgKS7C4kq
	 18qxicQ3JaQn61QucrsVzBSxl/i4NINHDmYlzNJhlR3xDxB6P2DP2L65zAt4ScPjEE4iA
	 it3cvjh+PGyyVt21hL7Tkn55LZR43FoVNNEPcm7WiAlI5jQPLJJuJ4/dJwknfVCQrPZAl
	 HaeGtef7o6Mn85UP9iW98xDElkSu9N+cFRsRV29hsGxy9xo02yHv39gOUKEjDH+wjTyED
	 G6hitswdpyFiMmuimUjeKOns5TxhtSmq6SRkKcGTunE8Tfry/4AnhkJBMq582XmVX4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179330;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hcY+X85m3AyWpJktejWbKZDNNIF552M/3mrqBFdc59E=;
	b=tt/LTZSwCnxrTD3876wYAFv8pWnViRuWJpoTt79zg9mBXUbuZkIwOo0ETKngrV4zG1oV
	 BgxmGUBY999UzSlf0mxJgzs/jzu7/0kmR8cmoYmMsciSPmBAOecyO5jDN1K9q3acDgWt3
	 t904weWv3Ot6b6WS42Q1HBGxhxFgz3//8sx2E3vhMfH/2CCM0gzy5UsL2jqAgrJrH+gFw
	 if5TkCjS6b7Dt5JnI7+gW22Scz1ErbAydZFbsn4zEaLGxNIvWuzOKhCN8FjDqltS9nVrE
	 ejYl6bNcIKlDaP2AD2/uVBpZH/MKWIQYD2TW58/gnOLKnWTj2VABNgttqyx+By4tX8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOD0WjcL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC68606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOD0WjcL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B40B1F031E2
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793179329;
	bh=hcY+X85m3AyWpJktejWbKZDNNIF552M/3mrqBFdc59E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OOD0WjcLZskXVS+6HeYpFM7vAg8qQGwTupaQ4WTW6wfMJ9HC6f79dWKlpV8d1LRxA
	 vo7ywX+9UJ93f+fL9bTdqI/a1ufmLGXHp5WNykyzoQs3e2tTvIV6UO8raqDGYeO4jB
	 VJsFEFZRz81rSyhPNHY+o2Y5dfksYJQoK07NNUj4miBZyLWHB/4SpViffbiOfiCgFF
	 2j7eK4ToakgBew2gfqfZueP+ljkVVkx9owMC8Hianuji884T4HGxLrhbj7LacYggO9
	 SM8S6T+R7YhOSm35pXJMGKYFJA6k3ZKQCUvPnV4KVGzOhZHH9hOR/STAPWCFaW3mlO
	 Y0wNb+M8sz6rA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c43373ae89aso95548466b.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:22:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxDRcPInpbebAhdk4KhYSDQn8Fy2sBcLEfqOULLRn4tlyEM/0ftBELwguQKkHiIexdXCqzjbjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu2qKsvWTIGGcfr1Wtx+osJwcIiH4RZDL109qrdwFY/EzLz46C
	ctMuzlyYDPt0TRvt3tIC06yXQVlYmXXJOm8PeTOquPcnHSL0hkBIMprtX6vmfdL7aeV6jbhkjeQ
	N/xlHPIndzXKK6HuK04GMPn+yp4wm36o=
X-Received: by 2002:a17:907:720b:b0:c3f:a2f0:6cb with SMTP id
 a640c23a62f3a-c49bdf2c6fcmr144196766b.18.1793179328235; Wed, 28 Oct 2026
 02:22:08 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027152519.138444-1-icb@fastmail.org>
In-Reply-To: <20261027152519.138444-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 28 Oct 2026 18:21:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9szApOXC1NOQ_9HfT2NnJ+Q_MQmSMdsiJicaeg0mQR3g@mail.gmail.com>
X-Gm-Features: AclHuK-OBkk1Uz8qpQiUILz-tENYGIxIIBdIXXpbtOr2anft58LiTRlzFQxjsXU
Message-ID: <CAKYAXd9szApOXC1NOQ_9HfT2NnJ+Q_MQmSMdsiJicaeg0mQR3g@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix use-after-free after a failed durable reconnect
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Steve French <stfrench@microsoft.com>, 
	Junyi Liu <moss80199@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:25=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> ksmbd_reopen_durable_fd() republishes a detached durable handle in the
> reconnecting session's file table and takes no reference for that entry.
> If smb2_open() then fails, cleanup relies on the final ksmbd_fd_put() to
> remove the volatile id.
>
> Two reconnects of the same handle can both take a lookup reference before
> either attaches it. If the one that reopens first then fails and drops
> its references first, the other request makes the final put through
> ksmbd_put_durable_fd(). That frees the handle without removing the first
> session's table entry, so tearing that session down writes to freed
> memory.
>
>   BUG: KASAN: slab-use-after-free in __close_file_table_ids+0x14d/0x740 [=
ksmbd]
>   Call Trace:
>    __close_file_table_ids+0x14d/0x740 [ksmbd]
>    ksmbd_destroy_file_table+0x76/0x100 [ksmbd]
>    ksmbd_session_destroy+0xf8/0x480 [ksmbd]
>    ksmbd_dispose_sessions+0x13e/0x200 [ksmbd]
>    ksmbd_conn_sessions_cleanup+0x4c3/0x6d0 [ksmbd]
>   Freed by task 1030:
>    __ksmbd_close_fd+0x97d/0x1000 [ksmbd]
>    smb2_open+0x14eb/0xd9f0 [ksmbd]
>
> Commit 3515503322f4 ("ksmbd: fix durable reconnect error path file
> lifetime") handles a final put made by the reconnecting request, but not
> one made by another holder.
>
> Remove the volatile id under the file-table lock on this error path,
> before the references are dropped, as ksmbd_close_fd() does on the
> request_open path just above. Removal then no longer depends on which
> holder makes the final put. The stale comment in the reconnect cleanup
> is updated to match. A successful reconnect is unchanged.
>
> Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
