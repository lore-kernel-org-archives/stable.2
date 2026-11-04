Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817658;
	b=TUGcSyS+NMyG6DDq37loFB+659EvvtnPIVTpOU+NKD1wwwGbQZduk8xQOB+4YYIyML93
	 o0fcpR0WJCzb5kko2ZzLoMWEmd9oYx1SL8B/sVqok4G8MUwz+NrH7renANSSY6O/rtSOw
	 nGdhSGp2pbusuhPW3+RYXV+9zrzo47pzwxbmPSEmXVd+4PvvLpqPihBGQzhZIc2o8/QMv
	 6wm1yv5WqxO8DbjthVX+G3ZuzCZvK68ITBvUoUGC98d6v0ox+Icf+aQZS2XJNs6ZvGK0N
	 EsNAL8GAUuSAfPY2rcpl2Is03yPwmqh9ABmvFY5k2kXOaR2kKVSLRNQNFVjQh3xA5Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817658;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ggyXg2xM+1s1EQjrkhfKY+SLad2QQIG5vrn2CQognHA=;
	b=jAqfKvfDI5stWpLoUPBJ7FHVzAj+feBI+AnOXCtgdH8DlUkEF8c1tifs1+zD6pyRvRNL
	 VCvCfbtbpvGHF5/r1YWcU09YxTxYb/KDnAhjDxsmN9Wew6jmpGAZ2XYyqkDdMKELDinCM
	 2BERQACrB7N/PEh6YtDNmUWybtv8sh5pljGIGMc6+tRUD39GIWZMlK4Hq2knfW3hvOzxo
	 C+912YyUocyAnrvnWE90KeDL9v8tfBHtFDU5wqMfWpsWQrmIYs2kRRCChf+N26SGqgeSD
	 cqd7hyy8OgfTuLmQRza97mcFLtz/xsTwlmVY9oer8jrFxRErhKZPhscFP+rCEg4hirA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kf526tEg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D0606D836
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kf526tEg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868F11F000C1;
	Wed,  4 Nov 2026 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817657;
	bh=ggyXg2xM+1s1EQjrkhfKY+SLad2QQIG5vrn2CQognHA=;
	h=Subject:To:Cc:From:Date;
	b=kf526tEga3mXHF7gS7Rk58Q0At8Dqh2YmqwHILxp5HWSi3kQVqkb3+P3LhjE5grnW
	 27yXklCRSniUpUOxId0v6W7sE4w/LaBF/pshGrb1C0t4D8AKZ6xIcsr2PLfyuDsHCQ
	 JX2vFGEFfyH948y42GTHPOQDqJg9hIPO7IgL1sHw=
Subject: FAILED: patch "[PATCH] smb: client: validate the data area in SMB2_read()" failed to apply to 6.1-stable tree
To: suruurism@gmail.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:40:53 -0500
Message-ID: <2026110453-subwoofer-stove-d336@gregkh>
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
git cherry-pick -x 2ec9cdf469dd32bcf33073aeb30c08e9356e0ca1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110453-subwoofer-stove-d336@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

