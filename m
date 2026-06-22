Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596E3AE185
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134292; cv=none; b=BrkeBFZRg5387ASKC6kCJo4gZmBaOUQXxR91OVcai4a09dkP7atdTX6lMpxHeE8JnTInI7cH6Jk1XS9mOeF2MIXP9kH3cSdd6py/s4pDvOvNRkfBuBrnIILbrJtqcsUuQi7itVJs8EGEBjk+sVjJJADMIAPDYkxVywDHcqCM1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134292; c=relaxed/simple;
	bh=yyw0nMtUQFYySF+Vo3tr4O3uzZRBP38LtrsViqoS/Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=becMBH6Sozlb5MnBTo2fsiXyKaB9q2b/RKu0EsssRSKIVsEhprDHDMH0v3EDhxVClKzCwGClyIq0L/W5R26BknK2NX/Ym8KIroZx5YxMQpKewDFryeV0HLTsU/ZMFtzKahkD86oo74/+e2zRXfpQLKFCaSXjLteCOZSIRybx13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T29KCQpC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T29KCQpC"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c07fd4dc2c8so457291066b.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782134290; x=1782739090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64GS0cV1F3q6Azsz5ClQ2jQ7hHXoaFyqY/ADvWBZ5O8=;
        b=T29KCQpC83FMWIUMXtVjT7ip3KbjcDOwIVyOIrMEOwMoPZt2iD38tI9zYhfnNFrKcN
         els/EjHrO9ufU+9dzWhXbvNB/CeuNmmjVzqeL8mWc5rC7cMoL1zQB+tYZmJhzkcQgxGn
         jdH8hO/8OQO7/FzJV4rV2ySzHhDXUGQ8TQJz5LHgY85yNUNq8UjJsEUnEi5WUMMf3WZs
         WZXFFjzW9fZaKi3Nu4OfejxoV/d0aO4dHwvRskXEx5Z3Ca+lIhLIF9AQtDhXedSk3h2k
         9DJVJPbnUxdwUUxjPlgR62k04mHHegXtLpIwqlu7srNmfVudDCzj+SPXzH8bec3NrDUP
         g/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134290; x=1782739090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64GS0cV1F3q6Azsz5ClQ2jQ7hHXoaFyqY/ADvWBZ5O8=;
        b=kDTe6OYo1M62nS/KQ1X0T2G+GZT6KQUw35bK+ohREht+xSBmviXtlDYoIxRgTgObtt
         VhuznRBViMQc3uzIqWRpCkEizFX0JhsPa1KDpZCrh8T+0dkZjvaWbG+huCK9k9/Lq3t8
         6EfZvTx/uM37VdPoOT5OPH7Vhgo7n8xKNwndDix9DE9uZvO1jdniZZ+aaLKey/n9Tksn
         oKx3W90LJmTsAdv9JwxyGME3uaVuLmPUS6yLXf9eM3yFpTF7n9vHE4fj68ACtRi/neQq
         /6pp/dGJvLXgXurJki0Yd2uiuJZFUQnoU25B75o1r4l1p2+VRx6YC8G4GlbcOaCjnt5T
         e0Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/jXhTpCi+d5zFotVoPCh+nusa+DNVcdgMeN3xNMVdGEn7pVqOzJ48N+sYd4w2Z7NXr4AasNKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47DW0BxGD2ULEVyjs0TY3bN5lVcLwqcYOSKIr9blrDJTPmTMi
	dC884SS/22L7AfHy+SndJ2Ss+sf+DzCjQgD5JY6BLEtsb2Cc3T1ibH5y
X-Gm-Gg: AfdE7clIZWuVJ5+2ZWuKZ4Z5Vu6wDW9NgRveTkWL/hBjCnGrWFKE1qDOPLQjUEDI6jA
	EYIp2+V3M5VzHzep0fNLQjmjkeOCeYzjhjjFKv8+MYXWUfTH6/3NvQQ0z7/7ncD0hA1aHFZGBTz
	/zwZ99mDny58P6kFifD5GvaNVVuU80vWB4QP+n5WMsfnLbRAdP5W+blinK/iDP/w65Thk177rZa
	8ZeMlgKle3IE35MTrZdhsR8+loDnDH5eSnElqEV6OWFF8a6FKni8pyZPsGEsi52HjXCLNxqt0eg
	fFFn1FcfSeGkHAeLE0e2qdOP264sFLlDfMu8CsKTnNHu12WLcRonG5F2NRapIloxoUXyZDLb4Rv
	9bRy6ncIw74DR48utyzU059GygM2deHlQp+WiS7z5B8RQPzNXPgDX1sf+jF/6yclgd9v32Odx1M
	UoO5uB6M8OcrYG024caLbeDTzvcrh2sCdM3UPQ7lxb+/upCYrFGYgKAIli8C4=
X-Received: by 2002:a17:907:3e9a:b0:c0f:cbe8:7830 with SMTP id a640c23a62f3a-c0fcbe8976dmr71683266b.38.1782134288453;
        Mon, 22 Jun 2026 06:18:08 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99b968sm356605966b.24.2026.06.22.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:18:07 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	krzk@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers
Date: Mon, 22 Jun 2026 18:18:02 +0500
Message-ID: <20260622131802.239035-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() contain
three related bugs in their TLV parsing loops:

1. 'offset' is declared u8 but tlv_array_len is u16. When TLV data
   advances offset past 255 it silently wraps to zero, causing
   infinite loops or double-processing of buffer data.

2. Before reading tlv[0] (type) and tlv[1] (length) there is no
   check that offset+2 <= tlv_array_len. A truncated TLV causes
   an OOB read of one byte past the buffer end.

3. After reading the length field, the value bytes are accessed
   without checking offset+2+length <= tlv_array_len. A crafted
   length=0xFF on a short buffer causes up to 255 bytes of OOB
   read past the buffer end.

Both functions are reachable without authentication via
nfc_llcp_set_remote_gb() which feeds remote LLCP general bytes
directly into nfc_llcp_parse_gb_tlv() with no additional
validation.

Fix all three issues by widening offset from u8 to u16 and adding
bounds checks for both the TLV header and value field before each
access.

Fixes: 3df40eb3a2ea ("nfc: constify several pointers to u8, char and sk_buff")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---

Notes:
    v2:
     - Rebased onto current nfc/for-next.
     - Dropped the previous nfc_llcp_recv_snl() fix since equivalent checks
       were merged by commit ed85d4cbbfaa ("nfc: llcp: bound SNL TLV parsing
       to the skb and add length checks").
     - Retain only the fixes for u8 offset wraparound and missing TLV bounds
       checks in nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv().
     - Reject invalid TLVs silently with -EINVAL; dropped the v1 pr_err()
       logging, which was reachable from a remote peer.
    
    Link: https://lore.kernel.org/netdev/20260519011937.12903-1-meatuni001@gmail.com/

 net/nfc/llcp_commands.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26facbf3a..ca89fe967d6a2 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -201,9 +202,15 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -243,7 +250,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +259,15 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {

base-commit: ed85d4cbbfaa4e630c5aa0d607348b42620d976b
-- 
2.54.0

