Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9F31D72E
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855608; cv=none; b=NjLPyOsLKa/r3iPs6nqEnTQSTMN4S5FvfAZwtCi7O4zDFvyAT7HESCKfdpGBRr45fnYe4n4rAD+A41i1Y/zHv5KXZYc8EF+jD6jm6j8r/TFZjBgjzIAmeYfwvOyebq2niG8rnULTQ5grRjUAtDXAHQFonkNZiFL4laBsHsXcwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855608; c=relaxed/simple;
	bh=pX91VZCWjtVn5XntwhIUKqRT2u2/AIqeQRmuIFxuWiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkalquUILn61TB/b54Tfu27MY+s/mufmOBK/nAwlg1Ky7PeEPaqDK91DD+iUwLKA8PfkHusZSRowc0weVASuc9Rbw0H14CP+AmmCrvJbw9obU8cLe1jLkE6kUB7D4UQodgttOqejKOX7EOpcmhkqvSU0KbPKBcbUjHzhKsi3f9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkvNMFll; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkvNMFll"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eeba68948so1327329f8f.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781855604; x=1782460404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pX91VZCWjtVn5XntwhIUKqRT2u2/AIqeQRmuIFxuWiE=;
        b=PkvNMFllKGIedUb0Bm4nByFfWNXN+yPpPnOB5OBzqSj41TPUcJaRUjVD/BIu/IcAe4
         M/am1Vm1FzjapfXqM/XhGZdpoEVJKgh00OihjuuU1bNsK6CKmLp/LO7zILR/RZL/bh+N
         kz/GjVcWdYKyCDYWdwytS+3obKrsZhcbjhvjPO9TWUM6HN/SQITp2/ER/T1nMcL7oWYU
         fqOTjX4GkBx3QxgM7t2w4kqXLdrYOw6cGqRHiMS3GH+kB8BsvkIXWZbKPxQet1jAev52
         YvuPd0DlHSZnbxSMGkf9wZsGNHIljjPGFLTIHVU7fzVBR8qLsqDal6PAux3e4RJqSLpJ
         MzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781855604; x=1782460404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX91VZCWjtVn5XntwhIUKqRT2u2/AIqeQRmuIFxuWiE=;
        b=CjX6EklusVHxd+iOau6aUICt6oxNOi7DOHqhAPkZQjoKfFMQcbyfiavc3JrbjvE7H3
         UD+DhTSocC360ZuoXRkLpHB+p09nwEN5dHT+A1aTsEOY5oIQ4tsgS3wySqbHQlx1x1g6
         oeIKLXP6nKujDumRTtZQGnJrVWj3p/f0606PmhdDWJ8e1ulImpFyRA0szNNN26CkBcgw
         iORpn4KVhvxBfYl3tXrgAj9rlTI98b08+rqhJaerioc5eCc7IhZiMOH6ppHisfw8Tsqa
         4bM4+JTcNTAVmv7p9YwaMR+bxUtnQoOOzq4P9gLsuOuvBL6+7pndPRPPG0BUfhmTo0MR
         4Oyg==
X-Forwarded-Encrypted: i=1; AFNElJ9cQugGH1iXpMhNeO5p7E8YQ8Ivuh2VTZXIX4kmkFcw146s2q5Um0o/B2GIlFJqbQ27cPe03QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQN1bPWIyuxe5w1BXhdi1wc1TtIm5rrpqP+stUUg4GcIEleXcR
	9VXlP1XDz0TAbe6XyYyM3eeGbbKAXXfkap7B6ohm1ow8j12pV+TkN+WI
X-Gm-Gg: AfdE7clPWZ0LHmhsb3e9ZfRVF4aqouevMWM8fI4l1D2KkAOZxpJ82AodhWlXUHDZWfb
	eO8/C7Xqv27cKrsqNFHIYxBrts4Ana2nOO0TQLKgBw7dgcnyoRfnHylSPy/w0EubEwH0IEzig7V
	qnwrbSzIVigo6tzjrdrc/YZCoVlKP9d9YS6DFZtfMFbWGZM/VEy5xrkOjAlig/CNnNkPlqSAlJV
	q6e5HSMx6z/+Fweh1cOdUuthuQe/WPYihK8QnCrL8rPh9Ylq8vyT0zlmlZ+409NGE6cP0hyR4ht
	3+PsnMFZt/OruCujkRTUkcBVOITJ6ln7s/ABCWYXAbeNPhwxjuzEcekpt1tsCXU9L7XFRkRHtUG
	F+NnXej/eIUbaQ2hi8c2N9Oxhw+ZaJGT9FHzTIOJ7ynS1yQ4Ry/MjNGRzhZ325Axb04pu3JQUJO
	gj3HKbdllGFiiiul7VazUh821YL85hoZzZVNl6BjKcCvg8DwTY73XYddmhbHnH9tR1zXn3HuAOQ
	huwwdbbZpGmms0=
X-Received: by 2002:adf:e5d0:0:b0:460:6a8f:5d36 with SMTP id ffacd0b85a97d-465085353bfmr3214856f8f.22.1781855603755;
        Fri, 19 Jun 2026 00:53:23 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f106:a001:409c:b132:5c19:42ef? ([2001:9e8:f106:a001:409c:b132:5c19:42ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04b55sm5915595f8f.5.2026.06.19.00.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 00:53:22 -0700 (PDT)
Message-ID: <7130ff1c-7c6e-4a82-868b-7f6c60c98e7d@gmail.com>
Date: Fri, 19 Jun 2026 09:53:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <20260619074323.IIq-0qan@linutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260619074323.IIq-0qan@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 19.06.26 09:43, Sebastian Andrzej Siewior wrote:
> On 2026-06-08 09:37:29 [+0000], Jonas Jelonek wrote:
>> smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
>> marks the CPU offline for the scheduler via set_cpu_online(false) but
>> never informs RCU, so RCU keeps expecting a quiescent state from CPUs
>> that are now spinning forever with interrupts disabled.
> …
>> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Sorry for being late.
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> Sebastian

Thanks to both of you. The patch has been accepted and merged already
(silently) [1]. But I appreciate your reviews a lot.

Best,
Jonas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=9f3f3bdc6d9dac1a5a8262ee7ad0f2ff1527a7e7
