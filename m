Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A033BBD7;
	Mon,  7 Sep 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794769; cv=none; b=ebBRzPQrkLG45lu49E9bJUT9704NmI9JqBBJ1+yQBx1jTL37cox2Y9e3WaruIwq3tsR7Q/7kLpm9WuPBWam5rH4fk+n5yK3BZ63pSCHHKbUT13ogBYlAt+LEoDZtpl1yQ3lZCnpaBCE8Y47IsQj9xvY8ROqr2q7Cc+FSTywN7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794769; c=relaxed/simple;
	bh=hiX52D534OCuj8NUvhf5eISq5SeH5ZBZgQez8Kmzw5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwxZgeXQYD+8tymnGB20tysKXuCHR4uhJmd6WaWZFRwnWifounHNmWibpntyFIQuIbZVSg2I3Xaj4rk5051NgWDu4fxK+yje4rvlgh4l4XWU8dtIqQJksY1DbTx91NKog4vQtyI4vbh0LLajxJT4FKNbicMJowtnuZ9MxxB489w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWr1QrCC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWr1QrCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3B51F00A3A;
	Mon,  7 Sep 2026 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788794767;
	bh=6KHxMEEDGfdd+dJVwnVvsl03TAcBECKrJo0zP0n9v+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HWr1QrCC7R2HThxfe0Hy6iIf6huziNJNqMQ08CNYGjRXYU0ukS5d9BbLPcIoRb2iZ
	 Ny60OWKxn5Cv0x01wz1+tDZZmgHtPQqqWIUq/8XkG8NEGimgkZDQAewQhUKpxLya8d
	 iU0oR50mBalG2pNEoweY41tVn0ilo7pSQoDaxSOtTYfKkR44w+zNfWB/wPn5ByJhPl
	 Oc0eTku2VQXCZioO+IWjbOvTqk8nUH72rUpvv3L9bpZFGMriq6RzbbKpzB0AFAp0wq
	 duCbgfLsAlogsGTWG3y1wJiOZEq0jXtLDQRR7GFJA/yUyjNhdRaGiVQ8YaFDdi8n4j
	 XEWJ/SArYFLMg==
From: Thomas Gleixner <tglx@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Cc: Hyunwoo Kim"
 <imv4bel@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz
 <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>,
 stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
In-Reply-To: <ap6urw5aAxrKO3Ck@localhost.localdomain>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
Date: Mon, 07 Sep 2026 17:26:04 +0200
Message-ID: <87ik4h2icz.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07 2026 at 14:31, Frederic Weisbecker wrote:
> Le Sat, Sep 05, 2026 at 08:59:01PM +0200, Thomas Gleixner a =C3=A9crit :
>> -out:
>> -	spin_unlock_irq(&tsk->sighand->siglock);
>> +	flush_sigqueue_list(&sigq_list);
>
> It probably doesn't matter in practice, I don't know feel free to ignore,
> but FWIW it looks like it's still vulnerable to the theoretical far fetch=
ed
> race I described. The head is moved under the lock but individual nodes a=
re
> deleted without the lock.
>
> CPU 0                                CPU 1                   CPU 2
> -----                                -----                   -----
>
> exit_signals()
>    spin_lock(sighand)
>    tsk->flags |=3D PF_EXITING;
>    list_splice_init(&queue->list, head);
>    spin_unlock(sighand)
>
>    list_for_each_safe(head, node)
>       list_del_init(node)
>          node->next =3D node // A
>          node->prev =3D node // B
> ...
>                                      de_thread()
>                                         // acquired tsk->flags
>                                         // and signal flushed
>                                         // through tasklist_lock
>                                         transfer_pid() // C
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
>                                                            posix_timer_fn=
()
>                                                               posixtimer_=
send_sigqueue()
>                                                                  // OBSER=
VES C
>                                                                  t =3D po=
sixtimer_get_target(tmr)
>                                                                  lock_tas=
k_sighand()
>                                                                     // OB=
SERVES A
>                                                                     if (!=
list_empty(q))
>                                                                        //=
 BUT NOT B
>                                                                        li=
st_add_tail(q) // D
>
> Then who knows which write wins, B or D?

For a moment you almost convinced me, but that's not possible:

    de_thread()
        ....

	if (!thread_leader()) {
            wait_until(old_leader->exit_state);

            transfer_pid();

old_leader sets the exit_state in exit_notify():

    do_exit()
      exit_signals()
        lock(sighand)
          old_leader->flags |=3D PF_EXITING;
          head =3D remove_signals()
        unlock(sighand)
        flush_list(head)
     ...
     exit_notify()
       old_leader->exit_state =3D EXIT_XXX;

From a program order POV the flush is completed _before_ the new leader
can observe old_leader->exit_state and swap TIDS. exit_notify() and the
wait in de_thread() are serialized via tasklist_lock.

The signal is either dropped before transfer_pid() is observable due to
PF_EXITING on the old leader or queued on the new leader and then
discarded in posixtimer_exit() -> flush_itimer_signals().

The only valid question is whether it is guaranteed that on a weakly
ordered system the stores in flush_sigqueue_list() are visible _before_
transfer_pid() is visible to the third party.

It's not obvious of course and might deserve a comment.

      exit_signals()
        lock(sighand)
          old_leader->flags |=3D PF_EXITING;
          head =3D remove_signals()
#1      // RELEASE: PF_EXITING must become visible
        unlock(sighand)
        flush_list(head)

     ...
     posixtimer_exit()
       posix_cpu_timers_exit_task()
        lock(sighand)
        ...
#2      // RELEASE: The stores in flush_list() must become visible
        //          They might be already in case of preemption
        //	    or due a RELEASE operation in seccomp_filter_release()
        unlock(sighand)

    ...
    exit_notify()
      lock(task_list_lock)
      exit_state =3D EXIT_ZOMBIE;
#3    // RELEASE: exit_state must become visible
      unlock(task_list_lock)

So the new leader cannot proceed before #3 which means it can't swap
TIDs before that point. That requires task_list_lock so there is no way
that the TID swap can trickle before the lock is held and exit_state
being non-zero.

Though the important part is that the third party on CPU3 has to acquire
sighand lock in posixtimer_send_sigqueue(), which is an ACQUIRE
operation. That means _all_ accesses to tsk::flags and to the sigqueue
must happen _after_ the lock is acquired.

If it acquires it after #1 and before the TID swap it must observe
PF_EXITING and return immediately. So a concurrent modification of
timer::sigqueue in flush_list() or not-yet visible stores are
irrelevant.

If it acquires it after #2 it must observe the full writes to the
sigqueue. So after that point it does not longer matter whether the PID
resolves to T1 or T2.

No?

Thanks,

        tglx
