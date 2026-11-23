Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448906;
	b=cFTJIgkWYAZvNongB8AmDmuggQG1UVvZ6kToK5aQ3vmW2yd9f7Y8cZWgwtE7uT5yYuK+
	 t+IVdtCHUuCAx5E05iTO2BreLO1zT2xBnnNbXXxAwKtiN+oxgOGdvuqG5OVRY8bg1ALe5
	 HJr52I0CY0yXWkXJI29D7iNiNa77yrvoQ1ND75mfC7jVaTmSbQzSXT5AS18Frxuo4VI9a
	 HcIdPUG0Vvtr+5ttE8xanUBX2iQYiQLihNdEBkpXG+ZDhzagmx/gnyMWzR8X7QA7Nwmb6
	 raG1oehZRuAzLt/bmoCeev0BPYr3IqKJ+eeS7hJpIVM3BQiRhMCWEFOBTqY4rL6NM0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448906;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
	b=rNGynUD/hCqpN/MzS5+Zd0w8ce9BgA1IHZCYNzVb99bXuvQQ1syp9Wi+GH6RqJ7KT1rR
	 lYSPoI4EeNRuKjdwuyEZRoyUYTzaCApvGeXJg2Wu8eZbu2ameY1Ts7g38MGfwW3wpNX/J
	 4VUV5fZZq7D+HfcbUCyvucgiU0Hi3ZnAmHP7lNzdH7xvrIp9Ue06WGE3JA/ADZMjqKSo/
	 7jgGuzF+tu04QvwPMiFwFzee2CI9RyZfj+7/+55TSenN+EEBjGoscK+VJxNxgTCUbUYud
	 BcmZ85daZPyQU9KpgKRq69oZ+8zk6tms1GTd6FgrIN/gTQT86R/26UAEpUPSchPxoHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mbt1JdmK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dsfZhFmo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19C606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE19C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mbt1JdmK;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dsfZhFmo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795448904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
	b=Mbt1JdmK1AyJOIbMwV/jO1KHp57Acl/HXHw2EDf6MzsCI5jR3Q8dutqkzgLDV/gGyRssaK
	venGwI/P/vth4U2CPdp7M5JL5jAQQ/4K0uad5rDa0I5wUF1A83VSbWviwphHFslZPSE25J
	2MQSh5pTPOAgaSWGdwT8OGKgmw7adUc=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-CMHEQR5eOA-ZDs5fZ-uSog-1; Mon, 23 Nov 2026 15:48:22 +0000
X-MC-Unique: CMHEQR5eOA-ZDs5fZ-uSog-1
X-Mimecast-MFC-AGG-ID: CMHEQR5eOA-ZDs5fZ-uSog_1795448901
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67c041acd09so5226560d50.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448901; cv=none;
        d=google.com; s=arc-20260327;
        b=n1jyWidoyNsnkR/kKGk/Y1LrCJ1qRwbTeOviRjQmbkk8kLE2+DomePM5q4nk4VnGwR
         45ueVboXl5/VC1dXEwrwccDgFq3MZWJrmX+SAYv0v2mG5MEHuVRT9720ss/HCK1BpuQX
         omxO1dgWxn3eWv7hhmwUipgMDQz1JRwqYxG40JQiaIxzsebmGm4VRLB8PaJ7D7AA2Iaq
         QmPg8ccreQYfgsXRr4OQkcibgL4ofoVCLZaryHeAA4eL3w3+malWzRdj5hxAxxE4nduh
         wmq3HQt41gsFsnJfHfm1nFkCFIkIQtnK3C38tk4FkHjXG1/E9N70gvlxkbXde5BN95Je
         FdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
        fh=hfk3PrNFWffolDTvcJqrdbx9HcOcbpDAYpsOV0Hyutg=;
        b=f3j1JTQnosj+ACfQDQQadvl1tYW+hMouI4a+xgBsDYHoMkjCRZ6TzZ8C8tujCDZ0Dp
         mHc/0tKeT2QcVZdCh6tve8ZqbAhX9ErMXNqKkjQaCcl8sPlxCeM3gkGOsqC6HZCLurGT
         qFvHQ+VE+HBqtDtUIZDX3+E5/Dq6kREtDUDsuUrWGqV1tkw+0NAs73Ql8RLkIaivUiST
         ddnKwfumXCcALqfygdI9S9/vImCanmAO1qW2oI1ii0bFQOXVs9eUZWucDf1WpZrqEW3n
         HuqoMdQo3tOXNKYw05XDQfcqLHDZlbcn24fAqpheNdE13ytv2a+TyJRWHGGCiMn+dZ3a
         xkWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795448901; x=1796053701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
        b=dsfZhFmodnbE7qJ/+h28fM11IW95haQ/HwOArI6w5lnEBqB9E+BHecqtIO6sHZC/Q0
         y9Ww2fGlfQdux/XJuJtD+6UVvh3rSqq5MiGH2qPQb9natv0NBtuHG30u5UYnL7P3QwBJ
         YYZHaM66NXm5fOTn5bHUzfZzzmQ0fBRDRGd/o4MX0tgByBixuIFoP2ceSjw6EQ9I0Grq
         uEG4lO++mQh+Mi+zZ+j+8rcOnqWbWURPnClmXZuFEDjQNQMKzxvEtqOl9yJv/Zyfa6oD
         mzkkEmEF8qq7gQQNVGUB13ITJuGmcBZ1NJlIx2KOOggqGR4ZYf/AZu2CYK7x5kw12jp2
         RuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448901; x=1796053701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
        b=mt8gBZbmwss6OSFLTD9o1alyK+fxY9fF2eFkt5Hy1YiX0ywe2ijj5ET/HBfs3ThRZb
         yi2aPMxH1lCmNO1L6aeTy2VXYMeZnMbezftbbPpsrmdZYXf2sD54fNx5Ql3139rG+oGg
         6ysHUBcWDYTl5e4RWR8ifBWDV4Ad9At/aLN0UblmyqzW0t7/gymp9m814gfxM/Cb1kA1
         9RYBWpxi9daHlGmT3kikZksjgOfK7IUD72burYesMvlErfZX2dWjbL1spblBAX1bxV5k
         VBxBZXTrWkreEdQjsmoooGyfy7MTj6QxKsH3TO4lrHPFkwHDnIJccnhvu4PaPHrjr4Sd
         /u0g==
X-Forwarded-Encrypted: i=1; AL+hErFlCR7Jm0tIgJbGOu5+CceZx9kzGYZQQ1IMHmPE912BxQ4EE+hvyljvjoZw3V0cyRO/kkPHJ1Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tyn7aC+CSU9pGK071MHCJPWWPA/QIs/LALmLiyzdXgjBVLI/v
	BcWj8oVWooWsrhyYV66jiPALQ/y8Jc6Oa+rptxsQSzGlVIm1vqG89RNArZrin4AdtWv4TSbD5Cv
	aC1HqU5AWSsv2urCgdfzUyreYxsETC5iSK/s6FGeGART/R7IljxSLhWqtkYVd/GZ1LZqb5xWl3D
	4sfILt1a3uq9hhsc2IuFBg93F4NByprOrz
X-Gm-Gg: AZFdTZeRhpQ4vbmYyLG/h5mtqIflVKEE3fj8lLVkgtBkaYUU7BLO7LqHgsQwjI3iuMY
	L6zYD5KmVhMcWGNR5NKKeWvPOfSc1/23pNl0upecxCljY8GHWzvAJ8SLwxloQvsI3KaChSQExQQ
	IgAg9a4HwrvsxcXHOk2lofF6DA+5nAC9nOAd86xM3d0C4cwysPh9Q/oKcojs4gTgAQ+ki7RSuOF
	/EszRoZZsZM9KqcxmD7oY9j+lgnpLpTmAkkqUJYBNuc3HOxG8ibZZWqulo=
X-Received: by 2002:a05:690e:150e:b0:677:b670:bc2 with SMTP id 956f58d0204a3-67df4497b11mr3158232d50.131.1795448901291;
        Mon, 23 Nov 2026 07:48:21 -0800 (PST)
X-Received: by 2002:a05:690e:150e:b0:677:b670:bc2 with SMTP id
 956f58d0204a3-67df4497b11mr3158224d50.131.1795448900838; Mon, 23 Nov 2026
 07:48:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-5-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-5-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 16:47:44 +0100
X-Gm-Features: Aa3M54o4ueCnunOOjRD8BYS6eetZBocpj0aR00-pSGaCcCscH__3XBFasy8mITE
Message-ID: <CAJaqyWeVfFBohQ+x1_MCmNCt0FgvepgKV+H_u4GqR+GLCqf6Mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vdpa/mlx5: Don't flush the workqueue under reslock
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 3:00=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The control VQ work (mlx5_cvq_kick_handler()) runs on mvdev->wq and
> takes reslock. Device reset and the error path of .set_status take
> reslock and then call unregister_link_notifier() which flushes the same
> workqueue. A deadlock occurs if a CVQ kick arrives just before the reset
> for the CVQ work.
>
> Lockdep caught this when QEMU quits (pkill qemu) and closes the
> vhost-vdpa device:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: possible circular locking dependency detected
>  ------------------------------------------------------
>  qemu-system-x86/5785 is trying to acquire lock:
>  ff110001cd292940 ((wq_completion)mlx5_vdpa_wq){+.+.}-{0:0}, at: touch_wq=
_lockdep_map+0x7a/0x180
>
>  but task is already holding lock:
>  ff11000136eb4928 (&ndev->reslock){+.+.}-{4:4}, at: mlx5_vdpa_compat_rese=
t+0xed/0x760 [mlx5_vdpa]
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
>  -> #2 (&ndev->reslock){+.+.}-{4:4}:
>         lock_acquire+0x126/0x330
>         down_write+0x87/0x1d0
>         mlx5_cvq_kick_handler+0xb1/0x1180 [mlx5_vdpa]
>         process_one_work+0x8df/0x1660
>         worker_thread+0x62c/0x1030
>         kthread+0x377/0x490
>         ret_from_fork+0x4d7/0x720
>         ret_from_fork_asm+0x11/0x20
>
>  -> #1 ((work_completion)(&ndev->cvq_ent.work)){+.+.}-{0:0}:
>         lock_acquire+0x126/0x330
>         process_one_work+0x874/0x1660
>         worker_thread+0x62c/0x1030
>         kthread+0x377/0x490
>         ret_from_fork+0x4d7/0x720
>         ret_from_fork_asm+0x11/0x20
>
>  -> #0 ((wq_completion)mlx5_vdpa_wq){+.+.}-{0:0}:
>         check_prev_add+0xe8/0xdb0
>         __lock_acquire+0x1801/0x23e0
>         lock_acquire+0x126/0x330
>         touch_wq_lockdep_map+0x93/0x180
>         __flush_workqueue+0xed/0x1090
>         unregister_link_notifier+0x10c/0x170 [mlx5_vdpa]
>         mlx5_vdpa_compat_reset+0xfe/0x760 [mlx5_vdpa]
>         mlx5_vdpa_reset+0x15/0x30 [mlx5_vdpa]
>         _compat_vdpa_reset+0x29b/0x3b0 [vhost_vdpa]
>         vhost_vdpa_release+0x16f/0x380 [vhost_vdpa]
>         __fput+0x36a/0xaa0
>         task_work_run+0x111/0x1f0
>         do_exit+0x7ba/0x2590
>         do_group_exit+0xb8/0x250
>         get_signal+0x1f46/0x2020
>         arch_do_signal_or_restart+0x79/0x4a0
>         exit_to_user_mode_loop+0xbe/0x450
>         do_syscall_64+0x257/0x4f0
>         entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>  other info that might help us debug this:
>
>  Chain exists of:
>    (wq_completion)mlx5_vdpa_wq --> (work_completion)(&ndev->cvq_ent.work)=
 --> &ndev->reslock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&ndev->reslock);
>                                 lock((work_completion)(&ndev->cvq_ent.wor=
k));
>                                 lock(&ndev->reslock);
>    lock((wq_completion)mlx5_vdpa_wq);
>
>   *** DEADLOCK ***
>
>  locks held by qemu-system-x86/5785: 3, last CPU#9:
>   #0: ff1100021d7c2068 (&dev->mutex#3){+.+.}-{4:4}, at: vhost_vdpa_releas=
e+0x4b/0x380 [vhost_vdpa]
>   #1: ff11000136eb44c8 (&vdev->cf_lock){++++}-{4:4}, at: _compat_vdpa_res=
et+0x16b/0x3b0 [vhost_vdpa]
>   #2: ff11000136eb4928 (&ndev->reslock){+.+.}-{4:4}, at: mlx5_vdpa_compat=
_reset+0xed/0x760 [mlx5_vdpa]
>
> vhost_vdpa_release() resets the device before stopping the kick
> handlers, so CVQ kicks can still be queued while the reset runs.
>
> The fix is to move unregister_link_notifier() calls outside of
> reslock. The function doesn't need the reslock.
>
> Fixes: c384c2401eed ("vdpa/mlx5: Avoid losing link state updates")
> Cc: stable@vger.kernel.org

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index f1c5f72032a3..a175f734517d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2908,6 +2908,8 @@ static void unregister_link_notifier(struct mlx5_vd=
pa_net *ndev)
>
>         ndev->nb_registered =3D false;
>         mlx5_notifier_unregister(ndev->mvdev.mdev, &ndev->nb);
> +       /* mlx5_cvq_kick_handler() work needs the reslock. */
> +       lockdep_assert_not_held(&ndev->reslock);
>         if (ndev->mvdev.wq)
>                 flush_workqueue(ndev->mvdev.wq);
>  }
> @@ -3215,6 +3217,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       bool unregister_nb =3D false;
>         int err;
>
>         print_status(mvdev, status, true);
> @@ -3257,12 +3260,14 @@ static void mlx5_vdpa_set_status(struct vdpa_devi=
ce *vdev, u8 status)
>         return;
>
>  err_driver:
> -       unregister_link_notifier(ndev);
> +       unregister_nb =3D true;
>  err_setup:
>         mlx5_vdpa_clean_mrs(&ndev->mvdev);
>         ndev->mvdev.status |=3D VIRTIO_CONFIG_S_FAILED;
>  err_clear:
>         up_write(&ndev->reslock);
> +       if (unregister_nb)
> +               unregister_link_notifier(ndev);
>  }
>
>  static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
> @@ -3301,9 +3306,9 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>
>         print_status(mvdev, 0, true);
>         mlx5_vdpa_info(mvdev, "performing device reset\n");
> +       unregister_link_notifier(ndev);
>
>         down_write(&ndev->reslock);
> -       unregister_link_notifier(ndev);
>         vq_reset =3D needs_vqs_reset(mvdev);
>         if (vq_reset) {
>                 teardown_vq_resources(ndev);
> --
> 2.54.0
>

