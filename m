Received: from smtp-sv1.saltyming.net (smtp-sv1.saltyming.net [152.53.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81920DD51
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791073671; cv=none; b=uoFut7cQisS1nKRT1hAnDrYwbDnU3q9bcCdVPwOsY5JEn8C3zL6kcl+bCyjKNRZafiirEs4/El74Vq7qOsoC/nu2V859xAEZuWwSDda97/Q7fmIBZRZbwiEZ85ILyDHrzoyb1p2CgtzzotiOWUC9qKxFo6NVJaD+RR+NUbThUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791073671; c=relaxed/simple;
	bh=9y565mXmPk14OT+EJKpfLw7jDnD7lIoT4YWiqhVhvcA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AgoMq9QvSS4CW75wdgUX8WO39I2Vp21Rm2WBp9k+Yf1zIhnbj/gG1PVBIcJEpFEhQ3D8y/UwJzsVcDI7XWjqJMfl2v1NtjDoJ7ZR1vx86nH2ygA+XZWQW7BlVdhl1+y4spweixvvXGEHwfFB0NHxOay4L1tGKeRiJZUeYH5PXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=saltyming.net; spf=pass smtp.mailfrom=saltyming.net; dkim=pass (2048-bit key) header.d=saltyming.net header.i=@saltyming.net header.b=rJPpQ3sH; arc=none smtp.client-ip=152.53.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=saltyming.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=saltyming.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=saltyming.net header.i=@saltyming.net header.b="rJPpQ3sH"
DKIM-Signature: v=1; a=rsa-sha256; s=saltyming-dkim-202512; d=saltyming.net; c=relaxed/relaxed;
	h=To:Message-Id:Date:From:Subject:Mime-Version:Content-Type; t=1791073668;
	x=1791678468; bh=9y565mXmPk14OT+EJKpfLw7jDnD7lIoT4YWiqhVhvcA=; b=rJPpQ3sHDm
	FviOjVZiydUKUvSX+11yxOv1bvCjdlDN9WsRHAVeq5AEDM7g4HS4H51abf0ZeuPQ3yakFNr7jGk
	lpuodGNbtaU4aLh1sHDB4bnRB2xYh5CjCMNl71iPdKbD86IaOg7PPuIYLE+DzWC+CEXNWQRA7JZ
	hwUrFFwXp9UbbPa/fYsXyHFPjg1c4aCk/u/RiNWQh+VRvQT75YfuKFdqbydZHWKdVr1fgdXCgvk
	BXULcuB6pN+gLqZygvCNl5D+ALZ6y5vRiI/MdEZJxNRKEkJjaLcTtESWH+eyhIiSjY/SnnQDY61
	qsH3c9ffJV0nPMUYQXJgloAKrDKFeIww==;
Received: by smtp-sv1.saltyming.net (SaltyMail) with ESMTPSA
	(version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 bits=256/256)
	(No client certificate requested)
	id 98d00096-4c49-4edb-b58c-8c8ea6f631e3
	for <stable@vger.kernel.org>; Sun, 4 Oct 2026 00:27:04 +0000
X-Virus-Status: Clean
X-Security-Tags: spf_none, dkim_none, dmarc_fail, dmarc_quarantine, arc_none, av_clean, ham
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.41\))
Subject: Re: [PATCH] drm/nouveau: request a privileged CE channel only on
 Kepler and later
From: Hamin Sung <hamin@saltyming.net>
In-Reply-To: <cdc6f42770d824240a6d4474d090a9be8da7bc2a.camel@redhat.com>
Date: Sun, 4 Oct 2026 09:26:47 +0900
Cc: Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Yonatan Maman <Ymaman@Nvidia.com>,
 Gal Shalom <GalShalom@Nvidia.com>,
 Ben Skeggs <bskeggs@nvidia.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F16C3327-4F6A-479E-B4D1-F8F2B1F55EF0@saltyming.net>
References: <20261003223244.63133-1-hamin@saltyming.net>
 <cdc6f42770d824240a6d4474d090a9be8da7bc2a.camel@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3901.200.41)

2026. 10. 4. 08:53, Lyude Paul <lyude@redhat.com> wrote:
> The LLM didn't mention this (of course), but you need to increment the =
version
> of the patches that you send out when sending new versions along with =
a list
> of changes that were actually made to the patch since the previous =
version
>
> Also, while LLM generated patches are fine for fixes (to an extent) - =
but
> please at least make sure you write the changelog by hand to avoid =
inevitable
> mistakes

Sorry for noise from the sudden series of patches I sent using LLM. =
These are my first kernel patches,
and I just wanted to fix some issues with my old NVIDIA graphics card.

Also, those weren=E2=80=99t new versions. My mail server had a bug =
delivering most messages twice
(I mentioned this in the devfreq RFC series). Sorry for the confusion, =
it=E2=80=99s fixed now

I=E2=80=99ll keep about versioning and hand-written changlogs in mind.=

