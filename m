Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D261A6823
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780984468; cv=none; b=few7UhOo4FrlL6MWko15AMZKt6pQTH87AsgSTNFI+YNR4esecI3BZpYuo9xeDG8CabKXnUjf9z6TVRlnLogMTFk/Q/M5JHipxr1n1OI8JgMpwJ8WBCZz0spdBieH4rT8pqSTRMv+oaP15FnNUkTAkfO4oHUaTgkh+eyR8J5AqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780984468; c=relaxed/simple;
	bh=TLsSDV9VD3WU6t5YlfaCQGPVqBXO7S58BIho6lpCVAE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=scMAg9OpgLvh/Z+wiptgn+kpqLApTvc4/0tmTSKFNQdnnXxiSi+VkCOZbPvheL7ZEqXCrD5tvNBVWnEeLDud8soQR87XYY6qTQpr7Cif4oMWWcBm5gmNix7zBfohLtkne+aeYd2KWsxKGEF1AJVl4HVeJm/TbxfvONg+zUg8/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRlti4pi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRlti4pi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780984467; x=1812520467;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=TLsSDV9VD3WU6t5YlfaCQGPVqBXO7S58BIho6lpCVAE=;
  b=lRlti4pi+5Up0Qpg8DHR2LoGi3/XEzA/nzqEJp8knSYhLQu77Fxrr21K
   8vBodGbiN0yJ2nP6Xm/ItSKic7k4xlmoO+XgYQFmsPbgQIY+NVBUcN6sp
   Lbj+XVZu5XUKXtrwu7WFadQft6vmTZmwLiN2eI1lUYzmXkjuDJ4KtHNAn
   uuZYZ7RINLOUER1qEJQonl4JRVtQ7Ay1KHiqT6Nx9VDEggN9p/bA360/2
   3Wp2xmwxjqdLuB5I0EghKYiRR+MkafsWQIHsC/feeXI+C4n49NvaBFc/L
   CuPpx4cuBQ0XGTcVsGkLJqmlbALGf6UvMXEwi/ABGGXkOkr4eo0xR1szK
   A==;
X-CSE-ConnectionGUID: m7LHQXUbSriPk/zbCLuHdA==
X-CSE-MsgGUID: B+mWQXKUSuKiz8Tf7E4zhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81848116"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81848116"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:54:27 -0700
X-CSE-ConnectionGUID: pTw9gR2qRp+fJwoLhYgLrg==
X-CSE-MsgGUID: A7BylG1uT/WQSBslCyt3dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="239429711"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.44]) ([10.217.180.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:54:24 -0700
Message-ID: <738b9a7d-3e5c-4788-9b77-649eb914161f@linux.intel.com>
Date: Tue, 9 Jun 2026 07:54:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Fix signed integer truncation in IPC
 receive
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, david.laight.linux@gmail.com,
 stable@vger.kernel.org
References: <b464b589-2d28-4617-baf0-eefbe14e170a@linux.intel.com>
 <20260601161643.229342-1-andrzej.kacprowski@linux.intel.com>
 <7218fa4b-bb09-47a8-a2ab-7d381cf7d897@linux.intel.com>
Content-Language: en-US
In-Reply-To: <7218fa4b-bb09-47a8-a2ab-7d381cf7d897@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08-Jun-26 9:27, Wachowski, Karol wrote:
> On 01-Jun-26 18:16, Andrzej Kacprowski wrote:
>> Fix potential buffer overflow where firmware-supplied data_size is cast
>> to signed int before being used in min_t(). Large unsigned values
>> (>= 0x80000000) become negative, causing unsigned wraparound and
>> oversized memcpy operations that can overflow the stack buffer.
>>
>> Change min_t(int, ...) to min() as both values are unsigned and can be
>> handled by min() without explicit cast.
>>
>> Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done 
>> messages")
>> Cc: <stable@vger.kernel.org> # v6.12+
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>> ---
>> Changes in v2:
>> - Replaced min_t() with min()
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
>>
>>   drivers/accel/ivpu/ivpu_ipc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ 
>> ivpu_ipc.c
>> index f47df092bb0d..9347f05a2b79 100644
>> --- a/drivers/accel/ivpu/ivpu_ipc.c
>> +++ b/drivers/accel/ivpu/ivpu_ipc.c
>> @@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, 
>> struct ivpu_ipc_consumer *cons,
>>       if (ipc_buf)
>>           memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
>>       if (rx_msg->jsm_msg) {
>> -        u32 size = min_t(int, rx_msg->ipc_hdr->data_size, 
>> sizeof(*jsm_msg));
>> +        u32 size = min(rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
>>           if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
>>               ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg- 
>> >jsm_msg->result);
> 

Pushed to drm-misc-fixes.
