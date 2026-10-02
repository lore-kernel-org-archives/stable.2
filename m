Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF5497B97
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947932; cv=none; b=niBgNJJmJ3vt5AEgTNkyEtPj5ZHzmt15owbiPqj/vo5VrA7pzccb/rHxtS3Y4s2aRL0vhd31OKzvrz6ZACWfq8wlKXQdpUoi2q+yJnfw+jZrjyyjOZrNwYnPGPfIBOrBLOARYWXW/vPfgvl6dgY7dX2/t9GOOZj9vQKzrFkOK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947932; c=relaxed/simple;
	bh=reBzhYRQcyj3Nz8ivHIWx97+3K4OUPNTngWR16scD8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eN/L9FfJssOvc60Sa9mlC1iXvky0P7RqnnsnUYZC5bFtmx2FFH5zc/yHzN5oAng32/wWPwJyNJummD/Y/VvsAqRipHasMhb3sZ53rtYr0xWW6jKGMaXqOCOsQd+83mbZfqRCobF1SZVbSaEIqpxQVUARO2QVyeSY9E5QOq5OiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhogitT5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhogitT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790947930; x=1822483930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=reBzhYRQcyj3Nz8ivHIWx97+3K4OUPNTngWR16scD8g=;
  b=YhogitT5h5Z+NZa99raEz5Et52zPM10s+fXFOP045VjYcjpx4j0VdzEu
   DvPVrQRG3y+Yy/WYf1+pIyr9XXBJmXZ5WYkvBa17FcXb37ULqI2w6/2lz
   SfApIE34qgPsJBheJzQKkK7glmrJ1yhZGJg0/vhssC3YvNd+Re3VgehKt
   KpPLvv1AUf/9SQn59xC+iuyW28UCzA+f9nKHsVg7cz0thU3FFQAi1o1Gk
   0GeRtKbrTjgtV5/2ODULo+09Up+h0YCPaRcK26xwo143yvgmS1Wwh18iD
   QJuzFveLTXFwdmT9qmQM6I6CcrDPZfsqZECjhGoSLwULm335+bGa4+OpN
   A==;
X-CSE-ConnectionGUID: nnD9AM/wQkOkbTLjNL8NaQ==
X-CSE-MsgGUID: LPxFyq9LS4+Y7KGRuJBViw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90571834"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90571834"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:32:09 -0700
X-CSE-ConnectionGUID: lGE1Eq0aQP2owmBiBeqEaw==
X-CSE-MsgGUID: 5pfzi2FSRt2JW+5uSr9j3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="271501"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.244.239]) ([10.245.244.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:32:09 -0700
Message-ID: <04c348e7-2fed-4fe9-a151-860b05433a75@intel.com>
Date: Fri, 2 Oct 2026 14:32:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/xe/vm: make PREFETCH to TT sticky
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20260928164820.1237049-4-matthew.auld@intel.com>
 <20260928164820.1237049-6-matthew.auld@intel.com>
 <92619c231f212306eb1c0c274b69c47687696159.camel@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <92619c231f212306eb1c0c274b69c47687696159.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/2026 13:43, Thomas Hellström wrote:
> On Mon, 2026-09-28 at 17:48 +0100, Matthew Auld wrote:
>> When userspace explicitly requests DRM_XE_VM_BIND_OP_PREFETCH to
>> system
>> memory (XE_PL_TT), xe_bo_migrate() moves the buffer object to TT.
>> However, because XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK in the
>> buffer's default placement (introduced in commit 5c87fee3c96c
>> ("drm/xe:
>> Attempt to bring bos back to VRAM after eviction")), any subsequent
>> validation during exec immediately migrates the buffer back to VRAM,
>> completely undoing the userspace prefetch request.
>>
>> Use xe_bo_migrate_tt_sticky() when prefetching to XE_PL_TT so that
>> the
>> buffer remains resident in system memory across subsequent
>> validations.
>>
>> Assisted-by: LLM
>> Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM after
>> eviction")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.12+
> 
> I think we need somewhere to clear this stickiness. Perhaps if
> xe_bo_migrate() is called with another destination than the sticky one,
> we'd clear it?

In the other patch in bo_migrate() there is:

+	ret = ttm_bo_validate(&bo->ttm, &placement, tctx);
+	if (!ret)
+		xe_bo_reset_sticky_placement(bo);
+	return ret;
+}

So if something successfully uses a non-sticky migrate(), it will reset. 
Is this enough?

> 
> Thanks,
> Thomas
> 
> 
> 
> 
>> ---
>>   drivers/gpu/drm/xe/xe_vm.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index 425c678f4480..2068e0cf50ff 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -3406,7 +3406,10 @@ static int op_lock_and_prep(struct drm_exec
>> *exec, struct xe_vm *vm,
>>   				mem_type =
>> region_to_mem_type[region];
>>   			}
>>   
>> -			err = xe_bo_migrate(bo, mem_type, NULL,
>> exec);
>> +			if (mem_type == XE_PL_TT)
>> +				err = xe_bo_migrate_tt_sticky(bo,
>> NULL, exec);
>> +			else
>> +				err = xe_bo_migrate(bo, mem_type,
>> NULL, exec);
>>   		}
>>   		break;
>>   	}

