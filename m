Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8264348C47
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683428; cv=none; b=Dp7Ro9TM9cItiVb7mhDrutC3t4+u91h8TMYvZIU6wTahRUKfoaqp5LITJ78DxQamjT66JiVeqbCPMkoLLZo6MJKp1R5h7PuzJJomI/rRDGhdlhLUg5GqODtX6CJ+8CmEuPAezettL5cxMLte4fJKmFIz8T/pTapdyWdTF+B463A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683428; c=relaxed/simple;
	bh=4qFHrJ8TjRhzwg9eX6E4uCk78ScEs4rJofH5o2OZmu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvgYMxP58XAAVwio4qL5zQjQFQyqevDw08QkMBFr4CcnwjKT9kOy+/CqehpDkuMdB7kDGMBYB7uNdG+Eycqw6iw2FGfsRtg+tCxbxND9268cjbvXx5dgLMp1i+Du2Nrq3RPP367pL5RNgCuhFYDwaSW/aTpXwJhy+Rt7E1BbXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlmrVxOL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlmrVxOL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c825c88744so15484655ad.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782683426; x=1783288226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xJeWro39OB82LbHgE7JTjiXJkNJO0xjWGuLEsvgMVw=;
        b=BlmrVxOLuMWywpvxEAR7aOzqiogLp74+5JIaPgaEwcmYgoLPqdOnaDCRJOhbynQ0p0
         T8XUfsRe1WseWBB5V0zm8MpcVoU70WqAuzJ0Dcsrlod/aUXr/3ySL8OY2ECd00R3U+ZK
         CN8F94HYkVYkaFfravcdCP9hiQQU7FQQgnXrsrBeETJI86uZl9Tcrbd+ltj7S3oO+BWx
         +OGLOHMyCukZ3YtoARPQnT7lfc7PqctmxbjMbjueC2IzyWsqm5mi1y0GzX3d1nT52HUp
         ntWCjXIL86LT5obNzfQd2romE50TPWQUM13i8kRDPJfCMy4FEDsePt6stIRwSbUGQcga
         UjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683426; x=1783288226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xJeWro39OB82LbHgE7JTjiXJkNJO0xjWGuLEsvgMVw=;
        b=kXFbUEPI605PboluF1WUMI7zmA+PAfyJOR43077n7fXy8OdBAdMW6fxwwtE3vQ/Jqd
         ibXojjACPwzO5YBoJd0ojnQjJiuPyrvL8A3fjc8vGdzjoxNGI/yitnbevNmzMkVy9Wbm
         ySWpDFES8TEHbgrlpnyKJ2VDFtHEYkhpVAqFu2VxlIxN74rZSELpQOmOcNiXQNyf1LYi
         JMcwDZh7XM33pbfU8+zso8jZr4LpNZxJYLFBy4CKyyc/8wo1yTAyOaEjO2FaHVfNssgt
         WXrXcQxsI/409GLYIK1E+qY4xb1kRkierdLVl+rTOp8A5mEeU8vTSl5AGzTE/QHTb8vK
         NKcA==
X-Forwarded-Encrypted: i=1; AHgh+RpX1gz7m8wKXq9GB2ZI+lx9iIgvs1x54yak9KOyXqz6hv9kPdqXuRD6cDl43IPw8XBoM/qW9tU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bPEzxlC9QsZ9RPptIGx18gr+L2QIiQCy+9qzc/e7bf7T79Q/
	ujNEFpOB7aelRLTJExazTDntm7kEAWng66LawopErpTmYb7QOC4ofqoc
X-Gm-Gg: AfdE7ckBABSY6T2V6/GxX7lXWtJtf/lxJKeZFRCPlbpXoj5jYEvWnq13JtdELBusV6p
	C/xMRmQ7b6AkcNh7vusWPJGKm1c/Eiau6rDqTOD+eZodjq5aIUknIbvXyyuFWa5vs+DFs61MpFO
	x6i2d44G1ht2wbHjEbliMKleMyfaGvjZcRFy6y7708g59U5GELH9Zj3MCNZ9wixUpBQNJXt87gQ
	3ohSbW2fdIUWs5CVvlfTwuc/QCZPSpgvz3JkLg8FG1R/YFC+IO1f4mGz7yT6ZqRu+/yZn04LW0z
	NJbNO7QmGJO4pMvdp5rh3v13xayt0CWGeySP6fh3oaY4aiW4NcEl51gXzXZHrYnTqMiCz12D5Jf
	0u0DSPFDtR4fmbeWVixyuH4zVskFXcXOv9RzLouGC+cYZgW4bJxcbpgevAG5jtApQrPgjCp8a1t
	cQgav91mp4uWwAF/TibXL/RmKFKkUF3NxKL0/v9e+dPS+f0vU6U/CwXU3pI/VwSQ==
X-Received: by 2002:a17:903:1cc:b0:2ca:281:27fa with SMTP id d9443c01a7336-2ca02812986mr8901775ad.37.1782683426051;
        Sun, 28 Jun 2026 14:50:26 -0700 (PDT)
Received: from node ([149.40.62.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9e95e49efsm14044425ad.52.2026.06.28.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:50:25 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: david@ixit.cz
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net v2] nfc: nci: fix use of uninitialized memory in NFC-DEP general bytes
Date: Mon, 29 Jun 2026 02:49:29 +0500
Message-ID: <20260628214929.135152-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_store_general_bytes_nfc_dep() derives the length of the NFC-DEP
general bytes by subtracting the fixed general-bytes offset from the ATR
length:

  atr_res_len - NFC_ATR_RES_GT_OFFSET   (poll, offset 15)
  atr_req_len - NFC_ATR_REQ_GT_OFFSET   (listen, offset 14)

It never checks that the ATR is at least that long.  When a
RF_INTF_ACTIVATED_NTF reports an ATR shorter than the offset the
subtraction is negative; because min_t() casts its arguments to __u8 the
negative value becomes large and is then capped at
NFC_ATR_RES_GB_MAXSIZE / NFC_ATR_REQ_GB_MAXSIZE.  remote_gb_len is thus
set to up to 47/48 even though only atr_res_len/atr_req_len bytes of the
on-stack atr_res/atr_req buffer were copied from the packet, and the
following memcpy() reads the uninitialized remainder into
ndev->remote_gb.

Zero remote_gb_len and skip storing the general bytes when the ATR is
shorter than the general-bytes offset, so that a stale remote_gb_len
from a previous activation does not survive into the new session.

Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/nci/ntf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 802928ca4d51e..b72545daa2051 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -654,8 +654,10 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
 		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
-		    NFC_ATR_RES_GT_OFFSET)
+		    NFC_ATR_RES_GT_OFFSET) {
+			ndev->remote_gb_len = 0;
 			break;
+		}
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -669,8 +671,10 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
 		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
-		    NFC_ATR_REQ_GT_OFFSET)
+		    NFC_ATR_REQ_GT_OFFSET) {
+			ndev->remote_gb_len = 0;
 			break;
+		}
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.54.0

