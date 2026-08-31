Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E93E2756;
	Mon, 31 Aug 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170280; cv=none; b=l1qMcd1Rw1kHmFmcNtUpuoCv4XfYZpSx+/5O5yUNHdT56y+oRPRmc6mBhllaksGURNb9X07O1w26hOakXhuL8vTcWHkmqAvxd/EC5ZZcxmAVUMPD7RYfsFSUy6D7KRIcBnPGJTaUziyiQWQiEVwt91S1TUBZIXkWLQKU95WRno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170280; c=relaxed/simple;
	bh=ggP8rmDJ1VI0kO6CwY54v3jJgVBsVzO2YmkvwuOCfh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxMMjvpiJPsS8emyWcBchs9HwwxNsV8IUaaNoQI9Mna2SZOaoEi9iIiFJmHnD29WAcbJ2k4sdOQ+McYQx1pS6qMPgNYN8NUQq0PeAmmrOFNmpNFMBLV4WSxQMx6ojv5TilJAjPmxENCdBbxbJ2+fT8PlWTzk2mgTalt1HIh2aY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhHn9yVv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhHn9yVv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788170277; x=1819706277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ggP8rmDJ1VI0kO6CwY54v3jJgVBsVzO2YmkvwuOCfh0=;
  b=YhHn9yVvVb5OyXwbuoyDYyQ8pouc2GXZ7P/2mSesuZIbjT2nwvLX0L2+
   oXKK5hYX5S0MJIX4NClNPnfPRuzqbcsKePGOAddjy/9+dX0d9BvXkCoKd
   33MsnWNxSJyJQ2RbyVrBDznshxnOP1k/eQw2pPUD/wf1cuZiHgFder/X4
   ujv68dQlOjzkcT9/XMlE0EV2IP+bWSGpbAG7fSJooZY5kslJkp1Y3DzEX
   j+DgSFfJvPFF+ssyMlHBpK24LGwixbqu4BJhbUq0vl0wpRozbtcx5fa3D
   18gjC8zsOYOGArZgrx26TMnfyoXzcvZXs7TwEAO9jXl2ZNkMWtYTEB2pb
   A==;
X-CSE-ConnectionGUID: sSdrWjiYRFmp5V51XMT/zQ==
X-CSE-MsgGUID: TVoAIvrFRa2n0czYXQbTvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92384045"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="92384045"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 02:57:49 -0700
X-CSE-ConnectionGUID: wwftChZCTKmAw2rKA26LuA==
X-CSE-MsgGUID: GrDlps4HT6OVhQupKCKsdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272265513"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 31 Aug 2026 02:57:47 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 3786399; Mon, 31 Aug 2026 11:57:46 +0200 (CEST)
Date: Mon, 31 Aug 2026 11:57:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, bryan.odonoghue@linaro.org,
	gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: qcom-pmic-typec: drain
 cc_debounce_dwork if port_start() fails
Message-ID: <apVQGgz5iSu1Krws@black.igk.intel.com>
References: <20260819161950.77858-1-fanwu01@zju.edu.cn>
 <20260820135307.153773-1-fanwu01@zju.edu.cn>
 <20260820135307.153773-3-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820135307.153773-3-fanwu01@zju.edu.cn>

On Thu, Aug 20, 2026 at 01:53:07PM +0000, Fan Wu wrote:
> cc_debounce_dwork can be queued before port_start() fails:
> tcpm_register_port() runs first, and its state machine may invoke
> set_cc() or start_toggling() from the TCPM worker.  The error path then
> calls tcpm_unregister_port(), whose worker flush may queue the delayed
> work before devres frees pmic_typec_port.
> 
> Disable and drain the delayed work directly at port_start()'s error
> exit.  Do not use port_stop() for this path: its IRQs use IRQF_NO_AUTOEN
> and are enabled only after a successful port_start().
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Cc: stable@vger.kernel.org # v6.10+
> Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> index fdc379fc4..53c143364 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> @@ -684,6 +684,9 @@ static int qcom_pmic_typec_port_start(struct pmic_typec *tcpm,
>  		enable_irq(pmic_typec_port->irq_data[i].irq);
>  
>  done:
> +	if (ret)
> +		disable_delayed_work_sync(&pmic_typec_port->cc_debounce_dwork);
> +
>  	return ret;
>  }
>  

-- 
heikki
