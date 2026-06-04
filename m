Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013413D47CE
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553161; cv=none; b=nUx6pPPL8yXzKGKqY7T8iqkZzBI9Dh8gI+oXAIPsQJfbTWqR6dclb5pGOkJcCreBE2RIfI0wzfCoV6yLFhe1OkrZ78yCNze+41aYNqKt+DJ+0IAL7Tb6CCaDftaOzficWG07KEf1ofkyANcKcSeR1bsXQBA9Ce/n+jhS2VOaoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553161; c=relaxed/simple;
	bh=5eswC+KL4APLtyRsks8Cy8JGWs92UNSBQ6FWuiiawDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCQ5XGnnCNAlUxsNQg9WoAX4spH4LrVZkV/OY+Gjjp88144tSYzyCdBMrUstCjDJ0AYctNoPkFsM5vyZlI4q6k8rC/b4YpchvWGluUV4S4WViM1iGa4pitBxF/sH22IzX2i8uCb7qjr7sxZCo9v4/XslNWRcNuzKhb1GvMS+qp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDnF00r2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDnF00r2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa68cf03bfso266893e87.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780553158; x=1781157958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzGDTR4e2e8XTfSWLdmjfHxDAQS69+VmysI4qx6bLeY=;
        b=hDnF00r2LRhSQsuzscr8vexWN0/X57UY/E/Ts2rFky4QstE6Lt94rb/MIwRzvUhUzM
         GOiyDxsyAKUai+//5APkNiH0dF2w/ITf1n6vgPdF4oxvO96jm8jtblG11Qsu/mpH5Tod
         uQggvGUtkhLaUe3FwcjafG4E+xu743I0nTiiRsAe5rduLgfCpB5XutMW6HOjvJv+6HqA
         m4TOzmcO10RtRDgjV+hoyks+iNowcWjYR6b6JJesG0bKm/36hDuiv1H2wHk5TspMrqvO
         BG1DmvoOloruC2lgoMM5WJenXHWAmHq3k544qZY3N617vp6jr+MITlUJ+9JuFzTofXte
         v6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780553158; x=1781157958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzGDTR4e2e8XTfSWLdmjfHxDAQS69+VmysI4qx6bLeY=;
        b=eZCYWtycZ/u6UqJN3Nsyo0P7jrlTYryRAp/9aLkqHWPl35OFmGdvjfDbh019pdr8CR
         bUzscePfu2fCiOUeW+P514BaB3C4KhmBv3ERwU4eDe7rSzq9NXQqI1jQ+7hAqG4y8aev
         KjW2fLE0q5qPfiow3TpJzBBOYxpf56MEnzKlTlCn0Ru7WC61CxeYQpYy0Py9HieAn3ki
         vsLibjwxx+kZ7gopIOg9I18U2Crokxj5wiuzogsNgIxD8LnQNdXc5VwRuLZL4bMr3FfU
         66kVmbPKjaaPK6tRG6sugGMuOgE4r0SfR+BnVM4dMzUWJcy32Noda9Yz7nKSG619RmUR
         vDCA==
X-Forwarded-Encrypted: i=1; AFNElJ/DhcBG+hcR7Dw6zujFg/SS2Gd6p4/PeecavQ7Z686D83Q+p1Tem6sd6i6SHY0ch+uz/5f2yH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCnt6Us5JoELaOEcQ4GZxCa5JZTilPbJZlUiNimzXFvVkynqU
	13lRZvvmdS2VvBMeC9POOvUZP22shZ0eb1tGBxsHjBP1YPiz4EoP9l7B
X-Gm-Gg: Acq92OH/YkVdWaJfO5Ipjw3/TSeORa8p9ngAzBYUUHn/VrsYgvQYQRaVV7Sm2lYcxvN
	OXZKCD/Ey91HHLexlr4UkPPcjPwY9h4YiOl1pZtyIDfgtaxW8gcXfhIjuWgRalcHArhh+xRtuHo
	8TTJ9G1fDtLQzyzwFu9vzqnXPfT5+Bh0AKZJ7Da9uM/CWMsVcd3vmEuqAsZI+5tDk7DuPOu0aNP
	SDxziyDb1vqFoQUuP5R+Y4l6Pd/xiDMjGnx7L2DA35ZKriH+VKvWXB6VBiDEcY7IoLeSRh0IEOP
	88gSS4qmV1zVFNCKglxN/X8Z+eKodT7M2c1XDkOOm4FSLwCttkwXcCPFTujxziKF9hJ6eWTQu+f
	RXuyr0QDpZl5rgdFMJqNSzp4D6covVuHCs2znpXOGGhWQWs7uIovsM9Fe5w9exn3CPnt/rPcDI2
	RaW2HvSNEtmRe/RZGx2klwuCeBlsMwDpmnNfFENPa6GnZ8yRMF96Gt/Mmr23G1M85c15Uzbv6ee
	ayEim7dfv2vn/urWHeanbBadvY3Xw==
X-Received: by 2002:a05:6512:8050:b0:5aa:77b2:fec8 with SMTP id 2adb3069b0e04-5aa7c0ec22amr1475705e87.27.1780553157939;
        Wed, 03 Jun 2026 23:05:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396abf66d87sm14160741fa.1.2026.06.03.23.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 23:05:56 -0700 (PDT)
Message-ID: <dc478208-17ee-49c1-af93-fbebd95be527@gmail.com>
Date: Thu, 4 Jun 2026 09:05:54 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
 <20260518161516.53f21777@jic23-huawei>
 <61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
 <20260520120822.351aa58f@jic23-huawei>
 <0d58842a-aa5c-4d12-9435-3264070038cc@gmail.com>
 <aa2c2f98-454d-489c-a652-b8023b0773bf@gmail.com>
 <20260603182658.2c3c6efa@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260603182658.2c3c6efa@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 20:26, Jonathan Cameron wrote:
> On Fri, 29 May 2026 11:21:40 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 22/05/2026 15:38, Matti Vaittinen wrote:
>>> On 20/05/2026 14:08, Jonathan Cameron wrote:
>>>> On Tue, 19 May 2026 08:48:13 +0300
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:

//snip

>> [  251.368583] irq 64: nobody cared (try booting with the "irqpoll" option)
>> [  251.375463] CPU: 0 UID: 0 PID: 835 Comm: irq/63-2-005d-b Tainted: G
>>           O        7.1.0-rc1-00002-g3b459deb7222-dirty #249 VOLUNTARY
>> [  251.375501] Tainted: [O]=OOT_MODULE
>> [  251.375511] Hardware name: Generic AM33XX (Flattened Device Tree)
>> [  251.375525] Call trace:
>> [  251.375545]  unwind_backtrace from show_stack+0x10/0x14
>> [  251.375607]  show_stack from dump_stack_lvl+0x50/0x64
>> [  251.375646]  dump_stack_lvl from __report_bad_irq+0x30/0xbc
>> [  251.375680]  __report_bad_irq from note_interrupt+0x2b4/0x32c
>> [  251.375722]  note_interrupt from handle_nested_irq+0x13c/0x14c
>> [  251.375758]  handle_nested_irq from iio_trigger_poll_nested+0x4c/0x68
>> [industrialio]
>> [  251.375917]  iio_trigger_poll_nested [industrialio] from
>> bm1390_irq_thread_handler+0x54/0x7c [rohm_bm1390]
>> [  251.375994]  bm1390_irq_thread_handler [rohm_bm1390] from
>> irq_thread_fn+0x1c/0x78
>> [  251.376028]  irq_thread_fn from irq_thread+0x18c/0x324
>> [  251.376057]  irq_thread from kthread+0xf8/0x130
>> [  251.376091]  kthread from ret_from_fork+0x14/0x20
>> [  251.376114] Exception stack(0xe0355fb0 to 0xe0355ff8)
>> [  251.376136] 5fa0:                                     00000000
>> 00000000 00000000 00000000
>> [  251.376156] 5fc0: 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000 00000000
>> [  251.376175] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [  251.376189] handlers:
>> [  251.498714] [<2ec7a5d9>] iio_pollfunc_store_time [industrialio]
>> threaded [<7f4268a2>] bm1390_trigger_handler [rohm_bm1390]
>> [  251.509974] Disabling IRQ #64
>>
>> Message from syslogd@arm at Jan  1 01:17:33 ...
>>    kernel:[  251.509974] Disabling IRQ #64
>> [  252.822500] sched: RT throttling activated
>>
>>
>> Things I very hastly picked up:
>>
>> 1. The throttling mechanism works even though the handling is invoked
>> via iio_trigger_poll_nested(), Probably because this propagates the call
>> to the handle_nested_irq() - which does bookkeeping.
> 
> Great.  At least it squashes something.

Yes. We get the nice trace in logs, clearly pointing to the guilty one.

>>
>> 2. For some reason (which I didn't have time to check yet), the
>> beaglebone black which I used to run this, was not completely blocked by
>> the IRQ. We can see the "Hack, return IRQ_NONE (xxx th)" -prints
>> emerging just fine.
> 
> After the Disabling IRQ #64 message?

No. The prints were spilled out regularly, even before the IRQ got 
disabled. So, CPU was not completely consumed by the IRQs. I am not sure 
if the IRQ thread gets preempted (what is the default scheduling policy 
for IRQ threads?), or if we have some other safety mechanism letting 
other stuff be executed. In any case, the system stayed somewhat responsive.

***

I did also try a hack which returned the IRQ_NONE, but did not call the 
iio_trigger_notify_done(). Result was as expected - the IRQ stayed 
asserted as the bm1390_trigger_handler() was not invoked repeatedly. 
Furthermore, the very helpful log entry was not spilled.

I suppose that now, because the system stayed somewhat responsive (even 
when the IRQ stayed active in the background), it wasn't exactly hard to 
check the IRQ counters and spot the culprit from there.

As a bottom line, I would love to see this fix getting merged, even 
though it doesn't seem as crucial I thought it was. Checking the log is 
still first thing one does when spotting a problem - and the entry there 
was to the point. Not all systems capture IRQ counters when an error 
occurs - while many still capture the kernel logs :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
