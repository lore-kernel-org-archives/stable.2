Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412657;
	b=quS174b6pTmXQf1nLVOXTyskj2VFzjOUGUth5V1qhfe9oi8S62R9tcIOqll9ZDSR0AHT
	 rLoYGlZo6IrZKS67PHRTqjFFTr/x9R/Z7PEOSjvfV0MouFwQ4J7B8m+eFBpYVFkm5p36w
	 1fpMiGluv/NPeu7idWt3qLojJzhCQ2d0kXOnrFyPi5mlZEmq2Uvq6aogdott2zUBfdD9h
	 gsDxuXRHXHOqzK9p4Y/v27wDqwX0yhXQp2eCHxC/m5cNmlOBN5H87ijqt0phzdcX9cmR5
	 FeR4UVdhFXnw4STcHK+rht7AHo6J2POGoIjhtuYSqhlINClHvffozv1Rd2PoO285qTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412657;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qEwymFVp2Zq2jgvCpSYjWSfGxMjlENvd9A4hKHtWv/0=;
	b=hME+m+OzC8ZbfZHrdosYo/C6emiSuNmzfN+F9KSf5r6Y00IBZGhsFFJu26tDlC3j++5Y
	 tK5aAjn0rN5KjSiQZvEsAzslmDASiR0KPod5J0NzfwJfrCEB/Jct8azjcawBp4Mxljt13
	 Ti9HeDimW2f01a3nKtQs9SPFGs1jb0E9Nc3yu0MYNxET1YJulQ3e6RkIqgv4SUwOmhaEP
	 bXGwb28YfZgecbj3ygZR/vRZvTjEszOzO3BXyXp4u/LPzYulGfgf6qr3OfPY+Cw9E66/8
	 ZlEf+VqkqK5UpDTy0Gq2Hi6T3maBfv9HWIEsScEOY25ld5IObc6faF4OA87k9aZy09Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5hIO+W9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98AD606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5hIO+W9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D201F00A02
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793412656;
	bh=qEwymFVp2Zq2jgvCpSYjWSfGxMjlENvd9A4hKHtWv/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f5hIO+W9GkiGL/k4n4TrpsRrhCRoPE/baLsosaGfiDi5TuMBScdGETNtWvLWYnw0L
	 /1xR/bLOrZkgXxVJH7+GQVkSLUI6/NI66dbpP84wsCHnhQ6U2j6eNwOUfyF69Yo/NO
	 ZLDOtA7F0BbcA/+LvCdkIsBINTT7WuvbKSYaBD0pDCNB1Nn5sDz4al/LoYFj9oRm3g
	 2uc6lRtEm3/s+pK4ZZ1mxYuGap8GEOSFV5jrsg2QNec1c7mF7OThrbjpePiByJ6xWL
	 tYKu3LLEfL3UQEHh1h04YkCBCoCbA6Y7dyMLahL9ITePScn4OtMbQklOYmypj0szYp
	 y5skg1pM0yRFA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so1434369a12.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:10:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByyaYTOThVLzGWGOw/EAckUuc/iVAwDAuoIGlylIdkBg3k55vSnc/JmXdC+jvNG23rtlAW7nu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjcNxwGBRbepyMy2CbLzOrAjcIYcInf1NoAMuxcbYZpaTF0AUP
	k7AVf8hVgOKlHEn8FzlNj4ZKGXDyeSvUWwavOoiT3akDlT+ntgYEhpHnBwhLszNjr/CYVjWXbY6
	03LAd39Pv51cWxbohn1PjZZD1+eoLERA=
X-Received: by 2002:a05:6402:1bc1:b0:6b4:5f9a:528b with SMTP id
 4fb4d7f45d1cf-6b4d5ce83f4mr2182825a12.36.1793412655304; Fri, 30 Oct 2026
 19:10:55 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030020523.302085-1-icb@fastmail.org> <20261030020523.302085-2-icb@fastmail.org>
In-Reply-To: <20261030020523.302085-2-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 31 Oct 2026 11:10:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9_=P_ruM+mnF6j9L-sKP3fdkK3-SeHBYwF5FpmwPNUFw@mail.gmail.com>
X-Gm-Features: AclHuK8IYZhS44FO0B57D4KDqQnvzDJhfZCOVTn-ExASVAhMYT89hRfnPPbtJ-Y
Message-ID: <CAKYAXd9_=P_ruM+mnF6j9L-sKP3fdkK3-SeHBYwF5FpmwPNUFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ksmbd: evaluate the DACL in order for requested access
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 11:05=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> On an acl_xattr share, smb_check_perm_dacl() evaluates the whole DACL in
> order only for a MAXIMUM_ALLOWED open. Any other open is checked against
> a single ACE, the first one whose SID matches the caller.
>
> If that ACE is a deny, the caller gets every right the deny does not
> name. For example, a deny for writing grants read. Later ACEs are never
> checked, and an inherit-only ACE counts as if it applied to the file.
>
> Evaluate the DACL in order (MS-DTYP 2.5.3.2) for every open, as the
> MAXIMUM_ALLOWED path already does. The extra rights that path gives the
> owner, and the execute right it adds, stay limited to MAXIMUM_ALLOWED.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Can you check Sashiko's review comments ?

https://sashiko.dev/#/patchset/20261030020523.302085-1-icb%40fastmail.org

Thanks!
