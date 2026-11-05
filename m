Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907603;
	b=4SQ+GVqwTedPTtwSvVyXKt/COy8ejvvmU4alkNM16VzMO4CIqBB+PHNkITIaRkfohlTg
	 bZUIItOA1q/YYXEPB0tT7RngVZBNUB4ieDVce1T21+LoSRYYoduZ26loY2FzHONEHRedg
	 4HKw58V8oemtLqwSIJRZ/KQqkYJFI9F4JjRlo0yc2HhoX2OLY6LKV6PKppg4kLCcvdhLO
	 JF42cEC/7z1jRET27rMPpQDQ6tB6p8OiN5As5fJ6+i0V1YB+XLAAPrSwgg5FPYUSsScmG
	 0IIcFEalPJmNYuhpdXzUFjQm8JewRsr0kC1m0PbIIxr8zkuP8u9WOMVi/ciKmmsT/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6ytWN8M47eqCMypL8fB3AZ55O+IpXJQ/QmtHb+pqhDo=;
	b=EcNddrs/NSbFhFz5LAQVTvJYWdZukf5RXUhZjKtYDDn+6EhfyhXsgTKxMR9UaYarooe4
	 wc07rx+mfS6rzkf1aMc+VaC6VxWZ0/JaShHaNO+oc4wIRuS6WTOsEe8oYEWfTmGT70pru
	 VO+2htbFIHvaqWQbFSOcpVx2FRLUvLnaAmTjrtZ8LYfoTwLbBqrRvPysySJ0cVZFns6zy
	 AIMyuVKgCk7OTGg0m2+WXz6vTrBu5/li6TtIJ+Xwuzfe1j+rABrH8iUi82DFoifRtv1XO
	 wq1Xte2ZiQUOsJM0LXgCXDN6Nvi2uOZvK8RhUAsZaTNCHnNDRat/yg2wcJRvy45Xzaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArXWzHAX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B83606D50B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArXWzHAX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58781F0089F;
	Thu,  5 Nov 2026 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907603;
	bh=6ytWN8M47eqCMypL8fB3AZ55O+IpXJQ/QmtHb+pqhDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ArXWzHAXq2C1NL+gwPgMQggWgl2SxYxhdUHaVyKzYTkqLGuEz61ybtcO5qtBZUQTV
	 ikLVFQL1Z1B4hOd3b8RpbxfXkJ8Pf46xVOLSLH/Rt9RyZCPMmPulb/MB1BzquCPqvK
	 O6oKQ6jO1ZKDF9xqgUyh2rU4uLVpJSoL9HdV50pSnrV717gZcgaa2IABmAnW265PnH
	 OEdvcBg4fWTD46qgazcG5FFFgq3vNWrwwXx3Kx5gQZZQ6GXq+MgfgN6Kb/IoYQsDyX
	 eDTrfm00rutpq2z7EPHrpPhmtboSDAyb7jC94WLxTjGsvug2Ztt6hUL7zELvfoe7lX
	 XIp6KhA+/5VlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: validate SMB1 EA list bounds before parsing
Date: Thu,  5 Nov 2026 14:40:01 -0500
Message-ID: <20261105193920.2642443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110406-sturdy-reptilian-fde1@gregkh>
References: <2026110406-sturdy-reptilian-fde1@gregkh>
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
[ sashal: adjusted the CIFSSMBQAllEAs() hunk for plain -EIO where upstream already used smb_EIO2() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6e4b845a4078c..14d5c1924ae2b 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -6082,9 +6082,11 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -6161,9 +6163,19 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -6172,12 +6184,14 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	/* make sure list_len doesn't go past end of SMB */
-	end_of_smb = (char *)pByteArea(&pSMBr->hdr) + get_bcc(&pSMBr->hdr);
-	if ((char *)ea_response_data + list_len > end_of_smb) {
+	if (ea_list_len > end_of_smb - (char *)ea_response_data) {
 		cifs_dbg(FYI, "EA list appears to go beyond SMB\n");
-		rc = -EIO;
+		rc = smb_EIO2(smb_eio_trace_qalleas_overlong,
+			      ea_list_len,
+			      end_of_smb - (char *)ea_response_data);
 		goto QAllEAsOut;
 	}
+	list_len = ea_list_len;
 
 	/* account for ea list len */
 	list_len -= 4;
-- 
2.53.0

