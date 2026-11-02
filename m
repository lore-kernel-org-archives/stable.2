Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662895;
	b=mvzQtVrufVViOyKpxBDLphVaCixbLUukEPAJpoCZwXAKjbvdCibRitHGWnbyx2wUr8F3
	 dtLuCUIOL0uE4RhTGO+APjBKLkapDxRvQ5m8KBedL6pyp62gSfc2ww6TVJf8nMZ0N1rDC
	 g/uXcJdx+9Ba+DAUnYbUKXkT5CjaCQ5rwlEIE+OrxEQfGnLxZHtW2wIsDcjHiINmfQfTD
	 5F0ioe4TJ/zbgD9n7eLEkT5dR15o6Dx+WZTYEN0Djrs4rE42LRrZVyRJBcFDmoB3ZN2JR
	 kHy5x+VR47FEgBg8wMamegAwaFoxrpLwyVyBTAPYlQAGxxBNKtLGgDfdUlkCmE5ALcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662895;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Dyb0KNEBDyW9YUH/H8NB1sb2XfBQhpgJT9JPFKBIQR0=;
	b=5pqA+9KTn5bHzZvBM+Dm6fgOf+zDHlXInugax+vsc3ottF0M+AyzNbIx0Y7FMLaezcMO
	 k3hOmP7dvZkySI5DkzxaNrnlasmyLi0q8gyWzQ8LH/lBgiGbhLHVyZ9qjkRG6eN06DmBt
	 6CHIN8S0B8hZP4n31y3IjRRuUYJ2Me7plsx7xAmMBpzFiabRkk4XQZaLpxFNSWvigaynC
	 z4yP7myC4NY1x+2EHkV5cCxyN/6FQGN1cgxoWJYQCKu94JiDOmOhKgSrXj/fDvoNTIXQl
	 EX4pAObDOq3XYezZlAuhGQ9y+rXdOagG4qJiH1p4wXE+uKAYAIp4h92geBx8WWWVaUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcEKMJZr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF81606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcEKMJZr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684FC1F00A18
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793662894;
	bh=Dyb0KNEBDyW9YUH/H8NB1sb2XfBQhpgJT9JPFKBIQR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gcEKMJZraK7/1lnoIxsE4M0dToWDBIVmwxvZeTbAW0zRaJ9SXE5zevsln6eLNtZzo
	 yDxbYFWO3a6eKMh3u+gpl9RLkQfCLMmwPC6UMrPVcpJ7KyYSXdAy7z9hX3WmzNGlE4
	 rp6EfVtsi7JEA2yppF2327WS85/tKckSlQeRLVR3NzvAxu2/iFLplc8+gh/bAHPtdN
	 XupmLrstuma9RYmMcF0Eqo2P6v8HdOjbe4EpfAKxT3JDCq7e7M1nQJIBtSadaVrtQ8
	 11h9HAghsglPYIAc0vQH+rM1a3dnxedJilUTdrxlPWB2bfbloh1G+GN4U+XPJMha6m
	 DwUMS89EGMIMg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4ceaee6770so92362666b.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:41:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzZNPSFmGqGfp+49WCDZqmQLacnOX8UUPy2NN5OY3a4GHUfUHg06MQHtGcal7R/Meft5061K7I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L0/k1L5Ld+mLcTPJWIp3eJqRFx3jUKLjRZROi8IMmucslZWu/
	bJFL2aOB1EBPT8Yj1wPZi/vcMqvx7ZBFBWU7MVvZxSme6zdvkEgFHmyiJz8HpbhwPXW8Wk6QduK
	cuC8+sy9XAOlrzwl8dMES/haRxugI3Xk=
X-Received: by 2002:a17:907:d91:b0:c35:babe:ab44 with SMTP id
 a640c23a62f3a-c4ca740b297mr962386666b.0.1793662893123; Mon, 02 Nov 2026
 15:41:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102200353.884509-1-icb@fastmail.org>
In-Reply-To: <20261102200353.884509-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Nov 2026 08:41:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-s-g2V4LNY8e5SsH=+0r3qLY+AeOa5Lp9K0T5p_tnA8A@mail.gmail.com>
X-Gm-Features: AclHuK9G_vi4S7-_Tc8OkG8LlBlaaJXENvc1ro0Hs3ReisFb84vo12Ihx1bBJSU
Message-ID: <CAKYAXd-s-g2V4LNY8e5SsH=+0r3qLY+AeOa5Lp9K0T5p_tnA8A@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: grant a caller what its groups and OWNER RIGHTS
 ACEs allow
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aamir Ahmed <elb12345@hotmail.co.uk>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1562,7 +1586,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
>                              compare_sids(&sid_unix_NFS_mode, &ace->sid) &&
>                              compare_sids(&sid_everyone, &ace->sid) &&
>                              compare_sids(&sid_authusers, &ace->sid) &&
> -                            compare_sids(&sid_owner_rights, &ace->sid)))
> +                            compare_sids(&sid_owner_rights, &ace->sid) &&
> +                            !(groups && smb_sid_in_group(&ace->sid))))
groups is false for MAXIMUM_ALLOWED, so this skips group deny ACEs
too. Consider a file owner whose group has a deny ACE for
FILE_WRITE_RIGHTS, followed by an OWNER RIGHTS ACE granting full
access. The group deny ACE is skipped, leaving full access in ordered.
The new fallback then returns those rights.
An explicit FILE_WRITE_DATA request is denied, but MAXIMUM_ALLOWED
returns 0x001f01ff, including write access. Before this patch, the
latter request was rejected. Since smb2_open() uses this mask for the
handle's access rights, the client can write if the vfs permissions
allow it. Could we also process group deny ACEs for MAXIMUM_ALLOWED
requests?
