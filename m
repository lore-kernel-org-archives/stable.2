Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179309;
	b=IS1ObsK+8OiVShUWUoPu/6DEfMR4k5T3o0EArTDFwOmXC+KYcizW3T19pCCrbf7nuTPl
	 Q6zT6YJoJd8YwGHvompHBMH6pJ96a5yXyfRGM+rqNujy/aDdASaktTt/kCM2u4w+SO93o
	 FgSIaC6kK3PsLEJJgqjow3dL8DCVwVU7dQkxMoGAcp4/qSUDIrBYEAj3mUi1E11+TjPoh
	 EU2p7lmV2aEA7vkb8ri1eQXDxDXqzyjzbyPdJBcfVvCP9wD3piWncbp2Wvr639zsgJEHS
	 KF2j2r1UgFeybKZxL6LZ81BpZgVvaLKLTk1ECb+8U7CbIHQDToPS3Xb0s7IMVOWTaFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179309;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o0fsosZOYp7Iltbse45HXED8tfR0ddHeSh5Nzos0Djo=;
	b=vRUnMGZop06z2Bf75chdG0hb5oh409Q8eMihErgA7eWdZZ6f0MG7zWEJbI09XKyY2iLV
	 ZPklR8CpbT3s4TS6H6GSAeh1gOVf8pvfRwFRP2u3qF8ZudtVUI2AZCD84M2v7hAVIu+Wl
	 PkGn1iXPlRxc5YihXnVOI3toyiuaoDQxljErT935np5tvAY3yVLj2Z+dQOkYwdcvuItC9
	 RvAKn3JOjdyXVT2aOuVDSV6R7tPTQ9iE4jPIlhRWahwNAf8mmCxauxNMiKn8+vmVEqgOb
	 v+ag9Jrawo7xEm+aCqJkoTpSSBINPlsaRR2vj+XTDTc9cuLXy032wq0hH3pk06+pHsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMpQNTls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA10606A323
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMpQNTls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160BF1F031E7
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793179309;
	bh=o0fsosZOYp7Iltbse45HXED8tfR0ddHeSh5Nzos0Djo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AMpQNTlsTq80HIOtpUOXTa0Euc7qWviHRsrqMz4YhJmCw+N+QgsYsclBq+Cg/oYz8
	 aBStRRUNeRJRl/K1QmlPKrNZhNfaoqGIZol6TYp/KIaFa7ztdflULOvarlhLW+I3jf
	 OUtKZOkbzVYUpEy+hMi0dNyAeBkHnHTCaUpyDyKwJD3Q1Z0JTNnm3rCITGICZVkDoC
	 vfB8fyDFr8MWho5VUG6k3jXj1wsytBs8ONDQSghinoZ/4m1SLXC20ienV7Xl+3UNS3
	 LJVmTlcahChCNSCmWDDDkuOuQXWUqtm4sSS/vStfRni0Dd5SPJlLpbZsFSnjMTQe8+
	 rQ60exy7zRHAA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4697404c2bso96461966b.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:21:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzrOZiaZszthoHkA23MtM6O1Dt/Bn7s4xZbclYhwPAG69LKcwBOMrcfVuP+tA0mH6BGagb7mUc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWD4JguxfaUvyv2VDL1GQBsuvjsKmy3FTsHcbSWnvUZXMbRCWz
	H7ish/Rx8v8lTW1julF4W+MjxRK2zAh9JxHN7Z/M3JVQ0i4jgvJH9VA9DLkrbz/llkm5TcDihAC
	bITOKm1iHIZ2F8Kc8wamoDUKup+yzX5E=
X-Received: by 2002:a17:907:7211:b0:c2e:4e08:19ab with SMTP id
 a640c23a62f3a-c49bdf37143mr126307266b.16.1793179307707; Wed, 28 Oct 2026
 02:21:47 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027152135.138259-1-icb@fastmail.org>
In-Reply-To: <20261027152135.138259-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 28 Oct 2026 18:21:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8nvApw4QPvHFT_M3V8BMS07bH20MFQmi=u+H-qmH_hGQ@mail.gmail.com>
X-Gm-Features: AclHuK97M9BYzX6VPIeWldyUJ41r1miiCZlAMSB4h7QWCrhli_kFhVXJLOrMVoc
Message-ID: <CAKYAXd8nvApw4QPvHFT_M3V8BMS07bH20MFQmi=u+H-qmH_hGQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix session reference leak on compounded SESSION_SETUP
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Steve French <stfrench@microsoft.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:21=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> A compound request can place SESSION_SETUP after another command. That
> earlier command leaves a reference to its session in work->sess.
> smb2_sess_setup() then overwrites work->sess with the session it looks up
> or creates, and the dispatcher later puts work->sess only once. The
> inherited reference is never dropped. That leaks the session, together
> with its setup connection and socket, and every repeat of the compound
> leaks another.
>
>   unreferenced object (size 512):
>     __kmalloc_cache_noprof+0x32c/0x3a0
>     ksmbd_smb2_session_create+0xf6/0x9c0 [ksmbd]
>     smb2_sess_setup+0xda4/0x6280 [ksmbd]
>     handle_ksmbd_work+0x88c/0x1cb0 [ksmbd]
>
> Save the inherited session on entry. After the request has been
> processed, release it once, but only when smb2_sess_setup() has replaced
> work->sess with its own session or cleared it. Do this after
> ksmbd_conn_unlock() so the put does not run under srv_mutex. An error pat=
h
> may instead leave the inherited session in work->sess. Keep it there, so
> the dispatcher still puts it and the error response is still signed or
> encrypted with it as before.
>
> Fixes: 7aa8804c0b67 ("ksmbd: fix user-after-free from session log off")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
