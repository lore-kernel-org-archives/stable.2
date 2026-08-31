Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAC3D45EF;
	Mon, 31 Aug 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170220; cv=none; b=j2rGZHoAGCOeRm9yowJqaRTkKpZQ+jBE2A9fIXYwqeqpvk6EX9z1NSrgIpta83JowLXmZFl/BbyzJpWMH3Zri9RR53sTNNNNsfclg+mWDyq/No3E9e3lXk1z3orGywaak4nCi7Z4s/uTyOCfI37FJP1ESX7wv/pLEMAtGzfkIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170220; c=relaxed/simple;
	bh=7kSEl7dXRVSFOZzvngXyGnu7tMh/NV3u41UV4V06ztE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJWxxcLJxxos6FokipI69/jwwegjcmwK+bxgfaW9Fa08EOy6xxhAhZgqg04+xqbneGgnz4eij4bWOprJr7+MKN0RB6Ok9Bjlz2gylgzs0NCsglYGRLgXRo5PM1ooaMN3GT6ImdtnWbDDO4uooYaLuoL2MEjS0YVQLOyMp1hNRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw7VLvbz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw7VLvbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788170218; x=1819706218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7kSEl7dXRVSFOZzvngXyGnu7tMh/NV3u41UV4V06ztE=;
  b=iw7VLvbzNrZffiWB6evD3LSL/IPDTk/CVEvspAIbT8RH/+j5f/f0xRHk
   XV0ztY7Nbn1ijb2IQM0EmMaXvSiu4M7O0Ke8HDNe1q4d2tVMANk+S86z6
   8Z+VKjG/bpr5pGLgVzkdYBUNYRebdOVuBYC+VrvaKHFb8zwDRYvlgc1Hg
   b/3zwK6MCC2MY+D3yYahxhrzTKsEn8Qz50BuGmIAp0TmvQhYaJpONNi95
   SRwbab3TKmak4BFdYOWrMmOD+KiagWPDuqYIZr/7oYkl92pxx6jXnJPK9
   U89ptQtD/q1BoweIj457HEaaMNOpNLj3NMusR2YV/YXkM0MJad7P5/sh8
   A==;
X-CSE-ConnectionGUID: G4D4VkuQQfGQMC/UVSGVqg==
X-CSE-MsgGUID: 3Fg2CyGTR9OMD+X3cYXnhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92383851"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="92383851"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 02:56:57 -0700
X-CSE-ConnectionGUID: JXvBaMSLR3uT4fHbNVgeqw==
X-CSE-MsgGUID: 1WM8K0xtTBitmPWFKpaOrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272265346"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 31 Aug 2026 02:56:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 1399099; Mon, 31 Aug 2026 11:56:53 +0200 (CEST)
Date: Mon, 31 Aug 2026 11:56:53 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, bryan.odonoghue@linaro.org,
	gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: typec: qcom-pmic-typec: disable
 cc_debounce_dwork on stop
Message-ID: <apVP5VM_CCDmH6BS@black.igk.intel.com>
References: <20260819161950.77858-1-fanwu01@zju.edu.cn>
 <20260820135307.153773-1-fanwu01@zju.edu.cn>
 <20260820135307.153773-2-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820135307.153773-2-fanwu01@zju.edu.cn>

On Thu, Aug 20, 2026 at 01:53:06PM +0000, Fan Wu wrote:
> cc_debounce_dwork is queued from the set_cc() and start_toggling()
> callbacks, which run from TCPM's kthread worker.  port_stop() returns
> before tcpm_unregister_port() destroys that worker.  Flushing the worker
> during unregister may therefore run a callback which queues the delayed
> work after port_stop() has returned.
> 
> The delayed work can then run after devres has freed pmic_typec_port.
> 
> Use disable_delayed_work_sync() in port_stop() to cancel a pending
> instance and prevent the TCPM callbacks from queueing another one.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> index 429bd42a0..fdc379fc4 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> @@ -694,6 +694,8 @@ static void qcom_pmic_typec_port_stop(struct pmic_typec *tcpm)
>  
>  	for (i = 0; i < pmic_typec_port->nr_irqs; i++)
>  		disable_irq(pmic_typec_port->irq_data[i].irq);
> +
> +	disable_delayed_work_sync(&pmic_typec_port->cc_debounce_dwork);
>  }
>  
>  int qcom_pmic_typec_port_probe(struct platform_device *pdev,

-- 
heikki
