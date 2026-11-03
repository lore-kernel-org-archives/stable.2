Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680938;
	b=5TvXu4R9IUDrvzLVJynzAVCdTzP0FLFytfFq43zc889/2ijKFTWjcKtkg4XVRwlHtKbi
	 GpdTlenU9QSsep5xNFGkIXk7Ji0goYbqhQz00aGaZ9bWdl7qjl0DxYsCielelrvwbEkm3
	 HFggGVxEX7wCzWH7wtU5qK4PZkStlGt1OsT1fruPEFK+DIjQK4Sc7bb7Mbasr6k2o8GIj
	 GdSL8R+GsRVjkSxKgGj3Qp4PKszzNP9MH6XAOLU+OmYqr+cgF1O1SucQWPIoPzQh0xnDk
	 1Knsxl9P6ffnFkoXOAgQ/nD9os1YLHZCnFBx/yzhe3xGGMI5V+JC90xBpF+ah0kGSZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680938;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=+jDiXy0YeUVYl6qgi18TZdd89R1kuxVNQgWs4UJvxUs=;
	b=YoRZ+uv2FMDPZr4lKWEvWsZGN0QuoQhU79F9WibtHGjQ+1EohnV2vWbeBX1R4copOD5M
	 qWb2Daah66mMgd2Tt46ocHz/R5jb+uiyavVZuNQr+T+li0MgzKGnnvEaDXro8HQ5o/c3O
	 StD0XAcQ+CAxmyCxSWL7omvfu/jDsF46rGnf+ehEJk+xThZH09+etWSngfJaIvOS6BAbT
	 8Uf9aC/SpAIsJ4j26l4rNZgnoNrZxA1egNnpxkqdido+lSj8pIP/1pdF78/0OO3OFBts1
	 2ApCAB2l+IYG7cwGNK+7pp1v7Ohw5FktM+uuyeqcjqsb9CN66EH+A9nd92Wpk9TKtlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=epHzCZ4N;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69E606A331;
	Tue,  3 Nov 2026 04:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D69E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=epHzCZ4N
Received: from [10.95.64.190] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id D2E3220B7166;
	Mon,  2 Nov 2026 20:41:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2E3220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793680921;
	bh=+jDiXy0YeUVYl6qgi18TZdd89R1kuxVNQgWs4UJvxUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=epHzCZ4Ny2eTYK4NSsKsMVpPHGukLenXTlKyu8UgwnkXMSBkfx5nnHM76py7uE988
	 U5OArOL1lAaxblbgtCJhxJkUsvAJ/qEO7J+muOvrcRVrfmtMc17/P7R0HWh6DSoPxJ
	 4JQkJqbku/uqBXDdGYQgViShNqi6/BSllDXRAwSc=
Message-ID: <bbdff4da-95a1-40a2-b4f7-3d6335707425@linux.microsoft.com>
Date: Tue, 3 Nov 2026 10:12:11 +0530
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

Hi all,

Gentle ping on this patch. Would it be possible to pick this change
up through the x86 tree?

Thanks,
Naman
