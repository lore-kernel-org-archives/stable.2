Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607239A067
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405040; cv=pass; b=p4dq2r4vS0rCGmO6HoipU7gksdvCivyKhF/QNDSWeb5QI0K48cCcUQ9yClDpTzault1e8zm20vARugQXKlqT38jp87Tz4jqDiOfQ8wToMgyGjAgUAs7OU3qPEFTJxmeBiiCken0yFGqFOlvyC1S2mSillvm+UvlPggpM8XTshA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405040; c=relaxed/simple;
	bh=L/x/MsSpsPMPwv6hmc9szKtWP8yzSBXJpWyuSwDuuXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dvtb74dLQUlzyTEX9Gy6Ycv5E43ZEdOOq1lriZq04miW2xA8j8HHygOj/tDy3ISEEmzfsZdzq4At3Ov8KAlsnc/AG3tvGrwzEcWtTPCZ5n67kPzSBcdSnHADsIqN1qAuLCt+cP2z+oBemgHP1tGeIqoi49Wh3ndiYMEC6vaOhl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq6u1nQH; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq6u1nQH"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2c570f6f36so64408466b.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 23:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790405035; cv=none;
        d=google.com; s=arc-20260327;
        b=IHarKtBklwirJIM3XoizXDF3cQUa228MbgNY0FPmkOzNTlvdybJmCZfM7dIV3A8xNN
         c7//8Rql+PkxxUl2XLkAR6XcGZbokCjnuoFeR33jkXgGI9Um0IuhEd3VnNiH00hsT9lT
         VamzzUl5KAurigeqj+QclBDf5jWF/JLJYBEXUfY6zTYbtLsrqOXJTQdLBp9IsPM8Qbv1
         h2oJqGdpgpGrNbVoS/pXC9wP8nOBNQi+4nt5SwBmSdzdGA7rFdJYnCqPjwHPQ9QaWZPh
         I0dfm6+toDdo0pDobOcgXy1eBCfVzY6jRCcfRNmmuXzs/qRefLTWNQAD/abSgj8LAfuQ
         4yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        fh=RKr3DCKTEaxrv3C+kGnFaLV1+AUTv0K+coE5leV3CSU=;
        b=BCDMR5jD1/notXK+jXsFnM7HV9Tvi3b4rfPhrU4+cTAhzymBV63f6rPPeGWi4OriRC
         rqVgwRWW+Yf/QgzJJE3mq2JywzMw9oodwPTue4yNGvnLdxchvDrzxlw1X4eHdJGNxoLC
         UOyDdg+3zQCTr8/w3HzbGJ6NglwDeqrwgiGXXkceglRMvWy6m2qh8SyVPh+HhkY2t+lF
         pawnH0W16GG/BperRbFIYj/mDJszjFBv9DA7QEbOWu4ufNhDyLE5LqM5e9rQ6YemGdGs
         X/kOT4hxvjuIbsw8slQXMBEhx9mFQw/WKxyMkG1BolH4h/uJlJFnM2cjY3wUP4Eub7Ha
         InVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790405035; x=1791009835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        b=jq6u1nQHEYh8t9O/sL0lF53go1obYIzbU7c7HNlYeQH6JvuJRyEJSUrjEB/vOwo5qn
         uesatFnTPfnN9YvYFfBYym7F7JiJRFYkhGITALnNd7wAiRc05YDg4c2dm7GCqBh847BN
         y/exse6jDQyJdgVdzyMDoQu7q7oGTaFCqvoms74GWosmPkhj74h2bzkmK4xF9F6NvKqG
         GoMxX56VXXgRkRvvT3WP7p1PwjsPBmveAxnSTuBVUM3vPcfsLEPQrCulGfBQwlw/zIq3
         oUQjLs7hMkYMA6mxlhE1ypwRyDOfoyXnM0I7O63VKA41BHrDa6luVp51BfAEmALjmToN
         EPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790405035; x=1791009835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        b=KrvMErsdWSTDwuOXfhWGRIdGprJTXXm2UOTrMZnFv8ygMLsIlzaFg1bMnAf88rVNzw
         k8wVeYfS68iSENgBsHB4Q3ap1hpGNAYIQiV/YX3VFIRe9ylPjsTYyPEMMZVtuLwDtbTU
         hbMm4GCvX6NtTjkD04aboHa0r7rJajtbssD6mkhGm5BDqfHeZX3YvuXkZXo1w43hwyMr
         W1ccxZrQmmz7xx7WXuA5Z+8sGqA4ToBm3ayo8sEIkD1Bul5PhZIyVx8WwCp4EGm7PaBo
         VZUW4iUFd8318fQHzBaOUJjxmz1303bDTPOBaPC9ImY+fH1RgUtjY7t0dQ+0c9jN+x0M
         oN0A==
X-Forwarded-Encrypted: i=1; AKwUvBztkhNffj9+1ZXOizNKqcvtkccgtSJbfdJi4C87jqJ9jDS2x12mQ/kKOOTVy2hbfq2QK+iZ6jA=@vger.kernel.org
X-Gm-Message-State: AFuF++kElP90p8yW/dq5wwZ+Q6b16LD1SGPlF9Hi1ohy7IEAhAcKBnBV
	gUvnrGj275wTUNzSw1esVHZ5JWoHP6fuuvVS5sLAARXugt7eyOLuM5M97AwTU7Hlehk10mgDxfH
	QnWZYENR3p6MzcoWvAJkNzJeU5mkmqoY=
X-Gm-Gg: AYBFou1rkGweLRfz1NUGJiE9njM6Ovx2AtmBVN2a7nyPhyr7rz2phIbOHf/C+sGMVlj
	0lExZSU98/5HljkBf10UgEZpct/OKWWp+RxbmQDs9d6k+mfRduoXngStpiyGnNI/8Vid4JjNIcX
	jGl3ZCTDnHSnewZyUPhvC0UgqErPi2OSXnu+kRMNS0OfTV1gfepvWBINK3HdhheK5dEiEsrB7Lw
	PUdHihLOXXbQiCGVwT/icSY2sacu2/6ENEh6GyFL8IaNlewX/OhV8klV3wccSYn9BEMG/FPnUmx
	mUtC4nUGV8zq/CcggZiIIHKI8Sl7QSBkgCcIdeGnqXH3TknmPVQv6hP16iie3LZGY0FfHo8vgBH
	GwRrboz7ZXTPd0oXvWiNU9mo=
X-Received: by 2002:a17:907:d408:b0:c29:3821:ae6c with SMTP id
 a640c23a62f3a-c2ac2606943mr702009466b.37.1790405034922; Fri, 25 Sep 2026
 23:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122955.69433-1-fangxy@xiaopeng.com> <20260922122955.69433-3-fangxy@xiaopeng.com>
In-Reply-To: <20260922122955.69433-3-fangxy@xiaopeng.com>
From: Jason Wang <jasowangio@gmail.com>
Date: Sat, 26 Sep 2026 14:43:42 +0800
X-Gm-Features: AclHuK8xFsvc4j73hXtI-ilJ3XzgO5FqQXk1LCo83q1Fcp__nagIQq7skCOkqq4
Message-ID: <CAAf7B_NbjMu-9CEPwN2HD8+P=L4Nkk=tYO7Ga5-dHq=CVneBwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: add regression test for cyclic indirect descriptor
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	stable@vger.kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 8:30=E2=80=AFPM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> Add a case to tools/virtio/vringh_test.c that builds a top-level
> indirect descriptor whose NEXT points back at itself and checks that
> vringh_getdesc_user() rejects it with -ELOOP.
>
> Without the preceding fix, the walk re-enters the same top-level
> descriptor without making forward progress: count stays flat, so the
> traversal limit is never reached and -ELOOP is never returned. With the
> fix, the top-level count advances on each re-entry and
> vringh_getdesc_user() returns -ELOOP once the traversal limit is reached.
>
> Use index 1 rather than 0 for the self-cycle, since returning from an
> indirect table is only performed for a positive up_next value. A
> self-cycle at index 0 would instead terminate the walk and would not
> reproduce the bug.
>
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  tools/virtio/vringh_test.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 84961b9..2a5d7f7 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -458,6 +458,8 @@ int main(int argc, char *argv[])
>         int err;
>         unsigned i;
>         void *ret;
> +       struct vring_desc *ind;
> +       char *data;
>         bool (*getrange)(struct vringh *vrh, u64 addr, struct vringh_rang=
e *r);
>         bool fast_vringh =3D false, parallel =3D false;
>
> @@ -755,6 +757,45 @@ int main(int argc, char *argv[])
>                 vringh_iov_cleanup(&riov);
>         }
>
> +       /*
> +        * Regression test: a top-level indirect descriptor whose NEXT
> +        * points back to itself must be rejected with -ELOOP instead of
> +        * looping forever. Use index 1 rather than 0 so that returning
> +        * from the indirect table re-enters the same top-level descripto=
r.
> +        */
> +       ind =3D __user_addr_max - USER_MEM/2;
> +       data =3D __user_addr_max - USER_MEM/4;
> +
> +       /* Fresh ring and host state; resets last_avail_idx to 0. */
> +       vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
> +       vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
> +                        vrh.vring.desc, vrh.vring.avail, vrh.vring.used)=
;
> +
> +       /* Single-entry indirect table pointing at valid data. */
> +       ind[0].addr =3D (unsigned long)data;
> +       ind[0].len =3D 1;
> +       ind[0].flags =3D 0;
> +
> +       /* Top-level desc[1]: INDIRECT, and NEXT loops back to itself. */
> +       vrh.vring.desc[1].addr =3D (unsigned long)ind;
> +       vrh.vring.desc[1].len =3D sizeof(*ind);
> +       vrh.vring.desc[1].flags =3D VRING_DESC_F_INDIRECT | VRING_DESC_F_=
NEXT;
> +       vrh.vring.desc[1].next =3D 1;
> +
> +       /* Publish head 1 on the avail ring. */
> +       vrh.vring.avail->ring[0] =3D 1;
> +       vrh.vring.avail->idx =3D 1;
> +
> +       vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
> +       vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
> +
> +       err =3D vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
> +       if (err !=3D -ELOOP)
> +               errx(1, "self-referential indirect: %i not -ELOOP", err);
> +
> +       vringh_iov_cleanup(&riov);
> +       vringh_iov_cleanup(&wiov);
> +
>         /* Don't leak memory... */
>         vring_del_virtqueue(vq);
>         free(__user_addr_min);
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowangio@gmail.com>

Thanks
