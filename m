Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755010;
	b=zxaYug/DtDCa3v8FGVbiD9ZsMkhOPLPwyTac75wVHcwz0B74rbP1S5ri9buhB1TobtlS
	 g2StdxnXNT2FyS/d+K+WbfKKRRrfIaDiedkvgVAI5jB4WH+pTKRFuWDXDuvS0HeVC0Wi0
	 kw3IFlN3sVAwj1FZkrcF1zoNRLLIBfSyryPqp9HzIOBlLnwXWttkOljUEJWfz4WDXfKXn
	 Fzh4LzlU1Fzr5mYWSWYQA15HfDJ3ckYqMEMiJ1yQhFh7yIOypz7HE142p13vIQH/HR2Hd
	 UYKW8Ng/DhE6tyx6s9/acYz8IZdNXnZqGpJm7Nx23yW51ZHBnCPPtSS8jiKjZWsxkCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755010;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eIaKQbs2CvZNewKzz55AgGEgPZrnYFruF5iAPjXWtxM=;
	b=0NX3txVc9X5/RktGCLVPYbZUMw7JKxLeHjNSH0ujK3EzGJ9Z7WAHEKLpSGz/8QTL6tjc
	 GvXT1fd8SZnWY05bzfR+Pw2dneJUcZ011GWoF8HjE2JNqfBMtI4AGvNY7NHZUvwLF+DPp
	 ugLKsQZxDeaH8KtQkDU5HxUSP9D9SEiwNCEiBJdrdoeu0KpFvd0oFjM6sj6bpmTnnVyQw
	 660Ogq0AdzTET0imjkiepFVrEbFqc/Dy3ZfIuQchgqJ2QBtOTt4JF71l3M2IE1pvpef5o
	 rvjTXiU1f7yv8AQ5pNLa54q0rbX5aRiSL8g7yFfULfGVm/HHvE/42xVIM4YXvuk5CoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oDA9WYyX;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B9606A31B;
	Wed,  4 Nov 2026 01:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 932B9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oDA9WYyX
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793755006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eIaKQbs2CvZNewKzz55AgGEgPZrnYFruF5iAPjXWtxM=;
	b=oDA9WYyXQodTF6FRQ5mmAt9m8uITF3vC9re449gr8iZL4Ga243eQFkr/gVSm4rDf74rbRnYp52Vu5zJg+vbBkSLYhUtXm77/ruxpb9XV8N76aiOXXqwfVQR3UEYsCDb7ezGCrkDHzZqpg5iUqlGBDES3o4c91HMAs1gZVtL6eHY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XE45k6._1793755004;
Received: from 30.246.177.186(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XE45k6._1793755004 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 09:16:45 +0800
Message-ID: <9a375554-57ee-4cf4-8d84-60511c96d8ea@linux.alibaba.com>
Date: Wed, 4 Nov 2026 09:16:44 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: GHES: Fix severity check in ghes_log_hwerr()
To: Breno Leitao <leitao@debian.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20261030-ghes-hwerr-sev-v1-1-145ceb996c77@debian.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20261030-ghes-hwerr-sev-v1-1-145ceb996c77@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/26 8:18 PM, Breno Leitao wrote:
> ghes_log_hwerr() is meant to count recoverable GHES errors in
> hwerror_data[], but it skips them and counts informational records
> instead. As a result, recoverable CPU, memory, CXL and vendor-specific
> errors reported through GHES never show up in a vmcore.
> 
> ghes_do_proc() passes ghes_log_hwerr() the record severity after
> ghes_severity() has converted it to a GHES_SEV_* value.
> ghes_log_hwerr() compares it against CPER_SEV_RECOVERABLE, which is 0
> in the CPER enum and matches GHES_SEV_NO, so only informational records
> pass and GHES_SEV_RECOVERABLE ones return early.
> 
> Compare against GHES_SEV_RECOVERABLE instead.
> 
> Recoverable PCIe errors that ghes_handle_aer() hands to AER are also
> counted by pci_dev_aer_stats_incr(), so with the check fixed they are
> counted twice under HWERR_RECOV_PCI. That is not addressed here.
> 
> Fixes: 3fa805c37dd4 ("vmcoreinfo: track and log recoverable hardware errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/acpi/apei/ghes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 663dc2e601cf72..5d888c82efeaa3 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -899,7 +899,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
>   
>   static void ghes_log_hwerr(int sev, guid_t *sec_type)
>   {
> -	if (sev != CPER_SEV_RECOVERABLE)
> +	if (sev != GHES_SEV_RECOVERABLE)
>   		return;
>   
>   	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||
> 
> ---
> base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> change-id: 20261030-ghes-hwerr-sev-e440624108b6
> 
> Best regards,
> --
> Breno Leitao <leitao@debian.org>


LGTM.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

