Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB53932DF
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379408; cv=none; b=XN2m0ArHZn7Ryq90ZqCwciH6MmafGg2L1oP9/dYEuM80DviTNxLkt7+K9rr5XmSoW96618cKRDPMSuQkD3JOEFXA4ALVvRSCyQcTaGjpi8qN0HM9J1EsJifAbqeGXak30vxz4vgV5lB7V/DLhCojiYoLqr2LePNmqExUfqleh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379408; c=relaxed/simple;
	bh=mj9HAMZM6TU9/v8UpvnCJpU2g06IGq5K1i9ePAy2V7E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EUcKD/iYAjJWfnWNloqpmuBVk8bJmZcAI89Ztx6yasNK7RyG2UMyitJ4PSeBiJ+PTpdZMdhrcCkn1mo+Jp8l2mIWxB4mjtLgbH8I4auh8WpK7r5vLC6M+94jIUVQxM/oLXzM39hvB38/88aQfFUasmd7y8iFMXJPYgajWHPJVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCB9X6DY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCB9X6DY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780379408; x=1811915408;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=mj9HAMZM6TU9/v8UpvnCJpU2g06IGq5K1i9ePAy2V7E=;
  b=kCB9X6DY+KAE9wupJx7H0YaOnbR5lCa2YaqHZzUJ/rlImd3SnTQDC93L
   ghe+l2KagziDiy5bnHz/YrtOR01rxtG3+CYZRl1iTVkI9NLBuytyQ7zhr
   efMhv0tpOpNNJx8SYTeG/3if3tC2HT+mT5ErWQIIzptMvrLpw58Caf4xZ
   he5wotYdjHc7KLeHP+FW8Hig4jjPA0yMuIN+z4K2ykvui/k3c6eBwRw5Z
   2XRzOUIFI7xvauieEYGqFV0UXs2zPqvy/j7Ba5LPxmmci+QCo8crz59/V
   KvuPtJnRZEy0vmgnIh+nhQkQu5LUwEH1fggt6R47R7kiWu42e80kLxeXo
   A==;
X-CSE-ConnectionGUID: XPvWlHcqQ9qT1/QpInwwJw==
X-CSE-MsgGUID: soH8MvWcQMaLjpXZ+THZzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="85045083"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="85045083"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:50:07 -0700
X-CSE-ConnectionGUID: hYmEZITgTaqvFUGvO3o+dg==
X-CSE-MsgGUID: 1sZrEx44RRmEsOKR1hw/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267451426"
Received: from martanox-mobl.ger.corp.intel.com (HELO [10.94.250.132]) ([10.94.250.132])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:50:04 -0700
Message-ID: <97e861e1-8c15-4421-847e-58028fdf5327@linux.intel.com>
Date: Tue, 2 Jun 2026 07:50:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add bounds check for firmware runtime memory
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529120853.135876-1-andrzej.kacprowski@linux.intel.com>
 <fcad21ec-ebeb-41af-a94a-b31120fa945a@linux.intel.com>
Content-Language: en-US
In-Reply-To: <fcad21ec-ebeb-41af-a94a-b31120fa945a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29-May-26 14:27, Wachowski, Karol wrote:
> On 29-May-26 14:08, Andrzej Kacprowski wrote:
>> Validate that the firmware runtime memory specified in the image
>> header is properly aligned and sized to hold the firmware image.
>> This prevents errors during memory allocation and image transfer.
>>
>> Fixes: 2007e210b6a1 ("accel/ivpu: Split FW runtime and global memory 
>> buffers")
>> Cc: <stable@vger.kernel.org> # v7.0+
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 

Applied to drm-misc-fixes.

>> ---
>>   drivers/accel/ivpu/ivpu_fw.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
>> index 107f8ad31050..33c50779c06b 100644
>> --- a/drivers/accel/ivpu/ivpu_fw.c
>> +++ b/drivers/accel/ivpu/ivpu_fw.c
>> @@ -259,6 +259,22 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
>>           return -EINVAL;
>>       }
>> +    if (!PAGE_ALIGNED(runtime_addr)) {
>> +        ivpu_err(vdev, "Runtime address 0x%llx not page aligned\n", 
>> runtime_addr);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!PAGE_ALIGNED(runtime_size)) {
>> +        ivpu_err(vdev, "Runtime size %llu not page aligned\n", 
>> runtime_size);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (runtime_size < image_size) {
>> +        ivpu_err(vdev, "Runtime size too small: %llu, image size: 
>> %llu\n",
>> +             runtime_size, image_size);
>> +        return -EINVAL;
>> +    }
>> +
>>       if (!ivpu_is_within_range(image_load_addr, image_size, &vdev- 
>> >hw->ranges.runtime)) {
>>           ivpu_err(vdev, "Invalid firmware load address: 0x%llx and 
>> size %llu\n",
>>                image_load_addr, image_size);
> 
> 

