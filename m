Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925999;
	b=4qestHujHGXcHb0NeniQgJ7deb+uqMw2YrHvbcopon5OpJAod7P5TglB0uUbfdZ1/k/G
	 1BFpRvzqqEcoazSQmnEgvOjk9/YDUchIXk8PSXu4NGNLE4nhckzwTC7Qmij+VV5yXOG/y
	 MCQntbmSet8KP7WoczOIw8ydocTVV1tVgBp/1pmqy7adipdbwhGVhPNLnnBsVPW3BL91X
	 CzMVApOoqDDS3ESETPAjb0oS8NZo2A8O+AIgMky8Gv/o/FSmnci/BoFWgxw7VIZ1I24EO
	 kfDfKwHo3M04397vGpVHO0tYAgSuXdjdKk8z5pLThy1S+/nzlV+XWfsxBYOOf83vshw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925999;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PqVVEmQv9UzVp1UcPGiFfeBLZ2gXYSRu1lOW7biIra4=;
	b=GDmj/L+qaxLInC/GmmVzkJrjk1sJYRbUXpsrI6DQc/iSAUY5+kUBTEW9f+wLtU0SKHK8
	 sOLW8xA1RVm9LCRoVG10ciHNfDS99OneEADqtPZfG2ifvTzPdR0DBCwVI44hLS7rYQiqg
	 Yj+jBYt/akXuXjl96LaiVd4uxhOzQP9n9xykCPljyC1z6sA+kBwPte3P+ulkY0r9CW936
	 qCk9j+qcWS1nxjV3WuSJqP21/DXttPYw+/8RoQnBBVjrp5L8eluFgv1kbjfDPaRBWVsJ9
	 Hn7t8uBzNe7W/IVzfSLnt7pPSKK+aXo39+0XmzRENxZ3xkAkiXWqJiq3QdCYUIU2XEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7qGwKly;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F835606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7qGwKly
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A871F0089F;
	Fri,  6 Nov 2026 00:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925999;
	bh=PqVVEmQv9UzVp1UcPGiFfeBLZ2gXYSRu1lOW7biIra4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7qGwKlynKI5KZOi1eCrDBSWu/A5ZePL4w7nIHjfif5QmxR9zSM56snGS51iw/F41
	 of+cOiWt1Zp2SBG8S+HlZWKDlEura38zQEnhQ+DP2qct9RNzqgcGdwdzCybQGGpjYL
	 NiiBCJDsOeIHdZLEqHUTpZS5o5khxtMZr8WzqHHpxLaRDGdJk5PjIz3cWdO6x9iF52
	 GkWnM58q0uXTwTEfZHTMqZdf1bI2qCQTerR4ysrU8Pwc/74SoMBJgS3cXZI6kTcmZU
	 OzfWQSDPbmsr0pibEtZqhJxh0MCviVi5bkEOqkExLPcQcH4eyYS+cmE4obnQJ5AI4a
	 fF4H+l/gu3ohw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: validate SMB1 EA list bounds before parsing
Date: Thu,  5 Nov 2026 19:46:37 -0500
Message-ID: <20261106004444.3298743-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-repayment-impotence-e335@gregkh>
References: <2026110408-repayment-impotence-e335@gregkh>
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
[ sashal: Replaced unavailable smb_EIO2() calls with direct -EIO assignments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 11a400663b9f2..1d8a35366ea7a 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6043,9 +6043,11 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -6122,9 +6124,18 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -6133,12 +6144,12 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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

