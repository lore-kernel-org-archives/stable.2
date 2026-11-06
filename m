Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930094;
	b=DHgGuJNiPMCWbTR9udk+jhtNhQZWyxV3kMW3NM0apFYhddN7WKvK+XQ6WmfKOpryfzlW
	 r1M1sSHvnhvuHB2v22LjxRCCTWWgA/qmdlWL+RV4PqNjCS307wABFhCnKfN7/FvE1CsdH
	 r8NrU15DCDz7WP9naBA1fgFO52Jqx1Fdf5zIDoFff0MbpkkM6ZyykyqfkXqcU/Bzjsk83
	 7DuNewKs61CUca7OYYoD6+n+DnxKexuaWs7JUqWB2Sh8o5BY43jqtlXQs19zzLbnVFQwc
	 BIDps5o+LFFkS8cUSMzg1f2uAXGt0eC8bAQOgovJZUwAv2OWZvlTA74y+8X+GXo9mkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z7TjEGEIcQ/fUtqSVBVy9oBW03ctzPAD1v4INxLAKtU=;
	b=mHBdmjQW8lQIG8+uxF1Cc4rpjefZU9ed1effnDbKF1FwPcCgn1BXex2S3D5ekEnXujP8
	 wgf1OiM0Hgg+igJK6q4MH6c2gNcpr8B6qxBv/d31AjTj8EHPFxpwq+sZnT0GLb8BW2pwr
	 YI8/10qAbLcJKx2nvDswAXqVwDmOVxlz1wW+x6upDpAAuAW2s+zcL6+RgsXIFQ8qJkwUt
	 xAYgTJs86LBCq9PybwFAObi3pSxdTu2OOhGZ+SXcgv+RANtDVU5TaS4FHBCl2AfpWqK7i
	 NKplGrbiezY8nQqzm0k5mgROTmDkk+ZyfQ7Pg72t77XIoIlf4iastt38XtI614GEjxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XKkMQK/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5882606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKkMQK/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFBF1F0089F;
	Fri,  6 Nov 2026 01:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930093;
	bh=Z7TjEGEIcQ/fUtqSVBVy9oBW03ctzPAD1v4INxLAKtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XKkMQK/BgzRQkiYkmSahfOhADTQV0mBqQeOBRsxDEDjsDfHMtTlkQDjQpbEo0FYw4
	 h+V8mUlWvive6xiHaYXz5G8AFesexRWRx0o/gXAcQT/8dzwvnCnZ8cOBAWtKaoyNnw
	 DUZn5FjfHEqgy9i8Jw1luV+jKdd+GRBa2ED2NVN321Vr1jSXBPp4mHa0TGCMfnX0NV
	 w/3Gw4gKOrrKBUjCMJfvak+VzBfSnP1PukgNWER3QQ6jqO1/CePTt5hQl8iKd9Ld6l
	 OP2/8MswrWFki3YemVmnuZ9zvjv/M9YZ6CiW0MNWXyu/i2lTnnjch0kXtNxHkaz3+9
	 J21ATIixPJAZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: validate SMB1 EA list bounds before parsing
Date: Thu,  5 Nov 2026 20:54:51 -0500
Message-ID: <20261106015247.3502365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110409-unsoiled-surging-adc6@gregkh>
References: <2026110409-unsoiled-surging-adc6@gregkh>
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

From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>

[ Upstream commit ddc7a7e1eeb116ccaf010a6f1fb6ab927f3f888d ]

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
[ sashal: replaced smb_EIO2() calls with direct -EIO assignments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 67ff1669cab2a..6926291316809 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6201,9 +6201,11 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -6280,9 +6282,18 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
+		rc = -EIO;
+		goto QAllEAsOut;
+	}
+
+	ea_list_len = le32_to_cpu(ea_response_data->list_len);
+	cifs_dbg(FYI, "%s: ea length: %u\n", __func__, ea_list_len);
+	if (ea_list_len <= 8) {
 		cifs_dbg(FYI, "empty EA list returned from server\n");
 		/* didn't find the named attribute */
 		if (ea_name)
@@ -6291,12 +6302,12 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	/* make sure list_len doesn't go past end of SMB */
-	end_of_smb = (char *)pByteArea(&pSMBr->hdr) + get_bcc(&pSMBr->hdr);
-	if ((char *)ea_response_data + list_len > end_of_smb) {
+	if (ea_list_len > end_of_smb - (char *)ea_response_data) {
 		cifs_dbg(FYI, "EA list appears to go beyond SMB\n");
 		rc = -EIO;
 		goto QAllEAsOut;
 	}
+	list_len = ea_list_len;
 
 	/* account for ea list len */
 	list_len -= 4;
-- 
2.53.0

