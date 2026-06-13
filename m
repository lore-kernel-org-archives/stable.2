Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59934E75A
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337045; cv=none; b=AW8PINDDiOuxmWnDjvopbtX95umdE+cRj7xgooXdBQq0wp7am7LQH8ka3nBjJ44XewB+vcdv+SJesIJZ5OQmfc74EMw4NehQnlYvxBbVvzv8Wejjs8FxkMG6CVMtbmZJT0pFpUkvAM+ymVlH7uDXV6TreIPiFSAjNx3uGYZxZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337045; c=relaxed/simple;
	bh=nFJnphqUQG5wieQkJ7Kb9J+Gt5X/QP0brHiBPfCW6d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrQaNUg3kwKcqz1bRiOoW0hryyrphunwxe9GBgOc034+Stzxk0+hcp1AcW4r3wy1J0ca0jfnfv8wCUSOk6llVLhOGyaMhPXoIpbO3DNL0d3rGG32iH6f3TfeAfLD4wEz8i6wi39cfrYjE2AGS9DyALYEmx637MopACW2pWtLa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryd7iyCI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryd7iyCI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so10122425e9.0
        for <stable@vger.kernel.org>; Sat, 13 Jun 2026 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781337042; x=1781941842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mlm0YHGLM0VfFF/fXJEvgkWs1yTQHLEduURYTbkabJ8=;
        b=ryd7iyCIeu7cuAs5mNY/PwWNKIC4b0xWZpWTdYN3aT33Ak+ve1k6PNhrAtHKwTxyB9
         0z3ZKLLmhny0in//j5dlgsqWzWPVIc6qRuBTXB4TFJrzUIUXC1fMSTIJIo955QFLzJbH
         byes3VClwjAct5zbB4QCEq+pjHyLOSP0VW1A6mCjZHkyb3keed2O9dq4TzyyKEctkFYS
         BL0d8jXbbMUeKfD05BSKT87gFYXGg/MBjztxNi6BVcUQPshNCf5QWYV5rGSJnGL4QP2V
         ZLISsrkLytodX9oCzsEvKru6H+UYebF9idbMqyUAqDaCVRgJlgJrPJU8vlr6Vja21PEj
         vBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781337042; x=1781941842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mlm0YHGLM0VfFF/fXJEvgkWs1yTQHLEduURYTbkabJ8=;
        b=GZz38WNJ+vJTgCuX4cvL/8K2C4vBwEnXTO+CYX7aKb5XarBhb0Dz1ka2O33MwOxhds
         MfBb47593s5uBC9oMJaUAFe7xTYJsYrV8Gvl2d1umWiHFl2S6Qk9PUjV8zVtXYgS+nI+
         r9OVBEke5kyZlJc8s5bdaHlhT/lVGKMhoLGUAkm5p+XJjuBgKELx8AOn0+9WOx8gMA/u
         UBS8hsdTNEtpVy9NHtR5UA3Sp3lU7/muxDjA4FJZvzkwpCKT/G3TxzwMMuLVkbfsnmSq
         YcfetRU/Cn9EI1qcyKPL3CUYrXjEGh8KA2Qg8edS+a7v5hpP+IXSdHtybtljl6g+4RMQ
         7vwg==
X-Forwarded-Encrypted: i=1; AFNElJ+5sdptmZuZxP7+5EKCCwV6R6JOMFia1YM3i2Wq0ZdJCRZny+OwwYo7N8/NUwffPSNNn/KYZjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/nCk6qi07QwSM9tty65NQVpVeWVUn089qVwCgSv4kRbglDq7
	/E7dbPGXqfEzPnayj7ptOEmdvHps/c5ig494Tavvazu0kir188e01R6h
X-Gm-Gg: Acq92OGEmrxpUMv88RRGiSK8Kq9L2lYI5WXnCjrNLZXGtKUIBRFPw+IOaVdZwnStlFi
	tur3++AiaIXISqfYC0/cy0HkJVmKbJ0kLjwyupSchgZCJUFnP233hQVoIwBp70pUCv2AUdLiL5G
	RmYSEUbjvw03aGhobyPAO5hwk3rmA8njMHyu0CmC1DaJ2/SHYaw5MHMOqlAustYPYcqJ7eZwjAN
	5srMA7xY+9hBBVhQT0E/KA/HZFkU2UIsN4M9Pp2laaUOSjK6FSn19BuwbtOFnsA3exl5LJfY6jH
	aCix/RC9tyP3GeqfymHh4xbFNsk2PrgtL9BY1H/kcRUOJM+vZjMZ1kXMtyCbO+bBXTulSNCaSym
	2VBU1q0ylwS6EP/krM7nSFkw7jzElwFokOU1QkM6eKv3U2HLFhWpqaQ5Fplm5bnSvj4MnZllB+N
	wkhiPLkQVcANlT+TTq9TjrkIGaGdnTKNnA7ZLYZpBFDAqx
X-Received: by 2002:a05:600c:820c:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-490ec4d3407mr76769065e9.15.1781337042183;
        Sat, 13 Jun 2026 00:50:42 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4a128csm145232805e9.0.2026.06.13.00.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 00:50:41 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
Date: Sat, 13 Jun 2026 09:50:40 +0200
Message-ID: <p7BkDUOlT8udh62CkXD6NA@gmail.com>
In-Reply-To: <20260607030950.83636-1-vulab@iscas.ac.cn>
References: <20260607030950.83636-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 7. junij 2026 ob 05:09:50 Srednjeevropski poletni =C4=8Das je =
Wentao Liang napisal(a):
> When sun4i_backend_init_sat() calls reset_control_deassert() it
> increments the deassert_count of the reset controller, and must
> pair that with a reset_control_assert() call to decrement it.
> In the error path where clk_prepare_enable() fails, the function
> returns immediately without calling reset_control_assert(), leaking
> the reference count.  Other error paths, like the devm_clk_get()
> failure, correctly jump to the err_assert_reset label which performs
> the missing assert.
>=20
> Fix the leak by using the existing err_assert_reset label in the
> clk_prepare_enable error path instead of returning directly.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 440d2c7b127a ("drm/sun4i: backend: Handle the SAT")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



