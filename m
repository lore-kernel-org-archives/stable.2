Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817257;
	b=DzqHO4DXdz5cWkOt5SItQZ4zrT6jUsr4sgc4w1nBr+eQq9Sxh2knZ8bcIbTGlox0uZnY
	 35ccbccEsaiULK6i+k3vPXPSRivBjd2Xq/mzhysQG7Ri47xzXwMxEIQBm9JNvYMqDtQGI
	 ALv/syz9nMIjoSlG+1VHvkhyECr24Am1xuUt1PkDl8qDqlHmBA4Dh0zWpUGNt8QYrmInD
	 V2FCCP/WzQCSbp/nIo2r1NVXwmTvx2zHSPTo0su0k+gZMHsalM2vuuhMvBqmmwdO9520E
	 MdyfS/W+nrkC/UKDsZZCb0NLpVOeMKwJOL1ToqgbW9+ikpKoO+uY1UO6p4VaXos2PBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817257;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tSpN1Qql+SvF7DDBkoN1a84j83CjoS04t4eDukMYEts=;
	b=0xvuBuhhyw+jN0cA5hQM72G0Wrq/NqCTa4imia5EwAqIlYwpyAquYhOGWABq1JJa093h
	 EPZk+Jn0p3iIvY++djfD+71GV1VAk+QE62MJBWKD5n4dvKigw2bHishIt1JgGH2SVcmQX
	 HTsbIa9ApgMAHgKP9YhZpxTvQz1+fomAbegecjl5ocDi78A47E5Q6tXdUSOdoM7wCnnSx
	 9yUittECR83V+BpvwkttLRflUpoXZSzv5OyUsdwvIoNedwDqJfr47HZ0Yq0kcTIjUzSU3
	 s1uDIvE/sSsGYk8+tqI3E04bVA86JO7+SjUUkoyNtbVXGLK2ZVGlmS1Ajcoym5GTEvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iHipZJAM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C71606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iHipZJAM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E421F000C1;
	Wed,  4 Nov 2026 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817256;
	bh=tSpN1Qql+SvF7DDBkoN1a84j83CjoS04t4eDukMYEts=;
	h=Subject:To:Cc:From:Date;
	b=iHipZJAMy1P9LxhQZfhQ4HhgC6xB8NgpHJkO8+q97Fen4QJwTjm8MyeBT4S62DgdZ
	 zL0y+fec6HpS7ZbQlt+NsMH9UxOGItu2lC8BbGMRkfOUrm0loSAkRxzKFP4we1JkJf
	 zg6WxwYCdfIXIXArTomzlsF0OtI/Cy0yKVkUJPFk=
Subject: FAILED: patch "[PATCH] smb: client: reject short or out-of-range FIND response" failed to apply to 6.6-stable tree
To: diego@bynar.io,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:34:13 -0500
Message-ID: <2026110413-sandpit-deceiving-8d0e@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 531aa4239b0d80d7146b102b98f7aa7da989ccdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110413-sandpit-deceiving-8d0e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 531aa4239b0d80d7146b102b98f7aa7da989ccdd Mon Sep 17 00:00:00 2001
From: Diego Oliva <diego@bynar.io>
Date: Tue, 29 Sep 2026 10:16:35 +0100
Subject: [PATCH] smb: client: reject short or out-of-range FIND response
 parameters

CIFSFindFirst() and CIFSFindNext() read the SearchHandle, SearchCount,
EndofSearch and LastNameOffset of a TRANS2_FIND_FIRST2 or
TRANS2_FIND_NEXT2 response at ParameterOffset. validate_t2() bounds
the offset at 1024 and ParameterCount below 512, and nothing compares
them with the number of bytes SendReceive() copied into the buffer or
with the size of the response parameters. smb_init() places the
request and the response in the same cifs_request allocation and
cifs_buf_get() clears only the start of it, so a short response with a
ParameterOffset past its end has the search handle, the entry count,
the end-of-search flag and the last-entry offset read out of the
request that was just sent, or out of whatever the allocation held
before, and a ParameterCount smaller than the parameters has them read
past the end of the parameter block. The reads stay inside the
allocation, but what they return is not part of the response, and
CIFSFindFirst() then hands back a search handle the server never sent.
That handle is sent back to the server in the next FIND_NEXT2 or
FIND_CLOSE2, so two bytes of the buffer leak at an offset the server
picks.

SMB1 is not negotiated by default; reaching this code requires an
explicit vers=1.0 mount.

Reject a response whose parameter area is smaller than the response
parameters or extends past the received length, returning smb_EIO2()
with a new smb_eio_traces value for each of the two responses, like
the other response checks this file gained since v6.19. Backports to
trees before v6.19 need smb_EIO2() replaced with -EINVAL and the
trace.h hunk dropped.

A conforming server is not affected. The parameter block of a
transaction response is part of the SMB, so ParameterOffset +
ParameterCount cannot exceed the smbCalcSize() bytes that
SendReceive() copies, and the response parameters are 10 bytes for
FIND_FIRST2 and 8 bytes for FIND_NEXT2, which is what
T2_FFIRST_RSP_PARMS and T2_FNEXT_RSP_PARMS hold.

This patch depends on "smb: client: reject FIND data areas that run
past the received response", whose declarations it extends.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org # 6.19.x
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index bb71fed940a5..94ed6a2d3541 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -4408,9 +4408,9 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 	      struct cifs_search_info *psrch_inf, bool msearch)
 {
 /* level 257 SMB_ */
+	unsigned int parm_off, parm_count, data_off, data_count;
 	TRANSACTION2_FFIRST_REQ *pSMB = NULL;
 	TRANSACTION2_FFIRST_RSP *pSMBr = NULL;
-	unsigned int data_off, data_count;
 	struct nls_table *nls_codepage;
 	T2_FFIRST_RSP_PARMS *parms;
 	unsigned int in_len, lnoff;
@@ -4531,6 +4531,18 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 	}
 
+	parm_off = le16_to_cpu(pSMBr->t2.ParameterOffset);
+	parm_count = le16_to_cpu(pSMBr->t2.ParameterCount);
+	if (parm_count < sizeof(*parms) ||
+	    parm_off + parm_count > (unsigned int)bytes_returned) {
+		cifs_dbg(FYI, "%s: bad parameter area offset %u count %u for response of %d\n",
+			 __func__, parm_off, parm_count, bytes_returned);
+		rc = smb_EIO2(smb_eio_trace_ffirst_param_area,
+			      parm_off, parm_count);
+		cifs_buf_release(pSMB);
+		return rc;
+	}
+
 	data_off = le16_to_cpu(pSMBr->t2.DataOffset);
 	data_count = le16_to_cpu(pSMBr->t2.DataCount);
 	if (data_off + data_count > (unsigned int)bytes_returned) {
@@ -4545,8 +4557,7 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 	psrch_inf->smallBuf = false;
 	psrch_inf->srch_entries_start = (char *)&pSMBr->hdr.Protocol + data_off;
 
-	parms = (T2_FFIRST_RSP_PARMS *)((char *)&pSMBr->hdr.Protocol +
-					le16_to_cpu(pSMBr->t2.ParameterOffset));
+	parms = (T2_FFIRST_RSP_PARMS *)((char *)&pSMBr->hdr.Protocol + parm_off);
 	psrch_inf->endOfSearch = !!parms->EndofSearch;
 
 	psrch_inf->entries_in_buffer = le16_to_cpu(parms->SearchCount);
@@ -4574,9 +4585,9 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 		 __u16 searchHandle, __u16 search_flags,
 		 struct cifs_search_info *psrch_inf)
 {
+	unsigned int parm_off, parm_count, data_off, data_count;
 	TRANSACTION2_FNEXT_REQ *pSMB = NULL;
 	TRANSACTION2_FNEXT_RSP *pSMBr = NULL;
-	unsigned int data_off, data_count;
 	unsigned int name_len, in_len;
 	T2_FNEXT_RSP_PARMS *parms;
 	unsigned int lnoff;
@@ -4663,6 +4674,18 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 	}
 
+	parm_off = le16_to_cpu(pSMBr->t2.ParameterOffset);
+	parm_count = le16_to_cpu(pSMBr->t2.ParameterCount);
+	if (parm_count < sizeof(*parms) ||
+	    parm_off + parm_count > (unsigned int)bytes_returned) {
+		cifs_dbg(FYI, "%s: bad parameter area offset %u count %u for response of %d\n",
+			 __func__, parm_off, parm_count, bytes_returned);
+		rc = smb_EIO2(smb_eio_trace_fnext_param_area,
+			      parm_off, parm_count);
+		cifs_buf_release(pSMB);
+		return rc;
+	}
+
 	data_off = le16_to_cpu(pSMBr->t2.DataOffset);
 	data_count = le16_to_cpu(pSMBr->t2.DataCount);
 	if (data_off + data_count > (unsigned int)bytes_returned) {
@@ -4674,8 +4697,7 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* BB fixme add lock for file (srch_info) struct here */
 	psrch_inf->unicode = !!(pSMBr->hdr.Flags2 & SMBFLG2_UNICODE);
-	response_data = (char *)&pSMBr->hdr.Protocol +
-		le16_to_cpu(pSMBr->t2.ParameterOffset);
+	response_data = (char *)&pSMBr->hdr.Protocol + parm_off;
 	parms = (T2_FNEXT_RSP_PARMS *)response_data;
 	response_data = (char *)&pSMBr->hdr.Protocol + data_off;
 
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index bb8d0197cb54..2708bedb49ab 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -30,6 +30,8 @@
 	EM(smb_eio_trace_ea_next_offset,		"ea_next_offset") \
 	EM(smb_eio_trace_ea_overrun,			"ea_overrun") \
 	EM(smb_eio_trace_extract_will_pin,		"extract_will_pin") \
+	EM(smb_eio_trace_ffirst_param_area,		"ffirst_param_area") \
+	EM(smb_eio_trace_fnext_param_area,		"fnext_param_area") \
 	EM(smb_eio_trace_forced_shutdown,		"forced_shutdown") \
 	EM(smb_eio_trace_getacl_bcc_too_small,		"getacl_bcc_too_small") \
 	EM(smb_eio_trace_getcifsacl_param_count,	"getcifsacl_param_count") \

