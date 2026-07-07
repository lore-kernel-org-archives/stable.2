Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0435B645
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450880; cv=pass; b=hqTsufkcKPgOY7QOZJOH6HS0YGvU0VFwVYCMr3mLyHDFDq9DE0/JiBSV2GhkMNStk2Y8aCAW+FPsIUZSjLj8JPvodpGVaPe2Pv3jJhnF3FzII7Pm2OX7UnvPFYnHBvc9AMQy7DwER5yWo8NCrszvFq51IK938sIkZFnkCDO8zUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450880; c=relaxed/simple;
	bh=9YILv/b/wrOOopqIQNr3zYUi1Tt5X2/kqpJzZKHDvvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMTvkW+hD9lybSDA0KhNFxIFHraKkJsQ+wj7Kylw6VjSduMK610AnSvSWwLZ/QIy/LVF8dHxgVrPObRluQHC7hXk7g2X0GP9BQw3jNJdQTD/joJTSyDZKgrUPblS2TL/MzvCRCLocjCjnzMAa/Ue7YhkARmEDLmvU4K8Z393ALM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nrSC+Oyg; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrSC+Oyg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cb59f6ba26so19345ad.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 12:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783450878; cv=none;
        d=google.com; s=arc-20260327;
        b=tAKzSCotx0tFHOt5Bc6VXYasbcc+RBtRQ8zhhSPduc35eZRevQa/3XRX6dkZNgE3sh
         5LDRQFB1v/34vT0wc8CHxutPFYlrwCiPklrgcDb07YPzbYCOswZmfrkfkRYoNcDiN50A
         DjrX/a3CN4LOPhFZNulFq5hzhBUYtDxTkyARJu9knoktf05CfCvIvYlMMyxdT1A5cHak
         5aDEzD/evIVmVHq7I0oXLRa3jeZgybG3iiRNvXR6F+kbgh/NDKRyc6HkJb5xJ7RwObsl
         Lzt3rMQ4cs2pTH1KXopTHsYHdAR2bb1GcRpulQCvqmUS8EBghDsIgWCsOamsHwBP/KWP
         8K2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
        fh=gYN5aOUNZ2169W7Dg2ht8SWjiRIhSItVwHzK1z+nI7M=;
        b=W7d2yOLZG7CMjfkHhL48crE1E9N8LFZnBNkesdvnrUKpdNg4ljQTAeAqu6hwTYE6Um
         22h979HBxiQMNQaz7WPL9wISueOzK1H0L62pmdq56F6ZpSiJRf471E2JLkdAs8p1kTU6
         fpWORqih3LtMrU9ooCFF4q0k9HxHy1ZMCSOhPAg2DoMf2B1TY8mNWLPfvF+zMIms9Bhp
         q4ys97dtyxj+ln5l7vq3IUjfiqA5BFSG0toSmDr3siWQIYUc5d/EuGzQ3FT0l6DosbUE
         teKbeQjqn9wK5HGVgU4j27iKITLj6cbZeX2iWZBf3+zpAfD3EYgNR4M+Ah6VUQr+KtRm
         FVSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783450878; x=1784055678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
        b=nrSC+OygB3rohIluWzVsieWZZ9HytqgCswCNOR6//fMmcwESZY9AdwXlqSCyecr0Rz
         MLm/X8/B9qvB+jL+yR36VJ/OmzUZRmf1C2oK1LQ0eE7FwjDJAZt7Xi0NDpW0qE2h3qjN
         4m5n+ltLvSIL5FJ8Gh2htBmo8QdHiF/nRrplx8pUFx4Ek7HazeAQK2g+ZyX2u6N2HCtY
         eLW2AdYwaXm88EvvyVJpy4AFeePc1MB+pwqUwVSn2d92o7HcCH5rLDwJAR3wZoydqMuz
         I7bM+9sM7UwacRO7Jc3aMzX8YwU3YUj12eU6HuqkHlNiShcpFFfku/2pOzZ38x07UL06
         Xbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450878; x=1784055678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
        b=RUt0smy2z0h37t8IRn3F2DM33/bzzlGPaQKHzEGYXT0VZftVrGYSI2F7wI3rApBF1V
         jJLf5xHxWif06vSSyieWoZ0tU4NyNFsm+uWjm6iL+gGSWrqkhNOvmxLJEP9DbuRs9AVW
         jONpAlnQjy7RqU1JDviDhTxDGCnZY68wZtXVcNDPosBCPZKFmlH1g9zdygK7k/5Lr0l+
         VOfdyfZ6eVjCIyNgHXXFziiYYvh2kynVSvY3Mrjkd2SkRRooR4r+YFgz6KYPVYdN3vms
         GgA2Hxmp8/ZsC8LFuTX4zU8viefalWILNzVFLcJdubuoYJDF8x/g+8TVU0GT9FbI76Jn
         jnJA==
X-Forwarded-Encrypted: i=1; AHgh+Rquo5CMexKPcd/YM8tfahR/4+nZqN41pMd12LSrX+XoZ7dHaP70/ltgk8y+k8zQH1J3UKu9KSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweb+NxMVgp87ThCDRZlsjomOCUrz4T2hR8LW6nniv3qXmJCLlz
	K0dZKxUizTLxrgJ2rij9PxjETZqZpWhF/B6vvi5knydZV1SC70ijeFC3TXQNjvgpdI8pDCoHIqn
	KG1M3h3Au5pPdz5FtSSoB54BNuniqwyKJIgTFITk=
X-Gm-Gg: AfdE7ckVuoAf3zZiNiC5u2sTjPTFAg3DeE5h8GLR+ni0a+V2D3U4H7DJXeBZo7Maekc
	+qWnwiCj3OtAX5DEmcbed5W0qV/YJu1m08hYgyWodfCfOfAKDLdpXY2r7LewF/bx5dlgnsW24aZ
	KoikYIxS2wbsNYT4GlF0OodSXlHSelDsU1xEV2sGKDzfqQqcO3RwU0cdtjFfq8k9c84iTwXFZgp
	TRkzB5w8zPJm/gBGr4RxfozWZSLFffdgMIsprsg4JlMmLV/IS3+VoR1cX5RVtQU3z2LeUv8+XSD
	R1PZxZ1mDKADW/r3b7Df7V5Ie8UrxA==
X-Received: by 2002:a17:902:f705:b0:2cc:6df5:62a1 with SMTP id
 d9443c01a7336-2ccc9cfe5e8mr4326205ad.20.1783450877735; Tue, 07 Jul 2026
 12:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625170828.3335431-1-natsu@google.com> <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
In-Reply-To: <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
From: Yiwei Zhang <zzyiwei@google.com>
Date: Tue, 7 Jul 2026 12:01:05 -0700
X-Gm-Features: AVVi8CfqZRK8FjQuAUJC_3d57L43GEZFnnGMpVl0zr846a_sRmyOwX1vUSPqcgA
Message-ID: <CAKT=dD=YecudFK1L9wJ22BO41qXt7V4Qm=nNQQiuwheKejoHdg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Jason Macnak <natsu@google.com>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 2:39=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi,
>
> On 6/25/26 20:08, Jason Macnak wrote:
> > Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
> > Don't attach GEM to a non-created context in gem_object_open()")
> > to virtio_gpu_gem_object_close() to avoid trying to detach
> > a resource that was never attached due to a context
> > never being created when context_init is supported.
> >
> > Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default p=
aram if context_init is supported")
> > Cc: <stable@vger.kernel.org> # v6.14+
> > Signed-off-by: Jason Macnak <natsu@google.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/vir=
tio/virtgpu_gem.c
> > index 435d37d36034..66c3f6f74e9c 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> > @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_o=
bject *obj,
> >       if (!vgdev->has_virgl_3d)
> >               return;
> >
> > -     objs =3D virtio_gpu_array_alloc(1);
> > -     if (!objs)
> > -             return;
> > -     virtio_gpu_array_add_obj(objs, obj);
> > +     if (vfpriv->context_created) {
> > +             objs =3D virtio_gpu_array_alloc(1);
> > +             if (!objs)
> > +                     return;
> > +             virtio_gpu_array_add_obj(objs, obj);
> >
> > -     virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> > -                                            objs);
> > +             virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx=
_id,
> > +                                                    objs);
> > +     }
> >       virtio_gpu_notify(vgdev);
> >  }
>
> The following scenario still will be troubling:
>
> 1. vgdev->has_context_init =3D true
> 2. virtio_gpu_gem_object_open() invoked, GEM created and not attached to =
ctx
> 3. virtio_gpu_context_init_ioctl() invoked, now vfpriv->context_created
> =3D true
> 4. virtio_gpu_gem_object_close() will detach resource that wasn't attache=
d
>
> Add obj->ctx_attached member to struct virtio_gpu_object. See
> virtio_gpu_object_attach() that uses obj->attached, do the same for
> virtio_gpu_cmd_context_attach_resource().
>
> --
> Best regards,
> Dmitry

Hi Dmitry,

WIth context_init, resource attach/detach is per-context based. So a
simple obj->ctx_attached won't work. One would have to track in the
guest context_init ctx for whether a bo has been attached or not.

Another option is to accept this patch and live with the case you
mentioned. We can consider that "invalid" user behavior.

Best,
Yiwei
