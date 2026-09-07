Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688B41379E;
	Mon,  7 Sep 2026 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763671; cv=none; b=E3zL86X0RV4hR+jTVR8kn0FoOBcT2BLQJjBjOMrkxxnY/nFCVNi0yADZ7fWclVzg9ku0ymNXiCWnN4zw68Eisv8omrQvaytwKsOFYS1JvFv8ZEcOeQi24thhMPed4PUu0r3/BQz+6grOzKuqVKwLJ503yIk9q1ZiNizsK093E48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763671; c=relaxed/simple;
	bh=BNie282xU5eu890Ms/upZMZQO49kpQrhLK8FlGZdHrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhOqnJVIBzRyEuVJYdM1u7SpTfgbFTdet4233OO1uri8Zh18JzpZy3dKWuNQLS4uVJ2HIUeU6XR3QnaD4LHAmN0zX/Hkzy/Y8VopanaEhgaD9H7KCSHn7jooJXnxPqg4dSFEUPdVhiqrLF3etc6+heXhTt8AegJshelvxftZA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu1cQqUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu1cQqUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852DC1F00A3D;
	Mon,  7 Sep 2026 06:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763668;
	bh=TKhJNQZ3kTdGLSdNxwitpgDe39MWhrreC+MxyA1vdgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Uu1cQqUnIInzGmTWcEycZJ78Lzuli/xVHHI4VLpzTVIO2QTYr7HmVDnc8kQxYX1uE
	 UCpJNNtPJhvfM8V1Y541K8MD0m89J87Z8sDeMSm0O6g1uI7zRcUDz98gwh0XiEcZHn
	 Go3I0qRE82rJpIE3EPoJtoYGLIZ3heXp0r/J7BWUwofIq4IoltaEQcgkI9tWBJW6C5
	 /rZxq+YlSOPXZwC/mwv7APpGwbg64m/BUtepuhZVqK3vjh9ZKWWr/wHx5/c16bKQuq
	 Tymy7EK1Gzdd3MlaAl/9rwP0O7pg9ZHgaXfuiQoMvEpNvtpuUIzf7asQvMXCkEtRDA
	 T4w9GnA3JOWbQ==
Message-ID: <3f33d9f0-65c2-49b7-bb6d-2fe33f0d8fbe@kernel.org>
Date: Mon, 7 Sep 2026 08:47:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] serial: revert guards in uart_wait_modem_status()
To: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260907064418.92953-1-johan@kernel.org>
 <20260907064418.92953-2-johan@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260907064418.92953-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07. 09. 26, 8:44, Johan Hovold wrote:
> Mixing scope-based and regular cleanup is discouraged and
> uart_port_deref() used by uart_wait_modem_status() falls in the latter
> category.
> 
> Revert the premature guard conversion in preparation for fixing a hangup
> race.

It's not premature. Just convert uart_port_ref() to guards too. Gotos suck.

> Fixes: 56609c050051 ("serial: serial_core: use guard()s")
> Cc: stable@vger.kernel.org	# 6.18
> Cc: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/tty/serial/serial_core.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 95774b0f1484..1553bc6cbe7b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1213,15 +1213,16 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
>   	uport = uart_port_ref(state);
>   	if (!uport)
>   		return -EIO;
> -	scoped_guard(uart_port_lock_irq, uport) {
> -		memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
> -		uart_enable_ms(uport);
> -	}
> +	uart_port_lock_irq(uport);
> +	memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
> +	uart_enable_ms(uport);
> +	uart_port_unlock_irq(uport);
>   
>   	add_wait_queue(&port->delta_msr_wait, &wait);
>   	for (;;) {
> -		scoped_guard(uart_port_lock_irq, uport)
> -			memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
> +		uart_port_lock_irq(uport);
> +		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
> +		uart_port_unlock_irq(uport);
>   
>   		set_current_state(TASK_INTERRUPTIBLE);
>   


-- 
js
suse labs
