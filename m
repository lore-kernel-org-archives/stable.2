Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F846EC84;
	Mon, 21 Sep 2026 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992630; cv=none; b=cOA9DY/E4Mgd2T9tvOJhF86wlCjltu8mZ8O3+D2FKreaVcOMIiNKCrGmQj3mZoxvcCoC1BNsXnmftlaM9MK1xkOsAbOdwIo7ejYoqCIN5bO/Sa9AxAF8VdH0C3R66R0HHlfkag9z53+JQixxTiZHLY3+rdW+WT7CI/vKPSJIqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992630; c=relaxed/simple;
	bh=TQ6439819zM+jUQ38PGeQohKat1IgIG1YfPSTxBHGk4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gF7TfUCOnUxbjuvbYaNCJLHM41nAcdzgTUJFetQQvKyE9W3RJ+gSNIDE5dPLu+U56Fv2SjX4Y9VYgMgcmfAK3420vKx/1ZA4I4vLFnV2fYv/6uUk1phjFQkbmJ3mF7jHMHa/btKaoGmjs30dMPd9IikQtuDQ8gDcMTq3jlPQ94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPgjaEb/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPgjaEb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789992629; x=1821528629;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TQ6439819zM+jUQ38PGeQohKat1IgIG1YfPSTxBHGk4=;
  b=cPgjaEb/RQCifiijnGzw/PJp86LmH+3TsQgB2+72bf00Kq855EeBlVrI
   f0o5sy0QMSH/ig3clKh6BYmLB1sPLzaUznpRDsBx7tC/sksY6kbFC0Kpz
   C+he1dELeocf6RB6pL/yaSfrLF5Hs9n64goFKV4j8FprHOQbn7ObAyggE
   Bi/9y7v0/5IeLrFVxqbMTqtAMJnOxSadytGwKDPMyqc3uOZsdqU970B5G
   /h83oLTOYqGbk0ZdixfudzVPxKNdTFDr5JurrYvaGwVWZGZ8fhp2/avRZ
   JOUsFg5MYZgGjVMqNdoXohkmHYSIsiVyUaYgiFbIAmyS1qFtHAnyJYqfJ
   A==;
X-CSE-ConnectionGUID: kc+nkrEySReq/QkXpdjGOw==
X-CSE-MsgGUID: BSfvpy0zRZqmr0/dDfyWIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="116026871"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="116026871"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:10:28 -0700
X-CSE-ConnectionGUID: U9r91DRiRJ+9y7x458bSgw==
X-CSE-MsgGUID: aQai4rCETtu69sJKBgZGAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3931158"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:10:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Sep 2026 15:10:18 +0300 (EEST)
To: Hui Peng <benquike@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] serial: core: reject baud_base values that overflow
 port->uartclk in uart_set_info()
In-Reply-To: <20260921013027.659965-3-benquike@gmail.com>
Message-ID: <6919bc88-ea25-3349-29ac-c50bffa03898@linux.intel.com>
References: <20260919222627.3797854-1-benquike@gmail.com> <20260921013027.659965-3-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Sep 2026, Hui Peng wrote:

> In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
> uport->uartclk (an unsigned int):
> 
>   uport->uartclk = new_info->baud_base * 16;
> 
> While uart_set_info() checks if (uartclk == 0) and
> if (new_info->baud_base < 9600), when new_info->baud_base exceeds
> UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
> by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
> (16), bypassing both uartclk == 0 and new_info->baud_base < 9600 and
> setting uport->uartclk = 16 (baud_base = 1, well below the required
> minimum of 9600 * 16).
> 
> Reject new_info->baud_base > UINT_MAX / 16 with -EINVAL in
> uart_set_info().
> 
> Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
> &ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
> TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
> (TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
> TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divide by zero")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Split out into patch 3/3 of the series, add Cc: stable@vger.kernel.org,
>   and document the QEMU test method, as requested by Greg Kroah-Hartman.
> 
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 128fc056f5c9..4cd4fb0f7ee3 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -965,7 +965,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>  	}
>  
>  	if ((new_info->irq >= irq_get_nr_irqs()) || (new_info->irq < 0) ||
> -	    (new_info->baud_base < 9600))
> +	    (new_info->baud_base < 9600) || (new_info->baud_base > UINT_MAX / 16))

Include for UINT_MAX is missing.

But why is this checked here? I'd have thought the more logical place is 
where the function checks if the resulting uartclk is zero?

>  		return -EINVAL;
>  
>  	if (change_port || change_irq) {
> 

-- 
 i.

