Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378BC41D22E;
	Mon, 14 Sep 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377610; cv=none; b=SMiFwzG9q5jh9nA72vHC1ynSBRTm6U06cAo2BUaUDPa7KmYF6ymsUu5xg/WTQ3Sd1/CfCFTDl5HtbGiReImct2eJ7B1yrGdoFSsy/kIfKk2jd7vV/QWnHGMgzNat987m61jZNwInSeJ+d3wkpMzgacWj9W7Tw0gLJPYHz4HyEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377610; c=relaxed/simple;
	bh=Dbt/u2Th7DInX9UOvRT729AxlZ4woY/FSOLDAOOROOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CutSNQd4fbqSWbzicedjV98+MQ8GmGU3kPJC/mbaG31vTkTQzrFkbR2GWApRHDUK+1LiZ2zdDHN4KBbR8VCnDk20+3sI9QDXiz6K+K6zC9I5jcEtutDenMpBR1xe64SymlHkhiIVLG801nwlpsYgddsr6ijEp2lPXoJh1ctCn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: xABupc/+Qz+KpllhNGSJOg==
X-CSE-MsgGUID: vMlld0GyQ1qLoyD+FDr+5g==
X-IronPort-AV: E=Sophos;i="6.27,102,1786982400"; 
   d="scan'208";a="188847208"
From: Shaobo Huang <huangshaobo3@xiaomi.com>
To: <ljs@kernel.org>
CC: <akpm@linux-foundation.org>, <bsegall@google.com>, <david@kernel.org>,
	<dietmar.eggemann@arm.com>, <huangshaobo3@xiaomi.com>,
	<juri.lelli@redhat.com>, <kees@kernel.org>, <kprateek.nayak@amd.com>,
	<liam@infradead.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@suse.de>, <mhocko@suse.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <rppt@kernel.org>,
	<ryabinin.a.a@gmail.com>, <stable@vger.kernel.org>, <surenb@google.com>,
	<vbabka@kernel.org>, <vincent.guittot@linaro.org>, <vschneid@redhat.com>
Subject: Re: [PATCH] fork: reset pointer tag of vmapped thread stack before vfree
Date: Mon, 14 Sep 2026 17:19:56 +0800
Message-ID: <20260914091956.100424-1-huangshaobo3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <anSVlVpUXrA8ra_z@lucifer>
References: <anSVlVpUXrA8ra_z@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJ-MBX13.mioffice.cn (10.237.8.133) To BJ-MBX01.mioffice.cn
 (10.237.8.121)

On Thu, Aug 06, 2026 at 03:13:31PM +0100, Lorenzo Stoakes (ARM) wrote:
> This looks AI-generated but I see no Assisted-by tag, please follow kernel
> procedure on this please.
>
> https://docs.kernel.org/process/coding-assistants.html
>
> None of your 4 patches pre-dating the slopularity look anything like this.
>
> Also please use a real name.

Thanks for the review.  v2 addresses all of these:

  - Added Assisted-by: tag per Documentation/process/coding-assistants.rst.
  - Used my real name (Shaobo Huang).
  - Dropped the verbose comment; the fix is a one-liner.
  - Fixed the Fixes: tag (see below).
  - Trimmed the commit message; removed the full KASAN dump.

> Output from a repro that you don't share, brilliant.

Fair — should have included it from the start.  Here it is:

  Prerequisites:
    - CONFIG_KASAN_SW_TAGS + CONFIG_KASAN_STACK + CONFIG_VMAP_STACK
    - /sys/power/mem_sleep set to "deep" (s2idle does not enter
      cpu_suspend and will not trigger the bug)
    - A wake source (RTC alarm, power button, etc.)

  Method 1 (deterministic, single command):

    # rtcwake -m mem -s 3

    rtcwake writes "mem" to /sys/power/state, driving suspend-to-RAM.
    At _cpu_resume, kasan_unpoison_task_stack_below() rewrites the
    rtcwake process's kernel stack shadow [base, sp] to
    KASAN_TAG_KERNEL (0xff).  On resume, rtcwake exits; its thread
    stack is freed via RCU callback (thread_stack_free_rcu -> vfree
    -> vfree_atomic), and the llist_add write trips KASAN.

  Method 2 (how the original report was captured):

    1. Trigger system suspend (screen off, or `echo mem >
       /sys/power/state` with an RTC alarm) -- the suspend-driving
       task's stack gets 0xff'd on resume.
    2. Trigger reboot/shutdown (`reboot bootloader`) -- during
       shutdown, init kills services; the suspend-driving thread
       exits, its stack is RCU-freed, and vfree_atomic trips.

  The original KASAN report in v1 was from method 2 on a Xiaomi
  Xring_o1 (arm64, 4K pages, SW_TAGS).

> A 2016 Fixes for some KASAN state bug? Really?

Fixed in v2: Fixes: 9f7d416c3612 ("kprobes: Unpoison stack in jprobe_return()
for KASAN") -- the commit that introduced kasan_unpoison_task_stack_below(),
adding both the function definition and the _cpu_resume() call site that
writes 0xff to the stack shadow on every CPU resume.  The v1's Fixes
(0f110a9b956c, the vfree_atomic commit) was incorrect: vfree_atomic is
fine; the issue is the shadow/pointer tag divergence introduced by
kasan_unpoison_task_stack_below().

> And of course Cc: stable...

Cc: stable is retained in v2: the fix is one line, and the bug affects
any stable kernel with SW_TAGS + KASAN_STACK + VMAP_STACK where a
non-idle task drives system suspend and later exits.  Happy to drop it
if you'd prefer the stable team evaluate separately.

> Nobody in their right mind does a comment like this for a kasan_reset_tag().

Agreed -- dropped in v2.

v2 will follow shortly.

Cheers,
Shaobo
