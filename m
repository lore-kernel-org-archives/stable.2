Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637612;
	b=UymSlgjrfXsbswh1UHT+28+DIZYZXgJaNyCSooGRGIszMqdOyxBUcFUSsyczqDEiZb4e
	 cUWds2uqENXh8Xa+7Ez7jd/437P4dCj4OiCm0vo7aM2r2M6rhtmBkdKurG7EauMEBDAMy
	 Tk8QqcbVQ4ixDOwa2EYIwAgf5i+ZYFPN36Umu/hbFnsgdwTRlPRtiJglfgPKG4TF8itBm
	 qKPWDzU6KA3okg9s68/uI0Ah/2lH0X0LlUx2N9y/M+/447E2NKjHFck4NiQUUq8Z//F8P
	 osCw/ziACdqMBKi63Ky11DOI4YkFKG8+pQo2uGZdkl35rEnua/+W+bdIToaewCY83/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xUwUTar5g+YyZ0+0H60qrNboYluLL/4nAr406HnMeqA=;
	b=0ScyyK7HK7Pz6pQpsFwpLG9+Y+UpsKXtMiA09RMV1euNRR4gA02aJU6yjbf4RkTm2xDs
	 Spd9zohdJpbOt7d7byqkXFJTwEfaawXS6MYH+pihqlc8jUDUGOCmpBD8I6NweKXzDLiAt
	 ruRpxadTXUhsIKEflisYYX4FKpTfw/GXlP+2mn0m2QnA8PNZPty5so/hZgXPCIRR+c6NI
	 LkcAyznsUUfhW7FvXNjN9AnY2ymutcRuzOpvlKTcPz3WwI6yxUoBckKSDEPXTW624fpbj
	 nxzN1hTgsc+AUcGR8r5nU3gW46sjd47AAoD0f6wPaYOuA3MivXkSZNSS2QxlSIIGbFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKgk7qut;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F237606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F237606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKgk7qut
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bb5afa736so182022eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794637611; x=1795242411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUwUTar5g+YyZ0+0H60qrNboYluLL/4nAr406HnMeqA=;
        b=fKgk7qutwtVwcr0ip9gooczPCipZ7rT3mtfIqVk9V2VffIAQ4YvYoOGHXbsgqgYOQ0
         T5luUK2sPonEyO9Onz9p2t3nh0YHfEB7IkujILTAr6klr9aj1CtGRwPqrC3wCyyBdC3O
         md/WsfB0tVimH5uO1WfGQTZ0H5922eKk6Y6LvdrtYzzuvEkHAgxFFL5avk+R7SA/Vdih
         NtBf7xQPjl/vH1GbvmhNEuec9Zq6uOcHe2adJb618LiMpFgv6JABNlUW4rIQlXKrgwar
         kbnt7ZMXw9Zv3zDIqykKniPUnk8e8prCJorbB5XHJ4+zVK1gj+RmC+fMjRICYkdq06x9
         5zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794637611; x=1795242411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUwUTar5g+YyZ0+0H60qrNboYluLL/4nAr406HnMeqA=;
        b=a2an5t/6YyzJ19i1x4o62N3pqrFBWc/N+Nb36VAQzT7uEaHiIyT4P0S38LDIsEzZT9
         hz5UghjGbhN94dOtlKDf2bqLheKQJdI5Cgl7afKufIik9t78M8TvQgkUsuY/uejL6cpK
         mBrkGqSZrhHCJdwhasfoHRyPDSTou5FDttY8DVw0Iw3Jr1P2wpafUFOmkOoux6u3Ific
         dFzKx6nn/J/Zl2JLioBemDA6xy5zfLg8RxfZQTNepYeV/1T7jez8E4/lT2XXeDWgJrYQ
         U0LUMnfGyyVDwfgFBn0QWrLH1TEMLZoAYFCpqRiWNGTGk06lempueTv2A50bbWSMsIrw
         4bcQ==
X-Forwarded-Encrypted: i=1; AL+hErHq857PhqGJ7QmS8e1k/XGPEuNA2FTfMES6GzfxwrkEwBUZw9FvKyes36KVFOkyVP41g8ZxPeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z97YMqYP9xnlLkQaZLA5nwF/tNo2eSTINbILoAmFG8dWkbfb5iJ
	VkG6Bv7AsuieCGQ0BAbaoPhIbpIkqjkrHR6PMei9GW4cE7wE7Upt1j1WHdseJZWXcpk=
X-Gm-Gg: AYBFou1u2pqnFjM2hGvu6Dnn/zxAowaZvPdbkeQZCmY0vVBbAEZFwxGHLtA/FWbzJs4
	b8RakSCZ/RJCEYMt9zNWEfPua1A0PSbuNr6+vqTNlH7jCZYy9WG1sefqM+SnvadXeVhN5uEFrFu
	8gRW63tYjpMawvvm6wZ11gIJIbrHrwnErbChUuwkw2yXMFZTfhwCWSkHT5OargV5KhoevM9Igr4
	fznMW2ZkQqaHb+zkMaD81z4hntXV2zNghKbb5zQAapBSrj+rrPB4suJEaQthj2V9uxmJrmWj0fM
	VwyKqNX637Dp/TjYc87hauu/HPQXVwanqF8ApE2FiPovnrLqco1f9cXpcNfkY3uTCa70FjKDHBw
	ieS6D6u5wQejFy0DXdBbR1HHT6GrCo9YfdaXX4tadlizheOTwiJWF88qOJrxgj6q0/rm8Shuo/T
	KLjkpErKfXWYmco3kgWjpFjb0adhhLUmNA7kKleQqD/hOqFk+iIkANQ4GqQcAHjP82i7IRjzyYE
	Rz0XgE8Oe31t0rRSY1QiAzj8jySU/iAlPPYVrF6QzwOdR2KIEtUUNoGxRD7uWcpK3lTZ+yzGF4X
	8FOKgFbGTi3JspnH9+jpWGnQycEmo/5PPmiqcuIK4/PVNB9FQ1V955l1LGDpunOjtCg1kBF3wry
	qqN4=
X-Received: by 2002:a05:693c:3e0a:b0:377:d6e5:e642 with SMTP id 5a478bee46e88-379652e5215mr5982030eec.1.1794637611213;
        Fri, 13 Nov 2026 22:26:51 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955ffcbc9sm19762863eec.18.2026.11.13.22.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:26:50 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/panfrost: Stop a job queued after its JM context was destroyed
Date: Sat, 14 Nov 2026 15:26:37 +0900
Message-ID: <20261114062637.2447-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114062637.2447-1-arpe1618@gmail.com>
References: <20261114062637.2447-1-arpe1618@gmail.com>
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
it takes the lock, so such a job is either found by
panfrost_jm_ctx_destroy() or sees the flag, and it then goes through
the same stop and completion path in both cases. Cancelling the job in
panfrost_job_hw_submit() instead would leave a gap in the fence seqnos
of the slot, which the job chain flags rely on. Use READ_ONCE() and
WRITE_ONCE() for the flag, as it is written outside job_lock and read
without it in panfrost_job_run().

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for manging job resources")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
panfrost_stop_job() is the loop body of panfrost_jm_ctx_destroy() moved
into a helper unchanged, apart from the lockdep assertion.

Arun Iyengar's "Resume long jobs instead of resetting" series also
changes panfrost_job_hw_submit(); this patch does not depend on it:
https://lore.kernel.org/r/20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com

 drivers/gpu/drm/panfrost/panfrost_job.c | 68 ++++++++++++++++---------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7022b1b2e020..fbfdee42a4ae 100644
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
+	 * resume. Pairs with the WRITE_ONCE() in panfrost_jm_ctx_destroy().
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
@@ -1100,7 +1141,7 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 	if (!jm_ctx)
 		return -EINVAL;
 
-	jm_ctx->destroyed = true;
+	WRITE_ONCE(jm_ctx->destroyed, true);
 
 	/* Kill in-flight jobs */
 	spin_lock(&pfdev->js->job_lock);
@@ -1109,32 +1150,11 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 
 		for (int j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
 			struct panfrost_job *job = pfdev->jobs[i][j];
-			u32 cmd;
 
 			if (!job || job->base.entity != entity)
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

