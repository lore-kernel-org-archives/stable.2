Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795854481;
	b=mI1nMomJrdz+RTm5ilvK/h3WtG29KgzXEqbvKcwHmApzHKnKgpKDOx4Ig/9vqVtgv0hc
	 8gQPV0iU0daB0s4H+/iNHKIHwtzeTB8iMcfSQbF5r09bqmAFPAWBmBvxyJ+rwNalyIDab
	 z2nwAh3UN1aamtAzp/YCrUV0etMnHxEdGfzxx/SO9E4FV6jGTlwHcC/vhqXkRvOD6klTQ
	 0YRoP5kU33KKdUeFmcnOgvk1HPoJm/PAeFem7mS4LIJZgPfQXMVl4u1xdMIpJTl3udWJs
	 r/NpMH6h4ESXm3zRsJnw05mB+LZtAm0k3GOOmQiSue7GbwrkwBBbUS8VqXSMfc6F5sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795854481;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=eWOtYyvFjAz6pp2c8GfRiAyYtqMIExJFiM1D9vtmH+w=;
	b=YL157frSrTcuVGr6xmrioatqAJiNcAYsuRc+m7qxqJvAzdGtoiSR+K+IWVx+Q0Bxbv6b
	 /5+qAmRnoCp9+m02aQkE+sEpGGFoP6zGbC7MKVKzqq2Ocbbu+RO2tBgQLIqd2KWpE4hJC
	 +nPJyz2t0F69jto/SuwygxdP4prrGGTYCclZFsDwF98vt1L4f8C+vKUbiWZzTP3/mtdS7
	 Z6lJZ3udTE6Q/DktdywspjiVMWJf3DBDn8hFXR8/jZvgbicAXGTQgLdxq7dNMsiq/NvsV
	 jegXlA7ju8JmvEB4ZUdLBa2qpobXotVghx5qo6JYXaj4MiubwiO7nmQJKFEgaMp5uIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=aOKBJJL9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DC606A31C;
	Sat, 28 Nov 2026 08:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB7DC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=aOKBJJL9
ARC-Seal: i=1; a=rsa-sha256; t=1795854459; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lge2V1phD4GvM4gQNB8EGK7dF7ynTy2agpPqUcb1/lNKxUXH9y9xNedU/Pfi9zRYJKymsFWsPNkSHuAoFbpfUzWvC+16K7/VeUgdAw6DkglmBZeyegwdhgPtJR1Wh8cPKbaKHEoHmrmGER5YIIXMjJXOQ0ya+R9dgRFlGG5Ibkg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795854459; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eWOtYyvFjAz6pp2c8GfRiAyYtqMIExJFiM1D9vtmH+w=; 
	b=dzTEpYfKssUTQtUU2BScP5VlOQwhmEApCQ1RBo4LRSkLQQe2rcAkVuWo2c9mwZeOMGNxnOuYDtpqAkXtHIrJnr40Gd60GTwgEo1WtWKeBroz0nTOpIny+dgTv+K4tgi2NKB3kYuUaseSw0oOV8tHfMiB49DF7AUKHu4LWQct9sU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=aOKBJJL9WEa0777gV9mFC04irkZOzoLx63WhnmTojZtyJW8wV69m2ULPbupODrLl9+NOLTLTrPyTgHI2xvBmKlzRp4UQyoqJkJ2U/6+KCrlis3VuXdqvrtRbZcS5y9bE2kmrk9ziTnhl3psZwudSY3+iFbqfUoRIDhYN469iZSs=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=eWOtYyvFjAz6pp2c8GfRiAyYtqMIExJFiM1D9vtmH+w=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795854456395164.46153556574347;
	Sat, 28 Nov 2026 00:27:36 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 28 Nov 2026 09:27:07 +0100
Subject: [PATCH] drm/sched: Sanitise wqueue_start/wqueue_stop/is_stopped
 interleavings
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-drm-sched-fini-race-v1-1-9803ee8aa8b4@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNwQ6CMBBEf4Xs2Y22Jqj8iuHQbhdZk4J2izEh/
 LtF9DYvmXkzg3ISVmiqGRK/RGUcCphdBdS74cYooTDYg62NsUcMKaJSzwE7GQSTI8YLmWDd2Xt
 /qqEsH4k7eX+t13ZjnfydKa+qXyPxcyp3eauBd8pIY4ySm2o9iaK0/wfcfO2yfAC6GHh5sgAAA
 A==
X-Change-ID: 20261123-drm-sched-fini-race-9c1d2a8bbb76
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luben Tuikov <luben.tuikov@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, stable@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2

drm_sched_wqueue_stop() will WRITE_ONCE 1 to the sched's pause_submit
member. This member is checked (with READ_ONCE) in every
drm_sched_run_job_queue() and drm_sched_run_free_queue() invocation,
which is how the two work items drm_sched_wqueue_stop() cancels would
usually get re-armed.

However, this is of little consequence on SMP systems, where the effect
of WRITE_ONCE is not guaranteed to be ordered with READ_ONCE calls on
other CPUs. As a consequence, during drm_sched_fini(), a work item may
become re-armed after its call to drm_sched_wqueue_stop(), and run into
a sched->sched_rq that is now NULL, dereferencing a NULL pointer.

To fix this, add a pause_lock mutex which prevents queue starts and
stops from interleaving. This lock also guarantees that the wqueue
remains stopped during the drm_sched_fini() teardown.

Additionally, use disable_work_sync during wqueue stopping to ensure
that no previously stopped work item can be re-queued during the process
of stopping the wqueue. work_tdr in drm_sched_fini() is also disabled
rather than cancelled, so that no stray work timeouts can trigger
anything of concern during teardown.

Finally, use the smp stores/loads to set and read the pause_submit
member, so that drm_sched_is_stopped() will observe the results of a
start or stop operation in a properly ordered fashion, so that drivers
which use this function don't need to worry about unexpected
interleavings.

The drm_sched_run_job_queue() and drm_sched_run_free_queue() functions
consequently no longer need the (racey) drm_sched_is_stopped() check, as
the work disabling achieves this in an atomic manner immune to TOCTOU
bugs.

Fixes: a6149f039369 ("drm/sched: Convert drm scheduler to use a work queue rather than kthread")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
We've been told of a NULL pointer deref stack trace in
drm_sched_run_job_work() on systems running panthor during teardown of a
GPU context. The affected customer reported that by disabling the work
items in drm_sched_fini(), rather than cancelling them through
drm_sched_wqueue_stop(), the crash would go away. The reason was that a
job could persist beyond the wqueue_stop, since they can be re-armed by
one of the other work items being processed on a different CPU.

Upon looking at the code I realised that drm_sched_wqueue_stop() was
actually broken in several subtle ways that go beyond just changing
which function of the workqueue APIs should be used.

While I was tempted to get rid of drm_sched_is_stopped(), several
drivers do use it. I think it's a potential TOCTOU footgun unless the
driver itself makes sure that no start/stop is issued between the check
and the code that is subsequently run to act on its result. But now it's
at least sequentially consistent as well.
---
 drivers/gpu/drm/scheduler/sched_main.c | 52 +++++++++++++++++++++++++++-------
 include/drm/gpu_scheduler.h            |  1 +
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 99252674e266..4662f024ad88 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -138,8 +138,7 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
  */
 static void drm_sched_run_job_queue(struct drm_gpu_scheduler *sched)
 {
-	if (!drm_sched_is_stopped(sched))
-		queue_work(sched->submit_wq, &sched->work_run_job);
+	queue_work(sched->submit_wq, &sched->work_run_job);
 }
 
 /**
@@ -148,8 +147,7 @@ static void drm_sched_run_job_queue(struct drm_gpu_scheduler *sched)
  */
 static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 {
-	if (!drm_sched_is_stopped(sched))
-		queue_work(sched->submit_wq, &sched->work_free_job);
+	queue_work(sched->submit_wq, &sched->work_free_job);
 }
 
 /**
@@ -1153,6 +1151,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	init_waitqueue_head(&sched->job_scheduled);
 	INIT_LIST_HEAD(&sched->pending_list);
 	spin_lock_init(&sched->job_list_lock);
+	mutex_init(&sched->pause_lock);
 	atomic_set(&sched->credit_count, 0);
 	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
 	INIT_WORK(&sched->work_run_job, drm_sched_run_job_work);
@@ -1190,6 +1189,20 @@ static void drm_sched_cancel_remaining_jobs(struct drm_gpu_scheduler *sched)
 	}
 }
 
+static void drm_sched_wqueue_stop_locked(struct drm_gpu_scheduler *sched)
+{
+	lockdep_assert_held(&sched->pause_lock);
+
+	disable_work_sync(&sched->work_run_job);
+	disable_work_sync(&sched->work_free_job);
+
+	/*
+	 * Anything that observes pause_submit will also want to see the effects
+	 * of any of the previous memory operations.
+	 */
+	smp_store_release(&sched->pause_submit, true);
+}
+
 /**
  * drm_sched_fini - Destroy a gpu scheduler
  *
@@ -1212,13 +1225,15 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
 	int i;
 
-	drm_sched_wqueue_stop(sched);
+	/* Guarantee queue is paused for the entirety of the teardown */
+	guard(mutex)(&sched->pause_lock);
+	drm_sched_wqueue_stop_locked(sched);
 
 	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
 	wake_up_all(&sched->job_scheduled);
 
 	/* Confirm no work left behind accessing device structures */
-	cancel_delayed_work_sync(&sched->work_tdr);
+	disable_delayed_work_sync(&sched->work_tdr);
 
 	/* Avoid memory leaks if supported by the driver. */
 	if (sched->ops->cancel_job)
@@ -1303,9 +1318,9 @@ EXPORT_SYMBOL(drm_sched_wqueue_ready);
  */
 void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched)
 {
-	WRITE_ONCE(sched->pause_submit, true);
-	cancel_work_sync(&sched->work_run_job);
-	cancel_work_sync(&sched->work_free_job);
+	guard(mutex)(&sched->pause_lock);
+
+	drm_sched_wqueue_stop_locked(sched);
 }
 EXPORT_SYMBOL(drm_sched_wqueue_stop);
 
@@ -1320,9 +1335,19 @@ EXPORT_SYMBOL(drm_sched_wqueue_stop);
  */
 void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched)
 {
-	WRITE_ONCE(sched->pause_submit, false);
+	guard(mutex)(&sched->pause_lock);
+
+	enable_work(&sched->work_run_job);
+	enable_work(&sched->work_free_job);
+
 	queue_work(sched->submit_wq, &sched->work_run_job);
 	queue_work(sched->submit_wq, &sched->work_free_job);
+
+	/*
+	 * Anything that observes pause_submit will also want to see the effects
+	 * of any of the previous memory operations.
+	 */
+	smp_store_release(&sched->pause_submit, false);
 }
 EXPORT_SYMBOL(drm_sched_wqueue_start);
 
@@ -1334,7 +1359,12 @@ EXPORT_SYMBOL(drm_sched_wqueue_start);
  */
 bool drm_sched_is_stopped(struct drm_gpu_scheduler *sched)
 {
-	return READ_ONCE(sched->pause_submit);
+	/*
+	 * Ensure drm_sched_wqueue_{stop,start}() && drm_sched_is_stopped()
+	 * gives a consistent view to any observer that ensures no concurrent
+	 * starting or stopping operation is ongoing.
+	 */
+	return smp_load_acquire(&sched->pause_submit);
 }
 EXPORT_SYMBOL(drm_sched_is_stopped);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 3b0978fa8cf0..259960fd584a 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -627,6 +627,7 @@ struct drm_gpu_scheduler {
 	bool				free_guilty;
 	bool				pause_submit;
 	bool				own_submit_wq;
+	struct mutex			pause_lock;
 	struct device			*dev;
 };
 

---
base-commit: bf57105b00e32d37b666c029c8c6b8708391da20
change-id: 20261123-drm-sched-fini-race-9c1d2a8bbb76

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

