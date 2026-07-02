Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E905431E53
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952234; cv=pass; b=jwlmw79U3Q8NN9FztVneaaGYEAf5CJ+w236itfkzgmOtr39/L7Utgt0eQOmFd5kvZGgbRxzqmOextNDIT815C+6mYyeOF5/4/W6AZvP0wB5HJFKiIufLQbIgwMDQwp7GVFy+5/2nb8rBiCNlCaZT5sn41j6NpXweAGb6+Mh++Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952234; c=relaxed/simple;
	bh=uE2Z0sUsxkHX3B7YJ/WYKbzZMFygNnjUDTM1KHzHSbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWzbnjUpaWurRDka5Xrp969KWloePUsxBzOCtm1VH5uv2FZ2F/Bz4B4fhJVbWMHMiAHNtZslThvvfWK3zFFugEApiLYFCCo7x8Zl5qBb7Bk/78Wd8lejoK7dxmlZtQ12S2sl3zf8XKnuhzRNnMo29niwidOI/k5jgG9T/b0ICyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMMXVho7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mmcye6oa; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMMXVho7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mmcye6oa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782952232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uE2Z0sUsxkHX3B7YJ/WYKbzZMFygNnjUDTM1KHzHSbg=;
	b=NMMXVho79QdNxss59SE8jo1HKEohYC0cedXO0bZDFo+5StgmkD0grA46h8rooYQq2+CEC+
	3/JXyKaBqXLvh/Wn1rzGVAugfOAnweCrfCZvggGUe8Ix3SdXLxP4lP7B2XqfcN5cK+/pGa
	HuUeyXnUZzIRKN9mUdyAFTWZkZnDtFw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-OIY_aYo2MuuBJXarOPXxgA-1; Wed, 01 Jul 2026 20:30:30 -0400
X-MC-Unique: OIY_aYo2MuuBJXarOPXxgA-1
X-Mimecast-MFC-AGG-ID: OIY_aYo2MuuBJXarOPXxgA_1782952230
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c860544c077so2050967a12.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 17:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782952230; cv=none;
        d=google.com; s=arc-20260327;
        b=SqOZ7pF9nJm1+nJrhyFzSO7zgfcg9ky9OLBe2Rsbg1B4XLG3hmo0U7JNWjfk/+JAWH
         zL2CgDsDcJwJpJBBky0aNN9rJZSJitxkq1/AEi9t+4/hkLFtK3lJJ8I4JnHlD47t1FBn
         viHLY6j7b7vBGk1JTK76DK2v7VyvaPJptoKmm5uqh2fYtw0xWA9+MUh5uAhE5VhuD4rB
         VQX39PpFggT5aeV4Xt0ZCXc3IN/saZ4JK4VMWJubrFHN8Ipvdkv0Nw7xSsrWjpdRR0+Q
         8e4zVVDLVHPV7YMMXCfIkWbhviioIGoa5lo7LMZoYVDgwACho4rzJumEKNjRAimyqVzP
         tpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uE2Z0sUsxkHX3B7YJ/WYKbzZMFygNnjUDTM1KHzHSbg=;
        fh=b9fs8SzlfuFYVBHeIKbE8zC+hJoFKwoSnz788lf8Zz4=;
        b=RMZ/h7cn+aVIBgEXwZxrbkZ6lvZdvLS22t6tRwaJQw10GbcEcyObD71ChmdyeM1ZL5
         HV/hodOpRBD8kA6DFUQKnHH1qZdzdlPIrvyMaLBr3q9R1x3XGQXsrcqi0JUtdgfvPUNC
         1bMlmuPuKBhxmisM8epgOljS20FyE0GlY49NwfBANu95OaE6UZq/iB8QvzrlaA6rnI1H
         duiot4bFOXMPNvLV5iuurDYPLhRPMTCSenim6ZNwMWmiSf0p3K/incGVzTfc3kB39oEw
         DPomA0lFkFFc6Gs0dUenCFsMy94biB5pptGzwNpJAxGKCma+sd+ddVAG7648LIF0wLhV
         VIQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782952230; x=1783557030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE2Z0sUsxkHX3B7YJ/WYKbzZMFygNnjUDTM1KHzHSbg=;
        b=Mmcye6oa39w2IjBypvfC2YPzQcGazP9yy+4OR2Jz5KuB5lTLUsulvuQoSxjOuskNZq
         tpFg+X1mQSqULsNl5gox6gBr3ElqYpYKnIrdn7PF6648ELOQo7motvUtr5if131AvuFD
         jNxVMcHtmvM2EftjFasZrtJyxs+LsJMvB7KZP9xKZQHJDv99Lr+FnSqsg89ocOpyQzS7
         Mt3gTxiFwnQne35rOg3Ut0w8BxbuyEr2PRBwvQohoz8Yr8VC/rzVbqQ8gLsyvUmnhhax
         yOqg3cvHC6r5/BRlS+pseWfqVOZDLgzirz8oy0WqA0F0gHt7EVHzDhkYwIqCbicv20+V
         epaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782952230; x=1783557030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uE2Z0sUsxkHX3B7YJ/WYKbzZMFygNnjUDTM1KHzHSbg=;
        b=oDaIGBz66a2oL2GO2SeUDoZRiziDgAnY/ClPtJDqB3b+ZczvdVHZZdUU8QaAMvrUMp
         ykvPMhJWuXd7yEFNNiqsGq/x9W9WjIgkyjQ8AgJEvz5BBBpppp6LM8/jN2wb6eqc53Kl
         vP/rYnI6RHY2Yh+sPrFXQw3K0lpXwpQMSi6NqWb4r4VxwMtaVNL4o58iFxLNDtBOZAYA
         LkGlqRG0vQLriFy284oca9Fu1odImaWLfKr7Frw0yxMuilFTwKEmJa4kE09TQoW6Dfng
         wH1BKbVSeKSCI+MnnBJCwxq4gCXuVTh9q/Z3NwSdcG8ZpmsyrATaCbC5vykI4ww6Q5Hp
         BP/A==
X-Forwarded-Encrypted: i=1; AFNElJ+WRHbct+qhL27kyekdYPr/Ba1wKZ67IQfUPrhfLdxG46MFbREcLkOzDWslNOXWYXuzbiEKE+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pYRUpMCDqHGfLqvUieM6r6p2txC0bQs6TCJhPUwIaOA080Yw
	ickT0+o7vHL4UaltXhV9MfBDKaWfGaXPgcMmiK+1pJ68NXnwP2W1RxKKxCuR++Q9dSFfio9LJY5
	miZdTEh6Y/wHqnRy5jOQdGCZj7BnnzwW582gWk+5NwkUWGlRnCN/YSqXZprRAhy+stssX8RU7Af
	ipRfyfEdGgM/GYUf+nKw1PUPtcRBJto/zb
X-Gm-Gg: AfdE7cm91/u73JHSHf0WpJRGi/hWG18o6QRO5k+Y18ZDhECtfOtvchr15t8J77/8Pqc
	xdSsj5vsUcH72OalS57Ep/jYfml5ZlEl7ebxftjYYUugkqmQPthEMEH5jCUe4NJjojQDDXCiAjV
	XTEyvWFlo5ZlfUshivNw28lWbZCyJGR1oEF/ftpTrF9hjMGpGjYRcZRihQi2ifsdDyZo2uz4X2h
	Ga3ezeYHVObO8sd4nuCsyovKJs=
X-Received: by 2002:a05:6a20:9188:b0:3bf:6237:b1b3 with SMTP id adf61e73a8af0-3bff428abb9mr3232506637.42.1782952229719;
        Wed, 01 Jul 2026 17:30:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:9188:b0:3bf:6237:b1b3 with SMTP id
 adf61e73a8af0-3bff428abb9mr3232455637.42.1782952229092; Wed, 01 Jul 2026
 17:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701182857.190713-1-lyude@redhat.com> <20260701182857.190713-3-lyude@redhat.com>
 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
In-Reply-To: <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
From: David Airlie <airlied@redhat.com>
Date: Thu, 2 Jul 2026 10:30:17 +1000
X-Gm-Features: AVVi8CcxrtJSClXEO5FKdmTHOwuAtmkEnH-VE9hidyytnYNh0i2fFS2pSdVPCWA
Message-ID: <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Kees Cook <kees@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
	Mel Henning <mhenning@darkrefraction.com>, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 10:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> (Cc: John)
>
> On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
> > It turns out that the only reason our previous fixes looked like they
> > worked for this was because we would occasionally set the Gcoff state t=
o 0
> > in the normal S3 path, which fixed suspend/resume on desktops - but not=
 on
> > machines using runtime suspend.
> >
> > The proper fix is to just never set this flag. Our current guess for th=
e
> > reasoning behind this is that Gcoff likely coincides with GC6, and not
> > literally power off.
>
> I don't think GcOff coincides with GC6, it should actually be a power off=
.
>
> From a quick glance in OpenRM, it seems that with bEnteringGcoffState =3D=
 1 it
> also saves off buffers flagged as MEMDESC_FLAGS_LOST_ON_SUSPEND.
>
> My guess would be that with bEnteringGcoffState =3D 1, GSP's resume path =
expects
> certain kernel-driver-allocated buffers to still be in place that nouveau=
 didn't
> save off, or rather never had in the first place.
>
> John, do you have some details about this?
>

In nouveau we have the INST_SR_LOST target, for buffers that aren't
preserved, I wonder did something change between 535 and 570 around
what needs to be kept around.

Dave.

