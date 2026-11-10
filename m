Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288827;
	b=MWyCUTWFdzfjfmjAW/dp5jl5Zk5sKCPyXloNvVAw3NBEypl/F8slDqTPSzI2/i/MeZRw
	 PMD0cU5WiIQbCu3uw6kW+A2nweJ2FyQG+rZphKzBbjIhOUDW2ENqtSsrQM3C/PSyK2Yar
	 tt+4i46X5Mrc+VrB2il+zoNM4XbOhdRO6xL3AV+XBFSp5jxHNnJwkoen4fBrszjGnbjWd
	 xYccT5w7n+no8m5lxg1wwVAUCdb7A+ijUhC5rYS6n2jSx0ZDVCcQFA5LmeogDed12RK2D
	 6UNqHLaP/ZYY8VKql1qA5UnwXIrrktYA8S0mghLO058waKQ0F5fAJ/N6776VtLEqOtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SXPCCLeu6bOfAQfnDnfqA2Y+labC//B5Rc3/aEJwvGM=;
	b=eGEFUrC8SmzLmXsKIE9grwBJCFqb2cB334/IPOfLoCcro9vMv3UuztfIdSN4ZThLLMpu
	 Ye3dyE8AmHqAC9SEF5tXYvG3F4U3zKk2OXNZ0sloDSrRIBOXoe2MuPAcMOgoY7q6MbOe+
	 wD6wjYOMdqsA26oZIsiNkegxn+xbTFWluiU37irACEFxoXHRnfiCLmnzIIAlRhOv64gMx
	 n0FaCE+7Oonvl43VvxjtEc2NSchcDS5cdMzupXajzuzQ6hpWHuqOt5r2i7UNkEwXN1kDG
	 uPd/XapBcd6hbGnoJcZkNPW+GxRlLVMPLEieMGGr+CyfIeilL1RaPVk/eCKAd1Kxc9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b="uOM/Az8v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422CA606A33C;
	Tue, 10 Nov 2026 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=uOM/Az8v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2FC1F0089F;
	Tue, 10 Nov 2026 05:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794288827;
	bh=SXPCCLeu6bOfAQfnDnfqA2Y+labC//B5Rc3/aEJwvGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=uOM/Az8vhUo8huEn5CCDDJ70WdmUBJJ1YNghwS13hD0Y8+g+G2waPjZMqo8NhCj/w
	 AOs+nfkM+xpY9/lfMgpCqJUdqNPORQ6LEeJv8Boz+AiZJBPYMlRJBl187b4wFAY2FC
	 Ql21XDDvgZOT3dimGKlEf+J695tQr83bXe9b6/Vg=
Date: Mon, 9 Nov 2026 21:33:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fault-inject: fix boot failure with fault injection
 boot parameters
Message-Id: <20261109213346.634e83b158ee7086e64f9cd5@linux-foundation.org>
In-Reply-To: <20261105160209.1504867-1-ekffu200098@gmail.com>
References: <20261105160209.1504867-1-ekffu200098@gmail.com>
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

On Fri,  6 Nov 2026 01:01:58 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Since commit e9bc360b105c ("fault-inject: use prandom where
> cryptographically secure randomness is not needed"), setup_fault_attr()
> calls prandom_init_once(), which calls kmalloc() and schedule_work().
> 
> But setup_fault_attr() can be called from __setup handlers before slab
> and workqueues are initialized, so any fault injection boot parameter
> leads to boot failure.
> 
> So use DO_ONCE_LITE() instead.

thanks.  I'm surprised that command-line fault-injection options (or at
least failslab) have been broken for 1.5 years.

And what's going on in that code?  Why does it need to call
prandom_init_once() from three different sites?

I discussed it with LLM for a while and it proposed the below.  But I
ran out of time to think about this.  The code seems to need a
signficant rethink so I suppose a quick bandaid as you suggest is good
enough for now :(





Could we use a shared initialization helper instead?

There are three prandom_init_once() expansions in fault-inject.c.
Each has its own guard, so configuring another interface can reseed
the same state after fault injection has started.

DO_ONCE_LITE() avoids the allocation and workqueue dependency, but
doesn't serialize concurrent initialization or wait for another caller
to finish seeding.

The patch below keeps prandom_seed_full_state() and gives all three
configuration paths one lock and one completion flag. The three calls
remain because each interface can independently enable injection.
Moving initialization to an initcall would leave boot-parameter users
able to inject faults before the initcall runs.

An ordinary spinlock is sufficient: these are configuration paths, not
the interrupt-time random-number generation path. It also preserves
the lock type used by DO_ONCE(), allowing the RNG's ordinary locks on
PREEMPT_RT. No raw spinlock or explicit interrupt disabling is needed.

From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 5 Nov 2026 10:01:33 -0800
Subject: [PATCH] fault-inject: initialize random state once without workqueues

Fault-injection boot parameters call setup_fault_attr() before slab
and workqueues are initialized. Its prandom_init_once() call expands
to DO_ONCE(), whose static-key disabling path allocates memory and
schedules work. A valid boot parameter can therefore crash the kernel
before boot completes, even when its probability is zero.

The debugfs and configfs setup paths have separate prandom_init_once()
expansions. Their independent guards also allow the shared random
state to be seeded again after another interface has enabled fault
injection.

Replace the three expansions with calls to a shared helper. Serialize
initialization with an ordinary spinlock and set the completion flag
only after prandom_seed_full_state() has finished. This retains the
existing seeding algorithm without allocating memory or scheduling
work to disable a static key.

The lock protects configuration-time initialization, which is not
called from interrupt handlers. Use an ordinary spinlock rather than
a raw spinlock because the RNG acquires ordinary locks that can sleep
on PREEMPT_RT.

Fixes: e9bc360b105c ("fault-inject: use prandom where cryptographically secure randomness is not needed")
Reported-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Prepared against c2366a2edc886a5a02d2a43de8b1c6ec09bab840.
Source inspection only; this replacement has not been built or
boot-tested.

 lib/fault-inject.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/stacktrace.h>
 #include <linux/fault-inject.h>
+#include <linux/spinlock.h>
 
 /*
  * The should_fail() functions use prandom instead of the normal Linux RNG
@@ -19,6 +20,24 @@
  */
 static DEFINE_PER_CPU(struct rnd_state, fault_rnd_state);
 
+static void fault_random_init(void)
+{
+	static DEFINE_SPINLOCK(lock);
+	static bool initialized;
+
+	/*
+	 * Configuration paths must finish seeding before enabling injection,
+	 * and must not reseed state already in use by another interface.
+	 * These callers are not interrupt handlers. An ordinary lock allows
+	 * the RNG's sleeping locks on PREEMPT_RT.
+	 */
+	spin_lock(&lock);
+	if (!initialized) {
+		prandom_seed_full_state(&fault_rnd_state);
+		initialized = true;
+	}
+	spin_unlock(&lock);
+}
+
 static u32 fault_prandom_u32_below_100(void)
 {
 	struct rnd_state *state;
@@ -50,7 +69,7 @@
 		return 0;
 	}
 
-	prandom_init_once(&fault_rnd_state);
+	fault_random_init();
 
 	attr->probability = probability;
 	attr->interval = interval;
@@ -240,7 +259,7 @@
 	if (IS_ERR(dir))
 		return dir;
 
-	prandom_init_once(&fault_rnd_state);
+	fault_random_init();
 
 	debugfs_create_ul("probability", mode, dir, &attr->probability);
 	debugfs_create_ul("interval", mode, dir, &attr->interval);
@@ -456,7 +475,7 @@
 
 void fault_config_init(struct fault_config *config, const char *name)
 {
-	prandom_init_once(&fault_rnd_state);
+	fault_random_init();
 
 	config_group_init_type_name(&config->group, name, &fault_config_type);
 }
