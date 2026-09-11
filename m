Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A835E1BD
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138338; cv=none; b=CjVN9LlM8qvOFWWdg/oJxvsviXwSt3fQP+BzKisnrm936RPCD/KxNoWE1ykXwt5bY+GvylddVCny0Fs5AO4KKnhVusoKfz10QstOUvrYi7biTS1s+AlKZaVt/ljehn0vx8LA9T35ZtEpSiGoaxaXReEWrxwGPCFenyASAt3lTvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138338; c=relaxed/simple;
	bh=xB7Gjx7oi7AEzV/VUG5hfLvIwZPLCZ4R2dv/uIR6uUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV1Rg1x+2VDPgzFgw6XZUzvZXqJQXOS3NmBmuCVibiYTAi59obcg3Osnd2MEfOCkzeQ9EAbvNYUDBpn4Eq+lWCFkHCoV5c2XeQ6WrYxkCpDCR0oRbeRn1ZDw56a7CT50XxLpkHHhb56WtC2rJQfzHb5LvID6OIEFXyG9gJ3mFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=eXASwIuK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="eXASwIuK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-939f5e4e919so49648385a.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1789138335; x=1789743135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZhZv1vGSR2vVlo/Lr0l698roU8RNHR6wgwQoRxUqXLI=;
        b=eXASwIuKdpFQKSvFguXK8WanZ3+6GoXcjlg83VLEwY29poF4nlfT09fOLMzRHE3HQ0
         GtiFg4Io6L9YFeEskUOsw2mHxhDeCM9vc70HX4v1cNM1qfg/PDVNbJPIqEY5FAACImmY
         HQLmiHr4EbQhijUCJoeB9xGnASYMFjRpmwHFK1kgIZwIgBzWbPh/AE/3pcFCrqYy6aQ0
         CUKBFW5ybEBe1VFLfrOWHkf+RB0RkRdS4F52LZWHwrupa3q7RcUGN9nKU/OfQfAbXwAR
         BzUl7Zt4tHKLqgBRls4RkaQkD2yANz/4qnyrTdYg2iUuT78a+S3yJzImFDu1GX73xRCn
         lLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138335; x=1789743135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZhZv1vGSR2vVlo/Lr0l698roU8RNHR6wgwQoRxUqXLI=;
        b=PJzVj2YlJq2IYcAA+Jxc/U190QtVy2awXHiCN+fqoubxZU47KNKCCQwMygQ5WnDcQt
         pgsBxbnFr1WQ4Z72vd8buTDNButhgj+BBlDytlhIo/q+WEOwexQWi3nTNczKy79qQOZU
         dkuEHrlieO9pMDbTnicBBlCljWV6B2wVjGaAayT4aQvpQIjHsachT1m9tAi5FrB7ezZ1
         TaTPwUc01oNziwGCthC7YK2QAz3tn9A/PphGLFpDiG+utm0Vmh9HRW/6CybgOobmnsCw
         yw2laRmuakLttKHSLCnHlxdLylVjH1fo2Nbf1vQLWBQ2RgOi9zocmJ9xgcBdzpCjgcSx
         dNFA==
X-Forwarded-Encrypted: i=1; AKwUvBwQFnLLnJRzKpsND9HbkAjWDuyRh3zywO+bOV6epbf5CeDUNyURzGUO18cP8c/ZWTEwY1iIAnU=@vger.kernel.org
X-Gm-Message-State: AFuF++nth7D7oS89cmlyJiEvM7nM1KadoyfKquUUZJzPmjYf+BRSZjYD
	rQPPzmXXwjbWVRP9ztXwJCi8W9PeCx4c4+15GhrHJJmQogDMDVRbIIiBRfl3/OA15A==
X-Gm-Gg: AYBFou0QyLKtEcFxvXpweh3oW/+x3TJEG8KM6DruiMAz1DUq3P5txdMUpD8IdQyrsXx
	DPn5J7jJQaliXz/phwbi2/rlu/7iz6MgK44DruSBOU12kW+e/vqqz/6M7WXK23ZfmfD6RtVUZQo
	ef2jMtn5Nu76ZP8E9tEn6wj46/yFoC/jw6pLngeIhj7QeoS+D0ij7dRrBMxEXlF2jIacxcNtXXo
	K53sn7b0RhBb3+WufZKLaLqhXF6heNMIzLx2qbAKR3eX8+GvqMxb1rGdSt2+E8HLLoQBPH7u1zc
	USiiPLYWQzzPtyecPxJtSqgT4f4vw9EMfLD25Xhdvz+ddUc+8qT3UzeGymjdz9ywAPwaUoB5F/D
	k/KIQwN8GC/arUwb/2pLLbtCCoe/aPKRwif8/7037dXvDax1d+Q79cnFE41bErsNl9SgokkFFAX
	r3LErUtoYSNvAOdxIGmQOKcoPfxrmv8FP1G8JPp2Ruug+4QhX8g3hjlMfrg+Kb01lqZ90eWkai
X-Received: by 2002:a05:620a:17a2:b0:92e:8310:7369 with SMTP id af79cd13be357-939ea030e13mr590476385a.37.1789138335253;
        Fri, 11 Sep 2026 07:52:15 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::7544])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ed67a93dsm171386185a.43.2026.09.11.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:52:14 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:52:10 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, boqun@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <e8e2bd62-13dc-4a53-af0d-051c83b08f4f@rowland.harvard.edu>
References: <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
 <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
 <aqKu8nJqPsmKOo1d@localhost.localdomain>
 <20260910132843.GS776954@noisy.programming.kicks-ass.net>
 <aqPQrGWqKfX_5MMj@localhost.localdomain>
 <20260911102203.GF1837346@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911102203.GF1837346@noisy.programming.kicks-ass.net>

On Fri, Sep 11, 2026 at 12:22:03PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 11, 2026 at 11:58:04AM +0200, Frederic Weisbecker wrote:
> > Le Thu, Sep 10, 2026 at 03:28:43PM +0200, Peter Zijlstra a écrit :
> 
> > > The way data dependencies work in this case is a LOAD->LOAD ordering.
> > > The LOAD-ACQUIRE that is part of LOCK must happen after the initial
> > > load. And then the later load is constrained by the ACQUIRE.
> > > 
> > > So LOAD(B) must resolve in order to do LOAD_ACQUIRE(B->lock.value).
> > 
> > Ok I must confess that's not a pattern I'm used to and therefore it's
> > still a bit counter-intuitive to me. I hope we can document that somehow
> > somewhere.
> 
> One way of looking at it is the computation for the address of
> &B->lock.value.
> 
> A	void *r = LOAD(B);			 // B
> B	r += offsetof(typeof(*B), lock);	 // &B->lock
> 	spin_lock(r)
> C	  r += offsetof(typeof(B->lock), value); // &B->lock.value
> 	  for (;;)
> D	    v = LOAD_ACQUIRE(r);
> 	    if (!v && !cmpxchg_relaxed(r, 0, 1))
> 	      break;
> 	    cpu_relax();
> 
> Note how the LOAD_ACQUIRE() at D depends on the computation of C, and B,
> which in turn depend on the load of A.
> 
> If A does not complete, B,C cannot compute the address for the load of
> D. Therefore A must come before D.

There's one subtle point worth making here, although it doesn't affect 
the final result.

We have to be a little careful when talking about when a load happens, 
because executing a load actually involves two separate things:

	Obtaining a value from memory or cache, and

	Completing (retiring) the load instruction.

These two things don't have to happen at the same time, and in the case 
of speculative loads they can happen at very different times.  So 
whenever you talk about when a load occurs, or whether it occurs before 
or after some other operation, you have to be careful about which part 
of the load you're referring to.

In theory, a CPU could try to obtain a value from memory speculatively 
before it knew for certain what address to load from.  This would defeat 
an address dependency leading to that load.  As mentioned in 
explanation.txt, none of the archictectures supported by Linux do this, 
and the LKMM does not allow it.

However, if it did happen in the example above, the CPU could read the 
value of *r at D before A had finished (say, by remembering what address 
it had used the last time it executed D's load and trying to read 
speculatively from that old address).  But even if this did happen, the 
cmpxchg_relaxed() in the line following D would not be able to execute 
successfully until the CPU knew for certain what the value of *r was, 
that is, until A had completed.

Alan Stern
