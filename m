Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0070470EB6
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669176; cv=none; b=Q2ndWOpOWd2LJqE1djGlfMH5npw3D0CAvNcuBOyMAuIIvP5bSgLTMAl9SQ9O0RZISh0xhTh6+JnIu+YFxyA5jJ8HgENqLtzFDub4+bZup0F8mjGyA09kYQilopaTJ7U3hJwRFekqecGuSuX7/Pn8HNfPhuTriZ7NIl6N3ZlwZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669176; c=relaxed/simple;
	bh=Yk+dsBCvOCH3KYRJfgG+xXG8w0PVzLsSfAJEvJo42do=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imIepbn74pvDRc0pxGklKL5fP4wU43bQdGS5KYenMu9ypx5X8fNFNS7uHbTkptcfSXvqLp5H12ekR8XpCPZ22A7aR9oOIM2YFpS0gQV4HN4V2HcNpKtJyfoCPGNRhB1lUFzpJu096FJzOOUzrlohgf4mnUrXPwoAbU1v6YNX++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQ1kgs5Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nh6rH0ZL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ1kgs5Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh6rH0ZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789669173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6EVrUJFQJF3dnaOQZb2Gx1UGobWA2s6Fo3aIIPVgJwM=;
	b=eQ1kgs5YRkdxVIaL8ISyVhLYqxwnhIWVNc+ATVOyF08s/9kHlYq80n7gJMTsIl93IhQuHd
	8vzivDZmumQlGpTI+o2bVdoggHuU1HXS9iWUgwudbCYFIQpieuUdUpzxAV2fa0z7WAIfdX
	0QrOX1jze9Ul4pD9RVq9Y7HbsUypM90=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-xw06AoYEOCy9Aer6UnPGqw-1; Thu, 17 Sep 2026 14:19:32 -0400
X-MC-Unique: xw06AoYEOCy9Aer6UnPGqw-1
X-Mimecast-MFC-AGG-ID: xw06AoYEOCy9Aer6UnPGqw_1789669172
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-982a39e0c4dso169380241.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789669172; x=1790273972; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6EVrUJFQJF3dnaOQZb2Gx1UGobWA2s6Fo3aIIPVgJwM=;
        b=Nh6rH0ZLx6UXQargD914orX+oCTg9u3QAMc6UtSsww8KnILww8zmCf7G/DEjnw01WU
         dhDSlpoeRkqyzxkn5Q+om2EhwSBBkiGrjW4/bpTx37Dhz4R/LQLUjddQ9Q1QT/HK7l3Y
         SBC0/VqV0cRsvyGo5GySWivCMdDHrt7m+zIKy8DA2IBZ4KQ325UjcyPSzzdoszo2j2Hn
         fmnlDTja8/Z2c54LLgJJF9cxK1SITt+SyqcMZzLLMhSznJkTerjH4t6brWf3Cg0giCdq
         yqcfU4em13G7/6+sdZzVCcBwxuQF0Ls7YWiwq4AJAeopMkPS+6/9lp9wZvXD++5PqXLS
         smOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789669172; x=1790273972;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EVrUJFQJF3dnaOQZb2Gx1UGobWA2s6Fo3aIIPVgJwM=;
        b=GfajO+IOyCkhHYlEwSfsc1x3pHxcSPEYgQRikPe5wibJxBwaXbc7UvTnGdHBqZ/SS6
         IJtG/NeQ0mRjQrisVK/MuKsPWiIVEsyHVQo4EgTTxDYxVWNgrBZt6gO9B2dquDvfEzTv
         U25MukxEbnOCZk+JNO7Be68nNMAbceuSlsiOghS86nrQA23KhU9fTBEiQWPj63MaJyx0
         JXrv3DbuAyfUXHATPZBi3AZcprJAhpa7xMJCFCe1bpIJQ0WvuGduQiyzW/OpUNXRfdKG
         5LU8Cr/4Ts1dRoBavGLmEhAk1ZtVa07d9TkS+viyRutQr13rlI4nkwGtFuqirfbkFbbX
         QszA==
X-Forwarded-Encrypted: i=1; AKwUvBw+XSB0GPg+JoS+hXcCtvmogsFH92hGf++4K+fJq3lLKC/ryDrEdSw7w/1uGm/V11gHcIxX3K8=@vger.kernel.org
X-Gm-Message-State: AFuF++nqQR1ki1fKNwhXkUweE+6lsd4oRPy2igrnL9AXSkShGrVLxhBa
	a/m76bEbE2uDhgFlmK/9Vz57h9rc1w+TDxzXF8Wj0vRY0bL2+mPsrE7upDV2RrnJwt/tVjXlI9K
	Iy5ndshlYYrgukrwS9Hozbz+OXmtF1p0AFYzlyPqsrwflei21cquDYYOh/A==
X-Gm-Gg: AYBFou1rRlE8gj1FCKXpNYyopB7zTN/eWjLsPVMfPd3IibkbIYU98JDbb2H6tE9/Rmf
	NerU151hd7BCP2sD6kPi0N1jmv8JAPYp++ujLkJk6+aYXe5t5L+77cQPVnfokIgKIn1ND5yiDH5
	Gg63xV+IfJ1rRvHEsGbtvxKXjefkN4rwK006Lv44hszy8bynnf+nQbLgnoEYPk7eRcpFGAFcy7M
	i1KlWjEkcQnz4jcnVddgBKYuLXcAGn3c6arMx45v6w+hl9Qx759Eb657ieLoSRQsu+rS9jahGIT
	k3epAv8fc0bKNhy79qudv+u/xfxuOTxuybnafbcf9PCmOoSCk0IelViTt7Izu12VPPSIxUBi
X-Received: by 2002:a67:e708:0:b0:797:e5aa:61c2 with SMTP id ada2fe7eead31-7a024dcd2e6mr7627704137.3.1789669171648;
        Thu, 17 Sep 2026 11:19:31 -0700 (PDT)
X-Received: by 2002:a67:e708:0:b0:797:e5aa:61c2 with SMTP id ada2fe7eead31-7a024dcd2e6mr7627685137.3.1789669170960;
        Thu, 17 Sep 2026 11:19:30 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1e292ee59sm4120534137.6.2026.09.17.11.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:19:30 -0700 (PDT)
Message-ID: <d43ff56c010c83fc4cbef634e7a632940f5d20f7.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix gem reference leak in validate_init()
From: lyude@redhat.com
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: bskeggs@redhat.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, nouveau@lists.freedesktop.org, simona@ffwll.ch, 
	tzimmermann@suse.de, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 14:19:29 -0400
In-Reply-To: <20260916180202.2090231-1-vulab@iscas.ac.cn>
References: <20260916180202.2090231-1-vulab@iscas.ac.cn>
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

Will push to drm-misc-fixes in a bit

On Wed, 2026-09-16 at 18:02 +0000, Wentao Liang wrote:
> On the ttm_bo_reserve() failure and "vma not found" error paths, the
> loop breaks without adding the looked-up object to any validate list,
> so the reference taken by drm_gem_object_lookup() is never released;
> validate_fini() only walks the spliced lists.=C2=A0 Drop the reference
> before breaking out on both paths.
>=20
> Fixes: 19ca10d82e33bcfe ("drm/nouveau/gem: lookup VMAs for buffers
> referenced by pushbuf ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_gem.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c
> b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index 20dba02d6175..c2601b559947 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -513,6 +513,7 @@ validate_init(struct nouveau_channel *chan,
> struct drm_file *file_priv,
> =C2=A0			if (unlikely(ret)) {
> =C2=A0				if (ret !=3D -ERESTARTSYS)
> =C2=A0					NV_PRINTK(err, cli, "fail
> reserve\n");
> +				drm_gem_object_put(gem);
> =C2=A0				break;
> =C2=A0			}
> =C2=A0		}
> @@ -522,6 +523,7 @@ validate_init(struct nouveau_channel *chan,
> struct drm_file *file_priv,
> =C2=A0			struct nouveau_vma *vma =3D
> nouveau_vma_find(nvbo, vmm);
> =C2=A0			if (!vma) {
> =C2=A0				NV_PRINTK(err, cli, "vma not
> found!\n");
> +				drm_gem_object_put(gem);
> =C2=A0				ret =3D -EINVAL;
> =C2=A0				break;
> =C2=A0			}

