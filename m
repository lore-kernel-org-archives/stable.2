Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D348C402;
	Wed,  9 Sep 2026 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944916; cv=none; b=KnxydVshxtfW2IB0mVKH0Ogf9oUbUgE4Lhob7Yy2eyfRQpYAc+zQiaQoQ/jzTULIK45ukTseWlPqfgbr6JnR4DgVr7ksqoNjZ5+u1nFTjC3mKVL5FrJp64fP03307vt/gHGp6pofKojpt/TNoIpKkQImDsZvB75MNEZrDBf6vkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944916; c=relaxed/simple;
	bh=4EFFBgRF1Ln+SQ3SXXVLN+LEdKbDyIsZFmNprV8uEew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ToVHRyLqnwffpjkZxrWjHukrl+WjSIrNRKLlclZFDx+X0RNMgPH4l5Oer79pW8n+GS3XA23i7PRgc4ZTRQJYCIaZIrpW+OV1a586tEEk082qfeZgrAuFAU7OWkl61jGp1vgQhk4TrsLwFIk7FI6G42xuIgK4Q3WSYIXZSaWGMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=masU3CVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="masU3CVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A74E1F00A3D;
	Wed,  9 Sep 2026 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944915;
	bh=9WmWAiR+ErcC3dQcXoDnGK6eZwpnpPVg1IU0OrzRFuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=masU3CVliFA6CbjIjmTOOvcqq/8lVt3GxALrqVm3MC0QKCTXFQbi7d6maA7NiSNmd
	 kuKYVHA1ztsEPPg8y3ytWJQznJAqWOpvWYMSiNFlz/ACLOIJ8W1LZn1Msq3JNp8h9z
	 Xi8gXe0RNhpZbEZ4TYxKtofx2TT7hYLuwMVu5IJYn7NY5lK6FpNHnKYf5oO3uX+mw9
	 XhB1cXzVhiv45DB8dqKV9ggX2obw7u1Dw0mAQhdtEuyVInVy9EMYtuTNsepH9IYhJv
	 b6shnqQF+0oP4CCEM8/jhzYsYnfzOd8Ygu2PbMl1sTTC/AW8Gdea1hpTE2JVLvKdbK
	 6H8A+NxodCYcg==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Cc: Hyunwoo Kim"
 <imv4bel@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>, John Stultz <jstultz@google.com>, Ingo Molnar
 <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, "Eric W.
 Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
In-Reply-To: <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain> <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home> <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
Date: Wed, 09 Sep 2026 11:08:31 +0200
Message-ID: <87ecf223n4.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 09 2026 at 10:04, Peter Zijlstra wrote:
> On Tue, Sep 08, 2026 at 12:15:21PM +0200, Frederic Weisbecker wrote:
> Let me try and have a go :-)
>
>
> do_exit()				de_thread() 			posix_timer_fn()
>   exit_signal()				  LOCK siglock 			  posix_timer_send_sigqueue()
>     LOCK siglock			  UNLOCK siglock 		    t = posix_timer_get_target()
>     tsk->flags |= PF_EXITING; 						    LOCK siglock
>     UNLOCK siglock			  if (!thread_group_leader) 	      if (!list_empty(sigqueue))
>     					    LOCK tasklist_lock
>     flush_sigqueue_list();		    if (leader->exit_state)
> 					      break;
>   ...                                       transfer_pid()
> 					    UNLOCK tasklist_lock
>   exit_notify()
>     LOCK tasklist_lock
>     tsk->exit_state = EXIT_ZOMBIE;
>     UNLOCK tasklist_lock
>
>
>
> Then there is indeed nothing that makes sure posix_timer_fn() sees
> sigqueue updates done by do_exit(), because those are ordered by
> tasklist_lock, but posix_timer_fn() doesn't care about that.

That's irrelevant because in the above scenario posix_timer_fn() 't'
points to the exiting old leader (on the left) because the PID store has
not happened yet and it therefore observes PF_EXITING on it so it won't
touch the sigqueue. Note, that setting and checking PF_EXITING is
serialized by sighand lock, so this is fine.

 do_exit()
   exit_signals()
     LOCK siglock
     tsk->flags |= PF_EXITING
     UNLOCK siglock

So after this point anything which looks at tsk->flags under siglock
will observe PF_EXITING and not touch the sigqueue. Nothing to see here.

> The easy solution would probably be to do transfer_pid() while holding
> siglock?

That'd be only relevant for the situation Frederic is concerned about,
i.e. the case where the third party observes the TID swap.

Because with that visible 't' in posix_timer_send_sigqueue() won't be
old_leader, which has PF_EXITING set, it will be new_leader which has it
not set.

So Frederic is concerned that posix_timer_send_sigqueue() can observe
the PID store but not observe the sigqueue stores.

I argue that's not possible:

A:  sigqueue stores

B:   AQUIRE tasklist

C:   exit_state store

D:   RELEASE tasklist
     // sigqueue and exit_state stores become globally visible
 ------------------------------------------------------------------------

E                               ACQUIRE tasklist
 ------------------------------------------------------------------------
F                                if (exit_state)
				   swap_pid()
G                                     STORE_PID

				// The PID store can become visible in the
				// system right here so F can observe them before
				// RELEASE tasklist

H                                                             READ PID
							      ....
I                                		              ACQUIRE siglock

After #A the sigqueue stores are maybe visible

After #C the exit_state store is maybe visible

After #D both #A and #C are guaranteed to be visible to _ALL_ agents in
the system and cannot become magically become invisible after that
point.

The new leader cannot swap PIDs before acquiring task list lock and
before it observed exit_state != 0 under it. That's fully serialized
against the old leader as both hold task list lock for their operations.

#F creates a control dependency, so if the new leader acquires task list
   lock before the old it will observe 0, drop the lock and wait. No PID
   store obviously.

#G can be come visible immediately but is only guaranteed to be visible
   globally at the RELEASE of tasklist lock.

#H can only observe the PID store after the store actually happened in
   #G. So it either reads the original PID or the swapped PID.

#I is not really relevant for this. It's only relevant for PF_EXITING
   and other stuff which is directly protected by it. And it does not
   matter whether it locks the old or the new sighand.

Now let's look at the full chain and what can possibly be visible or not
and when:

#A can trickle into the tasklist held section, but not after #D.

#C cannot be reordered against #B and #D

#A is therefore guaranteed to be globally visible _before_ new leader
   observes exit_state != 0 in #F under task list lock

#G cannot be reordered against #F and obviously not against #E either.

   It can become visible at any point after the store, but as argued
   above that visibility can't be reordered before #A (sigqueue stores)
   became visible.

The important part is that the visibility of #A (sigqueue stores) and #G
(PID store) is fully ordered through task list lock.

So #H _cannot_ observe #G without observing #A - not even on PowerPC or
similar insanities.

No?

Also doing the PID swap under sighand lock is not solving anything
either because posix_timer_send_sigqueue() does the lookup without the
lock simply because it does not know which task it is upfront. So it
would have to redo and validate the lookup with the lock held.

Thanks,

        tglx
