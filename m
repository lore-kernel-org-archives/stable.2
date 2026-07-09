Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AD2D3A60
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616184; cv=none; b=LqrgNiQchkxDXEghKms6JaRA6BBlKzwQ3HL0P3AOoVlPlUSlxtQqazz6lDC3+976/RKsWomiIo5VOSEfz4zkb561+g96ZU7lk4aLfxiZ3HGWu2vP8bbbTD7N/Bma9qikrQ8dtBVYCff+rOYHlRKo8o90BygwuBCJcLdSUMj1mC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616184; c=relaxed/simple;
	bh=mJENbzgctRGn35af/XgacrGkfki9wBVujHBixMSaqf8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=gsOfIa9cilCv7VAkso87vBCsA3KevdYVzZUImgCtU86NpY6GZgEuWwkjh7AQ8+hsBWfoiwmTkkn0esoF7xQJZnD4DBAJeIQjvvwTE5JjKOGA73T77SgEAHXDAHw98FuXGOF52T1gNaAFN6bC6onF3h6ieikkvZcwG389n3jv1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLSwpJU/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLSwpJU/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c7c61b5292so38435815ad.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783616182; x=1784220982; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LxRJKp6D1ptC4y5YnQZ3DSiE42VBKKscZdC4o85YzcU=;
        b=TLSwpJU/7gh7MtgxFW9FKC937zHoma/csrV6QsxDMm00B5Wvo+6ad9jMR435hzeYyz
         cv5wdYNZ8E3YztLNT4JY6EIwzoTkvoBXTZ1U0A7Ar2nQBmijXPsJe6+rvRdOp/RjYoKs
         AkQvIQwL0AUgzAI/iUGxNc5SeIsDTTPRStznKvfOvI+04uZobebgf44v8hzMf3MvJEwt
         nfLwuG3I9WiVD/4JCrwqVgR1uHeWSO0iWaPaxW1XEFlZwGTnAfQdHdSe8VoYhZOlF8a8
         DEfJ3Cf8xx/UiUYnChnha4r2zBQ43m/evMw6M6LHu5JLR7SbeNbVy9SFdwG5knfd7FM+
         bKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616182; x=1784220982;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxRJKp6D1ptC4y5YnQZ3DSiE42VBKKscZdC4o85YzcU=;
        b=Sbz+ef31y4/fOQ3oGWzbwYJHwY8bjyWUP64kwLdS0r62Mm2MArLPNYmeKD7S0yHEcE
         20W4CiZ/ySAt15tI/HK4QDFTd3qPzFQg4YpFyKd7e+Hqq96r+UrPRg9fA9A42vt44NHU
         Fo1xUiqXZg2N5Ldh5o/RX7H0toZOoTZDnK53az/N5jdV46OJYT/VB2KWE3R9tPIV273E
         pOk1K2oaH1dYPBHWDm6ZAb5fTIr3ulCaeVqgTSgmXEcp5li1ttYw7bW7PlhazWRgudKE
         JOzsRCzxmaVOEJIzKHiyw3R6beEvRm2q9a8yFu0yurMEyT7IitRyqSwTSE4d5H2pcrJU
         AgcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZs9w6RT3LUX2AhE9Vn/zlk9FTfbd6dM2366jv8aOU9RHyHzX3kEKqYVEqtogCygK3foeX/Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vjugf5SR4SZ+ef/G+6/njxLGlVoPSQTWKnFMRF1htkCBwk/e
	HTAThKK+8q1Ge3P3TnrY4F6gsVUHSc6xQik0puDkEMr+c3Hr+CEuUAda
X-Gm-Gg: AfdE7ckhgaREqdfAJEWgIKqOcj230wiP/I92yZ0NVf3J+TOZmE6sBCgb8pf281Gwn3/
	1K/IMVZYWJm3H0O7XBogIkRMX9+H7S8aUr5m6/2Tw1cnkCM6LgnfUkfSLGxK9DavS2sEEUQ3Hi1
	1Y+TKXYLdQiIigpcsYhGF3jmCgtjRwey2cNJQNDBjJjVQP6BHCwAOlodEOaAKo3PMLQma7YKBLa
	4QjiRfmOqVwJUQ8fKOcmWAg/bIQqov4RMzXN4kIH1VsZjURBQpLCsimny5S8aOeix4Imyc8mcNv
	R6JgPHLTAM/77lfa1oXh1x6LXk/oQWWZR8HEBjng4ewggoMGJicylrlsQXuYf7o2n4pwa9T5jxX
	QD0k18rKni/VQkV7sxhc83xTM6nFwZqRmylo8EoN14fBpOAGw1jKlH5Cl3LP0ltTX9MVrYVVaOL
	XPHP7aIBn6IPI=
X-Received: by 2002:a05:6a21:512:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c0bcfea433mr9860874637.21.1783616181907;
        Thu, 09 Jul 2026 09:56:21 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm32344548c88.0.2026.07.09.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:56:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, sourabhjain@linux.ibm.com, stable@vger.kernel.org, Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/crash: stop watchdogs before booting kdump kernel
In-Reply-To: <20260603070217.483696-2-sourabhjain@linux.ibm.com>
Date: Thu, 09 Jul 2026 22:01:02 +0530
Message-ID: <4ii8w2ex.ritesh.list@gmail.com>
References: <20260603070217.483696-1-sourabhjain@linux.ibm.com> <20260603070217.483696-2-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> On pseries LPAR systems, watchdog timers configured from userspace
> can remain active after a kernel panic. During panic triggered crash
> dump capture, the crashing kernel jumps directly to the kdump kernel
> without shutting down userspace services. As a result, active
> watchdogs are not stopped before entering the kdump kernel.
>
> If dump capture takes longer than the watchdog timeout, PHYP resets
> the LPAR before dump collection completes, resulting in dump capture
> failure.
>
> Fix this by issuing the H_WATCHDOG hcall on the crash shutdown path
> to stop all active watchdogs before booting the kdump kernel.
>

Nice catch!

> Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
> Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kexec/crash.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index e6539f213b3d..5651523e3a70 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -28,6 +28,7 @@
>  #include <asm/interrupt.h>
>  #include <asm/kexec_ranges.h>
>  #include <asm/crashdump-ppc64.h>
> +#include <asm/hvcall.h>
>  

would be nice, if we could avoid papr specific header into common crash.c

>  /*
>   * The primary CPU waits a while for all secondary CPUs to enter. This is to
> @@ -352,6 +353,28 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
>  }
>  EXPORT_SYMBOL(crash_shutdown_unregister);
>  
> +/**
> + * stop_watchdogs - Stop active watchdogs before entering kdump kernel
> + * On pseries LPAR systems, watchdogs configured from userspace remain
> + * active after a kernel panic because userspace services are not shut
> + * down on the kdump crash path. If a watchdog expires while the kdump
> + * kernel is collecting the dump, PHYP resets the LPAR and dump capture
> + * fails
> + *
> + *   0x200UL : watchdog stop operation
> + *   -1      : watchdog number, disable all watchdogs
> + */
> +static void stop_watchdogs(void)
> +{
> +	if (firmware_has_feature(FW_FEATURE_LPAR)) {
> +		int rc;

ditto.
Also I guess this could be FW_FEATURE_WATCHDOG

> +
> +		rc = plpar_hcall_norets_notrace(H_WATCHDOG, 0x200UL, -1);

- 0x200 is hardcoded.
- -1 is hardcoded.
- I think it's return value is long.

> +		if (rc != H_SUCCESS && rc != H_NOOP)
> +			pr_warn("crash: failed to stop watchdogs\n");

Let's print rc as well.

> +	}
> +}
> +

Looking at the code, we already have a mechanism to register a crash
shutdown handler which anyways is getting called from
default_machine_crash_shutdown(). So, I think we could use this generic
crash handler register mechanism and keep the wdt specific calls within
pseries/setup.c file...

...How about something like this? 

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 50b26ed8432d..4e557694d724 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -59,6 +59,7 @@
 #include <asm/xics.h>
 #include <asm/xive.h>
 #include <asm/papr-sysparm.h>
+#include <asm/papr-watchdog.h>
 #include <asm/ppc-pci.h>
 #include <asm/i8259.h>
 #include <asm/udbg.h>
@@ -185,14 +186,42 @@ static void __init fwnmi_init(void)
 #endif
 }

<...>

+static void pseries_crash_stop_watchdogs(void)
+{
+       long rc;
+
+       rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
+                                       PSERIES_WDT_NUM_ALL);
+       if (rc != H_SUCCESS && rc != H_NOOP)
+               pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
+}
+
 /*
  * Affix a device for the first timer to the platform bus if
  * we have firmware support for the H_WATCHDOG hypercall.
  */
 static __init int pseries_wdt_init(void)
 {
-       if (firmware_has_feature(FW_FEATURE_WATCHDOG))
-               platform_device_register_simple("pseries-wdt", 0, NULL, 0);
+       if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
+               return 0;
+
+       platform_device_register_simple("pseries-wdt", 0, NULL, 0);
+
+       if (crash_shutdown_register(pseries_crash_stop_watchdogs))
+               pr_warn("Could not register watchdog crash shutdown handler\n");
+
        return 0;
 }
 machine_subsys_initcall(pseries, pseries_wdt_init);


Note that I added papr-watchdog.h header file in above. I am guessing we
can move some definitions from drivers/watchdog/pseries-wdt.c to
arch/powerpc/include/asm/papr-watchdog.h in a separate patch before this
change.

I think you get the idea. Can you try this way and let me know if this works?

-ritesh

>  void default_machine_crash_shutdown(struct pt_regs *regs)
>  {
>  	volatile unsigned int i;
> @@ -360,6 +383,8 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
>  	if (TRAP(regs) == INTERRUPT_SYSTEM_RESET)
>  		is_via_system_reset = 1;
>  
> +	stop_watchdogs();
> +
>  	if (IS_ENABLED(CONFIG_SMP))
>  		crash_smp_send_stop();
>  	else
> -- 
> 2.52.0
