Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520258;
	b=n2+ifDLWUHLitmTU5SzYq1AwWq3ptQfgb5TjKPlGThU4bPTRGk3bHbYKJSMLh5Q9psko
	 EWYPh7G8ftZnHEe9puu2Lued2IyT3a8h4Btfs0n8BvAfdSc7IWBYnyWIMnYgV7MFKllji
	 QsI0ihl9qXHWxuYPh/fv5JG8keIC/L+pmsernpbktuGN3jbujIpjxZz8OsmCfynCh0SPG
	 9l6568LWypyN8MfWC02EvbZTlL9geSni3zVQEpxN3xzuZFRPqIgCd5pXM4N9g9Dwanyk+
	 FmBAbBpAizgOLNSnjBj5b6YmC1I9q5GDUFL8SQfH7tpFok0elEEqTM5d6n9xHZmyGLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520258;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ffFcW/wEVn0upi3qmE81RMYECIu3yhVq9k41vKWVWh8=;
	b=qGOFA3XK5ej/VaVpraa2hvD5dJM9dfJicGcw2UkrRsiOTXPd7BwQ4SvBQB35lJm87OGh
	 2TYURAQ7wFvccsuQs1EIL4VkyVReKfPEyOMRimN4lV010eNTyW3i5f1AYRHDuqHQRY5hP
	 TblLD7Jjs9lBKo1z9MJ3uwoBLzdHO2FZiYinUGjUvDQl9QcRZA921UyRMotuwgLEs+osM
	 yxRuiP2b214m5emXuBXq2UAWTWVXw936UO3ShGThMYziH3hMQpk7rzCNQR8zNPfjeo9Go
	 8V2AD/tIwi5tEdttaayipcXm8cMNYpv0pYN0yX2/SQMbe+wq5FuyB6nN36UB4cbc9LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.49
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB82606A321;
	Tue, 24 Nov 2026 11:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB82606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06463327|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00439941-0.000242477-0.995358;FP=1009340942401455331|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.k9B4J50_1795520244;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k9B4J50_1795520244 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 19:37:25 +0800
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
	itoral@igalia.com
Subject: [PATCH v3] drm/v3d: Fix double free of query arrays on parse failure
Date: Tue, 24 Nov 2026 11:37:23 +0000
Message-Id: <20261124113723.3055530-1-wangxiaolei01@kaihong.com>
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

On a parse error the timestamp and performance parsers free the query
array, and the job release path then frees it again: query_info->count
had not been set yet, so no syncobj was put twice, but the stale array
was handed to kvfree() a second time.

Make the job the only owner: the parsers just fill the array and record
how far they got. count is set before the parse loop, the arrays are
zero allocated, and the free helpers stop at the first entry that was
never set up, which keeps put-count equal to find-count. That also
removes the inline kvfree() of kperfmon_ids and the count arguments of
the free helpers.

Tested on Raspberry Pi 5 (v3d).

Fixes: 0e50fcc20bd8 ("drm/v3d: Fix potential memory leak in the timestamp extension")
Fixes: 32df4abc44f2 ("drm/v3d: Fix potential memory leak in the performance extension")
Cc: stable@vger.kernel.org
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---

Changes in v3:
- Stop the query free loops at the first entry that has no syncobj.
- Do not free the query arrays from the parser error paths; the job is
  the only owner now, so the array is released exactly once.
- Set query_info->count before the parse loop in every parser, and drop
  the count argument from v3d_copy_query_info() as well as from the two
  free helpers.
- Drop the superfluous comment in v3d_sched.c and rewrite the commit
  message.

Link to v2: 
- https://patchwork.kernel.org/project/dri-devel/patch/20261120022828.2612091-1-wangxiaolei01@kaihong.com/
Link to v1:
- https://patchwork.kernel.org/project/dri-devel/patch/20261110061341.2075931-1-wangxiaolei01@kaihong.com/

 drivers/gpu/drm/v3d/v3d_drv.h    |   6 +-
 drivers/gpu/drm/v3d/v3d_sched.c  |  40 +++++----
 drivers/gpu/drm/v3d/v3d_submit.c | 136 ++++++++++---------------------
 3 files changed, 70 insertions(+), 112 deletions(-)

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
index 1924e3440dc9..6e55523be66b 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -96,33 +96,41 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
 }
 
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
+		if (!query_info->queries[i].syncobj)
+			break;
+
+		drm_syncobj_put(query_info->queries[i].syncobj);
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
+
+		if (!query_info->queries[i].syncobj)
+			break;
+
+		drm_syncobj_put(query_info->queries[i].syncobj);
 	}
+
+	kvfree(query_info->queries);
 }
 
 static void
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 7548faab67ba..288283900022 100644
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
@@ -900,73 +874,51 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 	job->copy.stride = copy.stride;
 
 	return 0;
-
-error:
-	v3d_timestamp_query_info_free(&job->timestamp_query, i);
-	return err;
 }
 
 static int
 v3d_copy_query_info(struct v3d_performance_query_info *query_info,
-		    unsigned int count,
 		    unsigned int nperfmons,
 		    u32 __user *syncs,
 		    u64 __user *kperfmon_ids,
 		    struct drm_file *file_priv)
 {
 	unsigned int i, j;
-	int err;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < query_info->count; i++) {
 		struct v3d_performance_query *query = &query_info->queries[i];
 		u32 __user *ids_pointer;
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
@@ -987,12 +939,13 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	job->job_type = V3D_CPU_JOB_TYPE_RESET_PERFORMANCE_QUERY;
 
 	query_info->queries =
-		kvmalloc_objs(struct v3d_performance_query, reset.count);
+		kvzalloc_objs(struct v3d_performance_query, reset.count);
 	if (!query_info->queries)
 		return -ENOMEM;
 
+	query_info->count = reset.count;
+
 	err = v3d_copy_query_info(query_info,
-				  reset.count,
 				  reset.nperfmons,
 				  u64_to_user_ptr(reset.syncs),
 				  u64_to_user_ptr(reset.kperfmon_ids),
@@ -1000,7 +953,6 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	if (err)
 		return err;
 
-	query_info->count = reset.count;
 	query_info->nperfmons = reset.nperfmons;
 
 	return 0;
@@ -1027,12 +979,13 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	job->job_type = V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY;
 
 	query_info->queries =
-		kvmalloc_objs(struct v3d_performance_query, copy.count);
+		kvzalloc_objs(struct v3d_performance_query, copy.count);
 	if (!query_info->queries)
 		return -ENOMEM;
 
+	query_info->count = copy.count;
+
 	err = v3d_copy_query_info(query_info,
-				  copy.count,
 				  copy.nperfmons,
 				  u64_to_user_ptr(copy.syncs),
 				  u64_to_user_ptr(copy.kperfmon_ids),
@@ -1040,7 +993,6 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	if (err)
 		return err;
 
-	query_info->count = copy.count;
 	query_info->nperfmons = copy.nperfmons;
 	query_info->ncounters = copy.ncounters;
 
-- 
2.34.1

