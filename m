Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27F42BC4F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066651; cv=none; b=r07KpE8C/sbrLVxPVpgBpUxRu/gQDzG7XjrR7MKC62xr/FPaNzXtJs93IfzS7MXkktMVxBPyqs+0RycTo2ZZ7uJ+ZQ7wFKndE6ZJXhOGDG9iSUdHReDe9/WL6plRDAkvgZV72zwkUulC2+ciw/MI4b/q65ekhHkXwC49SpHw6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066651; c=relaxed/simple;
	bh=18UTJEvMJAX6Pvj4C86yHHH8AV7JgkihYTnq81EVZNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9i7kVgGSwXF8DrrNzvC6mHVtag97kRxIt+XEmDI+mO/GBvyLx/v/tYZHbwcrCzpyTe0g3j4/pXxaE/ZmbSctmnplK/xtrfuVDoRgD8kApDhn+YnNUISBL/WuRzRPH5ApY+VF76ZrdMguSe3zpDRBPvrKqNk4lBK3IuXypOEySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncScB82h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncScB82h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E6F1F00A3D;
	Tue, 14 Jul 2026 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066650;
	bh=2fV5qXBh9EoE9l4RedqdXRkb5J9mxULQVgefCcBdnww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ncScB82hl+9Kk5qr+14NSoO24C41w2Ipt35E/8wxiAnZNbnBJDXWcJWoegC96J2+M
	 svd0VkbF1o8REubftQG8VAZ1KEg5zutfJABD9ibSzB4NHU+mE0JEkig9QsWYJUGrJ/
	 d+5ttIm1HMko/C8wSLtGNxC9PrFjXDKy3oaPkOAA2poGnrGH3+05uiBknwv9AbVzzJ
	 wje6CgkycxnBbT1xh7DK1xDATFW45bvVKhMLQYgfGtUjeauzw4jvXfLY4kE6+IxHmb
	 XQvr7iOK4vcFqefgqLSNGsdBBCQU3MUPoaXRm/XcqF9B0ZyqiuYBA5eIswakREE6mF
	 CsQpCkxFD9tpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>,
	"Paulo Alcantara (SUSE)" <pc@cjr.nz>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] cifs: remove unused server parameter from calc_smb_size()
Date: Tue, 14 Jul 2026 18:04:04 -0400
Message-ID: <20260714220405.3333589-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714220405.3333589-1-sashal@kernel.org>
References: <2026071312-blank-founding-5203@gregkh>
 <20260714220405.3333589-1-sashal@kernel.org>
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
index 11d0eaa603cade..024a358380c79c 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -41,7 +41,7 @@ void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
 		 smb->Command, smb->Status.CifsError,
 		 smb->Flags, smb->Flags2, smb->Mid, smb->Pid);
 	cifs_dbg(VFS, "smb buf %p len %u\n", smb,
-		 server->ops->calc_smb_size(smb, server));
+		 server->ops->calc_smb_size(smb));
 #endif /* CONFIG_CIFS_DEBUG2 */
 }
 
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index af9e134174951f..d0905aa0b04cd0 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -397,7 +397,7 @@ struct smb_version_operations {
 	int (*close_dir)(const unsigned int, struct cifs_tcon *,
 			 struct cifs_fid *);
 	/* calculate a size of SMB message */
-	unsigned int (*calc_smb_size)(void *buf, struct TCP_Server_Info *ptcpi);
+	unsigned int (*calc_smb_size)(void *buf);
 	/* check for STATUS_PENDING and process the response if yes */
 	bool (*is_status_pending)(char *buf, struct TCP_Server_Info *server);
 	/* check for STATUS_NETWORK_SESSION_EXPIRED */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 8c0ed2b602854f..d43e8c331df958 100644
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
index b333ba3332298f..b4199b4085db39 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -370,7 +370,7 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
 	/* otherwise, there is enough to get to the BCC */
 	if (check_smb_hdr(smb))
 		return -EIO;
-	clc_len = smbCalcSize(smb, server);
+	clc_len = smbCalcSize(smb);
 
 	if (4 + rfclen != total_read) {
 		cifs_dbg(VFS, "Length read does not match RFC1001 length %d\n",
diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index 0e728aac67e9f2..dd2929150bf2ec 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -913,7 +913,7 @@ map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
  * portion, the number of word parameters and the data portion of the message
  */
 unsigned int
-smbCalcSize(void *buf, struct TCP_Server_Info *server)
+smbCalcSize(void *buf)
 {
 	struct smb_hdr *ptr = (struct smb_hdr *)buf;
 	return (sizeof(struct smb_hdr) + (2 * ptr->WordCount) +
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 9e62d75f24651e..9a7315aa24e0d6 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -801,8 +801,7 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 
 		end_of_smb = cfile->srch_inf.ntwrk_buf_start +
 			server->ops->calc_smb_size(
-					cfile->srch_inf.ntwrk_buf_start,
-					server);
+					cfile->srch_inf.ntwrk_buf_start);
 
 		cur_ent = cfile->srch_inf.srch_entries_start;
 		first_entry_in_buffer = cfile->srch_inf.index_of_last_entry
@@ -1000,8 +999,7 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	cifs_dbg(FYI, "loop through %d times filling dir for net buf %p\n",
 		 num_to_fill, cifsFile->srch_inf.ntwrk_buf_start);
 	max_len = tcon->ses->server->ops->calc_smb_size(
-			cifsFile->srch_inf.ntwrk_buf_start,
-			tcon->ses->server);
+			cifsFile->srch_inf.ntwrk_buf_start);
 	end_of_smb = cifsFile->srch_inf.ntwrk_buf_start + max_len;
 
 	tmp_buf = kmalloc(UNICODE_NAME_MAX, GFP_KERNEL);
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 71923cda9cc502..3adadeb9b837e6 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -225,7 +225,7 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 		}
 	}
 
-	calc_len = smb2_calc_size(buf, server);
+	calc_len = smb2_calc_size(buf);
 
 	/* For SMB2_IOCTL, OutputOffset and OutputLength are optional, so might
 	 * be 0, and not a real miscalculation */
@@ -407,7 +407,7 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
  * portion, the number of word parameters and the data portion of the message.
  */
 unsigned int
-smb2_calc_size(void *buf, struct TCP_Server_Info *srvr)
+smb2_calc_size(void *buf)
 {
 	struct smb2_pdu *pdu = (struct smb2_pdu *)buf;
 	struct smb2_hdr *shdr = &pdu->hdr;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index e1bd7b070535a5..2230c09e105528 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -316,7 +316,7 @@ smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
 		 shdr->Command, shdr->Status, shdr->Flags, shdr->MessageId,
 		 shdr->Id.SyncId.ProcessId);
 	cifs_server_dbg(VFS, "smb buf %p len %u\n", buf,
-		 server->ops->calc_smb_size(buf, server));
+		 server->ops->calc_smb_size(buf));
 #endif
 }
 
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index 5a15762ffbc835..049a1f3d61020b 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -36,7 +36,7 @@ struct smb_rqst;
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

