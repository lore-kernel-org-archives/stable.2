Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790F44CACA;
	Fri, 24 Jul 2026 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920371; cv=none; b=FUuLb4lIkKPimTYZAtUx4J+dCshuXyaoEnM39ZpQ9HVMHd0669Vz15eGFkPNkGmDvwZ73+A5hqbQhz6i3GJnAFXZbvPU7MojtHH2dlQRq19GKqE0rx2gAvF48JZf1P1zGPPTLtU+70equ6AKFJqO1yvB8ExLVVR7tZZVmJD9zJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920371; c=relaxed/simple;
	bh=8D9/Jq7XwqmSclISOGcdhs05jLgfixBqoILxtl4I8zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+LWEwwAdn0pzeN0oeDCrwETztxtVMMU5HIQB6HiqBGc46ZWigXd8NGyqn0wVvoApO1Ihc74VBz4U4FZhfOhoyLDEcuSMF0HSd8E4vSyvC/52sG2/d1xgIbAmdOOL9tLcQZmJoNxExqo8h61UzjKBR4+aDyLZ18tlNU9dAY6VmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLrJn8q/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLrJn8q/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784920369; x=1816456369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8D9/Jq7XwqmSclISOGcdhs05jLgfixBqoILxtl4I8zE=;
  b=mLrJn8q/n1t6wVWDXXApgMHSxmPhOKwK06BS5eSpT3PXU+roR8FNnYZc
   SvQzdz5sH7WKHQ80wJEvaKOE6nE/VZC3b3yK2b8HWPPl0C6JRo00UqF0x
   5xWQpYK6p1BDdWXgr66z6oMEu6l++mtAnXbROQxS8kGooRBP3U2ay2Cng
   IhTlJQK4dy67AzV8vFlPga05+THcXpsouAMopOJWJPygJhFpUpZSkMePS
   l5FC8LiN3ehVEYSf/kJbX64/pllInEGHeB0dhvj7WR7RXuVeq6LBUcgDB
   CQLXQj0PpLMTW94vMXq50OUFNFkjylyK+d8O7jNUKRCL7qpK8HTQ2dTgo
   A==;
X-CSE-ConnectionGUID: yD5LV9lGQvG38ogsyAmicw==
X-CSE-MsgGUID: u1HOuM1USBaSKA34Wa/e8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96185911"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="96185911"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 12:12:48 -0700
X-CSE-ConnectionGUID: 4mx1DY1sS6KrldJRQ0kcuA==
X-CSE-MsgGUID: vGllffMWTC2N9eywtp1LHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="288770477"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.110.193]) ([10.125.110.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 12:12:48 -0700
Message-ID: <b67e0995-fad5-42fb-b5e8-390446a1a10f@intel.com>
Date: Fri, 24 Jul 2026 12:12:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pmem: Format nvdimm serial numbers as decimal
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>,
 stable@vger.kernel.org
References: <20260619055932.1354182-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260619055932.1354182-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/26 10:59 PM, Alison Schofield wrote:
> The CXL NVDIMM security passphrase key is looked up by the description
> "nvdimm:" followed by the device serial string. For serial numbers of
> 10 and above, the kernel auto-unlock path fails to find the key
> because ndctl names it with a decimal serial and the kernel uses hex.
> 
> That means a passphrase-protected device cannot be unlocked after a
> reboot, and the pmem namespaces it backs do not come up. Devices
> without an enrolled passphrase are unaffected.
> 
> The mismatch occurs for any serial number of 10 and above. Since CXL
> device serial numbers are vendor-assigned 64-bit values, that covers
> essentially all real hardware once security is enabled.
> 
> The 'id' sysfs attribute is established ABI that ndctl consumes as
> decimal, so format the kernel's serial string the same way. A u64
> decimal string requires up to 20 digits plus a NUL byte, so grow
> CXL_DEV_ID_LEN to fit it.
> 
> The issue was exposed by CXL unit test cxl-security.sh when cxl_test
> mock serial numbers were recently extended to 10 and above.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next
2a77c0818e05

> ---
>  drivers/cxl/core/pmem.c | 10 ++++++----
>  drivers/cxl/cxl.h       |  3 ++-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index 68462e38a977..2ccdf04c1f43 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -219,12 +219,14 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_nvdimm_type;
>  	/*
> -	 * A "%llx" string is 17-bytes vs dimm_id that is max
> -	 * NVDIMM_KEY_DESC_LEN
> +	 * dev_id becomes the nvdimm dimm_id used for security key
> +	 * lookups. Match the decimal serial emitted by the CXL 'id'
> +	 * sysfs attribute. A u64 decimal string requires 20 digits
> +	 * plus a NUL byte and must still fit in NVDIMM_KEY_DESC_LEN.
>  	 */
> -	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 17 ||
> +	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 21 ||
>  		     sizeof(cxl_nvd->dev_id) > NVDIMM_KEY_DESC_LEN);
> -	sprintf(cxl_nvd->dev_id, "%llx", cxlmd->cxlds->serial);
> +	sprintf(cxl_nvd->dev_id, "%lld", cxlmd->cxlds->serial);
>  
>  	return cxl_nvd;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..3463faeb8a15 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -487,7 +487,8 @@ struct cxl_nvdimm_bridge {
>  	struct nvdimm_bus_descriptor nd_desc;
>  };
>  
> -#define CXL_DEV_ID_LEN 19
> +/* Holds a u64 serial as a decimal string: up to 20 digits + NUL */
> +#define CXL_DEV_ID_LEN 21
>  
>  enum {
>  	CXL_NVD_F_INVALIDATED = 0,
> 
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6

