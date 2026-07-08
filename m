Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFEB1ABED9;
	Wed,  8 Jul 2026 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490591; cv=none; b=k4gUpWOvtvhOveM5F+6o27WrB7p4qUHHbL55Lvi38K1LFR4hbak6m+i1xb572VZ6b2kHnaNZXHs0PC+ivbZ+bemk1wGT5NxO2BmNv7RNQnI/ABXl0qgzshsBTkouGvMUiPy0hzWsOG5JD6MwVdCAhIIMD3LguACuJtFjHkFq9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490591; c=relaxed/simple;
	bh=gSKIrVdgDbhsjTT7Fwbx/W0AdkIDbkQRquzcDz2U2OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jh0iBGTWMCJre3gm4Jrs39cXMIN3629DTpnhUTv6zMwT6gqtDqmgFrXJ3sVhRWUhuDsKVSnHKI2rNaN+YdRK0CHirkeHu4hFFE46TO+eMR/QgvDQ1k5gY/ATAzaMdYjtjsg9J9NIpNaQRLwpyBcpFOl4ruYo5z45UuAX0UMkqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS1igjd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS1igjd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F071F000E9;
	Wed,  8 Jul 2026 06:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783490589;
	bh=Fj0iGrfuPytQrb9kpP8/968TUDgqCaTRyYSgg+8fF50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VS1igjd+3YmBZqpEuQoiMIY5jWsl1riPbUXso0rwL+OMjlUUIU+30bmzLg2xDhivU
	 HcCwgb9O/Lm3a5hMot8aOkDOvxO2YIKXk/FO9zlsuVYRhplNgGYLkFLGkEf8X8P4Ye
	 U2XlpF2qg3YG65tJflmLZy/qYkmweh7gWW+qxlhJeQdBc2pDtLtB85D9OBiTMSoKGV
	 Ggd+0rTSq9gj/w/dTgtXLiwvedzaeKNvKGtZ+Evf6g84Qa1+QbR8AbOiPnrhLkWl24
	 V95QPPWHbjJFv7j3506pyO4STg9/jYAQKh48Nz2TMKWkrPxhkqm4PjmDegChUsWBq9
	 5xkqaqIbTcYsg==
Message-ID: <25599a7f-e9cb-4aa0-a375-d9b4ed52be5e@kernel.org>
Date: Wed, 8 Jul 2026 08:03:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250: fix shared IRQ startup race causing IRQ
 warning
To: Wang Zhaolong <wangzhaolong@fnnas.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, andriy.shevchenko@linux.intel.com,
 albanhuang@tencent.com, tombinfan@tencent.com, jackzxcui1989@163.com,
 kees@kernel.org, osama.abdelkader@gmail.com, realwujing@gmail.com
References: <20260527092052.2086342-1-wangzhaolong@fnnas.com>
 <20260708031115.3757150-1-wangzhaolong@fnnas.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260708031115.3757150-1-wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ah, you are fixing the same thing as:
https://lore.kernel.org/all/20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com/

I did not look up who of you was first.

Note the above contains you in the commit log:
Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579

You both CCed each other, so you know the other's submission. I don't 
understand why you both send the patch? Anyway, you guys speak to each 
other and decide who sends the (fixed) patch.

On 08. 07. 26, 5:11, Wang Zhaolong wrote:
...
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -154,10 +152,18 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
>   static int serial_link_irq_chain(struct uart_8250_port *up)
>   {
>   	struct irq_info *i;
>   	int ret;
>   
> +	/*
> +	 * Keep the hash lock held until the first request_irq() completes.
> +	 * The first port publishes i->head before request_irq() starts the IRQ;
> +	 * a second port sharing the IRQ must not join the chain and run the
> +	 * THRE test while the IRQ core is still bringing the line up.
> +	 */
> +	guard(mutex)(&hash_mutex);

The same as in the other patch:
hash_mutex is no longer an appropriate name for this lock.

> +
>   	i = serial_get_or_create_irq_info(up);
>   	if (IS_ERR(i))
>   		return PTR_ERR(i);
>   
>   	scoped_guard(spinlock_irq, &i->lock) {

thanks,
-- 
js
suse labs
