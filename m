Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CED5632B9
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087217; cv=none; b=pRgwM+6jWdOURq+89y6IfO2sgjsxycYtXfpkVIunPy3L59TlaFcTxCfed5zHK0iwbrm8P7GDqQPE5CTf7sbkNxMM5V4apukvUPLyoAcUg81/KWFtxJf/jo+UWorrPdGCOW3iwhiaVRG2H9Zf1f0VGS0WsanuUTyA89R/wT7v7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087217; c=relaxed/simple;
	bh=DrDZ0rtNac1TFfMF35LminYAuufoxFAQqDGkVPh++08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BujC4nAr8zARJ8Ob6k/KaYoPttfTR8FjboQKs5cs6bEVj/lVVgcm9OnuYepy+NJUWOAqjZg56muJRooPd87xPjvDwvlmalLRvGrsmLy9seAgBRqTYeW/YeaBIubynAHQgrjs5+ef9m+S2/zqrOR2Sa8Z3+qTVa3puJpscGz9oLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiB5+iCw; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiB5+iCw"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15943c9c005so2728071c88.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792087207; x=1792692007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQU2mFCcZijVfHNcT83wEGKS/aSb6ywHgE8MWS0vK70=;
        b=DiB5+iCwESGaJSVEWDXHYUUhuj8j5kOWcWGTmBeaTOJtOMZ0oYMWJzKGguAT0Qh0Jy
         Lrb3+Kwl1HdUllK52UYhOSiv4SYGi3RY6v+UyI13T2n03BL5K6YWACGeMO2g1scAfiuk
         GsHGuWHCIb9LGXdbLrbxN3dtEzVWwRMSE2X6l5pcZQPZCTqw3XLlg5IpoAeHn6/yGn/P
         7uCn8mFs5not06Rh49VRHdwlzzRWdA1Wqo0bi1AX8ZhblH5fSRmqll9Lyec3E+VdE2EM
         0ymJdnDXZUNEwyDHvt6wQ0AtkHKbGYm4OawyPCA/iH14nTmRZu3q10rh3EAoLc8LGxHX
         BjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792087207; x=1792692007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQU2mFCcZijVfHNcT83wEGKS/aSb6ywHgE8MWS0vK70=;
        b=z8jct0rPrz8TLFBD3G6Zv+sMCXJySN4pd30KgQ6c0DNAffmmkMiz5yEynRBm/SvHRw
         /UwqH43m1d0YNuuzd3Q6ryR0wisFfkrg62FjtxgeGgbgCmFraE6ls8lB5n+e6MmsrySc
         BQ7sPa4g5PZHJYPVdFywft99Cime08Pc/JH+EztEkbP8Qo0+W48Q8cEsa0atkzmqhctP
         lXXPk77JCXkE08ks/Ymk61iF5D6rKGOuuxGo7jj1zMQ7ZJ9jUkmNtlYGNg/kEsBYJCC7
         TDac7WDm2XddYSN+GrDwz34lp4ib3ARZ8/LUf+nripBn0Tz5JO/JXaXxFGT29xS2FeJJ
         etrg==
X-Forwarded-Encrypted: i=1; AKwUvBz3KMGNXU9pnADX5+C2Hfuq09KozmFdxX/5LeEtQO0b3na7aa4TJ342nxtVHQpyGciU9rW8qwU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNfJv+w/leYDcTkstnt/9aCvIIi4df55oadixq4mfi39eGplzJ
	cSWaXKHNaYqtygs9Uv8eb+QAgP7BtmMnuZOxv+AlOmcJjWMglMzxT78a
X-Gm-Gg: AYBFou31XgkdmAEJ5tNeDg928/bDreNY2c5TTxc+mVp02Ys9LoBjsJbnHnC/ho3e6DQ
	EXMk6aQW8112ccuUqdPthXMp1DGWtUkr2VLmHPMbfxZo1lElKZCPqtRUCQYWjpG24xOzxwgZmZr
	T2zGP6nvPBnVVs0GCN7plR89mLuFIbht8NB8rZw6e28IMYflh27jLONQVhXdfG1pM4z55yLe6GV
	MrGtwUlrAqLAFCy4iH9MnlhFFFA00ZR3iBfSuAy33fu8hoiaiHCJQUVxhjZkemVv7LrqQOC7j8y
	2DMzIL2eOWobGZvc1ikezumW3IG6oh6EfbgVFAE6Vfd0eAuwKC2QRJSWBZvbDKQsmXSJB0f0AtE
	T8kbWyGCQ6uLv/SAt3DW7JpG1vbXWpKKLWbGTSZXBSEd/yxFqAcdXKFmQvthP2Fk9VhAjj3IIJT
	Cn1p+EqFSP1+mcayNiF3mWoNSerA0Vq7Ets+k/St2+A78UfyyAlEW+K0XkQdgtxVQc0+WSr8zoz
	HSgDDq3ysn0P/cD0eVaUj1jDHinz+wVFsRj2JSc0tAaf0w=
X-Received: by 2002:a05:701a:c901:b0:143:26cf:8617 with SMTP id a92af1059eb24-16a6337f340mr29049828c88.25.1792087206644;
        Thu, 15 Oct 2026 11:00:06 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-182a900cfbfsm444389c88.22.2026.10.15.11.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:00:06 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+4a43f26b1a2b6f57@bugs.sh
Subject: [PATCH] nvme-auth: serialize authentication before TLS key revocation
Date: Thu, 15 Oct 2026 10:59:57 -0700
Message-ID: <20261015175956.1895355-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NVMe/TCP reset and error recovery can revoke opts->tls_key while
admin-queue DH-HMAC-CHAP authentication is replacing it.  The sysfs
reset_controller and tls_configured_key paths can reach this race because
nvme_auth_stop() cancels only controller work; the split negotiate/wait
interface also lets concurrent callers reset the same queue context.

Serialize complete authentication transactions per queue, reject new work
after the controller leaves LIVE or CONNECTING, and make nvme_auth_stop()
drain queue work and its callers before NVMe/TCP revokes the generated key.
Take the transaction mutex before canceling residual work so a pending
authentication cannot be reported successful without running.  Authentication
on different I/O queues remains parallel.

  BUG: KASAN: null-ptr-deref in down_write (kernel/locking/rwsem.c:1632)
  RIP: down_write (kernel/locking/rwsem.c:1632)
  Call Trace:
   key_revoke (security/keys/key.c:1142)
   nvme_auth_revoke_tls_key (drivers/nvme/host/auth.c:653)
   nvme_reset_ctrl_work (drivers/nvme/host/tcp.c:2612)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  Kernel panic - not syncing: Fatal exception

Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
Cc: stable@vger.kernel.org # 6.15+
Reported-by: <co+4a43f26b1a2b6f57@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/nvme/host/auth.c    | 81 +++++++++++++++++++++++++++----------
 drivers/nvme/host/fabrics.c | 16 +-------
 drivers/nvme/host/nvme.h    |  9 +----
 drivers/nvme/host/sysfs.c   |  8 +---
 drivers/nvme/host/tcp.c     |  7 ++--
 5 files changed, 68 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e55920642f2c..563dbe3dcc89 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -21,6 +21,7 @@ static mempool_t *nvme_chap_buf_pool;
 struct nvme_dhchap_queue_context {
 	struct list_head entry;
 	struct work_struct auth_work;
+	struct mutex auth_mutex;
 	struct nvme_ctrl *ctrl;
 	struct crypto_kpp *dh_tfm;
 	struct nvme_dhchap_key *transformed_key;
@@ -915,9 +916,12 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		chap->error = ret;
 }
 
-int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
+static int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 {
 	struct nvme_dhchap_queue_context *chap;
+	enum nvme_ctrl_state state;
+	unsigned long flags;
+	int ret = 0;
 
 	if (!ctrl->host_key) {
 		dev_warn(ctrl->device, "qid %d: no key\n", qid);
@@ -931,12 +935,18 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 
 	chap = &ctrl->dhchap_ctxs[qid];
 	cancel_work_sync(&chap->auth_work);
-	queue_work(nvme_auth_wq, &chap->auth_work);
-	return 0;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	state = nvme_ctrl_state(ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_CONNECTING)
+		ret = -ESHUTDOWN;
+	else
+		queue_work(nvme_auth_wq, &chap->auth_work);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
 
-int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
+static int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 {
 	struct nvme_dhchap_queue_context *chap;
 	int ret;
@@ -948,13 +958,32 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 	nvme_auth_reset_dhchap(chap);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_auth_wait);
+
+int nvme_authenticate(struct nvme_ctrl *ctrl, int qid)
+{
+	struct nvme_dhchap_queue_context *chap;
+	int ret;
+
+	if (!ctrl->dhchap_ctxs) {
+		dev_warn(ctrl->device, "qid %d: no key\n", qid);
+		return -ENOKEY;
+	}
+	chap = &ctrl->dhchap_ctxs[qid];
+
+	mutex_lock(&chap->auth_mutex);
+	ret = nvme_auth_negotiate(ctrl, qid);
+	if (!ret)
+		ret = nvme_auth_wait(ctrl, qid);
+	mutex_unlock(&chap->auth_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_authenticate);
 
 static void nvme_ctrl_auth_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, dhchap_auth_work);
-	int ret, q;
+	int ret, q, last = 1;
 
 	/*
 	 * If the ctrl is no connected, bail as reconnect will handle
@@ -964,16 +993,9 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 		return;
 
 	/* Authenticate admin queue first */
-	ret = nvme_auth_negotiate(ctrl, 0);
+	ret = nvme_authenticate(ctrl, 0);
 	if (ret) {
-		dev_warn(ctrl->device,
-			 "qid 0: error %d setting up authentication\n", ret);
-		return;
-	}
-	ret = nvme_auth_wait(ctrl, 0);
-	if (ret) {
-		dev_warn(ctrl->device,
-			 "qid 0: authentication failed\n");
+		dev_warn(ctrl->device, "qid 0: authentication failed\n");
 		return;
 	}
 	/*
@@ -991,22 +1013,26 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 		 */
 		if (!chap->authenticated)
 			continue;
-		cancel_work_sync(&chap->auth_work);
-		queue_work(nvme_auth_wq, &chap->auth_work);
+		ret = nvme_auth_negotiate(ctrl, q);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %d: authentication setup failed, error %d\n",
+				 q, ret);
+			break;
+		}
+		last = q + 1;
 	}
 
 	/*
 	 * Failure is a soft-state; credentials remain valid until
 	 * the controller terminates the connection.
 	 */
-	for (q = 1; q < ctrl->queue_count; q++) {
+	for (q = 1; q < last; q++) {
 		struct nvme_dhchap_queue_context *chap =
 			&ctrl->dhchap_ctxs[q];
 		if (!chap->authenticated)
 			continue;
-		flush_work(&chap->auth_work);
-		ret = chap->error;
-		nvme_auth_reset_dhchap(chap);
+		ret = nvme_auth_wait(ctrl, q);
 		if (ret)
 			dev_warn(ctrl->device,
 				 "qid %d: authentication failed\n", q);
@@ -1044,6 +1070,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		chap->qid = i;
 		chap->ctrl = ctrl;
 		chap->authenticated = false;
+		mutex_init(&chap->auth_mutex);
 		INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
 	}
 
@@ -1060,7 +1087,17 @@ EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
 void nvme_auth_stop(struct nvme_ctrl *ctrl)
 {
+	int i;
+
 	cancel_work_sync(&ctrl->dhchap_auth_work);
+	if (!ctrl->dhchap_ctxs)
+		return;
+
+	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
+		mutex_lock(&ctrl->dhchap_ctxs[i].auth_mutex);
+		cancel_work_sync(&ctrl->dhchap_ctxs[i].auth_work);
+		mutex_unlock(&ctrl->dhchap_ctxs[i].auth_mutex);
+	}
 }
 EXPORT_SYMBOL_GPL(nvme_auth_stop);
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 59f823dfbbcc..0da8f1b74f86 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -481,13 +481,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 			goto out_free_data;
 		}
 		/* Authentication required */
-		ret = nvme_auth_negotiate(ctrl, 0);
-		if (ret) {
-			dev_warn(ctrl->device,
-				 "qid 0: authentication setup failed\n");
-			goto out_free_data;
-		}
-		ret = nvme_auth_wait(ctrl, 0);
+		ret = nvme_authenticate(ctrl, 0);
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication failed, error %d\n",
@@ -556,13 +550,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 			goto out_free_data;
 		}
 		/* Authentication required */
-		ret = nvme_auth_negotiate(ctrl, qid);
-		if (ret) {
-			dev_warn(ctrl->device,
-				 "qid %d: authentication setup failed\n", qid);
-			goto out_free_data;
-		}
-		ret = nvme_auth_wait(ctrl, qid);
+		ret = nvme_authenticate(ctrl, qid);
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %u: authentication failed, error %d\n",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf740..d6952bb4afa6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1288,8 +1288,7 @@ int __init nvme_init_auth(void);
 void __exit nvme_exit_auth(void);
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
-int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
-int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
+int nvme_authenticate(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl);
 #else
@@ -1305,11 +1304,7 @@ static inline void __exit nvme_exit_auth(void)
 {
 }
 static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
-static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
-{
-	return -EPROTONOSUPPORT;
-}
-static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
+static inline int nvme_authenticate(struct nvme_ctrl *ctrl, int qid)
 {
 	return -EPROTONOSUPPORT;
 }
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 02a2490a9ed7..42bdba831894 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1038,13 +1038,7 @@ static ssize_t tls_configured_key_store(struct device *dev,
 	if (!ctrl->opts || !ctrl->opts->concat)
 		return -EOPNOTSUPP;
 
-	error = nvme_auth_negotiate(ctrl, 0);
-	if (error < 0) {
-		nvme_reset_ctrl(ctrl);
-		return error;
-	}
-
-	error = nvme_auth_wait(ctrl, 0);
+	error = nvme_authenticate(ctrl, 0);
 	if (error < 0) {
 		nvme_reset_ctrl(ctrl);
 		return error;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b..f3709009ffd0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2563,9 +2563,8 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	bool revoke_tls_key = ctrl->opts->concat && ctrl->tls_pskid;
 
-	if (nvme_tcp_key_revoke_needed(ctrl))
-		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
@@ -2574,6 +2573,8 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_tcp_teardown_admin_queue(ctrl, false);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
+	if (revoke_tls_key && ctrl->opts->tls_key)
+		nvme_auth_revoke_tls_key(ctrl);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
@@ -2606,9 +2607,9 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
+	nvme_stop_ctrl(ctrl);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
-	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-- 
2.55.0

