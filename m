Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B43B47D5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506815; cv=none; b=AVmoPMgvzTqV8scwXbv1cjC7lBXlRjgqlsEQvdRNZehQeBj6v9CWI+SstkJNEy8Lvua1eDadOqwk4DsqNGaOkmUi1BYN97thAHHwrg15jlC6pE7NZC5pTDZrVBOqXI/kX4eReL4EdD0d6Y84bu79+3Qq59dMQ0cnnJWtMngSfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506815; c=relaxed/simple;
	bh=gn2ssXC1ejqemrvTuLo38/1m205JY8o5WvjCLUAl4Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eyel46IljNPnY3jBfzl5a/wMhCex/p6vhxWxW60CiaEikFHJdm020EdWyko6tRnV5/aUKUlRySFAtb+CYufNVcUggSF7G95YDpAjn0AmThJ+SStX12/F10PzkskfZbsnfNJC3R46srPHNyTaDpyvlA/XXyas+ZnVRqtGm1A7CXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCd2ju4M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCd2ju4M"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso21841475e9.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781506811; x=1782111611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8w8xq/4mVkW1zPaq+z+yq8eteQWjYrXoGXcozsWmpc=;
        b=HCd2ju4MSe05WVZ7QBJNvt1sn29Aw6eWWAmH2k7qUC+bQYb53gEtEvEuOcKaLZWlOe
         JfWmgb4NJxLA61916hpTSFWc1qCtvZS5R8/CQj0sduFSSEuO0WDdAKjBRAW7MtYINEY6
         0VVSGKZh6nYlij46mLLDeCIADSt15jRSr4lCh9YquPVJVROsdEKaJnuO43vS/fO337PM
         Gm7nhL3xFAlBYllxgAE2HVJlQCHEjEIis5IS6b/URCgq0cDARar9J4tBcQIORFBSCt8d
         6m1CmNzUk9v5i37gDwRZh18jtyuMmwJNVfEyHAQx46/pE41EyYyoa+t59/lnwY9UacTo
         GTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781506811; x=1782111611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8w8xq/4mVkW1zPaq+z+yq8eteQWjYrXoGXcozsWmpc=;
        b=oN255cdIIBvV9nQuWrcVzj72722PrKj5b+nihPILAXqpwkQ8DWL8p3+G20djsC8LxQ
         FDxnWyiUZ6KMEVrpXLG43+BU+ongjwJ8S07homwjkd8HTKAbA0uubZrPNJYfs8BoP4Ib
         8n/8wMkM1XAqR7MrPxxIuSOjsjp2kDmuSBu/xgR1BrwsXBpB20j735FQb56CJOG06ObG
         z0e1/XknSjg30GvYebRXCndy3JJPTXSX/kk4waH8YIEXYDon+8E8P3CCV3autooJZFlL
         hfhVUB8MnEvFZ5hAPt412dcEWyDnSkq7wGN6LyrrwlFzpQj69AifS8o/nMrK1KyZ3QSN
         wRRg==
X-Forwarded-Encrypted: i=1; AFNElJ9dS075/5RSmzQHh3hNRdYyt5XVlLmtKfMGyBBnAaSQLA1mSycnV9mAfR74PnUHaiMkpI6ek5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLvyU5QMsmsY9ftV2AzfTzgxy97ISZhi+wZhFhIHGxf+JmpuN
	Fj6sSO7cAH/IXfp8bl2Bu55LcZwYazCVJbRUWvUudYim3lkeWClO/+w5
X-Gm-Gg: Acq92OF8xRfnqm+LAnf3eXz81ufMlIE+5CG/JRN2GQENGKnqV2+eF86W7kiY4OcEscb
	JTCxV+7VpG4HNVohc+FCGskmtoQ5KSfF299yXkEWxDMnydMCNhiZcWgdKq+nc52zNgI2kRsTlDB
	i+DrVeDLdfSngXnmMfRtmxod5nrWRdBdE6BfrFjjfX1Q+mhqfsuWjBy6rLQmTmY1yjlDePvXBXd
	v1byTXccacQFODH64LS1pLF3kABj/lLXRpyB/na9qcxlbURLICZFJ3CmIt0lw+U3v5at6dt8BX5
	pF/x19Qn/RrK8Wmzufl1/KpB7fdvC6v18fVD1iwL7/HccAYmkfmDHR3RiWHyjgjVe84qn9/jc44
	smek1T3U2DnhzHFq4G8vE0xJxveZqL6U1mwBMezT5Av7tgKbWiPo2KJnIZGpS3UMIXv1X5GW8bm
	Do9RnL3iTnhrdRZpeOqQEv/Sif+sDA96ndfNCCnaPonkC/hjxCf7XuFeoo7FwvwmCPsfRzCTsRH
	Futw2OGEJmmVZbVVXXjPgpNYQ==
X-Received: by 2002:a05:600d:6447:10b0:490:e18f:d108 with SMTP id 5b1f17b1804b1-490ec501b2cmr122824265e9.19.1781506810190;
        Mon, 15 Jun 2026 00:00:10 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f12e:9401:c875:96a4:7b6f:72fd? ([2001:9e8:f12e:9401:c875:96a4:7b6f:72fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4a399fsm217664565e9.0.2026.06.15.00.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 00:00:09 -0700 (PDT)
Message-ID: <731bd6c4-0f70-45a2-8480-8fed315b82b4@gmail.com>
Date: Mon, 15 Jun 2026 09:00:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Huacai,

sorry for the reply delay.

On 10.06.26 08:05, Huacai Chen wrote:
> [...]
> In theory LoongArch has the same problem, but I cannot reproduce,
> should I enable PREEMPT_RT? Or there are some special configurations?

Sadly I cannot help with that. For MIPS, this seems to be the default
behavior.

> Huacai
>
>> This issue was noticed on several Realtek MIPS switch SoCs (MIPS
>> interAptiv) and came up during kernel bump downstream in OpenWrt from
>> 6.18.33 to 6.18.34, after the backport of the patch to the 6.18 stable
>> branch. The patch also has been backported all the way back to 6.1.
>>
>> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
>> generic CPU-hotplug offline path, so RCU stops waiting on the parked CPUs
>> and grace periods can still complete. MIPS shuts down all CPUs here
>> without going through the CPU-hotplug mechanism, so this report is not
>> otherwise issued. Reporting a dying CPU to RCU outside the regular hotplug
>> offline path is not unprecedented: arm64 does the same in cpu_die_early().
>> There it is an exception for a CPU that was coming online and is aborting
>> bringup, rather than the default shutdown action as on MIPS.
>>
>> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>>
>> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>> index 4868e79f3b30..0f28b4a62e72 100644
>> --- a/arch/mips/kernel/smp.c
>> +++ b/arch/mips/kernel/smp.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/sched/mm.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/cpu.h>
>> +#include <linux/rcupdate.h>
>>  #include <linux/err.h>
>>  #include <linux/ftrace.h>
>>  #include <linux/irqdomain.h>
>> @@ -422,6 +423,7 @@ static void stop_this_cpu(void *dummy)
>>         set_cpu_online(smp_processor_id(), false);
>>         calculate_cpu_foreign_map();
>>         local_irq_disable();
>> +       rcutree_report_cpu_dead();
>>         while (1);
>>  }
>>
>> --
>> 2.51.0
>>
>>

Best,
Jonas
