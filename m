Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28D4746C6;
	Fri, 24 Jul 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933078; cv=none; b=LfwrV2lYoDm5x+0bPgIjxZIO7c5cjsTW+gKm+mDBXVm265ZSJX0wcXuXV/5YuArtbRo/jm5ruixPDy5WvfSibtgyjqj1MoLxl+1bEMzKJ3SVsq+uGFVK+pCyky+wOpQAzb1u7LsoDHxK0f0GC7UGmTVrYPB+cJ6QXaXBBMAvkR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933078; c=relaxed/simple;
	bh=QqIaBCRieId5IemtvcpKahPh19xZYLf1hGy70SKg0PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG7X8k1XRzI8QjeeHrXZ2h3HFiM34CB3HD+rOP7ebYPV0OAcpvWjHMCtDo187eqH1h3O3ehbB3/rFLnp09FYXD8GtnySrgdS66jk7E7imGL9Kg05gustOxGsMYgvW5d6T9Gb8kJsrP4wEynm35+xGflH/yilYGFJB8YspvjpQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4rBpEhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4rBpEhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6331F000E9;
	Fri, 24 Jul 2026 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784933065;
	bh=WtuhOUxYiTRsl5zK5BpJ83EHAdKYT9hBTgyqeW8tiGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i4rBpEhfhegDJ8TnMvpAXKQi/Ojo4RmSa/KXofg+CF4tn12KC+kqaOGsaMY2m+cfy
	 Ea2jV+6FPwoWpZ0elNj1jcNdIlqDQtJE6FGMzLRqXU5wWjaXvMuOSoPJ/xICgP12ob
	 tTfYBvWvrR0mp2WTqL5M7BMCIF64pZbZPPGST8P4cQC14s50zibwsC+FvjSa827u0e
	 TDl8qXpxwxMb+ByiZGwlLn/3kEZJZ5rQFEDWELIVENkd1hWMOrL4iFn+xD/MJ54sUi
	 WqIMfw2jOW0t/TAJOnnvmJ2WubbgrquuKaXO5yII4yOLAyAuhURIMkWh/Dvp3ugCLL
	 TZifoJMdjx2fg==
Date: Sat, 25 Jul 2026 00:44:21 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: jdelvare@suse.com, djkurtz@chromium.org, hkallweit1@gmail.com, 
	wsa@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i801: Clamp adapter timeout to prevent system
 lockup
Message-ID: <amPinh8c7GwQx4Le@zenone.zhora.eu>
References: <20260723034331.116690-1-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723034331.116690-1-25181214217@stu.xidian.edu.cn>

Hi Mingyu,

On Thu, Jul 23, 2026 at 11:43:31AM +0800, Mingyu Wang wrote:
> Userspace applications with access to /dev/i2c-* can use the I2C_TIMEOUT
> ioctl to manipulate the adap->timeout value. In the i2c-i801 driver,
> this user-controlled timeout is used directly in both the interrupt
> waiting paths (wait_for_completion_timeout) and the polling loops
> (time_after(jiffies, timeout)).
> 
> If a malicious or arbitrarily large timeout value is injected from
> userspace, and the hardware (or an emulated device in a fuzzing/VM
> environment) fails to respond, the driver will block for the entirety
> of that requested timeout while holding the i2c adapter's rt_mutex.

I am not convinced that we should fix this in the i801 driver.

Access to /dev/i2c-* is normally restricted to the administrator.
We cannot protect the kernel from every unreasonable value chosen
by a privileged user.

...

> Fix this by introducing i801_get_timeout(), which clamps the timeout
> to a maximum of HZ (1 second). This is safe and strictly necessary:
> 1. Normal operations complete in milliseconds and are unaffected by
>    this ceiling. The timeout is only consumed during hardware failures.
> 2. Per the SMBus 2.0 specification, the maximum clock low timeout
>    (tTIMEOUT) is 25-35 ms. A 1-second clamp provides immense headroom

The SMBus clock low timeout is not the maximum duration of a
complete transaction. It does not prove that one second is a
safe limit for every user.

The one second limit still looks arbitrary to me.

>    (orders of magnitude) for legitimate transactions while decisively
>    preventing prolonged rt_mutex lock contention and D-state lockups.
> 
> Fixes: 1de93d5d5217 ("i2c: i801: Replace waitqueue with completion API")

This commit did not introduce the problem. It only replaced the
waitqueue with a completion. It looks like a convenient point in
the history rather than the actual commit that introduced the
"issue".

> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

...

> +/*
> + * Bound the maximum wait time to prevent system lockup if the
> + * userspace passes an arbitrarily large timeout via ioctl.
> + */
> +static inline unsigned long i801_get_timeout(struct i801_priv *priv)
> +{
> +	return min_t(unsigned long, priv->adapter.timeout, HZ);

This also silently ignores the timeout requested by userspace. A
user may request ten seconds and the ioctl will succeed, but the
driver will use only one second. There is no warning or other
indication that the value was clamped.

More generally, once a user has privileged access to a device
node, there are many ways to misuse the hardware. I do not think
adding arbitrary limits to individual drivers is the right way to
address that.

Thanks,
Andi

> +}
