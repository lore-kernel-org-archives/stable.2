Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817653;
	b=PKg9KR6H+gNDWCx+Dwqt1xD4HdM7eyE4i9CBbj9gwByYOAn7h2xcWP5DaWS9Qgx3fRir
	 9XNuLfz+T2kjut1ZdaffwStMIwjNSfgdW+WqvVAYiOEDCiDWUwoqHWWOkkKMdtVFqTQV5
	 YsoemUNVjM0h3/L5XHvHMMRu3ULjOpMyvFE4+dzx+T/d+Qq8f4PUgibn4Rq+ER24ByauH
	 LRweCx5rM5MvVlivcBXZMb/HSOs5amGUKMdVkg79+i4ub5+NHU7jIkytEvgKNLU/m1nv1
	 Yw7w2Gh6ib639cfT+EcpDCRU5yAT/adQ08vq9miNDuoS0PUt+JaAMFCouKLVyfeYuPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817653;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+4isRBVNC+b2Ea3Sol+RWxRI/sV5w7waClARqKCZJZ8=;
	b=3pusgtsoxf/cQhYEiqqZxiTpxDL+yg9yCAlYmqKZbWogtGSVR8/2yZkWVMA7m5oRBIL/
	 MWal9ngb/yezn4rjhie9KlzNdjBzOZtUWMn85Dtfc3+fpepkTm+TMW4Qkbi+nIgHlC6D9
	 yC/SYZV/nblItYNdwc80eGFFnoLttaXn8YKVhsq0jJ5V5XDGv8pZVxAiwsHLwKLIlSUY2
	 etXSW7JyVf2w1TCY6ifGeuberSnOF4sf5TVIsFpGaDjX73r6kIjCD3xTo1RTGWpbnxJm4
	 X432qdxNSvKjhnRO3ODrjimEI+DtOZnm8dCfN4Mmr7wFhY9WxG712jgZt8LnZSYFVng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wY1fLASe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4D606D816
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wY1fLASe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2051F00919;
	Wed,  4 Nov 2026 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817652;
	bh=+4isRBVNC+b2Ea3Sol+RWxRI/sV5w7waClARqKCZJZ8=;
	h=Subject:To:Cc:From:Date;
	b=wY1fLASeXRE476Jmanzzcaho9UuxxCUESkMO/JFYN8qwIdhX8hFsPKVGiipYCzZIy
	 LlcB1qLfhSvPQJ9dEySh51SxJ90gGy38lgms7QCHWdaTPpHLFPmuIk9M1y/p/yxytY
	 Me/CKY+Q2vpPfqT4ACT4SRKwrakfQ42McfDjcoy8=
Subject: FAILED: patch "[PATCH] smb: client: validate the data area in SMB2_read()" failed to apply to 6.18-stable tree
To: suruurism@gmail.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:40:50 -0500
Message-ID: <2026110450-wreckage-support-bb8c@gregkh>
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
git cherry-pick -x 2ec9cdf469dd32bcf33073aeb30c08e9356e0ca1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110450-wreckage-support-bb8c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ec9cdf469dd32bcf33073aeb30c08e9356e0ca1 Mon Sep 17 00:00:00 2001
From: Abdifatah Suruur <suruurism@gmail.com>
Date: Thu, 22 Oct 2026 06:53:29 +0300
Subject: [PATCH] smb: client: validate the data area in SMB2_read()

SMB2_read() copies le32_to_cpu(rsp->DataLength) bytes from
(char *)rsp + rsp->DataOffset without checking that the range lies
within the response actually received. A READ response with
DataOffset == 0 makes smb2_get_data_area_len() zero the data length, so
smb2_check_message() accepts a frame as short as the fixed response,
while SMB2_read() still uses the server-supplied DataLength, capped only
by CIFS_MAX_MSGSIZE and the caller's length.

A malicious server can answer the synchronous read used by the
mfsymlinks (or SFU) symlink parser with an 81-byte READ response
carrying DataOffset 0 and DataLength 1067, making the client copy 1067
bytes from a 448-byte receive object (KASAN slab-out-of-bounds; up to
16 KiB in the general case).

Clamp a zero (or header-overlapping) DataOffset to read_rsp_size, as
handle_read_data() does for the asynchronous path, and reject the
response unless DataOffset + DataLength fits within rsp_iov.iov_len.
The SMB1 helper was fixed the same way in 5be5bdda5863.

Fixes: d8e050398d23 ("CIFS: Add readpage support for SMB2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 06a6ca0dc098..f85595136ef8 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4948,6 +4948,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 	struct kvec iov[1];
 	struct kvec rsp_iov;
 	unsigned int total_len;
+	u16 data_offset;
 	int flags = CIFS_LOG_ERROR;
 	struct cifs_ses *ses = io_parms->tcon->ses;
 
@@ -5007,8 +5008,29 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 		*nbytes = 0;
 	}
 
+	data_offset = rsp->DataOffset;
+	if (data_offset < io_parms->server->vals->read_rsp_size) {
+		/*
+		 * win2k8 sometimes sends an offset of 0 when the read is beyond
+		 * the EOF.  Treat it as if the data starts just after the header,
+		 * as handle_read_data() does.
+		 */
+		cifs_dbg(FYI, "data offset %u inside read response header\n",
+			 data_offset);
+		data_offset = io_parms->server->vals->read_rsp_size;
+	}
+
+	/* The data area must lie within the response actually received */
+	if (*nbytes && (size_t)data_offset + *nbytes > rsp_iov.iov_len) {
+		cifs_dbg(FYI, "bad data offset %u length %u for response of %zu\n",
+			 data_offset, *nbytes, rsp_iov.iov_len);
+		rc = smb_EIO2(smb_eio_trace_read_bad_offset,
+			      data_offset, *nbytes);
+		*nbytes = 0;
+	}
+
 	if (*buf) {
-		memcpy(*buf, (char *)rsp + rsp->DataOffset, *nbytes);
+		memcpy(*buf, (char *)rsp + data_offset, *nbytes);
 		free_rsp_buf(resp_buftype, rsp_iov.iov_base);
 	} else if (resp_buftype != CIFS_NO_BUFFER) {
 		*buf = rsp_iov.iov_base;

