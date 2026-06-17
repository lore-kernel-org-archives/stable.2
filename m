Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292A478E5B
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692660; cv=none; b=M5Jp1scjqiUX8/Pz9UPLKjsdOs+BI2P2yeTOTgyuyraBy4lkFp3QU1g5HepHNchDyjOeh/v2K3pchgKiMA+v5xdE33PSyGYqT3Ich/j5gnBkpB4GKcgMKubU/ZA4JPjRyi7r07dDOy59SKU3eVbtn9XEqI4gs4n9LgASSmVa12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692660; c=relaxed/simple;
	bh=7KGOXjbFus1OIBdwidGkbmaAhe5QXQQ88pd8jQjhpr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQEPbvMLeC6SMjmNSxv2KRrMiu8W9phlY/FEFmRNIDjFWsBRfqUFfEdZuB8zAxqxgCuAk7dmY1bEbyvZI+vKWB06xKmsx6ixaOsdZVdQqf0S58srEUgrfKDeP1pem5Bon17vP/n2JqxLEUZgIK/rBDUOqa+kMSJJ5/vm0zNNg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FOOi9K+l; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FOOi9K+l"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4631679f204so149286f8f.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781692653; x=1782297453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDhvQwG1QwT5cvmH6BZBllkhAVPQhK/Hew5ZXNgViMA=;
        b=FOOi9K+lPc3v+6COO0rMCTOQ3AM873AfxCLoKarEiH1Ej1VUNSWBjEAAiyw3tUPkkD
         c9I0dzihqELjE6ZHumASv3Nf4iZQkeTGWj4F0qowRseXhSHpydhKKRqgZps5BLVv9ihZ
         Pga7G4IDRuigevfhv0Enzm43Yx9q+Quy14IPb9fGjn7yEWZH1jOsoGn/KAIsjTfBZn5C
         T07hWdfivi8vVrYBA4g9wBHZ9YBEjby8LU10yzg700/mOTl919lw4dg1V8oSuqRqZyAe
         AS9PRFOShvz91InygEc88rzu99wiCc2FOvowixLqlIu/vaGdeXQ4VzU+X6g4NBuBPr3R
         D5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692653; x=1782297453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDhvQwG1QwT5cvmH6BZBllkhAVPQhK/Hew5ZXNgViMA=;
        b=l1BnLqS1DJwzn0AN7yxEOF3uJxwEqCqsmL9CLM1UyeIYsQ1hxynfY7+eHwmPs7u060
         KWVPMinA91NUCLWOiBf4a/xlc7fSBRwi2TOgaNLM1MZidmWi5B8xSanyTycS9mR/XAH7
         nt+G2Thh8JE2Yx2Nd5j2QMk3iZq/r35cKXq7XZ+whQVZvnx1MNb0T+nmc2YZoymeANjQ
         hd0WnvCA7oeANIqy+c7ynAQpzG1TSlmoT3NuU+LiFOFmw4Mu5KmBsfwqb2JDc61/3w31
         eDtaiaBeq8Zvs37woeBdX8DLmHm5RHH3hAXMeWjPzXqKpOaetrgwGa1dLqmn7oKiu2wJ
         0tBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VqP4vkPmQ5DqDHa2y8xuNXFPtEl5gAEqIjEjISeSPW/96YLUR0+AXWeZZskoeUq749Tf94do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvepxS6GOk35mHCj9XzHYxT0zYV3cJ/XF7LIfYji9AeExk1hH1
	tqmLwT7i69dU42LaIno5FVkurNEnurnwG6MLbBN0UHCHvYxCWoHs9jnagYMc6JYlEBE=
X-Gm-Gg: AfdE7cm0xKi1d7C0C2LG9qvwGeYjAEn0pACb4AC2TyKkeSUgy2tvoAceDHgRgA/zP6u
	NBZp9A1OlQ3e8Qlwzc2/glREmuNIe5vLMTgW2lV8xml+z2jnc5ukolDX63f5131dE6Z+s8g1a7s
	vweszUw4Me83qebI0cIEwSH0xGWiYFcNotdFGoEcrLdhu7dtp08lrJDca2N/JO1v2t/GQu8THiz
	vL7wyJZdqoulquMWAm+yjdfGLtij6Ip6TvdY/C1KVodqCo4gRdjok6ZrXJ5J5hedE8X/4GRZKuO
	9NmpFv1GiMdEAHylAx4+K0sIWMIVp7cEiQLycrz/ytyYwc3beu4NqMOhaiAZdYSGLU2PQ5aRtV7
	fIsVaf7PYWg1qUgJ+/gQFCXBC6W2HZv3iT5U4ajRuyJFXDHpf3unhlFCVLrxiBIOmfjSe3aRKKj
	leOqSv4WITRZiO75U=
X-Received: by 2002:a5d:5f53:0:b0:460:6b12:1783 with SMTP id ffacd0b85a97d-46268e1fcc3mr4236952f8f.4.1781692653017;
        Wed, 17 Jun 2026 03:37:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d4fsm57111382f8f.24.2026.06.17.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:37:32 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:37:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <ajJ46o4fomfxY5CX@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616141719.67684bf0@kernel.org>

On Tue 2026-06-16 14:17:19, Jakub Kicinski wrote:
> On Tue, 16 Jun 2026 19:02:57 +0200 Peter Zijlstra wrote:
> > > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > > to NBCON console infrastructure"). Because from here now on writes are
> > > deferred to the nbcon thread. So this purely about -stable in this case.  
> > 
> > Hmm, I thought netconsole had some reserved skbs and could to writes
> > 'atomic' like? That said, it was 2.6 era the last time I looked at
> > netconsole.
> 
> Yes, that part is fine. The problem is that netconsole tries
> to reap Tx completions if the Tx queue is full. We can't call
> skb destructor in irq context so we put the completed skbs on
> a queue and try to arm softirq to get to them later.
> Arming softirq causes a ksoftirq wake up.
> 
> We already skip the completion polling if we detect getting called
> from the same networking driver. It's best effort, anyway.
> Networking-side fix would be to toss another OR condition into
> the skip. But we don't have one that'd work cleanly :S

Alternative solution might be to offload the ksoftirq wake up
to an irq_work. It might make this part safe for the
console->write_atomic() call.

Well, my understanding is that there are more problems.
AFAIK, some drivers do not use an IRQ safe locking, see
https://lore.kernel.org/all/oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh/

Best Regards,
Petr
