Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153861;
	b=taWfrKnV8jgc/KtNQI5ucU37d6XzTUjAkZ/Mrxzr5VxrR3mhHv4uc+0YlI+ZvWlC6bdI
	 ukYOXbQFF+uN37Lhqq6mhp+XOZ9samZAqjRVD3Uvi+ae71cFptuReIxqpkKz/IN0E9XSH
	 wmbOmVtsg1IoY+Ay0JgwCV54AXFlbDLcG5+uFQ/XfFIimtTWxe8imqYmPC4gbod0bbIwN
	 xEk0fS4Jrfde+/CWbv1UDefWqPw67daqYnIZoKhK14DA+j0ZUp1IPUFjghnE7KW3V3lre
	 SuYF9u46jfynDwZ6frEHeFIOLCStuIHsMXrEfaIs+n9I/EAeBiei+A6xci+aF6i755w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153861;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+mDEeq6oysWkmqzraqvWJ9f5p5gwCRkaXSwyptqb8cg=;
	b=eE8etCGgKAv3hujiUmFJ4bElhF+wjBnB8DikVehoJ3jac5oiAey+UUbePt3mqVxqm6lr
	 qbk2pGvDUihmemYfq2YXDH4xgwwc7Qb4g9Z7//WU6esNXYi+vKdwuZEoL+gL4JV2sDbqD
	 8mOry6GXxnrkiUuRD4O/30Dew9Zcjy/aI4iXRNAPtWCQlCYh7vX3XNdRX5jqzMwuj9KXb
	 RjgTVim6gTb4+VbVVc8x6FRWkWBSfdq5ejInkA0iiLE65J620XgS87NIitBQnepPGLlbi
	 gM76f5YykEHAZUkqpAstqOvPDUNKYk61J3v+YYoQ9ptAYloWO3D1S8Fvw5XBRRAacmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=VQ84bRYD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABE606A31E;
	Wed, 28 Oct 2026 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=VQ84bRYD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732041F01825;
	Wed, 28 Oct 2026 02:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793153860;
	bh=+mDEeq6oysWkmqzraqvWJ9f5p5gwCRkaXSwyptqb8cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VQ84bRYDkqWVf4bJMHQvdoPX+vPniQR0i6dQDy/rgCQAHzXUXooZ4tBECqwLDJ9eB
	 6hzb6c+KVNVXFkC+LDj/U17Uqirwfww1eNj5XhFarE1Czdug0UHAXHliZGcFRybsej
	 B0paq9LLVOobRYl1oZB1NU/YBsya2DvKSrBt7SBI=
Date: Tue, 27 Oct 2026 19:17:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Kairui
 Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook
 <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jann Horn
 <jannh@google.com>, Hugh Dickins <hughd@google.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, Rik van Riel
 <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Alistair Popple
 <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Oscar Salvador
 <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, Chengming Zhou
 <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Youngjun Park
 <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik
 <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 07/46] mm/filemap: don't lose a folio lock wakeup to a
 signal
Message-Id: <20261027191737.c757411fbe53f98b1596eebd@linux-foundation.org>
In-Reply-To: <11b91d57-85e6-47d0-87ab-5fa8624e8068@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
	<20261027-fixes_core-v1-7-6f74bec9a5bb@kernel.org>
	<auDM5mvsb5ilIdsg@pedro-suse.lan>
	<11b91d57-85e6-47d0-87ab-5fa8624e8068@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 20:18:18 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 10/27/26 17:10, Pedro Falcato wrote:
> > On Tue, Oct 27, 2026 at 12:17:27AM +0100, David Hildenbrand (Arm) wrote:
> >> From: Josef Bacik <josef@toxicpanda.com>
> >>
> >> An exclusive waiter in folio_wait_bit_common() can leave the wait loop
> >> because of a fatal signal, then be woken by folio_unlock() before
> >> finish_wait(). If the waker did not hand over the lock, the waiter returns
> >> -EINTR without trying to acquire it.
> >>
> >> folio_wake_bit() stops after waking the first exclusive waiter, so this
> >> loses the wakeup and can leave other waiters asleep indefinitely on an
> >> unlocked folio.
> >>
> >> After finish_wait(), let a waiter woken without a lock handoff try once
> >> more to acquire the lock. If successful, return success so the caller's
> >> eventual unlock wakes the next waiter. Otherwise, the current lock owner
> >> will do so.
> > 
> > Has this been reproduced? I feel like this would've been found out by now?
> 
> Let me dig ... I don't find mention in the notes, but I was told that most of
> these things have reproducers.
> 
> I guess it's harder to hit in practice, because you need a fatal signal and then
> keep the other waiter alive while nobody else will take that lock in a timely
> fashion.
> 
> I asked codex to try writing one but it refuses for security reasons :)

Yeah, I keep hitting that.  Sometimes it can be worked around by asking
the same thing in a different way.

Anyway, how's this:

I tested this fix with a small, purpose-built kernel module in an
x86-64 QEMU/KVM guest.  It reproduces the lost wakeup on the unpatched
kernel and passes with the patch applied.

The module allocates and locks a folio, then queues two exclusive
waiters.  The first uses __folio_lock_killable(); the second uses
folio_lock().  It sends SIGKILL to the first waiter and uses an x86-64
kprobe on finish_wait() to hold that waiter after it leaves the wait
loop.  The coordinator then unlocks the folio, waking the first waiter
without handing over the lock.  Without the fix, the first waiter
returns -EINTR and the second remains asleep on an unlocked folio. 
With the fix, the first waiter acquires the folio lock, unlocks it and
wakes the second waiter.

This is a module rather than a userspace program because it needs
access to the folio lock, the internal exclusive wait queue, and a
kprobe at finish_wait() to force the specific race.  A userspace
program cannot directly observe or synchronize these kernel states.

Results:

Unpatched: 7.3.0-rc5-g6ead605f7c7a-dirty
  first=-4, first_done=1, second_done=0, locked=0
  REPRODUCED: second waiter asleep on unlocked folio

Patched:   7.3.0-rc5-g73cfeb4a61fc-dirty
  first=0, first_done=1, second_done=1, locked=0
  PASS: first waiter took lock; second waiter progressed

Both runs recorded flags=0x1->0x3 and probe_timeout=0, confirming that
the first waiter was woken without WQ_FLAG_DONE and that the
instrumented synchronization did not time out.

I've attached the module source and Makefile.


// SPDX-License-Identifier: GPL-2.0
/*
 * Deterministic-ish, VM-only regression test for the missing exclusive
 * folio lock wakeup when a killable waiter is interrupted by SIGKILL.
 *
 * Requires x86-64, CONFIG_KPROBES, CONFIG_MODULES and at least 2 vCPUs.
 * Never use on a production machine. No mm/filemap.c modifications.
 */
#include <linux/completion.h>
#include <linux/cpumask.h>
#include <linux/delay.h>
#include <linux/errno.h>
#include <linux/gfp.h>
#include <linux/init.h>
#include <linux/jiffies.h>
#include <linux/kprobes.h>
#include <linux/kthread.h>
#include <linux/mm.h>
#include <linux/module.h>
#include <linux/pagemap.h>
#include <linux/sched.h>
#include <linux/sched/signal.h>
#include <linux/signal.h>
#include <linux/smp.h>
#include <linux/wait.h>

#define PREFIX "folio-wakeup-repro: "
#define STATE_WAIT_MS 3000
#define PROBE_HOLD_MS 500
#define RESULT_WAIT_MS 300

#if !defined(CONFIG_X86_64)
#error "This test's kprobe register access requires x86-64"
#endif

static struct folio *test_folio;
static struct task_struct *first_task, *second_task;
static DECLARE_COMPLETION(first_done);
static DECLARE_COMPLETION(second_done);
static atomic_t probe_hit = ATOMIC_INIT(0);
static atomic_t release_probe = ATOMIC_INIT(0);
static atomic_t probe_expired = ATOMIC_INIT(0);
static unsigned int flags_before, flags_after;
static int first_ret = -999;
static bool initial_lock_held;
static bool second_got_lock;

static int finish_wait_probe(struct kprobe *kp, struct pt_regs *regs)
{
	struct wait_queue_entry *wait;
	unsigned long deadline;

	(void)kp;
	if (current != READ_ONCE(first_task))
		return 0;

	/* SysV x86-64: finish_wait(q, wait), wait is argument #2. */
	wait = (struct wait_queue_entry *)regs->si;
	WRITE_ONCE(flags_before, READ_ONCE(wait->flags));
	atomic_set(&probe_hit, 1);

	/* kprobe handlers cannot sleep. Pin this waiter to another CPU. */
	deadline = jiffies + msecs_to_jiffies(PROBE_HOLD_MS);
	while (!atomic_read(&release_probe)) {
		if (time_after_eq(jiffies, deadline)) {
			atomic_set(&probe_expired, 1);
			break;
		}
		cpu_relax();
	}
	WRITE_ONCE(flags_after, READ_ONCE(wait->flags));
	return 0;
}

static struct kprobe finish_probe = {
	.symbol_name = "finish_wait",
	.pre_handler = finish_wait_probe,
};

static int first_fn(void *arg)
{
	int ret;

	(void)arg;
	allow_signal(SIGKILL);
	ret = __folio_lock_killable(test_folio);
	WRITE_ONCE(first_ret, ret);
	if (!ret)
		folio_unlock(test_folio);
	complete(&first_done);
	return 0;
}

static int second_fn(void *arg)
{
	(void)arg;
	folio_lock(test_folio);
	WRITE_ONCE(second_got_lock, true);
	folio_unlock(test_folio);
	complete(&second_done);
	return 0;
}

static bool wait_for_state(struct task_struct *t, unsigned int state)
{
	unsigned long deadline = jiffies + msecs_to_jiffies(STATE_WAIT_MS);

	while (time_before(jiffies, deadline)) {
		if (READ_ONCE(t->__state) == state)
			return true;
		msleep(1);
	}
	return false;
}

static bool wait_for_probe(void)
{
	unsigned long deadline = jiffies + msecs_to_jiffies(STATE_WAIT_MS);

	while (time_before(jiffies, deadline)) {
		if (atomic_read(&probe_hit))
			return true;
		msleep(1);
	}
	return false;
}

/*
 * Never unload while a worker remains asleep. If the original wakeup was
 * lost, temporarily lock and unlock the now-unlocked folio to wake it.
 */
static bool drain_workers(void)
{
	int i;

	atomic_set(&release_probe, 1);
	if (initial_lock_held) {
		initial_lock_held = false;
		folio_unlock(test_folio);
	}
	for (i = 0; i < 100; ++i) {
		if ((!first_task || completion_done(&first_done)) &&
		    (!second_task || completion_done(&second_done)))
			return true;
		if (folio_trylock(test_folio))
			folio_unlock(test_folio);
		msleep(10);
	}
	pr_err(PREFIX "cleanup failed: a worker is still blocked; "
	       "module must remain loaded\n");
	return false;
}

static int __init wakeup_test_init(void)
{
	int ret;
	bool a_done, b_done, lost;
	int cpu, coord_cpu;
	cpumask_var_t original_affinity;
	bool affinity_changed = false;

	pr_info(PREFIX "start\n");

	if (num_online_cpus() < 2 ||
	    cpumask_weight(current->cpus_ptr) < 2) {
		pr_err(PREFIX "need two available online CPUs\n");
		return -EINVAL;
	}
	if (!alloc_cpumask_var(&original_affinity, GFP_KERNEL))
		return -ENOMEM;
	cpumask_copy(original_affinity, current->cpus_ptr);
	coord_cpu = cpumask_first(original_affinity);
	cpu = cpumask_next(coord_cpu, original_affinity);
	if (cpu >= nr_cpu_ids || !cpu_online(coord_cpu) ||
	    !cpu_online(cpu)) {
		free_cpumask_var(original_affinity);
		return -EINVAL;
	}
	ret = set_cpus_allowed_ptr(current, cpumask_of(coord_cpu));
	if (ret) {
		free_cpumask_var(original_affinity);
		return ret;
	}
	affinity_changed = true;

	test_folio = folio_alloc(GFP_KERNEL, 0);
	if (!test_folio) {
		set_cpus_allowed_ptr(current, original_affinity);
		free_cpumask_var(original_affinity);
		return -ENOMEM;
	}
	folio_lock(test_folio);
	initial_lock_held = true;

	ret = register_kprobe(&finish_probe);
	if (ret) {
		pr_err(PREFIX "register_kprobe(finish_wait): %d\n", ret);
		goto out_no_probe;
	}

	first_task = kthread_create(first_fn, NULL, "folio-wait-a");
	if (IS_ERR(first_task)) {
		ret = PTR_ERR(first_task);
		first_task = NULL;
		goto out_probe;
	}
	kthread_bind(first_task, cpu);
	wake_up_process(first_task);

	if (!wait_for_state(first_task, TASK_KILLABLE)) {
		pr_err(PREFIX "first task did not block killably\n");
		goto inconclusive;
	}

	second_task = kthread_run(second_fn, NULL, "folio-wait-b");
	if (IS_ERR(second_task)) {
		ret = PTR_ERR(second_task);
		second_task = NULL;
		pr_err(PREFIX "second thread creation: %d\n", ret);
		goto inconclusive;
	}
	if (!wait_for_state(second_task, TASK_UNINTERRUPTIBLE)) {
		pr_err(PREFIX "second task did not block\n");
		goto inconclusive;
	}

	/* A is the first exclusive waiter; B is behind it. */
	ret = send_sig(SIGKILL, first_task, 1);
	if (ret) {
		pr_err(PREFIX "send_sig: %d\n", ret);
		goto inconclusive;
	}
	if (!wait_for_probe()) {
		pr_err(PREFIX "did not reach finish_wait probe\n");
		goto inconclusive;
	}
	if (!(READ_ONCE(flags_before) & WQ_FLAG_EXCLUSIVE) ||
	    (READ_ONCE(flags_before) &
	     (WQ_FLAG_WOKEN | WQ_FLAG_DONE | WQ_FLAG_CUSTOM))) {
		pr_warn(PREFIX "wrong initial wait flags: %#x\n",
			READ_ONCE(flags_before));
		goto inconclusive;
	}

	/* A is halted just before finish_wait. Unlock wakes A, not B. */
	folio_unlock(test_folio);
	initial_lock_held = false;
	atomic_set(&release_probe, 1);

	a_done = wait_for_completion_timeout(&first_done,
		msecs_to_jiffies(RESULT_WAIT_MS));
	b_done = wait_for_completion_timeout(&second_done,
		msecs_to_jiffies(RESULT_WAIT_MS));
	lost = a_done && !b_done && READ_ONCE(first_ret) == -EINTR &&
	       !folio_test_locked(test_folio);

	pr_info(PREFIX "first=%d first_done=%d second_done=%d "
		"flags=%#x->%#x probe_timeout=%d locked=%d\n",
		READ_ONCE(first_ret), a_done, b_done,
		READ_ONCE(flags_before), READ_ONCE(flags_after),
		atomic_read(&probe_expired), folio_test_locked(test_folio));
	if (atomic_read(&probe_expired) ||
	    !(READ_ONCE(flags_after) & WQ_FLAG_WOKEN))
		pr_warn(PREFIX "INCONCLUSIVE: wakeup not synchronized\n");
	else if (lost)
		pr_err(PREFIX "REPRODUCED: second waiter asleep "
		       "on unlocked folio\n");
	else if (a_done && b_done && READ_ONCE(first_ret) == 0 &&
		 READ_ONCE(second_got_lock))
		pr_info(PREFIX "PASS: first waiter took lock; "
			"second waiter progressed\n");
	else
		pr_warn(PREFIX "INCONCLUSIVE: unexpected completion state\n");
	goto out_probe;

inconclusive:
	pr_warn(PREFIX "INCONCLUSIVE: setup or timing failed\n");
out_probe:
	if (!drain_workers()) {
		/* Do not free module text or folio while workers run. */
		pr_emerg(PREFIX "unrecoverable blocked thread: "
			 "module pinned; reboot test VM\n");
		__module_get(THIS_MODULE);
		if (affinity_changed)
			set_cpus_allowed_ptr(current, original_affinity);
		free_cpumask_var(original_affinity);
		return 0;
	}
	if (first_task)
		kthread_stop(first_task);
	if (second_task)
		kthread_stop(second_task);
	unregister_kprobe(&finish_probe);
out_no_probe:
	if (initial_lock_held)
		folio_unlock(test_folio);
	folio_put(test_folio);
	test_folio = NULL;
	if (affinity_changed)
		set_cpus_allowed_ptr(current, original_affinity);
	free_cpumask_var(original_affinity);
	return ret < 0 && !first_task && !second_task ? ret : 0;
}

static void __exit wakeup_test_exit(void)
{
	if (test_folio)
		pr_emerg(PREFIX "threads still active, unsafe unload\n");
}

module_init(wakeup_test_init);
module_exit(wakeup_test_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("folio exclusive-waiter signal lost-wakeup reproducer");




obj-m += folio-wakeup-repro.o
KDIR ?= /lib/modules/$(shell uname -r)/build

.PHONY: all clean
all:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules
clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean


