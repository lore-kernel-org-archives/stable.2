Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237951;
	b=F83HucNX8iGS3KAG8gbUv/N8ssiE4+rfmGn1C564Q/4gC2cnYbhOCIgVKr5xabsOHUtJ
	 iAurvCY4jVTz2nvxYGf+ilZ1HTlcWgPBK1PJRvvMVC5l0evVWiPbceDZuiL+HSMudfOB9
	 LgKZHY4zEOg3l9FRF9hPSDtLoJux0aid1Zn4ZCEIrLQgwkWLLMgO1McmKZbS0QhkCmZNJ
	 Fu/lG+mRnVPjxKNwYfclyC7SQZ6TlyOr6K5SpP+rz6zX+KhZlFSnqzpvW0Ys0Zzl74YEZ
	 dtWR1YxYWAY7oJqfEZx5IJmlv0j+XyTLcgR+WrQz9jVRjR4kGac/ohff0OxIeV8DbfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237951;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AWuorey2+GfC4KvscU51WE6b6XQx7DkkDB7vjHu7z9Y=;
	b=qW5W2XuXp0Qy+uyEJXznu5OjXQyn+uj/akKQa+G/B0KhtiWieyWdwiD/Zw2I3lJ8Jw8Z
	 5Q/EXHh9b+JJWIzZyufugBTpEbvP4Mu0j9fsJYXSTA04pPHuPVbJLLuaVACdrpKpPUR45
	 oitzHP3Ya3veEAFh36x1nRIREOY87C2wZ32frHeBoMEJYAIk9m9OFhzR54TxvYKcsN5kI
	 sLFI32t9K9IncofRizPMnnkduRqPZxwV9yQbY3Eg8c4n+VzpKc0VNp5bydXu1nuhXgvAA
	 iNvEEx3B7riAGQ/sgOFtUzKaMKYmHQXyL9YzbkZTYhiEV66enK+OJCPfZgEpW90MTmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GS1VH+Yp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79CD606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GS1VH+Yp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F7B1F031E4
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237950;
	bh=AWuorey2+GfC4KvscU51WE6b6XQx7DkkDB7vjHu7z9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GS1VH+YpNnneD+WG5YL0tcbWXKRgYjo4dqxms9kuQExUuGDSuWdA57VmVr61+virc
	 CRov31ZQQem2KOcVKZO4gplufU5lBTjU2ysBDvb9Xy2Y2s0bSpJWtclB7CDAKG2nEi
	 D8pc0LOr0HmqNW7Bcum+7SDK1TLQ0KvV3hY/TEOs8yhiPThXTUjsPKmRlhfYWE8yJp
	 YgWqZiOHJU6/BJ55zukizvmKqqr35NU9ek6/YpIq/oF26oNbiAan8VDJ1suFndkOni
	 fln7bMkPK5NP4ier8BD3j68HT6e05lzY0rMyJ4+H7UszGbBACdEUkjW92h5JXyHBm+
	 1D5CcPt9pk4sQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so251186766b.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:39:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz93Rs+30Gl2SIGu8xPL9t5OdRlrVKtDTq7CKHgh4zy6DuRbYulUWkIaCvcOrWtpXlD8wEPXmw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4SBbybmTX3T4f2euP9DR9P3VNhqBlJVa9bp4+5axPVEkS4xDh
	8rPkcXSR5axjQFi9rsTOQ4c+oQMbJhmFaZ89QddpYrYztYsn8j/qzgz478lS/uzMk8U+EUoIOyx
	CYG67urkmCI31jOO/uQOLZ/XixG24xSo=
X-Received: by 2002:a17:906:24c2:b0:c49:c76f:dad3 with SMTP id
 a640c23a62f3a-c49c76fdf1dmr180329666b.34.1793237949192; Wed, 28 Oct 2026
 18:39:09 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028153441.184701-1-icb@fastmail.org>
In-Reply-To: <20261028153441.184701-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 29 Oct 2026 10:38:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8PwT4aaFgUg82NYZUB=pFNasL2QN7TGGpJVaZjFXCuSg@mail.gmail.com>
X-Gm-Features: AclHuK9zbE7gF0pHaTPVpFsWzwKV08SqtKyYeZaWBxaTFlMoIWOSnmjrajDfLFo
Message-ID: <CAKYAXd8PwT4aaFgUg82NYZUB=pFNasL2QN7TGGpJVaZjFXCuSg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: enforce the DACL permission check on
 delete-on-close opens
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:35=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> smb2_open() runs the NT ACL permission check, smb_check_perm_dacl(), for
> an existing file only when FILE_DELETE_ON_CLOSE is not requested.
>
> On an acl_xattr share the stored security descriptor is the authoritative
> permission model. set_info_sec() maps a descriptor into POSIX ACLs and
> mode, so its read and write restrictions are also checked by
> inode_permission() when smb2_open() opens the file. A file's DELETE right
> cannot be expressed in a POSIX ACL, because Unix delete is governed by th=
e
> parent directory's write permission and not by the file's own ACL. So
> only smb_check_perm_dacl() can check it.
>
> Because delete-on-close opens skip that call, a client can open an
> existing file with DesiredAccess FILE_READ_ATTRIBUTES | DELETE and
> CreateOptions FILE_DELETE_ON_CLOSE and have the file unlinked on close,
> even when the descriptor grants the caller no access at all. Only the
> POSIX checks remain, read on the file and write on its parent directory.
> The normal open-for-DELETE path is denied by smb_check_perm_dacl(), so
> this lets a user delete files that a normal delete request could not.
>
> Run the DACL check for every existing-file open, so a delete-on-close
> open gets the same DACL check as any other open of an existing file. A
> caller the descriptor does not grant access to is denied. An authorized
> caller is unaffected, and shares without a stored descriptor are
> unchanged.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
This patch causes smb2.acls.INHERITANCE failure in smbtorture test.
Can you check it ?

failure: INHERITANCE [
(../../source4/torture/smb2/acls.c:1054) Incorrect status
NT_STATUS_OBJECT_NAME_COLLISION - should be NT_STATUS_OK
]
