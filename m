Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5E47AF43;
	Thu, 24 Sep 2026 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250374; cv=none; b=V85U+/hMGclZYC57JcFRteKEYAjRYrPC93oV25xzsMji2f+6ZbLDAbRyr/C7VClXdEYyEmrnHSm7kz1SWv1jFTc7MsiuM8kXE3x5n8NVLQxAi05rv0EeLu2FV3wjoPKlCZTJA6HA9zFF+5maetEHM9NqO2pQOmnW02f3IbGoOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250374; c=relaxed/simple;
	bh=AFnevkNG9mbXzu530+ZrB1iBf6/P7l2062ql6ElxH88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA+CHJNUOPr+TwALbjJtkLtPZhHEBaxiBg1nKI9OmDcrPMOeURclUKRAdczdJJBlhjTKt7qvKhIA1hhlokE6VTNNNOXGKW3F985xEEe8uIjJ/sZxCW/x9YgJlLQk/DcR/ZDU/NLIExY7Wr7ZQ7Zo9HQX5aBnNGrtzuo9y0NTOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnKuvbEV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnKuvbEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790250371; x=1821786371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AFnevkNG9mbXzu530+ZrB1iBf6/P7l2062ql6ElxH88=;
  b=YnKuvbEVwfCOjmZm7tVCMRR7Psv1K4kijDOCkDHyMyYm8TjQ9+GWbSeJ
   tQS+6txTaSCNQBdwy+BWCaT6ycKcz6/BuPcFut1jY7nbzMAzYXkfGA1OP
   ZRpbRHQryLJ+xaC/YhmYLCcs4E198JtOH+Ktb5vx292fxT4KWvLA9E9zY
   F6y3wX0Md+0DA165DifSZpPcQSRMOmFAcdsxVSDPzI7nISig5vsBoESKC
   gdffMPZIIXF7O8R5tiJoatqlfld8IaJvLlbxfa1m0ByI/OVcNCC+0Q1Bl
   jUZqPIF/OU+6iehbeSC4iOxl6vEJnmgfUyGzvmCFNDRO+FqA9LJQ/4xTN
   w==;
X-CSE-ConnectionGUID: V9GOE2wXS6KEg3shXbibmA==
X-CSE-MsgGUID: ymswVtkZRuSxZR3uVffpBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="116542326"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="116542326"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:46:09 -0700
X-CSE-ConnectionGUID: QDRMh5+oT4yoIdceSNE53g==
X-CSE-MsgGUID: lMnLbZVBQziVwhQyZOmzhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="272145249"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.155])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:46:07 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id CF7CF11F9B7;
	Thu, 24 Sep 2026 14:46:05 +0300 (EEST)
Date: Thu, 24 Sep 2026 14:46:05 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Felipe Calliari <calliarifelipe@gmail.com>
Cc: linux-media@vger.kernel.org,
	Antti Laakso <antti.laakso@linux.intel.com>,
	"Sapre, Sarang" <sarang.sapre@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tomas Moro <tmorolias@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] media: ipu6: Clear the isys ISR hooks when the isys
 driver goes away
Message-ID: <arUNfeaaokjYgP0z@kekkonen.localdomain>
References: <20260923234224.325504-1-calliarifelipe@gmail.com>
 <20260923234224.325504-2-calliarifelipe@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923234224.325504-2-calliarifelipe@gmail.com>

Hi Felipe,

On Wed, Sep 23, 2026 at 08:42:23PM -0300, Felipe Calliari wrote:
> isys_probe() points adev->auxdrv and adev->auxdrv_data at data in the
> isys module, and the buttress interrupt handler calls the isys ISR
> through them. Neither isys_remove() nor the probe error path clears
> them. Once intel_ipu6_isys is unloaded, any buttress interrupt
> dereferences memory of the unloaded module.
> 
> One way to hit this: the IRQ is shared, so with CONFIG_DEBUG_SHIRQ
> free_irq() runs the handler once more. If a buttress interrupt status
> bit is pending at that point, "rmmod intel_ipu6" after
> "rmmod intel_ipu6_isys" oopses:
> 
>   BUG: unable to handle page fault for address: ffffffffc8a00560
>   RIP: 0010:ipu6_buttress_isr+0x19b/0x370 [intel_ipu6]
>   Call Trace:
>    free_irq+0x16b/0x360
>    devres_release+0x37/0x80
>    devm_free_irq+0x42/0x70
>    ipu6_pci_remove+0x52/0xd0 [intel_ipu6]
> 
> This happened on a Samsung Galaxy Book3 Ultra. A module notifier added
> for testing confirmed that after "rmmod intel_ipu6_isys" the hook still
> points into the unloaded module, and that it is NULL with this change.
> 
> Set the hooks only after the last early return of isys_probe(). Clear
> them on the probe error path and at the end of isys_remove(), then
> synchronize_irq(). In the buttress handlers, read auxdrv_data once, so
> that a hook cleared concurrently is seen as NULL rather than
> dereferenced.
> 
> Fixes: f50c4ca0a820 ("media: intel/ipu6: add the main input system driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Felipe Calliari <calliarifelipe@gmail.com>
> ---
>  drivers/media/pci/intel/ipu6/ipu6-buttress.c | 15 ++++++++-----
>  drivers/media/pci/intel/ipu6/ipu6-isys.c     | 23 +++++++++++++++++---
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-buttress.c b/drivers/media/pci/intel/ipu6/ipu6-buttress.c
> index 105de1744..63197f746 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-buttress.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-buttress.c
> @@ -315,15 +315,20 @@ ipu6_buttress_ipc_send(struct ipu6_device *isp,
>  
>  static irqreturn_t ipu6_buttress_call_isr(struct ipu6_bus_device *adev)
>  {
> +	const struct ipu6_auxdrv_data *drv_data;
>  	irqreturn_t ret = IRQ_WAKE_THREAD;
>  
> -	if (!adev || !adev->auxdrv || !adev->auxdrv_data)
> +	if (!adev || !READ_ONCE(adev->auxdrv))
>  		return IRQ_NONE;
>  
> -	if (adev->auxdrv_data->isr)
> -		ret = adev->auxdrv_data->isr(adev);
> +	drv_data = READ_ONCE(adev->auxdrv_data);
> +	if (!drv_data)
> +		return IRQ_NONE;

This patch looks very much LLM-generated. Are the tags in
Documentation/process/coding-assistants.rst relevant for this?

I believe you need something more elaborate to guard against unbinding the
driver. Do note that we currently can't safely remove the ISYS driver if
the userspace isn't guaranteed to have no file handles open to the device
nodes related to the Media device and the related sub-device and video
device nodes.

> +
> +	if (drv_data->isr)
> +		ret = drv_data->isr(adev);
>  
> -	if (ret == IRQ_WAKE_THREAD && !adev->auxdrv_data->isr_threaded)
> +	if (ret == IRQ_WAKE_THREAD && !drv_data->isr_threaded)
>  		ret = IRQ_NONE;
>  
>  	return ret;
> @@ -436,7 +441,7 @@ irqreturn_t ipu6_buttress_isr_threaded(int irq, void *isp_ptr)
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(adev) && adev[i]; i++) {
> -		drv_data = adev[i]->auxdrv_data;
> +		drv_data = READ_ONCE(adev[i]->auxdrv_data);
>  		if (!drv_data)
>  			continue;
>  
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys.c b/drivers/media/pci/intel/ipu6/ipu6-isys.c
> index 08f29b678..15254e3e3 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/firmware.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irqreturn.h>
>  #include <linux/list.h>
> @@ -989,6 +990,18 @@ void ipu6_put_fw_msg_buf(struct ipu6_isys *isys, struct isys_fw_msgs *msg)
>  static const struct ipu6_auxdrv_data ipu6_isys_auxdrv_data;
>  static const struct ipu6_auxdrv_data ipu7_isys_auxdrv_data;
>  
> +/*
> + * The buttress interrupt handler calls into this driver through
> + * adev->auxdrv_data, which points into this module. Clear it once the
> + * device is torn down, and wait for a running handler to finish.
> + */
> +static void isys_unset_auxdrv(struct ipu6_bus_device *adev)
> +{
> +	WRITE_ONCE(adev->auxdrv, NULL);
> +	WRITE_ONCE(adev->auxdrv_data, NULL);
> +	synchronize_irq(adev->isp->pdev->irq);
> +}
> +
>  static int isys_probe(struct auxiliary_device *auxdev,
>  		      const struct auxiliary_device_id *auxdev_id)
>  {
> @@ -1006,9 +1019,6 @@ static int isys_probe(struct auxiliary_device *auxdev,
>  	if (!isys)
>  		return -ENOMEM;
>  
> -	adev->auxdrv_data = IS_IPU7(isp) ? &ipu7_isys_auxdrv_data :
> -					   &ipu6_isys_auxdrv_data;
> -	adev->auxdrv = to_auxiliary_drv(auxdev->dev.driver);
>  	isys->adev = adev;
>  	isys->pdata = adev->pdata;
>  	csi2_pdata = &isys->pdata->ipdata->csi2;
> @@ -1037,6 +1047,10 @@ static int isys_probe(struct auxiliary_device *auxdev,
>  
>  	dev_set_drvdata(&auxdev->dev, isys);
>  
> +	adev->auxdrv_data = IS_IPU7(isp) ? &ipu7_isys_auxdrv_data :
> +					   &ipu6_isys_auxdrv_data;
> +	adev->auxdrv = to_auxiliary_drv(auxdev->dev.driver);
> +
>  	isys_stream_init(isys);
>  
>  	cpu_latency_qos_add_request(&isys->pm_qos, PM_QOS_DEFAULT_VALUE);
> @@ -1065,6 +1079,7 @@ static int isys_probe(struct auxiliary_device *auxdev,
>  free_fw_msg_bufs:
>  	free_fw_msg_bufs(isys);
>  out_remove_pkg_dir_shared_buffer:
> +	isys_unset_auxdrv(adev);
>  	cpu_latency_qos_remove_request(&isys->pm_qos);
>  
>  	for (i = 0; i < IPU6_ISYS_MAX_STREAMS; i++)
> @@ -1094,6 +1109,8 @@ static void isys_remove(struct auxiliary_device *auxdev)
>  	isys_iwake_watermark_cleanup(isys);
>  	mutex_destroy(&isys->stream_mutex);
>  	mutex_destroy(&isys->mutex);
> +
> +	isys_unset_auxdrv(auxdev_to_adev(auxdev));
>  }
>  
>  static const struct ipu6_auxdrv_data ipu6_isys_auxdrv_data = {

-- 
Regards,

Sakari Ailus
