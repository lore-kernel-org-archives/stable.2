Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7535E923;
	Tue, 16 Jun 2026 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623888; cv=none; b=SIdb8RRuo5P8Y+2xJkJVG37ajc2pnoMppiRxbmW3+tEDGh/JVq79j8OisljLCdl9RU+7TEi2YpZXLso3c7hfQc+7cysLCMOHhLfdPE7zJdroNvYMjpfCJIYHPHUX/ej74/v5QEnXMjPdmMlP4w1LWH67oUyAjDs6Za0P1lvgVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623888; c=relaxed/simple;
	bh=sJViFkfm/ekIWg/yU29S/8y7sjVwRMKZ3zuMz1uu4Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8VxegRYEb/X9cQm6MtRLyA6xwht9+lYyoxvyFbzars/ZL8FGFGUZPdOQ0mS9YR8xNLtac/+Oesq9WMPNNH/RKxQ6tSgtp2OpMuM9pNR54stHIlxXsyXD+OinrKI/LcL2fMEHzwxeNK2wQIFu07dA7Md/Q6VBnRDopwZbr7d0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3D7V5a7N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCO1r8rC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3D7V5a7N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCO1r8rC"
Date: Tue, 16 Jun 2026 17:31:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781623884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTBREjQ1CMm+3pVbDHQG4MDlL3sfISBDUsIUWQVi69A=;
	b=3D7V5a7Nw/0QNcsdFn8g1mGRWtyJdw3uPLCSWIH6WyKta76gaNHzUwJ6gOGze5bJ35dQmo
	zAaUvm1MWebK9ewP3U2qqrayUUczV4MeVYronPhznRNuu/xiP/uSq6g+Iby7mpQ8M+bbgr
	KLsaQ8Egf4V/9gerAVlOkdenn9n2CnUtlwiv40PfGrWOnHkkOiSs8iMhSDi5CGOzNWPFKU
	/i6VG9MFZ5SIRFwk7wiOt57x5U0m83ch3jji2mrwsHJ6ZWC1cNDAWTxnuOtvS07pxB0tZA
	aEtlOilzUJxsas6Rarw7N4sKUGwRj5JSfjYIugz4n8VE+9RzBY1YV4PqOjOTHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781623884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTBREjQ1CMm+3pVbDHQG4MDlL3sfISBDUsIUWQVi69A=;
	b=iCO1r8rCnUXgcw/r1g3zthUBwI2wr/K5thRZ3iBTpZjGRSEO4go4GAX+6fl802MGQQ19mJ
	q0m3/BH/hEsawxAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20260616153122.keHMKvVT@linutronix.de>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616081128.04e2c8dd@kernel.org>

On 2026-06-16 08:11:28 [-0700], Jakub Kicinski wrote:
> > 
> > Adding sched and printk folks for opinions while eyeballing
> > WARN_ON_DEFERRED().
> 
> Thanks a lot for looking into this! To be clear - the printk_deferred /
> WARN_DEFERRED would be just for stable? Or there's still some
> sensitivity even with nbcon?

We already have printk_deferred(). WARN_DEFERRED() would be new. I
*think* this is not limited netpoll/ netconsole but all console drivers
not using CON_NBCON if the printk (via WARN) occurs with the rq held.
I don't remember all the details but printk_deferred() was introduced to
circumvent this until printk is fixed.

Once we get rid of those legacy drivers and NBCON is the default we can
get rid of printk_deferred() :)

Sebastian
