Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933732;
	b=yZVWZ7HfpSSnJTUYXZmo2T/ZDUozS5pbYX8EPBOMkFweWnLOhZM0rLad5tRZhQ1Te3Ou
	 94tgfoYvOJDfJqop89hd0kzUddnHzi4B8BW35uUhjzTdIfA3V4PnGZVhIKpnxXzLJTOAC
	 l8vhOjNGnG4dUn9z17evkUI71gWKUmnEkoyZUh6kyz91+CLk7Llhsqm2kJ2c8/x6HrOLz
	 MQoK/4gZFe327QHF0KWDIfF+yGv99gptgcqzdzNfLxDfJ5oTDJpJtsVnVKDUkmgfLGnQY
	 X+1Qg34RQXcD1A9JLdIi4PHueJFbbJg1Q8V8WiZbA/kuo0GCIW4fLBRA9AhkZti4beg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933732;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=IKS8d1lnRAIIiWYQsxJ4cN5ocNc8d6MdfDg7P9xpAdQ=;
	b=SUGtv1VcLmJIH6M735G81cLr9dC4bWpfFo2/nMq2HhzYfVa0i2V3F7pDfIMksPvImy33
	 mD/6z2vxmfHvZfkJ7Cp9m1OxvIWT5XEr5h/QCM7EQDH++N0/rjO4jHDDhC3XQLvbHWVXU
	 wxw74X9kTDwjUhLjnrpooE1HlC1auOzT4MqOt5oJSmaD3ZYql5nFxaCv5SpWvmSCoar9D
	 qZ5/Yb8H0s8lS7Dc8Z/4F2pVS7cpeX+7NCL4ayvtqKESql5hxPR6d9PbsUH50I6QnjPSg
	 O6AmOmgkt97RfrVi41M4zR09uc7Ko/xJ4OTlMFFazmFn/jNRYbR5XEvSTXhdVIBQ5yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=duhHs80G;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=snfZGNnA;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC73606A33B;
	Tue, 17 Nov 2026 16:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC73606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=duhHs80G;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=snfZGNnA
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794933724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKS8d1lnRAIIiWYQsxJ4cN5ocNc8d6MdfDg7P9xpAdQ=;
	b=duhHs80GoTBIqqx2VP76PUy6V1f3MImQZeIjE2f/ZpNnVonmOxt/Oeq0IeAcLparufgcfV
	aehAP6fpjWC28wAsOdA09XOSXUwiOxr56bCPrba8UjqWPqdv6KvhIaj1/6bsF2Il3lxy/j
	xLLiyvWUU4dQ2IyiuZP9c1jcfruQythTnjUn7e5nBDNg9+pyVM4N+4eJNk+S7BNjPh1e/p
	HBmg8U3xiGYnAW9pZphseYrFcZLh9ZRAiNWEBUmmo7/E3FW3Vfukcfax7g2VZoP7ctuPCD
	a0qm9dlx1TR6LTzd6AXK/WHBHF5sVomyVUzlq23n8bBGvO+r/dCQ3WMOinzdzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794933724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKS8d1lnRAIIiWYQsxJ4cN5ocNc8d6MdfDg7P9xpAdQ=;
	b=snfZGNnAosdgnTcIjGPEZGqw1ZDlfd07Y+JF5ZRXAqZbwAVc1/JlekH50kEq7nRScGwBnt
	7zoMKyS2RPHE2mCw==
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: Patch "serial: 8250: Switch to nbcon console, take 2" has been
 added to the 6.18-stable tree
In-Reply-To: <20261117154343.1812289-1-sashal@kernel.org>
References: <20261117154343.1812289-1-sashal@kernel.org>
Date: Tue, 17 Nov 2026 17:48:04 +0106
Message-ID: <87a4n79zqb.fsf@jogness.linutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On 2026-11-17, Sasha Levin <sashal@kernel.org> wrote:
> This is a note to let you know that I've just added the patch titled
>
>     serial: 8250: Switch to nbcon console, take 2
>
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      serial-8250-switch-to-nbcon-console-take-2.patch
> and it can be found in the queue-6.18 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Is this patch really needed for 6.18? The conversion to nbcon was
initially reverted for 6.14. The reason was it brought various serial
and 8250 issues into the foreground. It wasn't until these issues were
resolved (in 7.2) that it was allowed to convert the 8250 to nbcon.

If the 8250 nbcon is really needed for 6.18, then the set of uart/8250
fixes also need to be included. They probably apply, but it is a lot of
changes to put into stable if it is not explicitly needed.

The pre-requisite commits I am referring to:

9c7eb1c9c3e3 ("serial: core: Add dedicated uart_port field for console flow")
bf558715d91c ("serial: Replace driver usage of UPF_CONS_FLOW")
f69ec492244d ("serial: 8250: Set cons_flow on port registration")
39d307074f91 ("serial: 8250: Check LSR timeout on console flow control")
5e6dfb87b191 ("serial: 8250: Add support for console flow control")
302fbbb4fcbd ("serial: 8250: Ignore flow control on suspend/resume with no_console_suspend")

And then there were several fixes needed after the nbcon conversion:

560f4deda327 ("printk/nbcon: Change nbcon_irq_work to IRQ_WORK_LAZY")
37aba16e7943 ("serial: 8250: Change console_msr_work to IRQ_WORK_LAZY")
5f339c46f153 ("printk: Postpone kthread startup")

Let me know if I can help with any of this.

John Ogness
