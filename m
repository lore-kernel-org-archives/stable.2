Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94538C2B8;
	Fri, 24 Jul 2026 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924401; cv=none; b=ZzdDKoi+HeH+ldZUBpH62uyEBjzjsA5sI6Se1jkfx6POtM5bbFCzjHGqJYGiA05vY9FO88g0oMfl9EyXcIhB/DlIe4jY01wFBqLNZgQH9DS7Fq/nsOtfC5QhgjnzgYID9y5NPj0e1oaXWQkGBc8A+sW3HKtA7Tzp7fCBbLqPXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924401; c=relaxed/simple;
	bh=5qgqrlfMZO2xemS1pMFCpofawxzM6a3xpiPWmyiBe3M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LOfhI8ohxbjPiDa4Z4ywzpr1OVJfutZxpIXmWnSSM7pnkRgP7vu8zUQ2UNwAaYOq9Iz0342DJSEmXzYhAaVhrruUt5Vb92nHXUWYj9TM489TQ8Ij+UQKFCLy506nhePssnDx1JNtMYBJSFPlp90HP2ZUvmqxkvRvXhZq+HrrgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIPnzX5L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIPnzX5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784924399; x=1816460399;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5qgqrlfMZO2xemS1pMFCpofawxzM6a3xpiPWmyiBe3M=;
  b=GIPnzX5LkDpDOPVAihhyMP7WhKzlDUiAMlATyPiZpJHQNJVjZO+5OqYJ
   TUGXBhJVS8V7vdM6Sjg+8XxaIkuk6UxaxmSPNNmrM2+NgUFrw+B8IdWzr
   AwFVzUjI5P+n8MBKvC2EK14UDerpNoM10mgHl1V13knLpmoT5CAGoA9Nc
   UnaYgHY6Q/4O6ppZLggUe6D7eFt0JjITxl7HsEw39ME5Yd0D6v7ITvvPO
   64CuwTvuzpZJYHembD3voYAZ3zQJ156bTnEdO7+rUXJr9gffcZ2VChYBs
   qII6alelKYN+Z3dvApitBJO9lDB8XNtVRroB13qTgya84BbQ31tUY5HAx
   Q==;
X-CSE-ConnectionGUID: p8ATUnroTDOkp20ebBUPLA==
X-CSE-MsgGUID: cc4V3UcWQqics2fZI9hFtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="89421664"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="89421664"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:19:58 -0700
X-CSE-ConnectionGUID: kBb3lvXlRO+Bmnq93vIcXw==
X-CSE-MsgGUID: lToBT5mGRA62YVvv2b2OWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="257028665"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.110.193]) ([10.125.110.193])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:19:57 -0700
Message-ID: <168830ed-848d-444b-8356-9d3248b338cf@intel.com>
Date: Fri, 24 Jul 2026 13:19:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pmem: Format nvdimm serial numbers as decimal
From: Dave Jiang <dave.jiang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>,
 stable@vger.kernel.org
References: <20260619055932.1354182-1-alison.schofield@intel.com>
 <b67e0995-fad5-42fb-b5e8-390446a1a10f@intel.com>
Content-Language: en-US
In-Reply-To: <b67e0995-fad5-42fb-b5e8-390446a1a10f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/26 12:12 PM, Dave Jiang wrote:
> 
> 
> On 6/18/26 10:59 PM, Alison Schofield wrote:
>> The CXL NVDIMM security passphrase key is looked up by the description
>> "nvdimm:" followed by the device serial string. For serial numbers of
>> 10 and above, the kernel auto-unlock path fails to find the key
>> because ndctl names it with a decimal serial and the kernel uses hex.
>>
>> That means a passphrase-protected device cannot be unlocked after a
>> reboot, and the pmem namespaces it backs do not come up. Devices
>> without an enrolled passphrase are unaffected.
>>
>> The mismatch occurs for any serial number of 10 and above. Since CXL
>> device serial numbers are vendor-assigned 64-bit values, that covers
>> essentially all real hardware once security is enabled.
>>
>> The 'id' sysfs attribute is established ABI that ndctl consumes as
>> decimal, so format the kernel's serial string the same way. A u64
>> decimal string requires up to 20 digits plus a NUL byte, so grow
>> CXL_DEV_ID_LEN to fit it.
>>
>> The issue was exposed by CXL unit test cxl-security.sh when cxl_test
>> mock serial numbers were recently extended to 10 and above.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Applied to cxl/next
> 2a77c0818e05
> 

Backed out per request from Alison. There will be a v3. >> ---
>>  drivers/cxl/core/pmem.c | 10 ++++++----
>>  drivers/cxl/cxl.h       |  3 ++-
>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
>> index 68462e38a977..2ccdf04c1f43 100644
>> --- a/drivers/cxl/core/pmem.c
>> +++ b/drivers/cxl/core/pmem.c
>> @@ -219,12 +219,14 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
>>  	dev->bus = &cxl_bus_type;
>>  	dev->type = &cxl_nvdimm_type;
>>  	/*
>> -	 * A "%llx" string is 17-bytes vs dimm_id that is max
>> -	 * NVDIMM_KEY_DESC_LEN
>> +	 * dev_id becomes the nvdimm dimm_id used for security key
>> +	 * lookups. Match the decimal serial emitted by the CXL 'id'
>> +	 * sysfs attribute. A u64 decimal string requires 20 digits
>> +	 * plus a NUL byte and must still fit in NVDIMM_KEY_DESC_LEN.
>>  	 */
>> -	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 17 ||
>> +	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 21 ||
>>  		     sizeof(cxl_nvd->dev_id) > NVDIMM_KEY_DESC_LEN);
>> -	sprintf(cxl_nvd->dev_id, "%llx", cxlmd->cxlds->serial);
>> +	sprintf(cxl_nvd->dev_id, "%lld", cxlmd->cxlds->serial);
>>  
>>  	return cxl_nvd;
>>  }
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1297594beaec..3463faeb8a15 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -487,7 +487,8 @@ struct cxl_nvdimm_bridge {
>>  	struct nvdimm_bus_descriptor nd_desc;
>>  };
>>  
>> -#define CXL_DEV_ID_LEN 19
>> +/* Holds a u64 serial as a decimal string: up to 20 digits + NUL */
>> +#define CXL_DEV_ID_LEN 21
>>  
>>  enum {
>>  	CXL_NVD_F_INVALIDATED = 0,
>>
>> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> 
> 

