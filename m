Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC951E2614;
	Tue, 25 Aug 2026 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642941; cv=none; b=OHu/W+O4+nnxE0XxUK+ke4TosZJcNt2kkksLNqDP4yR6Q/zJ4dJkhOO0Q7UaJYhQ2/ltxD10jQAiVyn6MqqNdSekM3n7xgo5sCwGp4wUgkHiIf03yYRs9Gxk4cuUIpmzEO2iFfGuHQ5W9xme5JF+lj4MH+kWP4GbBHMwOkSyoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642941; c=relaxed/simple;
	bh=DgC7h2SSctxX1WZ2EpMV1rLASJ9kNCQwp6YffR366oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc3oEtDQAoJHTNuDU2z8i/DT+u+sLincNzCboJxcUug1LiumfOlsrrUM5Cc2EkdBRrXf+d0HNa6SgFpnoSCSw8bgWFiDqcDhHj6aQEMUoMV/0lt9O1Q+txzkL8v5CwGMbxPN4ELOz+CslBNZMe9CeYsRYWSLIZ4ZyUsELEwIIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07452403|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00153363-1.85344e-05-0.998448;FP=2819699858196063939|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=lixiaochun@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iwnnbeD_1787642925;
Received: from 172.18.23.215(mailfrom:lixiaochun@open-hieco.net fp:SMTPD_---.iwnnbeD_1787642925 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 25 Aug 2026 15:28:47 +0800
Message-ID: <53ba6f3e-9cf5-4af5-86de-9739709534f4@open-hieco.net>
Date: Tue, 25 Aug 2026 15:28:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: core: Fix a NULL pointer dereference in
 uart_parse_earlycon()
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable@vger.kernel.org
References: <20260806084827.16239-1-lixiaochun@open-hieco.net>
Content-Language: en-US
From: Xiaochun Li <lixiaochun@open-hieco.net>
In-Reply-To: <20260806084827.16239-1-lixiaochun@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/2026 4:48 PM, Xiaochun Li wrote:
> console=uart and console=pl011 can reach the preferred console matching
> path without an options field when a comma is absent from the command
> line. In that case uart_parse_earlycon() receives a NULL pointer and
> immediately passes it to strncmp(), which triggers a NULL pointer
> dereference during console matching.
> 
> Address this by returning -EINVAL when the options pointer is missing,
> ensuring incomplete console arguments are cleanly rejected while
> preserving the behavior of all valid earlycon-style command lines.
> 
> Fixes: 73abaf87f01b ("serial: earlycon: Refactor parse_options into serial core")
> Signed-off-by: Xiaochun Li <lixiaochun@open-hieco.net>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Add Cc: stable@vger.kernel.org tag
> 
>   drivers/tty/serial/serial_core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index a530ad372b43..02e770bf8bf6 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2084,7 +2084,8 @@ EXPORT_SYMBOL_GPL(uart_console_write);
>   
>   /**
>    * uart_parse_earlycon - Parse earlycon options
> - * @p:	     ptr to 2nd field (ie., just beyond '<name>,')
> + * @p:	     ptr to 2nd field (ie., just beyond '<name>,'); %NULL if
> + *	     no console options were supplied
>    * @iotype:  ptr for decoded iotype (out)
>    * @addr:    ptr for decoded mapbase/iobase (out)
>    * @options: ptr for <options> field; %NULL if not present (out)
> @@ -2104,6 +2105,9 @@ EXPORT_SYMBOL_GPL(uart_console_write);
>   int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
>   			resource_size_t *addr, char **options)
>   {
> +	if (!p)
> +		return -EINVAL;
> +
>   	if (strncmp(p, "mmio,", 5) == 0) {
>   		*iotype = UPIO_MEM;
>   		p += 5;

Gentle ping on v2 of this patch. Just checking whether there are any
comments or concerns. Thanks!

Xiaochun Li
