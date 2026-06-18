Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A34146A66;
	Thu, 18 Jun 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764128; cv=none; b=AbF5Ju07qJ6QTDPQk47EWs3yS54HZ7exYhhfL0jAw5m2KR69UfRGb3SS5akV8+s8FNAKFW3oLonX0W7HOUjpbYl+WR6gbjMipDZzegKV8uDZbbPcFEkpA4XuaOIGgXHVCo1Yswpfbr65FgVkICd1hRu5/YJXxp+VSPzOWZoEyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764128; c=relaxed/simple;
	bh=tbVx56po/SQzQgbuw5DtYXI3bcPs2gNfb+AJ4gh3QKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQc0fia9xhtgWTLQvde6LfhL1pJd1+bdQnxTEMpQN992DJgQdit6vRNpXY4jGHoLVDJjg9IzrJAAbozZILCA/EJljeIixro7RjnvQ11QygBARmkGiu7pWdo4bFIkxHgFVVOQsmvH1lasFGzzu3kRpMzcxMumnJ0zqYekOtxQq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKF/ztU2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aK40ZbtU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKF/ztU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aK40ZbtU"
Date: Thu, 18 Jun 2026 08:28:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781764121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv8sddD3UuF5Rf7ec5dmwrPPLbEvcHt690OH4TXc8/0=;
	b=vKF/ztU28iYem31/ZVUcGCAY9Xl4vQORViFV0dWnK27YmpDPZqmIdqjOhcReMDtSkfgOZs
	fGku/+A2/mkS28fW8J4U1bjOBpKCm7i5Eu894EsgGXoizp2/5xby2JNOWZlsd6Q9KSyqhJ
	bNlOtmtJ9SgtjCN32XzBdOUIyditaKyo+R4RQuixkFtU/A6NTUQYkjQNOiOBLqRQDFjSMC
	oEx5Wguqs4AcvzI7OCeGozWk2TJ3Pw0WZfIUNmes76qEQf5/EW+RvQ7tUDjvqRQf7JO+2L
	Jy8jWdu8IVCrQu+eQN4BAMz82zIki3ntnRteAh9coHNgBefHXEmK36TIt6+phQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781764121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv8sddD3UuF5Rf7ec5dmwrPPLbEvcHt690OH4TXc8/0=;
	b=aK40ZbtUmjb/BDqoc7oe877FraCcm3PCcXRR1fltxCCyLUsk2kswT7akesTxpBveo6L6TR
	7gVwOU/7q4BFTdAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-gpio@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: sch: use raw_spinlock_t in the irq startup path
Message-ID: <20260618062839.4o1ewdEn@linutronix.de>
References: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
 <20260617154035.1199948-2-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260617154035.1199948-2-runyu.xiao@seu.edu.cn>

On 2026-06-17 23:40:34 [+0800], Runyu Xiao wrote:
> sch_irq_unmask() enables the GPIO IRQ and then updates the controller
> state through sch_irq_mask_unmask(), which takes sch->lock with
> spin_lock_irqsave().  The callback can be reached from irq_startup()
> while setting up a requested IRQ.  That path is not sleepable, but on
> PREEMPT_RT a regular spinlock_t becomes a sleeping lock.
=E2=80=A6
> Fixes: 7a81638485c1 ("gpio: sch: Add edge event support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
