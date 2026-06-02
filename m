Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE3342CB3
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379371; cv=none; b=bMc1h0joV2bAcN+A5mQwwmeI83F0Lz88/+YpzXf+FBmNeu3Fh4lHvz85sUrt7Sickw9VZ8ap4Bzh3zLjKBmWuRq01dyZrRwFvy0M5y6t4wtiSCjBonB4ryVw9JBbq1+/rDqOfPBpPm4cCzJzWxV2s0eIOXhVBFrghqdwRAElo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379371; c=relaxed/simple;
	bh=XiyYyAHDe/o5OzbJ6v9PhRD2lY35xaiYM1/wBqdFa8o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sc1nSE/aY9YZCBJYDfLYcMX77PV8Qn6bVYiBioXixQt1lC3XT/tvK5XJwJPuIXuhUiKJMFYYo9P9rkKQD/lvtiUr/5Q4t1BsHcagbjLjL6z0CMQdSfgK6CRgMEZkKcpyvoUO61Z1DASxd1J6Vke8n+i1Km8A960+5sgdJ+qzQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDzrd+p2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDzrd+p2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780379370; x=1811915370;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XiyYyAHDe/o5OzbJ6v9PhRD2lY35xaiYM1/wBqdFa8o=;
  b=bDzrd+p2VXOTgRgyGXp960vX/aBZ67cR6E/UJvCPXZsOE3m5FQk56O72
   CoSZy0h+GBWzraBWrucios65fz5JKVqWOpik+TprGlTnfKkMEXqP7Zfwh
   MiM2A5CNzuMa9Glbq0w8T6z60IguN2e1H8pyj35e7m9/KudSGZxTU5Tsc
   Tsq71gmKlvCBSwi0zh78AZtXRMhA6NkJev7Y+6VhGZg0bCn179OeQ0Ecm
   6JVkRZemCTD0m4pwOSIMkuFY1CwI7I8/swvLqwVr1+Ro2zGKgCMre5Dx7
   yb3ZEjoLJolmTIb4gfAn/TOd74ZFk0njznZfIJ199WztphQQnI8kvdV/n
   Q==;
X-CSE-ConnectionGUID: 4ALqeBkoTqOaMyuPWcewGg==
X-CSE-MsgGUID: 1wI1VyBUS12MUafxYUtr4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="85045057"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="85045057"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:49:30 -0700
X-CSE-ConnectionGUID: /g+LueiEQsu0jQDFl/Bbjw==
X-CSE-MsgGUID: t10f2cToRSSnznqba1m3ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267451367"
Received: from martanox-mobl.ger.corp.intel.com (HELO [10.94.250.132]) ([10.94.250.132])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:49:27 -0700
Message-ID: <093b7951-a0f3-4935-adfa-dfd4fe45bea9@linux.intel.com>
Date: Tue, 2 Jun 2026 07:49:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add bounds checks for firmware log indices
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529115842.135378-1-andrzej.kacprowski@linux.intel.com>
 <9c0b071d-efd0-4b89-9e75-78b8355d90d4@linux.intel.com>
Content-Language: en-US
In-Reply-To: <9c0b071d-efd0-4b89-9e75-78b8355d90d4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29-May-26 14:06, Wachowski, Karol wrote:
> On 29-May-26 13:58, Andrzej Kacprowski wrote:
>> Add validation that read and write indices in the firmware log buffer
>> are within valid bounds (< data_size) before using them. If
>> out-of-bounds indices are encountered (from firmware), clamp them to
>> safe values instead of proceeding with invalid offsets.
>>
>> This prevents potential out-of-bounds buffer access when firmware
>> supplies invalid log indices.
>>
>> Fixes: 1fc1251149a7 ("accel/ivpu: Refactor functions in ivpu_fw_log.c")
>> Cc: <stable@vger.kernel.org> # v6.18+
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 

Applied to drm-misc-fixes.

>> ---
>>   drivers/accel/ivpu/ivpu_fw_log.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ 
>> ivpu_fw_log.c
>> index 337c906b0210..275baf844b56 100644
>> --- a/drivers/accel/ivpu/ivpu_fw_log.c
>> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
>> @@ -98,6 +98,11 @@ static void fw_log_print_buffer(struct 
>> vpu_tracing_buffer_header *log, const cha
>>       u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
>>       u32 log_end = READ_ONCE(log->write_index);
>> +    if (log_start >= data_size)
>> +        log_start = 0;
>> +    if (log_end > data_size)
>> +        log_end = data_size;
>> +
>>       if (log->wrap_count == log->read_wrap_count) {
>>           if (log_end <= log_start) {
>>               drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, 
>> log->name);
> 
> 

