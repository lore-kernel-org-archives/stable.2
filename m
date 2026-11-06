Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925998;
	b=FzfNvfFnfHBT4VeHUMMEt/4IN/uRzylew2fr5wrEWveOCnhEDfkong3/2/Rp+s3g3YOe
	 I3xU6QzCeGUDKYSxHc8hwTea6XuJRLpWYYqHfA+EmQcrjoIokJVwd3gaYNMkIIYyHeLbW
	 totGAUYejYhzcfF8w9vhAFk/I0FGcADVpYG+hyO8hIb+K6c5cauYqSQk/a6CfBulB8YCy
	 LUYc0RGcgKphtswS9DrbB8lsVLM9KWuOsTOXLVjnY2u1XU1d7bgqeaBfVBHVdiYlOI2C3
	 ORfXaSw8+WlCxXKQCyqiX4X5yfPBSgEp645InxnPmUyDcjlUAt8tRJSmxVSXAsYXhsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pqJ02zqkzIIteZMIYTbkLC5jlWjNmXlSWDgL2WT15pI=;
	b=w5Njjkphqm/V+noO1BJ0jQFDxb0G4RYcqA+Ml6itL73gobnWUeZr9oPpYb3wcUUaCOrp
	 35mJLnfUGjBP0T9py04F0LaZ4EQ8QOxxsqYK4Ah6zxTsKx9fv4sqZXAkEfkTvtwjV0tMh
	 qVCybxr/Py2uKdWZOwoOQm6LhS+99X+FXCQKB8x7o52YFix8sRM+OMT0VBiTojIKgCakv
	 Tylz1F8W7AZ6p2LKw4qomhUmKitaB4mnUnMitBhwQ+n87/DVoh7CAesmjVohB7ATlv9Ep
	 o2uQKOa/D8g4MJVW69C2Zipozcp/5Gxhpwuh2N4K98g53bZdD1kxr0ejpIuFVC5qrjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tcg418X0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CC606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tcg418X0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1081F008A1;
	Fri,  6 Nov 2026 00:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925997;
	bh=pqJ02zqkzIIteZMIYTbkLC5jlWjNmXlSWDgL2WT15pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tcg418X0bd1uGW8DerIzUJHZtqap+RDouYcB2KQPnY5d4eB6zC0K3tcQCTz0ZoZzD
	 +COHctQgITH2hR54qC8DjeoRVKZSEpCz+zpqECRs+4jz/I+gcZyDov+HDur8sv/FQC
	 +kj8hWyMn02Ifl/evzHoC+hX1eSEgIiuyk6RrBe0vdS0U43IO8VH0DKnOcofHZAfBv
	 3etIStz9eJTUmWtZAlZmgceufS8lpV5RfQjs+naOU3EJk+aZeM93hEZk2wp6kazV4o
	 6K26RlSob3gdMLGnyE91C4JuR7gD8s53VM2RjpwVSzvIDUB4Qy9txH4DxMzgGhanjv
	 01Mf+okmzb04Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: validate the data area in SMB2_read()
Date: Thu,  5 Nov 2026 19:46:36 -0500
Message-ID: <20261106004444.3299802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110453-subwoofer-stove-d336@gregkh>
References: <2026110453-subwoofer-stove-d336@gregkh>
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
[ sashal: Replaced the unavailable smb_EIO2() helper call with a direct rc = -EIO assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 716662453e19d..75942195b619c 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4559,6 +4559,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 	struct kvec iov[1];
 	struct kvec rsp_iov;
 	unsigned int total_len;
+	u16 data_offset;
 	int flags = CIFS_LOG_ERROR;
 	struct cifs_ses *ses = io_parms->tcon->ses;
 
@@ -4616,8 +4617,28 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
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

