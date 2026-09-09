Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD9D58E2C5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964399; cv=none; b=FWH/LSUC2WNvvlliZ+7cnahdLLTBV9vX1Bf3Lhb2vRiobWi28qJvnwCyimPqUlCkGUocFh/3Sb3P72kkZCPT1HlsS9hwDlpIPbM0AW5lj9c+YdZSJo5viQ1y2Gi5RJfyJyTxUHncOuzn+crxY2VQFak2v0KdK45PF7V/TqMXWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964399; c=relaxed/simple;
	bh=fntJjqdG2j+yL6RVAB6nKW7v01eU7mQiMAgAsay0h1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph8pISxWmbi+1zofJq+w7iMg0swBCCLF3VzBCOexcbqOfGRKE1Tl21AxSMG7OVTiycvT7WzMhcReU2MXDi/DeRi5tw09oCo9cLrEwaN/oJH0JnLnYL8ffcDK8/o8ACPRh77hTTNqQ2tax2cbE0FtAixYK54Si8JgPPyRn7qhQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=BohNoRLH; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="BohNoRLH"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66fa10f35caso5621426d50.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1788964397; x=1789569197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d0bOlfBpQTbQFgfmthpzay0FO8NJ5huTnd0J4hBWl4w=;
        b=BohNoRLHOGPYLbAvslIJAj4o5LgrV6pt+LILH+usEb4XVgKbFTMSPrDCqCnkpa18JG
         vLPDir4wVI9+AhvC6r20JVK9IteSk+HJzAl5f/eUkjLQd1MN/3OUAX79c9r6AiP7W7H7
         RDLOui3vgihdH/RWDMUNYGvY6kT2TwXZ2XGaNzUfmeKUfSPdcytzHoiGtjgXWR74t2mL
         Rgfi+g/gPsgXOHEvHb5nwBde28MkgTFZ9zSnJwcyOIwHfht9czLaIFUtPFsBTUheFcde
         3Dw5jEn28X7fTE32tGra3HYbaXbz9GqqQ4VSO90n4HvjDau/VNmmUE6ZKLZmm3yw33qs
         Uo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788964397; x=1789569197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0bOlfBpQTbQFgfmthpzay0FO8NJ5huTnd0J4hBWl4w=;
        b=Dbuj2HaPpKUtp1w2DNg01XdkuiC9t2/neNdVbYF7OqLIzfI8tCErV8Zdxk7PTu2rra
         4YEciyMnKbGfyG2X1kyoPN6ZyH/D+tjcooOp3eYB7fBLcUwXtZvOUroFmonuPEaYJ0qa
         rVGezVjCLEokRa/tXfaC2JjzeP+RU6c07diUbAtPT1D6FiiWKuFr/044Yyu0xZBTEO1v
         MONj8PBVx2hEHVrzSMXvQzkIFACsEPhQVPD/n1d4UTrXKCxbCH3IGPyBTQqbXC1B6zfN
         LXeXT+aL0PDcUfj4FzTbf428ZJAVeFbbWZn2vUsjGJnBNXPXV+P37NIAg0pb6OVXrpW2
         iEzA==
X-Forwarded-Encrypted: i=1; AKwUvBz4aAT28mVzK5oYdRcgB+lqXFb2vnXWnaLGhBeyGOQFo95dzuS43R8yByBKdDGwJfRmLNW8/PY=@vger.kernel.org
X-Gm-Message-State: AFuF++lYh+DW27GjOdsYpIWM56pI8jvwu3Q0SaV7QshBZf1vptaUqoR8
	BJrug1epQXojQK+i5mC3nxXLjbiS69WvuamYyxljgboLzp99RTcZVU1K6ZfUchUciQ==
X-Gm-Gg: AYBFou29zC5ftc8g5Tv/f2pLuCG+BIySlqRanznhdF9nImPsr37NtJY6oYa7+M4faHH
	vlQ+Ul9XcqsP4SpOVAfVXS4Aoyq/vMxbvA8twtUxQousJj8sGRDwm5gM6xapWLnA/1JoBJhuSiB
	HMoWhznpLhH3s2Bch1lYEsBPtg4zrm/Y2rPzjMfktqQUhEmP16z+zqjBOsfGL3oOPhedh8bzkx1
	Ole87EkMzVrzm6MwtMQTGeudHwRLqeJ7GXMDd9bK1UJrxbwgLutnp83njakeMoDubnDEd+/60Kj
	+OkYU9AqML9U+MSLyAV5xh69aZwOeO4EewyBMIfWXQOUg+fuqjTdKFmbORFBjVmIf69YsgfDv93
	eCaEgzZn+qoBrefiLO71KgeIm9wVgYKuUa+Bps8JH6294mQFgxBhfxMYehFRaAKzphmEt031XOg
	bfm48nCF2FtA727UC/jV3fj3LeRhGA5/KXfXG9LVOji/HI3idhPxpAs2WEzjjTrm5Jz7up74Fpu
	HXI0diGQKKqAn2lgw==
X-Received: by 2002:a05:690e:488c:20b0:671:27a:df14 with SMTP id 956f58d0204a3-671027ae48fmr1087364d50.20.1788964396777;
        Wed, 09 Sep 2026 07:33:16 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040679e13sm145160216d6.26.2026.09.09.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:33:16 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:33:13 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, boqun@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <285fa0e6-0ca5-4cd8-b0f5-819d44583fc9@rowland.harvard.edu>
References: <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909124555.GM776954@noisy.programming.kicks-ass.net>

On Wed, Sep 09, 2026 at 02:45:55PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 02:13:11PM +0200, Frederic Weisbecker wrote:
> > I didn't know about all those UNLOCK+LOCK properties. Well,
> > I know that UNLOCK+LOCK on the same lock, or on different locks
> > but the same CPU, equals smp_mb() except on powerpc. Which is why
> > we have smp_mb__after_unlock_lock(). But what you describe is quite
> > different.
> > 
> > Is this something that we should expect litmus to modelize?
> 
> IIRC these commits:
> 
> 6e89e831a901 ("tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire")
> ddfe12944e84 ("tools/memory-model: Provide extra ordering for unlock+lock pair on the same CPU")
> 
> Were supposed to handle:
> 
> 	CPU0		CPU1
> 
> 	UNLOCK(A)
> 			LOCK(A)
> 
> and
> 
> 	CPU0
> 
> 	UNLOCK(A)
> 	LOCK(B)
> 
> respectively. I'm forever confused by the actual CAT stuff, nor am I
> particularly adept at these litmus things. Boqun, Alan?

You got it right.  The required ordering is that instructions before 
(and on the same CPU as) the unlock are ordered before instructions 
after (and on the same CPU as) the lock for read->read, read->write, and 
write->write cases, but not for write->read cases.  Furthermore, this 
ordering requirement applies from the point of view of all CPUs, whether 
they access the lock variables or not.  In other words, the ordering is 
required to be RCtso.

This ordering is weaker than full smp_mb() in two respects:

	As mentioned above, it doesn't order earlier writes against
	later reads;

	In the WRITE->WRITE case, the guarantee is only that each CPU
	will observe the first write before it observes the second.
	There is no guarantee that _every_ CPU will observe the first
	write before _any_ of them observe the second.

Alan Stern
