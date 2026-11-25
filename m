Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649302;
	b=IgATrCkpMnxJXI2w7XLc6mF83nnH6fNHWnNwvUxvLLasJYjqsB4cXM6SeWEtsu79mm/A
	 ZsSR+cmx5wY4fO/0CvJtYnVjRz5KgSKZSpOMAfrB/0kq2kvROiEO/2HeWq5fmfi8RYll3
	 SR5b0jIvv1ncsGT/Ygypb8goS+Bh+MkzlURPi82I6NjSwIOoiAjqQL5AdtAJ4mklDkbvt
	 vtfO/hgKD8bxOaBKmpwviyfqR8sbor2KeuN90OqkxyBJzUaogVWE6oX1gLLsvhpW43UnE
	 4RSX3gkXCI3vpSlzDAPP+NlqTc0Dn4nYNxP0aIpJKfvzg41D3OPG8Sbg4mIH+tEPcoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ovv+Ak+qjMJDWOioiOck50/6AvWOLnchdDFocICeClo=;
	b=X52FrqTrAw78TEVaLirUm/YkyRPVVDm6buu6TcH8J/lW1JfC0In2j8fEsA7NYBuZfiPf
	 Vw4U5ltj1LM4WvMhBRTw42xoyCK5zXb0JOQ6wifSP65AGASJOAh+3qFi5wzn5dd3XjGdh
	 LvXiJfqE5YOYBGQi0JStNQxsKyGJnfCS/1vXukZ8dGUIAp1HyyF5A3uiJlKfcyZtlIUPJ
	 EV3gILLvjOcvCz326HFOcKAVYLLxlP1Pnnlh81mgE0tKUU/0jD9GpoGBXRR93vCKO3LEG
	 4lJJOmP9h0ZwhaWXcPDRtzH5m9hmpNkRC+kc3eoEJ6+tmb/vAugEeEIUZhMtVE6pVng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZpsddOf5;
	arc=none smtp.remote-ip=74.125.231.73
Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD31606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDD31606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZpsddOf5
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-4abbe52a747so2558576fac.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649301; x=1796254101; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ovv+Ak+qjMJDWOioiOck50/6AvWOLnchdDFocICeClo=;
        b=ZpsddOf53IQX6srQpfozpuxvzPNZQCRhKTjan5JHy/IUxNUKWHnXMusz+24Qg1nU1y
         L4+dnFm7khVsDknxQyUnOFxVrzCI2n7m3ckIvCf6PIrK1oGVy0MOIvu5MLXFrLeeRcJP
         q5SMJEVJNytw9tl/FmkHixVmMGXMlEsdSkTvfYehG0+hExLAc6UU5aJBEgyxwjlWXYmd
         lNBNpwn0HvJDzMTfFgdi+xr0wGUFB+PQaBJFwniQd8LFjs3H6glhLKlvc5CMlQ4dNpmS
         XgB3AhDYJ3PCAFvEOjTZ12sgKNGDKyBpPSuS24VcUDJj/fHEv/8hzw9EmXVlpO+oA70L
         3kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649301; x=1796254101;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ovv+Ak+qjMJDWOioiOck50/6AvWOLnchdDFocICeClo=;
        b=yWeuXPZ0HPnOuZQwU4BMcy+97k5Tmu8RzM18oQ/KS3xV+BjIumF5TK/hEZUahoXO8J
         0DCexhZ8kN9FUFB23B1PZ3oaRDPbQt7RRB4VaYG9U8Z1AmAPgGUSI/aCsAuDxi61u+3O
         7HiWmIHb60fdrzhX5QC0NdaAroPgnA2tVMZtnjBVgAL/N21s0PS11FJsIj8uA330K9fD
         kVHn4H7mp1UVXldJr+16cxdvCCW6C6Tw+YBIEA/gMwka41l8XOg/kRxPKdCKDBbOzX+B
         yDL7Z7g99fcQzB40aJ1u1PdlIrB6cbetQSNArosInCA5IEqGIB38gEhH8JT3jv+G75Nz
         W34g==
X-Forwarded-Encrypted: i=1; AL+hErGRGXH6+NCeobkAkAIiKxEwB+2maH/fE+Zm/g62IEyqw2umnoyA8YfaJFw4vX78dgyXvxr3ya0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+k2IWHtGUv75JA5U1shuoezVgfA564yuBYXkbfCnCF47mK7mqf
	V4u5MF2dKduJmcuP7tlW5egZblRqiCvqZBPkSjqgRVuULvco/sMFL1Yv
X-Gm-Gg: AZFdTZfLKaxCnWtUMVf/EEqgIDKpXNhZO5q0JnyuMg8qoHnpqWvRMmvTF3+QiBWjgYc
	TDwq5psM/qMxPzcOWids+Q7k1Dhj8qtWUnHhBCYZb/pcX8CYF7OqdjY3h8gyRm4p+A56msESu+2
	xj1ujz3nB+hCyD9+If+M8CNpCL2WLB7nPODJuVUiCk7kFuvhTAv/CEeO7Wvaa06xFTNEG5yLRiX
	ClMpp2WG+cI8BxbAp9s8JAbINhEFWHmjalfFD4rXAQtrgnNwdohWpOOEqvLKXwXfV2nO/rwYjEv
	OxtnDA9wNBiJpexMy0nywM2a00jyTes4oyFVQhfyfJ9YSlE8P0HaaQ/FXbZjN2xnVVpiaRgOnwu
	hjyMPudOpt/EAo9qvu01f4IuDWYQJovoILmt7p+EuB3rkyw7f/k6aZYpzaHUNjePV1OmE1xbBAx
	/yzxNs/7EiO+QqcyG5f3SSb4Mtj+amZwmFj/cedtsQBxWtCaqskrS7CWJ+5MO01ONl0hwdJP1Cm
	1X282EpG8DGnRsEEo5cFMaK7xnJESYzrPVIdx/fcacKh6xPROWL9LlAraC1TiHEAro+qUq6V36d
	xxXl2JaeJHdOjeQIoqv+JfnTmp7t8N1nEt1SkoNUSchhhg+dNvju6NK+
X-Received: by 2002:a05:6871:7a5:b0:4a7:6dc:af65 with SMTP id 586e51a60fabf-4bc819a3d4emr17566750fac.10.1795649300468;
        Wed, 25 Nov 2026 15:28:20 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60891cf6sm19200748fac.13.2026.11.25.15.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:28:19 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 17:28:15 -0600
Subject: [PATCH] drm/imagination: Don't hold queues.lock across
 drm_sched_stop() on reset
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
Message-Id: <20261125-rbrue-suez-pvr-pre-reset-lock-v1-1-0207245c5109@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MWwqDQAwF0K0M+TbQBFthtlL64ePahhYdkiql4
 t4FzwLORgE3BOW0kWO1sHminKRK1L/a6Qm2gXIivehNRK/snS/gWPDnsjoXBzsCX/7M/ZuhQzM
 2bV2rCFWJimO03/nfH/t+AAUV5+RvAAAA
X-Change-ID: 20261125-rbrue-suez-pvr-pre-reset-lock-e2d7f7a44211
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Donald Robson <donald.robson@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795649297; l=7208;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=S+pNhDcaReZxyl1Bxd2KOdwf7VmM0eJ5d5VBCJCOPKg=;
 b=Tmk3qgOiSZlieOuGxpdAC+MHCXe01gYek4MKsy29TMIt5lBB8y7Loqf3v6BUwzadPhEd2Y328
 GR+yaZtEhPSDrY1hQGnbYh/UW/yblFDlAq8TuSoJXzc1WCuKcLexF6M
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

pvr_queue_device_pre_reset() calls drm_sched_stop() on every queue with
pvr_dev->queues.lock held. drm_sched_stop() waits for the scheduler's
run_job work, and that work takes queues.lock in
pvr_queue_update_active_state(). A hard reset that starts while a job is
being submitted therefore deadlocks: the reset and the queue stay stuck,
and lockdep reports the circular dependency.

Take a context reference on each queue under queues.lock, move the queues
to a list of their own, and stop them after dropping the lock, as the
timeout handler already does. A queue whose context is already being
released has no jobs left and is skipped. post_reset() starts the same
queues and drops the references from a work item, because the last
reference releases the context, which takes reset_sem while the reset
still holds it.

Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and scheduling")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260630095216.498D61F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Sashiko flagged this ABBA deadlock in June, in its review of the
drm_sched_entity_fini() fix, and I have hit it on an MT8173 tablet
(GX6250, BVNC 4.40.2.51), first through lockdep and once as a real hang.

Tested on that board with lockdep and a local debug hook that forces a
hard reset from the watchdog under glmark2, plus a 20 ms sleep in
run_job before it takes queues.lock to make the race certain. Without
this patch, the first forced reset gives lockdep's circular-dependency
report, the reset never completes, and the job timeout handler then
oopses on a NULL parent fence. With it, seven hard resets over two
boots (four forced, three that the watchdog started on its own) gave
no lockdep report and no hung task, and new GPU work ran correctly
afterwards.

This patch was developed with the help of an LLM.
---
 drivers/gpu/drm/imagination/pvr_device.h |  7 +++++
 drivers/gpu/drm/imagination/pvr_queue.c  | 50 +++++++++++++++++++++++++++-----
 drivers/gpu/drm/imagination/pvr_queue.h  | 13 +++++++++
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index c246122b4caf..f495ee9234e6 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -236,6 +236,13 @@ struct pvr_device {
 		/** @queues.lock: Lock protecting access to the active/idle
 		 *  lists. */
 		struct mutex lock;
+
+		/**
+		 * @queues.resetting: Queues stopped by a hard reset, linked by
+		 *  pvr_queue::reset_node. Only used with @reset_sem held for
+		 *  writing.
+		 */
+		struct list_head resetting;
 	} queues;
 
 	/**
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 34b826381aa2..56751c192ce6 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1242,6 +1242,23 @@ static void reg_state_init(void *cpu_ptr, void *priv)
 	}
 }
 
+static void pvr_queue_reset_put_work(struct work_struct *w)
+{
+	struct pvr_queue *queue = container_of(w, struct pvr_queue, reset_put_work);
+
+	pvr_context_put(queue->ctx);
+}
+
+static void pvr_queue_reset_hold(struct pvr_queue *queue, struct list_head *list)
+{
+	/* A put still pending from the last reset hands its reference over. */
+	if (!cancel_work(&queue->reset_put_work) &&
+	    !pvr_context_get_if_referenced(queue->ctx))
+		return;
+
+	list_add_tail(&queue->reset_node, list);
+}
+
 /**
  * pvr_queue_create() - Create a queue object.
  * @ctx: The context this queue will be attached to.
@@ -1375,6 +1392,9 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 	if (err)
 		goto err_sched_fini;
 
+	INIT_LIST_HEAD(&queue->reset_node);
+	INIT_WORK(&queue->reset_put_work, pvr_queue_reset_put_work);
+
 	mutex_lock(&pvr_dev->queues.lock);
 	list_add_tail(&queue->node, &pvr_dev->queues.idle);
 	mutex_unlock(&pvr_dev->queues.lock);
@@ -1402,26 +1422,39 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 
 void pvr_queue_device_pre_reset(struct pvr_device *pvr_dev)
 {
+	struct list_head *resetting = &pvr_dev->queues.resetting;
 	struct pvr_queue *queue;
 
+	lockdep_assert_held_write(&pvr_dev->reset_sem);
+
+	/*
+	 * drm_sched_stop() waits for the run_job work, which takes
+	 * queues.lock, so it can't be called with queues.lock held. Pin the
+	 * queues and stop them without it. A queue whose context is already
+	 * being released has no jobs left, so it needs no stopping.
+	 */
 	mutex_lock(&pvr_dev->queues.lock);
 	list_for_each_entry(queue, &pvr_dev->queues.idle, node)
-		pvr_queue_stop(queue, NULL);
+		pvr_queue_reset_hold(queue, resetting);
 	list_for_each_entry(queue, &pvr_dev->queues.active, node)
-		pvr_queue_stop(queue, NULL);
+		pvr_queue_reset_hold(queue, resetting);
 	mutex_unlock(&pvr_dev->queues.lock);
+
+	list_for_each_entry(queue, resetting, reset_node)
+		pvr_queue_stop(queue, NULL);
 }
 
 void pvr_queue_device_post_reset(struct pvr_device *pvr_dev)
 {
-	struct pvr_queue *queue;
+	struct pvr_queue *queue, *tmp;
 
-	mutex_lock(&pvr_dev->queues.lock);
-	list_for_each_entry(queue, &pvr_dev->queues.active, node)
-		pvr_queue_start(queue);
-	list_for_each_entry(queue, &pvr_dev->queues.idle, node)
+	lockdep_assert_held_write(&pvr_dev->reset_sem);
+
+	list_for_each_entry_safe(queue, tmp, &pvr_dev->queues.resetting, reset_node) {
 		pvr_queue_start(queue);
-	mutex_unlock(&pvr_dev->queues.lock);
+		list_del_init(&queue->reset_node);
+		queue_work(pvr_dev->sched_wq, &queue->reset_put_work);
+	}
 }
 
 /**
@@ -1489,6 +1522,7 @@ int pvr_queue_device_init(struct pvr_device *pvr_dev)
 
 	INIT_LIST_HEAD(&pvr_dev->queues.active);
 	INIT_LIST_HEAD(&pvr_dev->queues.idle);
+	INIT_LIST_HEAD(&pvr_dev->queues.resetting);
 	err = drmm_mutex_init(from_pvr_device(pvr_dev), &pvr_dev->queues.lock);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/imagination/pvr_queue.h b/drivers/gpu/drm/imagination/pvr_queue.h
index 149cc6d124bf..d46e9bb7b4f8 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.h
+++ b/drivers/gpu/drm/imagination/pvr_queue.h
@@ -90,6 +90,19 @@ struct pvr_queue {
 	/** @node: Used to add the queue to the active/idle queue list. */
 	struct list_head node;
 
+	/**
+	 * @reset_node: Used to add the queue to pvr_device::queues::resetting
+	 * while a hard reset has it stopped. The queue holds a reference on
+	 * its context while it is on that list.
+	 */
+	struct list_head reset_node;
+
+	/**
+	 * @reset_put_work: Drops the context reference taken by a hard reset.
+	 * Context release can't run under pvr_device::reset_sem.
+	 */
+	struct work_struct reset_put_work;
+
 	/**
 	 * @in_flight_job_count: Number of jobs submitted to the CCCB that
 	 * have not been processed yet.

---
base-commit: 479e381e77dcde0dfcc9d51e89ff3273da199804
change-id: 20261125-rbrue-suez-pvr-pre-reset-lock-e2d7f7a44211

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

