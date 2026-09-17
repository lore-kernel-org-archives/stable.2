Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB64EF13E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665415; cv=none; b=pjQyPPCofDVXt9kjI1jOIxPbohM6Hgf7jM8+MZVh4OPl3ErT0uejltryW2jla3jrXiN5aYXah5MBq3KbMsndnbmwkFLjTGoHz6R7c0XDeh3TVP8l0BYrklAQBPbN9Qe9oRL8WI1Eo0+fbyc8JnUlD9+oQaws8O7pghDeSlJWxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665415; c=relaxed/simple;
	bh=yMFfWGZ+PoRdGpMVU94qylirYpyWyHJ+HDsE48mS7L8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPyHMYxgjB79e8xvqM2PEfm+Jj6/rmqQnDIJJzlnLeF4PPmoXB3rhIr/qNxKbWdyGZYe3OtMlQPg1h82eHzlpzTiq6+IX+y+oznRGozVxPZDgcYfag82ii5uxCGvOxW0Bs9BXGTk4WUIkhw/k3snMYj5WsAgnVJj8iwi4ypAHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xu9MhY/k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrhSFGZb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xu9MhY/k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrhSFGZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789665412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uC98k1DYNd0VN7AyfHY1vWTx0QXpdNax6z4iHwpWNLQ=;
	b=Xu9MhY/kOVKXC+9wySmIjRXmxhr89Ts+V8KS54D1v1ZbBe7KJvgKkIxGoKg419QV2oo3t1
	v+JRU5dGlXaeWcjZJTtn97Ynv3KGD7g76OP7ubgBrNeRdSui5xT1M/9xqqLePWuZWijodn
	/pBCPcPn8oX/PPbj/h8fvw15hNmbRG0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-EDTgBrajPm2RYCWiE0nFDg-1; Thu, 17 Sep 2026 13:16:51 -0400
X-MC-Unique: EDTgBrajPm2RYCWiE0nFDg-1
X-Mimecast-MFC-AGG-ID: EDTgBrajPm2RYCWiE0nFDg_1789665411
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9123c523d0cso12102366d6.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789665411; x=1790270211; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uC98k1DYNd0VN7AyfHY1vWTx0QXpdNax6z4iHwpWNLQ=;
        b=CrhSFGZbN8lyNYVZ2WfZ3829RDkLCUUNPmb2jLchkf/2/e7OtzX+e5cyifVbPoWQse
         rukkruRgZJCKfHxSR9PaDwV/o2Km8b9fwa274/nTH+Kbx+jR8K1WLPJH3A36KQjrcOLZ
         9re03Ohc5Zyhn13PLNucNGvqFdZrTlEfGGBmumUxiXnodm5pqDEa12b1vQ1qbgDv3DU+
         yoNbJYX6IsgC5NurQPallQ+XId3ZFVHFBxxbAvyksUrSkQOy5mqm+z1gFMrY4CROgJvA
         CLeqGDEq7QlFH72qINw6FA6JmdiSzwlKCOYfbJvtcV52Fqx5RteDkxay0MNzUYh3r+Xd
         AOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789665411; x=1790270211;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uC98k1DYNd0VN7AyfHY1vWTx0QXpdNax6z4iHwpWNLQ=;
        b=FcPSyTnfeKTY+TIR8/lJ2XzLiMR2rfyuv9r+fpc3C0v8vI5aCo/EhqdHaFdbPgTP/Y
         CgS2dPDUw0+ViXpntWT6Tre3B0arUDSraB5aETLb0f6X+fYMxxZYpF3pR2UMcqaUREBN
         RD1Gkvgo7+r1q8Ybg+dU3Sg1K41+qjXR2gs7CjZ4YBU8Cf5KENWRFIy68zivgaX+lIGV
         g2y7KXPVgwOX2+hBkKlFyt0hzqcXIuJtBOM7peXvEcsKo0SJRoXpeZ5vZpS+8x+XmeGY
         k+6EdPBEOohKYoTnwLgipiwWHGPjI/sn/TD85CI4JCtZ1snS6c9MYr14v8G6c4SUeWeZ
         uGIA==
X-Forwarded-Encrypted: i=1; AKwUvBx8y/4tOXrc4fycp7i65HqaQd0J9ytKUzuA69W4fDQnSEnhiFcpgN0fxBMeG5ljYhLIofCWQ3s=@vger.kernel.org
X-Gm-Message-State: AFuF++mRKOJQieH8wtnaVm/zhVaXO8vFSW2ag3swnM2/ejQPntwAemxd
	JGoppJIXHrtO4202GDumThursdpJUbWiBHqYvEknQePX+XI23XzNiiVXMssqYzLiwolkIKUPskE
	8BWCc45M7olMnzr/Hx5igKfyxgjJoU17jab+/poEBNHr5/7y6GPdjiU/GPQ==
X-Gm-Gg: AYBFou3DOgKfJLwRkEi1Jse/gDsSPzbmYKT6Yk28d9ah0hyvIePCG5EBgD0UUSUjb67
	Trw9rQiL30CrTxSZlXYOUOSjmR4grxiDh0U1WlIINfjqvPCmC3AKITKQBahCT1+l1SuV98Qs3MY
	fexDXRjrglGLnxL5e3am2gpez6RWe4K3EuhTObot6oe0E61zYSq4HcxaZzrunENhdlVEE3RZ1wj
	fE5KXHjK28rNXtDsO6b9Zv4D53QPz0J1oM+F8jB08eGp4eJX5wgzziWg0pIL3Bdvo0GSa+5P8re
	OMHYd/dTxAjDGpghtrVuYx30ABlQj29/6XpVgVH8dc539Ws+g8OwJQuX1heitvfdXVhUYXzE
X-Received: by 2002:a05:6214:2a45:b0:8ef:4ed2:316 with SMTP id 6a1803df08f44-9123d70ceabmr135426996d6.1.1789665410452;
        Thu, 17 Sep 2026 10:16:50 -0700 (PDT)
X-Received: by 2002:a05:6214:2a45:b0:8ef:4ed2:316 with SMTP id 6a1803df08f44-9123d70ceabmr135426346d6.1.1789665409997;
        Thu, 17 Sep 2026 10:16:49 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252d2b826sm2374926d6.47.2026.09.17.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:16:48 -0700 (PDT)
Message-ID: <6a934ca2b3caeb20f1b3d2e9d71e987d5d78af15.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
From: lyude@redhat.com
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: dakr@kernel.org, dri-devel@lists.freedesktop.org, helgaas@kernel.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, nouveau@lists.freedesktop.org, okaya@codeaurora.org, 
	simona@ffwll.ch, tzimmermann@suse.de, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 13:16:47 -0400
In-Reply-To: <20260916180036.2090118-1-vulab@iscas.ac.cn>
References: <20260916180036.2090118-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in just a moment

On Wed, 2026-09-16 at 18:00 +0000, Wentao Liang wrote:
> pci_get_domain_bus_and_slot() takes a reference to the PCI device,
> which is never released once the memory size has been read from its
> config space.=C2=A0 Drop the reference before returning.
>=20
> Fixes: 2fa6d6cdaf283c05 ("drm/nouveau: deprecate
> pci_get_bus_and_slot()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> index 18241c6ba5fa..4d52a158f320 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> @@ -51,6 +51,8 @@ nv1a_ram_new(struct nvkm_fb *fb, struct nvkm_ram
> **pram)
> =C2=A0		mib =3D ((mem >> 4) & 127) + 1;
> =C2=A0	}
> =C2=A0
> +	pci_dev_put(bridge);
> +
> =C2=A0	return nvkm_ram_new_(&nv04_ram_func, fb,
> NVKM_RAM_TYPE_STOLEN,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 mib * 1024 * 1024, pram);
> =C2=A0}

