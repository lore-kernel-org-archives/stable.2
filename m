Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185C5013AF;
	Tue,  8 Sep 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862525; cv=none; b=Qsh99dN/7U0Ug8NNFiv/taXs+VQg5Un/ShgdRcdiAwDQEM646eMbRvTYjX87OgoenVQEguibRszVzOxt6QY5aGuxPEDenVHd+u2npyXV1RHAUMBq1mD2eIlZ8QwaFcjZI3Z3K5C8R1gT8IWPagMb8jIPVIzOkuNqH5i1kbaLWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862525; c=relaxed/simple;
	bh=KhZcOhwfqOXyJL827hD2p3zO+S18yDJfSF01/73/sIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCL5IrJcMyCI0iuOdrRPkMXlWGcZkyHIkVt8KeVkxdOkcc8eIkt/X5W/2kL+ESDFAWUexcYiUq2Kckr9f6g5ofdtkDIOnwdtHIVTqRDS0NEv6ShE5ShJ216DYOkCJCfiAb8iCUNWu/4LYP4B2WMMg1BNkcpoe2+k9K6pJ2iPGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6l7AId2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6l7AId2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4121F00A3A;
	Tue,  8 Sep 2026 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788862524;
	bh=mYc22su1Pld1wIXxVxkbK8rFZ05p1gw9nYRbfQ91Ry4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H6l7AId2d8E1bfFYe9r+WIdpjH4PiHVxEMKs1/G9RsJQgMGMqIsLm/oP+TXCUCvsU
	 O9SwLXJWzSYEG5aDV9RcM1caiQT3rezFtKalcIFemPF6yrHmr7DK9s+c5Y5ytwr5E+
	 m+rjeDLWFNOcWKoxK2em/x2Hgt5YF8c4ANkkUgeZmd60aPdU4tSQV3vc4pLKx5B2F0
	 qB24+qiZ+5KfBwG58fLW71nL2ZqO2TMwdo9Hr1Mpts+xFd+aF4T4oM8DiLzTlV5kmd
	 fOBhLOqaYzNTEqrRTYwT+sV1G4KE7n8ZoOCt1psYpym9wBogPoio6ao2aUAaQvyX4U
	 Qc/suS3x+XdCA==
Date: Tue, 8 Sep 2026 12:15:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <ap_gOSWtPNjwWS1e@localhost.localdomain>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875x0g3de3.ffs@fw13>

Le Tue, Sep 08, 2026 at 12:28:04AM +0200, Thomas Gleixner a écrit :
> On Mon, Sep 07 2026 at 22:15, Frederic Weisbecker wrote:
> > Le Mon, Sep 07, 2026 at 05:26:04PM +0200, Thomas Gleixner a écrit :
> >> It's not obvious of course and might deserve a comment.
> >> 
> >>       exit_signals()
> >>         lock(sighand)
> >>           old_leader->flags |= PF_EXITING;
> >>           head = remove_signals()
> >> #1      // RELEASE: PF_EXITING must become visible
> >>         unlock(sighand)
> >>         flush_list(head)
> >> 
> >>      ...
> >>      posixtimer_exit()
> >>        posix_cpu_timers_exit_task()
> >>         lock(sighand)
> >>         ...
> >> #2      // RELEASE: The stores in flush_list() must become visible
> >>         //          They might be already in case of preemption
> >>         //	    or due a RELEASE operation in seccomp_filter_release()
> >>         unlock(sighand)
> >
> > That second step only appears at the end of the patchset, right? Otherwise
> > it's done on release_task(), which is after transfer_pid().
> 
> Cleaning up the enqueued posix CPU timers has nothing to do with the
> signals.
> 
> >>     exit_notify()
> >>       lock(task_list_lock)
> >>       exit_state = EXIT_ZOMBIE;
> >> #3    // RELEASE: exit_state must become visible
> 
> In context of patch 1 alone, this RELEASE operation guarantees that the
> stores in flush_list() are visible.
> 
> The new leader cannot proceed with swapping the TIDs _before_ it
> acquires task list lock and observes under task_list_lock
> 
>          old_leader->exit_state != 0
> 
> The TID swap cannot be reordered by the CPU _before_ task list lock is
> acquired and the exit_state is observed as non-zero.
> 
> As the exit_notify() RELEASE made both the exit_state store and the
> preceeding flush_list() stores visible the third party must observe them
> correctly as well when it can observe the TID swap.
> 
> It does not matter whether the RELEASE operation after flush_list() is
> spin_unlock(siglock) or any other RELEASE operation before and including
> the final one in exit_notify().
> 
> Any of them will provide the guarantee because _all_ preceeding stores
> must be visible before the RELEASE operation is complete. 
> 
> No?
> 
> Thanks,

Yes this side is well ordered but what about the other side.
Ok let's simplify the picture:

Old leader                           Exec'ing New leader     CPU 2
-----                                -----                   -----

WRITE q->next = q
WRITE q->prev = q

ACQUIRE tasklist
RELEASE tasklist
                                     ACQUIRE tasklist
                                     RELEASE tasklist

                                     WRITE pid
                                                             READ pid
							     // smp_mb()
                                                             if q->next == q
                                                                 WRITE q->prev

Isn't there a missing pairing full barrier in CPU 2 ?

Thanks.
