Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2C243956
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602755; cv=none; b=ryGhYYcVq1La6DlFUmOGU5YwrgqTaauNVHT8Kw73rrkTwlClDIbfis8jnItTFWifo0O1HFSH6Yg+OUhzs7srMSynQ3JRB6yW05GM8IdnF1p02X4hazQkaGy+yH8fEj5vnVyVdSGOLL1/waLifjTyy1WZeFp5nIR2Ocepj9hUX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602755; c=relaxed/simple;
	bh=iAyyFv/AQxA40DSCOj6cGXn3go3IfDOrY7GY4Sy9UyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPUpT8+2qgOq3dQ/LzGuc0daD9kijNOnXy4uXiTwZWZQ8YFsQp8bnIPcsYqpYOEXKBKYxYZJpT5ZHqOxtG6CB6piYLIRup57oFHkIhD2+HiOxdzSRQifQqNNJ5R9DAp5iHkVZUX6Qtn6dcdphIUbEVvyTCldKw/Ba+1QaYjOLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=0HUpb3ZZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="0HUpb3ZZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de0093c42so1760847f8f.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783602752; x=1784207552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H9Bxn/o6bHrATO0mn2uaPiWaqZWNuvOxb6ptBdz4eyg=;
        b=0HUpb3ZZrqe6jNid3T41CKaPgavGJH2XFVDZpU4OlrkemmGqXwgJg3skM+++7PbJoz
         lM/OTM5QiCBi7AkhWrErNjiarEbpLIoOl2TPEoy+r24R7peg4IVt39gNKvrY1i/fUO2s
         zHYhmDod8lllMEPZp7x+E9/yUUr7CqutmJtEW7PzEQejJcDiSDtm/cvnwv2I4B7hSiHw
         Dj1uGvCdOEqlEdcJnMDrHkyPUE1QXT24Ep8GvRUkfBlhVqoqH3EjJYF/b/ZDGK1FBv2U
         WQnUgusisLYMbaAqYvcFqtjMnZNp8v0G8nSsm2p8ZkIApxVhGnDmNg6/ytZN1XQeXVNn
         oUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602752; x=1784207552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9Bxn/o6bHrATO0mn2uaPiWaqZWNuvOxb6ptBdz4eyg=;
        b=A3Z/POg3Y8YjWIoiktomhPX5uMVYcsZzUX7bm5BtbqM3ZYuFWwHubpSyNpqoWuBi4w
         PV6P2mN6rrLDFruIKQb3A+qOcFN9/yb3oPfbR3oYbS5GnAFBdyrS5wvUf1XxTdF2e8zT
         1hLE+6IN0+B1UF28rX1BeGd/BNffRuTE/fxCvYIvsaZVdEiE3bM4tCjavVJItnPvbdIR
         KLe8bogo8WhW9BRPskgN5m7KU4NAqXyZqRZgqEaIWGYplzvAatGIGDEFfIGerx0mk33Z
         cSu5V0bLvSIESEb6aqH5bbiVEQqC3TrCkrbnwhn4Q83bmI9vCJ6BnMeQ2K4Rjitn0S59
         7/FA==
X-Forwarded-Encrypted: i=1; AHgh+RqrMWrnPoAi2C6W8x79Dd7kxPk1v5SXPeOcgQjRKgt1AXtHRyqtRzM865FuU4sOVhABGGGtEmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBz5OikhLaf0S4OmUmP4BAhK/SB3WPxPgWcKMNaQi/Q+kQHbXD
	HS7hInnKZZwqOOsD3RSR1fnYemI/PiD1MqG7fOqB7b3kC6jkenZxkWCoUaoOz4f7hGuT
X-Gm-Gg: AfdE7ckJr0QKF/T5rL07jci9AanZpilOfuYSF1E9ov0Ju6gRmrLClCCR7sogqr/OCk5
	ktMgSoOOyqbId3yioCchf9Uwy1SxsFORo0ZvSFoLb/B/GKumLVVqg48vbxhgBm6LX9k8l/LHVWN
	mgoK+Y56aRDtQ/QGsEBnU+E9f1yxlmp/tlJQNQKOjXXOR1KM/9BJkw9UMr1TsL5t3SovFCIiiOc
	IWX5ShuwASSbm/f2jG77kR/RS/BW6xCEM6hK/TqHpqM1MofooFtbtg6/KJRi0tlsWniGLun5FnY
	zrFoArbYkgtdZIPsJBsUJvw354polcttGuRPpNon3CZAntePCNfFT8DbKEQmlzMJI5N4Ly3s3p1
	aAAZFOzi9XYySwH0yuVHeETWHqPdqW5g7Pq5nla6AYfyjMdeQUlib4us7TDF1jM3WajbBCI3Q/U
	hdMOp86r6gv2QE/XYVN7Ep4b7UWob8FgTzLbI2eDnGcQgx7rGcI0ZMaId8n0yAFuNKnmielrvh1
	nX8UXEkX85vOAQkJJY83CZOjj5yhdvUpDs=
X-Received: by 2002:a05:6000:290b:b0:476:e67a:dfa7 with SMTP id ffacd0b85a97d-47df073b100mr7611503f8f.7.1783602751497;
        Thu, 09 Jul 2026 06:12:31 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6da9sm50439168f8f.12.2026.07.09.06.12.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 06:12:31 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz,
	oe-linux-nfc@lists.linux.dev
Cc: horms@kernel.org,
	david.laight.linux@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net v2] nfc: llcp: bound the connect_sn TLV walk to the skb
Date: Thu,  9 Jul 2026 15:12:29 +0200
Message-ID: <20260709131229.44477-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 27256cdb290e ("nfc: llcp: bound SNL TLV parsing to the skb and
add length checks") fixed the unbounded TLV walk in nfc_llcp_recv_snl(),
and commit d8bd2dedbde5 ("nfc: llcp: fix OOB read and u8 offset wrap in
TLV parsers") subsequently bounded nfc_llcp_parse_gb_tlv() and
nfc_llcp_parse_connection_tlv(). One sibling parser sharing the same
pattern remains unbounded: nfc_llcp_connect_sn().

nfc_llcp_connect_sn() walks a TLV list, reading a two-byte header
(type, length) followed by length bytes of value, without checking that
the two header bytes or the declared length stay within the buffer. It
returns a pointer to a service name of up to 255 bytes that may point
past the end of the skb; it is subsequently consumed by memcmp() in
nfc_llcp_sock_from_sn(). In addition tlv_array_len was computed as
"skb->len - LLCP_HEADER_SIZE" in size_t, so a CONNECT/CC frame shorter
than the LLCP header underflows to a huge length and the walk runs far
past the buffer.

nfc_llcp_connect_sn() is reachable from nfc_llcp_recv_connect() and
nfc_llcp_recv_cc(), i.e. from received CONNECT and CC PDUs. A nearby
NFC device can reach this without authentication; LLCP link activation
happens automatically after NFC-DEP, and the nfc_llcp_rx_skb()
dispatcher applies no minimum-length guard.

Walk the TLV list by pointer, bounded by skb_tail_pointer(skb), and
validate each declared length before use, matching the approach already
used for nfc_llcp_recv_snl(). Starting the walk at
&skb->data[LLCP_HEADER_SIZE] against the tail pointer also removes the
size_t underflow for short frames.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: drop the nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv()
    hunks - fixed independently by d8bd2dedbde5. This resend covers only
    the still-unbounded nfc_llcp_connect_sn().
v1: https://lore.kernel.org/netdev/20260705113505 net/nfc/llcp_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

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

