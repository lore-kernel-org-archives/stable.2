Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D564C77D3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059348; cv=none; b=RSKTIBfjhSSvJ41ilqDM7X/kmlFbbtdMjmuDDHUkFD66PNyCZ16drgANETG7AyRc/pULDQPLvKL2v38cydcpoaXPMvK0cusUMAfA+iOGEwttoA0hRxS2JUL50RHZSfyzX0KEO12JV7agvhx1vX70cxxKzx4xeVo0jA1p0j2J0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059348; c=relaxed/simple;
	bh=WZoJtH7rxJr5tdM1etZa0dcj8g6UR2ZbGCvO9Fr6pug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsGVxBiTnZqMhztSaB2Hi8x5bin5H5te0xrm2MGWhtPXe42CG/0cenJ0mxncSSrDIc0v7zwrqKA9wmTlNv14a/vhJpr7xUXIRvzItW/ugozghXLdevLvaTdfOw/4r+GADJmkKaFQpcjGju9PA2VGEJZfQeQ3GAHiXwyCMX3ysBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da5of+UR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da5of+UR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C7B1F00A3D;
	Tue, 14 Jul 2026 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059340;
	bh=9K9tRDDHguzKbIoi0udEKGmZDLzi9KztZ/+lOhPQ2z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Da5of+URTr6FzVMJ1iQvnj9nPNQdpqXGUeMsKFijN8eKpSXItucAzqQMUjGtcdlkv
	 1UYT7CRv7wwvEOcrKw6FthyfmqI+ER+LsFmzyEXupmSSwDI81h/oxyfPkI4zBjSYfb
	 dOX77FDc8f9pwJVl9QlRCafNHpVH8iIAe9UhEoFVMUHct/W/nrSo27A4oBMVpGk6vg
	 m611R4zYFHUVud6F2gDGfkk8fjsGlL2CwD1JJHsa0H3NV4XHO7RawvZpQaWAdDmp/v
	 MLNzbgE2B+Z9w6Aq8L3GR//VHxfrSrlXm11mI+abFouKMj5cRvJ+SO7zfyVgGYHEtd
	 QvXKxeEZWI3mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>,
	"Paulo Alcantara (SUSE)" <pc@cjr.nz>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] cifs: remove unused server parameter from calc_smb_size()
Date: Tue, 14 Jul 2026 16:02:14 -0400
Message-ID: <20260714200215.3152449-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200215.3152449-1-sashal@kernel.org>
References: <2026071307-payment-valium-e77f@gregkh>
 <20260714200215.3152449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Enzo Matsumiya <ematsumiya@suse.de>

[ Upstream commit 68ed14496b032b0c9ef21b38ee45c6c8f3a18ff1 ]

This parameter is unused by the called function

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 53b7c271f06b ("smb: client: restrict implied bcc[0] exemption to responses without data area")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifs_debug.c | 2 +-
 fs/cifs/cifsglob.h   | 2 +-
 fs/cifs/cifsproto.h  | 2 +-
 fs/cifs/misc.c       | 2 +-
 fs/cifs/netmisc.c    | 2 +-
 fs/cifs/readdir.c    | 6 ++----
 fs/cifs/smb2misc.c   | 4 ++--
 fs/cifs/smb2ops.c    | 2 +-
 fs/cifs/smb2proto.h  | 2 +-
 9 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index dd39097027b5f3..b7bbcd67e09545 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -42,7 +42,7 @@ void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
 		 smb->Command, smb->Status.CifsError,
 		 smb->Flags, smb->Flags2, smb->Mid, smb->Pid);
 	cifs_dbg(VFS, "smb buf %p len %u\n", smb,
-		 server->ops->calc_smb_size(smb, server));
+		 server->ops->calc_smb_size(smb));
 #endif /* CONFIG_CIFS_DEBUG2 */
 }
 
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 1030159152cc28..136f8b9cb44454 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -389,7 +389,7 @@ struct smb_version_operations {
 	int (*close_dir)(const unsigned int, struct cifs_tcon *,
 			 struct cifs_fid *);
 	/* calculate a size of SMB message */
-	unsigned int (*calc_smb_size)(void *buf, struct TCP_Server_Info *ptcpi);
+	unsigned int (*calc_smb_size)(void *buf);
 	/* check for STATUS_PENDING and process the response if yes */
 	bool (*is_status_pending)(char *buf, struct TCP_Server_Info *server);
 	/* check for STATUS_NETWORK_SESSION_EXPIRED */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 7d00802f972239..3de85b3283e627 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -148,7 +148,7 @@ extern int cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
 extern struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *, bool);
 extern int cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
 				  struct cifsFileInfo **ret_file);
-extern unsigned int smbCalcSize(void *buf, struct TCP_Server_Info *server);
+extern unsigned int smbCalcSize(void *buf);
 extern int decode_negTokenInit(unsigned char *security_blob, int length,
 			struct TCP_Server_Info *server);
 extern int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 7fd5882671b6b9..8b0eeb9ae7926e 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -357,7 +357,7 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
 	/* otherwise, there is enough to get to the BCC */
 	if (check_smb_hdr(smb))
 		return -EIO;
-	clc_len = smbCalcSize(smb, server);
+	clc_len = smbCalcSize(smb);
 
 	if (4 + rfclen != total_read) {
 		cifs_dbg(VFS, "Length read does not match RFC1001 length %d\n",
diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index fa9fbd6a819cb8..6ddab41f587385 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -912,7 +912,7 @@ map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
  * portion, the number of word parameters and the data portion of the message
  */
 unsigned int
-smbCalcSize(void *buf, struct TCP_Server_Info *server)
+smbCalcSize(void *buf)
 {
 	struct smb_hdr *ptr = (struct smb_hdr *)buf;
 	return (sizeof(struct smb_hdr) + (2 * ptr->WordCount) +
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 6aa3c267f4ca41..7c47a03afbcc39 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -808,8 +808,7 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 
 		end_of_smb = cfile->srch_inf.ntwrk_buf_start +
 			server->ops->calc_smb_size(
-					cfile->srch_inf.ntwrk_buf_start,
-					server);
+					cfile->srch_inf.ntwrk_buf_start);
 
 		cur_ent = cfile->srch_inf.srch_entries_start;
 		first_entry_in_buffer = cfile->srch_inf.index_of_last_entry
@@ -1008,8 +1007,7 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	cifs_dbg(FYI, "loop through %d times filling dir for net buf %p\n",
 		 num_to_fill, cifsFile->srch_inf.ntwrk_buf_start);
 	max_len = tcon->ses->server->ops->calc_smb_size(
-			cifsFile->srch_inf.ntwrk_buf_start,
-			tcon->ses->server);
+			cifsFile->srch_inf.ntwrk_buf_start);
 	end_of_smb = cifsFile->srch_inf.ntwrk_buf_start + max_len;
 
 	tmp_buf = kmalloc(UNICODE_NAME_MAX, GFP_KERNEL);
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index c24d3bcb565f17..29d723c04b1666 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -221,7 +221,7 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 		}
 	}
 
-	calc_len = smb2_calc_size(buf, server);
+	calc_len = smb2_calc_size(buf);
 
 	/* For SMB2_IOCTL, OutputOffset and OutputLength are optional, so might
 	 * be 0, and not a real miscalculation */
@@ -403,7 +403,7 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
  * portion, the number of word parameters and the data portion of the message.
  */
 unsigned int
-smb2_calc_size(void *buf, struct TCP_Server_Info *srvr)
+smb2_calc_size(void *buf)
 {
 	struct smb2_pdu *pdu = (struct smb2_pdu *)buf;
 	struct smb2_hdr *shdr = &pdu->hdr;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 2a640015c261bf..b17b5aa3fdb2f4 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -374,7 +374,7 @@ smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
 		 shdr->Command, shdr->Status, shdr->Flags, shdr->MessageId,
 		 shdr->Id.SyncId.ProcessId);
 	cifs_server_dbg(VFS, "smb buf %p len %u\n", buf,
-		 server->ops->calc_smb_size(buf, server));
+		 server->ops->calc_smb_size(buf));
 #endif
 }
 
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index b8f7abbf9dacd7..73955013033c04 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -23,7 +23,7 @@ struct smb_rqst;
 extern int map_smb2_to_linux_error(char *buf, bool log_err);
 extern int smb2_check_message(char *buf, unsigned int length,
 			      struct TCP_Server_Info *server);
-extern unsigned int smb2_calc_size(void *buf, struct TCP_Server_Info *server);
+extern unsigned int smb2_calc_size(void *buf);
 extern char *smb2_get_data_area_len(int *off, int *len,
 				    struct smb2_hdr *shdr);
 extern __le16 *cifs_convert_path_to_utf16(const char *from,
-- 
2.53.0

