Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1F4F7998;
	Wed, 16 Sep 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565155; cv=none; b=KNgqdR3ri72HclKvFO9nSX25j5pqtFpEZVP23kv4JOokoDBgywkgjxgrr6OTR/9vJ4Z+rAiCwSgSueguSJeti8ZzYiBpgD8PptbpaJarPbEQ32EAf7M7qcIMrSKFmI57QF+1ejW8pJlNWi0PYCREA1mANDgfNhc85ld3k3bgtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565155; c=relaxed/simple;
	bh=o1Me6Ims6tDpJzQ4N/cOSUaOSRTbxX/e/btCNucvSs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoOrr9qqDwMQOTt4r6bCt/CDXWR5NosPdQ4CwFkTiqhydbQBnyj/C7f6b/7dEOT6WTHjwBchDbzP2Voz6M/ntlide/OSo5tBZqVbuvjyLw1lNKdJPHftlslY7fXNgjlpfJ7oMkIn5US9PL99v7CGtL5T/c09TW2E9Rde2r3NZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAiDZPDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAiDZPDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7BC1F00893;
	Wed, 16 Sep 2026 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789565149;
	bh=tZawKGwuMuWWXQf64Ch7n5KkozWVDKTFmaNIELLlX0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IAiDZPDfnZMvnQhwsSyXrEE5NVGO1/egOUOlFPkvoPVj5mwwgWiAFhVKGB0YgfHJU
	 av6nrY3Qc8LZsEPBhX+2/9TR8azersqRMfG0zoJci2pePaEN23iP2Jspj7tGPqeBmu
	 GV/MUFRpMb4IWU2Tn5rblglfwzwxUt0Xa1vRGffrBAsT1CiSuRmt9zxYsWwKLlI3LA
	 TqC1dHYGSxnBigPfuiK/zU7HUBR1pfUh8PNfXXtNLJmEQhY5q6l0fd/3VC0snoQ8W2
	 Bg8cuof/3QGM2mZqm9GGz4NdYVOdOBBVXl6ts2puau5owde8vDF7MZTQy+cir2bhvR
	 coKxyXKNl9JLg==
Date: Wed, 16 Sep 2026 15:25:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, boqun@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <aqqY2hmuzOVVBFdQ@localhost.localdomain>
References: <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
 <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
 <aqKu8nJqPsmKOo1d@localhost.localdomain>
 <541b1db8-8649-46a9-9fa1-1b5f93cded7f@rowland.harvard.edu>
 <aqPzzMlPpXMNZ5WC@localhost.localdomain>
 <3c6865d9-a4b0-4fd9-a6d2-c4f4e1f94d29@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c6865d9-a4b0-4fd9-a6d2-c4f4e1f94d29@rowland.harvard.edu>

Le Fri, Sep 11, 2026 at 03:05:47PM -0400, Alan Stern a écrit :
> On Fri, Sep 11, 2026 at 02:27:56PM +0200, Frederic Weisbecker wrote:
> > What I would love to see documented for example is our case: acquire semantics,
> > which are described to apply one-way from a single memory target, are also
> > transferrable to other memory targets when there is a data dependency
> > involved between them.
> 
> "Transferrable" is not the word I would use, nor does it describe the 
> way you should think about this.
> 
> This is just an example of the fact that ordering is transitive.  So if:
> 
> 	write A is ordered before write B (by an intervening UNLOCK-LOCK 
> 	pair), and
> 
> 	write B is ordered before read C (because C reads from B and is
> 	on a different CPU), and
> 
> 	read C is ordered before read D (by an address dependency), and
> 
> 	read D is ordered before read E (because D happens to be a
> 	load-acquire)...
> 
> then of course A is ordered before E.

Right, transitive fits much better here.

> 
> The exact nature of the individual orderings -- such as the fact that 
> one of them is a dependency -- doesn't matter.  What matters is that in 
> terms of the times when these operations execute, we have A < B < C < D 
> < E.  Naturally this implies A < E.  As well as B < E, C < E, and so on.
> 
> As such, I don't think it's important to send much time on this in the 
> documentation.  It should be pretty obvious.

Ok

> The one thing to watch out for is the imprecision of the phrase "ordered 
> before".  When writes are involved, the order in which the writes occur 
> is not the only factor; you also have to consider the order in which 
> those writes become visible to other CPUs.  In the example above, we 
> know that the UNLOCK-LOCK pair causes write A to become visible to C's 
> CPU before write B does.  Therefore, since write B definitely is visible 
> to read C, it follows that any read on C's CPU that is ordered after C 
> will observe write A.

Right, heh, terminology indeed matters here more than anywhere :-)

Thanks for all the explanations!

-- 
Frederic Weisbecker
SUSE Labs
