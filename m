Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725069;
	b=REuCojn8cypHnwZctmJGZ36LbbAYG73bOmaQkknDAcyW2ybyPM1UAmqKCAI5qBx2Yd3M
	 iJ8W3U9sP6314vK0aJpOBoPu2lnnNsiI6L+ZrDs3kd9pPf3IKZa5rbCoMGanrfuWFlTg4
	 rxQqrMjpiDfKAHTG/Dp7+DDdzP/YjwuHhPnjj5XAMwbNSfO4WurXBFeSZrxTK/m7yFQd1
	 U36anTqyAnlemQaedRgSliVTHaPntjgx96XrhKa93mYCtdsKVqslGkIjSIbAgq56CYaqs
	 fpQp2bOcBYgL8O9pDKyHTcmOPd3cFUvN8R+I+IpZdUU9N/q8aFXO/TJz+Ix1bEeHwiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D1eUcm2mQCgyZbZQgs0SosU0DN1k8OOWQBjXBd56BQc=;
	b=0HAZo/QDIm+usO5LY7Vbmw5Ww82bPmGkj5QKlGLdnWW0tEuMcE18ie8egXOXE2VcU846
	 2E9CpZQGixCm/yfsy/u5d392nzcF9fkDlldy5zoKTGRkn6IKx9em6jjlAGrl15SaiqybS
	 r5HDnp8TlXXJqmrHti8Rd2POp5vb8NXs5bw2veXnyOCzyEbJpTiGu5hegrFB8ON4pYIq+
	 /2s2ivEX7jufIsYgLEx5YzI7/eIi67hJMN3lxspG7i14A6ujEhFIjtlyE6nhaIh7mfmCs
	 uBWGAkBdy64IgllH6S9D+vV8JdybQe0+w4dXh9hDeS11V1dMVa6UlwN2usYwI8gpbMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3Qc6jsH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A1606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3Qc6jsH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AAD1F000C1;
	Tue,  3 Nov 2026 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725069;
	bh=D1eUcm2mQCgyZbZQgs0SosU0DN1k8OOWQBjXBd56BQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3Qc6jsH4ZSI4wv+0+rvtNTWHXxg2YhKUWMrZKhdN/hwCuHYZ6FhCNAlpKma/wPdC
	 IFnVehF60j9Ksle2yOvFYudKe4i51S9HbHygvr7cdkDAzwq3mH1CHRApdxDlcgRIAw
	 T0lIOJHPAFXBL17xtZ+sMcLAKRGBfH/IG5yiZiwaxhqL9NTw2v5dy56FPX4/1TRZuM
	 6rpGyOz/YP9fT26qzrr2lGIEHGynFhKiHv8VucMbOwop7LGoFRIP2QWpKHczvcZcZA
	 M7nmcXVbc8xzsyunctfo1huIachhnIDeuiYaAo1exb45Lr++Oe7OiTdImszVYIa/r/
	 InOLYG1syFPSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] ksmbd: fix SMB2 CREATE response buffer overflow
Date: Tue,  3 Nov 2026 11:57:46 -0500
Message-ID: <20261103165719.643173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110339-undesired-vagabond-3610@gregkh>
References: <2026110339-undesired-vagabond-3610@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 713c31a3a225b6239a37ac7fbfb394567f8b3519 ]

smb2_allocate_rsp_buf() uses the MAX_CIFS_SMALL_BUFFER_SIZE
(448-byte) buffer for a single SMB2_CREATE response. That buffer also
holds a 4-byte length field, which only leaves 444 bytes for the SMB2
body.

The AAPL response made this buffer too small. After 8f1b796ff113, a
request with AAPL response contexts may need at least 456 bytes. In
the 456-byte case, create_aapl_rsp_buf() is appended last, clears 128
bytes, and writes 12 bytes past the allocation.

KASAN reports:

    BUG: KASAN: slab-out-of-bounds in create_aapl_rsp_buf+0x31/0x6e0
    Write of size 128 at addr ffff88800370954c by task kworker/0:0/9
    ...
    create_aapl_rsp_buf+0x31/0x6e0
    smb2_open+0x58f9/0xef10
    ...
    smb2_allocate_rsp_buf+0x19d/0x370
    ...
    The buggy address is located 332 bytes inside of
     allocated 448-byte region [ffff888003709400, ffff8880037095c0)

Reserve enough space for any fixed CREATE response KSMBD can build.
Store the required allocation size in the per-dialect values table.
This keeps the small buffer for other commands and avoids using the max
transaction buffer for every CREATE.

Fixes: 8f1b796ff113 ("ksmbd: add AAPL kAAPL_SERVER_QUERY create context support")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 714f27729121 ("ksmbd: fix out-of-bounds read when padding the final compound response")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/common/smbglob.h |  1 +
 fs/smb/server/smb2ops.c | 33 +++++++++++++++++++++++++++++++++
 fs/smb/server/smb2pdu.c |  6 +++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/smb/common/smbglob.h b/fs/smb/common/smbglob.h
index d9c7e6e7af295..fdf8408880620 100644
--- a/fs/smb/common/smbglob.h
+++ b/fs/smb/common/smbglob.h
@@ -40,6 +40,7 @@ struct smb_version_values {
 	size_t		create_disk_id_size;
 	size_t		create_posix_size;
 	size_t		create_aapl_size;
+	size_t		create_rsp_size;
 };
 
 static inline unsigned int get_rfc1002_len(void *buf)
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 4578291fb1722..747276b171bd1 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -13,6 +13,35 @@
 #include "server.h"
 #include "stats.h"
 
+/*
+ * work->response_sz includes the RFC1002 length field while smb_get_msg()
+ * skips over it. Durable v1 and v2 response contexts are mutually exclusive,
+ * and POSIX CREATE contexts are only negotiated for SMB3.1.1.
+ */
+#define SMB2_CREATE_RSP_SIZE(lease_size, durable_size)			\
+	(sizeof(__be32) + offsetof(struct smb2_create_rsp, Buffer) +	\
+	 (lease_size) + (durable_size) +				\
+	 sizeof(struct create_mxac_rsp) +				\
+	 sizeof(struct create_disk_id_rsp) +				\
+	 AAPL_RSP_MAX_SIZE)
+
+#define SMB21_CREATE_RSP_SIZE						\
+	SMB2_CREATE_RSP_SIZE(sizeof(struct create_lease),		\
+			     sizeof(struct create_durable_rsp))
+
+#define SMB3_CREATE_DURABLE_RSP_SIZE					\
+	((sizeof(struct create_durable_rsp) >				\
+	  sizeof(struct create_durable_rsp_v2)) ?			\
+	 sizeof(struct create_durable_rsp) :				\
+	 sizeof(struct create_durable_rsp_v2))
+
+#define SMB3_CREATE_RSP_SIZE						\
+	SMB2_CREATE_RSP_SIZE(sizeof(struct create_lease_v2),		\
+			     SMB3_CREATE_DURABLE_RSP_SIZE)
+
+#define SMB311_CREATE_RSP_SIZE						\
+	(SMB3_CREATE_RSP_SIZE + sizeof(struct create_posix_rsp))
+
 static struct smb_version_values smb21_server_values = {
 	.version_string = SMB21_VERSION_STRING,
 	.protocol_id = SMB21_PROT_ID,
@@ -38,6 +67,7 @@ static struct smb_version_values smb21_server_values = {
 	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
 	.create_posix_size = sizeof(struct create_posix_rsp),
 	.create_aapl_size = AAPL_RSP_MAX_SIZE,
+	.create_rsp_size = SMB21_CREATE_RSP_SIZE,
 };
 
 static struct smb_version_values smb30_server_values = {
@@ -66,6 +96,7 @@ static struct smb_version_values smb30_server_values = {
 	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
 	.create_posix_size = sizeof(struct create_posix_rsp),
 	.create_aapl_size = AAPL_RSP_MAX_SIZE,
+	.create_rsp_size = SMB3_CREATE_RSP_SIZE,
 };
 
 static struct smb_version_values smb302_server_values = {
@@ -94,6 +125,7 @@ static struct smb_version_values smb302_server_values = {
 	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
 	.create_posix_size = sizeof(struct create_posix_rsp),
 	.create_aapl_size = AAPL_RSP_MAX_SIZE,
+	.create_rsp_size = SMB3_CREATE_RSP_SIZE,
 };
 
 static struct smb_version_values smb311_server_values = {
@@ -122,6 +154,7 @@ static struct smb_version_values smb311_server_values = {
 	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
 	.create_posix_size = sizeof(struct create_posix_rsp),
 	.create_aapl_size = AAPL_RSP_MAX_SIZE,
+	.create_rsp_size = SMB311_CREATE_RSP_SIZE,
 };
 
 static struct smb_version_ops smb2_0_server_ops = {
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b3743e17aa3c1..e5bbd003e3599 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -873,14 +873,18 @@ static void smb2_update_lock_sequence(struct ksmbd_work *work,
 int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 {
 	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
+	struct smb_version_values *vals = work->conn->vals;
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
-	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
+	size_t large_sz = small_sz + vals->max_trans_size;
 	size_t sz = small_sz;
 	int cmd = le16_to_cpu(hdr->Command);
 
 	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE)
 		sz = large_sz;
 
+	if (cmd == SMB2_CREATE_HE)
+		sz = max_t(size_t, sz, vals->create_rsp_size);
+
 	if (cmd == SMB2_QUERY_INFO_HE) {
 		struct smb2_query_info_req *req;
 
-- 
2.53.0

