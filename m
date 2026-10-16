Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37A33F5AA
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113447; cv=none; b=EnI5EO8iKeht0nck7C1sd2U/KZMRxUXAX3+i9W2DA5VLw26OhTe4zKDGcIcestJXDQv6FTXqfJu16ck00URTjXYeqGtqsrfyNBG0H1nNLFOMrUhaCBXXbcgxEwznTohOboWJ2yXd8STFFrQ2VadqlU6/PXhGYn5bu0NRfrnEGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113447; c=relaxed/simple;
	bh=SJ/jG8MLQshaLuhuluYLLcj2s2DRB1st0MberlN5Xn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krdvAu5MpaSZTGR4Tahl30gPs75wNdtR87bQFUbwRTwxk4YjzYvk80YR6fvV3rjeCJrsZU54WPgbqZlhvkAE42bluglO6eb8eXKkdfXX8o9WjdgB41HoVIf60uw4WQL36Y2Ruwha4rNK79nI2vkEfK32gQqZ/i9IewNOLcMy0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtA4PMHY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtA4PMHY"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8917c712f32so2818438b3a.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113441; x=1792718241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kt9FQDsR1MLn/kxVOoumsCY08npA6k90Pz+IFSTIf/4=;
        b=qtA4PMHYkPBEq3zuWGZUi5OI9/e3x5TELtHQc/iN1zFJhVJon9El7OJrR1PH1ARGy6
         5GGVXKL/Yu+jCNZTvo7XMi08+iL/zPv/Js9V0/v8U1WJHAhhkc3epzpIt7pTQg/gVKnF
         DDh1yxkH5YCfXNueJ/5BeRfogpUxuWre9UMRRP9aMQ6JMVfieXen97gd+Od9y2WntfJJ
         J54xTtyr8jC4OXzEBsR2XHfr/TYWS3Y7ZkXzwXfP002O+Y4NkuslbYcd4vLgCqVjD11c
         S4BjANuMjvAqmkaJdEEZ5nBaO80PmiHFm7/0HCIdiFOSq8IWrn4ap0u2dgpsnZibk1ze
         LGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113441; x=1792718241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kt9FQDsR1MLn/kxVOoumsCY08npA6k90Pz+IFSTIf/4=;
        b=1vuxnLXkE5W9g/Aoh+jSAcC8JBwq4sM4H6AX3rCiIl36AVcPzMZAFGqn/a1hG2xrqd
         efHtjM8ng/MqJoH9kNsu/ANRYMH1rswXcV4qeOSwXKTKapN8ZcDA5lVTkPYGG1holR9y
         N88ngckymUJ5iWs4rDVvjbit+9xRo7483Pe6UUqSSLD9l8YBQ8QO8xqq3xnqll0WjTKN
         iM3ZNy/K8P/qbw5LvBNNLdTBRMtfqVlPuQLkVBvObj7kJVYvSzKk6CV7mYHan91oGWtN
         sOW6Acijng7JKf6u6igvi2S957g0ZhXzagXysAGnbWmXYbP02JkUjLMt32IGO791W2DR
         13vw==
X-Forwarded-Encrypted: i=1; AKwUvByIhljB+QRt+qxRzgxKyOiL0qxJiPxCiDSKIp+3KA0WBioCNgMDiHMEE+zgteGZJOw2NmSJKOk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2ig7Sk+8uJylSkqFNklQ86O1KpOrKf72nAB14coX7zzIik0/n
	u7aowbud0vHrQB0RTZNT7jOz8xKwS8lW7sOel3opLLBAFn+cBpCR6GsG
X-Gm-Gg: AYBFou2qa9O9W2sCP9s+uVZgohKTyCalFXoS9O7Ks83yd2k/9Tzuba7SEneb/ckoNPV
	Tq9EQ5iGNakGEYsezKm6u/x7aOmckh0BKTBina6WW1DjbLIPeSagG3o3bMg2VZqdOXkDzzhErBI
	5ZSs0XW9sl+0yrxYbwNmp5DbPA1jj1Qa+hLIus0Eg03sQBlU7S+CCHZcKu1+q3Whtex+PIp00aQ
	i9ceQdHde+ynVALwkpr0FnLSfmwe/TyJj3ukR3y+NLzjm+XySgI2djTF6sgv5jCnxyhPBVUYMDF
	LpQXN5WZMVYY+ohx8ldXwenFZz+WQu/pRW2Rq5OG2h6aHaCLjXQvcTUmvGgg8A5VAosC9TjtmNV
	XNFYGHUcN2Nfz9xF9zxafe2+Qo/ustiYo7mIcewBDGoI2NE4xEH6kWHWqM3uF/SUeurdQO0pu+L
	bri/g7NRxLX6BGs06eqafJLAu6/ocguHspNEF86B8kc7Z6lNmBfkZ+MkA9U9LNN5CdH9k=
X-Received: by 2002:a05:6a00:9504:b0:878:6ee:671c with SMTP id d2e1a72fcca58-897c700e769mr18527238b3a.30.1792113441269;
        Thu, 15 Oct 2026 18:17:21 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f6ab19e93sm247444b3a.49.2026.10.15.18.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 18:17:20 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com,
	akpm@linux-foundation.org,
	zzzccc427@gmail.com,
	kees@kernel.org,
	kmehltretter@gmail.com,
	christophe.jaillet@wanadoo.fr,
	ericterminal@gmail.com,
	rppt@kernel.org,
	rollkingzzc@gmail.com,
	brauner@kernel.org,
	sunil.mushran@oracle.com,
	kurt.hackel@oracle.com,
	jack@suse.cz
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com
Subject: [PATCH v3] ocfs2: Pin owning modules for open debugfs files
Date: Fri, 16 Oct 2026 09:17:13 +0800
Message-Id: <pm-ocfs2-objects-candidate-0089-v6-f7fda843f80887488145@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OCFS2 debugfs file operation tables do not set owner. The
full debugfs proxy obtains real_fops with fops_get() at open and
keeps it until final release. Without an owner, this does not acquire
a reference to the module containing the table and its callbacks.
Removing the debugfs entries does not drain retained open files.

An open connected_nodes file can therefore outlive ocfs2_nodemanager
and make full_proxy_release() read real_fops->release from freed
module memory. Heming also reproduced the issue with fs_state and
asked for the other OCFS2 debugfs operation tables to be checked.

Set owner to THIS_MODULE in all eleven explicit debugfs operation
tables: five in ocfs2_nodemanager, four in ocfs2_dlm, and two in
ocfs2. The existing debugfs get/put pair then holds the appropriate
module until final release. Leave the open, read and release callbacks
unchanged. The blockcheck table already sets owner through
DEFINE_DEBUGFS_ATTRIBUTE(), so it needs no change.

The original controlled test used an unloadable OCFS2 module and
case-local probe filters without changing the candidate open, unload
or release logic. Closing a retained connected_nodes file after
normal unload produced:

  BUG: unable to handle page fault for address: fffffbfff804cfef
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:full_proxy_release+0xbf/0x190
  Call Trace:
   <TASK>
   __fput+0x39a/0xa60
   fput_close_sync+0xff/0x200
   __x64_sys_close+0x8c/0xf0
   do_syscall_64+0x114/0x620
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  Modules linked in: [last unloaded: ocfs2_nodemanager]

Fixes: 2309e9e040fe ("ocfs2/net: Add debug interface to o2net")
Fixes: 87d3d3f3931f ("ocfs2/hb: Expose the list of heartbeating nodes via debugfs")
Fixes: 3ba169ccec1c ("ocfs2/cluster: Add new function o2net_fill_node_map()")
Fixes: 50397507e856 ("ocfs2: Expose the file system state via debugfs")
Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Fixes: 7209300a9b98 ("ocfs2/dlm: Dumps the purgelist into a debugfs file")
Fixes: d0129aceaecc ("ocfs2/dlm: Dumps the mles into a debugfs file")
Fixes: 4e3d24ed1a12 ("ocfs2/dlm: Dumps the lockres' into a debugfs file")
Fixes: 007dce53a29c ("ocfs2/dlm: Dump the dlm state in a debugfs file")
Assisted-by: LLM
Cc: <stable@vger.kernel.org>
Suggested-by: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
Changes in v3:
- Match each .owner assignment to the indentation of neighboring members
  throughout, as requested by Kees Cook.

Changes in v2:
- Cover fs_state and locking_state in the OCFS2 filesystem module.
- Cover all four OCFS2 DLM debugfs operation tables.
- Keep the five node manager fixes and the original diagnostic.
- Add explicit module headers and Fixes tags for the added tables.
- Add Cc: stable@vger.kernel.org.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0089-v2-4c67f48d4e2d0fc85990@gmail.com
Link to v2: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0089-v5-076c780eeaf45afb2a53@gmail.com

 fs/ocfs2/cluster/heartbeat.c | 1 +
 fs/ocfs2/cluster/netdebug.c  | 4 ++++
 fs/ocfs2/dlm/dlmdebug.c      | 5 +++++
 fs/ocfs2/dlmglue.c           | 2 ++
 fs/ocfs2/super.c             | 1 +
 5 files changed, 13 insertions(+)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 8e6ead433228e7419bfbbe5c7cdde65c654a24f4..1cb516df53f4e1b3b2a292eb2550faa3d16e3fa2 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1447,6 +1447,7 @@ static ssize_t o2hb_debug_read(struct file *file, char __user *buf,
 #endif  /* CONFIG_DEBUG_FS */
 
 static const struct file_operations o2hb_debug_fops = {
+	.owner =	THIS_MODULE,
 	.open =		o2hb_debug_open,
 	.release =	o2hb_debug_release,
 	.read =		o2hb_debug_read,
diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index f7ab66e70799302f3ed4e70ab6a8fb057dd0bfa9..5d373002297de1fdd9a05e270f7942d8c1ce2dac 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -183,6 +183,7 @@ static int nst_fop_release(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations nst_seq_fops = {
+	.owner = THIS_MODULE,
 	.open = nst_fop_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -415,6 +416,7 @@ static int stats_fop_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations stats_seq_fops = {
+	.owner = THIS_MODULE,
 	.open = stats_fop_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -427,6 +429,7 @@ static int sc_fop_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations sc_seq_fops = {
+	.owner = THIS_MODULE,
 	.open = sc_fop_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -476,6 +479,7 @@ static ssize_t o2net_debug_read(struct file *file, char __user *buf,
 }
 
 static const struct file_operations nodes_fops = {
+	.owner		= THIS_MODULE,
 	.open		= nodes_fop_open,
 	.release	= o2net_debug_release,
 	.read		= o2net_debug_read,
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index ce6d301cb9420385211d20d59637069154a89993..8919eb14df22700b36b1edf985bca15b8f185fd6 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2004, 2008 Oracle.  All rights reserved.
  */
 
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -339,6 +340,7 @@ static int debug_purgelist_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations debug_purgelist_fops = {
+	.owner =	THIS_MODULE,
 	.open =		debug_purgelist_open,
 	.release =	debug_release,
 	.read =		debug_read,
@@ -394,6 +396,7 @@ static int debug_mle_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations debug_mle_fops = {
+	.owner =	THIS_MODULE,
 	.open =		debug_mle_open,
 	.release =	debug_release,
 	.read =		debug_read,
@@ -601,6 +604,7 @@ static int debug_lockres_release(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations debug_lockres_fops = {
+	.owner =	THIS_MODULE,
 	.open =		debug_lockres_open,
 	.release =	debug_lockres_release,
 	.read =		seq_read,
@@ -791,6 +795,7 @@ static int debug_state_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations debug_state_fops = {
+	.owner =	THIS_MODULE,
 	.open =		debug_state_open,
 	.release =	debug_release,
 	.read =		debug_read,
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 6bc4a21cf5f02f04a6b54100925084aed239ae62..88d9464660833006b7bac25e2c2641dd77874438 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2003, 2004 Oracle.  All rights reserved.
  */
 
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -3332,6 +3333,7 @@ static int ocfs2_dlm_debug_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations ocfs2_dlm_debug_fops = {
+	.owner =	THIS_MODULE,
 	.open =		ocfs2_dlm_debug_open,
 	.release =	ocfs2_dlm_debug_release,
 	.read =		seq_read,
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 1e76b1d9fe0af4b3cf503e91e1dd077762fef88a..0af2245ae30369421e78ecd781b986c481d10f5b 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -387,6 +387,7 @@ static ssize_t ocfs2_debug_read(struct file *file, char __user *buf,
 #endif	/* CONFIG_DEBUG_FS */
 
 static const struct file_operations ocfs2_osb_debug_fops = {
+	.owner =	THIS_MODULE,
 	.open =		ocfs2_osb_debug_open,
 	.release =	ocfs2_debug_release,
 	.read =		ocfs2_debug_read,
