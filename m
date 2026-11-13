Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584324;
	b=2PJbaH5Lty+xyiOuvmwwhxGmIyUgyPimKGZ/sAeWsNOAcEEg6HhvgQNNZCLyqcxiKQVm
	 K8tEAYQr/gBoqUt6UEx1AvwwlKKEzN2l9+m6N25inffsG8mDugEFihzfX3taLRG5+fvBR
	 2REkmWFd66Qt6GvBHVx41lR9ZwdgY9RI+yNB/umqeVarBfSib1MLBwXJjQeyK6nKMD+Uo
	 C9OjZVpJDkuMNJZ1OSSOdfSKcOb1WwkLUvscxaakQPMSpOWW1EgQTh/2kP7JgJD0IGgmJ
	 MPqMnF3OkRBYhedd4RKEzSFFTTj5l1RK0vmoUhmZFb4UtUS8Zu8vzSiX1pxXFSLI7Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584324;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RfMjvcfRGxZSfwBA+VOEYuhu86t58kZI36FA7/CsuKA=;
	b=rAsO1L+8ZkZz6LEOoIL3iX4vGDQY5DV161Ey6/NPrCya4y2JaYiDSgLpJ3KiJOZKMjcA
	 6rjQxnKokARdJllLy0aljlUBtT/mhN7Ff4YwHPfW3jpx0JeT0oQdDk2ncRemlZIgvd94T
	 lkxaAB65VWG0EfVO+KfeW/ob0Bsnh4Rn/y1mdchGRAegRSvCVanPKpZ/gzTZSej+qBM0Y
	 1dU/ucShEO/9t4IAGiljFVII4Ma4wAeOgaf7IhR2RmkpYBiSKaC2tovAXfNwsA36+RP4j
	 B0GKd6Dv2sKpzInC9lZPBxz1UiFZ444gC4uJrj7uIduzbecsTxHgTmpdHoi2w0a/evA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azISgAOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917F606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azISgAOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ADA1F000C4;
	Fri, 13 Nov 2026 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584324;
	bh=RfMjvcfRGxZSfwBA+VOEYuhu86t58kZI36FA7/CsuKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azISgAOIQntSijVnt2iZ8y+4hENbEd553TydsR0J2O3bdtTU8HwVAnrgOSmTE+2ZK
	 EL0LuhJXxhUlta92Gi58+SHKBDi6iJpiD7A/h/KUgUdD1irSnPrmIuqEk7Y6rUBdVf
	 3B5xa4MrcUL5OH4oLF1HQJllxlsSUZGFCTCjjzTk4YvmEIsaYWYbUVFTCpiblyqLKe
	 AtbOupgzDci8+wqbEwJmKUaow9KI1kxTo2b2ozXVwwtldOqVkIH3KSOWUEYhbAO/yF
	 9TF0TL+jgnmj5u46TslTw9/YH79h2iSVMRKu1aCnRK1aDIRFpI/+z/DmcTpgxZUB9t
	 2MK3fyGN+hWnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] scsi: target: Move I/O path stats to per CPU
Date: Fri, 13 Nov 2026 10:38:41 -0500
Message-ID: <20261113153803.1958765-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201023-failed-6.6-6a6e7d7230cd@kernel.org>
References: <20261109201023-failed-6.6-6a6e7d7230cd@kernel.org>
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

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 9cf2317b795d6cde0fccb8744b5a080a9586020e ]

The atomic use in the main I/O path is causing perf issues when using
higher performance backend devices and multiple queues. This moves the
stats to per CPU. Combined with the next patch that moves the
non_ordered/delayed_cmd_count to per CPU, IOPS by up to 33% for 8K IOS
when using 4 or more queues.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Link: https://lore.kernel.org/r/20250424032741.16216-2-michael.christie@oracle.com
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 6a6e7d7230cd ("scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c | 69 +++++++++++++++++++++--------
 drivers/target/target_core_stat.c   | 69 ++++++++++++++++++++++++-----
 include/target/target_core_base.h   | 20 ++++++---
 3 files changed, 121 insertions(+), 37 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index dd041ee18ac9b..60ea1a317065a 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -56,14 +56,14 @@ transport_lookup_cmd_lun(struct se_cmd *se_cmd)
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, se_cmd->orig_fe_lun);
 	if (deve) {
-		atomic_long_inc(&deve->total_cmds);
+		this_cpu_inc(deve->stats->total_cmds);
 
 		if (se_cmd->data_direction == DMA_TO_DEVICE)
-			atomic_long_add(se_cmd->data_length,
-					&deve->write_bytes);
+			this_cpu_add(deve->stats->write_bytes,
+				     se_cmd->data_length);
 		else if (se_cmd->data_direction == DMA_FROM_DEVICE)
-			atomic_long_add(se_cmd->data_length,
-					&deve->read_bytes);
+			this_cpu_add(deve->stats->read_bytes,
+				     se_cmd->data_length);
 
 		if ((se_cmd->data_direction == DMA_TO_DEVICE) &&
 		    deve->lun_access_ro) {
@@ -127,14 +127,14 @@ transport_lookup_cmd_lun(struct se_cmd *se_cmd)
 	 * target_core_fabric_configfs.c:target_fabric_port_release
 	 */
 	se_cmd->se_dev = rcu_dereference_raw(se_lun->lun_se_dev);
-	atomic_long_inc(&se_cmd->se_dev->num_cmds);
+	this_cpu_inc(se_cmd->se_dev->stats->total_cmds);
 
 	if (se_cmd->data_direction == DMA_TO_DEVICE)
-		atomic_long_add(se_cmd->data_length,
-				&se_cmd->se_dev->write_bytes);
+		this_cpu_add(se_cmd->se_dev->stats->write_bytes,
+			     se_cmd->data_length);
 	else if (se_cmd->data_direction == DMA_FROM_DEVICE)
-		atomic_long_add(se_cmd->data_length,
-				&se_cmd->se_dev->read_bytes);
+		this_cpu_add(se_cmd->se_dev->stats->read_bytes,
+			     se_cmd->data_length);
 
 	return ret;
 }
@@ -323,6 +323,7 @@ int core_enable_device_list_for_node(
 	struct se_portal_group *tpg)
 {
 	struct se_dev_entry *orig, *new;
+	int ret = 0;
 
 	new = kzalloc(sizeof(*new), GFP_KERNEL);
 	if (!new) {
@@ -330,6 +331,12 @@ int core_enable_device_list_for_node(
 		return -ENOMEM;
 	}
 
+	new->stats = alloc_percpu(struct se_dev_entry_io_stats);
+	if (!new->stats) {
+		ret = -ENOMEM;
+		goto free_deve;
+	}
+
 	spin_lock_init(&new->ua_lock);
 	INIT_LIST_HEAD(&new->ua_list);
 	INIT_LIST_HEAD(&new->lun_link);
@@ -352,8 +359,8 @@ int core_enable_device_list_for_node(
 			       " for dynamic -> explicit NodeACL conversion:"
 				" %s\n", nacl->initiatorname);
 			mutex_unlock(&nacl->lun_entry_mutex);
-			kfree(new);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_stats;
 		}
 		if (orig->se_lun_acl != NULL) {
 			pr_warn_ratelimited("Detected existing explicit"
@@ -361,8 +368,8 @@ int core_enable_device_list_for_node(
 				" mapped_lun: %llu, failing\n",
 				 nacl->initiatorname, mapped_lun);
 			mutex_unlock(&nacl->lun_entry_mutex);
-			kfree(new);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_stats;
 		}
 
 		new->se_lun = lun;
@@ -395,6 +402,20 @@ int core_enable_device_list_for_node(
 
 	target_luns_data_has_changed(nacl, new, true);
 	return 0;
+
+free_stats:
+	free_percpu(new->stats);
+free_deve:
+	kfree(new);
+	return ret;
+}
+
+static void target_free_dev_entry(struct rcu_head *head)
+{
+	struct se_dev_entry *deve = container_of(head, struct se_dev_entry,
+						 rcu_head);
+	free_percpu(deve->stats);
+	kfree(deve);
 }
 
 void core_disable_device_list_for_node(
@@ -444,7 +465,7 @@ void core_disable_device_list_for_node(
 	kref_put(&orig->pr_kref, target_pr_kref_release);
 	wait_for_completion(&orig->pr_comp);
 
-	kfree_rcu(orig, rcu_head);
+	call_rcu(&orig->rcu_head, target_free_dev_entry);
 
 	core_scsi3_free_pr_reg_from_nacl(dev, nacl);
 	target_luns_data_has_changed(nacl, NULL, false);
@@ -690,11 +711,13 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	if (!dev)
 		return NULL;
 
+	dev->stats = alloc_percpu(struct se_dev_io_stats);
+	if (!dev->stats)
+		goto free_device;
+
 	dev->queues = kcalloc(nr_cpu_ids, sizeof(*dev->queues), GFP_KERNEL);
-	if (!dev->queues) {
-		hba->backend->ops->free_device(dev);
-		return NULL;
-	}
+	if (!dev->queues)
+		goto free_stats;
 
 	dev->queue_cnt = nr_cpu_ids;
 	for (i = 0; i < dev->queue_cnt; i++) {
@@ -708,6 +731,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 		INIT_WORK(&q->sq.work, target_queued_submit_work);
 	}
 
+
 	dev->se_hba = hba;
 	dev->transport = hba->backend->ops;
 	dev->transport_flags = dev->transport->transport_flags_default;
@@ -791,6 +815,12 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 		sizeof(dev->t10_wwn.revision));
 
 	return dev;
+
+free_stats:
+	free_percpu(dev->stats);
+free_device:
+	hba->backend->ops->free_device(dev);
+	return NULL;
 }
 
 /*
@@ -1001,6 +1031,7 @@ void target_free_device(struct se_device *dev)
 		dev->transport->free_prot(dev);
 
 	kfree(dev->queues);
+	free_percpu(dev->stats);
 	dev->transport->free_device(dev);
 }
 
diff --git a/drivers/target/target_core_stat.c b/drivers/target/target_core_stat.c
index c42cbde8a31b3..576d07a8484e3 100644
--- a/drivers/target/target_core_stat.c
+++ b/drivers/target/target_core_stat.c
@@ -280,30 +280,51 @@ static ssize_t target_stat_lu_num_cmds_show(struct config_item *item,
 		char *page)
 {
 	struct se_device *dev = to_stat_lu_dev(item);
+	struct se_dev_io_stats *stats;
+	unsigned int cpu;
+	u32 cmds = 0;
+
+	for_each_possible_cpu(cpu) {
+		stats = per_cpu_ptr(dev->stats, cpu);
+		cmds += stats->total_cmds;
+	}
 
 	/* scsiLuNumCommands */
-	return snprintf(page, PAGE_SIZE, "%lu\n",
-			atomic_long_read(&dev->num_cmds));
+	return snprintf(page, PAGE_SIZE, "%u\n", cmds);
 }
 
 static ssize_t target_stat_lu_read_mbytes_show(struct config_item *item,
 		char *page)
 {
 	struct se_device *dev = to_stat_lu_dev(item);
+	struct se_dev_io_stats *stats;
+	unsigned int cpu;
+	u32 bytes = 0;
+
+	for_each_possible_cpu(cpu) {
+		stats = per_cpu_ptr(dev->stats, cpu);
+		bytes += stats->read_bytes;
+	}
 
 	/* scsiLuReadMegaBytes */
-	return snprintf(page, PAGE_SIZE, "%lu\n",
-			atomic_long_read(&dev->read_bytes) >> 20);
+	return snprintf(page, PAGE_SIZE, "%u\n", bytes >> 20);
 }
 
 static ssize_t target_stat_lu_write_mbytes_show(struct config_item *item,
 		char *page)
 {
 	struct se_device *dev = to_stat_lu_dev(item);
+	struct se_dev_io_stats *stats;
+	unsigned int cpu;
+	u32 bytes = 0;
+
+	for_each_possible_cpu(cpu) {
+		stats = per_cpu_ptr(dev->stats, cpu);
+		bytes += stats->write_bytes;
+	}
 
 	/* scsiLuWrittenMegaBytes */
-	return snprintf(page, PAGE_SIZE, "%lu\n",
-			atomic_long_read(&dev->write_bytes) >> 20);
+	return snprintf(page, PAGE_SIZE, "%u\n", bytes >> 20);
 }
 
 static ssize_t target_stat_lu_resets_show(struct config_item *item, char *page)
@@ -1019,8 +1040,11 @@ static ssize_t target_stat_auth_num_cmds_show(struct config_item *item,
 {
 	struct se_lun_acl *lacl = auth_to_lacl(item);
 	struct se_node_acl *nacl = lacl->se_lun_nacl;
+	struct se_dev_entry_io_stats *stats;
 	struct se_dev_entry *deve;
+	unsigned int cpu;
 	ssize_t ret;
+	u32 cmds = 0;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, lacl->mapped_lun);
@@ -1028,9 +1052,14 @@ static ssize_t target_stat_auth_num_cmds_show(struct config_item *item,
 		rcu_read_unlock();
 		return -ENODEV;
 	}
+
+	for_each_possible_cpu(cpu) {
+		stats = per_cpu_ptr(deve->stats, cpu);
+		cmds += stats->total_cmds;
+	}
+
 	/* scsiAuthIntrOutCommands */
-	ret = snprintf(page, PAGE_SIZE, "%lu\n",
-		       atomic_long_read(&deve->total_cmds));
+	ret = snprintf(page, PAGE_SIZE, "%u\n", cmds);
 	rcu_read_unlock();
 	return ret;
 }
@@ -1040,8 +1069,11 @@ static ssize_t target_stat_auth_read_mbytes_show(struct config_item *item,
 {
 	struct se_lun_acl *lacl = auth_to_lacl(item);
 	struct se_node_acl *nacl = lacl->se_lun_nacl;
+	struct se_dev_entry_io_stats *stats;
 	struct se_dev_entry *deve;
+	unsigned int cpu;
 	ssize_t ret;
+	u32 bytes = 0;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, lacl->mapped_lun);
@@ -1049,9 +1081,14 @@ static ssize_t target_stat_auth_read_mbytes_show(struct config_item *item,
 		rcu_read_unlock();
 		return -ENODEV;
 	}
+
+	for_each_possible_cpu(cpu) {
+		stats = per_cpu_ptr(deve->stats, cpu);
+		bytes += stats->read_bytes;
+	}
+
 	/* scsiAuthIntrReadMegaBytes */
-	ret = snprintf(page, PAGE_SIZE, "%u\n",
-		      (u32)(atomic_long_read(&deve->read_bytes) >> 20));
+	ret = snprintf(page, PAGE_SIZE, "%u\n", bytes >> 20);
 	rcu_read_unlock();
 	return ret;
 }
@@ -1061,8 +1098,11 @@ static ssize_t target_stat_auth_write_mbytes_show(struct config_item *item,
 {
 	struct se_lun_acl *lacl = auth_to_lacl(item);
 	struct se_node_acl *nacl = lacl->se_lun_nacl;
+	struct se_dev_entry_io_stats *stats;
 	struct se_dev_entry *deve;
+	unsigned int cpu;
 	ssize_t ret;
+	u32 bytes = 0;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, lacl->mapped_lun);
@@ -1070,9 +1110,14 @@ static ssize_t target_stat_auth_write_mbytes_show(struct config_item *item,
 		rcu_read_unlock();
 		return -ENODEV;
 	}
+
+	for_each_possible_cpu(cpu) {
+		stats = per_cpu_ptr(deve->stats, cpu);
+		bytes += stats->write_bytes;
+	}
+
 	/* scsiAuthIntrWrittenMegaBytes */
-	ret = snprintf(page, PAGE_SIZE, "%u\n",
-		      (u32)(atomic_long_read(&deve->write_bytes) >> 20));
+	ret = snprintf(page, PAGE_SIZE, "%u\n", bytes >> 20);
 	rcu_read_unlock();
 	return ret;
 }
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 159567359bbb0..8874503b8af47 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -660,15 +660,19 @@ struct se_lun_acl {
 	struct se_ml_stat_grps	ml_stat_grps;
 };
 
+struct se_dev_entry_io_stats {
+	u32			total_cmds;
+	u32			read_bytes;
+	u32			write_bytes;
+};
+
 struct se_dev_entry {
 	u64			mapped_lun;
 	u64			pr_res_key;
 	u64			creation_time;
 	bool			lun_access_ro;
 	u32			attach_count;
-	atomic_long_t		total_cmds;
-	atomic_long_t		read_bytes;
-	atomic_long_t		write_bytes;
+	struct se_dev_entry_io_stats __percpu	*stats;
 	/* Used for PR SPEC_I_PT=1 and REGISTER_AND_MOVE */
 	struct kref		pr_kref;
 	struct completion	pr_comp;
@@ -790,6 +794,12 @@ struct se_device_queue {
 	struct se_cmd_queue	sq;
 };
 
+struct se_dev_io_stats {
+	u32			total_cmds;
+	u32			read_bytes;
+	u32			write_bytes;
+};
+
 struct se_device {
 	/* Used for SAM Task Attribute ordering */
 	u32			dev_cur_ordered_id;
@@ -811,9 +821,7 @@ struct se_device {
 	atomic_long_t		num_resets;
 	atomic_long_t		aborts_complete;
 	atomic_long_t		aborts_no_task;
-	atomic_long_t		num_cmds;
-	atomic_long_t		read_bytes;
-	atomic_long_t		write_bytes;
+	struct se_dev_io_stats __percpu	*stats;
 	/* Active commands on this virtual SE device */
 	atomic_t		non_ordered;
 	bool			ordered_sync_in_progress;
-- 
2.53.0

