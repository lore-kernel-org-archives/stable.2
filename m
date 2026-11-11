Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794362375;
	b=pVrQLd/NodI3CpGTlFilLpgaLlAAnAbe7uDqGRAt/q2SIWORpceEW60qJ/P6dzIY/qoy
	 tWW7kpMYHg9euGoiYatUS1p/MBlJPfDc3R3+IM6E1lm49CEKpo4OiFCF5dnrZN2u9zOWK
	 8JFACEJL3w6GnXlvkPJujBTFWQ2hnG6Pg0aqqrJqD1XOlzmoreiSLlpMUKZoOR33pSgwL
	 vcRwWaWZRMgdgrquLC0q+214J2Umb/xOorpLX2G7P24UXv1/bDxIWUvOqtO2JkvsHWRSy
	 1SglXD0zg0uAuc4z9Y2o/73e62I7phtwc6yNp8hxpsz4Uy6zVIfI3b1JYIJasuAii8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JNwnJPp+yu31nyo75SU+VysFK5l8+BlztC8tNoAM//s=;
	b=VYT4Xh/bOJ/oYenhgMcKD5wscZfyKiwh8DPi6nzNq84wtgdfYZOxbI6Bm9i1O+1ls947
	 VlsU2PeASEhUFIWFqfv9YuH3xT6bagP0enGCvoL32LpDc6bc4Ms35gw3N7j1vXSGdC/yK
	 AFk9sCyPIzg8AeTT+713VGfOcOEKvxAsTigbmTxXHg4YJlEGr7K3caNyZJmRQrjopDV9g
	 5lTpVUU/QLH38yvTFCm8ccIJLTf1AxdSd5/ywOrelz3KOiNwqPHhuJ5bsP+L7t6DOuWyn
	 8grHVp8gGZMwYV0aXtRj093uHVtKZ5wBqAOe7U8lgGnNzDDEvifiBevH58exqe0nbRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IYXgZFIA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55805606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55805606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IYXgZFIA
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so26898325e9.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:59:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794362374; cv=none;
        d=google.com; s=arc-20260327;
        b=FpJnylPCBKW1IegogW/YkqWa2oFtUy+zL2HT5BQfqWdHU6abgLjfCQ8DmbjZApnuc1
         Jcl51EaAkRnrcYZOMBw7kaTaJKAx3clGUrDsDiC5MdH505KLRP90D6os2o/scjGwMMvD
         3DFyQD4hQNNu+A7uF9yDkFBD5AUYJGYyKhla2u4VqFeSyQrO5UBZ/VaNR11RlPaByIy5
         tHmZkG+OaIuE5kv6Lb0inIXLtrZ3QZGOpuPMTLK54Ema1CyWgsxhJeC9Rr29/FvPoLHl
         GzZ4g30fseJGWae8OJDvpfp0YCXFFM1pa68sdjvCOMBezogE9t5vtpj/NyUp9h9tLYVy
         VZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JNwnJPp+yu31nyo75SU+VysFK5l8+BlztC8tNoAM//s=;
        fh=2lBIszkehkHKKMkQA9oEOa39ymf89Rqf8snJvNEUtfE=;
        b=hOMUFzHYIg9PzTRhRUTyCNL3MeIUV9wa6GE1HzlvIAoQPNHqJIGjE1O/wTqVMOyIaO
         CXr6CAJNVgR4BO3Td/7788+jDY0QUor5J50x0oHdCpQlhZT62qyI6A0P6YaWkxjkVdlv
         H0BrDx+IzceOVswHjjSeOFV8x7djw2ha7pxoUkeoGJZ1avPHR9cHaGMwVOQlRna/4DK0
         txyEOAojJCIMmVNjK35LXL18GP0tQSoyEY5ENEpuWCrW+Fx3s/bhJ637O/e5Zj6HgCit
         hsP62k9YX4UdebLUKDGKoMH9kAbksi3CAy8ibGAG5oDmykdA4dJKDvbDVyxRD9mYjQv/
         kvcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362374; x=1794967174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JNwnJPp+yu31nyo75SU+VysFK5l8+BlztC8tNoAM//s=;
        b=IYXgZFIAqYhKsk7hty4s+M40+ZNHa2IeMm17PFMqVWMCIl9YGy6wAzeGgxImhlt1VA
         n8BrRvYWFq/Ceq0eNRqZswZD2vs4agkBBpCDGyANyCt2UN6Y4TyFh1QnxVutuWhomYiV
         PTvnYFh4516+U7+8ptBWKhC7e+C/9xdaNT/+tfRPZOGgdw61N2JdW+Slwy+pIzUuSPyT
         SQI/GxQnOzyj8vOgwcpFbCbDHeIDrHoKjh+a4d+MxJsLGzbU/NgQ4EOd8byjnWoh82Nh
         2bLtxrK418qV3dd74mJTtDWN4B/QXbiHnBEkQloO+MMra273mgSbV//c6KXapzPXRq0M
         LcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362374; x=1794967174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNwnJPp+yu31nyo75SU+VysFK5l8+BlztC8tNoAM//s=;
        b=KnJbKT1y31uq52maZR9pHU7xQQys7VrPVv9zrT+LkfL46rbuVB+JPho0cIRqXs993w
         8dNGKZts3hfz6//CgQcNYjfq6TWUPRwRkPAPgKzAq87Rf1xU6HMx0bkW01yHtn3MtIJK
         Bigl2is9Fcg45A+tg2yFjevt+sCrNmGCGqMMASvT8cqviP4FMxMpSdQqV3gv//ma213o
         hRIfv1ZTame8HyVfQEZhkWTaCkyHEKok4SfLos/UOe7rJULJKpIZY+Y2sIMPIWYIxEoi
         9kIBLbjH0FWKf8ymWTxlEWdCmkVFynYrUERFJFfHdnz7yqOAegd99BOZFRnKGBtM+IH2
         KiFw==
X-Gm-Message-State: APuU4Z8Zklhex78/zO3BqhXJK7TEg+KmeJ+0QTAqnqWXVwrsGAcOwDoM
	UUxccl6LVx658oi57p9NpWmmKmegni9k2IwzYc1aR35FLK3F/ae+jNN2v/kjagmjspU5+vgHZVi
	PGGnrcuyGc4Mxglk0wTYhvHIlqqprONc=
X-Gm-Gg: AYBFou1WYX3MQZ+PCInhBhybOzpte8bbwwWj763fzXXrZ+sI4KkZuj9vLE8Ar1t5Lpn
	BB0Pifrmic+t1PvRjZwAMkkNeqAp5xWhB73lm5XPZUOML1SuTgB9EiOu+hZ0qv6mSZM0oBDlcYT
	lzqPGw8MhcgojcnrZ5qdPtFuAS0QBXdjT12Yl9pqIXpK1uBfYwEyhEunJUWrSHr0OP0TMaTZdu2
	o8h5E97c9Wgy44qkmRVvAuZan+X4oQvLL3RQXjTEOY6/UH3dNcI5z5F23d5BHJw/mhdL0m5ZBOK
	KXaMUdcmv/5aoMqQuRMIUdAJQJbTGWMKKXULT4DHVwg2Eb9MDDWvMD9a4aaU7imLy7V3a/3Pgjc
	IJSOv0AFKNJefb5Llkn4oM3dXKizAPCvij3DWew==
X-Received: by 2002:a05:600c:1e04:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4ba093b9702mr11727895e9.19.1794362373409; Tue, 10 Nov 2026
 17:59:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107054332-failed-6.1-7131aaa74bcc@kernel.org> <20261111013114.470246-1-wangjianjian3@huawei.com>
In-Reply-To: <20261111013114.470246-1-wangjianjian3@huawei.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 11 Nov 2026 10:59:15 +0900
X-Gm-Features: AclHuK9AxeLBGjjT8dWzkU1zDD3mx1rSay4eO5XNNsBfSe9dQhUQVfxov59X1BQ
Message-ID: <CAKFNMoneZ4jzi025V4w4Ep2N_VpHediHwwoe7TY6OowVjmq9_g@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] nilfs2: ignore non-fatal signals during synchronous
 log write wait
To: Wang Jianjian <wangjianjian3@huawei.com>
Cc: stable@vger.kernel.org, 
	syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com, 
	Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 10:33=E2=80=AFAM Wang Jianjian wrote:
>
> From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>
> Based on a syzbot report, Wang Jianjian pointed out that following a
> successful directory operation in nilfs_rename(), a synchronous write
> requested within nilfs_transaction_commit(), triggered by a sync flag
> set by nilfs_commit_chunk(), could be interrupted by a user signal.
> This interruption leaves in-memory metadata updates intact while
> returning an error, causing inconsistency with the VFS dentry cache and
> ultimately triggering a kernel warning.
>
> According to "signal(7)", local disks are not classified as "slow
> devices" (such as terminals, FIFOs, or pipes) and their I/O operations
> on disk devices are not interrupted by signals.  In kernel space,
> waiting for such disk I/O should therefore not be aborted by ordinary
> (non-fatal) signals.
>
> Suppress this issue by modifying nilfs_segctor_sync(), which waits for
> the log writer thread to complete synchronous writes, to catch only
> fatal signals via fatal_signal_pending() and return -EINTR rather than
> -ERESTARTSYS.  To complement this change and prevent the wait loop from
> busy-looping when schedule() returns immediately due to a pending
> non-fatal signal, switch the wait state from TASK_INTERRUPTIBLE to
> TASK_KILLABLE.
>
> This serves as an effective interim stabilization measure without
> structural changes until a comprehensive fix for metadata consistency
> is implemented.
>
> Reported-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df6c7e1f1809f235eeb90
> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> Tested-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
> Cc: Wang Jianjian <wangjianjian3@huawei.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> (cherry picked from commit 7131aaa74bcc7c9da1f1d1c8724da75c775557a0)
> ---

Hi Wang Jianjian,

The patches that the fix patch depends on have also been submitted to
the stable tree, so the conflicts should be resolved.

Considering future backports, I think Sasha Levin's approach of
simultaneously sending acceptable dependency patches to resolve the
issue is preferable.

Could you please check the link below?

[6.12.y] https://lore.kernel.org/all/20261110131241.1664282-1-sashal@kernel=
.org/
[6.6.y] https://lore.kernel.org/all/20261110131728.1706995-1-sashal@kernel.=
org/
[6.1.y] https://lore.kernel.org/all/20261110132237.1722151-1-sashal@kernel.=
org/
[5.15.y] https://lore.kernel.org/all/20261110132713.1736389-1-sashal@kernel=
.org

Please let me know if your intention was different.

Thanks,
Ryusuke Konishi



>  fs/nilfs2/ioctl.c    |  2 +-
>  fs/nilfs2/recovery.c |  2 ++
>  fs/nilfs2/segment.c  | 10 +++++++---
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index 4e964549bc4c..cbbe49bb4926 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -960,10 +960,10 @@ static int nilfs_ioctl_clean_segments(struct inode =
*inode, struct file *filp,
>   * Return: 0 on success, or one of the following negative error codes on
>   * failure:
>   * * %-EFAULT          - Failure during execution of requested operation=
.
> + * * %-EINTR           - Interrupted.
>   * * %-EIO             - I/O error.
>   * * %-ENOMEM          - Insufficient memory available.
>   * * %-ENOSPC          - No space left on device (only in a panic state)=
.
> - * * %-ERESTARTSYS     - Interrupted.
>   * * %-EROFS           - Read only filesystem.
>   */
>  static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
> diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
> index ce30b51ac593..34462039ae7d 100644
> --- a/fs/nilfs2/recovery.c
> +++ b/fs/nilfs2/recovery.c
> @@ -744,6 +744,8 @@ static void nilfs_abort_roll_forward(struct the_nilfs=
 *nilfs)
>   * Return Value: On success, 0 is returned.  On error, one of the follow=
ing
>   * negative error code is returned.
>   *
> + * %-EINTR - Interrupted.
> + *
>   * %-EINVAL - Inconsistent filesystem state.
>   *
>   * %-EIO - I/O error
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index a412abdfbbf3..3a256f786db2 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2236,7 +2236,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info =
*sci)
>         wake_up(&sci->sc_wait_daemon);
>
>         for (;;) {
> -               set_current_state(TASK_INTERRUPTIBLE);
> +               set_current_state(TASK_KILLABLE);
>
>                 /*
>                  * Synchronize only while the log writer thread is alive.
> @@ -2250,11 +2250,11 @@ static int nilfs_segctor_sync(struct nilfs_sc_inf=
o *sci)
>                         err =3D wait_req.err;
>                         break;
>                 }
> -               if (!signal_pending(current)) {
> +               if (!fatal_signal_pending(current)) {
>                         schedule();
>                         continue;
>                 }
> -               err =3D -ERESTARTSYS;
> +               err =3D -EINTR;
>                 break;
>         }
>         finish_wait(&sci->sc_wait_request, &wait_req.wq);
> @@ -2289,6 +2289,8 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_in=
fo *sci, int err, bool force)
>   * Return Value: On success, 0 is returned. On errors, one of the follow=
ing
>   * negative error code is returned.
>   *
> + * %-EINTR - Interrupted.
> + *
>   * %-EROFS - Read only filesystem.
>   *
>   * %-EIO - I/O error
> @@ -2324,6 +2326,8 @@ int nilfs_construct_segment(struct super_block *sb)
>   * Return Value: On success, 0 is returned. On errors, one of the follow=
ing
>   * negative error code is returned.
>   *
> + * %-EINTR - Interrupted.
> + *
>   * %-EROFS - Read only filesystem.
>   *
>   * %-EIO - I/O error
> --
> 2.34.1
>
