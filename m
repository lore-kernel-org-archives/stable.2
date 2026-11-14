Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644437;
	b=W2vmz+YFCk94jA78VtsVxmJ/cwZZ1AgBDlERNSKObDoamJsKToA40yg/pW5g7p5E+3t4
	 JgczZJHuVzfrh7NXJNRDA/UVSsdCN9x36vUkXw1uG0mR5zuS34O0tfjwULoDn+3FmMkyJ
	 gfPTCOCbhtdhgAF2ReAyzNmOShquhRQTv17vfHBvzfA95eWn3twGMh0/j+FWXW6pOTPhn
	 vNAH/ATYrWN05zzHjptQqwQKR2T3cASJZsrFy2k1CX4tS36moYfdtDaViz34pgGn9bhNE
	 yDxNfpzor8x5yzISiwYPHiVA6DbBkutg9jGC/odnH12sGTwe2v0NhQL/EjHQu7Ov00Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5+RlFqufX4xhL1zOaDcekPTcuiYRW3XbXJOszvYL5u4=;
	b=UQ8C8CfHVOYbXkrKgpQgHIi/Wr38Sw0hhk1sYMVff0sZYeMJeBB1DnsRD+8hMRYajAUl
	 C0U1WrVAIC8ntgKAgXyfLmTDzEtghCbw2W9npHHhDUajVUxpHqaAa2zRRXcF5Z2iZ7QzV
	 I3Gac+WL68uxOdBS7RjI4eX2eKoz46z1pjkd3C6eKetUIHr09TBK2PC24xgfD/BPujvxJ
	 RAPRp23vqc2Kvy1hGtliS4qBOhzvhoMh70bNGfIYP3fPUiDQVBHDoPFNDMwcKe/afSYD6
	 HXwNvVFcg6p5UCtDsJ8oiSJPWV/eqMUCQNOSIo7tPktHJ2Ti5d8waPjfnORkFyjs35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vH/6r+/V";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F338606A881
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F338606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vH/6r+/V
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-376a4059061so198263eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 00:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644437; x=1795249237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+RlFqufX4xhL1zOaDcekPTcuiYRW3XbXJOszvYL5u4=;
        b=vH/6r+/VYczRb5vbGj7sljclqqrqvD79C7Q5/g4rfRoKTUmhVwEGcsLlwIfqfiR7Td
         T+TRJPkYXjH/kgBvgkmU+UnAvreR2lW2paQ3iUTIeqlnBnPQdRB5QgfNkBbEYZB42fyE
         XAxY8Ih6kWxk5QklHArBm7g/lzS+Af9/ItfowcZ/yvq9p/ktt8xCa5oaWlnvbXgKu/jp
         9k/hBh1mtRCJfgHJXyDA6CTFvgGgPEmFETTaoIOQqxCIrpUgpiZe2ILH63w/6K1LvPNX
         6KlJHDbAYIsaQk+jHahrUEqui6b9BeWhZAkCXcAxLvrPRmtEMA2FV2ZKWInQVh+muiGa
         Uchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644437; x=1795249237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+RlFqufX4xhL1zOaDcekPTcuiYRW3XbXJOszvYL5u4=;
        b=AtgIIl3cjCWVF9tTCAyKS82+/jOMZpteGUaQD0iQ+dn5xPsiP0pN0M+a/eaQ7vGPEc
         VaRM5nfPY1czUCCRUmskPzfdZOH671Fi20aElkvYLjV/0JAr7uzE0DECsymsxmsPuHEJ
         n/h2QGZHrVTKNuzs4pS/6kW4W5568fahX5vEgI5mHkvKlZ9YswanNAFWRpCuQpYE4f2M
         yq8ppmhX7L9tKhgtnnDaxybDgnzNAB7+zkK+NoudT5BgbHzBBzBqV/UfVxRVhGoG1UZq
         lV1/ouSoPzUmyUZY49qgcqHvsjIZ0ZylLwNLDK4FwJ9O1xm+lX+XLOQ3w/7TsCaaPIQq
         WJWw==
X-Forwarded-Encrypted: i=1; AL+hErEUlnSS2qfSDDSub5AJ8F5qCcQL0t1ABp1i8XmO7DikCDh/ogn1xlEGDp0an/ELOB9b7MyGUy8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ce8kXOfjjm+TrZ/6UiIzGOM3WN4mOAtfySkF676e7n0OyE+fx
	pa8fWnM8WIFpDcVUbwAEQ5Wcr+pQ5nYHGXG1x23etgdQ7uurvgGdM6+a
X-Gm-Gg: AYBFou0p7C4atDA/PhA9KbFnZp3RSMq14ZOu2QN/cIDaTdjzro/7SkXxgyLGvOvju3P
	aFzIugcM3obLXUfN/TdbgnD2ihZNiS2kxIe63RxmXzNFJYe2323fnc4D9IZhwTcEXsghbrddO80
	kQ+H9C56iCZ7/qmQ3RFkd+Y2nQFC4Oo0noYXIeYgpDLrkNstb1Wi64ZEm9Aga5n5N3blFmQuPKd
	FBuq1sMziGWp6BlsB+vpYdNFp83MPnRIgL1+8vngl0Q6jr9xDtgm3Iqt2j90nY74IvyBqdVqPxy
	dVmmometTukEaTU3NTO9aKNucTrbP/hB7sjz3jdtsItzUGPnKXvhniJMzDAKZKjHejUSjSm1byu
	9RgOMCJTZ2vs9dIqgM132sEidRCeiHEFjqiApSKJBI9eYenyjfcDrLLLlNO4Woaw1MlyFLv0KIV
	BlJug1gpsGbqO6XA0YusRb486qfklyNShC4EvwP68esuG2Msj7ahylxBiq6/oKvetGPeNfVgOqO
	eCW4XlKScDZpXsGLqfZr0SnR56zI4HZCyDFZpqYAnkevpYp2XFyIzZwsbZDoVuKswsXS1HSS0Rr
	zbpfsY/LHOZZzr9RWQTkLCjwjfCKnNsu8P4HX+MhYpR7O2E51eP31OVJRpG+ODeR0Ef6wXYeJ48
	1f5A=
X-Received: by 2002:a05:7300:7481:b0:36d:cd5d:d809 with SMTP id 5a478bee46e88-37964ff2d6emr9742335eec.1.1794644436617;
        Sat, 14 Nov 2026 00:20:36 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:20:35 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] drm/panfrost: Stop a job queued after its JM context was destroyed
Date: Sat, 14 Nov 2026 17:20:15 +0900
Message-ID: <20261114082016.2454-4-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114082016.2454-1-arpe1618@gmail.com>
References: <20261114082016.2454-1-arpe1618@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panfrost_jm_ctx_destroy(), which runs on JM_CTX_DESTROY and when the
file is closed, sets jm_ctx->destroyed and then stops the jobs of the
context that it finds in pfdev->jobs[]. panfrost_job_run() checks the
flag once, without any lock, and panfrost_job_hw_submit() can then
sleep in pm_runtime_get_sync() before it queues the job in
pfdev->jobs[] under job_lock. A job that is between the check and the
queueing when its context is destroyed is therefore neither cancelled
nor stopped, and can then be started after its context, and possibly
its file, are gone. With profiling enabled, its engine_usage also still
points into the panfrost_file_priv that panfrost_postclose() frees, and
panfrost_dequeue_job() writes to it when the job completes.

Before commit 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for
manging job resources"), the close path called
drm_sched_entity_destroy(), which waits for a run_job() call in
progress on the entity, before it looked for the jobs to stop. The
entities are now only destroyed when the last reference to the context
is dropped.

Move the per-job part of panfrost_jm_ctx_destroy() into a helper, and
call it from panfrost_job_hw_submit() on the job it has just queued if
the context has been destroyed by then. The check in
panfrost_job_hw_submit() and the loop in panfrost_jm_ctx_destroy() both
run under job_lock, and panfrost_jm_ctx_destroy() sets the flag before
it takes the lock, so with the previous patch, such a job is either
found by panfrost_jm_ctx_destroy() or sees the flag, and it then goes
through the same stop and completion path in both cases. Cancelling the
job in panfrost_job_hw_submit() instead would leave a gap in the fence
seqnos of the slot, which the job chain flags rely on. Use READ_ONCE()
and WRITE_ONCE() for the flag, as it is written outside job_lock and
read without it in panfrost_job_run().

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for manging job resources")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
panfrost_stop_job() is the loop body of panfrost_jm_ctx_destroy() moved
into a helper unchanged, apart from the lockdep assertion.

When the job is in subslot 0, the hard stop is written right after
JS_COMMAND_NEXT=START, as panfrost_jm_ctx_destroy() can already do for
a job it finds just after it was started. Whether the job manager can
miss a stop that early could not be checked on hardware.

Arun Iyengar's "Resume long jobs instead of resetting" series also
changes panfrost_job_hw_submit(); this patch does not depend on it:
https://lore.kernel.org/r/20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com

 drivers/gpu/drm/panfrost/panfrost_job.c | 68 ++++++++++++++++---------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7a3137dacb9d..0dbed7a50910 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -202,6 +202,37 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
 	return 1;
 }
 
+/* Stop a job of a destroyed JM context, found in pfdev->jobs[slot][subslot]. */
+static void panfrost_stop_job(struct panfrost_device *pfdev, int slot,
+			      unsigned int subslot, struct panfrost_job *job)
+{
+	u32 cmd;
+
+	lockdep_assert_held(&pfdev->js->job_lock);
+
+	if (subslot == 1) {
+		/* Try to cancel the job before it starts */
+		job_write(pfdev, JS_COMMAND_NEXT(slot), JS_COMMAND_NOP);
+		/* Reset the job head so it doesn't get restarted if
+		 * the job in the first slot failed.
+		 */
+		job->jc = 0;
+	}
+
+	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_JOBCHAIN_DISAMBIGUATION)) {
+		cmd = panfrost_get_job_chain_flag(job) ?
+		      JS_COMMAND_HARD_STOP_1 :
+		      JS_COMMAND_HARD_STOP_0;
+	} else {
+		cmd = JS_COMMAND_HARD_STOP;
+	}
+
+	job_write(pfdev, JS_COMMAND(slot), cmd);
+
+	/* Jobs can outlive their file context */
+	job->engine_usage = NULL;
+}
+
 static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
@@ -272,6 +303,16 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 			"JS: Submitting atom %p to js[%d][%d] with head=0x%llx AS %d",
 			job, js, subslot, jc_head, cfg & 0xf);
 	}
+
+	/*
+	 * panfrost_jm_ctx_destroy() only stops the jobs it finds in
+	 * pfdev->jobs[], so stop this one here if its context was destroyed
+	 * while we were getting here, e.g. while waiting for the GPU to
+	 * resume. job_lock orders this against panfrost_jm_ctx_destroy().
+	 */
+	if (READ_ONCE(job->ctx->destroyed))
+		panfrost_stop_job(pfdev, js, subslot, job);
+
 	spin_unlock(&pfdev->js->job_lock);
 
 	return 0;
@@ -404,7 +445,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence = NULL;
 	int ret;
 
-	if (job->ctx->destroyed)
+	if (READ_ONCE(job->ctx->destroyed))
 		return ERR_PTR(-ECANCELED);
 
 	if (unlikely(job->base.s_fence->finished.error))
@@ -1100,14 +1141,13 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 	if (!jm_ctx)
 		return -EINVAL;
 
-	jm_ctx->destroyed = true;
+	WRITE_ONCE(jm_ctx->destroyed, true);
 
 	/* Kill in-flight jobs */
 	spin_lock(&pfdev->js->job_lock);
 	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slot_entity); i++) {
 		for (int j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
 			struct panfrost_job *job = pfdev->jobs[i][j];
-			u32 cmd;
 
 			/*
 			 * The scheduler clears job->base.entity when it pops the
@@ -1116,27 +1156,7 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 			if (!job || job->ctx != jm_ctx)
 				continue;
 
-			if (j == 1) {
-				/* Try to cancel the job before it starts */
-				job_write(pfdev, JS_COMMAND_NEXT(i), JS_COMMAND_NOP);
-				/* Reset the job head so it doesn't get restarted if
-				 * the job in the first slot failed.
-				 */
-				job->jc = 0;
-			}
-
-			if (panfrost_has_hw_feature(pfdev, HW_FEATURE_JOBCHAIN_DISAMBIGUATION)) {
-				cmd = panfrost_get_job_chain_flag(job) ?
-				      JS_COMMAND_HARD_STOP_1 :
-				      JS_COMMAND_HARD_STOP_0;
-			} else {
-				cmd = JS_COMMAND_HARD_STOP;
-			}
-
-			job_write(pfdev, JS_COMMAND(i), cmd);
-
-			/* Jobs can outlive their file context */
-			job->engine_usage = NULL;
+			panfrost_stop_job(pfdev, i, j, job);
 		}
 	}
 	spin_unlock(&pfdev->js->job_lock);
-- 
2.43.0

