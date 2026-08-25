Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7D4746A3;
	Tue, 25 Aug 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664126; cv=none; b=c5grVQDuDtHwLaY2XcBwMQBhtsEoTF1EF9fJ0aR4/mIjdVmnLPhq/XIwMJlbqx5VEmBlu9Z2GJww6hw/oI6ghY/wgy1Df9vpiyi0PqRwwr81DUe6tnxd33WCUKc5AwyzwqfAvWhmx+TnvB2FKjPYPf/3gFcjh8VUHsA0eb8FFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664126; c=relaxed/simple;
	bh=vHFLXzi7Yr0EPsIoB1pGXmXoglNRdcKLVuIO/oiKtd0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ddAw8lidYRGuXdBRpu6PLlLRMKg5sdbSktpLW8qrUb57wGLBf5+aenN/LnK9TBQbubc+nktPmPpNHxy9L3UezOenaa/RbolUpnUDpvkge18yjR9vPYkRjmD42pd+KE5CD6kz2VyI61Q9fvhV56NSws/ToHzwQI9cugZbp8QFxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=btPMdDAT; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="btPMdDAT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=nhEH62V5OEPxAlsJ+IhIzhqi1xPNjRqLmlHD+qXXMt0=; b=btPMdDATWy2ob1QbOw3ekauXeB
	n2iwikqU0sfgiET2eHFGtSCn4F3NX1GR+reG4RKP8F0oXnme5u4ek3LzWn/iuSjyvkl3AIKM7O8sn
	vjNzNAntzN0aJgX/SdxfdFqB+YOQpiwPIa+TcsgZFC8UgMeAizONgC8wdex55+xeRQ/Y=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wyr6A-000000006OR-2kN2;
	Tue, 25 Aug 2026 09:21:54 -0400
Date: Tue, 25 Aug 2026 09:21:54 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Luca Fresi <luca.fresi@bithiatec.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Tomasz =?UTF-8?Q?Mo=C5=84?=
 <tomasz.mon@camlingroup.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: enable THRI before filling TX FIFO
Message-Id: <20260825092154.87372afd883ff787b304caf9@hugovil.com>
In-Reply-To: <20260721222404.204746-1-luca.fresi@bithiatec.com>
References: <20260721222404.204746-1-luca.fresi@bithiatec.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Luca,

On Wed, 22 Jul 2026 00:24:04 +0200
Luca Fresi <luca.fresi@bithiatec.com> wrote:

> sc16is7xx_handle_tx() currently requests the THRI enable only after it has
> filled the TX FIFO. The request is asynchronous because the IER update is
> performed later by reg_work.
> 
> The SC16IS7xx generates a THRI interrupt when the TX FIFO crosses its
> trigger level. If the FIFO drains past that level before reg_work enables
> THRI, the chip does not generate a new interrupt. Characters remain queued
> indefinitely even though the hardware FIFO is empty.
> 
> This was observed on an SC16IS752 while both UART channels were active.
> During the stall the software TX buffer remained non-empty while TXLVL
> reported 64 bytes free, LSR reported THR and transmitter empty, IER had
> THRI enabled, and IIR reported no interrupt pending.
> 
> Enable THRI synchronously before filling the FIFO so the threshold crossing
> cannot be missed.
> 
> Fixes: cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Fresi <luca.fresi@bithiatec.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index daebd92f32c7..a1bd175e2feb 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -827,6 +827,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
>  		msleep(port->rs485.delay_rts_before_send);
>  
>  	guard(mutex)(&one->lock);
> +	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
> +			      SC16IS7XX_IER_THRI_BIT,
> +			      SC16IS7XX_IER_THRI_BIT);

You can combine the last two lines on a single line.

Also, now that arming is done with your patch in tx_proc(), you can
probably remove in handle_tx():

	else
		sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);

since the only other caller of handle_tx() will be
from the port_irq() when THRI fires, so it is already enabled.

Also it seems that for some cases, the THRI will be enabled for nothing
and then immediately disabled, causing useless I2C/SPI bus
transactions...

Also for x_char, empty kfifo or tx_stopped, THRI will be set, as before
it was not.


>  	sc16is7xx_handle_tx(port);
>  }
>  
> -- 
> 2.34.1
> 
> 


-- 
Hugo Villeneuve
