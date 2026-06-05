Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5D4219EF
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642591; cv=none; b=Gg34LPqEvdOsRKCmk29n271XycmngKgVM8vM2oGxajs0C4gIfnkNz6OFtfPpjqoVlUe+qrAHEC8OCsIxJ1/KODrXWTUuYDgXTQiwtPJ1mAiMIfvkMttm3hlHVq9j9hDrz/vWCNo26czmYlO3jAvwRAORyko8UgIZoS3mS6HEkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642591; c=relaxed/simple;
	bh=ZDvo2JB+1+eOw28zDMz66JG84t71fIwb6lfT3Y+53hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2PCo806XiP5rWeCh2rJHnG0ZyL7OSW/wcjh61/VpSPn/+vKKEXWugGJAzq+eVfPr7mvkym9XHE5MyzavNHEsABoO/81g16Xtb2KH+YlRGaFaNSxrnPBeeDFRpbwX4XsvDIOdOrECpsBoRpGQokcO5ongIHu2SbZwPMdkosqtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQIGjZpy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQIGjZpy"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso1059021f8f.3
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780642587; x=1781247387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCTmNu4jgb4r7pFyMhscOVe9W8lUl5WIYLcG+5Yn3NU=;
        b=EQIGjZpyoAPkkcw+DI2ludlABPF7YBAfaO5u5q9WUzEwR9Au3BAIBfNI5JiymA3yHS
         e4LLgDW54CbO71ZclsAExlKkkSB3Fv1CAY5YMahFyx0u+nGmbIkSh35qGFGI5RTGXfal
         9jszspuhlcxaLz4yHDy6I425umatBDOqUhWpxfW+jwrK3G7HN54ls+o3ieiNZFlveti6
         kpEZB+dAHhK6tVjkx5EGGSbyjpRHkczD7tr6FowAm8r8tnmkpkUx8l7ygL9QjjRt1EB8
         R58ZS+9XSWHua2tiYtLLmE2CX+uOgqz+D3jg3rcCigECa5duPegtbObKCP/jlCPjFNKU
         aFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780642587; x=1781247387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCTmNu4jgb4r7pFyMhscOVe9W8lUl5WIYLcG+5Yn3NU=;
        b=UxSRLfnirVdmRZLtxukmer1wN4qvt1k3Ny3QA3wU+pk7cPYlypLo/AajAqtDFFybES
         pr3Cd+6StCZ2KVs7WiaPxmqph7GEcAjkJogPAFVTc00LM5H2joYeBYjN4d5mrxTqZZW5
         YQ6gYKA1nrOLuUibod5Kn68W/F4Mzv0+RkuzUObK28w2xo72Tel+1enwor82gB7nP137
         gk7HgUfV6m4rs/NvqieI1G4Uvrcaoki4al5MviSxijQJLq+K2NdZd9kD51xHyplXJt3d
         DpCEEqo0rYOtRogszRYSQFoFDmr+ejlShI86tvcqNuUB2EfZeN107IctmK1qmHpLS1j3
         mDGg==
X-Forwarded-Encrypted: i=1; AFNElJ/k3a4RRG1iKIvFEPIs/cVGZiVS/13Wma+qDFOX5QfF+cqLwlZar4qcZ+Lwxp47n+ydPNRuqy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySPbytx0JxD+q7qGbMQO8Sj15F4NwjueP5wEeTkjU7/EgHFlKL
	R7HH4htc+DygyiYH20UF9bBdHgB5e0eU1sHJ+KuEOsB9Bj0MM6MFmqak
X-Gm-Gg: Acq92OHS9Rx4Tqs1JHPTADkAf8xUnKENGjzlao5zKw30fQIZdiFO8+J982CzxpOXvi/
	cy8jB5c2LOK1arKIU5hRNamG1MlpIW8ks9pwSHUv5f5vAs2iAnLFSbExXgXkShee32UXPI0t5S3
	Lh80sszi9TEdAzFo3/0vYqHz/0ORHAoxN6I05tRX9i5CcdAi2rasV8Hrk7hCiqkcnfTX2HPwX1F
	37VLJsip8mso33S+rYWCd6Bd1iNWOmsyoRxBq9X8jSPyZs+71RWberMuM+1fDMgfOWzUwa7TPk2
	tdzzSCeNieimlT14ar9YEW8b4yf+5njBg9RAjQL9wDvhm+J2/2nqZAb+Ki1TGVmxe2HdnPpOHY1
	L8lH2Ki6w+/Ss/yIzvCdn6X/jkbaLgk1VQ26Rs1xuLUTJzuHlq+OBbsgp+apA9hSGYrjQqObdfV
	NzYrqdGmr3YW2eE58tv93WbwYpCwYtqx8s2R6Z0y8ZHvHestNlM+cW5zHS2FJJLKXSWxQwBUmD3
	sY+DKgXPGRXo/O80TMP0OpopUybn1eNl3Mu
X-Received: by 2002:adf:e006:0:20b0:441:1e8e:d8fd with SMTP id ffacd0b85a97d-46030658bc5mr2487297f8f.29.1780642586855;
        Thu, 04 Jun 2026 23:56:26 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f133:a901:840b:2bf2:919c:cec5? ([2001:9e8:f133:a901:840b:2bf2:919c:cec5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm22537060f8f.2.2026.06.04.23.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 23:56:26 -0700 (PDT)
Message-ID: <e009fc98-73b7-4d3a-9b0b-7b6d37570dc5@gmail.com>
Date: Fri, 5 Jun 2026 08:56:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
 <CAAhV-H6khmNSNLOpVzV2B9qmRVAZkY6w8nYVrJC6QBP5CrFd3w@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAAhV-H6khmNSNLOpVzV2B9qmRVAZkY6w8nYVrJC6QBP5CrFd3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Huacai,

On 05.06.26 05:01, Huacai Chen wrote:
> Hi, Jonas,
>
> On Fri, Jun 5, 2026 at 2:25 AM Jonas Jelonek <jelonek.jonas@gmail.com> wrote:
>> smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
>> marks the CPU offline for the scheduler via set_cpu_online(false) but
>> never informs RCU, so RCU keeps expecting a quiescent state from CPUs
>> that are now spinning forever with interrupts disabled.
>>
>> As long as nothing waits for an RCU grace period after smp_send_stop()
>> this is harmless, which is why it went unnoticed. Since commit
>> 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
>> however, irq_work_sync() calls synchronize_rcu() on architectures without
>> an irq_work self-IPI, i.e. where arch_irq_work_has_interrupt() returns
>> false. That is the asm-generic default used by MIPS. Any irq_work_sync()
>> issued in the reboot/shutdown path after smp_send_stop() then blocks on
>> a grace period that can never complete, hanging the reboot:
>>
>>   WARNING: CPU: 0 PID: 15 at kernel/irq_work.c:144 irq_work_queue_on
>>   ...
>>   rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>   rcu: Offline CPU 1 blocking current GP.
>>   rcu: Offline CPU 2 blocking current GP.
>>   rcu: Offline CPU 3 blocking current GP.
>>
>> This issue popped up during kernel bump downstream in OpenWrt from
>> 6.18.33 to 6.18.34, since the suspected change has been backported to
>> 6.18 stable branch [1].
> Now 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single()
> on PREEMPT_RT") has been backported to as early as 6.1 LTS.

Yes, as also pointed out by Sebastian I should adjust this paragraph
to be more accurate.

>> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
>> generic CPU-hotplug offline path (and arm64's stop handling), so RCU stops
>> waiting on the parked CPUs and grace periods can still complete.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=18c0456ea2615b1a743a6db739c74411c3b42bc6
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
> I'm not sure but maybe it is better to before local_irq_disable()?

rcutree_report_cpu_dead() starts with lockdep_assert_irqs_disabled() so
it needs IRQs disabled already.

> Huacai
>>         while (1);
>>  }
>>
>> --
>> 2.51.0
>>
>>

Best,
Jonas
