Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135391;
	b=cchZgSVNOi4oyguLzNuRmGMnrAbJXoHhXjWPnzNHGCl2NSfHD4F1rnaLiaH4wGMHIJbP
	 0LhedOYRyLk3eQcmWkYxMiM7UclBjsipG/lNVCwPRmTVeBvQfKXtFwGBcURo/2LSpWTFX
	 +YFCPymQ+WeH2fI6ejyQq4boGDRJP8S0XOBbSOZNPWTqEqZlpfeTPb12ZLtMHRDlAdm5H
	 5T5blPnO7ZOBCuKOGlIOz4q+ZTTVO9Oiicsl16MryDwYaCc76LMEy3Vb6iruqhIKlnmkG
	 tp73RJNY2NN5BA4fPV6NOS279LqmYocpbP6Z2NsN8AmF+JYq7IGTmgbV+lgCiniptFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135391;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=e9Dpgey3aCA/wo/6U2AQsfdlzUC0B34C1vFmZygVNXA=;
	b=26nbn5GXbDgkesqrjGf7A8SZr5nsfSuZ8TVeIN7bBZ+dQJySrO/sBcdPDfw2OuKNrxL9
	 9GoNTQL56f+MEdDGFU7EiIub9NxaZws7q43GAZcvXzc+pKH0AVayBp//eiEVwrw/H+9IB
	 mmiE0zEF9VWOeiGiOFkVDrraB1iblMqMRlQaa5aOwiWvC6M6zy5mzf4Te9J2FyRSI7VKJ
	 4pEyWIUTqxvZuTJpigFgnKK1zrMcXwPVMxLX03YueXPjxADIgPYEBW6/ZwJ5uJwcskGLa
	 7HE/qv1w/GZYeZZzOrj7yJjYJ5ouGUHIYV+FCVfOm6eBV5tJ53qvMQdp2lWdwa85MJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=mcFEHqRF;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44542606A330;
	Sun,  8 Nov 2026 10:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44542606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=mcFEHqRF
Received: from LAPTOP-99KJFSET (unknown [223.75.64.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53e3dfdd4;
	Sun, 8 Nov 2026 18:56:19 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] drm/amdkfd: fix use-after-free in create_process() error path
Date: Sun,  8 Nov 2026 18:56:17 +0800
Message-ID: <20261108105617.1309-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
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
X-HM-Tid: 0aa1bacd4ba303a1kunm2cabcdaace62f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTElPVk0ZGRoZSRoZHkoeQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTE5VTU9VQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=mcFEHqRFpau+wg/fQNt+tNfumMVFWV3R/lwdCO/yVAMQgcDAWUpkmDSeZxOM7I5eeMdgwHh4hWtpiZlqclgjFFMEHa31l4uM+kKxFtVUpyhIf/6xKBouGo1fgl51BwivVCOJsNmXzsulbYCfatGS9gHvPieRpC7nv2ogYcpEEso=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=e9Dpgey3aCA/wo/6U2AQsfdlzUC0B34C1vFmZygVNXA=;
	h=date:mime-version:subject:message-id:from;

create_process() publishes the process in kfd_processes_table before its
last failing call (alloc_notifier() must find it there), and its error path
frees it with a bare kfree(), ignoring the refcount.  find_process() takes
its reference inside the sRCU critical section but callers use the process
after leaving it, so synchronize_srcu() misses them, and the error path
cannot unref once either: it holds two (kref_init() and the one keeping
free_notifier() from starting kfd_process_wq_release()).

Release the process as soon as it is visible: take the lead thread
reference right after lead_thread is assigned, run ida_init() before
mmu_notifier_get(), so the release work is safe on a half-built object.
The published error paths unlink with hash_del_rcu(), synchronize_srcu()
and drop both references, so the last one runs kfd_process_wq_release().
Both labels hold exactly two references, so nothing is freed early and no
path falls into the unwind the unpublished labels keep, now with
put_task_struct()).  Restore pqm_uninit() (kfd_process_queue_manager.c):
pqm_init()'s 128 byte queue slot bitmap leaked per failure.  Match
kfd_debugfs_remove_process() by process, not pid.

Fixes: 3248b6d3cbcd ("drm/amdkfd: Use mmu_notifier_get")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 12 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 46 ++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 7d4e07452cdb..a17a3a307266 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -33,6 +33,7 @@ static struct list_head procs;
 struct debugfs_proc_entry {
 	struct list_head list;
 	struct dentry *proc_dentry;
+	struct kfd_process *process;
 	pid_t pid;
 };
 
@@ -151,6 +152,7 @@ void kfd_debugfs_add_process(struct kfd_process *p)
 		return;
 
 	list_add(&entry->list, &procs);
+	entry->process = p;
 	entry->pid = p->lead_thread->pid;
 	snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
 		 (int)entry->pid);
@@ -174,9 +176,17 @@ void kfd_debugfs_remove_process(struct kfd_process *p)
 {
 	struct debugfs_proc_entry *entry, *next;
 
+	/*
+	 * Match the entry that was added for this process and not one that
+	 * merely has the same pid: kfd_process_wq_release() also runs for a
+	 * process that failed in create_process() and never got an entry,
+	 * and after an exec(3) the old and the new primary kfd_process of a
+	 * process have the same lead thread while a file descriptor keeps
+	 * the old one alive.
+	 */
 	mutex_lock(&kfd_processes_mutex);
 	list_for_each_entry_safe(entry, next, &procs, list) {
-		if (entry->pid != p->lead_thread->pid)
+		if (entry->process != p)
 			continue;
 
 		debugfs_remove_recursive(entry->proc_dentry);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 12e24fbf8c46..f118f7f03de7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1600,6 +1600,11 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	mutex_init(&process->mutex);
 	process->mm = thread->mm;
 	process->lead_thread = thread->group_leader;
+	/*
+	 * Take the reference on the lead thread before the process can be
+	 * released through kfd_process_wq_release(), which drops it again.
+	 */
+	get_task_struct(process->lead_thread);
 	process->n_pdds = 0;
 	process->queues_paused = false;
 
@@ -1648,13 +1653,17 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	 */
 	if (primary) {
 		process->context_id = KFD_CONTEXT_ID_PRIMARY;
+		/*
+		 * Must be initialized before the process can be given to
+		 * kfd_process_wq_release(), which destroys it.
+		 */
+		ida_init(&process->id_table);
 		mn = mmu_notifier_get(&kfd_process_mmu_notifier_ops, process->mm);
 		if (IS_ERR(mn)) {
 			err = PTR_ERR(mn);
 			goto err_register_notifier;
 		}
 		BUG_ON(mn != &process->mmu_notifier);
-		ida_init(&process->id_table);
 	}
 
 	err = kfd_process_alloc_id(process);
@@ -1664,7 +1673,6 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	}
 
 	kfd_unref_process(process);
-	get_task_struct(process->lead_thread);
 
 	INIT_WORK(&process->debug_event_workarea, debug_event_write_work_handler);
 
@@ -1673,8 +1681,39 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 err_alloc_id:
 	kfd_process_free_id(process);
 err_register_notifier:
+	/*
+	 * The process is already in kfd_processes_table, so find_process()
+	 * may have handed it out with a reference taken on it.  Unlink it
+	 * and wait for the readers that are still walking the table before
+	 * dropping the references held here: afterwards no new reference
+	 * can be taken and the ones already taken keep the process alive.
+	 * The memory is then freed by kfd_process_wq_release() when the
+	 * last reference is dropped.
+	 */
 	hash_del_rcu(&process->kfd_processes);
-	svm_range_list_fini(process);
+	synchronize_srcu(&kfd_processes_srcu);
+
+	/*
+	 * kfd_process_wq_release() frees the memory, but it does not
+	 * destroy the queue manager: on the normal path that is done by
+	 * kfd_process_notifier_release_internal(), which neither of these
+	 * two error paths can reach, because no mmu notifier was
+	 * registered for the process.  The process is unlinked and no
+	 * reader can reach the pqm any more, so destroy it here, before
+	 * the references are dropped.
+	 */
+	pqm_uninit(&process->pqm);
+
+	/*
+	 * Drop the reference that keeps a failing free_notifier() from
+	 * starting kfd_process_wq_release() and the one taken by
+	 * kref_init().
+	 */
+	kfd_unref_process(process);
+	kfd_unref_process(process);
+
+	return ERR_PTR(err);
+
 err_init_svm_range_list:
 	kfd_process_free_outstanding_kfd_bos(process);
 	kfd_process_destroy_pdds(process);
@@ -1684,6 +1723,7 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	kfd_event_free_process(process);
 err_event_init:
 	mutex_destroy(&process->mutex);
+	put_task_struct(process->lead_thread);
 	kfree(process);
 err_alloc_process:
 	return ERR_PTR(err);
-- 
2.50.1.windows.1

