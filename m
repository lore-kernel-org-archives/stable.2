Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021807;
	b=oSD4RvD0DwM3JUebPag4xAA/F/YuzJdTp30782KcsYvwZLGAOeaS0Y9+3n63Lu99Hdym
	 WOe8q4crunTP86bJS5hPs9IZru8HhaujrQBvRyY7Ol7gyuK5HXNBgWnoQ1xCJEU1KkFYq
	 uNu0ZAGg6+rxMTTkE/F+5kc5P80LQjM6vbZ0WpvMdUpkc+UXwgE+oSkojxFu44yWi3eqx
	 RiATEl71ew6h+clMjudIb3D7fzBicSGXYQT9nNLkGh2ikwnznx29x12o8ivQp4ua1Xg7U
	 zjnvo8nteWCktHmdgROQzPbZUCiZ5Zm8BNwgUhCaRi/wcweA2eBVN3L4YeM+zWVWOaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZBQLeUFC+EGxTcD0YG8dcZStfxcjShj56XwSxsyD+4E=;
	b=R+KQhw++VZfetNcR4t4wjW4a8PSI6CgUq36NaZkhxWlUxvVHZ+ECBGz5YFHNg7FXKsbV
	 Zunjm8e7jhr9nzGYlxgjHjIr5zONjQR5c8Imtgw+fEwsh0nlX6SemEk+f3aWDFTtjSUjx
	 yZt67uZBwI4GV613f29jPkCFPjUVLd1iB1VH5vrKBV2NMlzydGS1FGyRKzchypdT9qQNX
	 59Y4WKdI5Bee5+Rts6jHY2fFIyKaIA5uQWc2yWFaWO/3gHjZd/GvgGo/7U0qqtAFBg/yC
	 luv5Ib3yeYKdx/zf2D4KFqHMGTrKj6GNLbmz08Y86A2F3qo/1jM8y26rUXDa2cRc5Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpThBKW6;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E9606A33F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8E9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpThBKW6
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a3705ea6ccso258454f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795021805; x=1795626605; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBQLeUFC+EGxTcD0YG8dcZStfxcjShj56XwSxsyD+4E=;
        b=fpThBKW6Ucp49BkAtu1yrDrrmBmJ5XOsrJ3J/E85pZxxibX9Zt4awEOqQ9QF4LPsz2
         T3z6hepivAJ+jqk9gl9aIMjGOX9+NNNNznXXtPmICPppdEcNEShd+Tl3+cv+jh2XJint
         5iE8zxkvaCzz5RmZwCWXcQQypQaWR60qBSEZc8AEhBfyz/yvGbR8WVmklkR9zwc4ziS9
         jPxVn+uWp/h6J24CWUmjFbshNBN+icTfsTGRJL/WoBEl0qxYU686icasrqrrMbOkafcG
         zIpjD71p7A3H9wWn6HWbCQXVP8BH0EDqUEWOoTQ9EtuqC8p+3Lw+iWOzL0eCQzfnUNRV
         NSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021805; x=1795626605;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBQLeUFC+EGxTcD0YG8dcZStfxcjShj56XwSxsyD+4E=;
        b=KWOT1YRH8BkEqbECsRc+LAGHaV/6V6oDulrdvdoiVI9Rxc0g3iIqFGYxBG49vPlqeD
         9YZiMet5o5DpCUR7nf4einrrbNx7QemqyiMd9UrDyMJldXS6iRQwisd3nHtBLdcCCH+C
         Z1C3XmpnY0nja9TCoIXJ+vgnzxZluX9yGiag/pS/Rxa+A7itDiEg0S2fOU8kUCpYyRhN
         0THnfBWWQ+2PPia2HO2GbqPuB9aBV2mX84Uh2sYq2DeN0ETpM+j8dBbciDrPaCAtSNHV
         YkCXwEL4mV4Zefuo+b5gLrAAsrLTMwa5//7kKVcF3fhxjMXX/ERrFqUOTCPkPraoQ7/x
         nE5g==
X-Forwarded-Encrypted: i=1; AL+hErE9J109mwctRboJ5HDio9KPZFLSEIjvNLdHcKNRXzvFc+hRhLGbY+GhMMMIdz9BHvMG0OM+d2A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rqsx2LYEbCnHTDnsjEN8HUJ1E9koDsuS0Ukj/00rKEzbxtjQb
	Y68JUtr3DPmj4vL557qZES1AusA+EiSXiGsWqn1VirLV7HWbhh6BdbbN8Y+LjF+pD73nazggnu3
	82EfnsBd4a1KYgR1HKA==
X-Received: from wrmy18.prod.google.com ([2002:adf:e6d2:0:b0:48e:8481:c6ad])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2210:b0:48f:d7cd:a5ac with SMTP id ffacd0b85a97d-4a62d6d4ca5mr7655574f8f.0.1795021804316;
 Wed, 18 Nov 2026 09:10:04 -0800 (PST)
Date: Wed, 18 Nov 2026 17:09:51 +0000
In-Reply-To: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4299; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=utE9D0DUrvzxak4uVxnykRd3EoPT8zB0LcKz7hGMs34=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/dvo0nIOWmUoYahY2hKEfcj5qkiNkVGFSyQY+
 Nzw6sJHkT+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCav3b6AAKCRAEWL7uWMY5
 RqNcD/9nMuAC9ogBuQ+g/67v1kbmFenSkpIBWciyy4iighlDS+WYaVya6OR4wOHbcA501p0jsAS
 G9eRzbRUma7y/lDNGAcH21acegjrMFDG4wIpCc+3K1SwTSCRw9udPAAgbSLuZsTTuC5OWpMaaJD
 JsO53Tf1oPjD/Bi/AQjxYfabEkDerQcO0lqGxh7HQ/9r/Pn1TnUz4pOAy393i6A+AOkUOGi/0If
 FQ5Fot3eWtXdA+BLsS0bJBZhnkpBdgvNj9f5bVe1LMNzZk2lJXHXKrpC0s81dSfjYIpyubFCgYG
 elpiusD3N9kNTgdO/+8wPCnS8nHa7FbjzS1EhuSZOVMvOaQUmEEEI9XrsRZJrCR4WrcRcov5T4V
 8tu8BznsK35tULFKkgvXjaIWShOo1yo/fyyYvE+xs3dCrBwTCNpSNlczyugia2tPZ1t2DcxZKKt
 /Xvm1sIfIB7E4qyxlvxq2SNtvUxYiKCDUkXxy4mPrzCGQktMyCbcU4YXh3BX59Cr71mJZBXaxeD
 rsd23Bdw3TtKmvl90D8VzTw5hGuiprT+nGiqRd33M647/pzbJBXDrkm/JkFcpLAbkJ+dI6o66BG
 BH1XnO6hq0f5c2dByxtSOcaREQ/sHtvNsFplRPCbfLTubji9HeO+kt3jDfl7qFs5z3mQf1UfM/J luL72X5xY4k9ONg==
X-Mailer: b4 0.14.3
Message-ID: <20261118-ordered-wq-cancel-v1-1-916e01f9affe@google.com>
Subject: [PATCH 1/2] workqueue: fix cancel_work_sync() on ordered workqueues
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, 
	"=?utf-8?q?Christian_K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

There is currently a scenario where cancel_work_sync() /
disable_work_sync() does not wait for the work to finish execution on an
ordered workqueue (__WQ_ORDERED). This is because ordered workqueues
contain multiple workqueues internally (pwqs). Consider the following
scenario:

1. @work starts executing on pwq A (pool A), the oldest and only
   unplugged pwq in wq->pwqs.
2. Writing a new cpumask to /sys/devices/virtual/workqueue/cpumask
   allocates a new dfl_pwq (pwq B, backed by pool B) with
   pwq->plugged = true and appends it to wq->pwqs behind pwq A.
3. While @work is still executing on pool A, it is re-queued to the same
   ordered workqueue. Unlike normal workqueues, __queue_work() skips
   last_pool redirection on ordered workqueues so re-queued items do not
   jump ahead of work already waiting on pwq B, so @work is placed on
   pwq B->inactive_works and work->data is overwritten to point to
   pwq B.
4. cancel_work_sync() or disable_work_sync() steals @work from pwq B,
   and try_to_grab_pending() records pwq B->pool->id (pool B) in
   work->data.
5. start_flush_work() only inspects the single pool recorded in
   work->data (pool B, where @work has never executed), finds no worker
   running @work, and returns while @work is still executing on pool A.

Unfortunately, this scenario can lead to UAF if a driver uses
cancel_work_sync() and then frees the work item (or resources used by
the work item). And this happens on ordered workqueues in practice:

- drm/sched: drm_sched_wqueue_stop() calling cancel_work_sync() on
  work_run_job and work_free_job before scheduler teardown.
- drm/xe: gt_worker_disable() calling disable_work_sync() on
  gt->reset.worker and gt->wedge.worker.
- drm/panthor: panthor_device_suspend() calling cancel_work_sync() on
  ptdev->reset.work before suspending hardware.

Thus, fix try_to_grab_pending() to record the pool of the oldest pwq in
wq->pwqs when stealing a pending work item from an ordered workqueue, so
start_flush_work() flushes pool A and waits for @work to finish. If
@work is not actually executing on pool A, find_worker_executing_work()
simply returns NULL.

It is also needed for the soundness of the upcoming Rust ScopedWork
abstraction, which binds a work item to a single workqueue and relies on
cancel_work_sync() in Drop to guarantee that data borrowed by the work
item is no longer accessed once drop() returns.

Cc: stable@vger.kernel.org
Fixes: 58629d4871e8 ("workqueue: Always queue work items to the newest PWQ for order workqueues")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 kernel/workqueue.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index af845214e78b..d7acedfb8b27 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2263,6 +2263,7 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 	pwq = get_work_pwq(work);
 	if (pwq && pwq->pool == pool) {
 		unsigned long work_data = *work_data_bits(work);
+		struct worker_pool *offq_pool = pool;
 
 		debug_work_deactivate(work);
 
@@ -2288,9 +2289,24 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 		/*
 		 * work->data points to pwq iff queued. Let's point to pool. As
 		 * this destroys work->data needed by the next step, stash it.
+		 *
+		 * For ordered workqueues, __queue_work() skips last_pool
+		 * redirection so @pwq may be plugged while @work is still
+		 * executing on the oldest pwq after a cpumask update. Only the
+		 * oldest pwq is unplugged and can be executing @work, so record
+		 * its pool instead.
 		 */
-		set_work_pool_and_keep_pending(work, pool->id,
-					       pool_offq_flags(pool));
+		if (unlikely(pwq->wq->flags & __WQ_ORDERED)) {
+			struct pool_workqueue *oldest_pwq =
+				list_first_or_null_rcu(&pwq->wq->pwqs,
+						       struct pool_workqueue,
+						       pwqs_node);
+
+			if (oldest_pwq)
+				offq_pool = oldest_pwq->pool;
+		}
+		set_work_pool_and_keep_pending(work, offq_pool->id,
+					       pool_offq_flags(offq_pool));
 
 		/* must be the last step, see the function comment */
 		pwq_dec_nr_in_flight(pwq, work_data);

-- 
2.56.1.703.gf848ed807c-goog

