Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817237;
	b=0tzdSlU20VH0bZMxIhBn4nQXg2KSsowBwDrXf86kzPkZTzX2P0ZcFh8bIlr7RvWSy7Qt
	 JdePISNtnz4kXV+6jv+Wf1/gwy1CyRXe/DE2UqqMbK52QrsS9ZlMjk4n6TiQZE0iSF+1F
	 bGrLhsSsSbWjr6WXGpLMQc6vG7TwurN18sILHrx6QhhkqfpoAsAtJYJDsMED8Shk8RnX9
	 KOCjIOML2TrrtlpdlVcHaYbyn2xZtJxJmY20zja/zjeCphilAmUSm1KpmLKteBxKW3Jh/
	 vZFmtyE5TeiFX8XyoIPcohO0XHDSBw0dBXzFw1PnfiIbt65vDyfU/E2ZqBV6srkB0iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817237;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5ItNYq5AMwNDq/mWr5dU7zEthDG5VptAfyZiuTbM3tU=;
	b=kZ3NfvuNjc7QzYFX0f+3Msq1xh7cLezEr3/lnkix0+BLTqhNx8FzjYbWoy+4zuGyXRQS
	 WD97MmP3NbDJDawE9SE6VVRtOJqlwgRFmG/6w20w1tG3GID6crwQg/CN3OKI1NBeWTSRi
	 xkx4Xk+o5v577P5hM1agm4+1KXtJFM2aysD2hXWOv6w0FNglq3WgiTXWa0FFzNQuBMm1M
	 E2ADkLzJdBDCyqxIkr5LtPlVmry8EttMY3IPTI6nljc9/YBKc8u0XXkKnuOL4/sA/f3MG
	 LelbX6XT6G68A5r7WJ12WLd/TqfwIdcgcpdBOo/wedfvxsVgD3GMydN+CtHZ0TOVkEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HSlfR75+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF373606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HSlfR75+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6871F000C1;
	Wed,  4 Nov 2026 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817236;
	bh=5ItNYq5AMwNDq/mWr5dU7zEthDG5VptAfyZiuTbM3tU=;
	h=Subject:To:Cc:From:Date;
	b=HSlfR75+R5p8PLYrvln+xNFAwfL7bqonNTXeSo09wSdfpdU80lLc+4atQEC7FJRBo
	 T2T4xn8H7uYHwq/inqe2B2id9iUdW2bK8XMU+FTA59G87qtXFSCOHibKND3G40A4Rs
	 bgR4cq9Y5jg2lh+X+ojFBXeSH+/OSjpqJbaQSQ4s=
Subject: FAILED: patch "[PATCH] smb: client: reject FIND data areas that run past the" failed to apply to 6.18-stable tree
To: diego@bynar.io,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:33:55 -0500
Message-ID: <2026110455-defendant-swung-d565@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 29bd6773187cb5c1bbbdf90d677c6add7d58af26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110455-defendant-swung-d565@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29bd6773187cb5c1bbbdf90d677c6add7d58af26 Mon Sep 17 00:00:00 2001
From: Diego Oliva <diego@bynar.io>
Date: Tue, 29 Sep 2026 10:16:34 +0100
Subject: [PATCH] smb: client: reject FIND data areas that run past the
 received response

CIFSFindFirst() and CIFSFindNext() take the directory entries of a
TRANS2_FIND_FIRST2 or TRANS2_FIND_NEXT2 response from DataOffset for
DataCount bytes. validate_t2() bounds DataOffset at 1024 and
ParameterCount + DataCount by the byte count, and nothing compares
DataOffset + DataCount with the number of bytes SendReceive() copied
into the buffer.

smb_init() places the request and the response in the same
cifs_request allocation and cifs_buf_get() clears only the start of
it, so a short response whose data area extends past its end has
srch_entries_start point at bytes of the request that was just sent,
or at whatever the allocation held before, and those bytes are parsed
as directory entries. cifs_readdir() and find_cifs_entry() walk the
entries with nxt_dir_entry(), which checks every entry but the first
of a response against the end of the SMB; cifs_query_path_info() and
cifs_backup_query_path_info() read the first entry with no check at
all. Those reads stay inside the allocation, but what they return is
not part of the response. The last entry, which LastNameOffset locates
relative to the data area, is bounded against the received response
by an earlier patch of this series, as is every entry that
cifs_fill_dirent() parses; the walk itself and the two query functions
are not.

SMB1 is not negotiated by default; reaching this code requires an
explicit vers=1.0 mount.

Reject a response whose data area extends past the received length,
with the -EINVAL that validate_t2() returns for the other malformed
transaction responses. cifs_query_path_info() and
cifs_backup_query_path_info() still read a whole entry from a data
area that may be smaller than one; that is not changed here.

A conforming server is not affected. The data block of a transaction
response is part of the SMB, so DataOffset + DataCount cannot exceed
the smbCalcSize() bytes that SendReceive() copies; coalesce_t2()
appends each secondary response to the data area and adds its length
to both DataCount and the byte count, which keeps that relation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d8b1740b50fa..bb71fed940a5 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -4410,8 +4410,9 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 /* level 257 SMB_ */
 	TRANSACTION2_FFIRST_REQ *pSMB = NULL;
 	TRANSACTION2_FFIRST_RSP *pSMBr = NULL;
-	T2_FFIRST_RSP_PARMS *parms;
+	unsigned int data_off, data_count;
 	struct nls_table *nls_codepage;
+	T2_FFIRST_RSP_PARMS *parms;
 	unsigned int in_len, lnoff;
 	__u16 params, byte_count;
 	int bytes_returned = 0;
@@ -4530,11 +4531,19 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 	}
 
+	data_off = le16_to_cpu(pSMBr->t2.DataOffset);
+	data_count = le16_to_cpu(pSMBr->t2.DataCount);
+	if (data_off + data_count > (unsigned int)bytes_returned) {
+		cifs_dbg(VFS, "%s: data area offset %u count %u past response length %d\n",
+			 __func__, data_off, data_count, bytes_returned);
+		cifs_buf_release(pSMB);
+		return -EINVAL;
+	}
+
 	psrch_inf->unicode = !!(pSMBr->hdr.Flags2 & SMBFLG2_UNICODE);
 	psrch_inf->ntwrk_buf_start = (char *)pSMBr;
 	psrch_inf->smallBuf = false;
-	psrch_inf->srch_entries_start = (char *)&pSMBr->hdr.Protocol +
-		le16_to_cpu(pSMBr->t2.DataOffset);
+	psrch_inf->srch_entries_start = (char *)&pSMBr->hdr.Protocol + data_off;
 
 	parms = (T2_FFIRST_RSP_PARMS *)((char *)&pSMBr->hdr.Protocol +
 					le16_to_cpu(pSMBr->t2.ParameterOffset));
@@ -4567,8 +4576,9 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	TRANSACTION2_FNEXT_REQ *pSMB = NULL;
 	TRANSACTION2_FNEXT_RSP *pSMBr = NULL;
-	T2_FNEXT_RSP_PARMS *parms;
+	unsigned int data_off, data_count;
 	unsigned int name_len, in_len;
+	T2_FNEXT_RSP_PARMS *parms;
 	unsigned int lnoff;
 	__u16 params, byte_count;
 	char *response_data;
@@ -4652,13 +4662,22 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_buf_release(pSMB);
 		return rc;
 	}
+
+	data_off = le16_to_cpu(pSMBr->t2.DataOffset);
+	data_count = le16_to_cpu(pSMBr->t2.DataCount);
+	if (data_off + data_count > (unsigned int)bytes_returned) {
+		cifs_dbg(VFS, "%s: data area offset %u count %u past response length %d\n",
+			 __func__, data_off, data_count, bytes_returned);
+		cifs_buf_release(pSMB);
+		return -EINVAL;
+	}
+
 	/* BB fixme add lock for file (srch_info) struct here */
 	psrch_inf->unicode = !!(pSMBr->hdr.Flags2 & SMBFLG2_UNICODE);
 	response_data = (char *)&pSMBr->hdr.Protocol +
 		le16_to_cpu(pSMBr->t2.ParameterOffset);
 	parms = (T2_FNEXT_RSP_PARMS *)response_data;
-	response_data = (char *)&pSMBr->hdr.Protocol +
-		le16_to_cpu(pSMBr->t2.DataOffset);
+	response_data = (char *)&pSMBr->hdr.Protocol + data_off;
 
 	if (psrch_inf->smallBuf)
 		cifs_small_buf_release(psrch_inf->ntwrk_buf_start);

