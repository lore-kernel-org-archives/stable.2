Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E732E121;
	Mon, 21 Sep 2026 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981617; cv=none; b=iQrTbmxzXzUC7m6y4GI//3H5IUan+CymYYsLGRK6q/i/59ueeFd3k3pstcAlEasi/8g1o9Gt9K+uC8CN8JaccE5KbhavP23YtLWP+Pun/2t/9CB8mvL44k+rCmoeK8u0do8DUK/QkfUwHw8P0JvQotkx4VrpoQOqs+/rS87MSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981617; c=relaxed/simple;
	bh=STo49Godg6DLVIS4A3fquG3iQwdFcMAQTL+yZDX8aAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GG/HtFQ5RALPqELGqc1QWdhoFcvsnH+fNcg33AlVOo1UtMzS0LzaXGdLwh8dd8t1RFtJQ7PEOfqoHyGPhG+atuCLYuNx1qtPUIaYfvSOUNp8bvRSL+WiA9EPFhwgWBYioEhBVwBFZY1dkPOTtUZWJKoSWILp3fQLWBzuxFqASgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ibOsf5Hw; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ibOsf5Hw"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8e7465e;
	Mon, 21 Sep 2026 17:06:43 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v4 1/3] fs: configfs: add helpers for opening non-configfs paths
Date: Mon, 21 Sep 2026 17:05:57 +0800
Message-Id: <20260921090559.41364-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090559.41364-1-runyu.xiao@seu.edu.cn>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c337b5c503a1kunm2bb71b5a41172
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGk9JVh5JSh5LSUkYSEhDSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ibOsf5HwXz/CY07TG0jgmH5PQqIvHGw4W50Q2zgE9wHBO5rZQ4/iMcnilDDCpnZhXL8guqo9PoDEkQ6v6pxo4/8bdlhh2CNuoix7QQxTvOuKo7HOMlJVgzthd7ZvN4NgRO45MCbm0sxlhzmcvnlUjJW6rrZmyvfNBtb7dlkWdm0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=FrHsZaSHjKajBX0rdMRb30xqwkz5sNsC48iENtcmYd8=;
	h=date:mime-version:subject:message-id:from;

Configfs store callbacks may open user-configured paths while holding an
item frag_sem. Opening a configfs path from such a callback can re-enter
configfs and try to acquire the same semaphore.

Add helpers that reject configfs paths by comparing the actual filesystem
type and open the resolved path with file_open_root(), preserving normal
open-time permission and security checks. Provide a root-relative form for
callers that retain a resolved root and may create a file below it.

Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 fs/configfs/mount.c      | 33 +++++++++++++++++++++++++++++++++
 include/linux/configfs.h |  6 ++++++
 2 files changed, 39 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d8cac1cbf3bd5..77e1788ce2372 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -118,6 +119,38 @@ static struct file_system_type configfs_fs_type = {
 };
 MODULE_ALIAS_FS("configfs");
 
+bool configfs_path_is_configfs(const struct path *path)
+{
+	return path->dentry->d_sb->s_type == &configfs_fs_type;
+}
+EXPORT_SYMBOL_GPL(configfs_path_is_configfs);
+
+struct file *configfs_open_root(const struct path *root, const char *name,
+				int flags, umode_t mode)
+{
+	if (configfs_path_is_configfs(root))
+		return ERR_PTR(-EINVAL);
+
+	return file_open_root(root, name, flags, mode);
+}
+EXPORT_SYMBOL_GPL(configfs_open_root);
+
+struct file *configfs_file_open(const char *filename, int flags, umode_t mode)
+{
+	struct file *file;
+	struct path path;
+	int ret;
+
+	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	file = configfs_open_root(&path, "", flags, mode);
+	path_put(&path);
+	return file;
+}
+EXPORT_SYMBOL_GPL(configfs_file_open);
+
 struct dentry *configfs_pin_fs(void)
 {
 	int err = simple_pin_fs(&configfs_fs_type, &configfs_mount,
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index ef65c75beeaad..768132b2be1ae 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -34,6 +34,8 @@ struct configfs_group_operations;
 struct configfs_attribute;
 struct configfs_bin_attribute;
 struct configfs_subsystem;
+struct file;
+struct path;
 
 struct config_item {
 	char			*ci_name;
@@ -243,6 +245,10 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys);
 int configfs_register_group(struct config_group *parent_group,
 			    struct config_group *group);
 void configfs_unregister_group(struct config_group *group);
+bool configfs_path_is_configfs(const struct path *path);
+struct file *configfs_open_root(const struct path *root, const char *name,
+				int flags, umode_t mode);
+struct file *configfs_file_open(const char *filename, int flags, umode_t mode);
 
 void configfs_remove_default_groups(struct config_group *group);
 
-- 
2.34.1

