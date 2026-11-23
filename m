Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795450129;
	b=odWqKWlwbeXkO6yccNgJSiWhCFQh0brrD3lSLwo56y0QKh2NI38Xk8k3eO09VR4y3suy
	 NvP/+7GY73Ko3h+haF3vjB+OTUBBbhNkWUME+bpR91ieYWUWHYFV2/jHSOZSvDDoXkFsv
	 HEeeZZch4ms+MFr9ckqmnjLau0Erk9tzptK077Wx2PIxMCp4CPYtLGDrFfAmd4KEUje+y
	 174bihblDwOZmuk5+aQ+9sFdUXcUOIgBbWDHqcegTvUpkDyxdoubPJ2i/bBwYvo8reyqg
	 EewriFUfNYseRL9Hfed2XEGsipGOiMnIgzRL3dKceH7nVnagBbU6XUlteRfqqIlc5Aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450129;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
	b=Xqdcyi18o4FMSGo0ms7bV2izkfkkof3N6ySKwUSXfTt/Qe4vKZ6106Ca0MvA9W/zQiAH
	 cGjyRdEnYPLIkzpnLUbUPdeetrknwP+Bra3wnQDSc4Gd7KdUUF5INyxNvAFvp2NTx1cLH
	 2VUKjVfPPdK/dYG8oCUMT4JW1227X4TxnTxe16qaB9rqUtzczOL3lJOAgnhSZAb9zxCVA
	 bYWlz8f3wo2FSY3Jkyi2Tgcso9GokyK5kn/UdpgyohEWu8T4yJEKOIqP07jJfMR8SzCYQ
	 rPyXs2QmM1Z5jUyJenCbY9WdPIpph3rOYrgFiteNxlTibM4Z63+Geu/riVUqGsWPOGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5nucsP5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qd5JR7g6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62A606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C62A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5nucsP5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qd5JR7g6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795450128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
	b=C5nucsP50WObmK5Q7uRc+TveRbQ433qzGh7y2uyYQKa3lu8VBblMI/jfSafsNlAU5bzqM3
	2Oof31kKa1N1IDRagkxQGSOfEn7xcPfxwBTeYUwTJmOllC7W87Xmt98CG4KzUEqxzOoPdu
	PXhmAJmsmsCBRCvg+AyMrINooTjHRUA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-9PW2i-FMOJy55zS1035qfw-1; Mon, 23 Nov 2026 16:08:46 +0000
X-MC-Unique: 9PW2i-FMOJy55zS1035qfw-1
X-Mimecast-MFC-AGG-ID: 9PW2i-FMOJy55zS1035qfw_1795450126
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67be4f2f42eso5969577d50.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450126; cv=none;
        d=google.com; s=arc-20260327;
        b=UYAcZeIz+6NBh0XcgXt+fA0HuE5W/7XM07GgKj6qt//IbARp60QnRxD0yt8qdL7Nq4
         IxelX+VMUirgYZO8GuVmfqkAdx7wRDeFEhSION4nfT2+W1nM5VhGeM6Zfk+Cz9L+yqLf
         +Bko3ztEpGM4z0WasjYeCmc+tdcsYDOv+LeKZ/v1Fb3YEr3qUYS/oWx8cQBemCqOG2Ii
         IyyfrnX6wc4XCdFCPBYYQTXgWNHwNwWh59AAjWCvqzJWkcH0ErMPG6aFgQ10FnjDeZRm
         6hqteQSfsTtLusH4wHaS3ll0W0MeCOeBcl3IdSC8pdP0to2FWXWrmW7jhIKD2vSXWKAe
         TmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
        fh=+YFVGxzFNL/W2QrsOEBIL8NytOboK2B9NiyKlXcRaJc=;
        b=Cw8PPh1a2jqUYmW6nv+taoIyr1iROZk0L+ha3s8TrzzF+hg4W65ywf2QTYe8AhZpG/
         qrPKU6Uiu9aPFl/tX9miNVbFGBpHKw2XlR+fBCpZyM7E60vNgNJPqG/mGU5RRDwwpwgJ
         D2lqvb/3WQiPBTaSflrK4sggBnegGDK53Dr6iqpJbE7OVcN6A8/0jP+hcvdQ/+M7vpWD
         AdYjJzLR2ZVsMP4wD+dp9TuUE6uMo/BrR0aMORCxgaij0tf4KSI+4VG4AU6NBxPFdHBp
         GLS2TSyDYI6aFIV+lqfXjeyKS0D7ATYzTOoWdsI/RaydsxZq9d/37WtszOihAbGJGYnp
         8C0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795450126; x=1796054926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
        b=Qd5JR7g6lbc1bTE57DLvSbAcvCu+U5VnKV9hn7rTxISUy+bY47heC761ODwqICnDgn
         0qFgXuS7257s4kjYStNiNV8VAYTq3w+s8h09+qO05ZU2DwHrId+FhHfAYKeSITGi3N3P
         fSTI8BPp6EenPsopJifSxHd6LZlIocbNSV5EFqDuKpOSLWBzNbJOzYuOFrykRuEUhKcg
         UNQu+LPVEhoI28bovtV7kSmZL/Pk1CSuRx/jFxwWnx3YX7fkH+GA3pyeyYE1vGgmsYt5
         D0y43koEF5r0ggN0J3B8YGq1SRmtxPUnpJcpWuMuzqZEZwF6pjJFek11VkAxZk1UXnEp
         8LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450126; x=1796054926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
        b=GowEdybmppCokikFaeWHXBut31sRKcj2sUibxo8TqWZ42zoPru8BqJsAnBAS1j4ip+
         a+Zr5+eH2u/63nuvgxvI/ZSeTo/PVNJbKJ+mq35nl3Fw2qyFJ8SS4KYiid2B51hsAvgu
         p2ecof/+zJ189Xa0aWaPTeUgV2RJTKtZ5PgrveJfTkpX7i7yMG1S/IUivzdKiqMJrDXr
         EnzJcPMcYsFPrpnTuQfxZ3GPnxpHx1sIfgViC43o4Iwyf3WiS9tp1q40Ai8+vUtQaA/v
         phgkQGhxm6USS8bp8COjI11x4mL8PxToxIMV/Qi5cjgvCfMXOtPE3GFZO111pUnzCdBV
         dZRw==
X-Forwarded-Encrypted: i=1; AL+hErEdojgya9zUPY4A+e9Dn4Zta2E1kN7xHqFLAm3KTiTFprvFJlxTlJWFl27Fm+HZADHNia2Lzyc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mLZQmmlH7EPVZVvX9Z0xF6fyogCRm/SqCwHLeBlHoF/M3Hy/P
	X4YONZBNSuiMnBRnawEyjXlsEyE4Q3nwF/1pZ8uDtaEzNWQBe4pJd13AwSwjxXSbUMfp4AoyPnQ
	AuE/b+SZWsTnino7D/5aIE0ceE00f4lTTkzT7fI58yt9/9Ud4aTfxQPzdQWCwSZ3QLd8K8xZFii
	1IeNX4JtGAtP/C0gENySrxbFGsXmlCuj1G
X-Gm-Gg: AZFdTZdQ0tKb/FoOIIa0N6Z5fc3chhmf9NsTbh1VFZNS1+SVzKUGgnyg0kOfnt4xHG2
	GkAHtmFU3CqGug2lg3J4lIGORVp0FNdzFEhTz7CV6p95shHSofvlznbuWay8/eTWU5LRu1V/Ixj
	wZsUsysvnUD1Hjr53HONjAJlxtIB1VxgT7RvGE2cQ4C4dOLpceD6nv/WFO8w1gzb3nL5fdCThQe
	NInRgFpxLdqTU9NxxpX8Ig9E4tplgwRWboSnM9U23YguvDyZzEtVVe/RjI=
X-Received: by 2002:a05:690e:4883:10b0:677:d5bd:8349 with SMTP id 956f58d0204a3-67df445d5bfmr2252245d50.63.1795450125513;
        Mon, 23 Nov 2026 08:08:45 -0800 (PST)
X-Received: by 2002:a05:690e:4883:10b0:677:d5bd:8349 with SMTP id
 956f58d0204a3-67df445d5bfmr2252240d50.63.1795450125014; Mon, 23 Nov 2026
 08:08:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-3-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-3-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 17:08:08 +0100
X-Gm-Features: Aa3M54pR7ZVMpPP5oNO1OCA7GwyP-se96UdMP4VNO94DAWt_5DL7ZGYCWayniuk
Message-ID: <CAJaqyWedvj6htnM4rJyrbynW3u1k=6uLHrfuK05YvM5z8v1Hjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] vdpa/mlx5: Fix error cleanup when VQ setup fails in .dev_add
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> When setup_vq_resources() fails in mlx5_vdpa_dev_add(), e.g. because the
> firmware rejects the provisioned features (HOST_TSO4/6 without CSUM),
> the error path unregisters the vdpa device first and then keeps using
> it:
>
> - _vdpa_unregister_device() drops the last reference to the device, so
>   mlx5_vdpa_free() runs and ndev is freed.
> - destroy_workqueue(mvdev->wq) then reads the freed ndev.
> - put_device() on the freed device underflows the refcount:
>
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
>   Call Trace:
>    mlx5_vdpa_dev_add+0x3e0/0x760 [mlx5_vdpa]
>    vdpa_nl_cmd_dev_add_set_doit+0x362/0x440 [vdpa]
>    ...
>
> - mgtdev->ndev is left pointing to the freed ndev, so every following
>   "vdpa dev add" on this management device fails with -ENOSPC.
>
> mlx5_vdpa_dev_del() already does the cleanup properly so use that. Just
> make sure that an extra reference is taken during the call to avoid
> _vdpa_unregister_device() from freeing the device under us.
>
> Fixes: ffb1aae43ed5 ("vdpa/mlx5: Pre-create hardware VQs at vdpa .dev_add=
 time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 6830a80e8543..7a39b0bbbee3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -161,6 +161,8 @@ static void mvqs_set_defaults(struct mlx5_vdpa_net *n=
dev);
>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>  static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu=
eue *mvq);
> +static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
> +                             struct vdpa_device *dev);
>
>  static bool mlx5_vdpa_debug;
>
> @@ -4043,7 +4045,10 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>         return 0;
>
>  err_setup_vq_res:
> -       _vdpa_unregister_device(&mvdev->vdev);
> +       get_device(&mvdev->vdev.dev);
> +       mlx5_vdpa_dev_del(&mgtdev->mgtdev, &mvdev->vdev);
> +       put_device(&mvdev->vdev.dev);
> +       return err;

As a suggestion, the cleanup could be more symmetric if
mlx5_vdpa_dev_del checks for NULLs.

But I'm ok if you prefer this way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

>  err_reg:
>         destroy_workqueue(mvdev->wq);
>  err_alloc:
> --
> 2.54.0
>
>

