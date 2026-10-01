Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD70B3AE718;
	Thu,  1 Oct 2026 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894444; cv=none; b=IzCI+3XFnVyg/0uyhhW43AOEj5rTyQX//3Umgu4t1P2PDjnLn2AlofkJRKlJ9jX2C205WnYdP36YyPrWDxcUKrSfon4jpH8mze/vkPdk/YLRNn+AWmRD+dfqVntRtTl0nUHYMfcK+GXTxnCEAEkvfebn4jSjA/jNPdL/wApAWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894444; c=relaxed/simple;
	bh=ZN8RoTZg6K01nxxeJFAZR4JgG9STIYMvAUqfTbJwn8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqfeUASsDC/WkUvw2g/er4GkirJG2LHfEC+7yRfSbt9YSSuJwOY27kWGpVvADAxCvqOljIVJ87SQvR8Mkct7BSMBBULvlb0tJpZtRVSz3pjZj/dnN084I+PXDxWSzVn2+1dOSD5CGiRebq6QifVF8b7At6iwVYkmyVdSMHWpGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Np16BhZh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Np16BhZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790894442; x=1822430442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZN8RoTZg6K01nxxeJFAZR4JgG9STIYMvAUqfTbJwn8s=;
  b=Np16BhZhS83a9XWPvRctkirsskTeuyQYcxhDtn9zC41DGZMqeJDQbKYT
   T4fH8w/RzcU+TL7Lv9sGD3mCzjoRSDyN0zNQIyFx5JAvviBGA/C70dJjM
   1q7t5JYWUcvW8LYRHFy8LHyVwyZGCxMPntgMGfRnt/F2s3OIg6+ACsURO
   3v2xQRHwCLRVfzm6g9+ncbivCV+hOfm1A0Rk+jMBM54ERH+CWlAX/dkux
   ykamoPeLA4kcPr6xz3bMHnhSKPmOss3IkkXsSsNNJEhmSdnt7s+UyMYAo
   K7UkNoAwxpJI4TDxq6kdR/ET9Su8jAjjU/EmFQZ/6EFn2XZACHAr8+3Qj
   A==;
X-CSE-ConnectionGUID: d8RrBAVSQrC/OU7bJ3QC1w==
X-CSE-MsgGUID: mdYo8rowRhKcgfF3ahD1tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94377769"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="94377769"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:40:42 -0700
X-CSE-ConnectionGUID: kozJbeGQQH+NeUjkJc8c2A==
X-CSE-MsgGUID: h0sh4h/4T+q+qW5t0OJ2AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="273934360"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.244.120]) ([10.245.244.120])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:40:39 -0700
Message-ID: <b43b9d21-4134-4e4c-89d8-f867207b125e@linux.intel.com>
Date: Fri, 2 Oct 2026 01:40:37 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xhci: Reset controller on xhci shutdown
To: wenxiong@linux.ibm.com, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, wenxiong@us.ibm.com,
 Brian King <brking@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, Joel Stanley <joel@jms.id.au>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20261001222527.11742-1-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 10/2/26 01:25, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> Fixes kexec boot. Without a hard reset, some USB chips will fail to
> initialize in a kexec booted kernel.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
> ---
>   drivers/usb/host/xhci.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index a9e47e178c28..364bd61a4bd7 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -781,6 +781,9 @@ void xhci_shutdown(struct usb_hcd *hcd)
>   	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>   			"xhci_shutdown completed - status = %x",
>   			readl(&xhci->op_regs->status));
> +
> +	/* TI XHCI controllers do not come back after kexec without this hack */
> +	pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
>   }
>   EXPORT_SYMBOL_GPL(xhci_shutdown);
>   

Should be added to xhci-pci.c: xhci_pci_shutdown() instead.

Probably also limited to that specific TI xHC controller

Thanks
Mathias

