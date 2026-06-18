Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C8271A71;
	Thu, 18 Jun 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772710; cv=none; b=Ltbv7cc/S36xSzToikEXgAaawNp1pBws1B76omWW75KqM6SSjZk/rVpa9Q/GeMQ+cEd+6IkSTqzefFOog1d3Pd2vwkIZ6noBSscztYYLjUOPTzgefPnIkylh69WTQW9k62HGVFETF7XaCL26iwSfqvai/kjsJuTlHtrNAzkTotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772710; c=relaxed/simple;
	bh=rb9yxoM4gbLjOHysapp1CE0nRgIbFjR/UGC4LqOwwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKlYxdpyJLKzch3Vub/I6ACFTghuQIqE0s6mVKOJUB8yC2Cng4gY35AVy/mIntmuZkS90O1kSyVgSpn/SAXquynXPznNsQ6KsxzGZ2Q/QKtV+9mz46u8ZK0RqzLVKgkjDx3gGwFFSgUBSBbTmurd0NO6xRkNV3kD5ZrQqdX21Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CElUw2+a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=drnQVzBN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CElUw2+a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="drnQVzBN"
Date: Thu, 18 Jun 2026 10:51:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781772706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llqq9V9VjLh585KO4zW2vlsOrn2+ajRbUyv9ZWD/6zg=;
	b=CElUw2+aPATzep1WCEkmjPtFAp1sbh3YKl01We2WpctaIbU8Xg97+9L2qb1HFk0ZqlJAEC
	vhaOc+82IlOYuAG+QwfkauZjUeQSNXCnSNOT2oWN/dIChGRdq1cpMbGXaa3BcOGrGRBagx
	7oHnY0rUwLk5yIWErLlPqRyu5oKvXl8clkHs+MliLImKZPDdHTr0ljWMKdjdH4A0NLqm5/
	YRcGdD4a+1a6MOhDmpsWtVUp6V5gNS6xBL6bRf+cvsgSkuJCt/n0IfDxIlkT53sZ9iIAWv
	jygaaKoAXiPYjM77leioC/QEkD8STIB3LEedFR4hV5LNePBHfPkXqOxJ3AVInQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781772706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llqq9V9VjLh585KO4zW2vlsOrn2+ajRbUyv9ZWD/6zg=;
	b=drnQVzBNhpMpquE9C9RseUnfgR5Bn1EsaWINEsFZlTvoIAR95f3hpRoR+cwqWgKVK/j+/F
	IGTHlaENYmLBcJAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>, Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260618085144.ka6d07jR@linutronix.de>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de>
 <ajJy92ES-Q8ro97A@pathway.suse.cz>
 <20260617111504.GK49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617111504.GK49951@noisy.programming.kicks-ass.net>

On 2026-06-17 13:15:04 [+0200], Peter Zijlstra wrote:
> 
> Can't we push all the legacy consoles into a single legacy kthread? I
> mean, converting all consoles is of course awesome, but should we really
> wait for that?

That would be 

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 85fbf1801cbe0..c72f8d7027aee 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -27,11 +27,7 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
  * nbcon consoles have had their chance to print the panic messages
  * first.
  */
-#ifdef CONFIG_PREEMPT_RT
 # define force_legacy_kthread()	(true)
-#else
-# define force_legacy_kthread()	(false)
-#endif
 
 #ifdef CONFIG_PRINTK
 
and if I remember correctly it was due to delayed CI output limited to
RT. But this does not fix stable down to 5.10 LTS.

Sebastian
