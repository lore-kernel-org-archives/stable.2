Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923746AA73;
	Fri, 11 Sep 2026 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117582; cv=none; b=TucBq0KHfQIsrxrXWTIpxKH2TruLygOqxwN3Cjlz8ensrU7sxJKdUPCqZfpw4u+WrukysVXsuH3nsIrlk0xl2mjmkZaiXwnue0o/LZSu1MHrfw6nXiAbS2+col9BP6PfvEJGRnr8HUWczqiKcnTL2MgnLjn0HkMQ+k8wJCKHaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117582; c=relaxed/simple;
	bh=lhga+Weuy8JTzpn00mh5e2wdFlQK7ezFMNk65Apg3sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPMA8VkdsMIdwUDz+yxoOTdlsFYXRXZoc/wxnoe2/aQNgJ2ah92RW70ZaGYhX0MYhq90KCBnsTevpXIMmPDV4J+csikkEcU2hEaQ+PEa/Rhtuwi/5HBTAl64KgDESeFq+U6xV9rQKJezroh1GKyNjmMpP2FPfhznDfjgidgNpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fChbx+Es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fChbx+Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3C91F000FF;
	Fri, 11 Sep 2026 09:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117580;
	bh=kinXsJ+URPBbp7XR5+VZT6QQgES4hyVW0D7lJiMNVIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fChbx+Es/EQZDBom8HzjAqsQnYXng0pabKZrsb/D5uYF7GcXcIeD4eU82dmB6Wz+X
	 mXHBGsdf+QkGZsbq0U2ImzhHnC6TSWPXphgUbkQ/q7afFTPv6l/vjj4Jt5TtgtYnXj
	 /slvW7cBwDjlfYZaNACWS5OLojYa/6YL5iNL/u8kba9QW057726051wqkJNRXxki5h
	 ea51WIogrD4y+80+gOgHEf1Kz+U2gDdYzZzD9d3yk5SyoAxTHSecbXLhsCJqn0m8JL
	 rfzdjo1lspS4bd0m0w+PLaScCB6Q0FsoWMsQFK+SYtKg+E+L4MX2IEQRqmXCyIsntM
	 RsL33XvkMibVg==
Message-ID: <5cd0cb7c-f540-4369-a55e-8eaaa400e289@kernel.org>
Date: Fri, 11 Sep 2026 11:06:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: amiserial: fix broken TIOCMIWAIT
To: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org, stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20260911090132.723531-1-johan@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260911090132.723531-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11. 09. 26, 11:01, Johan Hovold wrote:
> A change replacing interruptible_sleep_on() inadvertently broke the
> TIOCMIWAIT implementation which now immediately returns -EIO (unless
> there is a racing modem status update).
> 
> Replace the old hangup (and signal) detection with a check for the
> TTY_IO_ERROR flag which is set on hangup.

You seem you opened a can of worms.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Fixes: 591cee0a3563 ("tty/amiserial: avoid interruptible_sleep_on")
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/20260910132029.D80801F00898@smtp.kernel.org
> Cc: stable@vger.kernel.org	# 3.14
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/tty/amiserial.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index 28af0fd98181..60f6060b893d 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -1138,11 +1138,6 @@ static int rs_ioctl(struct tty_struct *tty,
>   				local_irq_save(flags);
>   				cnow = info->icount; /* atomic copy */
>   				local_irq_restore(flags);
> -				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
> -				    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
> -					ret = -EIO; /* no change => error */
> -					break;
> -				}
>   				if ( ((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
>   				     ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
>   				     ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
> @@ -1150,6 +1145,10 @@ static int rs_ioctl(struct tty_struct *tty,
>   					ret = 0;
>   					break;
>   				}
> +				if (tty_io_error(tty)) {
> +					ret = -EIO;
> +					break;
> +				}
>   				schedule();
>   				/* see if a signal did it */
>   				if (signal_pending(current)) {


-- 
js
suse labs
