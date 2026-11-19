Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048686;
	b=5KlAUl6klxrAK4b9eM3z5ZrNx8kObU387lBARmeJ3c1p0laO/8DP6IgILv9cVCFo/UZJ
	 fzuhWVum9yxAM9/bvImqk01XI/4jNIXZbV+o+65Sd16MvtUdfO0BP1hUdsshDy47MsYQP
	 G8YMu7ArR4RT1LrJBlLX+yh61H2++20y7S12kEQJhRJGJHo7FtJrRPt/iXgUlbPtNrIgL
	 agGNkmz7xE+h92fVSVq5v9bqRYcS/rOUshRWHmR4tFf5cHJupzhhkNKZQ+LoiRXxxdXJs
	 Rl7AOle+aUobrF8a86f9jIGOhc36/WvXWgniHQZ4+/ZGlLRYHWwEaio+mREJbE3jO9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048686;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PtNQN5iYY+jY31+2PAsZJiMk/VcCexNZzkbg/hmJWTs=;
	b=bn1ZUPrBpHAyav3VCTkxmj81EL+W8bGxwyk/ANUg+lugrQunVC9Emk5HBeAkyE/loF0K
	 cQmy+E8enFEAupV2ytMoUF4ccwb+Rczw+75gV2PWoXvWWh4WXmOxkVhhYAuj37lQHqGbC
	 GjNOwIXwm+GdNQn5WYKSFr7ZcZO9lkTTKIUdyEZt33n5LpM9b6U69Yomh6aEXO17VkqTy
	 /jPnF8imprnglJ48X9GV1OHEoyVa22lJgZyVb6VKFQAmtOHvIu32zZajmpB4MZFtEfUpU
	 OAk+NmqK10fV5FerSJTWJTyGSPZPR7KM3R3zTar9ZDXmudndIKCQxwR/lE5yG1CbEXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJWSzLfr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0A606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJWSzLfr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF51F000C9
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795048686;
	bh=PtNQN5iYY+jY31+2PAsZJiMk/VcCexNZzkbg/hmJWTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JJWSzLfrLWZLBh+bEY0S4ycyK9l/DjHDUguV84PKMcPNyaeevfvpGwjeP5NMi9c71
	 iO1zRMc4UNpYSZkasBAbCngTGqNTi6rJFXgWvtRq2s8zFweQezKoGi+adSu3FXCJ6O
	 Jz2zEwZ5MpvW8GBWHGmgpbcp4rFbHt5FGxPTYixIUfmHWnFt1Au65Knobt94LrSEPq
	 OBpFWYzlhRjvHuF0u8FwPAw53oZZ7YBYF9tAksGmXgb9jk+TO5LUqz1kmmCgQoezRx
	 OtPAjoCfGE1+4hu1Qk1FjFpPlcPfQFYdasd9AECJnfzFloDA6WQMdZa2IRDCpktwWn
	 yQv6f181rk53Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c511c0e2826so135384966b.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:38:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFvJyGB5tDILZq3o9/jrulThLt8D7AHUid3zdX/Bc0UWAMAqxdpudlMKNKH5alhDiTDFQZmSHs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+W9sf77MsqFgAI3tSv5lnEEIhzvURTVmP3cXpKPsoUG2dabmi3
	01Qztfj3csCmt9QYoJrmpmkHDGu+mnFH3yULx82mIN2IG1sp0CXQUWWBD4mmNTp3gpyWQynJKPY
	k9aM6uVAZZPtLfKIH8ubtm8IW833CHr8=
X-Received: by 2002:a17:907:2d0a:b0:c42:4750:8d49 with SMTP id
 a640c23a62f3a-c510e19f1d9mr421000666b.25.1795048684847; Wed, 18 Nov 2026
 16:38:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118173454.76416-1-icb@fastmail.org>
In-Reply-To: <20261118173454.76416-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Nov 2026 09:37:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-KFizCjxU=qm65Aw+3NYoMWGHZhuaJ_7G5w_+4jFp5MA@mail.gmail.com>
X-Gm-Features: AclHuK8obTmEl6pbQBPLiW6u_HRdn8tgal2Bb23iPchjtvXRpFt8tnpt1hRJ6bo
Message-ID: <CAKYAXd-KFizCjxU=qm65Aw+3NYoMWGHZhuaJ_7G5w_+4jFp5MA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: allocate the security descriptor reply at its
 padded size
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	manizada@pm.me, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 2:35=E2=80=AFAM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> smb2_get_info_sec() allocates the security descriptor reply with the
> size that smb_acl_sec_desc_scratch_len() estimates. A compound response
> pads the reply to 8 bytes inside that buffer, so after build_sec_desc()
> the query fails with -EFBIG when the padded length does not fit. The
> estimate is not padded, so a descriptor that fits the estimate can
> still fail. A query with AdditionalInformation 0 always fails with
> -EFBIG. Its reply is the 20-byte header, the estimate is 20 bytes, and
> the padded length is 24. The client gets an error instead of the
> header.
>
> Round the allocation up to 8 bytes, as READ does for its data buffer.
>
> Fixes: fda9522ed6af ("ksmbd: fix OOB write in QUERY_INFO for compound req=
uests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
