Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAC369D64;
	Mon, 24 Aug 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570550; cv=none; b=Q1O/HYHNYMjFdbhwtAK81e/BT4a+cqgCqeL4y3QwEXC6FI6ukY36EshwdymUYAOcqMyHGvcLVW1+icGRXEphyjYxSKGa9bbjyDtG1/8nlpN2OAFX6JyvsCcgehz4VV7pt4UHlfDMWCzyQTr0184mkQAebFgctfyqce2aoAS0XiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570550; c=relaxed/simple;
	bh=GxNf1H16VO6sS50tTEr7AHCYWZ7TVFYSYfLtGWfkUbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYElrhbhtB4Q9yXqe2wsmndZHNn7BRJ3UbYKOWvcNZJoDvdZau4WYrSE2nhupkn2Jkdj/E4au3pgAcAMGRRGNjEMgeisTKEZ9h//zoUqmtit9aS4BduBINIj/Nf81zgiQtXVsFmn6PrqwLz5bZqXbbsFwvLcbM9CUG0t6lxQtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMLjgOxC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMLjgOxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787570548; x=1819106548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GxNf1H16VO6sS50tTEr7AHCYWZ7TVFYSYfLtGWfkUbQ=;
  b=VMLjgOxCo4XwV8UIGjE64Kgnaurbymg+SsWySzuE0gS3I5KC0Oy27NQj
   oFSrOurT1M04QRVPaxUfd5nG9ggsCJjGvOWEtVuTLuo6Bia8r9AfR97zk
   X7L/jI14kgi32t6JWIjx9b9qW9OGjqGeJaufdFfTXJRfxNaFAgC66azjc
   67c0xINOnjPmHzPu7Bzp9Wjjy8LuwtGhBtR1UOTdLL9Fx46BDcPmjmdMq
   J16q0dYsNuabgrmedIo8k79WgH6LbtGFCC5rJT+HgdQxYMB440/OSPI3g
   Aco/I6k0SxFiNoR179fN0sRp7yJdM0f4hZFCq9PZDuAtNtZcnaqZ/4B4R
   A==;
X-CSE-ConnectionGUID: MJAdZpF/QSC/izPb2kYgSA==
X-CSE-MsgGUID: 1uybE1sCRNuu6bRgXbYg+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91832012"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="91832012"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 04:22:27 -0700
X-CSE-ConnectionGUID: a+wj8XdmRDCMXOsorLVefA==
X-CSE-MsgGUID: QUcP43ggRXKKhYwR4QnXxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="260827468"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 24 Aug 2026 04:22:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 14BC899; Mon, 24 Aug 2026 13:22:25 +0200 (CEST)
Date: Mon, 24 Aug 2026 13:22:25 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, bryan.odonoghue@linaro.org,
	gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: qcom-pmic: cancel reset_work on stop
Message-ID: <aowpcQnisJNRNh29@black.igk.intel.com>
References: <20260819161448.76597-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819161448.76597-1-fanwu01@zju.edu.cn>

On Wed, Aug 19, 2026 at 04:14:48PM +0000, Fan Wu wrote:
> pdphy_stop() disables IRQs but leaves reset_work pending.  If the IRQ
> handler schedules it just before disable_irq(), the work runs after
> remove() frees the struct via devm.
> 
> Call cancel_work_sync() after disabling IRQs to close the window.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index c8b1463e6..abb9d0321 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -544,6 +544,8 @@ static void qcom_pmic_typec_pdphy_stop(struct pmic_typec *tcpm)
>  	for (i = 0; i < pmic_typec_pdphy->nr_irqs; i++)
>  		disable_irq(pmic_typec_pdphy->irq_data[i].irq);
>  
> +	cancel_work_sync(&pmic_typec_pdphy->reset_work);
> +
>  	qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
>  
>  	regulator_disable(pmic_typec_pdphy->vdd_pdphy);

-- 
heikki
