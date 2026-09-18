Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593E3DDDBE;
	Fri, 18 Sep 2026 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721152; cv=none; b=GWSgDyok6qEr/OUvg9tXNMscJ0yTwHzqqvnc0mYrTOxLcJuymuLmHRhSsNQcxEbXbLlwyKnd2PSnawf1V19Z3DfUVsmytyAd4pKck2lTXY4APZ4eWatO9jTVBekM5ENl3o2sQt+NL/BnQlFyTWkQTe0ZI4iIYiR1JNZ5iUVWazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721152; c=relaxed/simple;
	bh=6jm1/+RQTjOj86nkoMFsqYqIw+Hj6Gbgq/+Fvs5Z21Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMO8Q9YwJ+5p/SqDvpM2RyyK2bbVzZvwKVsR220+hqa1OtB7qZfvzlQ86dJ3kdndHt4CJuKg9Ubt6srT5LiDv/TYN1+43UdoKblu0BrG8HDwHlncjew4jiA9cFQSNPO68GlnYuIKDgpWjnSgY03uYQEKZHfkJWJ/aH6SzTNSE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQSL3V4R; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQSL3V4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789721149; x=1821257149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6jm1/+RQTjOj86nkoMFsqYqIw+Hj6Gbgq/+Fvs5Z21Y=;
  b=RQSL3V4RzFwtOCV5GbfPa9YxxkNYeeBoXUd2myJV2eJAZZrHPV8mXEJb
   nzgO0z8R+DWpNQdBGKolr7x8T/eaaezReHP/Twf5C90hAe7Swwkjiuqec
   dEPqWGYPmbIGuCQGdLN5N0jZChtKlDeL7woj5qy4fkE/dzkgrf2ZlT637
   r4Ilpicz2Iz09oTk2yX824l+N4coISNG1qP2zKXODr/oolIqr6uIF0TY2
   5p0ClsphzU9Un5OVLk1TdhLlooUc8IR9dWUxzFwdjOpm3oZOcSatnQjW7
   K8HbtQXCWEW5T7/tRR1GUKGZQyWJF9tppZM25iazwpUKYPOOhScg2iHdS
   w==;
X-CSE-ConnectionGUID: jqbxrHe4QYmXdxWfvSMPrA==
X-CSE-MsgGUID: 1ssiy8M6Ra+yNGbrtK0RzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90077051"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90077051"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 01:45:48 -0700
X-CSE-ConnectionGUID: azJm46xdTn2+5HVcBEE0cw==
X-CSE-MsgGUID: S3a2lZWKQyup46T9P/AhpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268037913"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.224])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 01:45:47 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 05DE8121BC3;
	Fri, 18 Sep 2026 11:38:21 +0300 (EEST)
Date: Fri, 18 Sep 2026 11:38:20 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov5647: fix power cleanup on remove
Message-ID: <aqz4fLrtW3f7OoYk@kekkonen.localdomain>
References: <20260915090457.2342778-1-lgs201920130244@gmail.com>
 <CAPY8ntA2h_ChCWJbAmCVygYiviTdsd9TA2LcVh5ffto__LgZAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntA2h_ChCWJbAmCVygYiviTdsd9TA2LcVh5ffto__LgZAg@mail.gmail.com>

Hi Dave,

On Thu, Sep 17, 2026 at 02:27:30PM +0100, Dave Stevenson wrote:
> Hi Guangshuo
> 
> On Tue, 15 Sept 2026 at 10:05, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> >
> > ov5647_remove() disables runtime PM without powering off the sensor if
> > it is still runtime active or updating the runtime PM state to
> > suspended.
> >
> > pm_runtime_disable() prevents further runtime PM callbacks and waits for
> > pending operations, but it does not force the runtime suspend callback
> > to run. If the sensor is active when the driver is removed, the external
> > clock and regulators can remain enabled and the power-down GPIO can
> > remain deasserted.
> >
> > After disabling runtime PM, call ov5647_power_off() if the device is not
> > already runtime suspended, and then mark the runtime PM state as
> > suspended. Checking the runtime status avoids disabling the hardware
> > resources a second time when runtime PM has already powered off the
> > sensor.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/media/i2c/ov5647.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > index 3facf92b3841..d42d009772ac 100644
> > --- a/drivers/media/i2c/ov5647.c
> > +++ b/drivers/media/i2c/ov5647.c
> > @@ -1271,6 +1271,9 @@ static void ov5647_remove(struct i2c_client *client)
> >         v4l2_ctrl_handler_free(&sensor->ctrls);
> >         v4l2_device_unregister_subdev(sd);
> >         pm_runtime_disable(&client->dev);
> > +       if (!pm_runtime_status_suspended(&client->dev))
> > +               ov5647_power_off(&client->dev);
> > +       pm_runtime_set_suspended(&client->dev);
> 
> I was unsure whether pm_runtime_set_suspended can be unconditional or
> should be in the if clause. There are numerous drivers doing each.
> 
> As it happens, Sakari's just answered that in [1] that it should be
> conditional, so I'd take that as gospel. It looks like he's given a
> similar answer on your ov2740 patch.

Runtime PM is a bit mystical in some places. pm_runtime_set_suspended()
appears to be setting the device's Runtime PM state disabled as it name
implies, but it may also e.g. increment dev->power.disable_depth. I'm not
fully certain if this is by design or not.

-- 
Sakari Ailus
