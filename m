Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817305;
	b=2ib8+f5/YRKH//32iNMidHjkY/XIwLNiybTjV0/Gp8wQWeF4V8uprnZsHwZe1Wi7xrtN
	 mxCce738/zBo9eV7p84+sh+MtRIRW1E5OMwwCESCqeJr86OmbMGplKt2XrGA8BSMAq8LT
	 RZNNzRw2wXIB2b8TWhQhQ9ArTEkb8H5sq4VnXQ4rUx0OZ8L52+WPTDE9Fv4H+3V1ChCEN
	 e991bvTGztNGywfqZ+0ogk3f+pez34GnPHGMwGDtSaRBN/zNG+aHl3yBkIOcKUpDqXcWs
	 gMQNXOdNiUPeK4+8XxKXzO/IjyY0HaFX3J/E6XDCYRmvApB1zosVffZ+GHmO2W8cCqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817305;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VnpcCznidD6l1F63F8JhC9CNYUyNOP6s8q1tvHzWLbc=;
	b=cjxnrQ2+fSYC9x3K5+P/npfKSC+HlmGH8VcZaZRTzkmpumyQOELXM0uyme4/nwTTfiV8
	 1+/BEVhtmEQCSh1JhkQG4hKYIQfZpBS7A7N9jHkPylU7Iv4eRb27BDqE6Wlrj/BD3QTiZ
	 577PSRKxGJeIH/6ON1vJ5JtXRIq7sjTUgAdlXFCTaCc+n0Mnlf1O4hXmZ0+6iqUFdFkgu
	 6oOaoYBLgC8G+zWyQW/fgkuPG9wJ1hR4YKQCFJNfTK2EOE52PYIWky4UOi0bRiBehbN0R
	 IdHd1nDyhO/aLhnenmXiqA7Z1urhOzClBn5+eZijGgeUNc3abcMwdh4KgSAR+daS/dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kjLRM1Yk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C1606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kjLRM1Yk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B411F000C1;
	Wed,  4 Nov 2026 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817305;
	bh=VnpcCznidD6l1F63F8JhC9CNYUyNOP6s8q1tvHzWLbc=;
	h=Subject:To:Cc:From:Date;
	b=kjLRM1YkIho7fbsG/mHqpkGpGIrLutvl4s6PF//F9tm/VLlFidRvSgA3+HOxXEr9i
	 Zdz7eu8ZieF2oWe2Pz0VN2hwYa/LEMPuu5LbxobHrBXY906Y6HbYZl0Gml3nL8RZyq
	 2lNtbQq7zHLW8c+U4MewvILO5TR0AxKb/Inx7fYk=
Subject: FAILED: patch "[PATCH] smb: client: validate NT transaction response layout and" failed to apply to 5.10-stable tree
To: ratnaker.gautam@kuleuven.be,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:34:55 -0500
Message-ID: <2026110455-observing-blush-5a37@gregkh>
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
git cherry-pick -x 83d0d5e0ca22233c75daf139ec0063b9d2ff1ac7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110455-observing-blush-5a37@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83d0d5e0ca22233c75daf139ec0063b9d2ff1ac7 Mon Sep 17 00:00:00 2001
From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Date: Sat, 17 Oct 2026 23:15:05 +0200
Subject: [PATCH] smb: client: validate NT transaction response layout and
 offsets

validate_ntransact() assumes that the response uses the fixed 18-word NT
transaction layout. A different WordCount makes get_bcc() locate the byte
count at a different offset from pSMBr->ByteCount, allowing the subsequent
bounds checks to use inconsistent response boundaries.

The function also turns the 32-bit ParameterOffset and DataOffset fields
into pointers before checking their bounds. On a 32-bit client, a large
offset can wrap the pointer below end_of_smb and pass the one-sided pointer
comparison. The caller then dereferences the parameter pointer or copies
from the data pointer.

Require the expected WordCount before reading the byte count. Check each
offset and count against the received SMB length as integers before forming
either pointer. Use subtraction after validating the offset so that the
range checks cannot overflow.

Reported-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Fixes: 0a4b92c05ed0 ("[CIFS] Add worker function for Get ACL cifs style")
Cc: stable@vger.kernel.org
Signed-off-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index e335686a68f2..9ffc94ac2069 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3787,9 +3787,10 @@ static int
 validate_ntransact(char *buf, char **ppparm, char **ppdata,
 		   __u32 *pparmlen, __u32 *pdatalen)
 {
-	char *end_of_smb;
 	__u32 data_count, data_offset, parm_count, parm_offset;
 	struct smb_com_ntransact_rsp *pSMBr;
+	size_t buflen;
+	char *end_buf;
 	u16 bcc;
 
 	*pdatalen = 0;
@@ -3800,37 +3801,42 @@ validate_ntransact(char *buf, char **ppparm, char **ppdata,
 
 	pSMBr = (struct smb_com_ntransact_rsp *)buf;
 
+	if (pSMBr->hdr.WordCount != 18) {
+		cifs_dbg(FYI, "invalid NT transaction WordCount %u\n",
+			 pSMBr->hdr.WordCount);
+		return -EINVAL;
+	}
+
 	bcc = get_bcc(&pSMBr->hdr);
-	end_of_smb = 2 /* sizeof byte count */ + bcc +
-			(char *)&pSMBr->ByteCount;
+	end_buf = 2 /* sizeof byte count */ + bcc + (char *)&pSMBr->ByteCount;
+	buflen = end_buf - buf;
 
 	data_offset = le32_to_cpu(pSMBr->DataOffset);
 	data_count = le32_to_cpu(pSMBr->DataCount);
 	parm_offset = le32_to_cpu(pSMBr->ParameterOffset);
 	parm_count = le32_to_cpu(pSMBr->ParameterCount);
 
-	*ppparm = (char *)&pSMBr->hdr.Protocol + parm_offset;
-	*ppdata = (char *)&pSMBr->hdr.Protocol + data_offset;
-
 	/* should we also check that parm and data areas do not overlap? */
-	if (*ppparm > end_of_smb) {
+	if (parm_offset > buflen) {
 		cifs_dbg(FYI, "parms start after end of smb\n");
 		return -EINVAL;
-	} else if (parm_count + *ppparm > end_of_smb) {
+	} else if (parm_count > buflen - parm_offset) {
 		cifs_dbg(FYI, "parm end after end of smb\n");
 		return -EINVAL;
-	} else if (*ppdata > end_of_smb) {
+	} else if (data_offset > buflen) {
 		cifs_dbg(FYI, "data starts after end of smb\n");
 		return -EINVAL;
-	} else if (data_count + *ppdata > end_of_smb) {
-		cifs_dbg(FYI, "data %p + count %d (%p) past smb end %p start %p\n",
-			 *ppdata, data_count, (data_count + *ppdata),
-			 end_of_smb, pSMBr);
+	} else if (data_count > buflen - data_offset) {
+		cifs_dbg(FYI, "data offset %u + count %u past smb length %zu\n",
+			 data_offset, data_count, buflen);
 		return -EINVAL;
 	} else if (parm_count + data_count > bcc) {
 		cifs_dbg(FYI, "parm count and data count larger than SMB\n");
 		return -EINVAL;
 	}
+
+	*ppparm = buf + parm_offset;
+	*ppdata = buf + data_offset;
 	*pdatalen = data_count;
 	*pparmlen = parm_count;
 	return 0;

