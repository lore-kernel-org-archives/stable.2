Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2E2AE78;
	Tue, 28 Jul 2026 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205336; cv=none; b=OYf7PfJWG4Z5+kElKvusITx8lqyTZM9j0hR8UnCdrxhmEZzmROitB06gcsbSvREP4R6JYgolANnVqHdwCX61WD26aiolEW1ZaXgVk1prlwGUsE7wxnUPQqQ2vXOqMj5I3ClpCeTXAou/sryvdgJHrDIAmWipZ6hV1Lvu+oecBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205336; c=relaxed/simple;
	bh=UbFD/3ksgPkZhnyFxSWZKmXSpjb+7JwiZu4mdB9Yfqs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uOmgGFhMbi0BqDtikwSl8qslVJgWkxMOQHZCUVVPJBaLif1TCm25VQYyKmCHtJ3ufs18K8JyrvxM2HTOSgjcDFNss7RLwNL9ILOWvykkAGWdu7WhqdFPb/f6sIEzKBbJFoPF6OUQYxhu0A00YS1vXKKo5QLuV7ngsy9Qgxyiwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ALb6tHXL; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ALb6tHXL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IN97GRGSXWLXbuOSeEjvu2/648NjLnhN0ac5lrVnnxg=;
	b=ALb6tHXLCLAanLMZQI8nSJM3rdhrhyIyBCLWBcHPEp8adcVrTP47IuEWxMEsTGouUk/XYCEWo
	7nhzDsoV66XB93isASHNDjKSdWbPIl04mbmexOX7wuxMviavnI2m0vuwItLEm3JZFdTZvj0Nb5x
	keTEWvuI5EW4QAN3gDhnOlg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h8Jrj505HzmV8f;
	Tue, 28 Jul 2026 10:12:37 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BFAF4055B;
	Tue, 28 Jul 2026 10:22:04 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jul 2026 10:22:02 +0800
Subject: Re: [PATCH] ACPI: APEI: Fix ERST timeout unit conversion
To: Nirmoy Das <nirmoyd@nvidia.com>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Kees Cook
	<kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
	<gpiccoli@igalia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Jeshua Smith
	<jeshuas@nvidia.com>
References: <20260721182551.2434933-1-nirmoyd@nvidia.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <943f855a-67d8-7a8e-a7aa-374845807d8e@huawei.com>
Date: Tue, 28 Jul 2026 10:22:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260721182551.2434933-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/7/22 2:25, Nirmoy Das wrote:
> The ACPI specification defines bits 63:32 returned by
> GET_EXECUTE_OPERATION_TIMINGS as the maximum execution time in
> microseconds. erst_get_timeout() instead multiplies the value by
> NSEC_PER_MSEC.
> 
> Use NSEC_PER_USEC to express the firmware-provided microsecond timeout
> in the nanosecond units expected by erst_timedout().
> 
> Fixes: fac475aab70b ("ACPI: APEI: Use ERST timeout for slow devices")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>   drivers/acpi/apei/erst.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index bf65e34615314..15ab797641cfc 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -108,7 +108,7 @@ static inline u64 erst_get_timeout(void)
>   
>   	if (erst_erange.attr & ERST_RANGE_SLOW) {
>   		timeout = ((erst_erange.timings & ERST_EXEC_TIMING_MAX_MASK) >>
> -			ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;
> +			ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_USEC;

Good catch! In the latest ACPI 6.6 spec, it says:

[63:32] value in *microseconds* that the platform expects
would be the maximum amount of time it will take to
process and complete an EXECUTE_OPERATION.

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
