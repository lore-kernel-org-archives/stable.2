Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7033DC4B3;
	Wed, 16 Sep 2026 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551305; cv=none; b=ghnj9LBLCsde7/1U1OI7hEMPv/F5GjQrRrUnBnZo03FX0XGyOP3qXxy6zyc/ELSYqmRVxs65y0R0gRsmudBk6h4486dI+A/VIkbW1MrmrrTmPl7s5/HGXUsEm6lf7lxVn0Ulv/XG3vv9ajwucVlWMPh1fTDt8pmRD38IyiP5tbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551305; c=relaxed/simple;
	bh=0oD5ioeqPruUzy3aqf8ovAMYYlDIuCz+XGpp5PFXAsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7jQfTZZR4cbMtVazKnyhqV6PiRAR4NJiN3ZDQnwOmAZcgThwo5nIIpBRlL8XRvcP1G7mc+XM1OM6O++BZVRchhDonwj797DduNcqqxRZDnqLMD6LFe3m4p4be1wRduaNfKZ/wpfCg9eRBaXdeAoyw+RxHchjqYlEGzRllihWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RecnCrCU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RecnCrCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789551303; x=1821087303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0oD5ioeqPruUzy3aqf8ovAMYYlDIuCz+XGpp5PFXAsM=;
  b=RecnCrCUC2NSvtXRZI7tDDAhLK9fed8mJoMklnUwzqmu29xx1SQ8E7hI
   5HZa+Mdt4gH/iD4UbhfPeW1Uk10eVGz1sqYJdh7HHhvDX9ZcQQFTUpzxZ
   uSW2ExbfTgJAcLqgEir0B4hr/S787LvmoUlzwI0qU0eB7CvTOz3/uaSbr
   H1V4BOOaoXVCWihN355qmMhojYVZza1W4jGKo6KE8A+LhwmV2sSE3jvdJ
   A/5sek6XicxBnCnrLos7zTwkjmqrf1LWcFsbJc+1ekl6WkxSOh1SUX+Dj
   9oseWIwpnCTiaf2PVLzSm5HyGUdCY7u4zIIA8mNsT3Si5j69krv1jI7f/
   g==;
X-CSE-ConnectionGUID: tKQVad/6TqivifJJzxc9/g==
X-CSE-MsgGUID: VTPtSVEEQfebEPHVNwgEuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89947401"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89947401"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:34:59 -0700
X-CSE-ConnectionGUID: FlqYCv9DRxyA6zu82/JZNg==
X-CSE-MsgGUID: wwMV4RCFRdunX+LivshwOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1686942"
Received: from aschende-mobl.amr.corp.intel.com (HELO alaakso-desk) ([10.125.108.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:34:56 -0700
Date: Wed, 16 Sep 2026 12:34:52 +0300
From: Antti Laakso <antti.laakso@linux.intel.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Miguel Vadillo <miguel.vadillo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: cvs: Get the wake IRQ without claiming the
 GPIO
Message-ID: <aqpivLIxfxcZSj30@alaakso-desk>
References: <20260908105717.496232-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908105717.496232-1-junjie.cao@intel.com>

On Tue, Sep 08, 2026 at 06:57:17PM +0800, Junjie Cao wrote:
> The wake line is only used as an IRQ source, yet the driver requests
> it with devm_gpiod_get() before the I2C handshake. Where ipu-bridge
> does not expose the CSI endpoints, CSI init returns -EPROBE_DEFER and
> every retry claims the line again for the length of the handshake.
> 
> On the Dell XPS 14 DA14260 (Panther Lake) the four CS35L57 amplifiers
> read their speaker ID from one GpioIo (DSDT decoded in the second
> link):
> 
>   GpioIo (Shared, PullNone, 0, 0, IoRestrictionInputOnly,
>           "\_SB.GPI1", 0, ResourceConsumer,,) {20}
> 
> A request that lands while another consumer holds the line fails, and
> cs35l56 does not retry:
> 
>   cs35l56 sdw:0:2:01fa:3557:01:2: error -EBUSY: Failed to get spk-id-gpios
> 
> All four fail on Fedora 7.1.13, the first Fedora 7.1 kernel with the
> driver enabled; the same board on 7.1.12 without it creates the card.
> The second link shows the same failure on openSUSE 7.2.2, whose
> config also enables the driver.
> 
> The INTC10E1 _CRS of this machine has not been decoded. The vendor
> driver in intel/vision-drivers requests req, resp and rst the same
> way but maps wake to an IRQ with acpi_dev_gpio_irq_get_by() without
> requesting it, and on another DA14260 (board 0VRKYR, BIOS 1.8.2) a
> build of it is bound while the amplifiers probe. The wake entry is
> the line that differs.
> 
> Take the IRQ from the GpioInt entry the same way, as the I2C core
> does for client->irq; this also applies the trigger type from _CRS.
> The driver binds as a platform device too, hence the explicit lookup.
> 
> Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2529031
> Link: https://github.com/thesofproject/sof/issues/11152
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---

Tested-by: Antti Laakso <antti.laakso@linux.intel.com>

>  drivers/media/i2c/cvs/core.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/i2c/cvs/core.c b/drivers/media/i2c/cvs/core.c
> index d4a3b9c3bab1e..8d857bbd8ab51 100644
> --- a/drivers/media/i2c/cvs/core.c
> +++ b/drivers/media/i2c/cvs/core.c
> @@ -725,8 +725,6 @@ static int cvs_core_probe(struct device *dev, struct i2c_client *i2c)
>  	}
>  
>  	if (ctx->res == ICVS_FULLCAP) {
> -		struct gpio_desc *wake;
> -
>  		ctx->rst = devm_gpiod_get(dev, "rst", GPIOD_OUT_HIGH);
>  		if (IS_ERR(ctx->rst)) {
>  			ret = dev_err_probe(dev, PTR_ERR(ctx->rst),
> @@ -734,14 +732,12 @@ static int cvs_core_probe(struct device *dev, struct i2c_client *i2c)
>  			goto err_put_ipu;
>  		}
>  
> -		wake = devm_gpiod_get(dev, "wake", GPIOD_IN);
> -		if (IS_ERR(wake)) {
> -			ret = dev_err_probe(dev, PTR_ERR(wake),
> -					    "failed to get wake GPIO\n");
> -			goto err_put_ipu;
> -		}
> -
> -		ctx->irq = gpiod_to_irq(wake);
> +		/*
> +		 * Do not request the line: another device's _CRS may list
> +		 * the same pin, and its driver would then fail with -EBUSY.
> +		 */
> +		ctx->irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev),
> +						    "wake", 0);
>  		if (ctx->irq < 0) {
>  			ret = dev_err_probe(dev, ctx->irq,
>  					    "failed to get wake IRQ\n");
> -- 
> 2.43.0
> 
> 
