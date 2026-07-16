Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A2331EB8
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231382; cv=none; b=jWMwDLzvrTpucvv9iZUXcgRY8cfieR6koRZksyjuwcoLDqMXZ72k4u0n+9zVsmsK8TEjylynnM+6kcezceKQ3IwOK18UHrfyrR7BL+fVkrTSFRRIIRaQ01GF0BEkycWnFl/SJsP/MBI0VtpLtbpqZhMwvYPH3NQIjtiX56fbknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231382; c=relaxed/simple;
	bh=XSEsEgNlwWPvDsdw1SmXQc6lSpmBAnebdVFgAvN6ddM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPldzzuaWR3IN6C9nk5TAy8DY4uNHsbXiDvHDREBbcf+O5WFf7Jojzoj5M1JXO05kBDlwgfupTll4tBog37/oEnpjNdpSXLCBOWcGKQWK8SDgnP9Ihhcs+ukymAsd++09PXghZmw7xoJqrOnrphA1GCSHTBMm5yKJxg0M1H2I1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3jYvRnt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3jYvRnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1B21F000E9;
	Thu, 16 Jul 2026 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784231381;
	bh=/Pbz57vgSSvpW4MaE+HoWOZ7XihtFdszrTHbyvVHM8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S3jYvRnt8cRcAnaJQlX2x1m2GWFLw3YsDLsA8btYwDc4VjkJnIw7H2kxIBf05js/q
	 512hDV7xsG7o1FqMbXP//vVMvjV7TW7A9Yi1K4Ckp+pOO9JYm8YYn4/t9IrAXOYmrm
	 P4+eYcjJBdYJiV3LDUjdsmR4WHeL06MNAHog/xZaXNtLI4IHU5adBQlaoxlIjALM+e
	 uJziM155MNZIal4lcLdBRwj7txER9CYrfW5BVcjtYa5eoZhX4WGZFTX33MFvznw3ff
	 uF+ef3fbRIV1XsoKUg7bge7GxcGzD5ckfpZ+O2L8fxBgRLH8vKic9oRrr9vD8s+4NN
	 84LzVAknpu+cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Sashiko <sashiko-bot@kernel.org>,
	Ignat Korchagin <ignat@linux.win>,
	Alistair Francis <alistair.francis@wdc.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] X.509: Fix validation of ASN.1 certificate header
Date: Thu, 16 Jul 2026 15:49:38 -0400
Message-ID: <20260716194938.1111666-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071443-crouton-afterlife-63a4@gregkh>
References: <2026071443-crouton-afterlife-63a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 3b626ba431c4501512ad07549310685e07fe4706 ]

x509_load_certificate_list() seeks to enforce that a certificate starts
with 0x30 0x82 (ASN.1 SEQUENCE tag followed by a length of more than 256
and less than 65535 bytes).

But it only enforces that *either* of those two byte values are present,
instead of checking for the *conjunction* of the two values.  Fix it.

Fixes: 631cc66eb9ea ("MODSIGN: Provide module signing public keys to the kernel")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260508033917.B5873C2BCB0@smtp.kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.7+
Reviewed-by: Ignat Korchagin <ignat@linux.win>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 certs/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/common.c b/certs/common.c
index 16a220887a53e8..c7bcf3f6a77e39 100644
--- a/certs/common.c
+++ b/certs/common.c
@@ -20,7 +20,7 @@ int load_certificate_list(const u8 cert_list[],
 		 */
 		if (end - p < 4)
 			goto dodgy_cert;
-		if (p[0] != 0x30 &&
+		if (p[0] != 0x30 ||
 		    p[1] != 0x82)
 			goto dodgy_cert;
 		plen = (p[2] << 8) | p[3];
-- 
2.53.0

