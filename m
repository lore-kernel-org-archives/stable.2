Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035552ED36
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984976; cv=none; b=iCeqFgJkiVmBq/9afPilPawWyN7b2FLe4of1NNT3bdm83Xu8uGtE0S2JfZK21B+Zwm4arVmdqyBVAZeq/3Vo5w4EQgubFDatb0mRf1DaFGKXoeAPiOpsIBeeKoYtojmqMpttTzpvoRFGkgOcgJEqY0faa1sYXWoO4pnLq+jvm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984976; c=relaxed/simple;
	bh=xIIifumklH4zj100HVaElaSYBEGesFZBBWxI7QXKRZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b46D7CJ/ZwmqiRQzDvstSlDIVFWD/RDjqXUzTgt20tgFrpict+++WW5kPFVoRjjfZMAyOvwWJLEGr0BV1cR05j6DuwskumoDMnA6kP3eBQmtDch8vqmhg12/1my4mUp163bCF1F5VLXX7cKkxZutyILmvV0QbB6Vl9JNVA0MQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alIVt5Wt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alIVt5Wt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b0584ad71so2457570f8f.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791984960; x=1792589760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5MuCLL2jlVAprcL5g7QW+4vSu4dju3LdD1kRK2MLYA=;
        b=alIVt5Wt45442fBEdYGFZSgJuihJVrADDhmSN7dWfDjXQfXMmKRQ/S2/CH/3UjveTN
         E000ULuRm4BQJZUBiFihUW4kVLvViF6FEiU+3y4rE3jdpQynLbUP62q+yU8guMZajv1s
         Erv9+cw2KtGmCxU79yf3g+DCP8Z0d/rnLwMGJF01dGY9o8KUx5Ktp7RvMzO4HsGOIUg3
         bijRN7q+B3lZcinQQtwdthP/vmJwW2uxdz4v2LXSV0h4VGdQ98bGZR0NkNOWuZ/3tmmu
         0L+oSyH9ln5wSdqTwb/SdnLkDB4QvtiO1Anxr5TJUxZmULsD7hdYUNV9QdW2jfyuz6+S
         MPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984960; x=1792589760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5MuCLL2jlVAprcL5g7QW+4vSu4dju3LdD1kRK2MLYA=;
        b=T7LozgAGRsBsCTQkcbwflk5EaydXKbjN5VMuTrrA4BgQreqUXfF+YfXjfZWOxqLLgw
         7y8SeWG0GhdTdJCNJLu0j344gCqMpQrYNT04B5iBa53HlBDFKVdnmqiKfjOY6KskbLeR
         wg35az/CspjreFFqRyL/ypCJHb1RwBwwf1GIgUCE1nFG1e0efN7/TAqTCeagsBDRe7G7
         YPMELz0sKeoUJgs/Mo2ND05x1vmwpRZ7fusYhRz+fN8d0C6/UfR8qSDvKDJufuNulajP
         nA6LIMxPWrBqsaCNSRv6tBNQxcLzj18r7/O8oRE0tju5DtjZ3ca7Vv6rkoCnF86Jv5D9
         IP2A==
X-Forwarded-Encrypted: i=1; AKwUvBy0S64bMvR9ppr6pcNXJTpTItqOVNcT3r4VdoMxaYGHh2LuKlSuXbD2nNmVk05TcjDYXZa62nw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQq62ObVXjVoUN+9bS8RhdzDWRXxCD/3YaA0z6/e+UVBIGNBzR
	fGTRtBKOXnmfcA5DbA+mjQccaGY3+yYmWeiHEdfRpnK6mVNrnpgnkd/H
X-Gm-Gg: AYBFou04F3t8p0AQRWTdOIlbS/gMkR25ZTC8myXvMrJrgOSeYdPoQRtss+McaifmpLN
	3NwwXjwObpqo950ZEKxBRWCt0p+OaUG6WxV43o7YJdH+eMcTG5uT6zVUjOv2XC3z8J3Il6sn3B5
	3uj+3k1w7qBWfY/RvxywUSLNC0007Nwccep9yAjx4eOo8YeDQ/jhSQ8rldSWlsHTwEh3QVQTZTY
	uOgiMoLc8MFI8CYfDLx3yVlzvnGXNucwXmLZ5Vss/D7f/SvuNKfj0QnAiEZyL96ryKA4pGwjzN3
	imQu0JOpUn6GsQes18nyIdM1TrWshkVocm8WveImJKdLKxawt6aqTOpuCp1tP8pxL8kpLvB5N7+
	8iqIsnpQApWwE/OzrzTah1DKTXjgVp4xLR8aqLZrHOk7bMffb3xEu1vYQTcYyr/UasplcI9KKak
	drH8yroBG8YScB2TpD1UEz81giH+FOzbmm/gsrkloFZjYq5Y4Mg+BRqOEtDNy/eSe1dK3L4Lg09
	cdmEbtDQ0ZSF+th3yqhVrVMmzaFSR0uC8EwXGQy3oegxg==
X-Received: by 2002:a05:600c:674a:b0:49f:f0bd:1e40 with SMTP id 5b1f17b1804b1-4a18e4afe9cmr288780635e9.23.1791984959760;
        Wed, 14 Oct 2026 06:35:59 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd037883sm994885e9.4.2026.10.14.06.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:35:59 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	petr.pavlu@suse.com
Subject: Re: [PATCH] livepatch: Fix races between stack check and module load/unload
Date: Wed, 14 Oct 2026 15:35:51 +0200
Message-ID: <20261014133553.102324-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alpine.LSU.2.21.2610141410370.16733@pobox.suse.cz>
References: <20261012140546.154730-1-parri.andrea@gmail.com> <alpine.LSU.2.21.2610141410370.16733@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Miroslav,

On Wed, Oct 14, 2026 at 02:23:50PM +0200, Miroslav Benes wrote:
> Interesting. So to sum it up... you load a live patch which contains a fix
> for a module and while the transition is on, you remove the module and it
> crashes

Yes.  Loading such a module during the transition races too:
klp_patch_func() adds to klp_ops while the scheduler walks it.

> (btw, I do not think that those traces are necessary here. More
> btw, it would be nice to have a human readable changelog instead of what
> looks like AI generated description of the patch itself).

Fair enough, I'll rewrite it and drop the traces.

> How did you find the issue? Is it a real problem in production?

An LLM found it while auditing kernel/livepatch/.  It is not a
production issue.  The reproducer was written by an LLM as well; it is
below, apply it with "git apply -p0".  It keeps a transition stuck on
a few kthreads and reloads a patched module in a loop.  On v7.3-rc7 it
faults in klp_find_ops() within a few minutes with KCSAN_STRICT=y.

> I wonder whether we could just decline delete_module() in this case and
> return -EBUSY. It should be a rare operation anyway. Alternatively we
> could increase refcounts of all patched modules during a transition and
> decrease them after.

I don't think either covers all the paths.  klp_module_going() is also
called when a module's init fails, or when its load is aborted after
klp_module_coming(), and neither -EBUSY nor a module reference prevents
that.  Loading a patched module also adds to klp_ops under the walk.
And klp_find_ops() walks the global klp_ops list, so it's the modules of
all patches that matter, not just the transition patch.

> I am not saying we should not do the RCU protection but it feels like a
> can of worms a bit so if there is an easier way...

I could split it: one patch RCU-protecting klp_ops, which fixes the
crash, and a second one for the ordering on module reload, which was found
by inspection and has not been reproduced.  Would that be easier to review?

Thanks,
  Andrea

diff --git klp-race-repro/README klp-race-repro/README
new file mode 100644
--- /dev/null
+++ klp-race-repro/README
@@ -0,0 +1,108 @@
+Livepatch klp_ops race reproducer
+=================================
+
+This directory contains a reproducer for a use-after-free in
+klp_find_ops(): the function walks the global klp_ops list from the
+scheduler (__klp_sched_try_switch() -> klp_try_switch_task() ->
+klp_check_stack() -> klp_check_stack_func()) without klp_mutex, while
+klp_patch_func()/klp_unpatch_func() add, remove and free klp_ops entries
+under klp_mutex when a to-be-patched module is loaded or unloaded.
+
+The fix ("livepatch: Fix races between stack check and module load/unload")
+RCU-protects the klp_ops list.
+
+Files
+-----
+  klp_race_target_a.c   target module A: four kthreads looping in
+                        ra_target_a_loop(), which sleeps with
+                        TASK_FREEZABLE.  The livepatch transition can not
+                        switch them, so it stays in progress and the
+                        scheduler keeps calling klp_find_ops().
+  klp_race_target_b.c   target module B: 32 patchable no-op functions.
+  klp_race_patch.c      livepatch patching ra_target_a_loop() (A) and all
+                        ra_target_b_func*() (B).
+  run.sh                sets up the stuck transition and then insmod/rmmods
+                        module B in a loop.
+  Makefile              builds the three modules against a kernel tree.
+
+Requirements
+------------
+  CONFIG_LIVEPATCH=y, CONFIG_MODULES=y, CONFIG_MODULE_UNLOAD=y,
+  CONFIG_FUNCTION_TRACER=y, CONFIG_DYNAMIC_FTRACE_WITH_REGS=y,
+  CONFIG_KALLSYMS_ALL=y, CONFIG_KCSAN=y and CONFIG_KCSAN_STRICT=y.
+
+  CONFIG_KCSAN_STRICT is important: the default KCSAN configuration
+  (CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y) does not report this race.
+
+  Developed on a WSL2 host; vng needs "--force-9p" there (virtiofsd is
+  not available).
+
+Building
+--------
+  KDIR=/path/to/kernel/tree
+
+  cd $KDIR
+  # enable the options above, then:
+  make -j4
+
+  cd $KDIR/repro
+  make -j4 KERNELDIR=$KDIR
+
+Settings
+--------
+  run.sh reads these environment variables:
+
+    ITER      maximum number of unload/reload cycles of module B
+              (default 20000)
+    DURATION  maximum length of the loop in seconds (default 1800);
+              the loop stops at whichever of ITER and DURATION is
+              reached first, and run.sh prints both numbers
+    OUT       if set, run.sh saves the full dmesg to $OUT/dmesg.txt
+              at the end; the grep it prints can miss lockdep and RCU
+              reports.  Make the directory writable in the guest,
+              e.g. with vng --rwdir=$OUT
+
+Run unpatched (expect a crash)
+------------------------------
+  Revert/invert the fix first and rebuild the kernel, then:
+
+  vng -r $KDIR --cpus 4 --memory 4G --force-9p --verbose \
+      --exec "ITER=100000 sh $KDIR/repro/run.sh $KDIR/repro"
+
+  Within a few minutes the guest reports a data race between
+  klp_find_ops() and klp_unpatch_func(), and then a general protection
+  fault in klp_find_ops():
+
+    BUG: KCSAN: data-race in klp_find_ops / klp_unpatch_func
+    ...
+    Oops: general protection fault, probably for non-canonical address
+    0xdead000000000110
+    RIP: 0010:klp_find_ops+0x55/0x90
+    ...
+    __klp_sched_try_switch
+    __schedule
+
+  0xdead000000000110 is LIST_POISON1 (0xdead000000000100) plus the offset
+  of func_stack in struct klp_ops: the reader walked a list node that
+  klp_unpatch_func() had just list_del()'d.
+
+Run patched (expect no klp report)
+----------------------------------
+  With the fix applied and the kernel rebuilt, run the same command.
+  Unrelated KCSAN races (9p, kernfs, ...) may still be reported, but
+  there must be no klp_* report and no fault.  The transition also
+  completes normally once the kthreads are stopped:
+
+    livepatch: 'klp_race_patch': patching complete
+
+Notes
+-----
+  - The transition is kept incomplete on purpose: the kthreads sleep
+    inside a function the livepatch wants to patch, so the consistency
+    model refuses to switch them and klp_resched_enable() keeps the
+    scheduler hook active.
+  - Module B is unloaded/reloaded to race klp_unpatch_func() and
+    klp_patch_func() against the scheduler walk; the 32 functions widen
+    the walk.
+  - Reproduces probabilistically; run it for a few minutes.
+    KCSAN_STRICT usually reports the race well before the GPF.
diff --git klp-race-repro/Makefile klp-race-repro/Makefile
new file mode 100644
--- /dev/null
+++ klp-race-repro/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+KERNELDIR ?= /lib/modules/$(shell uname -r)/build
+PWD := $(shell pwd)
+
+obj-m += klp_race_target_a.o
+obj-m += klp_race_target_b.o
+obj-m += klp_race_patch.o
+
+all:
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
+
+clean:
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
diff --git klp-race-repro/run.sh klp-race-repro/run.sh
new file mode 100644
--- /dev/null
+++ klp-race-repro/run.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Reproducer for the livepatch klp_ops race.
+#
+# klp_check_stack_func() runs from the scheduler (__klp_sched_try_switch() ->
+# klp_try_switch_task() -> klp_check_stack() -> klp_check_stack_func()) without
+# klp_mutex and calls klp_find_ops(), which walks the global klp_ops list.
+# klp_patch_func()/klp_unpatch_func() add/remove/free those entries under
+# klp_mutex when a to-be-patched module is loaded/unloaded.
+#
+# The target A kthread sleeps freezably inside a patched function, so the
+# transition never completes and the scheduler keeps walking klp_ops.  The
+# target B module is then loaded and unloaded in a loop to free/reallocate
+# klp_ops entries concurrently.
+
+set -u
+
+DIR=${1:-$(pwd)}
+ITER=${ITER:-20000}
+DURATION=${DURATION:-1800}
+OUT=${OUT:-}
+
+echo "== livepatch klp_ops race reproducer =="
+
+insmod "$DIR/klp_race_target_a.ko" || exit 1
+insmod "$DIR/klp_race_target_b.ko" || exit 1
+insmod "$DIR/klp_race_patch.ko" || exit 1
+
+# Let the transition get stuck on the target A kthread.
+sleep 1
+echo -n "transition: "
+cat /sys/kernel/livepatch/klp_race_patch/transition
+
+i=0
+start=$(date +%s)
+end=$((start + DURATION))
+while [ "$i" -lt "$ITER" ] && [ "$(date +%s)" -lt "$end" ]; do
+	rmmod klp_race_target_b || break
+	insmod "$DIR/klp_race_target_b.ko" || break
+	i=$((i + 1))
+done
+
+echo "iterations: $i in $(( $(date +%s) - start ))s"
+
+# Unblock and tear down.
+rmmod klp_race_target_a 2>/dev/null
+sleep 1
+echo 0 > /sys/kernel/livepatch/klp_race_patch/enabled 2>/dev/null
+rmmod klp_race_patch 2>/dev/null
+rmmod klp_race_target_b 2>/dev/null
+
+echo "== result =="
+dmesg | grep -iE "KCSAN|BUG:|use-after-free|list_(add|del)|klp_(find_ops|unpatch_func|patch_func)|ra_target" | tail -n 120
+
+[ -n "$OUT" ] && dmesg > "$OUT/dmesg.txt"
diff --git klp-race-repro/klp_race_patch.c klp-race-repro/klp_race_patch.c
new file mode 100644
--- /dev/null
+++ klp-race-repro/klp_race_patch.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Livepatch for the klp_ops race reproducer.
+ *
+ * It patches ra_target_a_loop() (target A) and the ra_target_b_func*()
+ * family (target B).  Loading it starts a transition which can not complete
+ * because the target A kthread sleeps inside ra_target_a_loop().
+ */
+
+#include <linux/module.h>
+#include <linux/livepatch.h>
+
+static void ra_patch_a(void)
+{
+}
+
+static void ra_patch_b(void)
+{
+}
+
+static struct klp_func funcs_a[] = {
+	{ .old_name = "ra_target_a_loop", .new_func = ra_patch_a, },
+	{ }
+};
+
+#define RA_PATCH_B_ENTRY(n) \
+	{ .old_name = "ra_target_b_func" #n, .new_func = ra_patch_b, },
+
+static struct klp_func funcs_b[] = {
+	RA_PATCH_B_ENTRY(0)
+	RA_PATCH_B_ENTRY(1)
+	RA_PATCH_B_ENTRY(2)
+	RA_PATCH_B_ENTRY(3)
+	RA_PATCH_B_ENTRY(4)
+	RA_PATCH_B_ENTRY(5)
+	RA_PATCH_B_ENTRY(6)
+	RA_PATCH_B_ENTRY(7)
+	RA_PATCH_B_ENTRY(8)
+	RA_PATCH_B_ENTRY(9)
+	RA_PATCH_B_ENTRY(10)
+	RA_PATCH_B_ENTRY(11)
+	RA_PATCH_B_ENTRY(12)
+	RA_PATCH_B_ENTRY(13)
+	RA_PATCH_B_ENTRY(14)
+	RA_PATCH_B_ENTRY(15)
+	RA_PATCH_B_ENTRY(16)
+	RA_PATCH_B_ENTRY(17)
+	RA_PATCH_B_ENTRY(18)
+	RA_PATCH_B_ENTRY(19)
+	RA_PATCH_B_ENTRY(20)
+	RA_PATCH_B_ENTRY(21)
+	RA_PATCH_B_ENTRY(22)
+	RA_PATCH_B_ENTRY(23)
+	RA_PATCH_B_ENTRY(24)
+	RA_PATCH_B_ENTRY(25)
+	RA_PATCH_B_ENTRY(26)
+	RA_PATCH_B_ENTRY(27)
+	RA_PATCH_B_ENTRY(28)
+	RA_PATCH_B_ENTRY(29)
+	RA_PATCH_B_ENTRY(30)
+	RA_PATCH_B_ENTRY(31)
+	{ }
+};
+
+static struct klp_object objs[] = {
+	{ .name = "klp_race_target_a", .funcs = funcs_a, },
+	{ .name = "klp_race_target_b", .funcs = funcs_b, },
+	{ }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int __init ra_patch_init(void)
+{
+	return klp_enable_patch(&patch);
+}
+
+static void __exit ra_patch_exit(void)
+{
+}
+
+module_init(ra_patch_init);
+module_exit(ra_patch_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_DESCRIPTION("livepatch klp_ops race reproducer: patch");
diff --git klp-race-repro/klp_race_target_a.c klp-race-repro/klp_race_target_a.c
new file mode 100644
--- /dev/null
+++ klp-race-repro/klp_race_target_a.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Target module A for the livepatch klp_ops race reproducer.
+ *
+ * A kthread repeatedly calls ra_target_a_loop(), which goes to sleep with
+ * TASK_FREEZABLE.  While the livepatch transition is in progress the task
+ * can not be switched (it sleeps inside the to-be-patched function), so the
+ * transition never completes and __klp_sched_try_switch() keeps walking the
+ * global klp_ops list from the scheduler.
+ */
+
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+
+void ra_target_a_loop(void);
+
+noinline void ra_target_a_loop(void)
+{
+	set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
+	if (!kthread_should_stop())
+		schedule_timeout(msecs_to_jiffies(1));
+	__set_current_state(TASK_RUNNING);
+}
+
+#define RA_NR_THREADS 4
+
+static struct task_struct *ra_threads[RA_NR_THREADS];
+
+static int ra_thread_fn(void *unused)
+{
+	while (!kthread_should_stop())
+		ra_target_a_loop();
+
+	return 0;
+}
+
+static int __init ra_a_init(void)
+{
+	int i;
+
+	for (i = 0; i < RA_NR_THREADS; i++) {
+		int err;
+
+		ra_threads[i] = kthread_run(ra_thread_fn, NULL, "ra_target_a/%d", i);
+		if (IS_ERR(ra_threads[i])) {
+			err = PTR_ERR(ra_threads[i]);
+			while (--i >= 0)
+				kthread_stop(ra_threads[i]);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static void __exit ra_a_exit(void)
+{
+	int i;
+
+	for (i = 0; i < RA_NR_THREADS; i++)
+		kthread_stop(ra_threads[i]);
+}
+
+module_init(ra_a_init);
+module_exit(ra_a_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("livepatch klp_ops race reproducer: target A");
diff --git klp-race-repro/klp_race_target_b.c klp-race-repro/klp_race_target_b.c
new file mode 100644
--- /dev/null
+++ klp-race-repro/klp_race_target_b.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Target module B for the livepatch klp_ops race reproducer.
+ *
+ * It provides a set of functions which are patched by klp_race_patch.  The
+ * module is unloaded and loaded in a loop while the livepatch transition is
+ * stuck on target A, so that klp_unpatch_func()/klp_patch_func() free and
+ * allocate klp_ops entries while the scheduler walks the list.
+ */
+
+#include <linux/module.h>
+#include <linux/compiler.h>
+
+#define RA_TARGET_B_FUNCS(X) \
+	X(0) X(1) X(2) X(3) X(4) X(5) X(6) X(7) \
+	X(8) X(9) X(10) X(11) X(12) X(13) X(14) X(15) \
+	X(16) X(17) X(18) X(19) X(20) X(21) X(22) X(23) \
+	X(24) X(25) X(26) X(27) X(28) X(29) X(30) X(31)
+
+#define RA_PROTO_B(n) void ra_target_b_func##n(void);
+RA_TARGET_B_FUNCS(RA_PROTO_B)
+
+#define RA_DEF_B(n) noinline void ra_target_b_func##n(void) { barrier(); }
+RA_TARGET_B_FUNCS(RA_DEF_B)
+
+static int __init ra_b_init(void)
+{
+	return 0;
+}
+
+static void __exit ra_b_exit(void)
+{
+}
+
+module_init(ra_b_init);
+module_exit(ra_b_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("livepatch klp_ops race reproducer: target B");
