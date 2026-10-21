Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545403;
	b=J0FPbt3NdDwhTqCWLl2h5NbOSoYH+tyfpoGh0EADUl+Mo5xUW/wT0X7qknfs7xbD2onr
	 KhD3mMQyyRer6iWM5j0Ybw7MfUUwmbL2gZ3VLUcGsKN785MNQzeY1C/PPiH+4o4aH6aeH
	 WR4BqkCSpdzoEwXAjCSkkDXA6SxsWKGS5mr9SzpIw5iztTwORwnZz6L60cCceCHAE3fJP
	 IOT/94a3ALgiTcAoqHQPgYTUYw95Fld/Ym/TxX9p5VnkageqyUrd4IiMgx9c3NVu6pTA9
	 oQyB8+by12NM0R70OZwqEcHk3i64/j6xAL8lJwyQlZL1QJPbkzcCarsFDotl1OQGEaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545403;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XQf033HRKJc+nAHb7sUQOAs1qCf2tDOM3C/wF7UdzeQ=;
	b=JczlN8Ho3Iupnk+Cp5HZ3GZ+VB5UwzzDdfjqLwGEDPBLa57543fAhF7l9+kMgKEtJBbJ
	 4ix+ksIWTtMKuO2GzdaQj5QBDw6P5KFrFvyP+Ld2l6YnOUC3u6QErWxRoP5cMfnw11Ddt
	 Av6JjQn7Lfhc8Xf1Fh799N9NHTaNS7ZKy+hCgjDTy8+PfUk4VdQOI+3yGfbYo+VSoNoXi
	 roOax5om+GTQc/yOcNWE/OitgzEh8K4eKO6AysdNMwFLKTGq1cJ7h4RjcouBdaOMA/IfM
	 kJQ6HrGDYmCuFz2AeVvqqRE7DBb7652zyb9qnzf3awuEktMP1jY08Djm6Xhhc+pe0KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7zC1p+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84D606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7zC1p+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BFA1F000CF
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 01:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792545402;
	bh=XQf033HRKJc+nAHb7sUQOAs1qCf2tDOM3C/wF7UdzeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X7zC1p+5JIPTEJoGGdAVY+zGUtkmkg58eKLXH6nNl8jHPcQMp4fh6Mbh2A4MAlqNl
	 BFc4oYa+YQgLzFNxkNl6LGFRc+JVSr4V0Oux6w64/4ZTfyIXa9FJsNqXtT7ynSwMtw
	 ZvKDCJyi1ozcQPnnVu2P78xajxhpo5mM9cx1eueft11E0caJWmdA+EzgMApOZwXutu
	 gKRaYn/Me+WRRGeJ4qvR0ORq4Sj+UMoXZGSkIU5SxWQY4tcSo8XGD2lF3MjMtgZb2A
	 d2aLyHie8unFpXCeJ62nkw75+hQ9wRrpXRqZVQ40FJaK1e6lQL9bXybFP8m7diBEwY
	 GRaAv7/Ly2xqA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4086e892a4so15480466b.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:16:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwv+SrgcgzVuxv2fXvOx8/1BsoYMsdAHbdx1lj7Yazjp0g/6+QB948PeBLrDZ+AaM0r25bb+PQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/A2yIe636uIVD3w9+62Rk0LFrld/nA+Vc4SHlPLrly7NdHZWL
	97GP8Wm57DgRsCQ/CFIlgzfHf6uq7qwYI2h4O56iOAsvfbolquuh1wv/lybjrNDXrj3mMyxmsWS
	vLuz1C60vkQQYWV12nPGYoCE3PtYoQss=
X-Received: by 2002:a17:907:2d92:b0:c46:645f:ced9 with SMTP id
 a640c23a62f3a-c46795e8002mr51901066b.10.1792545401324; Tue, 20 Oct 2026
 18:16:41 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <AS8P251MB000104EEF679ECC44D8791F2C8B92@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P251MB000104EEF679ECC44D8791F2C8B92@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 21 Oct 2026 10:16:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_cyS11k387nM-DfNORyZbTpexC9dQBtDjrhjy2FQKT2Q@mail.gmail.com>
X-Gm-Features: AclHuK-ZDQ3NXb3m5c0xNio5bQaHfkfxZPyPk1f2Yr4vlT42M-8V3UIjNVEiMaQ
Message-ID: <CAKYAXd_cyS11k387nM-DfNORyZbTpexC9dQBtDjrhjy2FQKT2Q@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: deny access for an empty DACL instead of
 granting the request
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Steve French <stfrench@microsoft.com>, Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 7:49=E2=80=AFPM Aamir Ahmed <elb12345@hotmail.co.uk=
> wrote:
>
> smb_check_perm_dacl() returns the access mask it computes to the SMB2
> CREATE handler, which uses it as the granted access for the open. For a
> security descriptor whose DACL is present but contains no ACEs, the
> function is supposed to deny access: an empty (non-NULL) DACL grants no
> access to anyone except the object owner's implicit READ_CONTROL and
> WRITE_DAC (MS-DTYP 2.4.5).
>
> The empty-DACL branch only denies when both
>
>   - the DACL has no trailing bytes (pdacl_size =3D=3D sizeof(struct smb_a=
cl)),
>     and
>   - the request contains bits beyond READ_CONTROL / WRITE_DAC.
>
> In every other case it takes the shared "goto err_out" with rc still 0,
> which returns success without modifying *pdaccess, so the caller grants
> the full requested access. Three problems follow:
>
>   - The READ_CONTROL / WRITE_DAC carve-out models the owner's implicit
>     rights, but the check runs before is_owner is computed, so those
>     rights are handed to *every* caller, not just the owner. For
>     READ_CONTROL the SMB2 CREATE path does not fall back to
>     inode_permission(), so any user can read the security descriptor of
>     an object whose empty DACL is meant to deny them.
>
>   - A request of exactly READ_CONTROL and/or WRITE_DAC is granted to any
>     caller. WRITE_DAC lets the handle rewrite the DACL.
>
>   - A DACL that declares zero ACEs but carries trailing bytes
>     (pdacl_size > sizeof(struct smb_acl)) skips the deny entirely and is
>     granted whatever was requested.
>
> On shares where the NT ACL is the authoritative access control -- e.g.
> "force user" shares, where every client maps to one POSIX identity so
> POSIX cannot distinguish users -- this is an access-control bypass.
>
> Compute is_owner before the empty-DACL branch and deny access from an
> empty DACL unless the caller is the owner requesting no more than
> READ_CONTROL / WRITE_DAC.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Applied it to #ksmbd-for-next.
Thanks!
