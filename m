Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925992;
	b=H5Bo54U4/wRW66aPc2uE5mblip9pmrqOnEkh8K6mvORZBVlRHxupxTduuBoaCURvHCtQ
	 9+I+u4DRXYEKIAZfSRWuWfsRg4jfNILHM4pWMPEc2cn7AwbXGLuhKZuYqCNvyrslZYs50
	 5Lvgeq37f6IRe4ydHiYk2Z79y8OvWRgerr3STUU5aF3siOB5k3CxQPtW3+L9ar5LsYLqw
	 IVu7T1DB9TndqTC2dLq3A2jNpWWIflYQ3WkYTfPGNT930mC6BlCWkqwVyBt444G9vcgAL
	 dD41f4QUf45i8Qvq1uZPBvKhV7Th+XnFS6l4opA5TchmwTJGmzh/4TohElHWzdZ/2zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LvqjI5xKKpErpFefDzijX/iB5GZTzn9hGHAWKydgyf8=;
	b=F4FbJRq6WFh4wDpOW9RsjUWsNg6NA4QX/QykD9STJlPMVs5XdYAIEhow7JN6MG4JTt1Y
	 4BbEACytlF1phWWM0p/jezE/RRNg4IQ7Cdm5DdUuVGckFT9mgrLlpQ9zJsAbob8Yr0mLt
	 pYwESwdglEEIhctUsGcYXQ+RxfQzx+hghbw+6gS8aJJAmbuyDPaOxtSqMtWNtKMJ1Hl3Y
	 ogfLqcIctdnTJlsvNilyt6QWIsb8A6T65391HlokUkg5m2oAD88QeKQ4zxFKCa6C1Y4kE
	 i1xMk6IBdoYhEr/QKYGE6DhBjbfQC5GJn1wFIOyhiAp/XirAUXtkw57JQXWLGgt/AAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/0wjbNI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B012D606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/0wjbNI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E2E1F0089F;
	Fri,  6 Nov 2026 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925991;
	bh=LvqjI5xKKpErpFefDzijX/iB5GZTzn9hGHAWKydgyf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/0wjbNIy0buKS9+95Rc082135pxBKk+cpWOXfcKuuA4dXQI7G2DPgtLqMMB+Obkv
	 VLiML1DHLED93g5y+L3Ps3Mg21QPMPh/+7Da5PVzWKyEyExwB7+akdnCJGwBL7DH6i
	 wR6dPd/kXyJ6vinw6hBwrwfO1h7SUASe40jhszWAAB6aGD7MUXKIgbeDLdJ4OJtnmY
	 jqz/W+YKh/3bBCNhwz8tt3JzZwoNkcltr0xwmNqq6WDR71rmROTd/Bc6hq5iw7QljZ
	 uVuUaAsX3Pr3HnQ+J3822myL998WFNsf1ybsdsQHlZfKs2zEt5stHvVKQwmZi5B2AM
	 H/Ea+Bi7R4MAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: validate SMB1 EA list bounds before parsing
Date: Thu,  5 Nov 2026 19:46:29 -0500
Message-ID: <20261106004451.3297603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-brussels-suitable-c4e7@gregkh>
References: <2026110408-brussels-suitable-c4e7@gregkh>
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
 fs/smb/client/cifssmb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 499385445cfb9..499a30ecf763c 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -5621,9 +5621,11 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -5700,9 +5702,18 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -5711,12 +5722,12 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
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

