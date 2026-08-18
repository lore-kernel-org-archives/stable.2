Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3C484232
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077468; cv=none; b=jYjmB8OrGDGJ4FX4nrOQjc3Qz0kGdZLj90NoaI6rrjyTySn7nyC2ahw6zN3CyQAMKWOARbEQNEr1QIcy8oLhF4DApITaV+JcT0iayORk7SnhyaAEEMEyX3Znnmh3ffn3htonYrnMHZ95ow8mDruE+C0C+6XeM8RhkbySRb6t5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077468; c=relaxed/simple;
	bh=wqPPOm/yXaMipv+y5NQC+ABxnF2CxAaaY6MQWXdEXMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKWK7dIWKQYWM/1HdKOKah+Sp7iBTAnVXYy5KecBBtlvWW+Vuhx61EgwE3lKznucg2ffIAA6VmcCk+OSuR57tWgSZgMFbcUP/4Om5EoXmBj/TGTtWCLHpU/2D5eAf6XBy/l6xGw+9VqBDXiFEZd9nwgThtY3DRvEcahLZe9+za8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWSWLVxz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mlEbSs7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWSWLVxz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mlEbSs7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787077465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EjK1grTNkC5kVSY96HRtQJcSC7mxO3Y6rELa2KIFGI=;
	b=aWSWLVxzQMRteUheqFvXz0MPo7HfLcCRBvz1IJs0sy/V2UVqm2fJRMiEQzfPYbkyYWd6Qe
	/b7eDj2yuhjyZJDLvBdPbzmiiEgVIAOHPZj1eJ5pw8b2dgivwTsB3PGD5dMMgcOaIyCg3B
	jIpzcGO9tXHymFQfvCAK6y3QknYSJ4w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-KkntJwvDPJGefMvJCu-B7w-1; Tue, 18 Aug 2026 14:24:24 -0400
X-MC-Unique: KkntJwvDPJGefMvJCu-B7w-1
X-Mimecast-MFC-AGG-ID: KkntJwvDPJGefMvJCu-B7w_1787077464
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90a602a4e6fso4901726d6.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787077463; x=1787682263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5EjK1grTNkC5kVSY96HRtQJcSC7mxO3Y6rELa2KIFGI=;
        b=mlEbSs7MwbXmgbW31Bf8ZYFODY1BtEs/cGlLUl3MuAnip18cY+47gwZ9jMsdCRTmJd
         LIN8qZRdHNXhqzx+TJ15gpwUa3DOiF8wqx+Cs7xH8KBMPpw2VWbkqbRGdnZpwwpukTBG
         xgYSROsbtRql7ahpVfY+N7R9FpGLpwOJBS3VQZ9JKe8thtHkok72P5LSoh2y0xZwNXJq
         b9QICHGqTWv3RbYBL6s1CbBeIxGAE0OeReygEW1D5gaa+1tQDh9IwSTxwgaxBPqZFnoD
         bjueL7i+NRdjPWiFBGcvDInlGakp7nxFrR3V6h5SM9bJBKje5lsO8Y6R8w61BuX8dGcf
         AyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787077463; x=1787682263;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EjK1grTNkC5kVSY96HRtQJcSC7mxO3Y6rELa2KIFGI=;
        b=Az5fA2JfUdagICDvntwcbQOu3NLhNwiZbh6Op01aYshKzSSgVBDoFRlINkYJqxJ/S8
         +3T2YHxfLmzz0zzylvg09+xdbfv8UCxZ+b080lIsQ/EC+zOQAxFCnwDkkxSvwwIrhm0v
         gZpKB0kXHjE7oO2X4QsDIISf4wHvl2MzXE40/oq7KG/IoTyccoKU6lgnuHvq+tbiqP8l
         SxaVbGPG5uYBQL8VqkixG1sTMocML8jqbF5RQYxa7wDwYhjAPZMqrchOQb7HPYDmy3MQ
         8ioKY2T2WobnMzicbTy6b+ackFhpMO9rotIJgY5tohyUiNJEJGgmkt0G6hd+Jr9Yuemq
         yOtA==
X-Forwarded-Encrypted: i=1; AHgh+RrQT0UNysRDf/y9dHN346DSIXSI0DJ9RpmX/4muupG+Uxy6a/L2ybCqQ2K20ofwPjaG/qCjygU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1lWL7DckavmK/x15z+ZIK9F0GPCK/USW6mdFJm9ADGToIVBo
	pd05b67QaJT10waAIvNnb5ohRvmUmmvR56vb9ErI7oGHYkyS9yhHmobCkBNI5o0qvaro/DVkUk2
	a+p64PwLV7gGL2jeT/vKYV0g5f4qmSOqd5ddP9wC1N9y/6oeXSR3svyhNgw==
X-Gm-Gg: AR+sD13ULI9w5Bujve9hl2JaA1cRtJ1AkTWuf3aIOUuBmBHKNOcotuCG1phuTAvCluy
	yUMcfIM/ATHoyKYOuTy0yYMQw4rmyiAuTbAafXn15TSW3V9lbq/VtjhG8/90fsPhah4kf/LJqH2
	O2n0jXRcjBm1vogGmlfFLEzhy+hQLx2OqUjKUp3Ieq4UzAbetJpRc4rSmmXaVAGKlU9B+VdVtRi
	fJw+EdVLK4/6iniCUQNc7jbfwxcWy6439+CHn0tH0WlI86VEtKTd1Km044WJVJ1xgnBQtxzC6wR
	EeqgfGlIkQlUb/OKFYmWrK/d7OfmcCeMg2wgdtZIj2DHJHWBgTONieZTspcRBqpPEm5VYe6d
X-Received: by 2002:ad4:5aea:0:b0:8f7:43f4:fe8d with SMTP id 6a1803df08f44-90c5c423802mr2388366d6.29.1787077463687;
        Tue, 18 Aug 2026 11:24:23 -0700 (PDT)
X-Received: by 2002:ad4:5aea:0:b0:8f7:43f4:fe8d with SMTP id 6a1803df08f44-90c5c423802mr2386196d6.29.1787077461736;
        Tue, 18 Aug 2026 11:24:21 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4597695csm37005146d6.40.2026.08.18.11.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:24:20 -0700 (PDT)
Message-ID: <25ccdb08f6d84982fb211444dd766d054258e41c.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/nv04: check cursor buffer object size
 before upload
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Dave Airlie
 <airlied@redhat.com>, Ben Skeggs	 <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Tue, 18 Aug 2026 14:24:19 -0400
In-Reply-To: <20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb37d213d@gmail.com>
References: <20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb37d213d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 18:35 +0800, Zhenhao Wan wrote:
>  struct drm_file *file_priv,
> =C2=A0		return -ENOENT;
> =C2=A0	cursor =3D nouveau_gem_object(gem);
> =C2=A0
> +	if (gem->size < width * height * 4) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +

A good start - but width and/or height could be UINT32_MAX, so a caller
could still overflow width or height. Would you mind adding an overflow
multiply check?

> =C2=A0	ret =3D nouveau_bo_map(cursor);
> =C2=A0	if (ret)
> =C2=A0		goto out;
>=20
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20260813-nouveau-nv04-cursor-oob-ad2b6001de3d
>=20
> Best regards,
> --=C2=A0=20
> Zhenhao Wan <whi4ed0g@gmail.com>

