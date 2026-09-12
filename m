Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E7224B05;
	Sat, 12 Sep 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184178; cv=none; b=mw/9sbaItFldKfuaTrgfH831K81TlfagJ+BWirhJ0JKlq0woZy34rFnpnBOplr2HqTcoNgTzT9g2AYDG1zxETxrXsT5ihE6GO3d4O0xcxOoHXXWLEWYk/7YSgwbWnl2Ohd8MU55l5sRlwMu3nBz2DbIcWLMlXShhUl/JXD8tQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184178; c=relaxed/simple;
	bh=EpZ6j2bTxc/TQ71LdovCHSO2o+cU1b+DPT7FT1SlkCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAwXVeh65Fd/Zbqwc9qrONImiZIe0AjfuudlwyDqFgOjizcnMoqNuiIZwZxA8MVDOfBXAbecHcXN2jS5hcQXdzXrR9n5e5AvznLCyyvsCSHwGh3f0UtKh0c+vkWtEEn8WVPDguNA7LTiUW0GWy0OcgOY5gVlUHAiOkAmPJHlDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=O8VKpYDp; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O8VKpYDp"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hhcWr616szKnW5;
	Sat, 12 Sep 2026 05:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789184168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=or6iSFDqXd+CZU1JKZS6bDuUBfaHBa3v2MYKJQpV0z4=;
	b=O8VKpYDpouBVk4IdgBvg//9oqP/8SAVYAhiAo0uc2bxwFeZpAQ+NzBmJRSRn0JJXYwLlEP
	C6DOBYq1e3oMylz+UUiF/xicd2Q/Z41CohvG9f2DTCT9C4pXhiy5crqq1dsZDDJ/DEbZto
	BV/z6i2RMBRV7Qr9OYGZ29L9Tz8HurX+U8fHmzTCDvyUS6c+WdxHifvsjOvof+AMMepbTt
	IsOgFcXSlurldQMKVjeszhMU9vPrkcg4Jquk3sOTolU2YDxCvsJMB2KGALIIdbDmGfJJQE
	ARHDNeWBrJseqeVBGO55YpDcH4k3RJdRXXUSiSL41OMyEGs/eQNFn3FDEKUH8A==
Date: Fri, 11 Sep 2026 20:35:56 -0700
From: Roman Kisel <vdso@mailbox.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: glx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	decui@microsoft.com, yunhong.jiang@linux.intel.com,
	ricardo.neri-calderon@linux.intel.com, rahul.tanwar@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
Message-ID: <aqTInOmsyr8AiciA@xps-8930>
References: <20260831082528.1623843-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831082528.1623843-1-namjain@linux.microsoft.com>
X-MBO-RS-META: jtxs5yqspmypysgsh4udaqisz4pi914f
X-MBO-RS-ID: 47d219f6da6d1010c08

On Mon, Aug 31, 2026 at 08:25:28AM +0000, Naman Jain wrote:
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
>  arch/x86/kernel/x86_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 252c5827d0634..3b9b41820c84c 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -37,7 +37,7 @@ static void iommu_shutdown_noop(void) { }
>  bool __init bool_x86_init_noop(void) { return false; }
>  void x86_op_int_noop(int cpu) { }
>  int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
> -void get_rtc_noop(struct timespec64 *now) { }
> +void get_rtc_noop(struct timespec64 *now) { *now = (struct timespec64){0}; }

Hi Naman,

Could be

*now = (struct timespec64){};

to save a byte :)

LGTM.
Reviewed-by: Roman Kisel <vdso@mailbox.org>

>  
>  static __initconst const struct of_device_id of_cmos_match[] = {
>  	{ .compatible = "motorola,mc146818" },
> -- 
> 2.43.0
> 
