Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910865;
	b=K7Eb4VIxuSgGV9rDi7gSP3ti6gLKTJH70cZNsivulsoi4vUM8wlvdvnlRVjuZY2Ovf/2
	 VJrd/3L22hkc4iHuStiGrreWvkGzZggBvp8zliK04JL+Cv/GVXwc9K5XRv88sBfOIYTzJ
	 /Xb5siiynczH9riRMgGCgtVeeRIrLZznVV5c6f/GLKRvYHAIA85RiGVFEbbdX4alIak6G
	 FVVO4D68qgRI6TbAbu5+Qccs2iB0loJFaTOc0Efvwv4v9AkgBYXBHk/FnFdCE16TZGYFr
	 YZK2Nph+6ZxjfNLjB/PoFf/8bRC0t9scyANf0CeMlysHMAi+jrPU8+UE6+kVCS23+rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5XEO4n/7XbbTsYODadw6MFY83CxH5HdToSc+DlpB1vA=;
	b=ARL9r4CdZRqu9L1+bFrgzBHcv7FhU6u7qt9lGfWRKWmTuKk5zZ+us9uGVvOSquiD5mN7
	 FIYjSt08kBw4Pmn5QY4adsCzhi/oeyQsOPvyPa+JKhaxaipNqtULXwxAvNtWC7FVcM0uf
	 TaoawyV25NTZFk4LGJVGGAOGROe5yOF/IcXNmeHo86IT+69I1FgPM8xXyuGGw2mZaXy6L
	 XkERNKJ7zvui7OcFhrcCRqFKtGIWjHt2aY1xkfGOkolLqfYwpjIpZKr7XVPGj/ITW+D6F
	 JdWjbEpYtJompOZ1vpJFpfLBjORBXLbX5tNXe8GHXvW2OL2y/xpdW2oGGPJeE4MgeuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8F1yWmp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96972606D802
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8F1yWmp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981101F0089F;
	Thu,  5 Nov 2026 20:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910865;
	bh=5XEO4n/7XbbTsYODadw6MFY83CxH5HdToSc+DlpB1vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8F1yWmpAY+zggpe63j9IK13Cqlu6VaHEZrcMuzwH2UsDaqNPmZEWBmbiXmHZTsUE
	 RKhbenMFoD+NGkvURVS/L4LEIenujgc0tRK9nrQW1Xwk0pgAeubdvXBjwKS+6I2aBS
	 K10QV5d2DRyt2QbsKxmIXqQMSVzaw/hWFI11TZSSo4aUfTzPpC8gbJi1sGaIoqHipa
	 3VfO+5PNqOhDVKwufI5gzviKgEyJdqCnBMAqTxZZ3Bjk1N8T1TjEIhpVidONC2Pa1n
	 ZraMesyknQeAUZ/+gN86KJZX8SVhDrkMw16EPuMX7f0uSiEO+LtexZg/5m7EZc1pZk
	 tMv43dOWMasjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: validate the data area in SMB2_read()
Date: Thu,  5 Nov 2026 15:34:23 -0500
Message-ID: <20261105203345.2798304-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110452-postnasal-landlord-bb01@gregkh>
References: <2026110452-postnasal-landlord-bb01@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdifatah Suruur <suruurism@gmail.com>

[ Upstream commit 2ec9cdf469dd32bcf33073aeb30c08e9356e0ca1 ]

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
[ sashal: replaced the unavailable smb_EIO2() tracing helper call with rc = -EIO ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 1d8e491bb205c..dbc7e4936b4c0 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4749,6 +4749,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 	struct kvec iov[1];
 	struct kvec rsp_iov;
 	unsigned int total_len;
+	u16 data_offset;
 	int flags = CIFS_LOG_ERROR;
 	struct cifs_ses *ses = io_parms->tcon->ses;
 
@@ -4806,8 +4807,28 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
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
+		rc = -EIO;
+		*nbytes = 0;
+	}
+
 	if (*buf) {
-		memcpy(*buf, (char *)rsp + rsp->DataOffset, *nbytes);
+		memcpy(*buf, (char *)rsp + data_offset, *nbytes);
 		free_rsp_buf(resp_buftype, rsp_iov.iov_base);
 	} else if (resp_buftype != CIFS_NO_BUFFER) {
 		*buf = rsp_iov.iov_base;
-- 
2.53.0

