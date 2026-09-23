Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DE38838B;
	Wed, 23 Sep 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158675; cv=none; b=Kwcl3Z7lS8UkXncXxDcKj5r/8JfamdAjpV2xmvAw5Jnx/8s6QN/SjhUZUdY2+fGd9MZvgTS6rnb1u4EVglCiDCUh7mtA4b1l5cDaKLQl87Qce+1YWO6KetpFhc21VoW64wqbLONZMp2V8uEpK/fEoyH7eCVL0tCABw9YLacV09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158675; c=relaxed/simple;
	bh=3+k97AKVX0+WvPsLrnSRRBQCDkxzMLRGCBSgfnCFNr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bkt8Net4rmvVPkE1fngv9sHfewiv+ELWSwjqtpn110nwz8G+C/4DaCTLWURKgrWLThD+kKlH1IS8EEuRDlLMY4MA4ECHmiS+4+hglYqaBGWr9L0OeotEhbX/ZtzPbC+VGBjrNu2AE6soASc1wAfDWzWNa535FoeYxIVq2upBqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r1iBhGpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r1iBhGpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0671F00893;
	Wed, 23 Sep 2026 10:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790158664;
	bh=W1/bjYm7A6ATDBDiHkAvKKXTQPf4WTEwcOm8tVT2vXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=r1iBhGpBecKlPSCySHLyLjJpU7CntPKJtM8VsybbGMZ24QDUu4afJPQ2Az8OT2f7v
	 DzYH5Yl6WnRCFebdNIMH+0dSZborKcYhcQxqeWB2nAPK9Ru8YZfAi9vp7bMYJD9c0I
	 gMU+owblHjscDxFcgb2Um6PQPFg+8AfJ3cxELD70=
Date: Wed, 23 Sep 2026 12:17:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: imx: cancel RS485 trigger hrtimers in shutdown
 and remove
Message-ID: <2026092332-limes-washhouse-44a5@gregkh>
References: <20260819021916.442827-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819021916.442827-1-fanwu01@zju.edu.cn>

On Wed, Aug 19, 2026 at 02:19:16AM +0000, Fan Wu wrote:
> The rs485 delay hrtimers trigger_start_tx and trigger_stop_tx are
> embedded in the devm allocated struct imx_port, and their callbacks
> reach the port through container_of() and touch registers under the
> port lock.  Nothing cancels them synchronously: the tx paths only
> call hrtimer_try_to_cancel(), which does not wait for a running
> callback, and the bounded wait in imx_uart_shutdown() can give up,
> force tx_state to OFF, and leave a timer armed.  After
> imx_uart_remove() returns, devm frees the port and a late callback
> dereferences freed memory.
> 
> Cancel both timers at the end of imx_uart_shutdown(), after the port
> lock is dropped and before the clocks are disabled, and again in
> imx_uart_remove() before the devm free: serial core does not call the
> driver shutdown on every path that reaches remove().
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: bd78ecd6056d ("serial: imx: use hrtimers for rs485 delays")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/tty/serial/imx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

How was this tested?

thanks,

greg k-h
