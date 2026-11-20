Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141724;
	b=gmWB9RgXwKLGQnDOVdcI+l9Vr0Kax2hqtKpbNjA4wHfSZi7/Ixo0q3otBNnguQ096t4H
	 24yCpkuu8seGdcpB+AcYPotkMtxihd4T9UMKL8CjY+iI2nWnwZB7Gi2oUtAGvMgKkFxM6
	 xpjjDEb0y5nKYlyF4+El9p/4mzF0XboPS9GCKh371BQCZOrlqaSQhtTSc9VOJi/kALDqh
	 zRDjWxElgceBPobGLL4yJXxwelok4AXHIG1lIcvBoFHnHz7tiM8BlroW6CYSi84OgbsFq
	 xti2UdDtmyfoPuOQKnGvswa0qQbo8l01MtJBwjH6GvEpOtNAAv9ru/qyHHUafPBAQMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141724;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4u82aT9jbSrBeO5DDlhhQ8oJcJ7vaKzUk0iD4meh3i0=;
	b=gJJyDR41VTU1JNoINnaXlYl2w9saebpvGfkIJciuKvJW3PBlOguNrPNszloJCZI5dIKH
	 O1dvvvpe0c06MDIgWT8jCPAkWabbMyTqZywbtzQKsA8/DpG9PxvopEGCGvPV6R/yRgxrP
	 YXK8UYVIio6s2ub4iaDmAhIf3y9cKaUyGkWMvuUHvigEHS/WXorKe3YSVHQowznaBpMUe
	 hAlBOeM6SBDCysEPUfC1Wbfv6K+uYTLUas3esE3Jy5gAuCIhG6Zud20+w8dUNxZfIfaXI
	 Mi1tP+Uj5xd3xleGzzOdavbBArS+PQPQi7A/etmkGeVwziCBp66EYxelxEQRJYs4LxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.146
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85D606A320;
	Fri, 20 Nov 2026 02:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F85D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00593228-0.000234901-0.993833;FP=794294060232459499|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.k67487P_1795141717;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k67487P_1795141717 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 10:28:38 +0800
From: Xiaolei Wang <wangxiaolei01@kaihong.com>
To: mcanal@igalia.com,
	mwen@igalia.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	tvrtko.ursulin@igalia.com,
	wangxiaolei01@kaihong.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Iago Toral Quiroga <itoral@igalia.com>
Subject: [PATCH v2] drm/v3d: Fix double free of query arrays on parse failure
Date: Fri, 20 Nov 2026 02:28:28 +0000
Message-Id: <20261120022828.2612091-1-wangxiaolei01@kaihong.com>
X-Mailer: git-send-email 2.34.1
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

v3d_get_cpu_timestamp_query_params(), v3d_get_cpu_reset_timestamp_params(),
v3d_get_cpu_copy_query_results_params() and v3d_copy_query_info() -- the
latter shared by the reset and copy performance parsers -- free the query
array on their error paths through v3d_timestamp_query_info_free() and
v3d_performance_query_info_free().

The same job is then released by v3d_submit_cpu_ioctl()'s failure path
(v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
v3d_cpu_job_free()), which calls the same helpers on the same query_info.
On these error paths query_info->count was never assigned -- it was only
written after the parse loop completed -- so the syncobj loop ran zero
times and no syncobj was put twice, but the "if (query_info->queries)" test
still succeeded and the dangling pointer was handed to kvfree() a second
time.

Every failure inside the parse loop takes this path: -ENOENT from
drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
kvmalloc_array() in v3d_copy_query_info().

Fix the ownership instead of the symptom: the query array, and the per
query kperfmon_ids, belong to the job and are freed exactly once, by
v3d_cpu_job_free().  The parsers no longer free anything; they only fill
the array in and record how far they got:

  - query_info->count is set before the parse loop, so the helpers know how
    many entries were touched when parsing fails halfway;

  - the arrays are allocated with kvzalloc_objs(), so entries that were
    never reached carry a NULL syncobj and a NULL kperfmon_ids;

  - the helpers walk the full count but test every entry, so they put
    exactly the syncobj references that were taken, keeping
    put-count == find-count on all failure paths;

  - the inline kvfree() of kperfmon_ids in v3d_copy_query_info() is dropped
    for the same reason;

  - the count argument of v3d_timestamp_query_info_free() and
    v3d_performance_query_info_free() goes away, as the count now lives in
    query_info itself.

With that, a parsing failure leaves nothing behind: the job release path is
the single owner, and a second release cannot happen because the parser
never releases at all.

Tested on a Raspberry Pi 5 (v3d) .

Fixes: 0e50fcc20bd8 ("drm/v3d: Fix potential memory leak in the timestamp extension")
Fixes: 32df4abc44f2 ("drm/v3d: Fix potential memory leak in the performance extension")
Cc: stable@vger.kernel.org
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |   6 +-
 drivers/gpu/drm/v3d/v3d_sched.c  |  42 ++++++----
 drivers/gpu/drm/v3d/v3d_submit.c | 129 ++++++++++---------------------
 3 files changed, 69 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 7c7bdf6e51a5..e5c9ad86449a 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -669,10 +669,8 @@ static __always_inline int v3d_pm_runtime_put(struct v3d_dev *v3d)
 }
 
 /* v3d_sched.c */
-void v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
-				   unsigned int count);
-void v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
-				     unsigned int count);
+void v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info);
+void v3d_performance_query_info_free(struct v3d_performance_query_info *query_info);
 struct v3d_stats *v3d_stats_alloc(void);
 void v3d_stats_release(struct kref *refcount);
 void v3d_job_update_stats(struct v3d_job *job);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 1924e3440dc9..6ee64fbacae9 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -95,34 +95,44 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
 	v3d_job_cleanup(job);
 }
 
+/*
+ * The query arrays are owned by the job: they are allocated by the extension
+ * parsers in v3d_submit.c (which also publish ->count before they start
+ * filling the entries) and they are released only here, from
+ * v3d_cpu_job_free().  The arrays are zero allocated, so on a parsing failure
+ * the entries past the last one set up are all zero and get skipped.
+ */
 void
-v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
-			      unsigned int count)
+v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info)
 {
-	if (query_info->queries) {
-		unsigned int i;
+	unsigned int i;
 
-		for (i = 0; i < count; i++)
-			drm_syncobj_put(query_info->queries[i].syncobj);
+	if (!query_info->queries)
+		return;
 
-		kvfree(query_info->queries);
+	for (i = 0; i < query_info->count; i++) {
+		if (query_info->queries[i].syncobj)
+			drm_syncobj_put(query_info->queries[i].syncobj);
 	}
+
+	kvfree(query_info->queries);
 }
 
 void
-v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
-				unsigned int count)
+v3d_performance_query_info_free(struct v3d_performance_query_info *query_info)
 {
-	if (query_info->queries) {
-		unsigned int i;
+	unsigned int i;
 
-		for (i = 0; i < count; i++) {
-			drm_syncobj_put(query_info->queries[i].syncobj);
-			kvfree(query_info->queries[i].kperfmon_ids);
-		}
+	if (!query_info->queries)
+		return;
 
-		kvfree(query_info->queries);
+	for (i = 0; i < query_info->count; i++) {
+		kvfree(query_info->queries[i].kperfmon_ids);
+		if (query_info->queries[i].syncobj)
+			drm_syncobj_put(query_info->queries[i].syncobj);
 	}
+
+	kvfree(query_info->queries);
 }
 
 static void
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 7548faab67ba..5087039733e8 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -174,11 +174,9 @@ v3d_cpu_job_free(struct kref *ref)
 	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
 					       base.refcount);
 
-	v3d_timestamp_query_info_free(&job->timestamp_query,
-				      job->timestamp_query.count);
+	v3d_timestamp_query_info_free(&job->timestamp_query);
 
-	v3d_performance_query_info_free(&job->performance_query,
-					job->performance_query.count);
+	v3d_performance_query_info_free(&job->performance_query);
 
 	if (job->indirect_csd.indirect)
 		drm_gem_object_put(job->indirect_csd.indirect);
@@ -734,7 +732,6 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 	struct drm_v3d_timestamp_query timestamp;
 	struct v3d_timestamp_query_info *query_info = &job->timestamp_query;
 	unsigned int i;
-	int err;
 
 	if (!v3d_validate_cpu_job(file_priv, job))
 		return -EINVAL;
@@ -747,43 +744,34 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 
 	job->job_type = V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY;
 
-	query_info->queries = kvmalloc_objs(struct v3d_timestamp_query,
+	query_info->queries = kvzalloc_objs(struct v3d_timestamp_query,
 					    timestamp.count);
 	if (!query_info->queries)
 		return -ENOMEM;
 
+	query_info->count = timestamp.count;
+
 	offsets = u64_to_user_ptr(timestamp.offsets);
 	syncs = u64_to_user_ptr(timestamp.syncs);
 
 	for (i = 0; i < timestamp.count; i++) {
 		u32 offset, sync;
 
-		if (get_user(offset, offsets++)) {
-			err = -EFAULT;
-			goto error;
-		}
+		if (get_user(offset, offsets++))
+			return -EFAULT;
 
 		query_info->queries[i].offset = offset;
 
-		if (get_user(sync, syncs++)) {
-			err = -EFAULT;
-			goto error;
-		}
+		if (get_user(sync, syncs++))
+			return -EFAULT;
 
 		query_info->queries[i].syncobj = drm_syncobj_find(file_priv,
 								  sync);
-		if (!query_info->queries[i].syncobj) {
-			err = -ENOENT;
-			goto error;
-		}
+		if (!query_info->queries[i].syncobj)
+			return -ENOENT;
 	}
-	query_info->count = timestamp.count;
 
 	return 0;
-
-error:
-	v3d_timestamp_query_info_free(&job->timestamp_query, i);
-	return err;
 }
 
 static int
@@ -795,7 +783,6 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 	struct drm_v3d_reset_timestamp_query reset;
 	struct v3d_timestamp_query_info *query_info = &job->timestamp_query;
 	unsigned int i;
-	int err;
 
 	if (!v3d_validate_cpu_job(file_priv, job))
 		return -EINVAL;
@@ -805,11 +792,13 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 
 	job->job_type = V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY;
 
-	query_info->queries = kvmalloc_objs(struct v3d_timestamp_query,
+	query_info->queries = kvzalloc_objs(struct v3d_timestamp_query,
 					    reset.count);
 	if (!query_info->queries)
 		return -ENOMEM;
 
+	query_info->count = reset.count;
+
 	syncs = u64_to_user_ptr(reset.syncs);
 
 	for (i = 0; i < reset.count; i++) {
@@ -817,25 +806,16 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 
 		query_info->queries[i].offset = reset.offset + 8 * i;
 
-		if (get_user(sync, syncs++)) {
-			err = -EFAULT;
-			goto error;
-		}
+		if (get_user(sync, syncs++))
+			return -EFAULT;
 
 		query_info->queries[i].syncobj = drm_syncobj_find(file_priv,
 								  sync);
-		if (!query_info->queries[i].syncobj) {
-			err = -ENOENT;
-			goto error;
-		}
+		if (!query_info->queries[i].syncobj)
+			return -ENOENT;
 	}
-	query_info->count = reset.count;
 
 	return 0;
-
-error:
-	v3d_timestamp_query_info_free(&job->timestamp_query, i);
-	return err;
 }
 
 /* Get data for the copy timestamp query results job submission. */
@@ -848,7 +828,6 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 	struct drm_v3d_copy_timestamp_query copy;
 	struct v3d_timestamp_query_info *query_info = &job->timestamp_query;
 	unsigned int i;
-	int err;
 
 	if (!v3d_validate_cpu_job(file_priv, job))
 		return -EINVAL;
@@ -861,37 +840,32 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 
 	job->job_type = V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY;
 
-	query_info->queries = kvmalloc_objs(struct v3d_timestamp_query,
+	query_info->queries = kvzalloc_objs(struct v3d_timestamp_query,
 					    copy.count);
 	if (!query_info->queries)
 		return -ENOMEM;
 
+	query_info->count = copy.count;
+
 	offsets = u64_to_user_ptr(copy.offsets);
 	syncs = u64_to_user_ptr(copy.syncs);
 
 	for (i = 0; i < copy.count; i++) {
 		u32 offset, sync;
 
-		if (get_user(offset, offsets++)) {
-			err = -EFAULT;
-			goto error;
-		}
+		if (get_user(offset, offsets++))
+			return -EFAULT;
 
 		query_info->queries[i].offset = offset;
 
-		if (get_user(sync, syncs++)) {
-			err = -EFAULT;
-			goto error;
-		}
+		if (get_user(sync, syncs++))
+			return -EFAULT;
 
 		query_info->queries[i].syncobj = drm_syncobj_find(file_priv,
 								  sync);
-		if (!query_info->queries[i].syncobj) {
-			err = -ENOENT;
-			goto error;
-		}
+		if (!query_info->queries[i].syncobj)
+			return -ENOENT;
 	}
-	query_info->count = copy.count;
 
 	job->copy.do_64bit = copy.do_64bit;
 	job->copy.do_partial = copy.do_partial;
@@ -900,10 +874,6 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 	job->copy.stride = copy.stride;
 
 	return 0;
-
-error:
-	v3d_timestamp_query_info_free(&job->timestamp_query, i);
-	return err;
 }
 
 static int
@@ -915,7 +885,8 @@ v3d_copy_query_info(struct v3d_performance_query_info *query_info,
 		    struct drm_file *file_priv)
 {
 	unsigned int i, j;
-	int err;
+
+	query_info->count = count;
 
 	for (i = 0; i < count; i++) {
 		struct v3d_performance_query *query = &query_info->queries[i];
@@ -923,50 +894,34 @@ v3d_copy_query_info(struct v3d_performance_query_info *query_info,
 		u32 sync, id;
 		u64 ids;
 
-		if (get_user(sync, syncs++)) {
-			err = -EFAULT;
-			goto error;
-		}
+		if (get_user(sync, syncs++))
+			return -EFAULT;
 
-		if (get_user(ids, kperfmon_ids++)) {
-			err = -EFAULT;
-			goto error;
-		}
+		if (get_user(ids, kperfmon_ids++))
+			return -EFAULT;
 
 		query->kperfmon_ids =
 			kvmalloc_array(nperfmons,
 				       sizeof(struct v3d_performance_query *),
 				       GFP_KERNEL);
-		if (!query->kperfmon_ids) {
-			err = -ENOMEM;
-			goto error;
-		}
+		if (!query->kperfmon_ids)
+			return -ENOMEM;
 
 		ids_pointer = u64_to_user_ptr(ids);
 
 		for (j = 0; j < nperfmons; j++) {
-			if (get_user(id, ids_pointer++)) {
-				kvfree(query->kperfmon_ids);
-				err = -EFAULT;
-				goto error;
-			}
+			if (get_user(id, ids_pointer++))
+				return -EFAULT;
 
 			query->kperfmon_ids[j] = id;
 		}
 
 		query->syncobj = drm_syncobj_find(file_priv, sync);
-		if (!query->syncobj) {
-			kvfree(query->kperfmon_ids);
-			err = -ENOENT;
-			goto error;
-		}
+		if (!query->syncobj)
+			return -ENOENT;
 	}
 
 	return 0;
-
-error:
-	v3d_performance_query_info_free(query_info, i);
-	return err;
 }
 
 static int
@@ -987,7 +942,7 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	job->job_type = V3D_CPU_JOB_TYPE_RESET_PERFORMANCE_QUERY;
 
 	query_info->queries =
-		kvmalloc_objs(struct v3d_performance_query, reset.count);
+		kvzalloc_objs(struct v3d_performance_query, reset.count);
 	if (!query_info->queries)
 		return -ENOMEM;
 
@@ -1000,7 +955,6 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	if (err)
 		return err;
 
-	query_info->count = reset.count;
 	query_info->nperfmons = reset.nperfmons;
 
 	return 0;
@@ -1027,7 +981,7 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	job->job_type = V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY;
 
 	query_info->queries =
-		kvmalloc_objs(struct v3d_performance_query, copy.count);
+		kvzalloc_objs(struct v3d_performance_query, copy.count);
 	if (!query_info->queries)
 		return -ENOMEM;
 
@@ -1040,7 +994,6 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	if (err)
 		return err;
 
-	query_info->count = copy.count;
 	query_info->nperfmons = copy.nperfmons;
 	query_info->ncounters = copy.ncounters;
 
-- 
2.34.1

