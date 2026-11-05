Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901528;
	b=neDfFwtNhMQFNcCIWeq1/LL0R+YjzMOI7mOkon7heDXNw18rN1tIwoz2qG+4ZlHL7vBV
	 jfberVA0/8WIwM4SDrjJTi20CMMJ17S8492ylGClDmQmllJ0r8SRiaQLhegD/9J7ElNE8
	 pvscQ2H9s3z4eaY2nu68a2EMkyJT32SHf1NVDgrZAommvQFlQ9VZtKXADQv/UBlpMk1c9
	 m0HOWrwS1AZXIFJ7lCOnjh6UUYTMJzdVMmjOuABahiBZYD6NNafoynp5BelmNiXybko/y
	 ejnLGoA+yo/StklCZoWjuW46c6xl5zjpsSbOav9kioR01s+b64y5+uaVY+eLvG8RMsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QlslJmXoS88jCiEYiLkBg0Zy8iHNTD1QI/kHcew4010=;
	b=EroPjoIutpOGnGOJTofTqAAgg9JJGOQzWL6VOF6UwAz4PpFd1yHcjPTVYPbHDEdvcFk+
	 tnFR72NZ5MFR/J9Cy6As2g+MPA5u1MpzVFiSxDog4iJ9IdojVg8M3bo8KZszU2k8pzdWR
	 TkhpQADT8ZcWulrAPhEUJbz//pgIMNZjulntBLUVLLO0IYzeOKjQJMpkaUcpuQgZ1oS9K
	 SeZ1L4ju71upKhMjeXTLWsAdDMFY3r+4uCuV+OWxl1964+qF+V15lWS4MoHTYBp9PS3qq
	 Zt7XsEAfNQFrJeKnRUF6N+dmu6B4oWp4iTiWxOYgUtvIzo6/qFCcoGKUmoHUbY9c0nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e49QJ4uT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1790606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e49QJ4uT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CED1F00A16;
	Thu,  5 Nov 2026 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901527;
	bh=QlslJmXoS88jCiEYiLkBg0Zy8iHNTD1QI/kHcew4010=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e49QJ4uT6D+YqdygfwWI52rM1ElwTbZPp2MrgF6nrMFdW0CNEiDVh1J/fwvS0YsQq
	 +79DQ4+LBCtqrWoxaIw/oFr64hAzfK62B3wm7U5s5rUIL7osY31pKH98SaL/C4Iflj
	 cWEOQUqQaA69LCdcBX03XbMSjxDW+SqAOntasWAfVEImJ0jRG8ODtb9IlPVdYcMrW7
	 QWl6k7RkLZ2iBU1MB/Mvuo3pVuQWVS+8q94TBUpfIlxNmygbwtAQtMqCAsgRcj3Dow
	 ZRsvQXDUsC4Q18kij1NCLr0ZnE7Q8V6L+azSqF5aGWro9GXyTofqNFvuABla3Wr46D
	 +eV6jcOP/UhWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/8] smb: move create_durable_handle_reconnect_v2 to common/smb2pdu.h
Date: Thu,  5 Nov 2026 12:58:38 -0500
Message-ID: <20261105175828.2192358-3-sashal@kernel.org>
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

[ Upstream commit 81a45de432c6c7d82821fb09cb9fc1cf58629f3a ]

Modify the following places:

  - some fields in "struct create_durable_reconn_v2_req" ->
                        struct durable_reconnect_context_v2
  - create_durable_reconn_v2_req -> create_durable_handle_reconnect_v2

Then move duplicate definitions to common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f8171804a39e ("smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.h | 17 -----------------
 fs/smb/common/smb2pdu.h | 16 ++++++++++++++++
 fs/smb/server/smb2pdu.c | 10 +++++-----
 fs/smb/server/smb2pdu.h | 11 -----------
 4 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 472553e499830..a75cde061a67d 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -138,29 +138,12 @@ struct share_redirect_error_context_rsp {
 /* Flags */
 #define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
 
-/* See MS-SMB2 2.2.13.2.12 */
-struct durable_reconnect_context_v2 {
-	struct {
-		__u64 PersistentFileId;
-		__u64 VolatileFileId;
-	} Fid;
-	__u8 CreateGuid[16];
-	__le32 Flags; /* see above DHANDLE_FLAG_PERSISTENT */
-} __packed;
-
 /* See MS-SMB2 2.2.14.2.12 */
 struct durable_reconnect_context_v2_rsp {
 	__le32 Timeout;
 	__le32 Flags; /* see above DHANDLE_FLAG_PERSISTENT */
 } __packed;
 
-struct create_durable_handle_reconnect_v2 {
-	struct create_context_hdr ccontext;
-	__u8   Name[8];
-	struct durable_reconnect_context_v2 dcontext;
-	__u8   Pad[4];
-} __packed;
-
 /* See MS-SMB2 2.2.13.2.5 */
 struct crt_twarp_ctxt {
 	struct create_context_hdr ccontext;
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index ca47c54afd324..7899e7706318f 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1304,6 +1304,22 @@ struct create_durable_req_v2 {
 	struct durable_context_v2_req dcontext;
 } __packed;
 
+/* See MS-SMB2 2.2.13.2.12 */
+struct durable_reconnect_context_v2 {
+	struct {
+		__u64 PersistentFileId;
+		__u64 VolatileFileId;
+	} Fid;
+	__u8 CreateGuid[16];
+	__le32 Flags; /* see SMB2_DHANDLE_FLAG_PERSISTENT */
+} __packed;
+
+struct create_durable_handle_reconnect_v2 {
+	struct create_context_hdr ccontext;
+	__u8   Name[8];
+	struct durable_reconnect_context_v2 dcontext;
+} __packed;
+
 /* See MS-SMB2 2.2.14.2.5 */
 struct create_mxac_rsp {
 	struct create_context_hdr ccontext;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 9e54b4301106b..d16df43f7c772 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2818,7 +2818,7 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 		switch (dh_idx) {
 		case DURABLE_RECONN_V2:
 		{
-			struct create_durable_reconn_v2_req *recon_v2;
+			struct create_durable_handle_reconnect_v2 *recon_v2;
 
 			if (dh_info->type == DURABLE_RECONN ||
 			    dh_info->type == DURABLE_REQ_V2) {
@@ -2828,13 +2828,13 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 
 			if (le16_to_cpu(context->DataOffset) +
 				le32_to_cpu(context->DataLength) <
-			    sizeof(struct create_durable_reconn_v2_req)) {
+			    sizeof(struct create_durable_handle_reconnect_v2)) {
 				err = -EINVAL;
 				goto out;
 			}
 
-			recon_v2 = (struct create_durable_reconn_v2_req *)context;
-			persistent_id = recon_v2->Fid.PersistentFileId;
+			recon_v2 = (struct create_durable_handle_reconnect_v2 *)context;
+			persistent_id = recon_v2->dcontext.Fid.PersistentFileId;
 			dh_info->fp = ksmbd_lookup_durable_fd(persistent_id);
 			if (!dh_info->fp) {
 				ksmbd_debug(SMB, "Failed to get durable handle state\n");
@@ -2842,7 +2842,7 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 				goto out;
 			}
 
-			if (memcmp(dh_info->fp->create_guid, recon_v2->CreateGuid,
+			if (memcmp(dh_info->fp->create_guid, recon_v2->dcontext.CreateGuid,
 				   SMB2_CREATE_GUID_SIZE)) {
 				err = -EBADF;
 				ksmbd_put_durable_fd(dh_info->fp);
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 189e0d955b4a5..8ef681f7075ad 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -80,17 +80,6 @@ struct create_durable_reconn_req {
 	} Data;
 } __packed;
 
-struct create_durable_reconn_v2_req {
-	struct create_context_hdr ccontext;
-	__u8   Name[8];
-	struct {
-		__u64 PersistentFileId;
-		__u64 VolatileFileId;
-	} Fid;
-	__u8 CreateGuid[16];
-	__le32 Flags;
-} __packed;
-
 struct create_alloc_size_req {
 	struct create_context_hdr ccontext;
 	__u8   Name[8];
-- 
2.53.0

