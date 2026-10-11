Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95363624AE
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 04:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791692663; cv=pass; b=ak+KAub7Jc14T0g5M22Zms8So25nXT+9FtZL7c8PJDWSIM7ZH3q/VpZ+8TdaPJntSH9ajOKX38ua7OwFUrEJpVn1UD6ows5oXoIOIvMNa8FnZaLEhkCGKV24Xe4HoGRqOjJZw32cHazrMAwr8ElWjU0QXMXZ4UBb1KNNaeDTf1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791692663; c=relaxed/simple;
	bh=qdxE0RHmxCdnGtaZYVfxmF/aX520nxo6WdF2env194g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luAk33PmqG+buIQ5fPvT9DrBsoeErEdmaZfueVpucbK43p7DSXxWJoksmYpdjN8BxEkTag2ha/bqw+o0uXUYPNokOnMqg/ycIV7qFHoah5E1BtS3eVdgOB7vuBYNe1DiJR/R+k2FjrL6uAo4qZsUe79XAqEyi1TfaC/3hH5L05M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfNhN1zS; arc=pass smtp.client-ip=74.125.230.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfNhN1zS"
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3a7f674d148so7788111fa.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 21:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791692660; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9zHx+o6gjaWzTOCZo5yVz0dcClGPmZJgJBKC9Ad8n1LYzzdY6LEclfieUlWBaPW1Q
         it+Vj6FifAW9n1yIA/7GrL/fwjbliXMMJ+rirP5frfpguO9MAwETGquXNeLmGmOfZbT4
         TjnP26/poz9C6aroFvq+SktVh9ptq+NkZ4IN/35LOkEjNmECkSZ77CIe3LiiN/rBOW6y
         JTRgoEhLigifJyEebaqNoKTDQx28POYZM2BdzuflG2x6x7E26e3xbXHn/7IopQpYvGh/
         7o17wQs1drNHMqRSAFVi7xWxQL/jSAzuZIOoLcx2fhi7B9QERUmZ1LInUYl76rqqRmvK
         xN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
        fh=u508j9i0Jk6FsxlFYRMN0Br1PvuvJmvTP6Nq6HGUAfc=;
        b=MD7JaL95xsn3zSPhbwGq069iRNeGQbfT63qtZB7KgJthRNnj6bPs5g2KeS7jFYPhfo
         lB0sBiHZV1uK7Ww4th/Gs1vdosBW+sujXOZs3R30sDQi/SQ7u6NyiY6cl6fLAPNh7W6d
         v7p1JvZHg58U1dXZMynTHuOBV36NVdyHbgZ94vdc9AQNHldtMDvwc8lLIIyMM1ggFsAY
         nj6ky6e2Y2V/OqY7buXK8xUF0W+DS+j+uaFDrc/RZvt82MhZD173Jti0FwWe7BaB3QAC
         EFERlin0zGSHoIB/CrJeCgmIzuX1pwcwEDe5fuTe09wvfrDTu7uO/gzj74tEJBxnzkMt
         fr1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791692660; x=1792297460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
        b=rfNhN1zSVCKpko3buLAsnBNMoCJlRFVA3akvZkd5pItIqMTdrB5w/VDWNfFGEpIck2
         Trsvdo1Ryc63+upWm05mysSO4ymHbqrpQtW5JzDKe4Brsre0wmpyHj74fC7wQvUeBViK
         QZyPemVaoKQMoNcmszJ2KnNyhHrefIg6qYpc3VEF4Ehk00lmgl4Lm+SLZ5tq/aHdTTNj
         p77CxAibofdiYErNUChaQawsajTCkMDAvwm+Vr1/qRqKVZLg8fgGQYP0nhu/6LsYf577
         Hy9phEtbZUVLgs9+bFea6MtDI08DrYrxDwqmWRIV+gtABVyItlBDlMvgIB/0CgGnAm9T
         IT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791692660; x=1792297460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
        b=EuSiNYEOZrS92p2q3BjyaYiKYccgkr12rmUzKoSq3aZoKbcRzBH2PcbsCWOeIPurtV
         dq7MY3q23PZU4SY0FP+BA58RWla03v1nzVnF9NPbisxvO4Q5brdO1CHZfBE6ju2tsVJI
         UuVDNM5SiGl+0dR2n/ll3drQWeP3Wv/8Bh+ddyLXKEPAhlSVCyHyhFbRazh6HQ5f4vay
         ox/TWdl0tPhnzGOyuPJJgWzJCLj7Ukodc06pEdHIlnjW0C1sdNx9jFxiZP35BEGTU1f/
         HcF48HZKYcAwzLwlBSeftJgVDgoIGu2daaaAb3CqLlsDK3E7vp4CaxV5Dv5GmXksC2NJ
         pGFg==
X-Forwarded-Encrypted: i=1; AKwUvBwPpd+KNfyr/qPiEWZnrtj8hFlfytJ1bbBfswH27cxrB6tl2Wp2P78XnLbbkBsGFpbFTfjXVyk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLk0RughS/IEAe1PSUOtjNBtYwjkGn8J+x8rrAzIIclxmXw4IKh
	OUK3g7QfHDOSwlnm/nEDPqsbtvCWnylIkPZtUfgbZImYZy+ytx0AOwGpg2VQr0fZazGMFLMoale
	NslwpXRjwdkXrQEfzgM80ZH+Zd4mjSlA=
X-Gm-Gg: AYBFou0Aa0/kMHfgN7nZrk6nUYVLrVcM1rEuH3oz8/TJcXg8haNffi5JL+1VNexx5y5
	zEDYWdgL0NQoHhhi+9IsNkBbPZ9kytRgBd4MS2Tk5CAgUWlIR6bzQLy1s+ceq5BrX+sCXvVnpIZ
	caNXkXNawPC7h+7WpjpI4Jah8CWinWjXCnjstPGdzfIDCHmT8O7hl5Wx+Q8+cGShBbwuPPwoB0A
	4UUQ6lX3u0+MALa75ARkkGrZ23/rQ7bRVzzAuKE4XMzO51kfbCCvHdMxZeq9FAzPCeKiwFIg+qS
	tIUtchkdHiuUvK6iPtdQIMq4HAXllwYhE9wpuLfYSzu12WeiQaaBulho
X-Received: by 2002:a05:651c:b27:b0:3a9:9b0b:b789 with SMTP id
 38308e7fff4ca-3a9c4ebac3bmr15900241fa.3.1791692659381; Sat, 10 Oct 2026
 21:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010081059.3096312-1-bsdhenrymartin@gmail.com> <8393a8a2-2ed5-4d63-b937-5d837c1bb1aa@collabora.com>
In-Reply-To: <8393a8a2-2ed5-4d63-b937-5d837c1bb1aa@collabora.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sun, 11 Oct 2026 12:24:10 +0800
X-Gm-Features: AclHuK-BTl_lG-VGVrLo4m7etjeQVOp6O1v4a1N4RBOkp9wdRCffIEeVjuhsxU0
Message-ID: <CAEnQdOovxVfYAyiEZ8nJM-DXe=r6apYkfmpJJUNx6CJbg61_-w@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: reject mappable HOST3D blobs without
 host-visible memory
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Chia-I Wu <olvaffe@gmail.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Junrui Luo <moonafterrain@outlook.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

You're right, thanks for catching this.  bo->created is set
synchronously in virtio_gpu_cmd_resource_create_blob(), so the
unmap/unref completion chain (cmd_unref_cb -> cleanup_object)
releases everything once the host acks.  The leak I described does
not exist - please drop the patch.

Sorry for the noise.

Regards,
Henry

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2026=E5=B9=B410=E6=
=9C=8811=E6=97=A5=E5=91=A8=E6=97=A5 04:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/10/26 11:10, Henry Martin wrote:
> > virtio_gpu_resource_create_blob_ioctl() -> verify_blob() validates
> > blob flags, memory type, context and alignment, but never checks
> > VIRTGPU_BLOB_FLAG_USE_MAPPABLE against vgdev->has_host_visible.
> >
> > For blob_mem =3D=3D VIRTGPU_BLOB_MEM_HOST3D the blob is created via
> > virtio_gpu_vram_create(), and on a device without host-visible
> > memory (plain virtio-gpu-pci,blob=3Don with no hostmem) the failure
> > comes too late: the GEM object has been allocated, a host resource
> > id taken and the create_blob command issued when
> > virtio_gpu_vram_map() returns -EINVAL, and the cleanup calls
> > virtio_gpu_vram_free(), which is a no-op while bo->created is still
> > false (the host response has not been processed yet).  Every such
>
> virtio_gpu_cmd_resource_create_blob() is invoked before
> virtio_gpu_vram_map() in virtio_gpu_vram_create(), hence bo->created is
> always true, how come it's false?
>
> --
> Best regards,
> Dmitry
