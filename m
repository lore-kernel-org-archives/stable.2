Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620C522F0C;
	Tue, 22 Sep 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064106; cv=none; b=gUXuZGymRosyWB9L9fFZMIJrZpj12dGUN4NX0laGt0uRIHsiQ/D1kcwQevg3N9MIb3awj+o/udLLRVtMX+uqzPmhVh3+HVNJTJBLzuQsxp7k35CyhhXWNrtlYuQbwhIBDQpxP0CI+batbNN5xB739kGkUh7T9LiOHi5ArYTAnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064106; c=relaxed/simple;
	bh=K5a4irdVg5GqminvoZlcv6xJQ44kH6rk1iM8qfqqAbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpaE+j2t/dhuFCe0sNCbKljgC57oVNDWIHP7fyBuOmX02gpQ7dVq7eyW9K/hqhgfuyBOltP3fJm5iudB0pKsF62TEd80pJ2LUhBbvYCuzceTbYmwj2a5QQOXL+4ijQgdr8V7Ts35IfVOz9Z8GhQMPybuGa8PlnKak+gKXUFKGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anf4GRXt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anf4GRXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790064096; x=1821600096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K5a4irdVg5GqminvoZlcv6xJQ44kH6rk1iM8qfqqAbQ=;
  b=anf4GRXtUUM6gy+axzR233QhhAhWSvVL6BSWjVxywiIHVW1re7vBslAc
   ejbuSgFlbgY2bk3HhflJOeXdj9+bQhjQ707RluOuO8rszJqXb0SDegpKz
   d4KIjKZue0UTBUHNaVGZ09gzzL54TXyqxDEMi9lJoMsF/zlNa3gorf00U
   83nLNeilRCUKt1FS9X8btCPe7X+lh7YlRMog9xxEhHdNqcuSoS/dd6kbA
   opB6OmJIr5jlPT8ADlnYoZoY9J3VOSaUVPQIYVtbnImjlYYLWwsPtjJq7
   +MeB3wbhUvNmk1THukdEgFdkCkQCozAn4p48PTYQPlCuSWjbIAua3Wrj+
   w==;
X-CSE-ConnectionGUID: mKucwaTTRtKRxBozCkk7BA==
X-CSE-MsgGUID: PY1zd84IQKSM+qfsS5g/1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89565767"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="89565767"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 01:01:27 -0700
X-CSE-ConnectionGUID: v4hnpuodQz2oQna5x2atZw==
X-CSE-MsgGUID: 89ebydLZStGlxUgM+WBClg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="273192073"
Received: from carterle-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.41])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 01:01:26 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 4C6BE121B9F;
	Tue, 22 Sep 2026 11:01:25 +0300 (EEST)
Date: Tue, 22 Sep 2026 11:01:25 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov5647: fix power cleanup on remove
Message-ID: <arI11VsxaiJ8v4Ye@kekkonen.localdomain>
References: <20260915090457.2342778-1-lgs201920130244@gmail.com>
 <CAPY8ntA2h_ChCWJbAmCVygYiviTdsd9TA2LcVh5ffto__LgZAg@mail.gmail.com>
 <aqz4fLrtW3f7OoYk@kekkonen.localdomain>
 <CANUHTR9_XR7Q1CJQwKHd6dZRLaJdRNpHxYbUVXkJj_iM7ywoeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR9_XR7Q1CJQwKHd6dZRLaJdRNpHxYbUVXkJj_iM7ywoeA@mail.gmail.com>

Hi,

On Tue, Sep 22, 2026 at 03:45:13PM +0800, Guangshuo Li wrote:
> Hi Dave, Sakari,
> 
> Thanks for the clarification.
> 
> On Fri, 18 Sept 2026 at 16:45, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Dave,
> >
> > On Thu, Sep 17, 2026 at 02:27:30PM +0100, Dave Stevenson wrote:
> > > Hi Guangshuo
> > >
> > > On Tue, 15 Sept 2026 at 10:05, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> > > >
> > > > ov5647_remove() disables runtime PM without powering off the sensor if
> > > > it is still runtime active or updating the runtime PM state to
> > > > suspended.
> > > >
> > > > pm_runtime_disable() prevents further runtime PM callbacks and waits for
> > > > pending operations, but it does not force the runtime suspend callback
> > > > to run. If the sensor is active when the driver is removed, the external
> > > > clock and regulators can remain enabled and the power-down GPIO can
> > > > remain deasserted.
> > > >
> > > > After disabling runtime PM, call ov5647_power_off() if the device is not
> > > > already runtime suspended, and then mark the runtime PM state as
> > > > suspended. Checking the runtime status avoids disabling the hardware
> > > > resources a second time when runtime PM has already powered off the
> > > > sensor.
> > > >
> > > > This issue was found by manual code inspection.
> > > >
> > > > Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > > ---
> > > >  drivers/media/i2c/ov5647.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > > > index 3facf92b3841..d42d009772ac 100644
> > > > --- a/drivers/media/i2c/ov5647.c
> > > > +++ b/drivers/media/i2c/ov5647.c
> > > > @@ -1271,6 +1271,9 @@ static void ov5647_remove(struct i2c_client *client)
> > > >         v4l2_ctrl_handler_free(&sensor->ctrls);
> > > >         v4l2_device_unregister_subdev(sd);
> > > >         pm_runtime_disable(&client->dev);
> > > > +       if (!pm_runtime_status_suspended(&client->dev))
> > > > +               ov5647_power_off(&client->dev);
> > > > +       pm_runtime_set_suspended(&client->dev);
> > >
> > > I was unsure whether pm_runtime_set_suspended can be unconditional or
> > > should be in the if clause. There are numerous drivers doing each.
> > >
> > > As it happens, Sakari's just answered that in [1] that it should be
> > > conditional, so I'd take that as gospel. It looks like he's given a
> > > similar answer on your ov2740 patch.
> >
> > Runtime PM is a bit mystical in some places. pm_runtime_set_suspended()
> > appears to be setting the device's Runtime PM state disabled as it name
> > implies, but it may also e.g. increment dev->power.disable_depth. I'm not
> > fully certain if this is by design or not.
> >
> > --
> > Sakari Ailus
> 
> Would this be the right way to change it?
> 
> -       if (!pm_runtime_status_suspended(&client->dev))
> +       if (!pm_runtime_status_suspended(&client->dev)) {
>                 ov5647_power_off(&client->dev);
> -       pm_runtime_set_suspended(&client->dev);
> +               pm_runtime_set_suspended(&client->dev);
> +       }

Correct.

> 
> If so, I can send a v2 with this change.

Please!

-- 
Regards,

Sakari Ailus
