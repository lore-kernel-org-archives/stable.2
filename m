Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE363E4C6B;
	Wed, 23 Sep 2026 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144699; cv=none; b=oBNPEu2uhl2+lXzdxoYfxz9vNUmwYGLzB88XXmszTexOcpLKXsuA2co0pYixoaRFLcmL6j5MiMXKVahIdDmZx/vMHPm17GN0hUoFXAR/HXXbHP0AAnezWtZqKDv+HdQBsvAXUnld2q+v1uiqMyX9EWasm5YWuvaoCOYMRufqrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144699; c=relaxed/simple;
	bh=nyDFj8GSfVMz/iweAypKdQ+Y9ZzMkfNh7Ehq37PbvhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UluHymgXLKMa8XLC8udi1OdMW3WpXE2mF1wBe6HElqLVvUWya4a28olaW/tA5V7zANlSb7QyMIpPqZhNMP4dZkKrDnEZJL4RAcrVjYi5kCV3ajFMNJSj4bpjc8KeBJBFW52ZESPZyZX3VcZ93wj/2qGG7JnDRfH8znjLUny5SV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZSAMTl2j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/stwqPg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZSAMTl2j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/stwqPg"
Date: Wed, 23 Sep 2026 08:24:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790144696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+Kd30g846HGZLOYEKmEAqtiOww49Ok9pxV3DLVIOME=;
	b=ZSAMTl2jsWi6tWk/kxqsBXR1v93aj741ThFraZFI1eKz+Ob13g5Oyp+QbCEadseQZavJ6V
	vd72xDKjZ9cDyH+4YeJZZsvWoahb9kyZp9Ya/yYWblGq3rAsI82cg3dQoFFGgxuDYQN2Ak
	LxlA5lp2yuEKjS42LDpYCisSFgMqH5oaRiVj0Y+JUozkJloxvCAwn9QjnAwy42uGnSHVuA
	wZ23y/fbLyJKpe7by6uleLUF5aTonmUQ87EIk1rxSvfxKpejhk756sOkyFi1KsKQrXe0tb
	jBvPVEemmMFFMQBdkPSzXCySS6V19vokaqBLqjjBMl+VTc8xIrSXJss9XVMIng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790144696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+Kd30g846HGZLOYEKmEAqtiOww49Ok9pxV3DLVIOME=;
	b=W/stwqPggWUmbCpUFJnscKOc0QIPzP18qyVg/1kIFPtDjovrlEo8d1sPtw2LCCBlvM2PcT
	hD8IIdb2TvIpOFCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH net] net: gen_estimator: protect seqcount updates from
 hardirq readers
Message-ID: <20260923062454.0W45uc5U@linutronix.de>
References: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>

On 2026-09-23 11:29:36 [+0800], Runyu Xiao wrote:
> est_timer updates the estimator seqcount with preemption disabled, which
> does not exclude hardirq readers on non-PREEMPT_RT kernels.  A reader can
> observe an odd sequence and spin while the timer is interrupted.

How do you inject a reader from hardirq? Isn't this meant for softirq
context only?

> Disable interrupts around the seqcount write section.
> 
> The failure mode was reproduced with an x86_64 kernel under QEMU. A
> test-only hardirq injection invokes gen_estimator_read() on the same CPU
> while est_timer() is updating the sequence counter.
> 
> On the unfixed kernel, the hardirq reader reports the seqcount lockdep
> warning and spins until QEMU times out. With this change, the reader is
> deferred until the writer restores local IRQs, then returns and the guest
> shuts down normally. The hardirq context is deliberately injected to
> exercise this interleaving; ordinary userspace traffic does not guarantee
> it.
> 
> Fixes: 1c0d32fde5bd ("net_sched: gen_estimator: complete rewrite of rate estimators")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Sebastian
