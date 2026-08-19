Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4D480DCD;
	Wed, 19 Aug 2026 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154792; cv=none; b=g2sl0KYt19KA6WjdIxFUMeUWZblKY48xpIJXcdYijT3cX/W/spNvQDEQxs60Yurnv5FbBa+HahQb7HTyfpF2fvM1iQwA26/q4MWpMFCopbO15qpnCrtWOiGlJpNjbemu5oBKJPFgn3Yc8b5ioQP6gZh+5vZdqPGpU9tPDancJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154792; c=relaxed/simple;
	bh=dISYKAJ7ZTYFk9RiBLR7zVrw1iL2r8Ul9aDfuHAiFOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MEhMdvQc0vWXDEzRk4fj8aKy5CkYNpnw9mrVJkGkpgrbxw4zmX30/IqW/nHHoilVjBVle+67MvDRaoEc7wWo+2Kmzx7p/1vhcv4XEBQhatu2BjNl+VubFrXVXr/vURLbkk/KCc5T3uxC4VO75VSkhN/QwuzT7e9Q4rpQPajOGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=W6UvOtxS; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="W6UvOtxS"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a95ff6de;
	Wed, 19 Aug 2026 23:52:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2 1/3] fs: configfs: add helper to identify configfs paths
Date: Wed, 19 Aug 2026 23:52:26 +0800
Message-Id: <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01ab9890a03a1kunm38a93da01445bb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQxhCVk5CSUJDTEMYGB9OGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=W6UvOtxSnCsHUR6W1AH8fkpsNrYUexXjJ9zDaDbaFzvYUxx8h1E7Wk1ZxgK9OXKvXWX2b7GswVYoHCNIQuzS5FjJ/D1FDnJQF0SutYEfQb+qvdAVE608fcMEwkSwgYuDWIP+x1kh845EOaKTShiLjtpF3w5UwWt+U14FQrjvlaE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=zYlm9WNLox2kaFNQpUZgFMheB5hPrtAfLIyn5XxB4ik=;
	h=date:mime-version:subject:message-id:from;

Several nvmet paths need to identify configfs-backed resolved paths while
already running under configfs callbacks. Keep the classification in
configfs itself so callers can reuse the filesystem-type test instead of
open-coding string comparisons.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 fs/configfs/mount.c      | 6 ++++++
 include/linux/configfs.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 456c4a2efb53..1204421b61df 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -120,6 +120,12 @@ static struct file_system_type configfs_fs_type = {
 };
 MODULE_ALIAS_FS("configfs");
 
+bool configfs_path_is_configfs(const struct path *path)
+{
+	return path->dentry->d_sb->s_type == &configfs_fs_type;
+}
+EXPORT_SYMBOL_GPL(configfs_path_is_configfs);
+
 struct dentry *configfs_pin_fs(void)
 {
 	int err = simple_pin_fs(&configfs_fs_type, &configfs_mount,
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 698520b1bfdb..b3426c952835 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -34,6 +34,7 @@ struct configfs_group_operations;
 struct configfs_attribute;
 struct configfs_bin_attribute;
 struct configfs_subsystem;
+struct path;
 
 struct config_item {
 	char			*ci_name;
@@ -243,6 +244,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys);
 int configfs_register_group(struct config_group *parent_group,
 			    struct config_group *group);
 void configfs_unregister_group(struct config_group *group);
+bool configfs_path_is_configfs(const struct path *path);
 
 void configfs_remove_default_groups(struct config_group *group);
 
-- 
2.34.1
