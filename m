Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910134;
	b=X/ipSy/yKsYdSq5DjTlPJ8vALCPBBJbP0rhiVBwCVSORktiAsAehrtCiENQom1tYnT83
	 b5LVQ6nfpOAuU3CJi+SzthfBpb6tfpNawCfuc17j7dLB2D2D9NdK8uT7/vIENOd4NOoum
	 XbcWdM+6ZuxlDa9Z7T28AgKpDV7ngjKObk81AtocZZhR6Y5YVLp37D1ZapO5rQ5gbpiVz
	 mC92zfPneh3e7sxc3yKJlP4e+fj6763kzPBvKyx784Nq3rRuEi0XGRTaiBriAwyFT25uh
	 QgKBlNKm95B0iBelPN1LC5UkAxgSnGRvfc8HyNAF0kr43tbz/XqFdV8afioOyMOH8xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SP1orB75e6nbezKp12T6XX9L8Qktc1L5Z85FyvR2R34=;
	b=WRWg9Z/iHWUtG6tTrncXfQNg/C9UiaYxFy8CKW2AQH0LSvbBzpyavxytkwrDI80YSeGZ
	 XdVknZYZKylNDGURLUyWqdXbo65xUunNDxtGzdeavU/wVUOx6b0/KduQvmWPy/L2/9B/L
	 RjHl+6jiUMn9hP2UruEeTxjxqJH/U7JjtNciH5DMACV9FblZO+0YQ823EFZ2x0asy2Lxl
	 EtJ0UcBwC9Fa6qmcBUrbnBmzfpMAxPA+qX4SqIvw3j8/YIkhL3iWbMBlrUNKkwXvgklmw
	 /9oD9IZYTGhdjJ9Oa75yPpTEb6SgVN6YmXYwN3gVHcl7b08p0lTaVuoktiCtfJL+6YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jyJnJXea;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F8606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jyJnJXea
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D671F008A2;
	Thu,  5 Nov 2026 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910134;
	bh=SP1orB75e6nbezKp12T6XX9L8Qktc1L5Z85FyvR2R34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyJnJXeaCPdUBVmUEYmTq/WBDOV02LoNBk4KFVbMZ+Q1wdT0ItVTRa+lmNqtrFBj4
	 S86IXpNG7RKzpyGm6aoRepWovkdMsOx2m3hQOy5TtPHOxpjL0Veu+otwvXbU5FEXBB
	 KMGlRHpSbCaAWrm8YfYiRt1jWmOPIJ5/TciupKUol85hKohkee4tW70eYu0sJKTAEo
	 y3EgQeGFBv0F0Rl4v5CSB+nb09CSkBoQTHRwWjols4nlwxDq9MiKDqcZPyhICn31Sj
	 aeUH0brb3KQD9rdpynKN47qFm1W/tzM80L0gqITjq9JUXtekzWTWqYJ10Z1z12RTJC
	 ajss+OMy5gGlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: validate SMB1 EA list bounds before parsing
Date: Thu,  5 Nov 2026 15:22:12 -0500
Message-ID: <20261105202150.2759890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-overprice-bronco-f64f@gregkh>
References: <2026110407-overprice-bronco-f64f@gregkh>
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
[ sashal: Replaced unavailable smb_EIO2() tracing calls with direct -EIO assignments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d2a4016acf7eb..f5e4f23bfacb4 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -5733,9 +5733,11 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -5812,9 +5814,18 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -5823,12 +5834,12 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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

