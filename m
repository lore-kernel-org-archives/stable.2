Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6F408029
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184531; cv=none; b=aOjrKUyRC1Sb7x0bs7tfd2HBMc4N1OObV2RbXNfCJct3BMZNnskg6YfyELmrrfRrr8ukR0xLlr0hYKzg6Hhw2S/1zh+ICx4n1trtCcRoxb/YUpaxGtUo7i0UQaaOmIvbDHwI00nFTzmRC6CatSwSxqhJo2epYKyGcftgnziShIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184531; c=relaxed/simple;
	bh=crKmGM2BPtU1gWofMArc5RSNIxo8syCXCMCQHJjzvSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXfE8l57FDaM6jl4CiSRNmRUR7RRmDoCXioFoZqaGEMDe2p4thnhqFRaMG5V0UOcBnrEdu5nlTCUn+hgkcGyAZbZc+rhErY91r88n4KeTPCKLfh4ZfMYLheu7+lRIbh2koUWbRzsgrJhlBQ0gGzHCCvhevf6oW51qMAurwLViJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7juqfne; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7juqfne"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0aa420401so61377505ad.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781184528; x=1781789328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr6lr/Zk4qDdZQL9yjJdI0zh4QdrOtRvdN1aN8UPXKU=;
        b=e7juqfne4BEQWFb7uAsbNpZ6bBRPG3XKGRIkDFcLIKc8iHJxeg9PA4FwMuKx7izMrC
         zvcAYxmIVlTvSVBp+TMJHP0r1EQvwEbLGK1fGIJ+6nyoZvSRfLUe1zf5TI8PldPbCOr+
         ExKcFbrPiAyvvEReMVudx9VRa36T2oNDa4o4DPEoXd+cy+n4LSq6ciplza6ioTStRog5
         CwEA07jb4eRKzZ2RQU/QQ1bYgjYeve4XXm+ZtkLjWDdzygl5E8vZhMSF7XVlOeJPpmcQ
         13yn1ybBiP5X0e0jfSA0u4mDoweAI90lqnk/Xl4BwjhN5Oif7gfuybYKUrNhIT7cAMPW
         yw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781184528; x=1781789328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr6lr/Zk4qDdZQL9yjJdI0zh4QdrOtRvdN1aN8UPXKU=;
        b=FBuoxY4DyfDa0qUMERl0kULLCxhyUR2LMlN+WsguwRTxVwE9QwVUny1EsZKtbayuBi
         ezuziB93uKakWQqRqqCjsYO/oP34dyQlpzS+wrlerYm9s6ReSnV3oBMG+rogDfif7oEb
         TYe7IaADc1qpSWQqFqC0Lk61cprNNXGuLODqpKnlM8hHsZG5ZT0GfoYpVNr20ir1bhaz
         2yCcIOvWWNZ1Ci1GPrkAYaawFH/Fij3DmqXQoZ+9kyq+RQHPtob41q85SzMeYT5P8+oq
         Ywpx0TYqFsUthOnsHOMApMCyDwlIRXb6OkY1/Gq+9e0qk8b1a1QRry2Gta36tsyoAamt
         sK5A==
X-Forwarded-Encrypted: i=1; AFNElJ9I1VsdTBDbeCasTN4KHMMNxBycoEiWAfvpt8mdKB6yPAjlCmEdlo0mtF3Oww9HYgWqtYeA8/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkU4cQ5L2MXYU7wwlpDSsSp+8R/72FOBsWPKPVLuo+RFxjN2Q1
	vyywh2kDSO/6cIDibBRUxRWklPaR6qBOGCvgYFqP7UBBsgsu5hwAuVmV
X-Gm-Gg: Acq92OE5AXWwsaTgdpwvyiYEIacHDCy5i/RNX88MZOygxt0ozkt246Rf+QvF06WdQfn
	Y88HWK31YVfcTRoxUMfmzzuOXem9SMxDC62d8vPk1qgI8VmRmdeJCOE2HkCzl59aQfvMOK16r1Y
	ejkRZ0sJOZzfXDmzw9g4VM0sScm1dwjlwewTTMi8WJtE43MQj9hhEVpb4ke89km80aHb/VoJgSE
	BFhIuYlv0GkJzxEZeGdwUnr/JgNjewWruboaNVkjUYqfkc1soB2yRJ3Va+7mOlOI/ANLLNeKvGE
	BSWud6Fr2CyeTKdQpATA5oATPjr0Jmj3CMjRR1SaBKnwdeEh10tHHNEtMZxhHw8GAmqvirXopBS
	5W47qoeS/GIu7OOusT8CmGh8X2p5nBcha2hIYaa9z5tP0saKPxfjev4L4uK0TUmEvaAzNwZ7DZ+
	1IkivqCfk2Mopmlg8F6hk0mI/rfDqfzgXxAFCAK+SltGoz2lVQkUrs3AHOMIEy4WmZEAGbspnoK
	GeslLDEC/FIBp5JkDOoVzidfcLbi9kgiUCVijP/qXsFVZ3JjDmCGbn5kMUBbCEHIfZavHew/ix9
	9zKnD4W5Cp8NDOYAkJod0xqaeQnK+z7K4HhhjyEiOHrk5fKj
X-Received: by 2002:a17:903:90c:b0:2bf:dd8b:7cd with SMTP id d9443c01a7336-2c2f10165e3mr31858515ad.10.1781184528412;
        Thu, 11 Jun 2026 06:28:48 -0700 (PDT)
Received: from jfk-HP-EliteBook-640-14-inch-G10-Notebook-PC.cse.unsw.EDU.AU (dyn-dhcp-226.cse.unsw.EDU.AU. [129.94.175.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cfb4sm292927115ad.59.2026.06.11.06.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:28:47 -0700 (PDT)
From: Weigang He <geoffreyhe2@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-media@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>
Subject: [PATCH] media: cec: stm32: prevent out-of-bounds write on RX overflow
Date: Thu, 11 Jun 2026 23:22:48 +1000
Message-ID: <20260611132248.114519-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stm32_rx_done() appends each received CEC byte to rx_msg.msg[] using
rx_msg.len as the write index, incrementing it on every RXBR
(receive-byte-ready) interrupt without checking it against the buffer
size:

	cec->rx_msg.msg[cec->rx_msg.len++] = val & 0xFF;

rx_msg.msg[] is a fixed CEC_MAX_MSG_SIZE (16) byte array in struct
cec_msg, and rx_msg.len is only reset on RXACKE/RXOVR or after a
completed message (RXEND). The number of bytes received before RXEND is
decided by the remote CEC device (it sets EOM), not by the driver. A
peer that keeps sending bytes without ending the message drives RXBR
repeatedly, pushing rx_msg.len past 16 and writing peer-controlled bytes
out of bounds into the surrounding memory. This is reachable in normal
operation once the driver has probed and receiving is enabled, from the
IRQ thread, without any local privilege.

The length check in the CEC core runs on the consumer side, after the
byte has been stored, so it does not prevent the overflow. Bound the
index in the driver before the store, as the other platform CEC drivers
already do (e.g. tegra_cec), dropping the excess bytes of an overlong
frame.

Found by static analysis tool CodeQL.

Fixes: d69ae57453c8 ("[media] cec: add STM32 cec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/media/cec/platform/stm32/stm32-cec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/platform/stm32/stm32-cec.c b/drivers/media/cec/platform/stm32/stm32-cec.c
index 1ec0cece0a5b7..8c2fc232202de 100644
--- a/drivers/media/cec/platform/stm32/stm32-cec.c
+++ b/drivers/media/cec/platform/stm32/stm32-cec.c
@@ -132,7 +132,8 @@ static void stm32_rx_done(struct stm32_cec *cec, u32 status)
 		u32 val;
 
 		regmap_read(cec->regmap, CEC_RXDR, &val);
-		cec->rx_msg.msg[cec->rx_msg.len++] = val & 0xFF;
+		if (cec->rx_msg.len < CEC_MAX_MSG_SIZE)
+			cec->rx_msg.msg[cec->rx_msg.len++] = val & 0xFF;
 	}
 
 	if (cec->irq_status & RXEND) {

base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
-- 
2.43.0

