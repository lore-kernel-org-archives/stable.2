Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1823F411B
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929767; cv=none; b=Jpud54MXGg/En6Qubq+lVvumSmUb3AAKkRshYOVNRmEGZzAy3ur9vqr59GD/Q5nAOUOX7oXdces20hP49WcQGdGQEj4SH9v1E1QYyc1TUmkas7jxV9tJKWQCIs7+e2Bphp856qZ8yRCgzaQTEYEv5IAcDpEq4DxBNuyTDeswVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929767; c=relaxed/simple;
	bh=SQoEdvMv6/pXDC6SALGlSvWerPwNr5G1/PmjYcz5yCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4tf5CL7YOXhazL55KmnaQ2MmFmwF+4g+/NiouOavLrayBeoNCz478DGygK0wZUMR+2tmZInZ9lPvVlO36N/Ic+jH5C6XN1aO+L7jnN0sJvnjOR30G2PzJDAYNQN50ExV2aPlytAEmBlNJAFan34LuvDgDDv9ZPtXMALFImpehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ra3F39Ti; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzDySoXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ra3F39Ti";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzDySoXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782929764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQoEdvMv6/pXDC6SALGlSvWerPwNr5G1/PmjYcz5yCE=;
	b=Ra3F39TiGqhhX6QbHdhBIGR0QqwTTOCytwVbYmF6Po+rRJxlIL3XhRm5nsFDmVXFlU9fFt
	9eZcOf6UOn4L95M2CfxevtufBqxipn/+VApAtTe/O6jKIRRzDHuP4aNvbxvjPGuDiC+iZj
	OVHdchxts7xzW1BoauTERTxtGCGSk+Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-5dNfdjm2OB6_EEYCqIEpcg-1; Wed, 01 Jul 2026 14:16:03 -0400
X-MC-Unique: 5dNfdjm2OB6_EEYCqIEpcg-1
X-Mimecast-MFC-AGG-ID: 5dNfdjm2OB6_EEYCqIEpcg_1782929763
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bff5c7035so17585991cf.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782929763; x=1783534563; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SQoEdvMv6/pXDC6SALGlSvWerPwNr5G1/PmjYcz5yCE=;
        b=KzDySoXNKy+zsyQI5GXHo/tbtWBTpZlFIjcQU4escJNDIjN5Cul25Hik8FiV1SDDCd
         aFCpuh37YJHt3jxusBBRw0mOrdPH1xXy+EEnY9SgEnumo8n6ZqScmnFPohTKPnYYktUu
         kE1BStbOOUPvfDrPnk3LzSyyHQXNBCHJM2q8/uRQbeGpp36h159TRAa2zlYcRgT1L+MR
         l48U0/SHzIM/EpkIl7liGC5+VoXAbOseCswa/+l7SLZZekGae2dUQH3fuz82aEgoTGqd
         JMAApxdnmsfkqg1r+RKLrUSb1M6YGHJILsyp0hJG2WIUz2f67A+9SFhMmZ9hJrGu3neS
         CcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782929763; x=1783534563;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQoEdvMv6/pXDC6SALGlSvWerPwNr5G1/PmjYcz5yCE=;
        b=PSbdQG9FBJU4HJ8g88mRWh5uZVQVvvTkEZ26eTEie3DxXm9Tq6MiiTYTdoiJL7xKm/
         RM5lXg/KrCrkMtf9qAB+6cNJW1nnhWRmOLRFDOKoJJEyQwul+zvFznDK/8fH1g+HAG6X
         jr2n3lFSDz3InWMmlKsuCwNwdx3Rg7b8/Sp1/l1Gy/RttarR1pAv2TGvPYPn7oRr1+vE
         T8Ho/YN4H0UxFJbuklFT8Hx4IQ5FxYh8tULx+3zs5aE10kkxJH672sAUIS7zAvUpjH2s
         5Saqb1LzMG0J2X7lFBedN2l7SXFKXdGbFfejYwFeKnQF8e0XuLUfTzQ6cRozEFpk7jvc
         wOaA==
X-Forwarded-Encrypted: i=1; AFNElJ970grSNSzHejVauxM3O30GHPiF8kC7OnMrJSGHD/U8n9r+mG4Uc2INlF+OFjdcgUtnsPirXsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlhvIEmSnrWmPKIeEw/0323x19kwt9oWCPZD09G+1KPGz8jlmD
	uv0auzN8xVY35/Z6Mgep5+soc3RhZMWxQ6Yww3gB81jNakDDg31tzzpgZrMP+AYHkA7GyvMX8hQ
	jGZoKGjpS0lWkod+OpkUlq5MOT3H7HQ+A4qh1Mbn6MYQlOcGfLtzzDjVlmA==
X-Gm-Gg: AfdE7cmepChz3cUy+qfwpqYEeh31WJN/WtjVMA7XY6koTFpWId9SGdgrGKAQyxb3IVl
	os1Ajp+nlo4rgaRurs3NPFDHsNDVp5NWfdBXT8Wawpq2gG7eMQ+2WhlmWOPb8vk2TkhmmjQ7m22
	A+IGnhrsbTWQbOez39ACXQfWaUahTWvPm9AW788EVgwUAz++p/wYj4ghLZiX1ou3eQv9kT4lcvM
	SPvbU0IjgnAtTjd7LXEnd1sNr8Su59NBZLk56/tjTHZFQBH/fA5TAX1Bk2FRdbAuTTFtqhZ+3qH
	hguISgyN+C90jQ18RL8+7oX8Vp/eJbXffjsOUH4d9IpUtpwj3c8sNaSRrs9oqVc/MdyGujR/S77
	qZFky7+k=
X-Received: by 2002:a05:622a:997:b0:51c:a70:5ed with SMTP id d75a77b69052e-51c26a7ea3fmr38529011cf.30.1782929762984;
        Wed, 01 Jul 2026 11:16:02 -0700 (PDT)
X-Received: by 2002:a05:622a:997:b0:51c:a70:5ed with SMTP id d75a77b69052e-51c26a7ea3fmr38528451cf.30.1782929762509;
        Wed, 01 Jul 2026 11:16:02 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a360e0sm51905511cf.30.2026.07.01.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:16:01 -0700 (PDT)
Message-ID: <b23948367e3580f45c1d6d61db6e38b582f219db.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timur Tabi
 <ttabi@nvidia.com>,  Dave Airlie <airlied@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Ben Skeggs	 <bskeggs@nvidia.com>, Kees
 Cook <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>,  David Airlie
 <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>,  Mel Henning <mhenning@darkrefraction.com>
Date: Wed, 01 Jul 2026 14:16:00 -0400
In-Reply-To: <DJMIGDHFYCIA.271V0T10TID2J@kernel.org>
References: <20260629224350.2870201-1-lyude@redhat.com>
	 <20260629224350.2870201-2-lyude@redhat.com>
	 <akOuPQ37-zxIJWWH@ashevche-desk.local>
	 <DJMIGDHFYCIA.271V0T10TID2J@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Sounds good to me - will update the patches with this on the next
respin, which should get sent out in a moment.

On Tue, 2026-06-30 at 18:05 +0200, Danilo Krummrich wrote:
> On Tue Jun 30, 2026 at 1:53 PM CEST, Andy Shevchenko wrote:
> > On Mon, Jun 29, 2026 at 06:42:33PM -0400, Lyude Paul wrote:
> > > This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.
> > >=20
> > > It turns out this looked like the right fix on some systems, but
> > > it's not -
> > > as this causes runtime PM to actually fail on many a laptop.
> > >=20
> > > [I have set the fixes to an older commit then the one that is
> > > reverted
> > > here, because when applied with the other patches in this series,
> > > this
> > > appears to /fully/ fix runtime PM in addition to the regression]
> >=20
> > No need to have this in the commit message, move it to the comment
> > block...
> >=20
> > > Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
> >=20
> > I'm not sure, actually, that this is a correct approach. You can't
> > revert
> > something that never appeared (in time range between 53dac0623853
> > and
> > 8302d0afeaec). Have you consulted with the stable kernel process
> > documentation
> > and/or respective maintainers?
>=20
> I think it should be as simple as picking
>=20
> Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on
> r570 firmware")
> Cc: <stable@vger.kernel.org> # v6.19+
>=20
> for this commit and keep patches 2, 3 and 4 as they are.
>=20
> The commit message of this revert can then explain that the commit
> that was
> attempted to fix with this revert, i.e. commit 53dac0623853
> ("drm/nouveau/gsp:
> add support for 570.144") is fixed with a different, subsequent
> approach.
>=20
> This seems correct, as reverting a bad fix does not claim to solve
> the original
> problem.
>=20
> Thanks,
> Danilo

