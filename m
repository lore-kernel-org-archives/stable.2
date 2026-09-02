Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C043ACA42;
	Wed,  2 Sep 2026 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332285; cv=none; b=UY/SpPkIB4EXOghfsz4HJFedU0J1cjj1p4VbHhKh9PgFc24JaCQDWOsbtkQlrdw9t6/06XeApaQWmNgsUpaoncHpeBv2CEPNTNGRLEEzDl1F6Xvu3ku0mXBSMuJ2ctJRTp3YxqIDEqSjb/EpxIUnDSZZSslq9+drOeNBZflZoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332285; c=relaxed/simple;
	bh=e4aeHQLForUGeICWn8YcbeYmVyJDYBsfKrglCLZcX5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1g072lpXCfAHKUb6MdCk4ObdYv5N4LnJ1r0nQ/GxQAkIm1m7avwv9Wv5eYIxYqMJythEBaFR6+dugFWX84We3e9nKRhEyy7Xjlw3tkIbk6B7g0Y9u9ExZkDEO0LUfX+AAi2quxnDRoOw3/OL7RCaH9bHXyjqCRKdatr/FApRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h41kCLV9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h41kCLV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788332281; x=1819868281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e4aeHQLForUGeICWn8YcbeYmVyJDYBsfKrglCLZcX5E=;
  b=h41kCLV9lQ146h/AZ5tKzRUb/p1K8Mj8HgAGLpkuXP8Z/uSdhkfBIc0M
   XqdtZS8ayNyDdTcpyr3s+RDypH8IxYwWfzQ0CBg92X6BSIyGCHwc9pF89
   yUfMnPghSdqUn8RPPfZdFyXlAazXWLETkZooMdNq0fa4DcT5V/zX2iisi
   wfyugg6KoIJny2Ais4WpUO9z7IwJLCQQGbq+t4WeW7f8lV9aB8/F6Rvf+
   OEm5Hg8gC2vop+XuyJmlo+mjYeG51/aAJ2xsGlUyOX3HLI5RSmYe5EG65
   I6shNEze35KnVAkhX1ECrKE5btf3KBaTTtd5LCpTRBrYNIi8k3wBlt2y+
   A==;
X-CSE-ConnectionGUID: p+ZZOib5RA6+t5dlw/E6kg==
X-CSE-MsgGUID: t0/dMcODRcqMsnkUtNocoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106149936"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106149936"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:57:57 -0700
X-CSE-ConnectionGUID: sv/VzFgBRW6bL6cH2M8gRQ==
X-CSE-MsgGUID: XTbmVp9BR+KPVQmabhCLyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="274585986"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.129])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:57:54 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id AF53E1218BD;
	Wed, 02 Sep 2026 09:57:50 +0300 (EEST)
Date: Wed, 2 Sep 2026 09:57:50 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sergey Zagursky <gvozdoder@gmail.com>
Cc: Miguel Vadillo <miguel.vadillo@intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] media: ipu-bridge: do not use the CVS device lookup for
 IVSC
Message-ID: <apfI7m2oD-k5GOYN@kekkonen.localdomain>
References: <20260901194526.6369-1-gvozdoder@gmail.com>
 <20260901195036.7648-1-gvozdoder@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901195036.7648-1-gvozdoder@gmail.com>

Hi Sergey,

On Tue, Sep 01, 2026 at 08:50:36PM +0100, Sergey Zagursky wrote:
> Since commit c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU
> bridge driver") the internal camera no longer works on laptops where the
> sensor sits behind an IVSC, for example a Dell XPS 16 9640 (IPU6,
> INTC10CF, ov02c10):
> 
>   intel-ipu6 0000:00:05.0: Found supported sensor OVTI02C1:00
>   intel-ipu6 0000:00:05.0: Connected 1 cameras
>   ivsc_csi intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: mei-csi probed
>       without device fwnode!
> 
> No sensor subdevice is registered, the media graph has no sensor entity
> and userspace finds no camera at all.
> 
> ipu_bridge_get_ivsc_csi_dev() first looks for the platform device named
> "intel_vsc" and returns its mei-csi child. That device is created by
> mei_vsc, which on this machine only appears once the LJCA USB bridge and
> its SPI controller have probed, about a second after the IPU6 probe that
> runs the bridge:
> 
>   07:59:29.297  platform INTC10CF:00 created (ACPI scan)
>   07:59:41      intel-ipu6 probe -> ipu_bridge_init()
>   07:59:42.391  platform intel_vsc created (mei_vsc)
> 
> The commit above added two fallbacks for CVS which match on the ACPI
> companion alone. They are reached for every entry of ivsc_acpi_ids[],
> IVSC IDs included. The IVSC ACPI device has two physical nodes:
> 
>   INTC10CF:00/physical_node  -> platform/INTC10CF:00  (no driver bound)
>   INTC10CF:00/physical_node1 -> platform/intel_vsc    (mei_vsc)
> 
> so bus_find_device_by_acpi_dev(&platform_bus_type, adev) returns the bare
> platform device. ipu_bridge_instantiate_ivsc() then attaches the IVSC
> software node to that device instead of to the mei-csi client, the bridge
> reports success, and the probe is never retried. mei_csi later probes
> without a fwnode, the CSI-2 link is never described, and the sensor ACPI
> device, which has an honoured _DEP on the IVSC device, is never
> enumerated.
> 
> Before those fallbacks existed the lookup returned NULL here, the bridge
> failed with -ENODEV and the probe was retried once the IVSC device had
> shown up.
> 
> Restrict the two fallbacks to the CVS IDs. CVS binds a driver to the ACPI
> device itself, so matching on the companion is unambiguous there.
> 
> Fixes: c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU bridge driver")
> Link: https://lore.kernel.org/linux-media/20260901194526.6369-1-gvozdoder@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code:claude-opus-5
> Signed-off-by: Sergey Zagursky <gvozdoder@gmail.com>
> ---
> Tested on the affected machine (Dell XPS 16 9640, IPU6 + IVSC + ov02c10) on
> top of 7.2.2, where drivers/media/pci/intel/ipu-bridge.c is byte-identical
> to v7.2. Without the patch libcamera finds no camera at all; with it:
> 
>   $ cam -l
>   1: Internal front camera (\_SB_.PC00.LNK1)
> 
>   $ cam -c1 --capture=5
>   202.794954 (30.05 fps) cam0-stream0 seq: 000003 bytesused: 8386560
>   202.828224 (30.06 fps) cam0-stream0 seq: 000004 bytesused: 8386560
> 
> The media graph gains the entities that were missing:
> 
>   - entity 349: Intel IVSC CSI (2 pads, 2 links, 0 routes)
>   - entity 368: ov02c10 21-0036 (1 pad, 1 link, 0 routes)
> 
> and the restored retry is visible in dmesg:
> 
>   pci 0000:00:05.0: deferred probe pending: intel-ipu6: IPU6 bridge init failed
>   intel-ipu6 0000:00:05.0: Found supported sensor OVTI02C1:00
>   intel-ipu6 0000:00:05.0: Connected 1 cameras
> 
> "mei-csi probed without device fwnode!" is gone, ov02c10 binds to
> i2c-OVTI02C1:00, and eight v4l-subdev nodes appear.
> 
> This patch is against v7.3-rc1. The version tested on 7.2.2 is the same
> change without the INTC10FA entry, which 7.2.x does not have. Building
> drivers/media/pci/intel/ipu-bridge.c with W=1 produces no new warnings.
> 
> Not covered: I have no CVS hardware, so the CVS path is only reasoned
> about, not tested, and I have not booted v7.3-rc1 itself.
> 
> This patch was produced with the help of an AI coding assistant; see the
> Assisted-by tag above and Documentation/process/generated-content.rst. The
> bug report this replies to describes what the tool did.
> 
>  drivers/media/pci/intel/ipu-bridge.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index 1bb3a3e98d6b..2c3b9efb0b2f 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -232,6 +232,15 @@ static const struct acpi_device_id ivsc_acpi_ids[] = {
>  	{ "INTC10FA" }, /* NVL */
>  };
>  
> +/* The subset of ivsc_acpi_ids[] which are CVS, rather than IVSC, devices. */
> +static const struct acpi_device_id cvs_acpi_ids[] = {
> +	{ "INTC10DE" }, /* LNL */
> +	{ "INTC10E0" }, /* ARL */
> +	{ "INTC10E1" }, /* PTL */
> +	{ "INTC10FA" }, /* NVL */
> +	{ }
> +};
> +
>  static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
>  {
>  	unsigned int i;
> @@ -283,6 +292,17 @@ static struct device *ipu_bridge_get_ivsc_csi_dev(struct acpi_device *adev)
>  		return csi_dev;
>  	}
>  
> +	/*
> +	 * The lookups below match on the ACPI companion alone. That is fine for
> +	 * CVS, which binds a driver to that very device, but not for IVSC: there
> +	 * the ACPI device also has a driverless platform device, which would be
> +	 * returned instead of the mei-csi client. Return NULL for IVSC so that
> +	 * the caller fails and the probe is retried once the IVSC device shows
> +	 * up.
> +	 */
> +	if (acpi_match_device_ids(adev, cvs_acpi_ids))
> +		return NULL;

I can confirm there's indeed an issue here. But considering the list
contains the CVS device HIDs, doesn't it mean you're returning NULL here
for CVS, i.e. not for IVSC?

> +
>  	/* Try to locate CVS device on the I2C bus */
>  	csi_dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
>  	if (csi_dev)

-- 
Regards,

Sakari Ailus
