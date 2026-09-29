Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D714A60F;
	Tue, 29 Sep 2026 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647149; cv=none; b=glLy/goI7ZiToaJnDtcASvhf1YfPeR48TTXVnibwTGo8GsPe6dyQCpTueOT0LSJOWZUprfiAOz2ulAXp3dc44npuAchjhDHDWcQEvbumT3zUJWpW+II1tc+m5AX7kRF7oQ0EMSGfpJS58sYSksW7ijp4tbSGJoIyI6PaWA5/4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647149; c=relaxed/simple;
	bh=B5nV/HtbBryxw/8tS+VfkVUXRLsvMEBZHxC2zJCFYn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBMcZIc1Vt3OHi+ihqpJMvbfKttGQyON2/rEnLCeOCzApeuC8Nc6CGoXl1f32OPog3MFzCSS7rfm4sjHzCpOJj4ojmNtGpGuU9UexT/DItiXmcXrRLxuriY1s31i4IEmh0ekstunSY+t83Du8b9vLlwY3/Mi0da4yugC8pRPJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FOuK0Nu3; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FOuK0Nu3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790647143; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8JRCLmFuMQXFiZMU3Bmuz8WXdz3zgxjaZT2gg9tR8dw=;
	b=FOuK0Nu3LNOBptHzQKEBEDndqaD4244VN5idxKQ2IVO3ixw69FI3pM5eNjz7Dd//lDTZMUEUgX+RpnPKRW5eBCN9+BNyQac+6UOA/NI1dnIR0swzYoU+xGsNUgDYyJN5aAtVYb1nnCr32aqzp41JeXxQVAdpUGesK89M6EDb+v4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0XBrSLRt_1790647141;
Received: from 30.28.50.44(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XBrSLRt_1790647141 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 09:59:03 +0800
Message-ID: <56179353-7e02-40bc-b443-80ab8e6b627d@linux.alibaba.com>
Date: Tue, 29 Sep 2026 09:59:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: accumulate the queued flag across error
 sections
To: Breno Leitao <leitao@debian.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/26 11:09 PM, Breno Leitao wrote:
> ghes_do_proc() walks every error section of a CPER record, and
> ghes_handle_arm_hw_error() walks every error-info entry of an ARM
> processor section.  Both assign to "queued" instead of OR-ing into it,
> so only the last iteration counts: a later section or entry that queues
> no memory-failure work clears the flag an earlier one set.
> 
> Instead of reassigning the variable at every time, just do an `OR`, so,
> if there was a single match, it will return "queued" as set.
> 
> The comment above the check says "If no memory failure
> work is queued", which is the semantics this patch implements. I.e, only
> SIGBUS if there are queue was not handled at all. If we want to SIGBUS
> if any event was not handled/queued at all, we will need something more
> sophisticated.
> 
> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
> Fixes: ccb5ecdc2dde ("ACPI: APEI: fix synchronous external aborts in user-mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/acpi/apei/ghes.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fe10ab0e02f68..ec2d5ca51db02 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -603,7 +603,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>   		 * and don't filter out 'corrected' error here.
>   		 */
>   		if (is_cache && has_pa) {
> -			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
> +			queued |= ghes_do_memory_failure(err_info->physical_fault_addr, flags);
>   			p += err_info->length;
>   			continue;
>   		}
> @@ -951,11 +951,11 @@ static void ghes_do_proc(struct ghes *ghes,
>   			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
>   
>   			arch_apei_report_mem_error(sev, mem_err);
> -			queued = ghes_handle_memory_failure(gdata, sev, sync);
> +			queued |= ghes_handle_memory_failure(gdata, sev, sync);
>   		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>   			ghes_handle_aer(gdata);
>   		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> -			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
> +			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
>   		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>   			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>   
> 
> ---
> base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> change-id: 20260925-ghes-queued-accumulate-591c8ac3b32d
> 
> Best regards,
> --
> Breno Leitao <leitao@debian.org>

Good catch, thanks for the fix.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.

Shuai

