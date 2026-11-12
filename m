Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515567;
	b=sxdugUPK5cPanvKYQNWcvrrIhUWHM+9D6ac9OKmM1E+SFwJdkvEMpGzHzE2plolu/Pcd
	 Tn+8JxcXRNO8viztDkd5hFBK6WATebySLI54ij2WzU9s5GAhVjRY8owSEXAMnuUP6474/
	 XwJud4lIe+fVGZEZXx+x+eZYGNcbvUYAZ88kqoLNBLlGIfHMuEvh6GS4E7vZ+4N7RuTrS
	 bc6FZILrWJwEyubdXERke+NkaHGXDd3TlS5rPtndMpDfDgMBi+UJGvQIdANc9qENfYeix
	 EXJ6O2JVxY2kDUEOjXsXIZ9YaxLUL+Yus3XGnJj7+6PRyWqWbdP10lOE72X3Fv+m0sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yLEQJEeGq76ca0gDFQxoo7B+kV11SXoTNR7l0+gs0rQ=;
	b=Jn6MbsABOGfIQzVuehdbOoIXUSK1eFNasP5o7ePXs1zNq+yGnqU/3PpwyoUSlokUCoGi
	 UByPtP/9SKKTMi0TClTJ54US6FmFM7aOjydanLlF+o1CwoH2IPuHPj4VLvfzb556kS6DK
	 ywjAUnYIfzU+yk0LaFr0UqXm1ewx56r+879zL4EWb8bnmL/4+bBrlbhjRP8Hzv7IhAFzi
	 WgxbzJ5l1t7QUKIjAEUg7AmsKgGu/7Z4Iabwpw9SYkR3JadSpshoFzr/frKDWilb8QHLY
	 Er102IcCtD8ygOMiNXhA/VRUoBtUa4+7tkmKN5kZymNShFWtYWB566oHAAyf0cn3mAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEluTNFD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC1606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEluTNFD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957111F000C4;
	Thu, 12 Nov 2026 20:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515567;
	bh=yLEQJEeGq76ca0gDFQxoo7B+kV11SXoTNR7l0+gs0rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEluTNFDmbzrpbS73DLEUYmEc0ACIsjMc4K1jBbu0RIArD6wHA825GoAE6eSsasEE
	 2GdWBq1o7GRTVPTqcE9EAUZP7X1TAbKMsOR31BiFBt4ULCqY+g8su8NPOzkc9ujv6O
	 BscqlJTHapXt4HbhrMTlABUGCAqDGd7trkwcyjV2+5pZ0bwTn0364+ISHN7ZP0inVa
	 DvbJmTLkXPkdwc+ZuSK9aAAKSgAKDTc1p3AKpiioJYkiXGLNDY6f3/ISxKwP1Gz/lJ
	 79ns3GLFEXYrqzLDmd7WxRKuzzp8llq5CuriyKr7a17wDoJKjbiinY5uZacdZ0sX93
	 4NEn7YYf32o4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: do not read past the DACL in the access denied debug message
Date: Thu, 12 Nov 2026 15:32:44 -0500
Message-ID: <20261112203122.3440952-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201548-failed-6.1-8296a64df544@kernel.org>
References: <20261109201548-failed-6.1-8296a64df544@kernel.org>
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

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 8296a64df5448548f410fb246c1d88a93609602b ]

When smb_check_perm_dacl() falls back to the POSIX ACL and then denies
the request, its debug message prints the access mask of the ACE that
the second DACL walk stopped at. On that path the walk ran to the end
of the DACL, so the pointer is one past the last ACE. If the DACL is
the last part of the stored security descriptor, the message reads 4
bytes past the buffer, and KASAN reports a slab-out-of-bounds read in
smb_check_perm_dacl().

Print the requested and allowed masks instead. They are what the check
compares.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: adjusted context for the broader access mask at check_access_bits ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index f0ec137e4efce..d3314b516e274 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1626,8 +1626,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 check_access_bits:
 	if (granted &
 	    ~(access_bits | FILE_READ_ATTRIBUTES | READ_CONTROL | WRITE_DAC | DELETE)) {
-		ksmbd_debug(SMB, "Access denied with winACL, granted : %x, access_req : %x\n",
-			    granted, le32_to_cpu(ace->access_req));
+		ksmbd_debug(SMB, "Access denied with winACL, requested : %x, allowed : %x\n",
+			    granted, access_bits);
 		rc = -EACCES;
 		goto err_out;
 	}
-- 
2.53.0

