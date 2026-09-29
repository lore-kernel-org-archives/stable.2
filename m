Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06833EB01
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682645; cv=none; b=LpbhAkmZMPH55DUp9jpJ0Nfpy1J5ESvpUijw7hK4VNRtwRF/XZiio3a+kMyZqRoRb8IxHTHTRGoCl4+jseIZZj0VZUp0vPhxlBsFdVND7RM1vKYaNZxfo9xllCnb6G9PjHv7wchHG/BDAUbqkYFcjgFazVWygooZVMlUT3O8ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682645; c=relaxed/simple;
	bh=O7ml2UY/q9aQ5mWBZHnC92AGLVAKg2ZDCPDMOE02e10=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uMP2C/R2nm+Tq/9agUtz6DD4F08EsGVvxvfvrXMFJeaC8vg7ou9BpGTLlu1PcEMipaG7KyyHQUt3u3wWfEUjqTXckbmRTEOg+2Un7phtHHuVWDQh/Uumic1B0taSMcG6f6q3Pj0+f6I9QGQwvc1N+TvAOdCWv+kvAymPKg5QgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4P8udcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4P8udcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AB51F00898;
	Tue, 29 Sep 2026 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682643;
	bh=OF7BJfRH46LDAxm1YDMQg3rV3zjTGOhrHblG0XAm0Kk=;
	h=Subject:To:Cc:From:Date;
	b=p4P8udcAu7pkGOX0tQl5RHpemH7VFMpRW4sGeRShSUQ/tnFpQxLFTNMjz0q2sVvNg
	 IM05Kkvz1472yWKHYzaeXq2Sc5td/N7G2cWlpa22bjbcs/NYR9/UrVpV0TBv9wzCEI
	 Iny3uRIjnh9eOM0pNpD1sMVrMxzjMe+XkxaDoPqs=
Subject: FAILED: patch "[PATCH] smb: client: fix create context out-of-bounds reads" failed to apply to 5.10-stable tree
To: zihanx@nebusec.ai,pc@manguebit.org,root@tr0jan.top,sorenson@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:50:30 +0200
Message-ID: <2026092930-lisp-onyx-a9f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 67f4c1c6a1b51e203d986779299824d1c2c590a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092930-lisp-onyx-a9f8@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 67f4c1c6a1b51e203d986779299824d1c2c590a6 Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Wed, 16 Sep 2026 15:29:24 +0000
Subject: [PATCH] smb: client: fix create context out-of-bounds reads

smb2_parse_contexts() validates the complete create-context area but
does not limit each record to its Next field before dispatching it.  A
malformed chain can therefore expose bytes beyond the current context to
a handler.  The QFid handler also used a full response-structure cast
although it only reads DiskFileId.

The SMB2/SMB3 lease parsers made the same layout assumption: they read
LeaseState and LeaseFlags at canonical offsets rather than at
DataOffset.  A valid non-canonical DataOffset could therefore yield
unrelated in-bounds data, while a short DataLength was still accepted.

Limit each context to its Next value, reject offsets before the context
header, and reject malformed chains.  Bound the name range by the current
context and do not dispatch a known handler when DataLength is zero.  Read
the QFid DiskFileId only when the context data covers that field.  Parse the
lease context from DataOffset and require DataLength to match the v1 or v2
lease_context size used by ksmbd.  A size mismatch skips lease parsing
without failing the open.

Fixes: b8c32dbb0deb ("CIFS: Request SMB2.1 leases")
Fixes: f047390a097e ("CIFS: Add create lease v2 context for SMB3")
Fixes: 89a5bfa350fa ("smb3: optimize open to not send query file internal info")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 3464470d3297..aa142420dae2 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4572,25 +4572,37 @@ smb3_create_lease_buf(u8 *lease_key, u8 oplock, u8 *parent_lease_key, __le32 fla
 static __u8
 smb2_parse_lease_buf(void *buf, __u16 *epoch, char *lease_key)
 {
-	struct create_lease *lc = (struct create_lease *)buf;
+	struct create_context *cc = buf;
+	struct lease_context lc;
 
 	*epoch = 0; /* not used */
-	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE)
+	if (le32_to_cpu(cc->DataLength) != sizeof(lc))
+		return 0;
+
+	memcpy(&lc, (u8 *)cc + le16_to_cpu(cc->DataOffset), sizeof(lc));
+	if (lc.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE)
 		return SMB2_OPLOCK_LEVEL_NOCHANGE;
-	return le32_to_cpu(lc->lcontext.LeaseState);
+	return le32_to_cpu(lc.LeaseState);
 }
 
 static __u8
 smb3_parse_lease_buf(void *buf, __u16 *epoch, char *lease_key)
 {
-	struct create_lease_v2 *lc = (struct create_lease_v2 *)buf;
+	struct create_context *cc = buf;
+	struct lease_context_v2 lc;
 
-	*epoch = le16_to_cpu(lc->lcontext.Epoch);
-	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE)
+	if (le32_to_cpu(cc->DataLength) != sizeof(lc)) {
+		*epoch = 0;
+		return 0;
+	}
+
+	memcpy(&lc, (u8 *)cc + le16_to_cpu(cc->DataOffset), sizeof(lc));
+	*epoch = le16_to_cpu(lc.Epoch);
+	if (lc.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE)
 		return SMB2_OPLOCK_LEVEL_NOCHANGE;
 	if (lease_key)
-		memcpy(lease_key, &lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-	return le32_to_cpu(lc->lcontext.LeaseState);
+		memcpy(lease_key, lc.LeaseKey, SMB2_LEASE_KEY_SIZE);
+	return le32_to_cpu(lc.LeaseState);
 }
 
 static unsigned int
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 880ce12f50c4..4046500dbe93 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2379,11 +2379,17 @@ create_reconnect_durable_buf(struct cifs_fid *fid)
 static void
 parse_query_id_ctxt(struct create_context *cc, struct smb2_file_all_info *buf)
 {
-	struct create_disk_id_rsp *pdisk_id = (struct create_disk_id_rsp *)cc;
+	u16 doff = le16_to_cpu(cc->DataOffset);
+	u32 dlen = le32_to_cpu(cc->DataLength);
+	u8 *beg;
 
-	cifs_dbg(FYI, "parse query id context 0x%llx 0x%llx\n",
-		pdisk_id->DiskFileId, pdisk_id->VolumeId);
-	buf->IndexNumber = pdisk_id->DiskFileId;
+	if (dlen < sizeof(__le64))
+		return;
+
+	beg = (u8 *)cc + doff;
+	memcpy(&buf->IndexNumber, beg, sizeof(__le64));
+	cifs_dbg(FYI, "parse query id context 0x%llx\n",
+		 le64_to_cpu(buf->IndexNumber));
 }
 
 static void
@@ -2431,6 +2437,7 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 	struct smb2_create_rsp *rsp = rsp_iov->iov_base;
 	struct create_context *cc;
 	size_t rem, off, len;
+	size_t cc_len;
 	size_t doff, dlen;
 	size_t noff, nlen;
 	char *name;
@@ -2453,29 +2460,41 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 		buf->IndexNumber = 0;
 
 	while (rem >= sizeof(*cc)) {
+		off = le32_to_cpu(cc->Next);
+		if (off) {
+			if ((off & 0x7) || off >= rem || off < sizeof(*cc))
+				return -EINVAL;
+			cc_len = off;
+		} else {
+			cc_len = rem;
+		}
+
 		doff = le16_to_cpu(cc->DataOffset);
 		dlen = le32_to_cpu(cc->DataLength);
-		if (check_add_overflow(doff, dlen, &len) || len > rem)
+		if (doff < sizeof(*cc) ||
+		    check_add_overflow(doff, dlen, &len) || len > cc_len)
 			return -EINVAL;
 
 		noff = le16_to_cpu(cc->NameOffset);
 		nlen = le16_to_cpu(cc->NameLength);
-		if (noff + nlen > doff)
+		if (noff < sizeof(*cc) ||
+		    check_add_overflow(noff, nlen, &len) || len > cc_len ||
+		    (dlen && len > doff))
 			return -EINVAL;
 
 		name = (char *)cc + noff;
 		switch (nlen) {
 		case 4:
-			if (!strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
+			if (dlen && !strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
 				*oplock = server->ops->parse_lease_buf(cc, epoch,
 								       lease_key);
-			} else if (buf &&
+			} else if (dlen && buf &&
 				   !strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4)) {
 				parse_query_id_ctxt(cc, buf);
 			}
 			break;
 		case 16:
-			if (posix && !memcmp(name, smb3_create_tag_posix, 16))
+			if (dlen && posix && !memcmp(name, smb3_create_tag_posix, 16))
 				parse_posix_ctxt(cc, buf, posix);
 			break;
 		default:
@@ -2487,13 +2506,18 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 		}
 
 		off = le32_to_cpu(cc->Next);
-		if (!off)
+		if (!off) {
+			rem = 0;
 			break;
+		}
 		if (check_sub_overflow(rem, off, &rem))
 			return -EINVAL;
 		cc = (struct create_context *)((u8 *)cc + off);
 	}
 
+	if (rem)
+		return -EINVAL;
+
 	if (rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE)
 		*oplock = rsp->OplockLevel;
 

