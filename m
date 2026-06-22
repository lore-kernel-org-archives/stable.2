Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62245274B4A;
	Mon, 22 Jun 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143802; cv=none; b=eooRzVCXcOxdGs7fICilQNRsG9U7XEDNdvalz+4WJyoATZ2e98e6ZBHB8TMUCTd1VaSn/ZKAn2HkCpnR5VijoFWe8K6NM/poNuJHvJe1QcXQApPcFGDKO9UhqE1NwDbwn8bB0K2EEf1Ycp5+alLC9bSg0kTU/LdvWcBZii2xAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143802; c=relaxed/simple;
	bh=E2npOhROQsK1NVJg4SA3vgkYO3Mo6mPCNcjISx+vSak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QD0DK9qcuoXwgizpebBT41yLDIUc8PRCvIsUOeobTd9PF5afIFtyjpxkf+lyWTxpZms26WRq8tc8c1fWBxXOsnDwNJenPFCK4AWideH48XTTaZ7QXO95Rrz5caqqpVUP7S5DScho5rxiXRRNmg077rXRvlgMRS9L5LwATf0Bb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv500U24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv500U24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36801F00A3A;
	Mon, 22 Jun 2026 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143801;
	bh=U+83Z2ZGm/CyeZD5t6rPdvZf02fZO5x9+ZBmpP19uDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kv500U243yVra1La+7A6O/uZ/1dYykhDMcxL2heCU+xuse0XnjhV4dod0jOG75if1
	 Jocv1jBdtyI85tbeJ2rKL5cfaKqNgTEmhrcIg95Nfm4Fmh0pfUpZ4TIHo4wlkaJYqh
	 PmCPxeztBaJD7TokviIaPYHFHKKrYL1xUl5TWVwlrDdOw77as295kyIBwwIxzocDSp
	 LlJ02DeHAEk62Fv4SkiIlOeZMIWRBAPg4jJtF8bHsPLk+3AxoBlCflGu7CD+NqejcS
	 kuKXtYehU3H6QttWgjz3SZilx7XfkoBEkM/jJ/5LlYsYQ56lcry7Y5gbRupvPJ1Qhz
	 sJDACADTXFbRw==
Date: Mon, 22 Jun 2026 08:56:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: au1000: move free_irq out of the close-time
 spinlocked section
Message-ID: <20260622085640.14e0018f@kernel.org>
In-Reply-To: <20260619151816.1144289-1-runyu.xiao@seu.edu.cn>
References: <20260619151816.1144289-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 23:18:16 +0800 Runyu Xiao wrote:
> au1000_close() calls free_irq() while aup->lock is still held with
> spin_lock_irqsave(). free_irq() can sleep because it takes the IRQ
> descriptor request mutex, so it does not belong inside the close-time
> spinlocked section.
> 
> This was found by our static analysis tool and then confirmed by manual
> review of the in-tree au1000_close() .ndo_stop path. The reviewed path
> keeps aup->lock held across the MAC reset, queue stop and
> free_irq(dev->irq, dev).
> 
> A directed runtime validation kept that ndo_stop carrier and the same
> free_irq(dev->irq, dev) operation under the driver lock. Lockdep reported
> "BUG: sleeping function called from invalid context" and "Invalid wait
> context" while free_irq() was taking desc->request_mutex, with
> au1000_close() and free_irq() on the stack.
> 
> Drop aup->lock before freeing the IRQ. The protected close-time work still
> stops the device and queue before IRQ teardown, but the sleepable IRQ core
> path now runs outside the spinlocked section.

Do you really think that this bug matters if nobody fixed it on
a 20+ year old platform?

Please do not point your AI scanning tools at old code!
The patch is valid I guess but we have heaps of bugs like this
that _nobody care about in practice_! You're wasting everyone's
time.
