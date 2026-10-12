Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC0336883
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819100; cv=none; b=h5XMdck/Xv0mjupwgczvhqBNT5ntF/34T9LA8WmRn9E+3zf9Ax1Nb7AlNJ6arXKEKjfKYYh3AcBVYWNLKFeb5hYvOr6pB2QFWWYMsa58BFZZIzA34RB9nhbfFar99/NlzAuR+z+Y2jm52Q1TtkF9UijUZI9j/PNFrlo9zNw+BJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819100; c=relaxed/simple;
	bh=f/4vr1dZT3VLMRa1IvmSDpB6Oddn41dENRdGQqUpNGM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QfO5boyFtUFAHoDI8VF+DuuSah2D50tJjcHVao4mP/iGa2ZnwtlyteP0ta2M3cx7fkhneBG5Pwp+dcIko9X/DzDOmPjPcaE1vRz7ypfpj0momwVhlryiaXk6HuKH40/5lORKSJ2pu/BUtCx+tVhBJLZ0YyhNH9VQm+n34paS+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tG4mjGGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tG4mjGGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008A81F0089B;
	Mon, 12 Oct 2026 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819099;
	bh=TLm96fg3sTpLC3mGZsPCVKiEHMsLHSv/BQxgVZxVxjk=;
	h=Subject:To:Cc:From:Date;
	b=tG4mjGGb5dG0NNmw99XlB4diWahLrqVtB1x2FSfuBan69aArA9JmKroz/BSheRt6K
	 jLL9wP6NvaDPi6zlHe2G/MSiDft/dB6t6hmsV727leGAnQQxzAaWVUyU2WGRKE1StD
	 JnhLQuhfp4la5Xudt/WsKEPjAXh7dZXagF4e73X4=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Unmask interrupts only when ACTIVE is true" failed to apply to 5.15-stable tree
To: krzysztof.karas@intel.com,andi.shyti@linux.intel.com,jani.nikula@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:30:15 +0200
Message-ID: <2026101215-poem-latter-1f1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5346b1cec6afa4f9b4b49a9f84e3cfef95a3f7bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101215-poem-latter-1f1d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5346b1cec6afa4f9b4b49a9f84e3cfef95a3f7bb Mon Sep 17 00:00:00 2001
From: Krzysztof Karas <krzysztof.karas@intel.com>
Date: Thu, 10 Sep 2026 08:13:29 +0000
Subject: [PATCH] drm/i915/gt: Unmask interrupts only when ACTIVE is true

There is a small race window between intel_rps_boost() reading
a stale ACTIVE state and queuing rps->work, where ACTIVE may be
changed via asynchronous calls triggered by wakeref drop.
This means that rps_work() could be triggered after the GT has
been parked, so unmasking RPS PM interrupts would happen without
holding PM wakelock. This sequence of events may be observed
during live_rc6_ctx_wa() selftest:

1) live_rc6_ctx_wa()
   -> intel_engine_pm_put()
      -> wakeref_put()

ASYNC1) wakeref_put() callback
          -> __engine_park()
             -> intel_gt_pm_put_async()
                -> intel_gt_pm_put_async_untracked()
                   -> intel_wakeref_put_async()

ASYNC2) wakeref_put_async() callback
          -> __gt_park()
             -> intel_rps_park()
                -> intel_rps_clear_active() [clear ACTIVE]
                WITH INTERRUPTS:
                -> rps_disable_interrupts()
                   -> cancel_work_sync(rps->work)
                   -> rps_reset_interrupts() [rps->pm_iir = 0]
                WITHOUT INTERRUPTS (TIMER mode):
                -> rps_stop_timer()
                   -> cancel_work_sync(rps->work)

2) live_rc6_ctx_wa()
   -> intel_gt_wait_for_idle()
      -> intel_gt_retire_requests_timeout()
         -> dma_fence_wait_timeout()
            -> ops->wait() [i915_fence_wait()]
               -> i915_request_wait_timeout()
                  -> intel_rps_boost()
                     -> intel_rps_is_active() [check ACTIVE]
                        [OPEN RACE WINDOW]
                     -> queue_work(rps->work)
         -> retire_requests()
            -> i915_request_retire()
               -> intel_rps_dec_waiters() [from 1 to 0]

If ASYNC1 and ASYNC2 would execute during [OPEN RACE WINDOW],
then:

3) rps_work() executes from the workqueue and may satisfy
   "(!pm_iir && !client_boost)" test (in TIMER mode rps->pm_iir
   is zeroed by an earlier rps_work() call or never gets a new
   value after previous intel_rps_unpark() event), so it jumps
   to "out" label, bypassing intel_rps_is_active() guard and
   executes gen6_gt_pm_unmask_irq();

4) GT is parked and runtime PM wakelock is dropped, so only
   a raw reference in __gt_park() ->
   intel_display_power_put_async() remains for 100ms, then the
   MMIO write in gen6_gt_pm_unmask_irq() detects missing
   wakelock via assert_rpm_wakelock_held() and emits
   "RPM wakelock ref not held during HW access" tainting kernel.

Commit 3e7abf814193 ("drm/i915: Extract GT render power state management")
dropped the "if (rps->interrupts_enabled)" guard that
gen6_pm_rps_work() had around this unmask in i915_irq.c.
INTEL_RPS_ACTIVE brackets the same window, since it is set in
intel_rps_unpark() before rps_enable_interrupts() and
rps_start_timer() and cleared in intel_rps_park() before
rps_stop_timer() and rps_disable_interrupts().

Skip unmasking when RPS is no longer active (reaching unmask
operation is independent of INTERRUPT mode). This does not
prevent RPS operation from resuming on the next unpark.
In interrupt mode, intel_rps_unpark() calls
rps_enable_interrupts(), which enables and unmasks the PM
interrupts. In timer mode, it calls rps_start_timer(),
restarting periodic engine-busyness evaluation. The timer
generates software RPS events and queues rps_work() directly,
independently of PM interrupt delivery. Neither mode requires
the late worker to unmask interrupts while the GT is parked

Fixes: 3e7abf814193 ("drm/i915: Extract GT render power state management")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16562
Cc: stable@vger.kernel.org # v5.5+
Assisted-by: GitHub-Copilot:claude-opus-5
Assisted-by: GitHub-Copilot:gpt-6-astra
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patch.msgid.link/20260910081329.3300417-1-krzysztof.karas@intel.com
(cherry picked from commit ca4a6deadad15b91ee083afe445fa6bdbfb68206)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/intel_rps.c b/drivers/gpu/drm/i915/gt/intel_rps.c
index a33b19c04737..0f9b4f1dd3cb 100644
--- a/drivers/gpu/drm/i915/gt/intel_rps.c
+++ b/drivers/gpu/drm/i915/gt/intel_rps.c
@@ -1904,7 +1904,8 @@ static void rps_work(struct work_struct *work)
 
 out:
 	spin_lock_irq(gt->irq_lock);
-	gen6_gt_pm_unmask_irq(gt, rps->pm_events);
+	if (intel_rps_is_active(rps))
+		gen6_gt_pm_unmask_irq(gt, rps->pm_events);
 	spin_unlock_irq(gt->irq_lock);
 }
 

