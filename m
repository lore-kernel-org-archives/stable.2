Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E50A3DEAD6;
	Wed, 24 Jun 2026 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331551; cv=none; b=mPdRj3gCfTKGW6KVLP0bovGFMt2Ij7AbWprIZTtF6T68gnMqQFjaQFxXroUD0/lKOBR4tOc9i8fUItZYRtBDgE/KmhH0Q3c6SD1yjF6speDyeCn7zSpuarOMhkwRI6tK67okl9FGkm+dhyUCHZhEOj8XpeMwKBKAEC7hqPfEGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331551; c=relaxed/simple;
	bh=mDXvhgvMBbtebrMTxKeU5TzK5uAp/GbyBv6TSR52dFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYFQNtmtLOkDPVamE9HcE7WU2j3RIf5Mal4tUeRAX6soGkhrkgd5soIVmryJjukZlGxGfczqTXLrgPY22cA7+jFjjV1AiCOhVymdyOTCm0jlgdFhL7hccr/l5NE8FISNEvufT1Sm+KsGnZo4mfWHwoSwYdHSh/vCHED4KfHiW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=glPFbAgi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="glPFbAgi"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 69DAF20B7166;
	Wed, 24 Jun 2026 13:05:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69DAF20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782331538;
	bh=uTPAhFcCNxcdpvID6odN7opmF9CXa7AS0OJLkqi0GiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glPFbAgiEdbig2XHfW2Q1dlGXuTvo9Q0Iv0r0OVgBqgR1cvzz3sr7e1YF+/QS5LCE
	 j2r4k9qbcsQSUlBmbt/5ABEi/Ejk4AUZ9yqxwWmuuPlKc5kvZvYvS80kMQIcpU12qC
	 rFoQs0Xw3oIKe6auO6rv+0R5ofeEl38rFiRjIYP4=
Date: Wed, 24 Jun 2026 20:05:35 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: XIAO WU <xiaowu.417@qq.com>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in
 user_event_mm_dup()
Message-ID: <20260624200535.GA132-beaub@linux.microsoft.com>
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
 <tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com>

On Tue, Jun 23, 2026 at 01:03:59AM +0800, XIAO WU wrote:
> Hi,
> 

Hey XIAO WU,

> I came across the Sashiko AI review [1] in this thread and wanted to
> share some test results that may be useful.
> 

Thanks!

> First — thank you for this patch!  The enabler UAF in
> user_event_mm_dup() is a real bug and the fix (kfree → kfree_rcu) is
> the right approach for protecting the RCU list walkers.  The selftest
> results you included in the commit are also really helpful.
> 
> However, I was able to reproduce a second UAF on the *user_event*
> object that the Sashiko review flagged — it's still reachable after the
> patch is applied.  I've included a PoC and crash log below.
> 
> On Thu, Jun 18, 2026 at 06:27:43PM -0400, Michael Bommarito wrote:
> > @@ -404,7 +407,12 @@ static void user_event_enabler_destroy(struct
> user_event_enabler *enabler,
> >      /* No longer tracking the event via the enabler */
> >      user_event_put(enabler->event, locked);
> >
> > -    kfree(enabler);
> > +    /*
> > +     * The enabler is removed from an RCU-traversed list
> > +     * (user_event_mm_dup walks mm->enablers under rcu_read_lock only),
> > +     * so the backing memory must outlive a grace period.
> > +     */
> > +    kfree_rcu(enabler, rcu);
> >  }
> 
> The issue: user_event_put(enabler->event, locked) is called
> synchronously, before kfree_rcu(enabler, rcu).  If this drops the last
> reference to the user_event, delayed_destroy_user_event() is scheduled
> on a workqueue, which calls destroy_user_event() → kfree(user).  The
> user_event memory is freed without RCU protection.
> 
> But the enabler itself is now protected by kfree_rcu — it remains
> visible to RCU readers in user_event_mm_dup() during fork().  Those
> readers access enabler->event (via user_event_enabler_dup →
> user_event_get(orig->event)), which now points to freed memory:
> 
>   fork()                                       unregister
>   ────────                                     ──────────
>   user_event_mm_dup()
>     rcu_read_lock();
>     list_for_each_entry_rcu(enabler, ...)
>  user_event_enabler_destroy()
>  list_del_rcu(enabler)
>  user_event_put(enabler->event)
>                                                    → last ref!
>                                                    → schedule_work(put_work)
>                                                  kfree_rcu(enabler, rcu)
>       user_event_enabler_dup(enabler, ...)     [workqueue]
>         enabler->event =  delayed_destroy_user_event()
>           user_event_get(orig->event);  destroy_user_event()
>           ↑ UAF: orig->event was freed! kfree(user_event)
> 

While I cannot repro this locally on my 16 core machine, I do agree this
case needs to be handled correctly. The enabler should keep the ref to
the user_event until after an RCU grace period. I have this fix that
addresses it more completely than the original proposal.

I'm hoping you can try out this fix with your machine that does repro
the timing window. The below change needs self test fixes, since now the
free happens after an RCU grace period + work queue schedule. This is
because the self tests (abi_test and perf_test) assume after unreg the
last ref is immediate (which was never guaranteed).

Thanks,
-Beau

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c4ba484f7b38..b860d8b70c7b 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -109,6 +109,9 @@ struct user_event_enabler {

        /* Track enable bit, flags, etc. Aligned for bitops. */
        unsigned long           values;
+
+       /* Defer put so RCU list readers (user_event_mm_dup) are safe. */
+       struct rcu_work         put_rwork;
 };

 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -396,17 +399,38 @@ static struct user_event_group *user_event_group_create(void)
        return NULL;
 };

-static void user_event_enabler_destroy(struct user_event_enabler *enabler,
-                                      bool locked)
+static void delayed_user_event_enabler_put(struct work_struct *work)
 {
-       list_del_rcu(&enabler->mm_enablers_link);
+       struct user_event_enabler *enabler;
+
+       enabler = container_of(to_rcu_work(work), struct user_event_enabler, put_rwork);

        /* No longer tracking the event via the enabler */
-       user_event_put(enabler->event, locked);
+       user_event_put(enabler->event, false);

+       /* Run from queue_rcu_work(), no need for RCU */
        kfree(enabler);
 }

+static void user_event_enabler_destroy(struct user_event_enabler *enabler)
+{
+       list_del_rcu(&enabler->mm_enablers_link);
+
+       /*
+        * We need to hold onto the reference of the user_event for this enabler
+        * until an RCU grace period has elapsed. This ensures that we only ever
+        * put (which may free) the user_event after all CPUs have an updated
+        * enabler list. If during the RCU grace period more enablers are added,
+        * the user_event will be kept alive by new ref counts.
+        *
+        * If user_event_put() is called on the last reference, the event_mutex
+        * is taken. These cannot be taken in an RCU context, so we have to run
+        * this in a work queue only after an RCU grace period.
+        */
+       INIT_RCU_WORK(&enabler->put_rwork, delayed_user_event_enabler_put);
+       queue_rcu_work(system_percpu_wq, &enabler->put_rwork);
+}
+
 static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
                                  int attempt)
 {
@@ -464,7 +488,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)

        /* User asked for enabler to be removed during fault */
        if (test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))) {
-               user_event_enabler_destroy(enabler, true);
+               user_event_enabler_destroy(enabler);
                goto out;
        }

@@ -764,7 +788,7 @@ static void user_event_mm_destroy(struct user_event_mm *mm)
        struct user_event_enabler *enabler, *next;

        list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link)
-               user_event_enabler_destroy(enabler, false);
+               user_event_enabler_destroy(enabler);

        mmdrop(mm->mm);
        kfree(mm);
@@ -2645,7 +2669,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
                        flags |= enabler->values & ENABLE_VAL_COMPAT_MASK;

                        if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
-                               user_event_enabler_destroy(enabler, true);
+                               user_event_enabler_destroy(enabler);

                        /* Removed at least one */
                        ret = 0;
