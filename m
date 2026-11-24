Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521213;
	b=f9FIYcKDc76F4Owab3XJhvlv3WReSvpDyGI6AopxVuOt0cGjIB100uaS25BgfyV8Ph24
	 EIZQXDGzXu1sQY5KHNmZ+nklXSPEIAfNARoVdpDql8FfiodQiu60yndzM+KjvLkwmDjmY
	 i7Wa2mvHaKdXduwtsYBkd9mtpEb7RaeWf/r7ZYE06Jr3NnDSfaLIFWgCNrgfigu2osd4K
	 tBZzvUPn+UnrTedKozf5vtftiB+uCHf+lkCAOwhE7ONa7EbWrqHOluf06DxBuxcNemp/w
	 A1M/prx0uzUlTfMfbpvrX5f5KbS89U7hE1hSVN2EkMeRSluE8hIZOccV2jiI1edkdLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fXDSwCteyZ/xoOThhEVEgHgDKXealTWvNjRPjKwF/z8=;
	b=FhrIr26ngyt7vzeXEuemuAugpWn0C/tudklujHcHhEVtw9QDlPLZN8q4vCTGArQ4ZL2X
	 ptqTdWPJhZaTp7E0+9KzMN373+XarghIY+3vvVjyckEbeciJR6veu1HdYkaIOnMtDVO9i
	 Dw2yn0TL6RSQc01kkxFdw8e+HxBiBc9XODQgiTZj28BaDPw0n3NW9byZZSZx/e8dKKI9k
	 TxHhLfRKIS6k3q2141FVSygWRSudYgkhz32TG/hFXDZDI6ClvBxslWVVYhEHUaDDS9lO9
	 54qteLde5+n8V0h0N12vOaqnzUcmzetuHtokSgKFY87+MCbSwWsxnwEKPi8h24hBjVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=VHyW+Ot3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD58606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD58606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=VHyW+Ot3
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-537548b811aso37457291cf.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:53:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795521211; cv=none;
        d=google.com; s=arc-20260327;
        b=nDtjU6LPZfJMKFbgpkuwD0IiyUENgU9FgdZD+aOwFwmW55ZafADAeNFhrYuyZT1qG0
         jEgbTqKWdR37Zz9lBv7wLlv6UI+3fMSEQYepvklevLsKMfs+I2rIbeMqRJZ4GZLyLw3d
         JWQ60pBS6PrfX37fV5ZtIiu2nrjJsLTkRP4VbDVU3az4c0xkc2GaMQRfgDQ+hYw+FTo2
         n5eDTZQ3YS4jBStWnZNUhGLVeuEAHrhJL9aESmnMcDk1TcbUU9yN6ToufVltFsL9VVqM
         vAXAVEcI0b4XJcqGRKA9igsoM7GiD2hMmDkTQKdopdMH6g8awUp+f5OUk7l144HgfW/g
         cHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fXDSwCteyZ/xoOThhEVEgHgDKXealTWvNjRPjKwF/z8=;
        fh=k3TWod5kW/lPrp2zB+W/2t5W5A7t3++2qBT+ZvAEpYo=;
        b=U1wHNj/jbO/uonq4ri1AkfCiwleZKhCIkGKv2c3OPwGn4MBxoxkYhX8n45LITrylGd
         9beqHpIspgorwxnrsgql5N0r8rhc0hFFfR/b/aMw8LBTQb61u44GTXAtvLem8EufpYE0
         TCqfrBOI+Zz6zWylnIsM/1eZNEDE/o2bvobdC/Xn40Bqa9GMUJWcyRnNmWBD0H/p8e8t
         3oOCOPCH+S+gHvggwf7j7D4V4JN1psi/hDdsZuqxG/dOgjqMD4WEXKirQEAaSHxKaFUN
         KcbdjMUciVcg/c288cFpaKj9XhdKzl3xnd4Tfo8dLe8xqiCev7M/RTUdW6+fVrDFWatb
         gP7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795521211; x=1796126011; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXDSwCteyZ/xoOThhEVEgHgDKXealTWvNjRPjKwF/z8=;
        b=VHyW+Ot3Ar7S4XkTbhsYnvIP0jul2S8KdOXQCdahpG6ozPUcfaNIo7TgVv56T/jdsN
         Sf4eM4YtJnt3qiBsweYVnNNySxq1W/WQvCj6VDzs6hEe6KiVq1YTwyvlc6/PYo9bWRXM
         ehfRSot4elSbbbJt4pWXcBqu+V/io2+/6+Vk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521211; x=1796126011;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fXDSwCteyZ/xoOThhEVEgHgDKXealTWvNjRPjKwF/z8=;
        b=qfF9cA0JlXXQMWGE6Aqzs0IhwTmfkjVAhMii9oaeNZmLOJ7o+k2AnYTAACxo1jqlT7
         KbpM1iTZZ3MHzZwFAKekO3xbRGADg31/Q0thbFms3U9SorNcpcdL0gZGysC56NSYoOeJ
         2eoVexWxmjn1jk7qjSn+IAo9/t+3Y6rd4UkJem6N+WrxxvFfNyrqveiC7b8Pta070dpx
         n5SVA0f1UvnUu8SgzWsp8zJOEliD9mkcJHeaNdbEA0sCThJV8Uav5zD1X1ARzcI21GJv
         Cw2+UueqFAKRTedapZG7KrVonWtYgRVLtUh97foFxXu65f5NASzvJCgguBVINYhNAjaB
         iMQQ==
X-Forwarded-Encrypted: i=1; AL+hErFEEySYDl5bo6FFylP3tuKgXH3bEffrNrhsA7kFtEbpPovbzjCcOOvC6lqyIHoOSWzgTd5WNRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Im18TgMzEVQhYHHTFpysoTzn7L9raAamD9SsJjdnuri4S8M7P
	BIqPJxpmrgCZgFbYLBGwTULHgCHHCevno3NiptO04jK0zrdaJFzoy2en9w/W6jC4YGeZpPkFi7D
	IjTrKtK/fzWdSU5f0ySE64r9OAT+USvsTXVY4lt9mLQ==
X-Gm-Gg: AZFdTZe2aqdWKE9fzxNyRLn0b2f6nag9tavzN+Br/UgupJWnle70l9M3ymb8semNE91
	gZ2X0f69V9ssXVz141j0g7mjBEyNUT43UfP6PSr27HWwr65kqqHhqfUlIEq+nf+T/PXBfhKi6DU
	jkMYOVEDIP4drmSf5YsTTF8NypkS2DXBbgW+P3C9kYfEfXziwmwKdTs8Vf3VcHBzLhtFGfD3/oG
	DU4A/vKJhPoqeNy2z/waT7fOMV1sZ5LriQ+gyBFsDUwyeo9Lgjg4o3jA2LDkZuQYXx0fT6vMZfv
	92q0ux/eFo35c9ikpUZjqTzWOhobKjejsEyyR8D+RIaLSppFK+5S0rFDpPoDbqNRASjcr53JOBC
	LuX7H7yBBJl8BOirJOCaWlnAJj4Yi+aNLkMRZ6UesR+fmPZG5VdH2gJ6yRlC8TOpDx6hCDw==
X-Received: by 2002:ac8:5a08:0:b0:55d:4be8:937e with SMTP id
 d75a77b69052e-55d76a2d266mr263720841cf.50.1795521210875; Tue, 24 Nov 2026
 03:53:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105150943.86650-1-mszeredi@redhat.com> <20261105150943.86650-2-mszeredi@redhat.com>
 <656d0e00-01a6-4e90-a924-4ad2329c3d74@kylinos.cn>
In-Reply-To: <656d0e00-01a6-4e90-a924-4ad2329c3d74@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Nov 2026 12:53:19 +0100
X-Gm-Features: Aa3M54pdQT8drGLIpCz-lb5dYncahFoRCAsGVIFwkCZg_LrUi6uOLzpn0GsGbkg
Message-ID: <CAJfpegsOCq4oGfxzYh=DdL5x2BxaWc=c-SnSi1SOOk4eDOooqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtiofs: fix use-after-free of fs->tag on device removal
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 09:50, Li Wang <liwang@kylinos.cn> wrote:
>
> Hi Miklos,
>
> On 05/11/2026 23:09, Miklos Szeredi wrote:
> > The virtio_fs object is refcounted via its kobject, so a mount can keep it
> > alive well beyond the lifetime of the virtio device binding.  The tag
> > string, however, was allocated with devm_kmalloc() and is therefore freed
> > by devres_release_all() as soon as the device is unbound, i.e. right after
> > virtio_fs_remove() returns (see device_unbind_cleanup() in
> > drivers/base/dd.c).
> >
> > virtio_fs_get_tree() looks up the instance, takes a kobject reference and
> > then drops virtio_fs_mutex before doing the sleepable part of the mount
> > (allocations, fuse_conn_init(), sget_fc()).  A concurrent device removal
> > can complete in that window:
> >
> >   CPU 0 (mount)                         CPU 1 (remove)
> >   -------------                         --------------
> >   virtio_fs_get_tree()
> >     virtio_fs_find_instance()
> >     // reference taken, mutex dropped
> >                                         virtio_fs_remove()
> >                                           list_del_init(&fs->list);
> >                                         // driver core unbinds device
> >                                         // devres frees fs->tag
> >   virtio_fs_fill_super()
> >     mutex_lock(&virtio_fs_mutex);
> >     if (list_empty(&fs->list))
> >             pr_info(... fs->tag);   <-- use-after-free
> >
> > The virtio_fs object itself is still valid here, only its tag has been
> > freed behind its back.
> >
> > Fix the lifetime mismatch at the source: allocate the tag with kmalloc()
> > and free it from virtio_fs_ktype_release(), so that it lives exactly as
> > long as the object embedding it.  All probe error paths already drop the
> > final kobject reference, so they are covered.  Merely dropping the tag
> > from the error message would paper over this instance while leaving a
> > devres pointer embedded in an object that routinely outlives its device.
> >
> > The other readers of fs->tag are unaffected: tag_show() is fenced off by
> > the kobject_del() in virtio_fs_remove(), the automatic KOBJ_REMOVE uevent
> > is emitted from __kobject_del() while the device is still bound, and both
> > virtio_fs_add_instance() and virtio_fs_find_instance() only walk instances
> > still on virtio_fs_instances.
> >
> > Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/bug/linux-0328b3a1-043b-468e-8425-6a613d91b5ef
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index ba8d79c4bcac..ef58bedc3941 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > ...
> > -/* Read filesystem name from virtio config into fs->tag (must kfree()). */
> > +/*
> > + * Read filesystem name from virtio config into fs->tag.  Freed by
> > + * virtio_fs_ktype_release() so that it stays valid for as long as the
> > + * virtio_fs object itself, which may outlive the virtio device.
> > + */
> >  static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
> >  {
> >       char tag_buf[sizeof_field(struct virtio_fs_config, tag)];
> > @@ -505,7 +510,7 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
> >               end = &tag_buf[sizeof(tag_buf)];
> >
> >       len = end - tag_buf;
> > -     fs->tag = devm_kmalloc(&vdev->dev, len + 1, GFP_KERNEL);
> > +     fs->tag = kmalloc(len + 1, GFP_KERNEL);
>
> The fix for the UAF issue regarding fs->tag looks good to me.
>
> However, while looking at this, I happened to notice another similar potential issue: when the DAX mode
> is enabled for file read/write, the DAX window is mapped via devm_memremap_pages and unmapped when the device
> is unbound. Although as far as I know, the corresponding QEMU changes for DAX mode don't seem to have landed
> in QEMU upstream, fs->window_kaddr and other established page table mappings still point to this memory region.
> Perhaps we should also look into cleaning them up?

Please do.  Can I assign virtio_fs bugs found by sashiko to you?

Thanks,
Miklos
