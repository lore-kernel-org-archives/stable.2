Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177757;
	b=g9Gtjeeb2XOTqk4cIzx5EFIlzrRkdBPlXo4HE9ion45znz3sPkvNxvZRdpodpKsVCktm
	 XKI2/ACdlC5iTtuXok15Q4BseC5iqOYUWu/OOYSV0QI6/q5c3/QBuLQKWDHU4P7Ygdp5f
	 NQf9ze6Bl2QnWM4BfcoZf6SGvc/+kIA3Z8rHbujQczAb1iZ5G6NNye8E6GCYCZSuQPj9T
	 E6V2PzTSQztGz8JpAOGAqiBe9TmKkZ866FIbB8xKLNbRHN+Y3xrGe55hi8rithD/ZcArq
	 dnKIxYxOzCFIvXWpeVP64ApK0ycQ18zN28FNBX7s6Y8Fqkr3qN4NVZsBOy/W/+1LPzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177757;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7Q03OZygytjS5FGuxrkC3cgSiKwOisIZC1+k1FSBH00=;
	b=TXlPPPtveQfQDLnC2+k+KefaosuKO+63s4TJdGjH+WK5qsz7++xwSLFyJbgNbFffDTzO
	 6wYb0i1p1q61Tae24zKmDL+Rh0ECuvwmU5kTGtg8t6D+oonn/umGI76+7NRXQbllhdS8B
	 y6LoNXxLw5Kddiq/ZwIv9Ft+7/2HDIGILFc7RtY1vlHYjd+wmqtoEulZo48KwHcX/s2rw
	 kp77er2DoopOO1WUZ4V+Z/1twkndiV645WUSsaWKMs6b6AG61DZ90AVxaGAsYpg7jBQKC
	 lV34ozlNKjyJdQlT11H3Jp0du8YivXwtPm397/fGU+oYsSVrsWSMCAUHIs1z/I0M9zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kSwkOXnT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90099606A320;
	Fri, 20 Nov 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kSwkOXnT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EE61F000C6;
	Fri, 20 Nov 2026 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795177756;
	bh=7Q03OZygytjS5FGuxrkC3cgSiKwOisIZC1+k1FSBH00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSwkOXnTzvc75bmvY4vUdqbk/YgX1dW3NNpZcTKR8w9RfuAT81WWJjCjvLJnvKAVk
	 kprLanghcsNg8D647RYgcKTIcIfk1NxcKeAN0BzzbKNIphEpFFc4JqyMT3HejAMU+k
	 TcRvvM6V2NPaErOSriICP8XDwKgdDkRuKyWfMC/g=
Date: Fri, 20 Nov 2026 13:29:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bertrand Jacquin <bertrand@jacquin.bzh>
Cc: heikki.krogerus@linux.intel.com, venkat.jayaraman@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in power
 level debugfs
Message-ID: <2026112040-splashy-power-2d46@gregkh>
References: <20261010120357.4937-1-bertrand@jacquin.bzh>
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
In-Reply-To: <20261010120357.4937-1-bertrand@jacquin.bzh>

On Sat, Oct 10, 2026 at 01:03:57PM +0100, Bertrand Jacquin wrote:
> ucsi_register() creates the debugfs entries right away, but
> ucsi->connector is only set by ucsi_init(), which runs later from
> ucsi->work and only publishes the connectors once the PPM has been
> reset and all ports are registered. Until then, or for good if init
> fails, ucsi->connector is NULL, yet the peak_current, avg_current and
> vbus_voltage show callbacks dereference it unconditionally.
> 
> On an Intel NUC13ANKi5 whose PPM never answers when CONFIG_ACPI_EC=n,
> reading those files after the failed init oopses:
> 
>   ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
>   BUG: kernel NULL pointer dereference, address: 000000000000045c
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:ucsi_debugfs_register+0x291/0x420 [typec_ucsi]
>   Call Trace:
>    <TASK>
>    seq_read_iter+0x1e4/0x4c0
>    seq_read+0x12b/0x160
>    full_proxy_read+0x9a/0x1f0
>    vfs_read+0xba/0x320
>    ksys_read+0x74/0x110
>    do_syscall_64+0x79/0x240
>    entry_SYSCALL_64_after_hwframe+0x71/0x79
> 
> Return -ENODEV from those callbacks while no connector is available.
> 
> Fixes: c851b71fd6cd ("usb: typec: ucsi: Add support for READ_POWER_LEVEL command")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bertrand Jacquin <bertrand@jacquin.bzh>
> ---
>  drivers/usb/typec/ucsi/debugfs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
> index 77a0dd75edd3..911a151ac16a 100644
> --- a/drivers/usb/typec/ucsi/debugfs.c
> +++ b/drivers/usb/typec/ucsi/debugfs.c
> @@ -92,6 +92,9 @@ static int ucsi_peak_curr_show(struct seq_file *m, void *v)
>  {
>  	struct ucsi *ucsi = m->private;
>  
> +	if (!ucsi->connector)
> +		return -ENODEV;

What keeps connector from changing to NULL right after you read from it?


> +
>  	seq_printf(m, "%u mA\n", ucsi->connector->peak_current);
>  	return 0;
>  }
> @@ -101,6 +104,9 @@ static int ucsi_avg_curr_show(struct seq_file *m, void *v)
>  {
>  	struct ucsi *ucsi = m->private;
>  
> +	if (!ucsi->connector)
> +		return -ENODEV;

Same here.

thanks,

greg k-h
