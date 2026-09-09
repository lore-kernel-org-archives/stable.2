Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758046AEE4;
	Wed,  9 Sep 2026 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941066; cv=none; b=fwpDfoJuV6zTEAag4aZJd2Sdo9/uVXL96gaPCmPkp3vrOkv6XZ4aXEo57j/70iwlNoS8kId6S7pu7uwDcQ3T/y9wAJUa4zpJxX9KSqTnsAl5OASQyMi6UVmT4hUMO3lASrUp+Wzo6mDHMoMc4/YEvTccOkAvUXJqwj3KzRnsce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941066; c=relaxed/simple;
	bh=yizD6Yn5JYZkoAHOCTdYqi5SSecXNquO+H4Atc6Mr8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK6Xm1cgGiXMJQJKuVtWvhl2zUk0BX5hFB0pxPbT/5NUJzRktn/xMKmD6J542/nFMYG9/H3IYbFnfW3vWnSrNKv2O4aoLEshahx/qCVN8K3jgqNHPTCpaeCy6THeQXTg31SuU4bi4SAK//UAOgfeYhTIqJGdZXO2YiT7fW+km1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jp5AQqjt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jp5AQqjt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+FhzJQT1ah/k5MMvwQ1Wjl9Ig6AU8A7aDGa5efwnat4=; b=Jp5AQqjt6UdMA+qs2ceAgGYQhB
	aZwZu37GRIRFUrvnOdh+X5NCYuZUvyWuqNJtfmXf7/i6aEqyJszVMLWxX8/fOiEAFkXqMoma4B15M
	bwYcwnnuz//uMPxkAsXq3QIzvZ25SjO/Nt0+vtSoCVROC2fkarFVEH4P2Ji5KjyBp2X0aKhCyguF9
	xERNiRgTFNeO1F5ooZcwRBlPyTsInHVgC7d3eLIvK1ABm3geM/xkkCO4hz3NPutN8/1GwluH53Qi4
	y3WF4QdEHdRr4OUHJTAdU4C7JhE+vA1AzrfiuXB7N66IyPbVPZoLNyPEBHZQM1ZVSZL88zKtESMtQ
	6Q5gSMSw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4DHs-00000002gQv-48SK;
	Wed, 09 Sep 2026 08:04:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B073230036F; Wed, 09 Sep 2026 10:04:07 +0200 (CEST)
Date: Wed, 9 Sep 2026 10:04:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_gOSWtPNjwWS1e@localhost.localdomain>

On Tue, Sep 08, 2026 at 12:15:21PM +0200, Frederic Weisbecker wrote:

> Yes this side is well ordered but what about the other side.
> Ok let's simplify the picture:
> 
> Old leader                           Exec'ing New leader     CPU 2
> -----                                -----                   -----
> 
> WRITE q->next = q
> WRITE q->prev = q
> 
> ACQUIRE tasklist
> RELEASE tasklist
>                                      ACQUIRE tasklist
>                                      RELEASE tasklist
> 
>                                      WRITE pid
>                                                              READ pid
> 							     // smp_mb()
>                                                              if q->next == q
>                                                                  WRITE q->prev
> 
> Isn't there a missing pairing full barrier in CPU 2 ?


Let me try and have a go :-)


do_exit()				de_thread() 			posix_timer_fn()
  exit_signal()				  LOCK siglock 			  posix_timer_send_sigqueue()
    LOCK siglock			  UNLOCK siglock 		    t = posix_timer_get_target()
    tsk->flags |= PF_EXITING; 						    LOCK siglock
    UNLOCK siglock			  if (!thread_group_leader) 	      if (!list_empty(sigqueue))
    					    LOCK tasklist_lock
    flush_sigqueue_list();		    if (leader->exit_state)
					      break;
  ...                                       transfer_pid()
					    UNLOCK tasklist_lock
  exit_notify()
    LOCK tasklist_lock
    tsk->exit_state = EXIT_ZOMBIE;
    UNLOCK tasklist_lock



Then there is indeed nothing that makes sure posix_timer_fn() sees
sigqueue updates done by do_exit(), because those are ordered by
tasklist_lock, but posix_timer_fn() doesn't care about that.

The easy solution would probably be to do transfer_pid() while holding
siglock?

