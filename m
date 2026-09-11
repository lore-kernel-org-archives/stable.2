Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B563DAAD0;
	Fri, 11 Sep 2026 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169630; cv=pass; b=WwpPHevgFu2JO/baGmYeyCUgqChKv5NWZgc3JFVNi0K1IL24XuG1bf99CGzaa/04HXcHUet+akf4yi442oIQWnwiCSaODASukkF/7IGYMFC84O/CNs0Ezcvd7mqH2c6/hQJvN1QvLMLmi2Q4U1Vd4+IM+5ysgzxu1g2WwZ3fU+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169630; c=relaxed/simple;
	bh=Yo+9K2nblqwDnLI6SnUTtE21RpYU30T8k87N5vXWLrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE7MsOuLFYhw77PvLAn2SKh1jmYY8qp3Lc8WALQTOLgFcC4QmedMBqanEnOdFHIpDCQK+KKxW9QSLnFWHjLqsTayutk5Te+jmvyNsVzMc5dBBtG5OQ09iIgQvrq+jkUcTr9HHXVz5ASWJKIrk7o7T3fQJbktRY2Sj/GSfrNNz/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Jsm26mRv; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Jsm26mRv"
ARC-Seal: i=1; a=rsa-sha256; t=1789169608; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mAAVftruK7RZ9u89zhkmXNyh3qvxYiEGBEfrf57eZyJ86b36g/B5ryA4hiQV0RqoedA4bpd8zpK1NsTyVvRHJbr1DeAXi1Kd01fg9n7QR47TsCQkse1bzw5oFKzOD9myRp/Wq7Um0u5pM8Of0CtrM9SgJ/WOtm4ojBdL+MOCzRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789169608; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FlSuAj76Xa7+btWKg1rFtrdbbsqdb8pmg5RuE4pVw8Q=; 
	b=KOu9AHP+5+6zaagWPzxr7jUzdbDqRjd7lAHX07oPuNAdmWxivMZtgFm4HVr0wY8ikXd9tQRS6sYpZtRobQYDwKVlROiQM2TNkbjZk8dRn+oAAaPjwIaeoOQisOcg0yGBfju8Vo7gpSfptYKpfBZVLCR1SvviZjLDz+kvUh8o1kY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169608;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=FlSuAj76Xa7+btWKg1rFtrdbbsqdb8pmg5RuE4pVw8Q=;
	b=Jsm26mRvp27+E7Gla/l/m9cPR7hCZ1J2W4HW0n+RIU2a2CEH0uwfLiqJim278yny
	nG8BOSCvsoWFVxI1e1cUCRJJ3y7WLy7Iy9P6iy/hh80Z/uaYzhmOXOfknvZOD23s8uT
	uuOXzZfOt4eODuFaxxRJAx7ut4v1pR818WEse8nU=
Received: by mx.zohomail.com with SMTPS id 1789169607383556.0096067894884;
	Fri, 11 Sep 2026 16:33:27 -0700 (PDT)
Date: Sat, 12 Sep 2026 00:33:23 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
	Eric Anholt <eric@anholt.net>, "Marty E. Plummer" <hanetzer@startmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: fix autosuspend cleanup during teardown
Message-ID: <aqSOyUCZ7rT-u1hF@sobremesa>
References: <20260808135025.2872956-1-lgs201920130244@gmail.com>
 <anx91vwww0TMjLn8@sobremesa>
 <CANUHTR9Xneqaa7FvdKmwuBfKiBuj2nE+nOXOxuR_cJYjExiemQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANUHTR9Xneqaa7FvdKmwuBfKiBuj2nE+nOXOxuR_cJYjExiemQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.144.59

Hi Guangshou,

I'm afraid in the end I can't apply this patch because the series I wrote, besides including this
fix, has quite a few others to deal with existing issues with power management in the driver.
It felt awkard to apply this one in isolation without addresing the other bugs at the same time.

Check https://lore.kernel.org/r/20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com for further
context, patch 6/16 to be more precise.

However, like I said in a previous message, I'll soon be compiling a list of existing issues
and post them on a Freedesktop Gitlab issue for anyone curious to have a go at.

Cheers,
Adrian

On 13.08.2026 10:10, Guangshuo Li wrote:
> Hi Adrian,
> 
> On Wed, 12 Aug 2026 at 22:35, Adrián Larumbe
> <adrian.larumbe@collabora.com> wrote:
> >
> > Hi Guangshuo,
> >
> > Recently I've been working on a patch series that addresses PM refcnt imbalances in Panfrost.
> > One of the fixes introduces devm_pm_runtime_enable(), so manually calling pm_runtime_dont_use_autosuspend()
> > is no longer necessary like you mentioned in the commit message.
> >
> > However, there might be a point in using it during device teardown and probe error just like Panthor does,
> > becasue it doesn't make sense to postpone suspension when the device is going away.
> >
> > Anyway, you can have a look at it here:
> > https://lore.kernel.org/r/20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com
> >
> > I was thinking, I'll let you know when I've v6 ready and then you could rebase this patch onto it
> > before I submit the series to the ML so that I can send them all together?
> >
> > Kind Regards,
> > Adrian
> >
> > On 08.08.2026 21:50, Guangshuo Li wrote:
> > > panfrost_probe() calls pm_runtime_use_autosuspend(), but neither the
> > > probe error path nor panfrost_remove() calls the matching
> > > pm_runtime_dont_use_autosuspend() during teardown.
> > >
> > > If the autosuspend delay is set to a negative value while autosuspend
> > > is enabled, the runtime PM core increments usage_count to prevent
> > > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > > during teardown, this reference is not dropped.
> > >
> > > The documentation for pm_runtime_use_autosuspend() also notes that it
> > > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > > driver exit time, unless runtime PM was initially enabled with
> > > devm_pm_runtime_enable().
> > >
> > > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > > probe failure and device removal paths.
> > >
> > > This issue was found by manual code inspection.
> > >
> > > Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > index 784e36d72c2b..007dcba62e62 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > @@ -1011,6 +1011,7 @@ static int panfrost_probe(struct platform_device *pdev)
> > >  err_out2:
> > >       drm_dev_unregister(&pfdev->base);
> > >  err_out1:
> > > +     pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > >       pm_runtime_disable(pfdev->base.dev);
> > >       panfrost_device_fini(pfdev);
> > >       pm_runtime_set_suspended(pfdev->base.dev);
> > > @@ -1025,6 +1026,7 @@ static void panfrost_remove(struct platform_device *pdev)
> > >       drm_dev_unregister(&pfdev->base);
> > >       panfrost_gem_shrinker_cleanup(&pfdev->base);
> > >
> > > +     pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > >       pm_runtime_get_sync(pfdev->base.dev);
> > >       pm_runtime_disable(pfdev->base.dev);
> > >       panfrost_device_fini(pfdev);
> > > --
> > > 2.43.0
> >
> > Adrian Larumbe
> 
> Sure, I’d be glad to do that. Please let me know when v6 is ready, and
> I’ll rebase my patch on top of it.
> 
> Best regards,
> Guangshuo

Adrian Larumbe
