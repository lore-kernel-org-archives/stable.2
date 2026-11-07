Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045830;
	b=NzmycPqeZDpBAjpuxM4tJasTiz1MTS4Ozqo6JFsi4lSZFxQWDyTd1p2/IwvmHwFcYh2U
	 7uO1V6SBiOnCaV7nI/xdSBxESZ6KqykOoTFxVVKgiWY7aA4veg9Ofh6nVPJljdbBAUOEh
	 EujvuTqabpniKqjvDVEMPiqvKnMlZQk2/c1XIbRvZXEUgjqJwhpsrlCSNrI5dbOqGFncs
	 tZIFqKXPXdnmNP6mKeNYCuhc9eqnsz6SibvL88LkTtAfeYF/UTPriQNrwY18Uycy3q8o0
	 bKhiLiEY3n07O+EQNij09Qy97ihkoWSnYZkJA1SmdDOkip+Y9mosngraRutt/FAXVLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7NHKgD98NO40NVcxnB4MPswO/f3cpUyt6nlypS9pr4o=;
	b=h3noS0U+AL0QbiVgisTLTKfstqQWqD4Yk015zyVOuWgDD9RNLo6CzxKMosytwhEg9yNH
	 6bRJx7ZF5Aj9+6BO2no3hP6/4BSIw+2bkuw6p7pNp7IpMnBSElZyge8WER3u3Q7dcwXvX
	 dsNcUSWza/7DBT7JuHaA/F6fo0N38qcZENx0WxOGr55em+1V99oi5s7rt70Dv1CSt7pB4
	 +LdRMQ3JGMmcMzkl3Wx8m/7G6I15gc9h4WPvx/2TaZzMiff6HBonUN6olvg8VGLiFuFuZ
	 tBTMr9zTYtY03PHNWc7ph4+YrYffkKn5cM5nf5h6HgBNdUqZEhKD3GofYuHOYNHXJRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP0fkhGp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP0fkhGp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442681F0089F;
	Sat,  7 Nov 2026 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045829;
	bh=7NHKgD98NO40NVcxnB4MPswO/f3cpUyt6nlypS9pr4o=;
	h=From:To:Cc:Subject:Date;
	b=BP0fkhGpKCN2OC2jRreC4AJ+IYbVYtA9MpzY6eJI/HO1GiIIzjQii8a7ak6W+J0hw
	 jZ4S0wgUL6gGNVSD6pX4H6v5zdPJfHJpLXEX/zj6HFHxY4JdgZl6abPvqI4fBRd0PV
	 T7V6lvOqV0fxRfYAEWf1H24/4bSuwmUQuTj751aUl6iWUmbHJpxNQbEY5gqSyrZvFb
	 Voe0+V0QUvmTpXwwdj3nwat8B91NG0uQb2+NCN8AGnMtJmYef99a7Cg2m7SM91X0Z7
	 oYHxa3iHMthEbXw0l7bIGJ174CTchCYok/cNnmEYg/44Y0Z4qHXpotGsYq1hoCjCvc
	 TDkfoUc9wy0MA==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.karas@intel.com,
	andi.shyti@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/gt: Unmask interrupts only when ACTIVE is true" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:48 -0500
Message-ID: <20261107050348-failed-7.3-ca4a6deadad1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x ca4a6deadad15b91ee083afe445fa6bdbfb68206
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050348-failed-7.3-ca4a6deadad1@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ca4a6deadad15b91ee083afe445fa6bdbfb68206 Mon Sep 17 00:00:00 2001
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
---
 drivers/gpu/drm/i915/gt/intel_rps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_rps.c b/drivers/gpu/drm/i915/gt/intel_rps.c
index a33b19c04737a..0f9b4f1dd3cb6 100644
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
 
-- 
2.53.0




