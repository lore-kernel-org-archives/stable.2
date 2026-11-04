Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817262;
	b=4vPDCO3Rp3QdeH8zZat9q0aRX8bz6MYvCdnOAn8jUyCOh35yTuHMM6RlEvnbNGfTE6Nb
	 rQpwDWp5qQRVpj0gU9bFhuUK2bqbe3qmJ56yMxY0gj3KLDEnW48FK4Evqk13Vo+vGvztt
	 YMD6CHFhOkQttifSABpLcw5lYTshNTtRKNTkIVRjGt4YGxLurIPfe64XS91g0qx3QXyXk
	 hwXnyWv3pknuLn7LtxVBSyEYMW3WzmX9DjYA2zDNnyFtoM1uo7Vu5LjCV5LGBeMWF/LnX
	 86lM6Gpbka6T5y/bvZ7/EWCbdrR8h8p7NFcaw5VIQyMnMoyf8tyjsa5G6PCcGMpvnyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817262;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VWb8VkN0HFuhgH3iJuLPNZzVfObium/C7ZRe4MSAqN8=;
	b=hKHDYKIp/ISsIRS5VXLoJYOH1/yAYxM487DKnr83WW6gr6+GcmvjhGXssqOK6JKOm5Yy
	 lfjnpwcevQI8SoILTietXpt0GOfWAE+N8N9dCHmT/kcLaI8TEPxhW1mTSmqtMCT8aI9l6
	 YSH0INz9OWV19+q5eANA/yiRR4SVoP0AYFojCmteAd3AR22gYTQbQPA9SzTIPauX+n+TP
	 7UkhOIQuipStcYsX1yYoMLoIje2o7c7tCLNDyScGbPRVtz4NIeXUNbn8lzNBtRlNCXSew
	 Py55RzIX5D25G9zD4fBAFR4QL1rQ6qHLQ/dqEwqGVaGt2ZEesNixEHMdJ3Xn8SauDjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cZppNFXx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3CD606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cZppNFXx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DCF1F000C1;
	Wed,  4 Nov 2026 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817261;
	bh=VWb8VkN0HFuhgH3iJuLPNZzVfObium/C7ZRe4MSAqN8=;
	h=Subject:To:Cc:From:Date;
	b=cZppNFXxcjfSANdiKuFyqtyT5WoO6b4rIv1T6y5mIPjtsh6biU6W9sVCarQCo0bR9
	 oymOenAgeokDe6i4gw4vTO8TaKBgagAHcE+Z9CPcoD1zkcylUrDImowTO8KubQAMCZ
	 Vu8QNNK+u5zDZLRzUPlqbppwF+auutFJvZWQBjVE=
Subject: FAILED: patch "[PATCH] smb: client: reject short or out-of-range FIND response" failed to apply to 5.10-stable tree
To: diego@bynar.io,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:34:16 -0500
Message-ID: <2026110416-exclusion-stack-7d67@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 531aa4239b0d80d7146b102b98f7aa7da989ccdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110416-exclusion-stack-7d67@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

