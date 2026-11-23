Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448359;
	b=m1XuzE0ZvMmQho/Tkl5hU8TLgt7eoei8Oc6fjPPhSCb5mW4LKELG+DDNeb1VcalLVGlO
	 R41XCnn1pCwSy7jxe7EZoOJYnHLNhYt5z7uOFMWODKkyg2Q/LmU2U4TxO9Q9iBEE67e4H
	 SujaMJUdgEgSwpx7HpjpD5A/8szcBOJ81WAmN0I58FrZJ6wh/nfBdOMgtHyPJg+c4YLuU
	 74stEb15tNkFVpdJlYQ3p1WGBNLyLaytScTv6Qaod3/xiTB3MYQx1BYos1fdWA9TtNiOr
	 FeGTgiz+hfT4sAMWb5dusHHIS4EeLFrSyR3EenlR6S1Q4labdRC2JSgIS74+noR1M4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448359;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
	b=CFI/83K6a8e8s5vltU/FrRZu8I4UgQKWU64RxfV4k48egBnBAXG2R03n0KrE3puS6UlY
	 yze0YyAXGTcaoaRNyl8FQzj13o1oz1dsXGeQI5pVt/6Gn9jd9n5pE9FFFDfJ5mcmiW1v5
	 rK37AGGCz7lP9DbIuqVT5sizF7AnvNc3HNlJbqs5EmtECeqjDaDQrA0AulboijWDspjL+
	 Pg3qv0nk7/XFDIC1LRePYHcMYFpJDjtZ++iN219eCRpNRm3PWchumiLZciWFHSOlbGqo/
	 ppRRbk4dGMjovfNMjZPlcSxg2l5lDndtIRuxGlUjTQQoIv38VOt4XNH8DDjeo2gkLzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a57uxpBZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L7yVAW4X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793B606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B793B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a57uxpBZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L7yVAW4X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795448357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
	b=a57uxpBZDLHfrmCork62OYqreU7S3HBuK/1ZQ79lOPU+fnvQ54ohkGBTxEOedtHGRO6bh7
	nj+cg014VjsEwONjnpXIEOcDUB+b4pwxyjoaT2z6Zq+zXYBgHUVnBALWRgKSoqOghHAZSZ
	OQJu7eFXIGOJS3pJXoEYfDRgY5HHzXs=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327--m8Nz_BqMtKNCwExf3G93Q-1; Mon, 23 Nov 2026 15:39:15 +0000
X-MC-Unique: -m8Nz_BqMtKNCwExf3G93Q-1
X-Mimecast-MFC-AGG-ID: -m8Nz_BqMtKNCwExf3G93Q_1795448354
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6799288480dso4890331d50.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:39:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448354; cv=none;
        d=google.com; s=arc-20260327;
        b=D+qw/DyA9BmQ4TKboPLc0atr6e5t4FuGwy7fZdlekUDaNB1ph8MbnHwabFhs+RI3My
         3q+Kw/orOqq9tiWEjNpDkoHK1Oos/8sgz/cgzL+pWF4vrF6hZfLs58N/lM44i7H0pyak
         Apgs/uru7BlNLeO/J80fcj+K0MUeciRclGKg8q7qwtkplNGsgjuczCxYTlwuTmRu5wXt
         zrVgt1XK5LXlxh8NkEQm+FNR2dqIkfE9BxvfIAuHUk0IEfMhBT60uFy2AEk5ymrf3zOg
         RHyDs8gDRcLr1cfciSiolMHasHNuKKgLsY240O2BMJ7vv0lbbtCDebdgjHOtstIU3PlN
         HJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
        fh=VwqltCDQstXKO0ssAw96YtlGk4KBDRDW/4jEY0hSmgw=;
        b=k7FXNNM47BYBM2Nu0vilj4lZKFB1r6PxgQGzZZKvfdsIQ8H4npoIHHq9ohBIMfMvft
         GkzNcp6ytWOWTENEvRGjOCrOL9E+DNshG/+ozeIbe8XkBNBNcIl9sDCQPRbN51PXz0gx
         0yyRKjtzxQUfarxbn29ikNPzDfYan2Fkwbju9jPpVPDiXOl85CvkaFtM8SXQho/i0E5r
         N1Xs1F0gaO/yXxobj23zfvFGALkPLA7mQqO0w8X1PxtsvzGm0RA+tpPT9C20lpMl4uur
         Pz6J3eLWlnA6AjRVHNZwx4DhxASsVgTvI0U5gsFnr4As8r+aK4TQowTMmayfJG5h0RdY
         5tjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795448354; x=1796053154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
        b=L7yVAW4XayKESw0Z0ypaaNCQwNhK1/UdB2KJtndGOO8ABCoM4cD3s9Dta3TGZ5rfJq
         GAy0EM48AUJUROlm4Es61DJpyI8PnqMwgIS0fsnxvYvjszHlgdpBTaaPA5sEBkzRy61S
         L0wg/KG1W62msYksfUFWsCWkQ2h9GRcXaqx/P51bS0IOJXQH17d2NgLlPp0wRQZMnOWh
         Lnwb4qrZkwZA6Z2AWdZ3ZtxI7V/yNL1RjyfPpI0VNV4ULRVlsjxnnBANrCtS/JKFZ6ll
         Jf20FabpCR0NEhlgg46jfsZV7vbwaXh28Qfd5KAKzgWMIeShGQUnoGg+H5gV9FKjEKkb
         cduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448354; x=1796053154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
        b=uHm3wDCPIqsV5dzAFkbWXLzWcUOuddZPMn58Vn57k9pi5M+fdWRXiCChISA4vaWLWR
         QI8WYSBu1AzeL7SVr2iiIHiZGNYWKRFbUbNpzNqWoaWa6TRViJ7OBrj3INemVhb26BxY
         Kpslcx+S3dMzRLf+Djv7byDUznOGsMVlsZwQRmfqTL2Ysja78SZ2VgBLApnQzBmq9+K8
         gwSWQCFYPKZJoVw9/UQXuRr+2fjIpfPLYEC3frquFFMWFaQyhJFWbp09GdFdS1gpZ3I7
         VteAvTHha93ZkwCdjhTOaP1pwZFlUfqSRIQeGfj4c+Pq/UP0yhLZh5whh8dzfaopGgkj
         mHlQ==
X-Forwarded-Encrypted: i=1; AL+hErHzN5OwSin8CF31FKTnZ4JftD03ALDj4Pcho2axvaBTKxy5xXompvgt4R103LIBLP7cLZMYpOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IMEOa+O/5IKrhDwqxXtvRhcFlsTNniRnUQleeZOUXX1fp2CFZ
	VTllOW+2Z2HQcNjweh1fYWsbnILj+EaTiak5eNxhhyFLlYMODhSxsP4PKNkyOkFtFb++W2sAdb9
	SBAb79jKYo6WatAA1ZbhBGM7b/xPU16UctMSisQk2BNvl9eZRjU/9+UdrTAxpIoOWKTvWMoYVxV
	npl4h7YhRkZQq1hpkd0I3yoMr4BTLTvOCwidp02ygg09U=
X-Gm-Gg: AZFdTZcTFYECZYCRbZMd3iFlmyMzRwRYmP7XB6nIgdKice40b5EIIOpQIV985RrHETI
	9BxIldQrX2r/mBWEIgUdN2Ycox6WGhqJUBbBTdc+DW8OD5+duGOPyHb8DBYc6DfKQ14oxMhGXNl
	Cz5kzi4cwHyOKMbHr9nBu8n4lMia5bZQ3qECKHZEU4cR3IeUE6t7XuwlXrfB/Mo/LuTPIsXYDp3
	kSPvtiHa9Xs28pqyBPyUikb3A/pI+MbjRw59VRvvVpK7/nrBvAqfcWzcWI=
X-Received: by 2002:a05:690e:1248:b0:67d:b995:a5c3 with SMTP id 956f58d0204a3-67df44b55admr4416370d50.70.1795448354448;
        Mon, 23 Nov 2026 07:39:14 -0800 (PST)
X-Received: by 2002:a05:690e:1248:b0:67d:b995:a5c3 with SMTP id
 956f58d0204a3-67df44b55admr4416353d50.70.1795448354006; Mon, 23 Nov 2026
 07:39:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-4-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-4-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 16:38:36 +0100
X-Gm-Features: Aa3M54o_X1llfaYVgrhNMk5-QtVPWRJiZP6Jl7gQZsBvDw4xjjtYogw0lgFiv-A
Message-ID: <CAJaqyWeKT3A2A5OHiB47j1P+e8BSoAbtJ9XaGLjU+kKOzOusMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Increase the maximum virtqueue size
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> mlx5_vdpa has always advertised a maximum virtqueue size of 256 through
> .get_vq_num_max(), while accepting any queue size in .set_vq_num(). The
> hardware handles larger rings just fine and users have been running with
> 1024-entry queues (e.g. QEMU's virtio-net rx_queue_size/tx_queue_size)
> since the driver was introduced.
>
> The commit in the fixes tag vhost-vdpa enforces the advertised maximum
> on VHOST_SET_VRING_NUM, so configuring a 1024-entry queue fails with
> -EINVAL.
>
> Advertise 1024 which is the max that qemu uses today. The device itself
> supports more but doesn't advertise it in any way.
>
> The Fixes tag points at the vhost-vdpa commit rather than at the driver
> because that is where the mismatch became user visible. It also keeps
> this change out of trees without the vhost enforcement, where virtio-vdpa
> would otherwise start creating 1024-entry rings instead of 256.
>
> Fixes: ccb1dc7c527f ("vhost/vdpa: reject VRING_NUM larger than device max=
")

Is it worth backporting this change? Nothing should break (or be
broken because of the 256 vq size), it sounds like an improvement to
me.

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Cc: stable@vger.kernel.org
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 7a39b0bbbee3..f1c5f72032a3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2965,7 +2965,7 @@ static void mlx5_vdpa_set_config_cb(struct vdpa_dev=
ice *vdev, struct vdpa_callba
>         ndev->config_cb =3D *cb;
>  }
>
> -#define MLX5_VDPA_MAX_VQ_ENTRIES 256
> +#define MLX5_VDPA_MAX_VQ_ENTRIES 1024
>  static u16 mlx5_vdpa_get_vq_num_max(struct vdpa_device *vdev)
>  {
>         return MLX5_VDPA_MAX_VQ_ENTRIES;
> --
> 2.54.0
>

