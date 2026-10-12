Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59E2DC76A;
	Mon, 12 Oct 2026 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814439; cv=none; b=CNSmMxFhw3P904PLD2nNYswBsetNqS5UHGpO9Vt12IQh4ODVbX8yXXz1k5IWz71/Q2oWxn/sIqwIoUs7X556yWMcXyEfzh4QoyiaFPQbaQjpA5KRef5FFi7pMsPbrU32hX8lMi0XbjWfkwqUju9HZw+OzCWsT3WuLdj+rSOwPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814439; c=relaxed/simple;
	bh=sVjwzLwnuDqiviKytairRzYj03flAp468AiTMTx6u1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnGQw7zA0AKY232hJ6jPIgZLwZK0a/Eqk3uvcXXHlCt0jeUt2PEDCKhVbqx+d1ImRV0wYpb1/LRkf6uFpmihg8WA3ZT4UuxRIawd5+acFLUEdlvPuvpDu0Ywz88sAE3REtHKcGWnzOap1877ckESFswl5XnOVVjsIidsrmoBcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7B2nYFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7B2nYFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740251F0089B;
	Mon, 12 Oct 2026 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791814438;
	bh=zChgm/anlnY6ygtPI9Yk+VQtQC58PsyggIibaqDgkac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J7B2nYFybMsRL3Ck30yqtH5FyF+LryI0O9muAH7glRL9PjGCiAVtRMJR+f2DsqY5r
	 xRCSjD1pC/KgDsa1TXdn1tuZRxGhsNffINpNrCb4ELmHcZHaOAuLKawB8QibV7wbV1
	 CFy7S1F8WEXeQQt2lfyjgAIQWyrrhhUSLJONRJXWc9dC+0AQwjf7TcvYo4wfmOErED
	 va/EGB1X6qEWxcnwcEkFSDZwtUI8PBwMTpmnUsdV5HmsAxPhtScgAKucA7cIwM4Bwx
	 mfO5e8ihXqTvGAghRoSVslKAu+GRq1FRkFVIEPg95pbSCf09gGJGu8fbPwOJpLlBI3
	 AVyejWw36sY+w==
Message-ID: <e00ab521-bd98-447a-9553-1f6265b822d9@kernel.org>
Date: Mon, 12 Oct 2026 09:13:55 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86/amd/pmc: Fix RTC reference leak in
 amd_pmc_verify_czn_rtc()
Content-Language: en-US
To: Ma Ke <make_ruc2021@163.com>, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, alexandre.belloni@bootlin.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org
References: <20261011121759.3267678-1-make_ruc2021@163.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261011121759.3267678-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/11/26 07:17, Ma Ke wrote:
> amd_pmc_verify_czn_rtc() opens the RTC with rtc_class_open(), which
> takes both a device reference and a module reference on the RTC
> driver. The matching release is rtc_class_close(), and it is never
> called. Every return path after the device has been opened, the ones
> that return 0 as well as the ones that report an error, leaves both
> references behind, so each S0i3 suspend leaks them.
> 
> Release the reference with a __free() cleanup on the declaration,
> which covers every return path without adding labels.
> 
> rtc_class_close() does not accept a NULL argument, so the cleanup
> helper has to guard against one: rtc_class_open() may fail and the
> declaration still has to be cleaned up.
> 
> Found by code review.
> 
> Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
> Changes in v3:
> - Define DEFINE_FREE(rtc_class_close, ...) in include/linux/rtc.h rather
>    than locally in pmc.c, since it belongs with the API it wraps.
>    Suggested by Ilpo Järvinen.
> - Guard the cleanup against a NULL rtc_device; rtc_class_close() does not
>    handle one.
> - Move the __free() declaration to the assignment, as described in the
>    comment in <linux/cleanup.h>.
> - Cc the RTC maintainer and list, since v3 touches include/linux/rtc.h.
> 
> Changes in v2:
> - Replace the added goto labels with a __free() cleanup on the
>    declaration, as suggested by Mario Limonciello and Ilpo Järvinen.
> ---
>   drivers/platform/x86/amd/pmc/pmc.c | 5 +++--
>   include/linux/rtc.h                | 2 ++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 6792aa2c6187..f96e8a358eb7 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -14,6 +14,7 @@
>   #include <linux/array_size.h>
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/cleanup.h>
>   #include <linux/debugfs.h>
>   #include <linux/delay.h>
>   #include <linux/dmi.h>
> @@ -648,7 +649,6 @@ static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
>   
>   static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>   {
> -	struct rtc_device *rtc_device;
>   	time64_t then, now, duration;
>   	struct rtc_wkalrm alarm;
>   	struct rtc_time tm;
> @@ -664,7 +664,8 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>   	if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
>   		return 0;
>   
> -	rtc_device = rtc_class_open("rtc0");
> +	struct rtc_device *rtc_device __free(rtc_class_close) =
> +		rtc_class_open("rtc0");
>   	if (!rtc_device)
>   		return 0;
>   	rc = rtc_read_next_alarm(rtc_device, &alarm);
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index c09fc22819d0..0f43b5027235 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -13,6 +13,7 @@
>   #define _LINUX_RTC_H_
>   
>   
> +#include <linux/cleanup.h>
>   #include <linux/types.h>
>   #include <linux/interrupt.h>
>   #include <linux/nvmem-provider.h>
> @@ -201,6 +202,7 @@ extern void rtc_update_irq(struct rtc_device *rtc,
>   
>   extern struct rtc_device *rtc_class_open(const char *name);
>   extern void rtc_class_close(struct rtc_device *rtc);
> +DEFINE_FREE(rtc_class_close, struct rtc_device *, if (_T) rtc_class_close(_T));
>   
>   extern int rtc_irq_set_state(struct rtc_device *rtc, int enabled);
>   extern int rtc_irq_set_freq(struct rtc_device *rtc, int freq);

