Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B644237B;
	Tue, 29 Sep 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670931; cv=none; b=ZYkB0+1RgtWw1Dblxqmoab+C13hKHdIxjLyarm6d0xPuRX5qjlYy7iTONMy+x+GamP9BuKdfxlcMidTurugcSrij1oeA2A5XPyqcrdr7f63+io+uzPbz1fKDLt6rZJAvmYoDnhf85mJKUbN2I3ZLs2QGDwmo4qPyu8rvM7mfYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670931; c=relaxed/simple;
	bh=kNdKZLl6i7jqrQV3FjlqFRTok3uN4f7E2c8tVW1je+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C69kGf5BpOiMpZk+ptqN78IGg6qNSye8N7hqRRJ17jy3JKpWbpA5e3uncwGVknVjlfbJXSdWAUhtIrej1AiaJ0RK2fDZO/nyA19U43MlbM1p5hjfW1/LeXW9An/O8CnHfXHNj6VXTgFqCpXfCX+a6asRH+h7f3wvzBKTX5Zm/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzv5DjUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzv5DjUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BE91F000FF;
	Tue, 29 Sep 2026 08:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790670926;
	bh=2NyRzIReUFpHHyp3XlwggkALVWJPA/gL7KG202E2vU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bzv5DjUYSZqxbWHy24p82D5CELfUCgHWSnWaAvnxovZhlX7ZEwP88pnXG7ARxlzzT
	 dezGTV1dC+/D5HDSKe0BjJW4Okyxd26ohnjCal4+9PLVat3dYe6HfY+7Vyp9gBSE/h
	 161zqvJE5i5xSizFkgxXoZdNX/G+OYgqPivPkvZTbUNu12gSnUpqG6DFIBsFsXbpeV
	 rRJeg21n2N2boDEpwDqOroqpFCL0sR8qQVycmV7+aREl+UYrQ9LXKMF+9pzsFSQOyx
	 G+ZQiRjD3caN1YIxcd5JU8H+122P3kKWHo0wFtyyJfNMOk+J5MhlSXyTDebY8QoRW0
	 NksM1glalOQ7Q==
Date: Tue, 29 Sep 2026 09:35:21 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: hand off fwnode ownership when shared
 fwnode owner is rejected
Message-ID: <20260929-abstract-accomplished-lynx-3edcbc@sudeepholla>
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
 <20260928-conscious-spectral-manul-19bc10@sudeepholla>
 <arsYvrYaQIr1lwbT@shlinux89>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arsYvrYaQIr1lwbT@shlinux89>

On Tue, Sep 29, 2026 at 09:47:42AM +0800, Peng Fan wrote:
> Hi Sudeep,
> 
> On Mon, Sep 28, 2026 at 01:09:08PM +0100, Sudeep Holla wrote:
> >On Mon, Sep 28, 2026 at 07:49:01PM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> When multiple devices share the same fwnode (e.g. the SCMI bus creates
> >> both "pinctrl" and "pinctrl-imx" devices for SCMI_PROTOCOL_PINCTRL), only
> >> the first device registered becomes the fwnode owner (fwnode->dev, set in
> >
> >This has been rejected in the past. Apart from the trigger in -next,
> >anything else has changed ?
> 
> When both pinctrl-scmi.c and pinctrl-imx-scmi.c are built into the
> kernel Image, both drivers call module_scmi_driver() at init time, which
> goes through:
>   scmi_driver_register()
>     → scmi_protocol_table_register(id_table)
>       → scmi_protocol_device_request()
>         → scmi_device_request_notifier()
>           → scmi_create_protocol_devices(fwnode, ..., "pinctrl-imx")
> So the on-demand path already creates both "pinctrl" and "pinctrl-imx"

Yes, but this particular device is i.MX specific issue as it should
have never been there. So I will discard that in any future discussion.
Use the SCMI pinmux driver and get rid of SCMI pinctrl-imx.

> devices for protocol@19, sharing the same fwnode, regardless of
> scmi_std_id_table. aac4e67d6eb9 just added a second path that does
> the same thing earlier - the fundamental problem existed before it.
> 
> This issue has been here for 2 years.

Thanks for clarifying this. You initial email seem to directly blame
the commit in -next. Please don't bring that commit into discussion then.
It was completely misleading.

> I proposed a patch in scmi side [1][2], but never made into mainline.
> [1] https://lore.kernel.org/all/CAGETcx87Stfkru9gJrc1sf=PtFGLY7=jrfFaCzK5Z4hq+2TCzg@mail.gmail.com/
> [2] https://lore.kernel.org/arm-scmi/ZryUgTOVr_haiHuh@pluto/
> 
> The issue is not specific to pinctrl w/o imx.
> 

Agreed. Perf/cpufreq is another possible issue you have brought up IIRC.
Since cpufreq must not have dependency like pinmux, we should be able to solve
it in some other way.

> The problem is that two devices share one fwnode, the first one registered
> claims fwnode->dev, and if it never binds, driver_bound() of the second
> device skips the dangling consumer pickup because fwnode->dev != dev.
> 

Agreed, but it shouldn't be the normal case unless there is a strong need
and there is the dependency you mention or you mess up by creating duplicate
devices like pinmux-imx. That's you own doing, sorry.


[...]

> >
> >Does dropping i.MX specials from list of devices solves the problem ?
> 
> No - dropping "pinctrl-imx" from scmi_std_id_table would not fix it
> when both drivers are built-in, because scmi_protocol_device_request()
> from the driver registration path still creates both devices.
> 

OK, thanks for the confirmation.

> >I am more than happy to drop i.MX special in the code and let you
> >sort the pinmux mess you guys have created.
> 
> I understand the concern about platform-specific code in the standard
> table. But the issue is not specific to pinctrl-imx - it is a generic
> fw_devlink gap that affects any bus creating multiple devices per fwnode.
> The same structural pattern exists for SCMI_PROTOCOL_PERF ("perf" +
> "cpufreq") and SCMI_PROTOCOL_SENSOR ("hwmon" + "iiodev").
> 

Yes perf/cpufreq case I recall and we should be able to work out something.
Sensor has no dependency like pinmux and shouldn't be a problem. Have you
faced real issue with it ?

> Cristian also shared his insights before, in [3].
> 
> "
> ....while other drivers exists that share the usage of the same protocol
> (HWMON/IIO GENPD/CPUFREQ), they use the same protocol to achieve different
> things in different subsytems...and they are anyway impacted (even to a less
> degree) by this fw_devlink issue AFAIU so the problem indeed exist also
> out of pinctrl-imx
> "
> 
> [3] https://lore.kernel.org/all/Z65U2SMwSiOFYC0v@pluto/
> 

I agree and that's what I mean above.

> >
> >And also I remember you creating situation disabling cpufreq in the cmdline.
> >Will that be ever used on those i.MX platforms ?
> 
> For the PERF pair, both drivers bind successfully today so there is no
> issue in practice. But if "perf" (the fwnode owner) fails probe while
> "cpufreq" binds, the same fwnode ownership deadlock occurs. This is not
> about disabling cpufreq - it is about the owner device failing to bind
> for any reason.
> 

Thanks for the explanation.

> >
> >I am not against the patch if others are OK.
> 
> Thanks. The patch fixes a generic fw_devlink gap in driver_bound()
> where a device binding successfully on a shared fwnode cannot resolve
> dangling consumers of child fwnodes because it is not the fwnode owner.
> The fix follows the existing fwnode->dev ownership discipline (only
> writing fwnode->dev when it is NULL, owned by self, or owned by a
> driverless device) and handles all three scenarios:
> 1. Owner probe rejected (-ENODEV/-ENXIO) - owner hands off in
> really_probe() failure path
> 2. Owner rejected earlier, fwnode now unowned - sibling re-acquires
> in driver_bound()
> 3. Owner's driver never compiled/loaded - sibling takes over from
> driverless owner in driver_bound()
> 
> 
> If driver core maintainers have better solution for the case that
> multiple devices share one fwnode, I would appreciate.
> 

IIRC, they don't want to use 2 device pointing to same fwnode.

-- 
Regards,
Sudeep
