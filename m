Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDE28FFF6
	for <stable@vger.kernel.org>; Sun, 31 May 2026 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780261425; cv=none; b=crM1IUwkspWltbRiWM80vF/GNpQG7kxX1znhygV5g7kVd1CH6vEyeliKTJO8pBkDRc5xvlMO+XYw8tki/jwa8pq2i9Lx4HGlW0DCZfbnMHAbJnLHPYCiScFG36kNBYIBvojJfJihgDvY0awFEA5E3/IWE3+/BESwO3HpDy0HgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780261425; c=relaxed/simple;
	bh=MKxBXFUVPv7lrp/B/zQ8eAYIXsFELqEcvpKTjggTUR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=krKJB0QTVqM+c8qbI/BegeL21WgvOM0kUO1bxFTciJuF7uo6XpDdyr0McvKUBFKVWjwaxA1OmlDYwhZNcAnlarwEfjDxgBOVV1qxLmCOtZnnHTHmO1wjChMkLPAJCDVf7iTsFbQOKApINypFZeiYlJcKcvRbjQngetJ5P9ix8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rH0G9PPr; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rH0G9PPr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nJ33K3gDEA0ztP2VLjZkr3Myqsk6mdBomiJLKiUFsFM=; b=rH0G9PPr5z4eQHJKuJnYdJioyz
	ENmm2xBcSXOed6hcYAI/Rh4zYAFfX+A6UUtCuVQmZllPe8dCZBvel9gE421TdZslGbVAq4VUM0fu/
	MF1GhEgAVOO+eaLO4PkpMOd42HBehRInPXKgan5gS/FAs5uo4eIhP0Sa2xobyPYs3+Nlg2ZVF3Fqu
	YiyjS/h1GD5eRw9XPzw3BNd0NUjmqq/lGxHggJLBXs6qI7mkjn6CoctgSbxlT7iw3EJUjxxFo/55t
	LOcKrKCgTtRSrmWTNli1FejjkJTVNbrrN2na5NvFnnkED6inNYpUY91kkTWwYWIOB5f/A94eewOaH
	6tNxqKJw==;
Received: from [189.7.87.67] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTnJr-00AhRK-7X; Sun, 31 May 2026 23:03:39 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Iago Toral Quiroga <itoral@igalia.com>,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.12.y 1/2] drm/v3d: Fix use-after-free of CPU job query arrays on error path
Date: Sun, 31 May 2026 18:02:01 -0300
Message-ID: <20260531210323.1637818-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CPU job ioctl's fail label calls kvfree() on cpu_job's timestamp and
performance query arrays after v3d_job_cleanup(), which drops the job's
last reference and frees cpu_job. Reading cpu_job at that point is a
use-after-free. Also, on the early v3d_job_init() failure path, it is a
NULL dereference, since v3d_job_deallocate() zeroes the local pointer.

In the success path, the arrays are released from the scheduler's
.free_job callback, but on the error path, they are freed manually, as
the job was never pushed to the scheduler. While the success path deals
with this correctly, the fail path doesn't.

On top of that, the manual kvfree() calls only free the array storage;
they don't drm_syncobj_put() the per-query syncobjs that
v3d_timestamp_query_info_free() and v3d_performance_query_info_free()
release on the success path. So the same fail path that triggers the
use-after-free also leaks one syncobj reference per query.

Unify the CPU job teardown into the CPU job's kref destructor, mirroring
v3d_render_job_free(). The scheduler's .free_job slot reverts to the
generic v3d_sched_job_free() and the fail label drops the manual
kvfree() calls, leaving a single teardown path that is reached from both
the scheduler and the ioctl error path. That removes the use-after-free,
the NULL dereference, and the syncobj leak by construction.

Cc: stable@vger.kernel.org
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Assisted-by: Claude:claude-opus-4.7
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260515-v3d-cpu-job-leaks-v1-1-7f147cbbf935@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
(cherry picked from commit b0fe80c0b9250b35e2211bf3117e7aca814a21b0)
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c  | 16 +---------------
 drivers/gpu/drm/v3d/v3d_submit.c | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index c9c88d3ad669..90eef062766c 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -103,20 +103,6 @@ v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
 	}
 }
 
-static void
-v3d_cpu_job_free(struct drm_sched_job *sched_job)
-{
-	struct v3d_cpu_job *job = to_cpu_job(sched_job);
-
-	v3d_timestamp_query_info_free(&job->timestamp_query,
-				      job->timestamp_query.count);
-
-	v3d_performance_query_info_free(&job->performance_query,
-					job->performance_query.count);
-
-	v3d_job_cleanup(&job->base);
-}
-
 static void
 v3d_switch_perfmon(struct v3d_dev *v3d, struct v3d_job *job)
 {
@@ -846,7 +832,7 @@ static const struct drm_sched_backend_ops v3d_cache_clean_sched_ops = {
 static const struct drm_sched_backend_ops v3d_cpu_sched_ops = {
 	.run_job = v3d_cpu_job_run,
 	.timedout_job = v3d_generic_job_timedout,
-	.free_job = v3d_cpu_job_free
+	.free_job = v3d_sched_job_free
 };
 
 int
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ddc20191a1ce..40c21aaade0d 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -118,6 +118,21 @@ v3d_render_job_free(struct kref *ref)
 	v3d_job_free(ref);
 }
 
+static void
+v3d_cpu_job_free(struct kref *ref)
+{
+	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
+					       base.refcount);
+
+	v3d_timestamp_query_info_free(&job->timestamp_query,
+				      job->timestamp_query.count);
+
+	v3d_performance_query_info_free(&job->performance_query,
+					job->performance_query.count);
+
+	v3d_job_free(ref);
+}
+
 void v3d_job_cleanup(struct v3d_job *job)
 {
 	if (!job)
@@ -1310,7 +1325,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
 
 	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
-			   v3d_job_free, 0, &se, V3D_CPU);
+			   v3d_cpu_job_free, 0, &se, V3D_CPU);
 	if (ret) {
 		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
@@ -1393,8 +1408,6 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	v3d_job_cleanup((void *)csd_job);
 	v3d_job_cleanup(clean_job);
 	v3d_put_multisync_post_deps(&se);
-	kvfree(cpu_job->timestamp_query.queries);
-	kvfree(cpu_job->performance_query.queries);
 
 	return ret;
 }
-- 
2.54.0

