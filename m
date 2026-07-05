Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD139433E93
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783252573; cv=none; b=MSTS+IKZjGHgTygnletpsC3qU6WPpTBoifAHdurnIhN95ctKtJqWaM38/m0RvqT+6O3idZI2cK7+/9bPge6F0O1w4kkulB2oKH/GfuqwDNz5EsKE0e52zOtWaFlFDfXOU7hk5lOpXx+jdSlH6PCkWlQbzR8gQndAILGqINnwZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783252573; c=relaxed/simple;
	bh=dBpnb2fM61zTI/cG7NhoPrseEWXO8kRPd0pZvs4NtWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8LpRttqv8c3y7O9sMohVidZDYdiy6hW0foaBmC72lKz+gpuy4UC4T2cBvnyiWMwjXRaaFQJV4c+NNuA+iyrj7KC3tTb89LsqBMGJtai7i6qlfRQM7uoUXLHCMwFxwGbkbk+UkFVUmxMGiPShZX+gnHXWPb1tUmCYpqDp9LN3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=IysM5M3d; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="IysM5M3d"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so1472375e9.2
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783252570; x=1783857370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6MQ/Phyg5U0tAZtVc1qJn1y5CxtgrlUlppyaWvPwJg=;
        b=IysM5M3dkEkyMBbtvzo/S2qj2GG0nUFRE/LErv+XYJYiS9y+Us3RVm6BkUI76T5phr
         geg3ntAoa0FFJ3tYAL524n0lvn9oFmOmee3Oa2s2qgxrxLk6f9Lcmgl0sh4ucWpS0aFl
         FJiQe6WP18rRRzdKem7wseX8n7hBQa0qgkTtD1BSzJrZSfVkezmJjrxHjb852ELHZSzT
         sA8XwO3y9gzR9m9Up5ikUHCP03/jfVYsiQ0G/rGpxmhqKmOMtebz5kvCvr5TgX9Syor2
         a2OXRH577BLsIKkmz2hzKwMwd37Yals/QTvo3nPyAKs2fzHfVOk/teFBY4taEdvffqWC
         xmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783252570; x=1783857370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6MQ/Phyg5U0tAZtVc1qJn1y5CxtgrlUlppyaWvPwJg=;
        b=dXRqEhRXoFGL5BOUr67Arnv6WUyBXYrwePq9f6iYEHxxxs8OWQb5pvF7ZKe5o134kF
         e9fL018kQR99dk2LchGqLuasy2zYuMqOOqYOlU/+D3IaeLIPuSY5FoKy+QL+crNA0JAR
         edFlF0LnkQTx46AErcyml8kQfOZw12bvP1I1Q8ciCiTKQNaVZJU6EZoaQgypSexAl8Jy
         yHs/mza2eW3Bg6V1oQY8oP7TqQXQlNtZjpupamMAU+esQRjDO1n9lseQGKoTzvnpVDZK
         FUR5rmC9POCWW0YQJzSNcdWvhnjBENUUNQPl0G+Y5EOB43vidzCnL7zsrw69ijIitn5N
         kThg==
X-Forwarded-Encrypted: i=1; AFNElJ+tdoOvppsW6QzknOJmwROR474My1bRTn8F1b2bbvrnksiU6kmEDTy2OnNSGWeCVrl9uIpazws=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSd2tTgWGOVoPKQ6Zx3XCysWsM2J3KLtO7uyhZAPfdkre3Bfh
	DGy9Vz+9B9YrzWJQJNDwNyKtxdY04KblTeaEN40Oz2OjVykJGoM+j1EDa+u2qQq6SMWT
X-Gm-Gg: AfdE7cnPEXCtFpXPBAkKVO2ixYQ4ckHPUAu5V2tAF/6QUYxwqz5/aYKu3kEi6pCGXXc
	AHQjoz5fKGXK64IMnoCzSlLmJvTzu1Rt0zGJ8Dn1WHn/NczGnHEq5ueD8Cle939vDNlwEJbGpDQ
	zH0n437urbtNtuzNZEkR/GNTzfikh528rrz0e3Dgjjn1d4Tig/dAknEqRiksSTr+e0eF7urjbrC
	0gFNqhF65v6sZXPlEBdKu2WXBMrdiaetISxLnKrvizBCJHRMdC5AhDTJVX4cX7uMAeZF5eIScxU
	XRjqfwo1sO4KbUG6cP2OhhxAd0FWlIKUEs+vAp+DIVn9Gf5cHJ35+ydqmeRO+g5VI3iBRW4LNc6
	p0bi2lFWx1c43riOpClHZqrww6n6ARDMbK1rGt32V68JUf++R2n+cNBOiPXcFVvLuluJrDHUYUS
	SiUZrWmZuu0hPI9ZDMThupCtDMcM9KYLiyvw7uMUWFfToPC8LqW2AqJDfhqcwxd/pWQw+yutinI
	sUBiqRhpo9vX4abjM8qmjurbMj7RxAj2Io=
X-Received: by 2002:a05:600c:6288:b0:493:bef8:ba8 with SMTP id 5b1f17b1804b1-493d1201f26mr70435525e9.39.1783252569812;
        Sun, 05 Jul 2026 04:56:09 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c636ec8asm238396105e9.1.2026.07.05.04.56.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jul 2026 04:56:09 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev
Cc: Simon Horman <horms@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net] nfc: llcp: bound the remaining LLCP TLV parsers to their buffers
Date: Sun,  5 Jul 2026 13:56:07 +0200
Message-ID: <20260705115607.60844-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 27256cdb290e ("nfc: llcp: bound SNL TLV parsing to the skb and
add length checks") fixed the unbounded TLV walk in
nfc_llcp_recv_snl(), but three sibling parsers that share the exact
same pattern were left unbounded:

  - nfc_llcp_parse_gb_tlv()
  - nfc_llcp_parse_connection_tlv()
  - nfc_llcp_connect_sn()

Each walks a TLV list, reading a two-byte header (type, length)
followed by length bytes of value, without checking that the two
header bytes or the declared length stay within the buffer.
nfc_llcp_connect_sn() then returns a pointer to a service name of up to
255 bytes that may point past the end of the skb; it is subsequently
consumed by memcmp() in nfc_llcp_sock_from_sn().

nfc_llcp_parse_connection_tlv() is worse: it tracks the walk offset in
a u8, so a single crafted TLV with length == 254 advances the offset by
256, which wraps to 0. The loop condition "offset < tlv_array_len" then
never makes progress while the tlv pointer keeps marching forward,
producing an infinite loop with a runaway out-of-bounds read and a
guaranteed oops even without KASAN.

nfc_llcp_parse_connection_tlv() and nfc_llcp_connect_sn() are reachable
from nfc_llcp_recv_connect() and nfc_llcp_recv_cc(), i.e. from received
CONNECT and CC PDUs. A nearby NFC device can reach this without
authentication; LLCP link activation happens automatically after
NFC-DEP, and the nfc_llcp_rx_skb() dispatcher applies no minimum-length
guard.

Walk each TLV list by pointer, bounded by the end of the buffer
(skb_tail_pointer() for connect_sn, tlv_array + tlv_array_len for the
gb and connection parsers), and validate each declared length before
use, matching the approach already used for nfc_llcp_recv_snl().
Dropping the u8 offset also removes the wrap, and for very short
connect frames this avoids the size_t underflow of
"skb->len - LLCP_HEADER_SIZE".

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/nfc/llcp_commands.c | 18 ++++++++++++------
 net/nfc/llcp_core.c     | 10 ++++++----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26facbf3..1a0a2f4aca70 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,17 +193,21 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	const u8 *tlv_end = tlv_array + tlv_array_len;
+	u8 type, length;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
 	if (local == NULL)
 		return -ENODEV;
 
-	while (offset < tlv_array_len) {
+	while (tlv + 2 < tlv_end) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (tlv + 2 + length > tlv_end)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -227,7 +231,6 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			break;
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
@@ -243,17 +246,21 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	const u8 *tlv_end = tlv_array + tlv_array_len;
+	u8 type, length;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
 	if (sock == NULL)
 		return -ENOTCONN;
 
-	while (offset < tlv_array_len) {
+	while (tlv + 2 < tlv_end) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (tlv + 2 + length > tlv_end)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -270,7 +277,6 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 			break;
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..0de20279e046 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -849,13 +849,16 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
 	u8 type, length;
-	const u8 *tlv = &skb->data[2];
-	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
+	const u8 *tlv = &skb->data[LLCP_HEADER_SIZE];
+	const u8 *tlv_end = skb_tail_pointer(skb);
 
-	while (offset < tlv_array_len) {
+	while (tlv + 2 < tlv_end) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (tlv + 2 + length > tlv_end)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		if (type == LLCP_TLV_SN) {
@@ -863,7 +866,6 @@ static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 			return &tlv[2];
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
-- 
2.43.0

