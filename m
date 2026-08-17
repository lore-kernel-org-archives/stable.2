Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658C3B4EB2
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951400; cv=none; b=l0FfQ2/nKmstKSTknH7z1bWzpuUrBL5+C9V8ZYEQXK+EdNmmrt4sMM2RVqoSLpnFTUZ7LsdygO0fVV5VapG3TLiRZMVIM9CPjuZGUOpw/iXO3L5ZZdP2ookgpwmCLNbivprmHhC1bWXmChJ3A+8/UDKtOURScbYc9KPg0vAkFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951400; c=relaxed/simple;
	bh=ZlAn7KJGSqpMAt/Ici+UlvtKqnC+mIeE7T0ZMjo+sDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSIEKRW5+JjQui5LQXG2oBxDs31XsVsPb13G6HL1ySlTs2aEYieVr2mWtpFrSzKBxgLC3QxHscsXJofZyCl1yenohihcg9wXPzFe+57p2g50UkR5ih1F+LDLrzXbaeyB41O8Bj6ZyaonnuLjPKf2o9CmFL064BXti9HPHNwGj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG+Bb0fy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG+Bb0fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78A71F000E9
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786951398;
	bh=R+jqORs8+hxxBRQmaPvtNJ0Yk9KIuVwJkWrtOoniQds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RG+Bb0fy3TPxvsaEKnCadZT1DGXK2aTBnTu7ZvV8oF+a3BEJNvGlRAzP62589R+vJ
	 87Uh5r+x/nEDq49HQ8NVo+IEWWayedmqdxh2vaVblMEvHB1QpdVjseqZkgOHqzHvLw
	 jWbeg/xmka1pk/YxBSMueaprAwiJjY2R+QGaJBtFvEfQbGSuz5NQbRkxbmWUORnC21
	 bF5c6O42nHzIdCMf/M7XEcVHASZK3wUAFkCs8n/fZifLHB3szivDs45gWJvB5eIQTH
	 sbW0ZRTNl9HVg0OwU2xqNvMZ+KIOhGCj4QHYMpky3RDrFaCoSeeoFYz3kdE7SC5Y9/
	 IxfpkK9TCm3cQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so3894879a12.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 00:23:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoqN45Xz1DCsuwLlAEOGuGUfWa4O0yE+u6l/uEjO14XmnEpMCGnnnXQvxAjed5GeMPYFMejM7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/8wnnHA1ZvM0ZRYLSxPcNZm5zwndiPd/bfceoHoIw0vC7jjk6
	S6cwxGcYRtJGqara0jpNmc3+9qTqAsg3wCOdeTn0Vucb9/SXgTF8U8Wim4i15lc5nxNFWPu4WXV
	H+JE+Im5iSStRkmFGjkdI9YHBDhDNXZQ=
X-Received: by 2002:a05:6402:350c:b0:6a1:7ccd:5203 with SMTP id
 4fb4d7f45d1cf-6a38a8d7a6cmr10401927a12.2.1786951397663; Mon, 17 Aug 2026
 00:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731102147.127082-1-git@jaseg.de> <CAPx+jO_dACmFfdy6v32=V31HYiBFeU0NpnvhVuFWvLQ0Ls845g@mail.gmail.com>
 <CAKJaZcON7n66Sk0RFAEiccw2G1aKF5jCR47Ph8+0RRY-Zz88aQ@mail.gmail.com>
In-Reply-To: <CAKJaZcON7n66Sk0RFAEiccw2G1aKF5jCR47Ph8+0RRY-Zz88aQ@mail.gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Mon, 17 Aug 2026 00:23:05 -0700
X-Gmail-Original-Message-ID: <CACRMN=fO_umGrNpM5t7ezp+Mvq8T0hT76S_YRdp6G3xagULesg@mail.gmail.com>
X-Gm-Features: AcwNN1WmMnldjy5XKkZRJDeCDp1UnWethIyrx_eViIYwmQWIhF0_wjCbOe79yak
Message-ID: <CACRMN=fO_umGrNpM5t7ezp+Mvq8T0hT76S_YRdp6G3xagULesg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: Saravana Kannan <saravanak@meta.com>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, jaseg <git@jaseg.de>, 
	Saravana Kannan <saravanak@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 2:00=E2=80=AFPM Saravana Kannan <saravanak@meta.com>=
 wrote:
>
> On Tue, Aug 4, 2026 at 7:31=E2=80=AFAM Ulf Hansson <ulf.hansson@oss.qualc=
omm.com> wrote:
> >
> > >
> > + Saravana, Rafael, Danilo
> >
> > On Fri, Jul 31, 2026 at 12:21=E2=80=AFPM jaseg <git@jaseg.de> wrote:
> > >
> > > From: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
> > >
> > > genpd->dev is embedded in struct generic_pm_domain and its release
> > > function is empty, so providers free the containing genpd with a plai=
n
> > > kfree() once of_genpd_remove_last() returns, ignoring its refcount.
> >
> > Yes, there is certainly room for improvements in regards to reference
> > counting and freeing data in genpd. It's moving slowly in the right
> > direction though.
> >
> > Anyway, the release function is actually set to
> > genpd_provider_release(), which ideally should free the data in the
> > long run, but we haven't fully reached that point yet.
> >
> > That said, I guess you actually are referring to the ->remove()
> > callback for the genpd_provider_drv, right?
> >
> > >
> > > Since genpd->dev is registered on the genpd provider bus, fw_devlink
> > > creates device links to it, and those are torn down asynchronously.
> > > Nothing made genpd_remove() wait for those teardowns, so the provider
> > > could free the memory backing genpd->dev while the queued workers sti=
ll
> > > used it.
> > >
> > > This is reachable at boot on qrb2210, where the firmware rejects PC m=
ode
> > > and psci_cpuidle_domain_probe() removes all the CPU PM domains before
> > > returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but sh=
ows
> > > up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
> > > causes the kernel to crash a few hundred ms into the boot.
> > >
> > > Call device_link_wait_removal() before dropping the final reference. =
All
> > > link removal work is queued from device_del(), via
> > > device_links_driver_cleanup() and device_links_purge(), which precede=
s
> > > genpd_free_data(), and flush_workqueue() waits for it to complete.
> > >
> > > Note: This patch was LLM-assisted. I reproduced the issue and tested
> > > this patch on hardware, and I did my best to verify it by hand. Howev=
er,
> > > I'm far from an expert in pmdomain, so YMMV.
> > >
> > > Assisted-by: Claude:claude-5-opus
> > > Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd=
 provider bus")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
> > > ---
> > >  drivers/pmdomain/core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > index 842c4169e290..4eeb980e5a40 100644
> > > --- a/drivers/pmdomain/core.c
> > > +++ b/drivers/pmdomain/core.c
> > > @@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_d=
omain *genpd)
> > >
> > >  static void genpd_free_data(struct generic_pm_domain *genpd)
> > >  {
> > > +       /* Pending device link removals still reference genpd->dev. *=
/
> > > +       device_link_wait_removal();
> > > +
> >
> > Even if this fixes the issue, it looks wrong to me that drivers should
> > have to deal with this themselves at device removal.
> >
> > In other words, I was expecting the driver core to deal with this for
> > everyone, but that seems not to be the case. Hmm.
>
> I agree.
>
>  I'm not even sure if device_link_wait_removal() should have been
> added. The point of refcounting is that we don't have to worry about
> who releases in what order and the last one to release will have a
> resource freed. Needing both ref counting and a say to sync feels
> wrong. Let me take a closer look.
>
> -Saravana
>
> >
> > Note that, the device removal should typically happen when the genpd
> > provider calls of_genpd_del_provider() and it calls device_del().
> >
> > >         put_device(&genpd->dev);
> > >         if (genpd->device_id !=3D -ENXIO)
> > >                 ida_free(&genpd_ida, genpd->device_id);
> > > --
> > > 2.53.0
> > >
> >
> > I will have a closer look at the driver core for this. In the
> > meantime, maybe Saravana, Rafael or Danilo have some ideas already?

I took a closer look.

I think the problem is that the genpd framework's internal structure
(struct generic_pm_domain) is allocated by the provider driver and
each one of them allocates it in a different way. For example:
* Part of a container struct's allocation. Eg: struct scpsys_domain
* Using a kzalloc(). Eg: dt_idle_pd_alloc()

And the genpd framework has the struct device as a member of struct
generic_pm_domain and device_add()s it. But the problem is that the
framework now has no control on when the struct device is freed AND
the provider driver has no way of knowing when it's safe to release
this specific genpd->dev and any containers of it.

I think the right solution is for struct generic_pm_domain to change
the "dev" field to a pointer and then allocate the device inside
genpd_alloc_data() and free it in the device's release function (which
is currently a no-op). There are a few places genpd->dev is used
outside of the framework, but those can be fixed up easily.

$ git grep -c 'genpd->dev' -- drivers/
drivers/pmdomain/arm/scmi_perf_domain.c:1
drivers/pmdomain/core.c:59
drivers/pmdomain/governor.c:2
drivers/soc/tegra/pmc.c:3

$ git grep -c '&genpd->dev' -- drivers/
drivers/pmdomain/arm/scmi_perf_domain.c:1
drivers/pmdomain/core.c:40
drivers/pmdomain/governor.c:2
drivers/soc/tegra/pmc.c:3

Hope this helps.

-Saravana
