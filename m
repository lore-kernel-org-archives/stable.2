Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF893CCFD2
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789073; cv=none; b=niZq5gTYRriwraDzwSCyn9bS5AdnxpR9tXcXNo0U5GqzAnGVfUpc9ENJ15FDPj9o6Uci6eXgUY8mu5htavSt5Mzme6MCzWz9apr0iASEdiB/5n+a/YyQ8XPXzXczKgcl7VaEcjYfEY1WLKu1FBK2/Ve48zSXgHbZ4i5erBhfIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789073; c=relaxed/simple;
	bh=hj34ECKR/PnYj7hFbkoXfWtnWqrv4b4KCtDgypPcjU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thI2SoZJfebQ+K0cCmtps85agEb0/hhje+jG3xqm49BSfWHw77cu5sImVO5fPFbijVd65AK4FPN/l/byjeT9066JqUo8h3j2qpatjIVKU8JUiJIETuUkjq6p2V1XbAstZXrVEfOZC5kkRk52mgotWCTvjB0lCwy8dxizKcWXkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH2rnKOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH2rnKOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45ED1F00A3A;
	Mon,  7 Sep 2026 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789069;
	bh=qdUi4QJkZ9ztLIVfXtMGTRzRqPLw0015pOQnh8HZbfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AH2rnKOTX6QzE21jPtPQ/OyMnxtcQ9roJWa+TPNQPf5qwM6x/1UMuLUI6eBOKQBZL
	 Uw+6uid4AwSFzP3xwrVo7ILRM/R+JSMddgw1nktPN8CzRkoYgg6pvFCXw4l9UobQn3
	 zl8emrPVaDrwFpF8hRtaqknq8JY4ZPpdTyXOGKkQgNh1PuBcke+3rXy6FHXVdQQazV
	 2zdVvufn8XbA0KTmsm7SIy1MDRGLa3aRg97J5amlhUSP34Lz+l4K5S8/QZK5HKruC7
	 pj0IYB/ukW1YnhjbmenjVv904/YJiIOQ4dkAMiBrJzUX3MqiOV4CuyoW3kN/pVzhA+
	 jG0p43uY/VTsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] smb: move some duplicate definitions to common/smb2pdu.h
Date: Mon,  7 Sep 2026 09:51:06 -0400
Message-ID: <20260907135107.3103249-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090314-shower-guileless-2d4c@gregkh>
References: <2026090314-shower-guileless-2d4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit 1172d8598499a006d172bb24bebaa3fdc99064a8 ]

In order to maintain the code more easily, move duplicate definitions to
common header file.

There are only 4 different definitions, the client uses cpu_to_le16()
but the server does not:

  - RSS_CAPABLE
  - RDMA_CAPABLE
  - INTERNETWORK
  - INTERNETWORKV6

The other definitions are exactly the same on both client and server.

The struct smb_hdr is defined in MS-CIFS and MS-SMB, but it's also used by
SMB2 and SMB3, so move it to the common smb2pdu.h.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

The struct smb_hdr is defined in MS-CIFS and MS-SMB, but it is also used by
SMB2 and SMB3, so move it to the common smb2pdu.h.

[ stable: Retain only the smb_hdr consolidation because the stable-specific
durable and network-interface definitions differ from upstream.  Prepare
the existing reparse_buf_ptr() for the follow-up fix with a local smb_EIO2
compatibility macro that preserves the existing -EIO behavior. ]

[ sashal: Reduced backport -- upstream 1172d8598499a touches 6 file(s), this
  backport carries 4. Not backported here:
  fs/smb/client/smb2pdu.h
  fs/smb/server/smb2pdu.c
  fs/smb/server/smb2pdu.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 05f78e6cf34e ("smb: client: fix use-before-check of ReparseDataLength in reparse_buf_ptr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifspdu.h    | 33 +--------------------------------
 fs/smb/client/smb2inode.c  | 11 +++++++++--
 fs/smb/common/smb2pdu.h    | 36 ++++++++++++++++++++++++++++++++++++
 fs/smb/server/smb_common.h | 30 ------------------------------
 4 files changed, 46 insertions(+), 64 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index f4cfb082dfd14..7a3ec22808adf 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -12,6 +12,7 @@
 #include <net/sock.h>
 #include <asm/unaligned.h>
 #include "../common/smbfsctl.h"
+#include "../common/smb2pdu.h"
 
 #define CIFS_PROT   0
 #define POSIX_PROT  (CIFS_PROT+1)
@@ -377,38 +378,6 @@
 #define GETU16(var)  (*((__u16 *)var))	/* BB check for endian issues */
 #define GETU32(var)  (*((__u32 *)var))	/* BB check for endian issues */
 
-struct smb_hdr {
-	__be32 smb_buf_length;	/* BB length is only two (rarely three) bytes,
-		with one or two byte "type" preceding it that will be
-		zero - we could mask the type byte off */
-	__u8 Protocol[4];
-	__u8 Command;
-	union {
-		struct {
-			__u8 ErrorClass;
-			__u8 Reserved;
-			__le16 Error;
-		} __attribute__((packed)) DosError;
-		__le32 CifsError;
-	} __attribute__((packed)) Status;
-	__u8 Flags;
-	__le16 Flags2;		/* note: le */
-	__le16 PidHigh;
-	union {
-		struct {
-			__le32 SequenceNumber;  /* le */
-			__u32 Reserved; /* zero */
-		} __attribute__((packed)) Sequence;
-		__u8 SecuritySignature[8];	/* le */
-	} __attribute__((packed)) Signature;
-	__u8 pad[2];
-	__u16 Tid;
-	__le16 Pid;
-	__u16 Uid;
-	__le16 Mid;
-	__u8 WordCount;
-} __attribute__((packed));
-
 /* given a pointer to an smb_hdr, retrieve a void pointer to the ByteCount */
 static inline void *
 BCC(struct smb_hdr *smb)
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 540f4ba81b6ce..927c9c800604f 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -26,6 +26,9 @@
 #include "cached_dir.h"
 #include "smb2status.h"
 
+/* Preserve the newer EIO helper call shape while retaining 6.6 semantics. */
+#define smb_EIO2(_trace, _info, _info2) (-EIO)
+
 static inline __u32 file_create_options(struct dentry *dentry)
 {
 	struct cifsInodeInfo *ci;
@@ -43,6 +46,7 @@ static struct reparse_data_buffer *reparse_buf_ptr(struct kvec *iov)
 	struct reparse_data_buffer *buf;
 	struct smb2_ioctl_rsp *io = iov->iov_base;
 	u32 off, count, len;
+	u16 rdlen;
 
 	count = le32_to_cpu(io->OutputCount);
 	off = le32_to_cpu(io->OutputOffset);
@@ -51,10 +55,13 @@ static struct reparse_data_buffer *reparse_buf_ptr(struct kvec *iov)
 
 	buf = (struct reparse_data_buffer *)((u8 *)io + off);
 	len = sizeof(*buf);
-	if (count < len || count < le16_to_cpu(buf->ReparseDataLength) + len)
-		return ERR_PTR(-EIO);
+	rdlen = le16_to_cpu(buf->ReparseDataLength);
+
+	if (count < len || count < rdlen + len)
+		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_rdlen, count, rdlen));
 	return buf;
 }
+#undef smb_EIO2
 
 /* Parse owner and group from SMB3.1.1 POSIX query info */
 static int parse_posix_sids(struct cifs_open_info_data *data,
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 1af827ae757e0..dfd50472de30a 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1860,6 +1860,42 @@ struct smb2_lease_ack {
 	__le64 LeaseDuration;
 } __packed;
 
+/*
+ * See MS-CIFS 2.2.3.1
+ *     MS-SMB 2.2.3.1
+ */
+struct smb_hdr {
+	__be32 smb_buf_length;	/* BB length is only two (rarely three) bytes,
+		with one or two byte "type" preceding it that will be
+		zero - we could mask the type byte off */
+	__u8 Protocol[4];
+	__u8 Command;
+	union {
+		struct {
+			__u8 ErrorClass;
+			__u8 Reserved;
+			__le16 Error;
+		} __packed DosError;
+		__le32 CifsError;
+	} __packed Status;
+	__u8 Flags;
+	__le16 Flags2;		/* note: le */
+	__le16 PidHigh;
+	union {
+		struct {
+			__le32 SequenceNumber;  /* le */
+			__u32 Reserved; /* zero */
+		} __packed Sequence;
+		__u8 SecuritySignature[8];	/* le */
+	} __packed Signature;
+	__u8 pad[2];
+	__u16 Tid;
+	__le16 Pid;
+	__u16 Uid;
+	__le16 Mid;
+	__u8 WordCount;
+} __packed;
+
 #define OP_BREAK_STRUCT_SIZE_20		24
 #define OP_BREAK_STRUCT_SIZE_21		36
 #endif				/* _COMMON_SMB2PDU_H */
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 8693b5f5b4ac2..577270d9ad9ec 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -160,36 +160,6 @@
 #define SMBFLG2_ERR_STATUS	cpu_to_le16(0x4000)
 #define SMBFLG2_UNICODE		cpu_to_le16(0x8000)
 
-struct smb_hdr {
-	__be32 smb_buf_length;
-	__u8 Protocol[4];
-	__u8 Command;
-	union {
-		struct {
-			__u8 ErrorClass;
-			__u8 Reserved;
-			__le16 Error;
-		} __packed DosError;
-		__le32 CifsError;
-	} __packed Status;
-	__u8 Flags;
-	__le16 Flags2;          /* note: le */
-	__le16 PidHigh;
-	union {
-		struct {
-			__le32 SequenceNumber;  /* le */
-			__u32 Reserved; /* zero */
-		} __packed Sequence;
-		__u8 SecuritySignature[8];      /* le */
-	} __packed Signature;
-	__u8 pad[2];
-	__le16 Tid;
-	__le16 Pid;
-	__le16 Uid;
-	__le16 Mid;
-	__u8 WordCount;
-} __packed;
-
 struct smb_negotiate_req {
 	struct smb_hdr hdr;     /* wct = 0 */
 	__le16 ByteCount;
-- 
2.53.0

