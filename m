Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E82443E2F;
	Thu, 24 Sep 2026 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246809; cv=none; b=uvO19ZBrMaj4GSdgKLJTR5ISPxuyV4fejz7iI1xO3OfRoELyBnwEXBvmXAYFneJchCjgMti2Qxm8NUs8pJ7mLBj2AhTlulH0IJXlBfm3sUdEYbNN3z2IfbRGLRXBCbZvTLmBnnWJmzPApWzC/wG8TraqBdo2eJYYRoxXCGZh44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246809; c=relaxed/simple;
	bh=eaWL2h8Hpmi30o6OOQtUlx/jxVxVoJEHENQby8iP7PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8OlVEBXckbeFzWjJ4dfYn5QGG1xC1348pJ8MIg8fcUbYjgQKdCwzIGrQHs04Vqoye6PjA+jdOZD8GFn/b6EszIwtl6cM85r9ZMC2uBnqvm6W7nGuAamp4Tuv4BlzzGydDXsuZb8XwoFZYo25i5no6XHC7+AeE2PblrOYzYlipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5iVS+Ma; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5iVS+Ma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790246807; x=1821782807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eaWL2h8Hpmi30o6OOQtUlx/jxVxVoJEHENQby8iP7PE=;
  b=F5iVS+MasSoTZ6ibuiMrxUoImNR6NBxgqEAKhbyTxinrOawEu2ZEPQvD
   qYXh7ECywA17OYfjoJjC+KNDY9zgBFAXClqGLb1O/nETfEL+xUNhlQYjg
   CebRL0wPBq4DjPtAgI4ZMdOFIH6vzA9eM5P7zYay1You0zYlWORjaJF/D
   9gcgBNVEDZtaUgdOYfwuWgZFigsLOivxlrRP0gvdlYtzsnwSkcuBArFxq
   mETHjA03uFhBEqITY/ahVogz9TQSQB2pgjdAzgfa1u1UPLStUpfXPxQCA
   ys7dHm+oiR8kTdoZKJGYtoArblFzLml2oTIQuF0K4AChn1muV7pi9nu4z
   A==;
X-CSE-ConnectionGUID: AVbiwCT2QlqTKqo+otU8hA==
X-CSE-MsgGUID: FMgvTI/sSu2Su8NvttWO4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78566118"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="78566118"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 03:46:46 -0700
X-CSE-ConnectionGUID: feHLpaJxTX6z44I2xgF1CA==
X-CSE-MsgGUID: X2M2W33FQICBHhwctdspWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="282081457"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.155])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 03:46:44 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7C28E11F9B7;
	Thu, 24 Sep 2026 13:46:44 +0300 (EEST)
Date: Thu, 24 Sep 2026 13:46:44 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Felipe Calliari <calliarifelipe@gmail.com>
Cc: linux-media@vger.kernel.org,
	Antti Laakso <antti.laakso@linux.intel.com>,
	"Sapre, Sarang" <sarang.sapre@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tomas Moro <tmorolias@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] media: ipu6: Only call the isys and psys ISRs for
 their own interrupts
Message-ID: <arT_lPROASv1Ps8l@kekkonen.localdomain>
References: <20260923234224.325504-1-calliarifelipe@gmail.com>
 <20260923234224.325504-3-calliarifelipe@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923234224.325504-3-calliarifelipe@gmail.com>

Hi Felipe,

Thanks for the patch.

On Wed, Sep 23, 2026 at 08:42:24PM -0300, Felipe Calliari wrote:
> ipu6_buttress_isr() calls the isys and psys ISRs on every buttress
> interrupt, and only afterwards checks whether the interrupt was theirs.
> So each isys interrupt also runs the psys ISR, and each psys interrupt
> runs the isys ISR, only to have the result discarded.
> 
> Beyond the wasted work, this makes an interrupt for one device
> dereference the other device's hooks. After intel_ipu6_psys is unloaded,
> its adev->auxdrv_data still points into the unloaded module, and every
> isys interrupt, e.g. on the next stream, calls through it. This matches
> a hard lockup without a trace reported on the first stream after
> unloading the psys driver. On a Samsung Galaxy Book3 Ultra,
> instrumenting the ISR showed that a 60-frame capture after
> "rmmod intel_ipu6_psys" would have made at least ten calls through the
> stale psys hooks. The same capture made none with this change, and
> captured all 60 frames.

The problem here is a dangling pointer. Can you also post a patch to set
that drvdata to NULL?

The above paragraph isn't relevant in the context of this patch.

> 
> Check the interrupt status bit before calling the ISR.
> 
> Reported-by: Mars-Wave <tmorolias@gmail.com>
> Closes: https://lore.kernel.org/linux-media/20260922063507.690-1-tmorolias@gmail.com/
> Fixes: ab29a2478e70 ("media: intel/ipu6: add IPU6 buttress interface driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Felipe Calliari <calliarifelipe@gmail.com>
> ---
>  drivers/media/pci/intel/ipu6/ipu6-buttress.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-buttress.c b/drivers/media/pci/intel/ipu6/ipu6-buttress.c
> index 63197f746..74c191d72 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-buttress.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-buttress.c
> @@ -369,11 +369,13 @@ irqreturn_t ipu6_buttress_isr(int irq, void *isp_ptr)
>  		writel(irq_status, isp->base + regs->irq_clear);
>  
>  		for (i = 0; i < ARRAY_SIZE(adev_irq_mask); i++) {
> -			irqreturn_t r = ipu6_buttress_call_isr(adev[i]);
> +			irqreturn_t r;
>  
>  			if (!(irq_status & adev_irq_mask[i]))
>  				continue;
>  
> +			r = ipu6_buttress_call_isr(adev[i]);
> +

No need for this newline.

>  			if (r == IRQ_WAKE_THREAD) {
>  				ret = IRQ_WAKE_THREAD;
>  				disable_irqs |= adev_irq_mask[i];

-- 
Regards,

Sakari Ailus
