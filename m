Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FD3EDE62
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696713; cv=none; b=EKHhRmmJ4mXr4JkxGDhh51KrnR1M0kO0YLs1tiLcAmdaKF+VUWU5XccbWSmNDhFNbnB8IRZd+tWBT5PnmaM/CXG/blr6fq6XXf4ArSn8SjPDh0oasDEA/vg3cVyg5n14QLcFZFY8efOEvPrYAkNtutT0X23lCZltm50iu78pQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696713; c=relaxed/simple;
	bh=UNOPNt3Tkj1fUbyNoRuaxHaZ3HpOAfl8W0SXs06UoTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hyd4e1VnMnWhx89JvJ/ad3736ranQYbqXH+blalT+MnXG5QByGBV7paQCWTdOvRdNVmlDtatvc3/iDTkbcd9PANlPxi5CqanHG0/SKDMHWcv4q5O6FjnkiufBdLcaFOz6s8ansFr/TRat+AFLBs6sjmFtmkOY+tiKmtSExas2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZ9I49cK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiHeSlP1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZ9I49cK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiHeSlP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781696708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFpuqaDieAHnE3Ar5B8cZarVK1thuyCr3IXVZ5S3Hp4=;
	b=YZ9I49cKIiBTXmqzG4HejnbnW3hBa6Eai8lzJvoakUhb/9DGk5gavolSNbGQ2uZWgD2PXo
	MzOEqtIIodc7GHp2z1Nxfnk9OVmDgsHtx/8ALVM1uE70ji3BuhMXDlOkdyJqQs94AgQKmu
	nKj6O0vaBoGyZeNeoKsq0bnAOyfcfTs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-8auJw-2INPiOiZIBPh7-SQ-1; Wed, 17 Jun 2026 07:45:07 -0400
X-MC-Unique: 8auJw-2INPiOiZIBPh7-SQ-1
X-Mimecast-MFC-AGG-ID: 8auJw-2INPiOiZIBPh7-SQ_1781696706
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso30769555e9.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781696706; x=1782301506; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFpuqaDieAHnE3Ar5B8cZarVK1thuyCr3IXVZ5S3Hp4=;
        b=JiHeSlP1oe48JsKQY5EKp1SSKXol2I0gwySI7T3OQYhtBnEzy1UXVdApQvSK0yRVFh
         cMcsw06xB6+EE73m3tflk/DS0AEIxKstUjoV+H9tmsVM6uFG08ND+csX+zQAW6LAbX1v
         CXWr1N/K6fYRqQ6giNgq5FMCmdDCaPpQy0LWFqSa4AelmtviVW3u3qrPkqkZiFpq6Zaj
         4r+LZuLWCJcBt5SIzE9gAw+TT6EESjxSNzd7QB/8lxvqeq9VcczDbtpppdNTDq/jqib0
         +mJqeqekZ+deO/RfJcQp4ZCFqQmyaklJKJceMfkNcy2Lm+j+6k29CgdzuNk146RpoY8v
         pRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781696706; x=1782301506;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFpuqaDieAHnE3Ar5B8cZarVK1thuyCr3IXVZ5S3Hp4=;
        b=mALsGo+zq46o78YExBQsIq2pBTRPMM3jIgDWFfxTVwaJAm09T7yOK/9jy0G6whGk7n
         MB5OisufdzvtJWcmYHrIJH58TM9bKL/qkv3uN7rGQCuw+w0z/NyOjjp9oUrd//+V+SHy
         UHelux5K3GGG5t/81BpdN4RKGUT4LsKtc7+nRUwkZpyAgzzUbooD4x9UnwHDS4Iiah/q
         ywhQkL6CiFwSO5KeGB+Z7Sp3Vlv3SLiS36K+W+EsGhGYbMzrMn0ltkJC/M/QJomRRlXk
         lmt3jOy97czONrs6qa96HuDeb+xHLuBa4X3aOFhAsO0Ixt476Es9iX75zur31bpF6ONH
         YPfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zjHzZwd42VYxNmanPV1BwJRaaIFiJmNjqoNNOBXVc5gcxBSHmobEbIFrf21pu6sip+/TBas8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8BLM++tjnMmk0EH3ZWzna7HnQm3Ozfyr4cpNrYHn/5Utbx+k
	+6JHI1+d76kzkQVs5ZcTuk3UEO16pymcCnlO0LAr4hVppZlLGsH+nqechmV0D+IQBkzxTKTySXi
	tNliY6eyEYMBjYtnQ4M+A7N5iiw3SzStydeAko1Pr7SBo2Qr2iZMMtu1bbA==
X-Gm-Gg: Acq92OFU0YfsZHZzrftD9SbH4V24Xn4UwnDDsr58yG5oxNb0hxVf8H8rZpm5WKE+Ea0
	KnXIyMFw4OtA4EdoNrDU0hKzYIntC5gIQqKU5GLlIqSGZHGfc0rFjcl47eT0TrLJmndw8V8l5Mx
	deN/l4m3qk2dtxTe5HLuTs3iuVn8JApc+RwFPqZtk1P7fPc1hN+TXhHnJ2F4oPzgPy5b7B9LATd
	MJM2V+EnKCMcuPuial3maz/hzQDIeIIyzKB4R2KGkh+gf/qMiyEp9gGevTsJAcmLvf45o5ZGk1e
	BLEDxpoEBwkoo6rwoAkBVtRACCC1wrhUiYvgZXm876Ofo4e4YUrbpXRZTM6PqLikETTeBz41d+n
	CbLgC5E5tu1p85M0syy5SNq8MwoXbOHMazKW5LDQX60U1B/1Fcx3Xd0SDptw9m/SYQJqR/g==
X-Received: by 2002:a05:600c:6089:b0:490:b8c0:d46a with SMTP id 5b1f17b1804b1-4923412f185mr46138885e9.22.1781696706228;
        Wed, 17 Jun 2026 04:45:06 -0700 (PDT)
X-Received: by 2002:a05:600c:6089:b0:490:b8c0:d46a with SMTP id 5b1f17b1804b1-4923412f185mr46138295e9.22.1781696705767;
        Wed, 17 Jun 2026 04:45:05 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a9a399sm137247345e9.14.2026.06.17.04.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:45:05 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sysfb: Return errno code from
 drm_sysfb_get_visible_size()
In-Reply-To: <20260617112932.511657-3-tzimmermann@suse.de>
References: <20260617112932.511657-1-tzimmermann@suse.de>
 <20260617112932.511657-3-tzimmermann@suse.de>
Date: Wed, 17 Jun 2026 13:45:04 +0200
Message-ID: <871pe5z8zj.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Change the return type of drm_sysfb_get_visible_size() to s64 so
> that it returns a possible errno code from _get_validated_size0().
> Fix callers to handle the errno code.
>
> The currently returned unsigned type converts an errno code to a
> very large size value, which drivers interpret as visible size of
> the system framebuffer. Later efforts to reserve the framebuffer
> resource fail.
>
> The bug has been present since efidrm and vesadrm got merged. It
> was then part of each driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

