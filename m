Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7538C2A0
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553410; cv=none; b=Iy6bDoGmkgJ/FIKMZu2oBEdnsBH6twjILdAHOIkUXljJLST12lvy3jPNFhYJ9sJ3/+NuIl/ShV2lCKVlQ9tw4K89d73qhH2F5HNFIi8LBodGPlkWTMQHApKbUkf9f+ByiiYYHFWCesELsET0Bmj7+0/bOCYWbS6iG825n5LKmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553410; c=relaxed/simple;
	bh=1pvBgwYa7lCn2bz7uXEDmoBIfHlXGdkFiLetg9jZiKc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0/2CibwX9vmEM9nGuGS7rWa5X8y1bek2ACONEgsBzrwdLpSzQinn8fhvuylHvOpqvcXrqgA9Zq3pNoBCbG18uipNUesTaanRKsyEaXa3aVy9e2MsUT2B3O5fdNfZMt2i4gmySYeTmnNV5skTeJrHMB1m1kLa7FKgg8AKAzzAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ed2y06MF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsFylpjp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ed2y06MF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsFylpjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783553408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pvBgwYa7lCn2bz7uXEDmoBIfHlXGdkFiLetg9jZiKc=;
	b=Ed2y06MF+UZ10efArl4vqWuC937NxrVi3UTxJHg9V3aY1w7AOGNLST57ViUMyRDlD7RgS0
	vGkGpbrffL/kou2btTHJrXIIyi1xM5aow+haMJ8yHMRXYYFTwztesF7V11PrU+yUDAriIB
	6avHwppOVcYO4Mdwz1589lPduX+RkVA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-pwQC98oRM_KGP0MoPEXK-Q-1; Wed, 08 Jul 2026 19:30:06 -0400
X-MC-Unique: pwQC98oRM_KGP0MoPEXK-Q-1
X-Mimecast-MFC-AGG-ID: pwQC98oRM_KGP0MoPEXK-Q_1783553406
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eeba1d9e47so4224506d6.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783553406; x=1784158206; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1pvBgwYa7lCn2bz7uXEDmoBIfHlXGdkFiLetg9jZiKc=;
        b=QsFylpjp5Dm07OfI8nuAVy+Y5obPh0TwyeNxl8WwSmC5H0EFkPmlOgtyuUbNzB7Em2
         cgtPDdRF2dqgkjFkEPdmKYmIv4MtpPZ7aSdsFl/zjnOpCTyoEL4Ar3oth5/AiEeSlvXB
         WloL/4KG4KIi5AGgRhMjSqo16PkMxOOMD/L67HLeuQuiwAjNZRQZL9zMRey3Eey6hr/t
         U4Csbfgu9QQsvZwKAU566zQKVjDeVfLunNTc/vMU1AGV3VNCwwCPwI/tbUoFGDB/NEQb
         Y32njpMvYoTiZsrYTrXwKsFnu4sG/bu4KgEMOshbpowLqUab19ci/svI0GXY2fX2Y1OB
         UPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783553406; x=1784158206;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pvBgwYa7lCn2bz7uXEDmoBIfHlXGdkFiLetg9jZiKc=;
        b=UhHHP20qlvmpN3HXHAb00RUJOKz0690YiiFUXhwBcx6BHegahjzS8pHeiFH5ssyJs6
         +YuDhRR2fXUOqok7+t7QwHAMmpPRcNrXNcGknmB2khKMSFsvWacNlqUyfatKfxI7WoKj
         T8FE5V6J6W+ybPDcMFZcm5psU56o7Er2v/ETvyH6axKGBFFLFd1BEeBDeMvuwVRgH1Pz
         jEsItTjsRL2L7uDmQtm9A8CG2hlfyu9VEze25pS2pW2qCNxRPhObYJNvvOI1g1UMBNr8
         BBTQ0BHpzX9q0SfdwGBHW+Xv/vaa0yYfe0/8BRgpgnjB0xDysO71z1fU8rqBaaEQ96lp
         1eYg==
X-Forwarded-Encrypted: i=1; AHgh+RqGhGfigdpnvRe8yPsH6w1yAD50DhHZXDPN/LJBlVNzkO57Cs1H2XsKxXuqw0s/o0IpGnpOYvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytpefTCTFvuNObarqEmykpoJRQa7moBO80chs+4YSco8z1lN2/
	IcnbgcTwwfmGW9tqTbXG3+/F+wNXwEIOVsCP/6RGuDbmkl4ZVkgeoNMsx4KLfT8l6Ec2ckdCxK9
	FBmIlMrLMQtTmLITUPLb9sp1Nr7hL4MHE1OCTCZo7FFm7QKQ19/69BLCBYA==
X-Gm-Gg: AfdE7cmUzavM6fMs4WUuaF89bYbijdP7VfgWXD6nH9L5V0KsUNfCakwZKG6WA6cdZtS
	NDgLZ6TVzk3Bbtwfjxka5ycspnTgU8LobzXK27jBw+o8Np26gI/YuxkWHxAfcoIk5kRtPMwQiIN
	Z/CN4wqknlBNJ2JQqeO+cEDqt9A4/RJkkKkZjxgNUTDOdxXMnD1J5wPs7d14Q5b80+Vs60PBKAW
	eiBBy3Anlu4zQlrAA1yD/5NwqrdOo5w8MWgwLc9IExkjnhm9xoKJHaUmmjhEoBtH9yhAAQx1JiN
	VxPN9dnshv6mf8ZZzy6J2IFSaGfdRf33U/bGiuqNyvtDKtyKQf+U+ZOydDOMSXwMxR65xCwwB9m
	CEW8xMdY=
X-Received: by 2002:a05:6214:4517:b0:8e9:a4e2:e43b with SMTP id 6a1803df08f44-8fec4bc9476mr52194226d6.1.1783553406274;
        Wed, 08 Jul 2026 16:30:06 -0700 (PDT)
X-Received: by 2002:a05:6214:4517:b0:8e9:a4e2:e43b with SMTP id 6a1803df08f44-8fec4bc9476mr52193736d6.1.1783553405866;
        Wed, 08 Jul 2026 16:30:05 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1e8aesm3791076d6.28.2026.07.08.16.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:30:05 -0700 (PDT)
Message-ID: <51b38994ed2032a83160881e53994fb4487a7b02.camel@redhat.com>
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
From: lyude@redhat.com
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timur Tabi
 <ttabi@nvidia.com>,  Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Kees Cook
 <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>, David Airlie
 <airlied@gmail.com>,  Thomas Zimmermann <tzimmermann@suse.de>, Maxime
 Ripard <mripard@kernel.org>, Mel Henning <mhenning@darkrefraction.com>, 
 Aaron Plattner <aplattner@nvidia.com>
Date: Wed, 08 Jul 2026 19:30:04 -0400
In-Reply-To: <58219e62-99aa-4bb3-9c6b-5f96dae12649@nvidia.com>
References: <20260701182857.190713-1-lyude@redhat.com>
	 <20260701182857.190713-3-lyude@redhat.com>
	 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
	 <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
	 <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
	 <b5d08cfe-aead-45f2-937d-6e9ef4dfea50@nvidia.com>
	 <971d09c47689981c1ea44c89555f71fcc0b5db41.camel@redhat.com>
	 <58219e62-99aa-4bb3-9c6b-5f96dae12649@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 16:25 -0700, John Hubbard wrote:
> > > not
> > > derive those flags from srInitArguments.flags. That field is read
> > > in
> > > only one place on the resume path, an unrelated display
> > > workaround
> > > gated
> > > on the PM_SUSPEND bit. Neither 0 nor PRESERVING | PM_TRANSITION
> > > sets
>=20
> This "unrelated display workaround" might be related after all,
> perhaps.

Would be good to note too - while it's not impossible it is actually a
display workaround doing this (as this secondary laptop GPU does have
display connectors routed to it), I currently don't have any displays
hooked up to it.

