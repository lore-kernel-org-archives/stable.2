Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87A3AA50B;
	Thu, 10 Sep 2026 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016064; cv=none; b=YRnB+u9xsgN+tayaszHVHRrQgoQ/QsDGQkT4lPzZKBoWdXw8wqOcaouQtJfiDLDSHk7SfdvJOenmEXKC6I0U67I2QyW93sYKKqbR/xqvnD/+tnHeVuuXc9p5VXwpbmYV532sQ+uIvFu5M8llG4AEOR1mh5XGBEHpSRoCEZfkKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016064; c=relaxed/simple;
	bh=+bNs+NW2eCTrCiW0lbLUtsxaYY6RHpLaZqrdvKV1WXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7uHl1kMO+TlteDMThiympHfwYASFiWxivAgF+HDYpBXGp+Mk5NKzf/FT34wSCsthAVhom1C1pPeGdeiwGiCp9RIJtqlx+wiXd4slOl8PWC3s5dmATKxh9tAw7W/otKnUQdLV5UiZWQGv9EZDkulVSMFKuLvhtpnm8V37J3Mzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=bSkdwyPI; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="bSkdwyPI"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3a5a3c9;
	Thu, 10 Sep 2026 12:54:09 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v3 1/3] fs: configfs: add helper to identify configfs paths
Date: Thu, 10 Sep 2026 12:53:58 +0800
Message-Id: <20260910045400.1201582-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
References: <20260902103202.GB8095@lst.de>
 <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089aa866303a1kunm413fe85d18135b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkJCVk1PSk0YShlDSRgdTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pOTE5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bSkdwyPIcJ3stD5RnvEHmBu4J8+aXeueNw7X0bCyuiDoWWKPxbu8raIot9k1oHoO0PBVBccZ/WevE9Z9hRhvQNWHqM6SYF6Hic9+NcocCi6lkkDNa7sq2ofxusZIsS+YmiApuSuPY5gnvSnC1yiUJGjTSGVEFjx+7TCdBb+QUaE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=WNhizG42jNgFw5zLdHr3DZPLKap23a4IhuZPG0ipX6E=;
	h=date:mime-version:subject:message-id:from;

Keep the configfs filesystem type check in configfs so callers can
classify resolved paths without comparing filesystem name strings or
using filesystem-specific magic numbers.

Export the helper for configfs users that need to reject paths into the
configuration filesystem while running from a configfs callback.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 fs/configfs/mount.c      | 6 ++++++
 include/linux/configfs.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d8cac1cbf..8abbe3afa 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -118,6 +118,12 @@ static struct file_system_type configfs_fs_type = {
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
index ef65c75be..55df734da 100644
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
