Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51F2F7EF6;
	Tue, 25 Aug 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642837; cv=none; b=eX72HCDkoVCkcXwlvEdQ4Xin49GpXhu4IQYW7496Yi23WHsTzRr4e//EF8tgfAog9i62Q9RL7P+IsenfNjOQjDYFqRqeBCWOGBz+FNeAA6RLtSzWRDiPvqZ+N7DErVW30CtySrPmFfUNS25CetMuOVcscM6dSFUqCCuOCxWTkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642837; c=relaxed/simple;
	bh=yHb03kiKvpOaV73EpXalcNAn3ZQLAgmlg9JUvT4lyO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nom6BMundsBR4dHg1oFUoJnqjmgpDo9rYWTZB2oKTTbwXsrKWFpO656BGKEcu6vYfcYzdsXb53rWn1S1Sdll9ygwItNGD+VofMSgjmbb37IQJz7OHbmKvOvYKSPK9HZPh3k2fG4QHlz/3bzAuuniDsBTw9mKfQu3K5LJYPLkVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kBDGfYTq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+Va6NGL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kBDGfYTq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+Va6NGL"
Date: Tue, 25 Aug 2026 09:27:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787642833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/7uVeYszVtmh3wnxTOvKtFbtwj8mIoO82675yqBkUU=;
	b=kBDGfYTqe3dVznwyAmrBqkhpKYjLSrDl1t6RnMQrRYSILIjvB3Tz3hwthCsbCj0JlC2X5X
	jxFacpFzGUCC/iCTTJze/ttSEcHFrIzCSdg4ZTgJ7Cl19f80KNZcTGSnF72Goq/s1z+ai2
	Np3JRefTlVkL7OLwAR25/Ki8dPY8WegK9Rg2I8x6CaI0/afAkUx4yDdpjDxyQK/pdLn2OA
	CHOatxBz7Bt1iwFfF7sPXGv+LFdnxE8i/ztP0buiFQi7gWk7aBbRkF7RqTIh/N7Yps2OTp
	swzdWddBE7JupHPAFbndudDocoziLtYi0jHpvjAht/TN4wsoWmygAHVGxDv++Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787642833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/7uVeYszVtmh3wnxTOvKtFbtwj8mIoO82675yqBkUU=;
	b=T+Va6NGLQ51qaRfvrFlqCTZNBQM5+HdAk/nbOkwqX7InyMK8CQ/UqxKqEfiG9vjWGfSO71
	8t2biNmhQt5mQvDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kendall Willis <k-willis@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	Tony Lindgren <tony@atomide.com>, s-kochidanadu@ti.com,
	a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix wake irq cleared during suspend
Message-ID: <20260825072712.jR_IlVlw@linutronix.de>
References: <20260824-uart-wakeirq-fix-v1-1-6d81a230a1c4@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824-uart-wakeirq-fix-v1-1-6d81a230a1c4@ti.com>

On 2026-08-24 11:28:51 [-0500], Kendall Willis wrote:
> The wake irq was cleared in shutdown(), which runs during the suspend
> sequence, making it impossible to wake the system via UART.
> Move wake irq setup to probe() and teardown to remove() so the irq
> remains armed during suspend when the UART is a wakeup source.
> 
> Cc: stable@vger.kernel.org
> Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
> Signed-off-by: Kendall Willis <k-willis@ti.com>

I leave this to Tony. I tested it back then on bbb and wake up from idle
was a requirement which worked. Tony had other boards which passed the
test, too.
The omap driver had and has the same logic here.

Sebastian
