Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F481AE877;
	Mon, 22 Jun 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145165; cv=none; b=bPvEu9vporY4WekEuGjMfGIAvyDTTC982deGIz9aF0ut1Y0oBbfBX5Ov+9Aflj67umZyJUIO4iLTgfJWbT9cCiML+o4M/VTChRKb+jvRw6lN4q5bXv1PUvOhkRROe+0PbCnaZrQBKpAoJBNr2LJ7hSj2j6jw3jN9tXoEJSAaTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145165; c=relaxed/simple;
	bh=6e/kdupA1vkNLp1w2IDFNbTNJDHcZByi2a9VZPxEgN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghR+cVkAwLK3ZIhe1qTR/OlXGCgol1KRT27IF1mZc0ytRabWLxvRKje2yr/F0Dvhkx6t6e1Qhnbk0mhXSQSGAW6vVw4+GErvbYJ3UZ2vPl55TCPp54D3FohCp/IIGza3rNHw6yDRZI9AuuVdIuSs6D1T2epCWgs23trCUv7MJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNz/jMqB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNz/jMqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782145164; x=1813681164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6e/kdupA1vkNLp1w2IDFNbTNJDHcZByi2a9VZPxEgN8=;
  b=PNz/jMqBPQyxJZTDCS8AvlOa1GcCkK/xf4mr3F2v0XeX27iTSkg10yw1
   DVmnbbiBIscmmZBosDW1HujfcrFnf1ZbvRTTe7CbDEsBWnh1fPvqZqKzT
   FXbt5OnpTO58waYQqoxWGSKdW2rFCmJ0cMqxSjyKNlRoN9I1ZktvSZRTL
   jRfn4Q3CLCQtJTgIiSjtvbVwxTc7QoxtIF9v068L9tjYrSVGg6yDjJB/H
   fd9MO5B9PiMgsIWJuBsXq1qf5SPWAMM0mvPJT+evvpKxWdB/Y4lDr6eRD
   cQE4JoqMX8uwgyqFO74bh2wFAGpKx5rWSSOVTfc9tIyT63qeZRUuR13rA
   g==;
X-CSE-ConnectionGUID: KRlZT1uyS+6OubIXK6oJUA==
X-CSE-MsgGUID: QyG3SZzbQiiNzhS7mSBiBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82765146"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82765146"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 09:19:24 -0700
X-CSE-ConnectionGUID: qvL3UTKPSHCMnwlKTWiW0A==
X-CSE-MsgGUID: VRR1UXspTP+SDurSAMWAjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="249315960"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.108.100]) ([10.125.108.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 09:19:24 -0700
Message-ID: <ddc1d44c-37ef-473e-9f87-efe207d8bcbf@intel.com>
Date: Mon, 22 Jun 2026 09:19:11 -0700
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

Can CXL_DEV_ID_LEN be used here?

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

