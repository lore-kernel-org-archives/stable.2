Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C6234994
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167562; cv=none; b=JZOtAD7LAtM5IwatIBWazXnqq7bLMl2woKPQ9p+45e2AcFpWHTRiu3raRY7fF1He01jpM0VX70HN8cIP77iWqALGoiwdZu+r26cedhSGDvV39DtpfNjg9wpMky5plkz1N2g5NvuyiO0H4GdJeEIQOoFXdFaNiFjaMrqW1OrqEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167562; c=relaxed/simple;
	bh=8v5OIivpftIF4ILzON8d4Ez0rFW1J+yQFh4oC1grSYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q62M4sWenNKRM1fXjnwr1PiZiv71+mfLz7sXLTYj0AdZSjE42NH3TawhQ8EhZfylQykzR3tuZ9qfTJYRzxx3YP2piG3S07un0fixBvZ/c2n2EjnYeoxLp3CcTX+6XynmOgefZU/vzrS5vf301r5UwBidYwa4yEfuezFN7PEafEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FntDU3FN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FntDU3FN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0C91F000E9;
	Thu, 16 Jul 2026 02:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784167561;
	bh=C3nwDZMfsDjVrrxwqgn+x3OS/VzPX5YPzJc/CUwu2Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FntDU3FNeDX6+IrXV7N5aIppJAzecFhuFlGgwU6XYIdA/eCVSkA5MJgIFfy2RQi9b
	 14u30y2c+qAjqCpWY8BXNR89sv5e4u0276jiH7aOvaEFnDtbeOnaPQXI893FLteL39
	 yuN6qJPjaGh0THkd7er/Ut7jIYGAg+EraaFCPu1S4KUAD+0TAVIEIX6zgN/Q2XigAa
	 PeZp3WRJvYcS3fejN8FHdwDKEwnSlYvambvMu7B9JM96Km9KYHNs9d4AAdPCrS84BG
	 qTCX/dONqTkjtUJOPc58MbBIJ2lNyhqeE7vJZYaTqAqSlrqG684sjLjZF0FevqbTNj
	 4JtaMKl6JnNrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] smb: move compression definitions into common/fscc.h
Date: Wed, 15 Jul 2026 22:05:57 -0400
Message-ID: <20260716020558.818894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071403-easeful-customary-a1e2@gregkh>
References: <2026071403-easeful-customary-a1e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit 9d357903ec9b0da60cccc4d311f99763ba0924a2 ]

These definitions will also be used by ksmbd, move them into
common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: c6394bcaf254 ("ksmbd: use opener credentials for FSCTL mutations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb1pdu.h |  5 -----
 fs/smb/client/smb2pdu.h |  4 ----
 fs/smb/common/fscc.h    | 18 ++++++++++++++++++
 fs/smb/server/smb2pdu.h |  3 ---
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/smb1pdu.h b/fs/smb/client/smb1pdu.h
index 7584e94d9b2bfa..0870949144abf5 100644
--- a/fs/smb/client/smb1pdu.h
+++ b/fs/smb/client/smb1pdu.h
@@ -1211,11 +1211,6 @@ typedef struct smb_com_transaction_compr_ioctl_req {
 	__le16 compression_state;  /* See below for valid flags */
 } __packed TRANSACT_COMPR_IOCTL_REQ;
 
-/* compression state flags */
-#define COMPRESSION_FORMAT_NONE		0x0000
-#define COMPRESSION_FORMAT_DEFAULT	0x0001
-#define COMPRESSION_FORMAT_LZNT1	0x0002
-
 typedef struct smb_com_transaction_ioctl_rsp {
 	struct smb_hdr hdr;	/* wct = 19 */
 	__u8 Reserved[3];
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 30d70097fe2fad..b9bf2fa989d5bf 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -195,10 +195,6 @@ struct network_resiliency_req {
 
 #define NO_FILE_ID 0xFFFFFFFFFFFFFFFFULL /* general ioctls to srv not to file */
 
-struct compress_ioctl {
-	__le16 CompressionState; /* See cifspdu.h for possible flag values */
-} __packed;
-
 /*
  * Maximum number of iovs we need for an ioctl request.
  * [0] : struct smb2_ioctl_req
diff --git a/fs/smb/common/fscc.h b/fs/smb/common/fscc.h
index bc3012cc295da6..859849a42fec5e 100644
--- a/fs/smb/common/fscc.h
+++ b/fs/smb/common/fscc.h
@@ -100,6 +100,24 @@ struct duplicate_extents_to_file_ex {
 	__le32 Reserved;
 } __packed;
 
+/*
+ * compression state flags
+ * See MS-FSCC 2.3.18
+ *     MS-FSCC 2.3.67
+ *     MS-FSCC 2.4.9
+ */
+#define COMPRESSION_FORMAT_NONE	0x0000
+#define COMPRESSION_FORMAT_DEFAULT	0x0001
+#define COMPRESSION_FORMAT_LZNT1	0x0002
+
+/*
+ * See MS-FSCC 2.3.18
+ *     MS-FSCC 2.3.67
+ */
+struct compress_ioctl {
+	__le16 CompressionState;
+} __packed;
+
 /* See MS-FSCC 2.3.20 */
 struct fsctl_get_integrity_information_rsp {
 	__le16	ChecksumAlgorithm;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index e7cf573e59f00c..3bed676bb5ad42 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -230,9 +230,6 @@ struct smb2_file_mode_info {
 	__le32 Mode;
 } __packed;
 
-#define COMPRESSION_FORMAT_NONE 0x0000
-#define COMPRESSION_FORMAT_LZNT1 0x0002
-
 struct smb2_file_comp_info {
 	__le64 CompressedFileSize;
 	__le16 CompressionFormat;
-- 
2.53.0

