Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A231F985
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905134; cv=none; b=e9WvffyHfKgfC4smuuV8z+K2LKpJYNWvPSYTU7uKWxYYw6Y0ayfTnXwn7EJ36Vxk394xiiVU+E9EYipnO3MaTbrZoIRG+DM5LZGEfAAQ//oHYHMI261XEe25fSbNk4T9yvJZ1bXXLBqdXew9fOV4i0T24bksCf2+zqyIvWKgq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905134; c=relaxed/simple;
	bh=5ovfIpmVXFvr/oeeGQCU99vBPdoxb3I/jtMbF63CU7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2ADc5md+yS46PBsAupuqHvxhhtFhgLWfMk7hZsuFPOn/N0AGgqNHdqjxJZYEXdJoXBJHt2sSB10axWB1OQBg4ebqq5M8ZTDFo+9XSymYZ8QKtKEBMCK7BIiHqnfm+Z2i6dIEQRTBEH2djO6JR+x4qqsxD9GgqviVvEpmR2b02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He5WRA6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He5WRA6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164FC1F00A3E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784905133;
	bh=e/BnxahU3KJS4xokcGJzjL1NXw3X2KZRSFnd0/5C8Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=He5WRA6gsG0wXYVBoUAVlu2CYajp57KxtTj5OLHy+mlGBi1MTgNAJM2i3J2aSg9g2
	 8RR5FtF9ah7PdeZCL6IGlPVXSd2bU5a1HKtDbKxCtYHKNMs0VS7qs1K2UyfXQZT922
	 kqAZs6olfjnqmd4J83aE30rlieQxw7tD/c7Ly8jyjHnB7FiEqUVZzdC8GrOC75/HqC
	 lmJJSrB9ng7KY+zRE21Oq7TnGDHVqMPZ4k/Yo9VbM5socLIzPms7pz7h19HXG6WbtD
	 SjPjhjLtv+RdnoTKbrRzHNW36suboCsbYvYhUoylrtrhkS8d8whbsDb+irfEgRQ5KK
	 m2ysRMlOryC9g==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69ea0595598so607957a12.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 07:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrr116OQdTI1gSPLVYWLR15xiZ59NR7UYLY5X4hDn3WjoRMO9UyC3Bp+GsyfL+AFfcS0sh37Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGj+ANS/nlj3HQqwv8k+pVRfsorUhVRbaMGU0CQ+Jz4cuKdQ5
	ybrJXOZ74KYIrG0Ueoso9TbN+iTftX64zhCygOvqDRN1gw6nPXeTd0nU2aIHdd3GYbU6trXVyTD
	KQF6FSh0qEkeOEnPl5KV84HXZtfMUSEE=
X-Received: by 2002:a17:907:97c4:b0:c16:5b3f:52e0 with SMTP id
 a640c23a62f3a-c1c50d1c4e6mr325351766b.38.1784905131734; Fri, 24 Jul 2026
 07:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723230053.684176-1-you@example.com>
In-Reply-To: <20260723230053.684176-1-you@example.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 24 Jul 2026 23:58:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-WdPK66FFaTMub8MC6SUX0R9YJ+miVvA8uOwkKioVPuA@mail.gmail.com>
X-Gm-Features: AUfX_mwD4Cgj5zCLCVBGR7H68DXPk61uYvU4305Ojr1OU_lxugjrBrSMlapbGJM
Message-ID: <CAKYAXd-WdPK66FFaTMub8MC6SUX0R9YJ+miVvA8uOwkKioVPuA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: only rebind the reopened file's own oplock on
 durable reconnect
To: Your Name <qwe.aldo@gmail.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, senozhatsky@chromium.org, 
	tom@talpey.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:01=E2=80=AFAM Your Name <qwe.aldo@gmail.com> wrot=
e:
>
> From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>
> ksmbd_reopen_durable_fd() walks the inode's m_op_list and rebinds every
> detached oplock to the reconnecting session:
>
>         list_for_each_entry_rcu(op, &ci->m_op_list, op_entry,
>                                 lockdep_is_held(&ci->m_lock)) {
>                 if (op->conn)
>                         continue;
>                 op->conn =3D ksmbd_conn_get(fp->conn);
>                 op->sess =3D work->sess;
>         }
>
> The only key is op->conn =3D=3D NULL, which every detached durable handle=
 on
> that inode matches, not just the one owned by fp.  When two sessions hold
> durable handles on the same file and both disconnect, reconnecting one of
> them adopts the other session's oplock: op->sess is overwritten with the
> reconnecting session without taking a reference on it, while op->conn
> pins the connection.
>
> The sibling teardown path, session_fd_check(), keys on the identity of
> the connection being torn down (op->conn =3D=3D conn) rather than on shar=
ed
> state, and so does not have this problem.
>
> Once the adopting session is destroyed, ksmbd_session_destroy() frees it
> while the foreign oplock still points at it.  The reader in
> ksmbd_close_fd_app_instance_id() validates only opinfo->conn, which is
> still live thanks to the reference taken above, and then dereferences the
> stale session:
>
>         if (!opinfo->conn) {
>                 up_read(&fp->f_ci->m_lock);
>                 goto out;
>         }
>
>         ft =3D &opinfo->sess->file_table;
>         write_lock(&ft->lock);
>
>   BUG: KASAN: slab-use-after-free in _raw_write_lock+0x74/0xd0
>   Write of size 4 at addr ffff88810a970528 by task kworker/0:0/9
>   Workqueue: ksmbd-io handle_ksmbd_work
>   Call Trace:
>    _raw_write_lock+0x74/0xd0
>    ksmbd_close_fd_app_instance_id+0x183/0x410
>    smb2_open+0x1346/0x4430
>    handle_ksmbd_work+0x2bb/0x7b0
>
> Reached from an authenticated session against a share with the default
> durable-handle and oplock configuration: two sessions open the same file
> with a durable-v2 handle and an RH lease under distinct AppInstanceIds,
> both log off, one reconnects with DH2C, and a later durable-v2 create
> carrying the other AppInstanceId walks into the freed session.
>
> Constrain the loop to the oplock owned by the file being reopened.
>
> Fixes: f363a0fb134a ("ksmbd: fix app-instance durable supersede session U=
AF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Applied it to #ksmbd-for-next-next.
Thanks!
