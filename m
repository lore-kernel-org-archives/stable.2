Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793293767;
	b=UKqRPtWhJeyk9Tn9f/eKTn2ofUe5R0353KoR1xVEOl/sOGoiQsZY415n4FErXmRBXOl5
	 At6Ju7Vg/KztZEo3XSJ+CoB5uOhnVQnsdmfV484JeCdk1Nf2tRJRvgev5YCZEwtQRoK9K
	 G7sabIH8VSdydkAz3ZNwri7mJsBkWqyUb0gGQJu6zMept72S50PWN3kehFWKUCNWGtgMI
	 HisTejrlIDKc8M4n0mDyHL06ckWnu8nHtWnE8jdOiuAn9NqSTHrzQZm91a0vYZhgbyMEv
	 8OzKBGOkKtM5Bs4ibXM6RHZ+JRlMH8xYJvTqK2lC8nH2/r7EvUbtRlBl9rcPF8YF7Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n5CrxIdnLHrI4ftpsB79WHBSJ2U5HNFlrN9+LthF+nk=;
	b=ANrzICtjHBbZFtZDap0SIbdc+F5pjvz7aZIBPPqkmvFnRKbSsYpQbE/RagV1ouEngGLr
	 zlJWzRtCmha7du0shjlM2tLXPQUVAB4LDrfjNqiV8T9ankbpfVtXr9hF7CLUr+3ty6L+s
	 z6G7DB7GCWDtOOQ7yvyGB8RXBNTfFKzY/xcngWYXceDctsKBW0Vf+POxQMu369nFLXJuE
	 Lz4s2uG4+5QEXr4dRd2Ueb517rkm2ObOczZe9AaQsV/JZk9GBF8tykg6FxBv71UQtt1Ge
	 SriL6CU6AyInBKc2IcbXuSWS/9jONHAYW2WqaL3tJmfs6j3prfPrvmMalCtEMhpVaJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHRgtcfR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3DE606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B3DE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHRgtcfR
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so2790255a12.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793293765; cv=none;
        d=google.com; s=arc-20260327;
        b=qC4jPvqXlihlYHyO3udG6hMEzJMRrpwCXnQHTCY/GQrb+1jHhDwyAevDZi51T6wGgj
         I5yXCUd9nGU3hgoO0IsNHJ1a/rIluJ0PiwI/3canhF7I4rDKy6WDhAEsKX/js6xeK2lm
         OdCZqWFgCIEhLxmDgd9QFNl2xUyQACkMJgtQqtiSMb/rgZ4mZC2pgZfYudA++mmDuSvh
         Hy5USIxTWt5RDaJJ7RL1uAwHn4TLaglQ5bN0Pi/4c+gcRXgYkFOuzRphO1rASBDTEJSH
         63gDkLbTDC5v47wqUHO0GyQALZpMNCBJNGfxXoTtTuQ2APyKg1ZXPGKTqq9eDM00n+jP
         RYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5CrxIdnLHrI4ftpsB79WHBSJ2U5HNFlrN9+LthF+nk=;
        fh=UmMlyMkZ33AsIPVAVjmldRM4+VgwjW97202/R190CFw=;
        b=A/mEyJ4dh5iSbCw5+z6hOBvmVdbLw2hcjjEjd8cUVOrTGMaoER9IfKnQhP2PDuGr13
         IQfxQP3Ew/rv7vDenn0OWEEVn0CrevRLipcfYuedpz+pAu0hKz6HZU2sUCcZswf7M9iq
         UihI9m5xDElD7ibAlR70aJ/xbzKcEjlpKNJi1R7CvHXxhqbQLYx9ycXstROIP6NKlZiA
         gFJ4xdlR2b7+ipVroX5Cz95D260YBmNvXmUtJyRE+Xu8xFvb4rDxw8PvszxkdKcB9h9s
         mMcmaATLHtRKKNZ5W9oaH/wYB74uGE9HAm8jH/Gm+sz7o0AIZMl3TBUJprQoHz5c3n+I
         kB0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793293765; x=1793898565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5CrxIdnLHrI4ftpsB79WHBSJ2U5HNFlrN9+LthF+nk=;
        b=sHRgtcfRtujwso1fgJmrsF7rrmHv4F4Zpr8X8fxVKLW4d2rVNFOobOOT2HNMTlLxhj
         t9BGwaIcJOr71hQzS/kLIC9q7JEX1n47xSmGpayt5S1slWaCjFgYmMEDG9iKpJPzOye+
         Wc1qCFquAx8KpLo0bRsLsrhb0R4hLSAhlzpQIXw11kcTQdvLV0anIwvbBEV7esRLbN5V
         +qUbcH4qtagqLVOYsHOV7OHedWMONIV510vMwUI6HRnhEum0hY+Tq9nrnx06LqubKUrm
         +B+ivfLUac+hoT0zXmT/hfrXvZDStmuMeN7jAsYmt/NfrkdEvCW7QYMfRTK3g8zOrspC
         qAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293765; x=1793898565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5CrxIdnLHrI4ftpsB79WHBSJ2U5HNFlrN9+LthF+nk=;
        b=WKNmE079jA70qv8rbQpqgzNF/TbrPSiiqmw20iWE3yansiXlfmkWTKgJ7/p0p4yG9r
         3EKo3FtttZ7EHGMbD9864ebLdlb7ryMLuKLHd8Q3TZ7E6ARCZNuS+EZEt09nGwl+e0il
         o4A7UWoitoIusPYeUTxANVuU36UHmZIPv1GU3xiqg4S/eGW8pa1Rz0X9CojijWbB/dW/
         IYnSpz5wC3xR2SIVRLHhf94QG5k0DEKUbFmdqkIk12fl5VMwGiO7Qb1hIulH7AGmNBR3
         aaGUB/nGd97Mo2ts5wrrIrrgKp5zFFHli51BtlbKThOcStgOQEQlesNemLneyUaHIgus
         kVRg==
X-Forwarded-Encrypted: i=1; AKwUvBxPTNzh6m4vZXUiLb3NvzUzLUnHLnpA284X/EMnlDrJfUNEKQTIT3prmMOIIOCM66Ea+T3bXbU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+q4h050SiMmWoRZMqsoa8QDr2iNLJ4CucOLd6BqmxAqXgX6ZB
	K0JqTylZY3otxN6s/s1MiKUVUSB6MAVbB88cVfHRnjCgHxI5EEiHTpfh+1g7JondFNFE+JcHG/N
	4amNQ0TxDvy374iuOPznmCrukud32FQ753/2F848=
X-Gm-Gg: AYBFou2x/2YqXKEKK1NRjE2uNSigWpxziULI4UAy/IykPhjfdAKw9WYZaP8mC7NzHLX
	v8p/yzaCXdwJ+2aoL2OjVnpgc8OAJAzBNfQ4XyUugflD71ucN26SMh6EEUdYEXaQakT46rQ2i95
	glKTmXn5y2+D2qZQ4E1MZWg6YJnH4rYyDc46WrLHFgyh1CCDjV11AqLR/Ho/3AO0MriRLu2h0me
	2wG8mwYmrjA01SCHluvyoKyIcptiQ0Jjj1yAXg7Ah5y2AQBn408Dv2DXfJFZ1DlMRBBM6o3H8Gq
	XY7cSbhvRZJi/IjYGNNyoe3ARuS0txTGIJgsxHjGFJJyJVTqdllTsr3ndn3LZf9yqKCze0KoZHD
	N2BGPTdd+7XxsxNZ4uQ4NN0/ToAbVytiESOjVYVJnk+SAXoqrh0pcC1HeHjeoyK5JdVxwkvtMQD
	uLh6KlIlQstbGDU7A=
X-Received: by 2002:aa7:cfd1:0:b0:6b3:c382:364a with SMTP id
 4fb4d7f45d1cf-6b49cc12254mr3101007a12.35.1793293765251; Thu, 29 Oct 2026
 10:09:25 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-fs-ai-fixes-v1-0-88f22792f6f7@kernel.org> <20261029-work-fs-ai-fixes-v1-2-88f22792f6f7@kernel.org>
In-Reply-To: <20261029-work-fs-ai-fixes-v1-2-88f22792f6f7@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 18:09:13 +0100
X-Gm-Features: AclHuK8Mk1uWay8TR8m6wNWSt-hr7nW1jofiuRs6EA2tpf0YUkmH554XzChvDMw
Message-ID: <CAOQ4uxjEa=bMJ+oMJs+EhSDo_0mhUx93uAy10AJ-y8wnHykoQA@mail.gmail.com>
Subject: Re: [PATCH 2/3] backing-file: enforce append-only and immutable
 backing inodes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:00=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> FUSE passthrough opens the backing file anew whenever the FUSE file is
> opened. fuse_passthrough_open() passes the flags of that open to
> backing_file_open() which opens the backing file with vfs_open() and the
> credentials of the server. But vfs_open() doesn't go through may_open().
> So the backing inode is never checked for S_APPEND and S_IMMUTABLE. The
> checks that did run were done on the FUSE inode and that one never has
> either flag.
>
> So anyone who may open the FUSE file for writing can overwrite an
> append-only backing file anywhere or write to an immutable one. The
> server only has to register the file and a read-only or even an O_PATH
> file descriptor is enough for that. Registering requires CAP_SYS_ADMIN
> but the writer can be any user that the server lets open the file.
>
> The FUSE inode is checked instead of the backing inode in a few more
> places:
>
> - do_mmap() refuses a shared mapping of an append-only file that was
>   opened for writing. A FUSE file opened with O_RDWR | O_APPEND passes
>   the open check and can then be mapped shared and written to at any
>   offset.
>
> - fcntl(F_SETFL) and RWF_NOAPPEND refuse to take append mode away from a
>   file on an append-only inode. On the FUSE file both succeed. A
>   synchronous write still appends because the backing file was opened
>   with O_APPEND. But an asynchronous write is submitted with the flags
>   of the user's kiocb and lands at the given offset.
>
> Do the checks on the backing inode. backing_file_open() refuses to open
> an immutable inode for writing and an append-only inode for writing
> without O_APPEND, just like may_open(). backing_file_mmap() refuses a
> shared mapping of an append-only inode, just like do_mmap(). And writes
> and splices to a backing file in append mode fail if append mode was
> taken away from the user file.
>
> A FUSE file that was opened before the backing file became append-only
> can still write anywhere. That's what happens on the native filesystem
> as well and the backing file of such a file isn't in append mode. Two
> differences remain. F_SETFL succeeds and the next write fails. And FUSE
> reports EIO for a refused open because it turns every error from opening
> the backing file into EIO.
>
> overlayfs uses the same helpers but it mirrors S_APPEND and S_IMMUTABLE
> in its own inode and a chattr through the overlay never sets them on the
> upper inode. So for overlayfs this only changes something if the upper
> inode is changed behind the overlay's back.
>
> Fixes: 4a90451bbc7f ("fuse: implement open in passthrough mode")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/backing-file.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 5614cb7801e1..2424dc38d21a 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -36,9 +36,21 @@ struct file *backing_file_open(const struct file *user=
_file, int flags,
>                                const struct cred *cred)
>  {
>         const struct path *user_path =3D file_user_path(user_file);
> +       struct inode *real_inode =3D d_inode(real_path->dentry);
>         struct file *f;
>         int error;
>
> +       /*
> +        * may_open() checked the inode of the user file, which need not =
carry
> +        * S_APPEND and S_IMMUTABLE of the backing inode.
> +        */
> +       if ((flags & O_ACCMODE) !=3D O_RDONLY) {
> +               if (IS_IMMUTABLE(real_inode))
> +                       return ERR_PTR(-EPERM);
> +               if (IS_APPEND(real_inode) && !(flags & O_APPEND))
> +                       return ERR_PTR(-EPERM);
> +       }
> +
>         f =3D alloc_empty_backing_file(flags, cred, user_file);
>         if (IS_ERR(f))
>                 return f;
> @@ -263,6 +275,14 @@ ssize_t backing_file_write_iter(struct file *file, s=
truct iov_iter *iter,
>         if (!iov_iter_count(iter))
>                 return 0;
>
> +       /*
> +        * F_SETFL and RWF_NOAPPEND can take append mode away from the us=
er
> +        * file. They checked its inode, not the backing one.
> +        */
> +       if ((file->f_flags & O_APPEND) && !(flags & IOCB_APPEND) &&
> +           IS_APPEND(file_inode(file)))
> +               return -EPERM;
> +
>         ret =3D file_remove_privs(iocb->ki_filp);
>         if (ret)
>                 return ret;
> @@ -309,6 +329,10 @@ ssize_t backing_file_splice_write(struct pipe_inode_=
info *pipe,
>         if (!out->f_op->splice_write)
>                 return -EINVAL;
>
> +       /* splice refuses a user file in append mode, so F_SETFL cleared =
it */
> +       if ((out->f_flags & O_APPEND) && IS_APPEND(file_inode(out)))
> +               return -EPERM;
> +
>         ret =3D file_remove_privs(iocb->ki_filp);
>         if (ret)
>                 return ret;
> @@ -338,6 +362,10 @@ int backing_file_mmap(struct file *file, struct vm_a=
rea_struct *vma,
>         if (!can_mmap_file(file))
>                 return -ENODEV;
>
> +       /* do_mmap() checked the inode of the user file */
> +       if ((vma->vm_flags & VM_SHARED) && IS_APPEND(file_inode(file)))
> +               return -EACCES;
> +
>         vma_set_file(vma, file);
>
>         scoped_with_creds(ctx->cred) {
>
> --
> 2.53.0
>
