Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5835C183;
	Mon,  3 Aug 2026 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761786; cv=none; b=Imdpx2VyxxOlhQSGY714FRzxuIR+swlgyIu+yYy+VBYNMgQ8sITSJLT/K6SjNN7yHZrNTfYa5bqO84rTnAIAMNMnBcSzXFcG1Yt4jnJXChloYfq/dWU75TZz/U2Bo6ijNV1yiuFNJEK7iXDlnYoBidrVTmdDCXyvBYm3VD1AFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761786; c=relaxed/simple;
	bh=zR4lh11GRIdJttYDzLy5OV+hGlxex6I8HHNmW5c1c7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmNUw3vvlIqEo77OTA2HvV79Pjqeu/jaLslRzPSYzkAhqmqEEc7rX8fRQO2qJtRPes4GqsVYmkMpAmicSz4863Q5OF8bbO1j9pWX5Cb4dS9CtqzqDrg4wrs5muWJ3ai7q/Mn6YgZyS+1GizwGc3x7YWTQ1XkHA+Ra6kURC6a80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AiFtnJVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AiFtnJVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920B91F000E9;
	Mon,  3 Aug 2026 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785761784;
	bh=OXsmNyUVqCO5xA+kOWaRUZXD1UJnnyoHcYSRN+f169Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AiFtnJVFAFBBIKh0EPIwW87Oz3N9pcoJZbeOBCaxCS+gCfiQirvahvaoxfVWmGZp2
	 iUf9s2c3v5qCIoi/X5WXH9DCHszcug02GU5cHfQzVDL57/wFI3dTx9loJ0IOfAXBdz
	 tSnCKr+uYJczSMUAcvjHRBek+nutqqRfTtIamdeU=
Date: Mon, 3 Aug 2026 14:56:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: jirislaby@kernel.org, broonie@kernel.org, zhao.xicheng@vivo.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: max3100: shut down timer before freeing
 port
Message-ID: <2026080353-bats-jailhouse-804f@gregkh>
References: <2026073036-coping-starter-ad07@gregkh>
 <20260801061208.356142-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801061208.356142-1-fanwu01@zju.edu.cn>

On Sat, Aug 01, 2026 at 06:12:08AM +0000, Fan Wu wrote:
> max3100_shutdown() stops the polling timer but returns early during
> system suspend. If the SPI device is unbound before resume, the serial
> core does not call max3100_shutdown() again, so max3100_remove() frees
> the port while the timer remains armed. max3100_timeout() can then
> access the freed port and re-arm the timer.
> 
> Add final timer teardown to max3100_remove() and use
> timer_shutdown_sync() to prevent a racing callback from re-arming it.
> Also drain the IRQ and workqueue before freeing the port.
> 
> Keep timer_delete_sync() in max3100_shutdown() so that a subsequent
> open() can re-arm the timer.
> 
> Introduce an irq_registered flag to track whether the IRQ is registered,
> independently of port->irq, so a failed request_irq() can be retried on
> the next open().
> 
> Found by static analysis.
> 
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Cc: stable@vger.kernel.org # 6.2+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> Changes since v1:
>   - Drop the shared drain helper; call timer_shutdown_sync() only in
>     max3100_remove(), keeping timer_delete_sync() in max3100_shutdown()
>     so a later open() can re-arm the timer.
>   - Track IRQ registration with a flag instead of clearing port->irq,
>     so a failed request_irq() can be retried on the next open().
> 
> v1: https://lore.kernel.org/all/20260721035631.3186613-1-fanwu01@zju.edu.cn/
> ---
>  drivers/tty/serial/max3100.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 44b745fa26c6..7bc3c5cfe886 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -107,6 +107,7 @@ struct max3100_port {
>  	int  force_end_work;
>  	/* need to know we are suspending to avoid deadlock on workqueue */
>  	int suspending;
> +	bool irq_registered;

LLMs _love_ to use boolean flags to attempt to figure things out that
they can't seem to determine.  Are you _SURE_ this really is needed?
How about unwinding things better so it's not required?  You are just
adding another "state" to the device, adding to the complexity overall,
which is generally not a good idea.

And do you have this hardware to test this with?

thanks,

greg k-h
