Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52862393DE8
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379392; cv=none; b=F5Ok6Ji//sO62Iw3w15qvHl52M5E0A76SfxddaJu8HrNnk4Dc0gnGoipA/BeVVbJUOT4d3MGjQbgzBNWsVKNxW0t/F6V28THaU+ETmSSNze8j2THzBeHYHAmKcp67Lvq4aJ1lV9XtZhrZgtlVvASnOojAynawRDmm1Tonk+Tal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379392; c=relaxed/simple;
	bh=eZrCBGazyAZ2yRvUieVnU0FSZppveeZKV8WrKXXSByQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oSwEW9TR+jLjUYSfiPWt3WIxOW/Rx0YVNvUZw8hdhz2XDeCKaPTCisXUd9uWH8VNHuW4+TGVcFvWynJGmwRmF7lfWEtPJcs6bS5mB+dySPVZsMunIjA9pGTXlvfgeH0T6ays9zJ5d6f337k2tGTnMrwqajpTrPeMqk1lkxMpliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jh1OKdLo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jh1OKdLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780379389; x=1811915389;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=eZrCBGazyAZ2yRvUieVnU0FSZppveeZKV8WrKXXSByQ=;
  b=Jh1OKdLoUsGIBK+yP3UGDI8MiVaaKwjl750MdwMh9MIKDbxsjlkL7y0k
   BhF71nDZkMK/eEPhI5+I3PiLQL2J40ZGHgzb41f5dp6CWDYm1+tCRDoMQ
   kiIzGNZotYoKl/gxzMQxht106UOyG8fh15tG0ti3QYIuAU7RYwxKKi+81
   7AXUosmO2GlgTcwT84ng5IasmFYAHYtXy6IEJCXAOYXljJmjNA9SROaQv
   Hrod1qdxDuEib2v0lJJ3+M+vQMT+7g0KNhsycHcxJZ1A6v+R0YhcDaGmH
   HFKKBUx9WuOtkRdP9QMnytJ0iX2M3Xi+zlIY9x1SFRzOIlcTqW5vpJJ4p
   g==;
X-CSE-ConnectionGUID: hSUYLufdRSKjVPLZfwa8xA==
X-CSE-MsgGUID: 9LOIbzi1QtqhV5kv4pEtPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="85045067"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="85045067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:49:47 -0700
X-CSE-ConnectionGUID: ayOaYNxsQISKe30thcLIng==
X-CSE-MsgGUID: nLS+remORPyhloR7ciO78g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267451392"
Received: from martanox-mobl.ger.corp.intel.com (HELO [10.94.250.132]) ([10.94.250.132])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:49:45 -0700
Message-ID: <32cb5055-c2e1-4bfd-a691-202e4cf08d17@linux.intel.com>
Date: Tue, 2 Jun 2026 07:49:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add buffer overflow check in MS
 get_info_ioctl
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529120841.135852-1-andrzej.kacprowski@linux.intel.com>
 <8cd98877-6535-4ca4-8c96-88c136a2dac1@linux.intel.com>
Content-Language: en-US
In-Reply-To: <8cd98877-6535-4ca4-8c96-88c136a2dac1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29-May-26 14:23, Wachowski, Karol wrote:
> On 29-May-26 14:08, Andrzej Kacprowski wrote:
>> Add validation that the info size returned from the metric stream info
>> query is not exceeded when checked against the allocated buffer size.
>> If the firmware returns a size larger than the buffer, reject the
>> operation with -EOVERFLOW instead of proceeding with an incorrect
>> buffer copy.
>>
>> Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
>> Cc: <stable@vger.kernel.org> # v6.18+
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Applied to drm-misc-fixes.

> 
>> ---
>>   drivers/accel/ivpu/ivpu_ms.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
>> index be43851f5f32..cd176e77b9a0 100644
>> --- a/drivers/accel/ivpu/ivpu_ms.c
>> +++ b/drivers/accel/ivpu/ivpu_ms.c
>> @@ -291,6 +291,13 @@ int ivpu_ms_get_info_ioctl(struct drm_device 
>> *dev, void *data, struct drm_file *
>>       if (ret)
>>           goto unlock;
>> +    if (info_size > ivpu_bo_size(bo)) {
>> +        ivpu_warn_ratelimited(vdev, "MS info overflow: %#llx > %#zx\n",
>> +                      info_size, ivpu_bo_size(bo));
>> +        ret = -EOVERFLOW;
>> +        goto unlock;
>> +    }
>> +
>>       if (args->buffer_size < info_size) {
>>           ret = -ENOSPC;
>>           goto unlock;
> 
> 

