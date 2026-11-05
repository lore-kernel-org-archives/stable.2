Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901530;
	b=jd9cIBl7h4C9tt8dGSTPTje437bLjhHTI0eQixhjNCBsdFQ/Ud02JyGGpr643jUcW3zl
	 cZoT/vc9jD01OjdKWGn2RZOgdgzNY8ty2W6U7qYT/S7LjvLga4oaz5bwEVxXQN48fAd/j
	 1aWr7/gT8t7TLlkT1nmgpohbwpoYbQVXymO2eYtoiec1gGUR+BfMm5LlBHgpfpfegvlnS
	 Kr1qDkPIBfrh1/ACz9co2v+uldt0K23BsEiZ5oIV3kVHe0HJzNouNh2YWpLVp/YFVovsr
	 BTGQ/sTumbbzGiv7e4YMMxqWewHfYgd5/4y94jVJRQXiZ/2NRN9ssy5C/SiPzhnuqBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zvqqZrWVJDkzy+hfOi59Iy6LWNVjSkAxh/IDN5o5AMY=;
	b=cetLk/PuXxY8I1L/6HZGZzP5bWHFZv6DZNFFLBiRgGrei9qmJafzhJbHluyipsso4nSu
	 iWJMHJ+EO+Rb3WKuk23NTX+q+PHOkcdNQNQvTbssoxWvemvBDBuaJbytFBgAbzqkOuIs1
	 QdA3pp7kuuxny82niE/UT166FeVcuZe+DIFdZyCb5q1lAGWY7vBremn5Q319KfAXZ2QCt
	 Fs+pzZiJH/IOBLgxjizIlWcdzHuuix2N8Yf+ha+vXlswSa/ARgJQfEZq16w3ZFPjDfcVR
	 P7eGtE6ltOZicR6Vv9twY5BRdv/XT89FlJu0nvorrH/Xbi4eBO34ARiygeom7gHCC1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neSEV1NY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957B606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neSEV1NY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615AD1F000C1;
	Thu,  5 Nov 2026 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901530;
	bh=zvqqZrWVJDkzy+hfOi59Iy6LWNVjSkAxh/IDN5o5AMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=neSEV1NYVoEpsDfCuhHk7D2MeBxjpErb/k13ynJKvL+6Zf+GUGqTs4WMLO1YN72WW
	 W9igdga5Xc8ZM5XYa4yS9mw+ydwrlO9ZwBek2/CdLcM4dotKJIb7+fUQPFG9wAosvP
	 MoLH3xAohxmWVatFMJcrI+k3V70vGCV2rtZ11txAR8lKFu4cguS+GTLa0GkfKNQwoJ
	 WtMF0L1gtMN0OZaLRoisWJwRszAj9dON+gbeIN674MrAUjJ3bEBY3XU+gKD3uO2B7p
	 IXTo10opKWGyECGsRnrUXYWLIJvCU8ZZ4mwrHORxfF29BctJr1R7E+o5MC330S19cB
	 YNJZT6y89v0Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/8] smb: move list of FileSystemAttributes to common/fscc.h
Date: Thu,  5 Nov 2026 12:58:41 -0500
Message-ID: <20261105175828.2192358-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105175828.2192358-1-sashal@kernel.org>
References: <2026110435-maternity-atlantic-ccce@gregkh>
 <20261105175828.2192358-1-sashal@kernel.org>
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

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit 84d8d4cf8873b4a9da0d76e9ba9d94ec88311cfd ]

These definitions are exactly the same on both client and server,
so move them to new common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f8171804a39e ("smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h   |  1 +
 fs/smb/client/cifspdu.h    | 27 ------------------------
 fs/smb/common/fscc.h       | 42 ++++++++++++++++++++++++++++++++++++++
 fs/smb/server/smb_common.h | 28 +------------------------
 4 files changed, 44 insertions(+), 54 deletions(-)
 create mode 100644 fs/smb/common/fscc.h

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 8d751026dd4a2..1bccccced31d6 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -27,6 +27,7 @@
 #include <uapi/linux/cifs/cifs_mount.h>
 #include "../common/cifsglob.h"
 #include "../common/smb2pdu.h"
+#include "../common/fscc.h"
 #include "smb2pdu.h"
 #include <linux/filelock.h>
 
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 212cd57357ce2..3ea8aa2a8d2db 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -2100,33 +2100,6 @@ typedef struct {
 /* minimum includes first three fields, and empty FS Name */
 #define MIN_FS_ATTR_INFO_SIZE 12
 
-
-/* List of FileSystemAttributes - see 2.5.1 of MS-FSCC */
-#define FILE_SUPPORTS_SPARSE_VDL	0x10000000 /* faster nonsparse extend */
-#define FILE_SUPPORTS_BLOCK_REFCOUNTING	0x08000000 /* allow ioctl dup extents */
-#define FILE_SUPPORT_INTEGRITY_STREAMS	0x04000000
-#define FILE_SUPPORTS_USN_JOURNAL	0x02000000
-#define FILE_SUPPORTS_OPEN_BY_FILE_ID	0x01000000
-#define FILE_SUPPORTS_EXTENDED_ATTRIBUTES 0x00800000
-#define FILE_SUPPORTS_HARD_LINKS	0x00400000
-#define FILE_SUPPORTS_TRANSACTIONS	0x00200000
-#define FILE_SEQUENTIAL_WRITE_ONCE	0x00100000
-#define FILE_READ_ONLY_VOLUME		0x00080000
-#define FILE_NAMED_STREAMS		0x00040000
-#define FILE_SUPPORTS_ENCRYPTION	0x00020000
-#define FILE_SUPPORTS_OBJECT_IDS	0x00010000
-#define FILE_VOLUME_IS_COMPRESSED	0x00008000
-#define FILE_SUPPORTS_POSIX_UNLINK_RENAME 0x00000400
-#define FILE_RETURNS_CLEANUP_RESULT_INFO  0x00000200
-#define FILE_SUPPORTS_REMOTE_STORAGE	0x00000100
-#define FILE_SUPPORTS_REPARSE_POINTS	0x00000080
-#define FILE_SUPPORTS_SPARSE_FILES	0x00000040
-#define FILE_VOLUME_QUOTAS		0x00000020
-#define FILE_FILE_COMPRESSION		0x00000010
-#define FILE_PERSISTENT_ACLS		0x00000008
-#define FILE_UNICODE_ON_DISK		0x00000004
-#define FILE_CASE_PRESERVED_NAMES	0x00000002
-#define FILE_CASE_SENSITIVE_SEARCH	0x00000001
 typedef struct {
 	__le32 Attributes;
 	__le32 MaxPathNameComponentLength;
diff --git a/fs/smb/common/fscc.h b/fs/smb/common/fscc.h
new file mode 100644
index 0000000000000..c8bfb87232ac0
--- /dev/null
+++ b/fs/smb/common/fscc.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2009, 2013
+ *                 Etersoft, 2012
+ *                 2018 Samsung Electronics Co., Ltd.
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *              Pavel Shilovsky (pshilovsky@samba.org) 2012
+ *              Namjae Jeon (linkinjeon@kernel.org)
+ *
+ */
+#ifndef _COMMON_SMB_FSCC_H
+#define _COMMON_SMB_FSCC_H
+
+/* List of FileSystemAttributes - see MS-FSCC 2.5.1 */
+#define FILE_SUPPORTS_SPARSE_VDL	0x10000000 /* faster nonsparse extend */
+#define FILE_SUPPORTS_BLOCK_REFCOUNTING	0x08000000 /* allow ioctl dup extents */
+#define FILE_SUPPORT_INTEGRITY_STREAMS	0x04000000
+#define FILE_SUPPORTS_USN_JOURNAL	0x02000000
+#define FILE_SUPPORTS_OPEN_BY_FILE_ID	0x01000000
+#define FILE_SUPPORTS_EXTENDED_ATTRIBUTES 0x00800000
+#define FILE_SUPPORTS_HARD_LINKS	0x00400000
+#define FILE_SUPPORTS_TRANSACTIONS	0x00200000
+#define FILE_SEQUENTIAL_WRITE_ONCE	0x00100000
+#define FILE_READ_ONLY_VOLUME		0x00080000
+#define FILE_NAMED_STREAMS		0x00040000
+#define FILE_SUPPORTS_ENCRYPTION	0x00020000
+#define FILE_SUPPORTS_OBJECT_IDS	0x00010000
+#define FILE_VOLUME_IS_COMPRESSED	0x00008000
+#define FILE_SUPPORTS_POSIX_UNLINK_RENAME 0x00000400
+#define FILE_RETURNS_CLEANUP_RESULT_INFO  0x00000200
+#define FILE_SUPPORTS_REMOTE_STORAGE	0x00000100
+#define FILE_SUPPORTS_REPARSE_POINTS	0x00000080
+#define FILE_SUPPORTS_SPARSE_FILES	0x00000040
+#define FILE_VOLUME_QUOTAS		0x00000020
+#define FILE_FILE_COMPRESSION		0x00000010
+#define FILE_PERSISTENT_ACLS		0x00000008
+#define FILE_UNICODE_ON_DISK		0x00000004
+#define FILE_CASE_PRESERVED_NAMES	0x00000002
+#define FILE_CASE_SENSITIVE_SEARCH	0x00000001
+
+#endif /* _COMMON_SMB_FSCC_H */
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 4568896273bec..bea0a250169c3 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -12,6 +12,7 @@
 #include "nterr.h"
 #include "../common/cifsglob.h"
 #include "../common/smb2pdu.h"
+#include "../common/fscc.h"
 #include "smb2pdu.h"
 
 /* ksmbd's Specific ERRNO */
@@ -50,33 +51,6 @@
 #define ATTR_NO_BUFFERING		0x20000000
 #define ATTR_WRITE_THROUGH		0x80000000
 
-/* List of FileSystemAttributes - see 2.5.1 of MS-FSCC */
-#define FILE_SUPPORTS_SPARSE_VDL	0x10000000 /* faster nonsparse extend */
-#define FILE_SUPPORTS_BLOCK_REFCOUNTING	0x08000000 /* allow ioctl dup extents */
-#define FILE_SUPPORT_INTEGRITY_STREAMS	0x04000000
-#define FILE_SUPPORTS_USN_JOURNAL	0x02000000
-#define FILE_SUPPORTS_OPEN_BY_FILE_ID	0x01000000
-#define FILE_SUPPORTS_EXTENDED_ATTRIBUTES 0x00800000
-#define FILE_SUPPORTS_HARD_LINKS	0x00400000
-#define FILE_SUPPORTS_TRANSACTIONS	0x00200000
-#define FILE_SEQUENTIAL_WRITE_ONCE	0x00100000
-#define FILE_READ_ONLY_VOLUME		0x00080000
-#define FILE_NAMED_STREAMS		0x00040000
-#define FILE_SUPPORTS_ENCRYPTION	0x00020000
-#define FILE_SUPPORTS_OBJECT_IDS	0x00010000
-#define FILE_VOLUME_IS_COMPRESSED	0x00008000
-#define FILE_SUPPORTS_POSIX_UNLINK_RENAME 0x00000400
-#define FILE_RETURNS_CLEANUP_RESULT_INFO  0x00000200
-#define FILE_SUPPORTS_REMOTE_STORAGE	0x00000100
-#define FILE_SUPPORTS_REPARSE_POINTS	0x00000080
-#define FILE_SUPPORTS_SPARSE_FILES	0x00000040
-#define FILE_VOLUME_QUOTAS		0x00000020
-#define FILE_FILE_COMPRESSION		0x00000010
-#define FILE_PERSISTENT_ACLS		0x00000008
-#define FILE_UNICODE_ON_DISK		0x00000004
-#define FILE_CASE_PRESERVED_NAMES	0x00000002
-#define FILE_CASE_SENSITIVE_SEARCH	0x00000001
-
 /* Combinations of file access permission bits */
 #define SET_FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA \
 		| FILE_READ_ATTRIBUTES \
-- 
2.53.0

