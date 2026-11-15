Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794750790;
	b=y3CHyT8pJ6eu3tA8a/dZ4fgDZioAqQhmdg36fGyF64RAxw8QjwurFxbdOjZbAyV6y0R0
	 h8CjsqwqxSgw5ra3JQRGx5IMzGQFtZuESbW+nY7+0Jn56YraWcdBwKcicERCURI0D5m5L
	 tBkqWlE40tkA0JZn7VP1Ec14e2itLQN3xjOlMHK3Tm2cFVBVISxsBZba8h8rodGGKCVRV
	 dppMuvYHznabXybfqgDNc082m0Hv1IEmnUjf8RLGlT1rcZjIdAhhp9mUrO6WxmGmYRUa3
	 lp8MsGwzbaV1G0VbZkrENULgorJ292lWntOQ7TFJzK4JGWUjjAZpqPWLlkfvZ58jDOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750790;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fmKXw7Sp/MNvZTSb4xcRBsLRBVw5OzncMgLzcyPSN0Y=;
	b=LRKVIKrSGhso+We9wcaGgs+RD1WGC0s7Kybap1i3GzfaCcY3ljYtVGvy/x8szgv4ePuk
	 b8RIohEk/jqaoVzzT5PYr5SbMVekScDqFIVftou54gqoAP3d9V68Mxy3S9eLJWm3gFwUK
	 rPWX9CW4qAR/SSyfTHSntYYL0iIj5sZmaeCz9lxWUhwfgi+2YwBCRZFYkoWw0FbptrUtD
	 J62Yrvd+s+vFz7bqWanMbR7pBC1p5qBkqZL9KfCE6A9D13VMcT+3jixK4JolG2xzKWmyW
	 JYmif8u/n/NBJd1l1Bm2D+LUcTXaL+B4ASn9jwmfgWXxcOR1DiAetTYc13jHAHyNa/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Umse5wP1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D5606A33B
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Umse5wP1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041FC1F000CB
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794750790;
	bh=fmKXw7Sp/MNvZTSb4xcRBsLRBVw5OzncMgLzcyPSN0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Umse5wP1+g5ZjdU/edSukKLDYhwuE+VrhK1TQzLQD/zvn7110aHBYDqcDuvTQ1dmA
	 R6ayqisUdEbD8ztajANSM8AzqaPQ+vawzwQcwQhQU22gzy6JX5TExK8TTCk5EXMqpF
	 Zxj8/GORSs9l9AETbEDWsqd7gaqHuyBoXnuGilYMwZNltaBdCtXs+dqITvWGl1xBWd
	 efyBGNm3ms7nyA0v3yE2cK/GIUIt7fc/sRSgMIn7tFDmShJimQVc1kVMHFflhGee2R
	 J/ONdotLkCbp+hTHlSwd0iB739tyD1V9q1dW8Eogaz/A3duOIpDjLUblOfMhwME3Jp
	 u3iKdGZtJoC1Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50cc7540b7so63415766b.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 05:53:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEwgQhk0gxAuHUxEpxdU70Tk2NiBFuauU35jtivMJ9P5PitFtgNW8YLTyR1RgEjLcyGSh/m8PE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RTAS/cAoHo2rMcmFMQ1am5dujMMCQSLyeNCdLIUESHiIxE++d
	rybsHAK0KF90uBltphA3yvX9dYiapHgVe/kFZZ/bNbK1PhpItBdQOTBoPxJpCdrph3SMbfA9Toa
	7EGV1NpJZVcEGQzykhQFDbTJuUhf/qVg=
X-Received: by 2002:a17:907:94c5:b0:c50:576f:b3a8 with SMTP id
 a640c23a62f3a-c50963d9089mr835079466b.48.1794750788588; Sun, 15 Nov 2026
 05:53:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115131047.2338285-1-icb@fastmail.org>
In-Reply-To: <20261115131047.2338285-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 15 Nov 2026 22:52:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_c8GCg58jTKw3shF+aFmR8KaDx8Ve4wQUHMjoZ6PT4wg@mail.gmail.com>
X-Gm-Features: AclHuK98yWzx6FWaTeowYxcy45zR74kQejiLyKPT7sgUKp8qn5-gwUVdz8a4ndE
Message-ID: <CAKYAXd_c8GCg58jTKw3shF+aFmR8KaDx8Ve4wQUHMjoZ6PT4wg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix smb2_cancel() use-after-free during request decompression
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:10=E2=80=AFPM Ian Bridges <icb@fastmail.org> wro=
te:
>
> smb2_cancel() finds the request to cancel by reading the SMB2 header in
> the request_buf of each queued struct ksmbd_work. A queued request may
> still be in preprocessing. smb3_decrypt_req() decrypts it in place, and
> ksmbd_decompress_work_request() frees request_buf and replaces it with
> the decompressed buffer. Neither runs under conn->request_lock. A
> concurrent CANCEL can therefore compare a transform header as if it were
> an SMB2 header, or read freed memory.
>
>   BUG: KASAN: slab-use-after-free in smb2_cancel+0x73b/0x840 [ksmbd]
>   Call Trace:
>    smb2_cancel+0x73b/0x840 [ksmbd]
>    handle_ksmbd_work+0xa90/0x2110 [ksmbd]
>   Freed by task 53136:
>    ksmbd_decompress_work_request+0x10d/0x180 [ksmbd]
>
> Record the MessageId and Command of each request in its struct
> ksmbd_work, under conn->request_lock. A plain SMB2 request gets them
> when it is queued, because its request_buf does not change. An encrypted
> request gets them once it is decrypted and decompressed. smb2_cancel()
> matches on these fields and skips a request that does not have them yet.
> It no longer reads the request_buf of another request.
>
> Fixes: 6639b6928ba2 ("ksmbd: handle encrypted compressed requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
