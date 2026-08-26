Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4C4483B4;
	Wed, 26 Aug 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755994; cv=none; b=cEY+zT7KhqhD+AcfUY1mph31b5LCEzFq6JYPjPwXj9pxtXqQTqC6WGMYk3cnuQ8TIlkiDCWNOeL2YGq15NVtT4Gmgu1nx4JPwd8+kvA9JPxOxwIa6FRUrfZjJ2pl38fOhK1edjAWN4FKdkRIlW5GWLUNxUXOhu3jcHZnCXUgr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755994; c=relaxed/simple;
	bh=CGK/TyRm8DcG8SVPl7AfDxJsfx140R/fg9QMCDVf+E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry6oTIGOfbcKxoHeO2lEm8MD26xmdFDw7COCo4DmjRblQzX248ImU5USN1/UtFF06ZfTZEGm5lxLsoLoYIVWZvXIXLCIUjzGOOKej6icivpVKXtY2epUefCZL9odGAmXC1sbKyjYC7d+DRzUTAQlAoId4eMR7Zwz15BfbuEUFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Txh7IwpW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=enUETfSD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Txh7IwpW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="enUETfSD"
Date: Wed, 26 Aug 2026 16:53:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787755988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGK/TyRm8DcG8SVPl7AfDxJsfx140R/fg9QMCDVf+E0=;
	b=Txh7IwpWGGtszC61jDWcoBjnD8Hw/7OfiBtCp+jDEszZO05f+oNVyzKlJi5BKoRJ7Xuh0x
	VKV+zxp9fvog1VSqH2Wm/Khr8qnPjMVWkvcQ0/j/2HwUPYBi3qk7cDWVCmDSAhIZPaooGD
	O6DtguaG99dmrbnoKiwSsisFxOCQBeKp9VCoz6QHnt6jpw+7vFrt0ooOnhZlVtuQYhu2/K
	3dgCiPzTa43nHJ5QK1heBB0hvDZTdyw9bkcVWMDp4u2Cjo1Rsu04JLUa8Z8Yixb6AFzs6m
	VBLiJ56JlKz5IUxgsoyqbI+s8EbYJQVSF/9RYnLAlEC1uMabAtlrOtS58pixhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787755988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGK/TyRm8DcG8SVPl7AfDxJsfx140R/fg9QMCDVf+E0=;
	b=enUETfSDBT3zJ4C27hqBZSSI7cbHo5EjfTf99KyzUG16rtzP0/SMDzhlNkUBkOe8LENMH/
	gm0LZlvJk70vrxAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kendall Willis <k-willis@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>, s-kochidanadu@ti.com,
	a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_omap: fix wake irq cleared during suspend
Message-ID: <20260826145307.4GWTzB5f@linutronix.de>
References: <20260825-uart-wakeirq-fix-v2-1-0b9fba03d9b6@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825-uart-wakeirq-fix-v2-1-0b9fba03d9b6@ti.com>

On 2026-08-25 17:06:07 [-0500], Kendall Willis wrote:
> The wake irq was cleared in shutdown(), which runs during the suspend
> sequence, making it impossible to wake the system via UART.
> Move wake irq setup to probe() and teardown to remove() so the irq
> remains armed during suspend when the UART is a wakeup source.

The omap-serial has the same problem, doesn't it?
I would still like to see an ACK from Tony here.

> Cc: stable@vger.kernel.org
> Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
> Signed-off-by: Kendall Willis <k-willis@ti.com>

Sebastian
