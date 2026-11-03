Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714437;
	b=EzZBJIzhAATQ0UrpsEMNse0yBlyrIm3P6XcO0EwpGKWC+BFOeBCgwscxFzFd9p/S5dRv
	 jXmxG967D98hZzhUGre0oR9bsKxyTU0N+C9DvekZFcTqX+MhTU0J8md2cdnVnDibLyreV
	 mYEfyOaNpfzljA5GB3YQC03RMUmUudM+Ale8xXTDtfFkkKFjO/dN4HEy+YRg/g6qDeboC
	 cJBgxU6kJ2TFMyeSAWVY0Mi7v5yVNOw13Jqrr1lBjCxnCIoM08RinG2CkaF3pnZ3Cx2gg
	 7A89iFD+ztkIQGfdVTEdwlWtrgyNx41zBiZ7T+n+P3SlE6JfZyKE1Jk053K4rVKykhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=92IEIUsn69vD4jbzySwIpFwlf38naR/78zdvvApK2RA=;
	b=l1sb2OYZcfvSFzxzz+Q3llcyRCbx7zC1S4IuOrpI9KNO3sm7Vmjn9I/ATJGluh1fh3Mk
	 XmrRDFDECCPpxqse7rVRTrkDFj23xJRjA8rTKag2SucfLR91CDX/c56pSm72Er9+oLUP0
	 1kN5/SNN6ojKSfCgqzUzg3xHHhHBn/jsQNNXPSIZ/W8eEk4bAH/bKxNly3/0P+hmx8Nrl
	 X1P3NWke1P6mBvTIzp0Be41/kG3Bz/BQwRfnFDzzzBdQbfLYoCGDgIGk7TXcyOYQ95E1T
	 5jDvK6pC8P4qNruNgdQnE1iu3YeD+ljnDIduMD0nvEbExiJSRQAC4lsiVzA5kAnEdZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1Vv7v5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C22606D814
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1Vv7v5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE91F000C1;
	Tue,  3 Nov 2026 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714437;
	bh=92IEIUsn69vD4jbzySwIpFwlf38naR/78zdvvApK2RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z1Vv7v5J42QxoniDDL3Mhh3Oih1Mhi7R2oqeDvU1CeavwwhN245DbOH8jIcbVMSt3
	 As5v674jZv+5wpEFK2ZQMZCeBtFXFTulvgiuxGpjSQFXYCKAAG3k3WL9d7SOQOiahT
	 SVHLV59iaZfp4dgzZI1lgm425TMkpN3OhtGO6u5NYeKGviWChoIGKFjmlx1YN+NSgx
	 XjVIt9vvmCWpe2EH5u1V2lNv1HUszFG3DoAtHeGMwiGihNda1gTJ2XdwBpCljHoFkp
	 wlWpQvjxb5pPnyVA16rNOTw/3nxFtyuNo2Q+FMU3PoBlv6dRpsm/WntesWplQYXf1y
	 z7cUkEpz80Yjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Tea La Forgia <tealaforgia+alias@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix extended session security negotiation for raw NTLMSSP
Date: Tue,  3 Nov 2026 09:00:35 -0500
Message-ID: <20261103140026.4191376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110305-blimp-nape-e4b2@gregkh>
References: <2026110305-blimp-nape-e4b2@gregkh>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 6868f857514bbfd2ed10b9b566664dc4a8ca039d ]

ksmbd_build_ntlmssp_challenge_blob() only advertises extended session
security when conn->use_spnego is true. As a result, raw NTLMSSP
negotiation drops NTLMSSP_NEGOTIATE_EXTENDED_SEC from the challenge even
when the client requested it.

A Windows capture shows an initial SPNEGO authentication succeeding,
followed by a raw NTLMSSP negotiation on the same TCP connection. The raw
challenge omits extended session security, and the client does not send
an AUTHENTICATE message. The unfinished session then occupies the pending
session slot, causing subsequent SESSION_SETUP requests to fail with
STATUS_INSUFFICIENT_RESOURCES.

Set NTLMSSP_NEGOTIATE_EXTENDED_SEC whenever the client requests it,
independently of the SPNEGO wrapper, as required by [MS-NLMP].

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Reported-by: Tea La Forgia <tealaforgia+alias@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index cc4233c414b66..0fff634a74e11 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -442,8 +442,7 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 	if (cflags & NTLMSSP_REQUEST_TARGET)
 		flags |= NTLMSSP_REQUEST_TARGET;
 
-	if (conn->use_spnego &&
-	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
+	if (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC)
 		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
 
 	if (cflags & NTLMSSP_NEGOTIATE_KEY_XCH)
-- 
2.53.0

