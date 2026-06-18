Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D5F2E7362;
	Thu, 18 Jun 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764377; cv=none; b=JM4RuHq1dmZHl4VDZP2KYsuH1Ac65m2pIU/BYNaFq7zdBMUfnCP8WmvV3eo9zFEevTG8vSQgk9SLKef0vij6JZYBqjrIqAbbTcpN0te0tGN6TPD8FIR4xwVDc1ZcAxTkE9GOi0W+s6r5dOyVdBpWR9bl/usP7sS0B7tM2T8l+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764377; c=relaxed/simple;
	bh=Qcz+7tjX7ygO3juELnfKHETvX+o1qYF94DDbsBU8MEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDXxCuHScX6iYK/PryytcT6udt7hDxyrIw8XQuqvVd1xELj7QMuZw/x9wfXtGGkvkV+Qi2BwJrQC3g5YJETgVLAw3yjCtynmSdxaPlaZDyOfdQQW+uFGr6YUnseiRC+wuhvCiGeZv+Iz0v79wa+5xZCn4S95UpNekMJPkEGlNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1rp8a25D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0yHEg/q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1rp8a25D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0yHEg/q"
Date: Thu, 18 Jun 2026 08:32:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781764374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4kyA6yHk+GPcMH3U+HqnffMzuSZuB07AzC6h+UiwoU=;
	b=1rp8a25D/967AZOX+CqM+nUprDa4wyYeEhVMQpXBNss1e5uYAoVw1wUGx4Uss5/n8P6yCT
	cmGbkRdqAGC649bCR+Upq5f2mVIUA4WdUkV+il86dszzhIVwCUz0+mEBjXNWE9qSeRcBJx
	gctZSEuZN7Xvj+2tluclK67tPP7nsh6jyMQDtcSnuFjJvg+AKX269mvgapa4qjlfzZOp2P
	7Ht7vnZ7JwTfXwAtwz/1VFUED/3eYhciZRIR0SKmOx2Yo5oxYcwVCoaA41BuAfZiD8dWb/
	oeuEK9oG8+m96EoIol9WX88DsSS6YTBPIuBsqjyGd/Bce6H9dWtc3FCnHXBMVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781764374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4kyA6yHk+GPcMH3U+HqnffMzuSZuB07AzC6h+UiwoU=;
	b=O0yHEg/qslDvIlR7GMyoKaynzlyKIXGC6O3uoOdVh9AQXA3EOn2sGe7D5l4wSqM5aEf9Pb
	7SndOlQchb9Z4wBw==
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
Subject: Re: [PATCH 2/2] gpio: eic-sprd: use raw_spinlock_t in the irq
 startup path
Message-ID: <20260618063252.DYS2hgcJ@linutronix.de>
References: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
 <20260617154035.1199948-3-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260617154035.1199948-3-runyu.xiao@seu.edu.cn>

On 2026-06-17 23:40:35 [+0800], Runyu Xiao wrote:
> sprd_eic_irq_unmask() enables the GPIO IRQ and then updates controller
> state through sprd_eic_update(), which takes sprd_eic->lock with
> spin_lock_irqsave().  The callback can be reached from irq_startup()
> while setting up a requested IRQ.  That path is not sleepable, but on
> PREEMPT_RT a regular spinlock_t becomes a sleeping lock.
=E2=80=A6
> Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
