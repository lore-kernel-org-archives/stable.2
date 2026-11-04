Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817313;
	b=Rg9zhnyjZbkOAv26QYJrdKkGgOAJLEngwl3t+i1zgDoAX8T9MhOKnUbZ4wSOZZvnWeEM
	 IgTwaiKIjF69TvNZaisLLUuhDmnhiJtcjSoMNMNjis9p4lNkERJArNRXWyMnA19M5ti7z
	 lSy0XH/oHKwnS8GCWLm5k1d1/FviegGKUXUdfT7Yqy0pBb+G1rsEZaj88hYVf9gW6/2W0
	 bC5/Q+LkGE95WbaEpYECGDs7+qXrnsGhP0a9aTJcF7nDJDHOx49uDkAsFj4e1bp93RUAo
	 FN7Fq3PE2jBUF8my9xqCMzL75qPs/M/1HsDZVboGaIpMhxHprg6nme2RK66p2DwfUyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817313;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q6T7aAAK1Gu6TL7CkwMAqARnMJ6yopazxuR77mMX6bc=;
	b=xlKMyjwGBagn+moQjyqIOUtblmEUwWlWnXXDingP//gj7IfFttCVraGlgEdocVC/ufny
	 MrTYvMf8IIynnkt69i2Rv3PBpKSfjYDdsi5U94VLWYyFsiCLCpvDfUhhoI8A/OJwmoOUK
	 r8DKBPf4ZbhYmWeq0rroiu4jAcQOHS49ybK/qMByhTS4Hk52QYMnSbDWEt+jrsCNM07QN
	 mo9rhM8QGNCQukotmSKDMu/P/Ki8GKb0eAOOZ9c4QBMdb2NxmXdxsoVgKq1disAx8Tlvy
	 uf11Skj5fcuMc7Sa6jGJzgrEH5Ayf2C0bt2K9peiT/rc2ONREgMrAyMvCfJ1FmesoVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u+jF58J8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E8606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u+jF58J8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8471E1F0093A;
	Wed,  4 Nov 2026 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817312;
	bh=q6T7aAAK1Gu6TL7CkwMAqARnMJ6yopazxuR77mMX6bc=;
	h=Subject:To:Cc:From:Date;
	b=u+jF58J8cL/OWBHZl5V8iP59uckYDR3p7SotorhEeX+tQ/zykn8/Vs8u3q1ka9IxI
	 2DL7cFyOZ7g3LFohODJyOdlUKxbvsYbRZwLuaR/1viIRFapWLGQoZPZcojad1rbdtY
	 zgEJX4MPcKjvDXGjBAEX8YRcDcLthrO0edGEGQgQ=
Subject: FAILED: patch "[PATCH] smb: client: validate SMB1 EA list bounds before parsing" failed to apply to 6.1-stable tree
To: ratnaker.gautam@kuleuven.be,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:35:08 -0500
Message-ID: <2026110408-brussels-suitable-c4e7@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ddc7a7e1eeb116ccaf010a6f1fb6ab927f3f888d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110408-brussels-suitable-c4e7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ddc7a7e1eeb116ccaf010a6f1fb6ab927f3f888d Mon Sep 17 00:00:00 2001
From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Date: Sat, 24 Oct 2026 12:36:14 +0000
Subject: [PATCH] smb: client: validate SMB1 EA list bounds before parsing

CIFSSMBQAllEAs() checks the server-provided EA list length by adding it
to the response pointer. On 32-bit systems, a positive length can wrap
the pointer and pass the comparison. The parser then walks outside the
received response while reading the next FEA header.

A response with a list length of 0x40000000 reproduces this as a native
i386 page fault and kernel panic from listxattr() against an SMB1
server.

Check that the EA list starts within the SMB byte area before reading
its header. Keep its length unsigned and compare it with the bytes left
in the response without pointer addition.

SMB1 is not negotiated by default and requires an explicit vers=1.0
mount.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 9ffc94ac2069..2936b38de98f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -6215,9 +6215,11 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	int bytes_returned;
 	int list_len;
+	u32 ea_list_len;
 	struct fealist *ea_response_data;
 	struct fea *temp_fea;
 	char *temp_ptr;
+	char *byte_area;
 	char *end_of_smb;
 	__u16 params, byte_count, data_offset;
 	unsigned int ea_name_len = ea_name ? strlen(ea_name) : 0;
@@ -6296,9 +6298,19 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 	ea_response_data = (struct fealist *)
 				(((char *) &pSMBr->hdr.Protocol) + data_offset);
 
-	list_len = le32_to_cpu(ea_response_data->list_len);
-	cifs_dbg(FYI, "ea length %d\n", list_len);
-	if (list_len <= 8) {
+	byte_area = pByteArea(&pSMBr->hdr);
+	end_of_smb = byte_area + get_bcc(&pSMBr->hdr);
+	if ((char *)ea_response_data < byte_area ||
+	    (char *)ea_response_data >
+	    end_of_smb - sizeof(ea_response_data->list_len)) {
+		rc = smb_EIO2(smb_eio_trace_qalleas_overlong,
+			      data_offset, get_bcc(&pSMBr->hdr));
+		goto QAllEAsOut;
+	}
+
+	ea_list_len = le32_to_cpu(ea_response_data->list_len);
+	cifs_dbg(FYI, "%s: ea length: %u\n", __func__, ea_list_len);
+	if (ea_list_len <= 8) {
 		cifs_dbg(FYI, "empty EA list returned from server\n");
 		/* didn't find the named attribute */
 		if (ea_name)
@@ -6307,14 +6319,14 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	/* make sure list_len doesn't go past end of SMB */
-	end_of_smb = (char *)pByteArea(&pSMBr->hdr) + get_bcc(&pSMBr->hdr);
-	if ((char *)ea_response_data + list_len > end_of_smb) {
+	if (ea_list_len > end_of_smb - (char *)ea_response_data) {
 		cifs_dbg(FYI, "EA list appears to go beyond SMB\n");
 		rc = smb_EIO2(smb_eio_trace_qalleas_overlong,
-			      (unsigned long)ea_response_data + list_len - (unsigned long)pSMBr,
-			      (unsigned long)end_of_smb - (unsigned long)pSMBr);
+			      ea_list_len,
+			      end_of_smb - (char *)ea_response_data);
 		goto QAllEAsOut;
 	}
+	list_len = ea_list_len;
 
 	/* account for ea list len */
 	list_len -= 4;

