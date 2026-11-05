Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910122;
	b=U+puNZ/u3oZF3S3yS+BLMF+Vgk+5Zl9q4gNwfzA9ugtM3QsOQb7Cw2ZsrT6lMywV956w
	 6lE/cDsFW/j2Vl8oL0zltK39iS2Qra+9DzMpUaBuXiMYWocAv1IEsFi0yOCTUdwLcDOr1
	 IMUaNE1sCOO7d9p9Jz/4rPYIJEWc33c32Lehd0lyucL1ma2GYupiD+z/sTI5Cm6gt8/1q
	 8TZd06aNDsVTPAoLv7w5j+COqIBJoC/ZF0JlH7SVMKgufnSaLck5nW8H/ADL0XlNrFhQZ
	 I8NEVO0lKU+2CiMWHxGKiRRUeNoXfzpiJq/10ygVSpH5J09ar6wbypzJ/bsR9NAeEYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910122;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GBSoKPzBBTCeZbRe09pTyWh4fNOSBFEBjT3rb6JlR5M=;
	b=BpKSiMEGT+bJZpQbEjWqW+OUrhsR3E89+j249zd5QjGCqRZomT2kmIADBjY/nrg3pMhw
	 KfitETpUZ2DgnbRImd36rBf12XYA0eThtCIvyh9On5v4KgnYys5lkdfTPYLmFvI8TnEQ4
	 8JXkBh6rn+q53RD5C94VGpVlcdJRK77j6/HJZEKqEwMaUHXmwaDvFXW5xtfuDDvDI/27T
	 Kwge9jRI3it1NWAA34jGxBhqVLan0jJVaFrm0bu9xhGFJRHzyXraR+aRrFppTROio5nAm
	 wJ8hjEiZdHMrV7lMKGD9gcNcx/Or104U50L2Tndc/ZtAic4m96F2Ld6nYZ4eulPvr5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T40MFSd2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A03606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T40MFSd2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B601F0089F;
	Thu,  5 Nov 2026 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910122;
	bh=GBSoKPzBBTCeZbRe09pTyWh4fNOSBFEBjT3rb6JlR5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T40MFSd28DYBi+1LkT7qQxQbLuEclpT1HNNkTrnIt2wzHB/hZeutFv4pxlx0xJJLL
	 SDgcceO4/BdAVb/t96eKJ4G9Lrri/nDsDPEgaXCGW+5i7ZjgDiWWQQNmbDZdzuhwHR
	 QS+UP+ui9I4O586fHVcExuLi+T6+6fagwVDn0pzUIbmm2pwzyqM05WTPooRB9KWXbx
	 VVy0IPiAwXpVskTAeLlSxL1RC7RgjyjTaKkJHGrhoGe3+XO80eIJkK6e5WykI7DuDX
	 boARnfFyxkp++CtI4ULZLybMxY1y0tYF8qj8R3XuRcWIOSx2+MQ+Ldw4cTPHVO0Qwr
	 yIMxADF+wB/HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: validate SMB1 EA list bounds before parsing
Date: Thu,  5 Nov 2026 15:22:00 -0500
Message-ID: <20261105201449.2682653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110406-guileless-stoppage-72d2@gregkh>
References: <2026110406-guileless-stoppage-72d2@gregkh>
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
index 3795fdfebb519..e3349b058dfd9 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -5769,9 +5769,11 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -5848,9 +5850,18 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -5859,12 +5870,12 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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

