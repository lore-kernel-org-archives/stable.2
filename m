Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D2335BBB;
	Mon, 12 Oct 2026 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782688; cv=none; b=NplojwsxT2uSYeyFWIlQH7TiMlMjffEtre3ZHbluzqO3UvZBouLzJuVQZr/gC+Rd1Xa9iuJo+xtyKRpMUTqqkvFHF23QKa+vkfiu7W97Xbw1IKpQQFTnuUzx2ZnwUT9aKmYPECy6QjV47O3RBPf3BQ6pbJZGhSbd41yDHhHPQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782688; c=relaxed/simple;
	bh=bZ6iLgm/H+UsLcTE2OPxzcWmY4bQaKMngs/ckX7bXEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEn35NuD7KzOv96JsIuXsk+UlS9nTb2RQs0Ma+96aysKDulge5cTn0Qo5nMWv4UdxfFZYi9m3WzlDEKhWHPSJ0KwK4YixIV8mL0TXJ+Cu3OI3z/y3bh9sQHT17ZXN3JAQ34kHaTBffVbzGMwV9kpOAKzuq4VlHO9JYlD1hjTvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=soLGs/nY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="soLGs/nY"
Received: from [10.95.64.165] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B35520B7166;
	Sun, 11 Oct 2026 22:24:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B35520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791782678;
	bh=7yLd5iwwD6WSJBgn9NxP3l6Wd3nU7iXEh4/LdEY2RnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=soLGs/nYpQUB+wk9ZJCgC1cyY99Dj8lxsVXZeVF6i9dvJ47d/OcWW2C2a2EhC5+fz
	 WQB5ct/zVinYL4nmHFqtJkYkgVfe95zqktzFR/7bDDhyD6whhZ9K9Gdg1CqGnY+O1z
	 0V3tnZ8v7j/T137SiVb5dx0uh/gdZ6gEgTbvd2Qk=
Message-ID: <2804567a-828a-46b8-b4bf-9ed6326bcc1e@linux.microsoft.com>
Date: Mon, 12 Oct 2026 10:54:33 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
To: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: hpa@zytor.com, decui@microsoft.com, yunhong.jiang@linux.intel.com,
 ricardo.neri-calderon@linux.intel.com, rahul.tanwar@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 stable@vger.kernel.org
References: <20260831082528.1623843-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260831082528.1623843-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 1:55 PM, Naman Jain wrote:
> get_rtc_noop() is used when an RTC is unavailable, but leaves its output
> argument untouched. When CONFIG_INIT_STACK_ALL_ZERO is not enabled,
> timekeeping_init() may therefore receive a nonzero invalid persistent
> clock value and warn:
> "Persistent clock returned invalid value"
> 
> Initialize the output to zero, the documented representation of an
> unsupported persistent clock.
> 
> Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>   arch/x86/kernel/x86_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 252c5827d0634..3b9b41820c84c 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -37,7 +37,7 @@ static void iommu_shutdown_noop(void) { }
>   bool __init bool_x86_init_noop(void) { return false; }
>   void x86_op_int_noop(int cpu) { }
>   int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
> -void get_rtc_noop(struct timespec64 *now) { }
> +void get_rtc_noop(struct timespec64 *now) { *now = (struct timespec64){0}; }
>   
>   static __initconst const struct of_device_id of_cmos_match[] = {
>   	{ .compatible = "motorola,mc146818" },

Hi Maintainers,
Gentle ping on this patch. Please let me know if there are any comments 
or if any changes are needed from my side.

Regards,
Naman
