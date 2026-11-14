Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644433;
	b=lbsuaqdWv2O9D5TGhStug8WSa2WL70qCp7PV3y6NiLVH3lWDCnn1JrMeA2xS5QgLvgZy
	 i0ITyMeY7bqnpTszhNLRcb3XWt47Ndn/Fff0CoSXLxj9RiQUrM+HTDxdVFrzRFRI/+hO3
	 tp7oTllg6G0OBSx1GeSRPcljj3CdJyegxizRmoEr22cS6DVophkopSjuUnlv7CBKEM1T0
	 ngpG1po5ADMcpW6UfYv0RhV0KQyYvM5Msr7OZffRID3Bw3s/KAHXigYvP/oLrn/A4jaqi
	 GBE5KRMvUAJbH97u2waTBHOhvtonfeBZl+ySiAo1ltIsCgee3V9UxPmT7NGmVrq/Guw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hp5f15bouPR2UtUnvKHkGzva3ieusdxkwfWzQA5rd1U=;
	b=vJlPWrGy0JEafTLG31LlARLGCdqyuS5jPNt1QSDYQ18FM9kXn6SD195DeA1rLQ5Jiyn3
	 pTcrar4IWwTg4vboICmxfdZMAm29gRwU16bciuZp77GKPbcdZOhbB5wsSzqhEifrj5fji
	 UQfRkqP+l2dyftlmId8emfJIal2RVQ4s5nMwk32lTonKFEtEEkdbcTpOzSsEOZg24chev
	 ccSgBKEBex7EYDbAJFdcnZXZKBk83yi+/9FDV1+UH5EVykxnRjgZ+XTi2OtPBii+FeGEE
	 DH0cED+mfUaIZOKOEaS1tgxDJw1hJmm/ybvUYlBCCe2GMvhs+LrcpzS4kIEBGYkC6JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ogL5Jhi/";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A73606A33B
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A73606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ogL5Jhi/
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36e90071735so287755eec.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 00:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644433; x=1795249233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hp5f15bouPR2UtUnvKHkGzva3ieusdxkwfWzQA5rd1U=;
        b=ogL5Jhi/GfHkxdTKHNOnIFtC6kkoCGd8driSM8hIkOSUwjby9siaUklWren0mcBsKf
         K+c6YEAkVLEKe829qoTWj71ZVZnBERVjC4GOSk0vVvP5A489MTRiLfLFGAdccHuzERnk
         7/pXEAhEg/48zrsAfTG333OGixsBNJJOwQ9pr73jt6SmwtKKLO7ukh65eFU+WjYvkDc3
         97G+7pwCJCE9wM5FJU3iwkOR7o8k6+07nMiMypmKzcJyMwmUMZgcZ5WTmsmmv4QRPuN3
         u0DfU4j8Dg0++ZN+7Gh21EV/jzSlv8CtjFI9tvytUjoqhqS+xfsuFWjc6eqYl/Dq/k52
         PX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644433; x=1795249233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hp5f15bouPR2UtUnvKHkGzva3ieusdxkwfWzQA5rd1U=;
        b=OgE7og/sIbhF7wHQf2F8l7Sb0bFU0VKzJZCPH1CXSQYkuPBu5uJ1WVTymsRJgx+W7G
         GDfzjadkZk8nHUaHsQGY7MLS5FRT9l0Zvx93dhP0Jr7dqCNoLaC/rF9sBbQwLjc3+5sf
         Et3kU5G8waJzMlsJjrhC0UhH77H+GeJkp5wowiuev7QwnmMIYWM6tK/+XwLsVks9Pa90
         I15y2gwUd1Ji6ernYsg635KETb51XbEur1XGebywRzAH1H2tvrxdA5z2vi5Z+SznXbqs
         kx0fIE1BLQsEF90oFtMwyBviHvootYSu0ujBtgB61iOoB/csjeBxqbdJ9jz/Fz53xNWv
         97uQ==
X-Forwarded-Encrypted: i=1; AL+hErHaXKiUNvTNMP+NLgcGc6BVjxVjVIWO0p7RbFEIEm4bRR02eFbjIxnuvVzSajV//Mo8WooL2QU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h4rdmi9wOrpUiQGd0ZoxnWjX0ySbn4nCuw4guU1z/+YwXnIbP
	dGgHa1M/z9q91dHDFnV6qftz70OVeOgcU9YTdbGgxdocMy9xCagI+PyX
X-Gm-Gg: AYBFou1zxGYogkc4GbM0iAvIuKBtpO4/zl6OOuI/xfjh3etRhh+YNtp8/JvMRjcyV9i
	bQZWNGGBrQAzao21U0FuZJPWaZjua5StHCjyLAQKy0k6qVJOPwHqW/6ArlzXpLg/msnqNSYEcv1
	9ZcCRGaqqiqBj8dZYP0GOlft+qpPnDAxy9jdvQSibxe53tB53yZ2Dg30l/MuqUN8CxYXwVO3poS
	ktBudZtw3BxuI9BccIGgBtH+PdoN8nkAyor561MLF2apxaJKan/WvtoZivuSnpQA5WpnylTDXs3
	bkqpvsLJEM9br7NcstyiDTpim8cQYcdEcUHhy9lZn4Sw48Q0MIaWfF25AmMEBaxQgAB+FW5zjwp
	gXU08bA6fpn2dvEnv0YUrQCP3B1iDwyZs1zKu3fBqo8yT0IkIyp+f7dpEVasDGyMJHbPtiYKcYR
	ndChIc4ewdqQQMEnSfXkS1VLxhG4gZ+ERc6VXaDkB7eZ0//1q9BhLyizAUwmQyALUH/MZHBx0ly
	uWlpXIc8Z+SRB54VZV7HIZeQIFEkTbVWi0/F/6qEhLvMP79KkYhevZnSWmSigccgCklhyAWYAEH
	lLfC0JhWo3z1EaApdyqdYKjn4BIJjQ1Sm7OT2jy4lBtXGYSr8m9L4rsp/sXXZH/8u6jvp+k0I9P
	Y8ZU=
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id 5a478bee46e88-379651ecb3emr8108167eec.1.1794644432522;
        Sat, 14 Nov 2026 00:20:32 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:20:31 -0800 (PST)
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
Subject: [PATCH v2 2/4] drm/panfrost: Find the jobs of a destroyed JM context by their context
Date: Sat, 14 Nov 2026 17:20:14 +0900
Message-ID: <20261114082016.2454-3-arpe1618@gmail.com>
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
file is closed, looks for the jobs of the context in pfdev->jobs[] by
comparing job->base.entity with the entities of the context. Since
commit 96c7c2f4d5bd ("drm/scheduler: set entity to NULL in
drm_sched_entity_pop_job()"), the scheduler clears job->base.entity
when it pops a job, before it calls run_job(), so the entity of every
job in pfdev->jobs[] is NULL and the comparison never matches.

The jobs of a destroyed context are therefore neither stopped nor
detached from the file: they keep running after the file is closed,
and with profiling enabled, panfrost_dequeue_job() writes their
engine_usage to the panfrost_file_priv that panfrost_postclose() has
freed. The same comparison was used in panfrost_job_close() before
commit 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for manging
job resources").

Match the jobs by job->ctx instead, which a job holds a reference to
until it is cleaned up.

The patch and its changelog were drafted with an AI coding assistant.
The issue has not been reproduced, and the change has only been
compile-tested.

Fixes: 96c7c2f4d5bd ("drm/scheduler: set entity to NULL in drm_sched_entity_pop_job()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-214229@kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
Trees from before commit 6aa8bc58ac88 ("drm/panfrost: Introduce JM
contexts for manging job resources") have the same comparison in
panfrost_job_close() and need a separate backport; there, the jobs of
the file can be matched by job->mmu instead.

 drivers/gpu/drm/panfrost/panfrost_job.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7022b1b2e020..7a3137dacb9d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -1105,13 +1105,15 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 	/* Kill in-flight jobs */
 	spin_lock(&pfdev->js->job_lock);
 	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slot_entity); i++) {
-		struct drm_sched_entity *entity = &jm_ctx->slot_entity[i];
-
 		for (int j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
 			struct panfrost_job *job = pfdev->jobs[i][j];
 			u32 cmd;
 
-			if (!job || job->base.entity != entity)
+			/*
+			 * The scheduler clears job->base.entity when it pops the
+			 * job, so match the job by its context.
+			 */
+			if (!job || job->ctx != jm_ctx)
 				continue;
 
 			if (j == 1) {
-- 
2.43.0

