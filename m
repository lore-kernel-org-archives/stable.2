Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFA36A358
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979983; cv=none; b=qp590P+SHSpBdOjF3NUw7PFGWjRL8jkspAL7ptU0kB1yhMCJIBW/tlqh0SBi+VJ1JCEwMSOaE3bQ/sL5W3SY7bH7i9zgD9s/XfrruScn+C24dyGiAtuArVyRAolVBnDRZBA/PSSwhOu1r7DhtVvRikI87DBba2HNqBflviNJmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979983; c=relaxed/simple;
	bh=CHryohLe/fnBYpOI8e4BvVaoKUdQxQ7HJ+W2ldsPKKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nl+9EvZ+F5msR+7S/4rKkhNJGcEBPrYKSOUv3QmEzLtfRxtCPD0m0CtEcEa9xiIGkjk8aJ2tdHLpXvt1XQA9JAyDqJtj3DIsV00dGmBE92fDZJI4Ioan1rarckKs0/82Heq1IIaSWpaURmcw522/OSfx6QmFvID4V1/2QcJlANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=d4Ba279q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="d4Ba279q"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493ba701891so2338835e9.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783979980; x=1784584780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=37p3VfmrrNMS4akxO403NRH36eKSLE6Wn3AfUCl+4gA=;
        b=d4Ba279qNkP/UzpnjQeR3R07VNfGiC7musfQDHgXQlPqo/ZZtjEKD23esT9dGQ91Tn
         V4qnX13+i8lyy4l1VYJDvtctc9g7MdmxVeMT1i37ee2iw10bnVJoG/DKd/qJy6eGTLaD
         VNcZCeKLzKS0rVxAd6q2nXeB7VvAWJ2TLSQyS/fbLTZ/ic9dP286KML7L8TXikk0u36k
         wJQrOHY+9D4yfNz2hCypcXChHxyzaNEdPT3/ftsiiqEEyoujBeWrRn2wkPmciZ/21VqJ
         3A3Mfc/A1RHvUz1lOoAUr3HG4Bcrr1zmpVVgctWaPFYuYwqr708BM/whR6LQ4qR6qdJp
         2GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979980; x=1784584780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37p3VfmrrNMS4akxO403NRH36eKSLE6Wn3AfUCl+4gA=;
        b=Aim32RId8ZscFfugjYsCv1xTUc7OhDKWr3XYmMQfsLzdUpKlm+elh3r02tZNhRpqrA
         YT/kD3UMkef1aksnQPHfwTQXGKTbwQh2Bg4NfISBOlafZF1XvqPFyaySqR5515Y5492B
         J3Svz23xKqzS8I/Sf9AmjrQbtiNEjPPkAK4aSXol4l8f+yFzKqCHw4zkCE0dvF5Z08mG
         7WuzkJluS1Z5ezdsM9CjCNaZV3Zl+3triPg8TmHRSLrTmWDow1/4k25LD6iWGXWdNpW8
         M1N2L5mLdSDAHFEPcwdKglTvAjTC8jJ4eRHX5Jhc0fsCbJwFc4BoDxJAfILPxbMMedp/
         XSTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpy1OU9u1GDb84xuDGdjxq2mOcGpFgTO/6YKXe2+2ETlv08dy8MMrVIWm8yXQsN/Czh67Lbx54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+l5QWFYA4KwmJUJ7MdLKy+DJ7LNGF1OHLAMiMsKcUhB7Qt45
	1q1QizxIK7X6capNbJQ1CGWs43wQUP3Z/spaQlT5mgiqWMfvPBwzieMLfULOWPlcXCrRhbthwoy
	2AJ/+dcjW
X-Gm-Gg: AfdE7ckXYBR90NuTqFH4O52Q1jJorHinkutgucxqw7vxHR17HqfYOaCGXjtGYbHSCNb
	kGhqHCPPKtJPsjUOVAuM7fPOmtgv6z3ckmuqM7Pcid5JeYj3xbimnf0NbNVTDtiWe/KGUlBdnfg
	4G21DmI7npOChXxEXYpqI3dEX6C0V+NWKHG53mYJrRI4aL/YmM6IRvb2ZrSONC/3QCZ5t8XMlC9
	1ruqaMvcno3a/S8d9hHZV/SdeH9AtGoxHXSWNEwCN2WbwFslzkut2K9wIvevQErwdlf9Uxk/gaR
	6TQsTS9xFhRuz7havBYtnmmEY/Drx1QigkEJ4H84LnUWQE4o4SEW+Zy4tXgw2oIuDB0fExSdvch
	kPzH/Y7/zbJKKth5WEYf17wgDrcIavy4NV56AtVlchXBfRsuTOC+n7U0Tou++ITjckuLtw7i0dj
	rgKZPbwSUUAYyR2sicdEEkP4Y9Y8sjfqeDX0Y49pPO41iqcB0eXdeSXgwXvSqHzVLUKQHrs1hPA
	2FI3d0T9LmEcIEJEwa5j0XXWCy5qU+As3s=
X-Received: by 2002:a05:600c:b90:b0:493:b967:178d with SMTP id 5b1f17b1804b1-493f881d05emr112865375e9.19.1783979980087;
        Mon, 13 Jul 2026 14:59:40 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f9402sm28390785e9.13.2026.07.13.14.59.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 14:59:39 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: microread: validate CARD_FOUND event length before parsing targets
Date: Mon, 13 Jul 2026 23:59:36 +0200
Message-ID: <20260713215936.23137-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

microread_target_discovered() parses a device-supplied MREAD_CARD_FOUND
event into a struct nfc_target, reading fixed offsets and -- for the
ISO-A and ISO-A-3 gates -- a variable-length NFCID1 straight out of the
event skb. The only length check is nfcid1_len vs sizeof(targets->nfcid1);
skb->len itself is never validated, so a short event makes every gate
case read out of bounds past the skb:

  - ISO-A / ISO-A-3: fixed ATQA/SAK/LEN reads plus a memcpy of an
    attacker-controlled nfcid1_len bytes from the NFCID1 offset;
  - ISO-B / NFC-T1 / NFC-T3: a fixed 4- or 8-byte NFCID1 memcpy from a
    fixed offset.

The copied nfcid1 is exported to user space via nfc_targets_found(), so
the over-read is an information leak (and a possible oops on an unmapped
page).

Reject events too short for the fields each gate case reads.

Found by 0sec (https://0sec.ai).

Fixes: cfad1ba87150 ("NFC: Initial support for Inside Secure microread")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/nfc/microread/microread.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 4149c5d735bd..9a7a4fd6796b 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -483,13 +483,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 
 	switch (gate) {
 	case MICROREAD_GATE_ID_MREAD_ISO_A:
+		if (skb->len < MICROREAD_EMCF_A_UID) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    skb->len - MICROREAD_EMCF_A_UID < targets->nfcid1_len) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -497,13 +503,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_A_3:
+		if (skb->len < MICROREAD_EMCF_A3_UID) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A3_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A3_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A3_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A3_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    skb->len - MICROREAD_EMCF_A3_UID < targets->nfcid1_len) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -511,11 +523,21 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_B:
+		if (skb->len < MICROREAD_EMCF_B_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_ISO14443_B_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_B_UID], 4);
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T1:
+		if (skb->len < MICROREAD_EMCF_T1_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_JEWEL_MASK;
 		targets->sens_res =
 			le16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_T1_ATQA]);
@@ -523,6 +545,11 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T3:
+		if (skb->len < MICROREAD_EMCF_T3_UID + 8) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_FELICA_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_T3_UID], 8);
 		targets->nfcid1_len = 8;
-- 
2.43.0

