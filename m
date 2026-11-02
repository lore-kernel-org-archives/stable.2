Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618332;
	b=VRje28Eo0MYLAsrX8AF8jrMwR6bNO/0E509gUnB4UEvwKvjmXtl65ZhLrSbVY9HJmaVw
	 54jJY42u8Gg92NitzpYJMob8hzqmF76xeTGjwAMqgPg1rXbtE47ypIl7TwoSK/SsYUtsN
	 SVUOh6YHUhS7qMYKx6A/u76MSVc8LA00DfyaEzNmjRyPS0Ksv4CuUALOHc7X8rNYn2weF
	 5hDI1uqc9uyYYjYkETVu/ncmOu7r1TEHcDqZ22R3A1o91y4voAmL0ZkcRb0H88OumGqSV
	 UuiAVTSFwrMkJpT02Gs0gzYKCjYC5akLYE90QyuQ73M23z/hW0zHOORuKkHvvS5yo2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618332;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+gXN1EJDAIuD6OAVLJNi2E0ukj20V1+++FMkKGgMxX8=;
	b=xD6C3bOS1MSlY3QPAuGh7T+ox3IdWFwe25VRldgTIcBzWHfgL5g/kgbrGZCMimSG9Ni5
	 52uGX5Wck29FXYTAdPeFjCehhKq55KIL4QVKnMtJ2wTCiFuqqvK/SV5Ua7KHDhUhKPZkS
	 WFC8frAc/NKpOd1+VOeLBKdW9LFcOwmUT0qM2b/gty3af/bUyfOO6zeY7+rfRNH4VjE2M
	 LJPMwiNSBDG9zDpBibjxp196YR8GcD7Edu0PlGJ+0tTD89oqhh+4irBZvLwlu4LERuKeZ
	 J9A4k9JG1v8HrFsCZ1tXm9MqDv/3Y4dPQyNelCufgNilYZE3inqY66o3TZ256UXQqbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IjRRuSGv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11056606A326;
	Mon,  2 Nov 2026 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IjRRuSGv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C231F00A16;
	Mon,  2 Nov 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793618331;
	bh=+gXN1EJDAIuD6OAVLJNi2E0ukj20V1+++FMkKGgMxX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IjRRuSGvhYeyYi3jncPvWKJjTbPAQ5o084u+ANSXB9FIJWNVHflGxH7aaQsSAmts7
	 omi3oRBUVLvwHmfF5S2iOrNZ+yiGQJMdtzrLB/d1FFq/HYo0OgJ0oJhv3nijfuAzo7
	 5aJgfspAyJzIscgAM66jmq9RTS4q/U0PD41tYSrE=
Date: Mon, 2 Nov 2026 12:18:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "fuzheng.meng" <fuzheng.meng@semidrive.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: restore FIFO in
 serial8250_console_restore()
Message-ID: <2026110235-zippy-divisibly-3766@gregkh>
References: <20261102093609.2400381-1-fuzheng.meng@semidrive.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102093609.2400381-1-fuzheng.meng@semidrive.com>

On Mon, Nov 02, 2026 at 05:36:09PM +0800, fuzheng.meng wrote:
> When console_suspend is disabled, the serial console stays enabled
> over a system suspend, and serial8250_suspend_port() writes a canary
> value to the SCR register (if the port has one) to detect whether the
> UART lost power during the sleep cycle.
> 
> If the hardware did lose power, all registers are reset, and the
> first console write after resume detects the canary mismatch and
> calls serial8250_console_restore(), which reprograms divisor, LCR and
> MCR, but not the FCR.
> 
> serial8250_console_write() decides whether to take the FIFO write
> path from the cached up->fcr, which still carries
> UART_FCR_ENABLE_FIFO. With the hardware FIFO left disabled by the
> reset, the transmit holding register holds only one byte, while
> serial8250_console_fifo_write() pushes up to tx_loadsz bytes into the
> port after waiting for THRE only once. The burst overwrites itself
> and the console output right after resume is garbled.
> 
> Factor the FIFO write path condition out into a new
> serial8250_console_use_fifo() helper and use it from both
> serial8250_console_write() and serial8250_console_restore(). Restore
> the FIFO in serial8250_console_restore() when the FIFO write path is
> going to be used: first write UART_FCR_ENABLE_FIFO, then the cached
> fcr, as dw8250_idle_exit() does after its registers are reset.
> 
> Tested on a DesignWare 8250 based platform with console_suspend=0
> over a suspend/resume cycle.
> 
> Fixes: 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: fuzheng.meng <fuzheng.meng@semidrive.com>

Real name please, not an email alias.

thanks,

greg k-h
