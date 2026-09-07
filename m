Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA12478E5E;
	Mon,  7 Sep 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780416; cv=none; b=YYuAUXP0sjmW/D9pqP24IssYvbFytT2xkGcxQMYb4dS8X5lyRj4kA6Yz5histIWPc3OFwXVqhfqm8kuCz7q/mYmcxXN1/xAEb0/cF349FiWpT1nRwR+lgJUgM+YenpV3lD+o3WuZMn2xn+mL5zXBKBy7e+gct9byzDA62tQhDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780416; c=relaxed/simple;
	bh=b1/7jF3rM6chow1Mf0/Vho4WgWNjKULtTHiZPFcjS1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/q7IjMYck/9XLHmvp2xYQ4qLjObJqYUwGqoK83uIZKiuCGrcxkqKXO+XG+65Lw6kIho/XtZKc3n08+iZAxl/yeNAiP+w61wSr9CimaEKhoq3Ai2xoOsNL1QP3A8ypKCiHJmvqhNdbG/Vi0NCWe34X+kfjpKazf9joX04Wvl1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMPrakXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMPrakXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8161F01558;
	Mon,  7 Sep 2026 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788780414;
	bh=tXd8LGopt741aXLt2J4qsw6qnF0oEX86K+sORJnTN9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oMPrakXa7lFBtJPd8E6U6u+WkG2T8Rjv+t1YdPBXrhvAHqm9AESM8/3sLqosXgFM2
	 2vktZpKBT7fqybEdH9lOgQTti8+A1tdlfBtsnozKvP37MWpj7UffJmFjWh3a7u0kna
	 WoaBvkD57o11RnOw/soSwsapEdSRchDy0PyiOYN5ewO4uj78dcuzPRPOrYOQYSEEMV
	 t7nnHFeuBw/r6JH64OQed7+NOoVxzT/MnBifmWYrvwCrRvmLfAgBxtlUR2OEsZk1AN
	 SUwzrIvLQFMOrlY1xtNQTf7YbEBYkmqh9Aojz2sHA45ly5x64Zb+TsL+/5gz/sWXHN
	 IZOfluBBvxHaQ==
From: Thomas Gleixner <tglx@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Cc: Hyunwoo Kim"
 <imv4bel@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Frederic
 Weisbecker <frederic@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>,
 Ingo Molnar <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
In-Reply-To: <8733vmatsi.fsf@email.froward.int.ebiederm.org>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <8733vmatsi.fsf@email.froward.int.ebiederm.org>
Date: Mon, 07 Sep 2026 13:26:50 +0200
Message-ID: <87zext2tfp.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Sep 06 2026 at 17:39, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@kernel.org> writes:
>> @@ -1019,6 +1029,21 @@ static inline bool legacy_queue(struct s
>>  	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
>>  }
>>  
>> +/*
>> + * When PF_EXITING is set the task is on the way out and has t::pending
>> + * flushed already. Prevent queueing of PIDTYPE_PID signals as they would
>> + * be leaked.
>> + */
>> +static inline bool task_can_queue_signal(struct task_struct *t, enum pid_type type)
>> +{
>> +	lockdep_assert_held(&t->sighand->siglock);
>> +
>> +	if (!(t->flags & PF_EXITING))
>> +		return true;
>> +
>
> I don't know if we care but I just noticed that this disallows
> using tkill(..., SIGKILL) or tgkill(..., SIGKILL) to stop coredumps.

The thread running the coredump does not have PF_EXITING set:

get_signal()
        ....
        vfs_coredump()
        ...
        do_group_exit()

The only interaction with coredumps of a task which reached do_exit() is
via:

        synchronize_group_exit()
           coredump_task_exit()
        ...
        exit_signals() ; // sets PF_EXITING.

coredump_task_exit() waits until the dumper thread finished, so even if
tkill() is directed at a non-dumper thread which is stuck there in
coredump_task_exit() the signal will be queued and complete_signal()
will set signal->flags = SIGNAL_GROUP_EXIT and wake everyone up
including the dumper thread.

So the only case where this matters is when a task sets PF_EXITING
_before_ the dumper starts:

T1			T2
                        do_exit()
vfs_coredump()
                          synchronize_group_exit()
                            lock(sighand)
                            tsk->flags |= PF_POSTCOREDUMP;
                            core_state = signal->core_state;
                            unlock(sighand);
                            // core_state == NULL

		          exit_signals() // Sets PF_EXITING
  zap_threads()
    lock(sighand)
    // Observes T2->flags PF_POSTCOREDUMP
    // and skips T2

Now in current mainline a tkill(T2, SIGKILL) will queue the SIGKILL in
T2->pending, but complete_signal() will not turn it into a group exit
either because it is a PIDTYPE_PID signal when PF_EXITING is set:

complete_signal()
  // wants_signal() returns false because PF_EXITING is set
  if (wants_signal(sig, p)) 
      t = p;
  else if ((type == PIDTYPE_PID) || thread_group_empty(p))
      return;  // path taken because type == PIDTYPE_PID

So it is queued for nothing and just sitting in T2->pending until
flush_sigqueue() mops it up.

That has been so since:

  5fcd835bf8c2 ("signals: use __group_complete_signal() for the specific signals too")

which was merged 18 years ago in the 2.6.26 merge window.

Which means not queueing it in the first place has exactly the same
outcome vs. SIGKILL.

The only difference is that current mainline still reaches
signalfd_notify() further down in __send_signal_locked(), while with the
early exit it will not. Does it actually matter?

If it matters we could simply force PIDTYPE_TGID for SIGKILL if type ==
PIDTYPE_PID because complete_signal() converts SIGKILL into a group exit
anyway.

Thanks,

        tglx
