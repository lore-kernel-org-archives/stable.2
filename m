Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489243785D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226139; cv=none; b=tujcmbukrmoJ8KtiPh+2OxvomneacOgZqZYmulU4WRcdaYyfoLLMz9b0abrADRVw4oy7p/lltaDn1W9DZvCUJgL3y8KwIKkWQpJgkiFXUH0yeSgYfHS6oE8RQNuCrHyEopJIIInP5c4aBUInjX+rJ4DR9miWKtcuLIN8bAqAxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226139; c=relaxed/simple;
	bh=cViwmYAJmlWYnpVRql5SRECqnt/U+vNNneWFyFTYKx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKL12GteP9ivML+BQAOJICe0nMmp4isgmAV6q6LHmBn9UCC1XzJ5lIshcEoK4ijZvj4UZUIKNTPYiScygLEsoajD7m5B2ZKTnEfDaQ1LE3qOrhl2vD3zXUZUMO9m5vHTCu9kdwFz8Mt6TZAjPy+efmWtcE/yptZg3adyLSbeBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=infC7j61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="infC7j61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2632E1F00A3F;
	Thu, 16 Jul 2026 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226127;
	bh=S3NYo/3awEhjTfuE3VxeGUo3M2/l/GktH7GMLs2NSqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=infC7j61Gt+ROM9k3uKRBnUUM7gIFQpYKG5yFdIgq4FcJ4pkFptdz10Q2AvRZch4F
	 eDCD8jnsRJGcdWPb1u3wM+Xy2P/bxKR7bFKef+ayNUnTv9MnH8al+Q0xfBbA4yawu3
	 7JSq3pyCEv8T1J5ryzRRB/MJbfsvgJs2rCKrdCqYGioX4mzyW57uTJBk+oZiNI73OV
	 sd3oKtACZ0DJru8rxQAVbfkGEqPnl1UsYNjqyu6SscFjp476tLl+OI7YG4HIsN6L8h
	 BApdA7nanB3ctDC6Qd8hxiiTCRN4c1MxiwvG6kMEJhZ/PsOv9ZKUyEBnGmatiY/jFj
	 JGDjPLHmXPD9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/7] smb: move some duplicate definitions to common/cifsglob.h
Date: Thu, 16 Jul 2026 14:21:59 -0400
Message-ID: <20260716182205.921233-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071415-rambling-chooser-b760@gregkh>
References: <2026071415-rambling-chooser-b760@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit d877470b59910b5c50383d634dda3782386bba51 ]

In order to maintain the code more easily, move duplicate definitions to
new common header file.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: c1016dd1d8b2 ("ksmbd: track the connection owning a byte-range lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h         | 18 +-----------------
 fs/ksmbd/smb_common.h      | 14 +-------------
 fs/smbfs_common/cifsglob.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 30 deletions(-)
 create mode 100644 fs/smbfs_common/cifsglob.h

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 68b9b382d44bf2..f8b869a6231df3 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -22,6 +22,7 @@
 #include <crypto/internal/hash.h>
 #include <linux/scatterlist.h>
 #include <uapi/linux/cifs/cifs_mount.h>
+#include "../smbfs_common/cifsglob.h"
 #include "smb2pdu.h"
 #include "smb2glob.h"
 
@@ -566,12 +567,6 @@ get_rfc1002_length(void *buf)
 	return be32_to_cpu(*((__be32 *)buf)) & 0xffffff;
 }
 
-static inline void
-inc_rfc1001_len(void *buf, int count)
-{
-	be32_add_cpu((__be32 *)buf, count);
-}
-
 struct TCP_Server_Info {
 	struct list_head tcp_ses_list;
 	struct list_head smb_ses_list;
@@ -842,7 +837,6 @@ compare_mid(__u16 mid, const struct smb_hdr *smb)
  * pages in a single call. With PAGE_SIZE == 4k, this means we can fill
  * a single wsize request with a single call.
  */
-#define CIFS_DEFAULT_IOSIZE (1024 * 1024)
 #define SMB3_DEFAULT_IOSIZE (4 * 1024 * 1024)
 
 /*
@@ -1905,30 +1899,20 @@ extern __u32 cifs_lock_secret;
 extern mempool_t *cifs_mid_poolp;
 
 /* Operations for different SMB versions */
-#define SMB1_VERSION_STRING	"1.0"
-#define SMB20_VERSION_STRING    "2.0"
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 extern struct smb_version_operations smb1_operations;
 extern struct smb_version_values smb1_values;
 extern struct smb_version_operations smb20_operations;
 extern struct smb_version_values smb20_values;
 #endif /* CIFS_ALLOW_INSECURE_LEGACY */
-#define SMB21_VERSION_STRING	"2.1"
 extern struct smb_version_operations smb21_operations;
 extern struct smb_version_values smb21_values;
-#define SMBDEFAULT_VERSION_STRING "default"
 extern struct smb_version_values smbdefault_values;
-#define SMB3ANY_VERSION_STRING "3"
 extern struct smb_version_values smb3any_values;
-#define SMB30_VERSION_STRING	"3.0"
 extern struct smb_version_operations smb30_operations;
 extern struct smb_version_values smb30_values;
-#define SMB302_VERSION_STRING	"3.02"
-#define ALT_SMB302_VERSION_STRING "3.0.2"
 /*extern struct smb_version_operations smb302_operations;*/ /* not needed yet */
 extern struct smb_version_values smb302_values;
-#define SMB311_VERSION_STRING	"3.1.1"
-#define ALT_SMB311_VERSION_STRING "3.11"
 extern struct smb_version_operations smb311_operations;
 extern struct smb_version_values smb311_values;
 
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index c4978579c5412b..9d8cf9facf3d3d 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -10,6 +10,7 @@
 
 #include "glob.h"
 #include "nterr.h"
+#include "../smbfs_common/cifsglob.h"
 #include "smb2pdu.h"
 
 /* ksmbd's Specific ERRNO */
@@ -25,13 +26,6 @@
 #define SMB311_PROT		6
 #define BAD_PROT		0xFFFF
 
-#define SMB1_VERSION_STRING	"1.0"
-#define SMB20_VERSION_STRING	"2.0"
-#define SMB21_VERSION_STRING	"2.1"
-#define SMB30_VERSION_STRING	"3.0"
-#define SMB302_VERSION_STRING	"3.02"
-#define SMB311_VERSION_STRING	"3.1.1"
-
 /* Dialects */
 #define SMB10_PROT_ID		0x00
 #define SMB20_PROT_ID		0x0202
@@ -45,7 +39,6 @@
 
 #define SMB_ECHO_INTERVAL	(60 * HZ)
 
-#define CIFS_DEFAULT_IOSIZE	(64 * 1024)
 #define MAX_CIFS_SMALL_BUFFER_SIZE 448 /* big enough for most */
 
 #define MAX_STREAM_PROT_LEN	0x00FFFFFF
@@ -507,9 +500,4 @@ static inline unsigned int get_rfc1002_len(void *buf)
 {
 	return be32_to_cpu(*((__be32 *)buf)) & 0xffffff;
 }
-
-static inline void inc_rfc1001_len(void *buf, int count)
-{
-	be32_add_cpu((__be32 *)buf, count);
-}
 #endif /* __SMB_COMMON_H__ */
diff --git a/fs/smbfs_common/cifsglob.h b/fs/smbfs_common/cifsglob.h
new file mode 100644
index 00000000000000..00fd215e3eb547
--- /dev/null
+++ b/fs/smbfs_common/cifsglob.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+/*
+ *
+ *   Copyright (C) International Business Machines  Corp., 2002,2008
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *              Jeremy Allison (jra@samba.org)
+ *
+ */
+#ifndef _COMMON_CIFS_GLOB_H
+#define _COMMON_CIFS_GLOB_H
+
+static inline void inc_rfc1001_len(void *buf, int count)
+{
+	be32_add_cpu((__be32 *)buf, count);
+}
+
+#define SMB1_VERSION_STRING	"1.0"
+#define SMB20_VERSION_STRING    "2.0"
+#define SMB21_VERSION_STRING	"2.1"
+#define SMBDEFAULT_VERSION_STRING "default"
+#define SMB3ANY_VERSION_STRING "3"
+#define SMB30_VERSION_STRING	"3.0"
+#define SMB302_VERSION_STRING	"3.02"
+#define ALT_SMB302_VERSION_STRING "3.0.2"
+#define SMB311_VERSION_STRING	"3.1.1"
+#define ALT_SMB311_VERSION_STRING "3.11"
+
+#define CIFS_DEFAULT_IOSIZE (1024 * 1024)
+
+#endif	/* _COMMON_CIFS_GLOB_H */
-- 
2.53.0

