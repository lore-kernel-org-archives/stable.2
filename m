Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771631DDA18
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295045; cv=none; b=hWoK3tYwWchMTT2byOsfhUNpAyjYL3XCRwiCJLrNfuMa4Y4dYi3W6B2+ZG2kS2aXm37kcxxMqq/QtWKBpjF7/+s+xFs2I0mBcNNE037sA/bQwl/fI4QEk9HD64JkWEO1tTnyUkYwPJBNZkuzDY/lvsC27d2FDiNxGnsf+ZJM51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295045; c=relaxed/simple;
	bh=1rvaVBS5z3PcQvipdDAj9WVWm6JugqJIhc+zC3OYV1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgMnjW/2F4EUQA+12lTozE/Z1pYo1ksNToBntiso/NE/ivteSlOcSgVR+HYvDI/wRzqb0DsXMoo0qsfic6uvID7CzzPK1Of7eZCqTz6qZ8dV1LgO0zw0O1AytYQ3Rvfq/vktNh1dUdPN6CCtqv81IKCNDzVJTGYhfuSO/C9byFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=NQfYWH/+; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="NQfYWH/+"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3410209aa6aso237255eec.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790295042; x=1790899842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uoMaAm02Pyqn85C4te1/bOInshnG9mfbEU4HCghL9sk=;
        b=NQfYWH/+gQaM85kq/LM9ZR2/ghD3sDdHgntPdSkoSmTQca6MIPAMl69Ry5W+FfuDjs
         3aHXO9A++nzoHXlyuHuawxEiWqkt1LaUnG6C3bQxOfapiYckxMfBeND8t1gdKEv+19lY
         GbxHfjZPlBEBgdS0fsqyMGHYNiGLAILxQYcZ37dL+/vCOJcDwKvhiQ6/YwSEKt8aTe5x
         vBnl+P2+Xt8THfQIJnbPgNhA/MDLVWUVwtqDayGgfBGoRVSkUl2hL495PkuI9xUR2pH5
         7abkarwjK+wcGFCLzQUy9iWnlzDSmp78rGp2s/LTttvRfvky9AvBnaa7Te49KM6bJJBI
         mLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790295042; x=1790899842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uoMaAm02Pyqn85C4te1/bOInshnG9mfbEU4HCghL9sk=;
        b=ET9Fec4e4KxT38x/qZvVvg8cBKuRhtEDqWGhbD+02GwWXnHXM3ed4W8zaeDZqO7kf/
         wgM4X+kfCWQxqJD9zpvZh4QJpEkUM67eNvFTVnDZximsLjTYKrrBd35BvEUMmZjUiZZR
         bEZbv63nsZbWpuyhRCgXSkzoSFW+lVkmvbS4DV+fZ5uBfLf38/zKMMGgMAnGA2vkG3d6
         UR8rojVin0Qtbsiu4FLMf4KaBG5zNsFDZ4rwIgS7UsVm2/8+u5e/s5F3HPAebY82VhKP
         log3DjVaDV5RjTrMrMmbiValNxG5Va2GtE+mXuSZ4TLb/OT6SHg/s/woi3UXMC+1O1wk
         +6uQ==
X-Forwarded-Encrypted: i=1; AKwUvByRLrqj9RCEUPWWTzUANOdRcdqh9NMqhh5OLRY1vS9r0ycLwB3a6Z2kHd8ABk4HjFR30sLeppM=@vger.kernel.org
X-Gm-Message-State: AFuF++kJC5PrH/13h4DwbOswpuaWKqV5xNurESe0/EqMmeYLpFlKMjrb
	frG1R2tSFyXHZBkBiNByQywYu/aYGhlL9Ay4PwWO/qKVdik++T8f11JVgd2gaAhx01c=
X-Gm-Gg: AYBFou1wLAGJEkFrGLwe1z/xQdPEC+ItQWUX/s+4jYO/ZZ9Z4/lux6uETfDss4u4BVA
	UbwIZYGhnl+J3tM+QxPMV0a8/In1CL6RW97gPMvLJW6FCDa+SDVADmeLWcg2eI1o4PetCNjbUQH
	YkNqHMMwFSTx+dIZFFbLPWNymlVuFvGsIzkzF6zBy3uLogCsPyb936Iq3onLwhdNW/KR/thOiXI
	ZQlLstAE4+2UQ9MFsrxmvIz2uKXDfZnyU7HVffRkkCT/HrCI/U6zqGCsiqZ9820hCSvOXcqbgKm
	GOhQtp9dpIUc8eutGSFV+TI3KjshcEPMxHRUhsJEiOQBbHiHZSuHNn7SrbU0qiKUaNBle0UK82v
	8JmUH1wvjN9HGnA/xvu8dLyFDDJZ8uykeKlHSRhhA2bq2hTeKeylmccIzDnsTRei2MpqEHzho2w
	nMbmrVxJ7Om7E8ssLlKy85Q933iO8vIqV9iopPhCGDagkn4wnP1zDkdGn+I/cl4rKM73OPXRrh0
	w==
X-Received: by 2002:a05:701b:4254:20b0:136:4bbe:9524 with SMTP id a92af1059eb24-1450403dc38mr3141393c88.10.1790295042387;
        Thu, 24 Sep 2026 17:10:42 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145632298sm1787647eec.22.2026.09.24.17.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:10:41 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 24 Sep 2026 17:10:37 -0700
Subject: [PATCH v7 3/3] i2c: xiic: don't clobber msg->len to signal
 block-read completion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-i2c-xiic-v7-3-df7e752332ef@nexthop.ai>
References: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>
In-Reply-To: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790295038; l=2009;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=1rvaVBS5z3PcQvipdDAj9WVWm6JugqJIhc+zC3OYV1M=;
 b=CeyCZ+j6PyXwi2IxNzqHNhjgrX9Og3sz3PrfkkWqKWWMlqelDQm1WAl8kwmODXCZf5TYFasH7
 auvAVv5l3aKDqLqlLiHm/m/SAC2AwA1Kj6Zst3jMHnPM3mIuPqGGkse
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

At the end of a SMBus block read the BNB handler force-set
tx_msg->len = 1 to push xiic_tx_space() to zero so the STATE_DONE
branch would fire. Two problems:

1. tx_msg and rx_msg alias the same i2c_msg struct during a receive
   (see xiic_start_recv), so overwriting tx_msg->len also changes
   rx_msg->len. The i2c core's i2c_smbus_check_pec() then reads the
   PEC from the wrong offset -- buf[0] instead of buf[rxmsg_len + 1]
   -- and either mis-validates or returns -EBADMSG.

2. xiic_start_recv sets tx_pos = msg->len (typically 2 when PEC is
   enabled). xiic_tx_space() is unsigned msg->len - tx_pos, so
   setting msg->len = 1 with tx_pos = 2 underflows to 0xFFFFFFFF and
   xiic_tx_space() never compares equal to 0 -- the STATE_DONE check
   falls through to STATE_ERROR, giving -EIO.

Instead, advance tx_pos up to msg->len. That drives tx_space to 0
without touching msg->len, preserving the buffer length that
xiic_smbus_block_read_setup() already grew to cover the length byte,
the payload and the optional PEC byte.

Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")
Cc: stable@vger.kernel.org
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 5cd737c7608f..5e397a7e63f6 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -889,8 +889,11 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		if (i2c->tx_msg && i2c->smbus_block_read) {
 			i2c->smbus_block_read = false;
-			/* Set requested message len=1 to indicate STATE_DONE */
-			i2c->tx_msg->len = 1;
+			/*
+			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
+			 * without truncating the rx_msg length.
+			 */
+			i2c->tx_pos = i2c->tx_msg->len;
 		}
 
 		if (!i2c->tx_msg)

-- 
2.54.0

