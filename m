Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4093397E8A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214347; cv=none; b=IhBVk8CIXHxPHkYxaB/eGQirYMsRkGZ8t9jjKK4NUXuIz0LMjnBKazqoNivOMuh63WdPjJei6/hmQ8ZUvO/GMkWV3RonbN05V9ngYBmgsxcb/O0EjR1tE8Rq99jT36gv0jhNPKRqa3tIfsrkJOS6XsAKcEy7j9v/ghH2MIDoie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214347; c=relaxed/simple;
	bh=Bg5NkWAAvHyt3A3yj80XS79ACYShmuxSKGVO43oYPz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMB5fM9mzmdfQaavTFKSrA9ozbyYVl3ijHUKGa2xL2uOlq6vUZ/e5s+m2jJ3cNQUUvixgyO0TMLvHsYPMN3Cf24m0OCxyKtTj7TBcUv0HutYAzNwejGlSl7rC1gYu5v7CqFIJ9o5wc8LtT0ZA5EARgjzE2jcXRAkYN/T2D0wCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kHCm+ey9; arc=none smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="kHCm+ey9"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso1085086c88.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790214345; x=1790819145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ieebBEdwgRwM6KekZkohbUAIizHwSaKZe32zZn7go7M=;
        b=kHCm+ey9tiS053NLeXnGp46mTEX4CTJb9QuEhkXxKw6I8JBkGNgHfv0tsLDP/6BQFU
         M3dcpbflKjO2Om2Hv14M/ar3boanePYHXyMEyrdt+N8a0zt3Kt9qSwjH63/QxqjBD8mA
         xrBmHe7l09etko7gSr68m9uWVeMPYcWhmbM93tcpXnI4L3lC3lRn8dufad6xR60HIfjW
         RVQfPdMgWXuuXgjMJyddV00trLDo/lTqj4IztxCxVJMCuEwD1hrciEx8Nfz5QFyKfmCp
         Uffk+MlpHZhhBEregW7m1na7vn7jdI3dRuKZzpyJXx6fnP1HEoDf3YXjhzIJEG/BmXDX
         0c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214345; x=1790819145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieebBEdwgRwM6KekZkohbUAIizHwSaKZe32zZn7go7M=;
        b=WGQ7A6YgLplEemK5fW9MFHC/rIJIQJ7JaPvb45NyGDNEGr0+RXYsidv7T/eaWH7AeF
         p/dSbDp1XdeTrRmLzSj+wI9X5fk0lZIsngs1idvGPy2doS6ZR9taatJVtZcclFYnD342
         Ay79fOHySKYrxB3RdPvhg/Gy2a35ekfiAtYi8vcMUnAVmW45KjWESaDPtgfCiAVLxwuC
         VCwnZUV25PUMGKfCOXLIaKhk+L8m/18CnSVAjazyHOjeDLOYoMXowLRIsfM1YYPG1SKT
         Tud7VuwG/Rq0yWJydc90vgyWF9dsh2o79ecc6np7ofCXiwZiOA13E/t7tl3NyfTq04oE
         /EQg==
X-Forwarded-Encrypted: i=1; AKwUvBwKrjNS+zhxnJEHTw6/tLL3NqozjiVyTjDThz7aB4YUA8xy9TSwDV4v/eCg5AW8Zbr44F6jfRM=@vger.kernel.org
X-Gm-Message-State: AFuF++mRNSVBRmeGojrv47q1nwTnJ662y4bNhorIG4tBy3HiULmx2BBg
	NQDsts029AYbbgBCi3w2S/rQOZr4UQSGBQeLFN+fi+a+nw+3hKig+nzt68VpnFxU1S4=
X-Gm-Gg: AYBFou3+Nwo9WBw8LpeZk5bKP/E8CEfjV2Muw+WUegw3teulJi9ewW/hxewGLA/WWMU
	obsUkI73oBaH56XlB22iJRwQhiomdd2Ct5BNXchmJ7YBkKFtojD3fCoxfDDRfiYRbiLmxYac1hW
	f9RVJEtyTleIEzbeMQZrbt2JsDAJi9Q13PjewqPIp4sgBECfoExkb18Mw2axd1PdnuBYuGWzSzx
	gm9qbUnW08iJLxmWYOwwgD/rr8llbtFC9o5RMhL17PBN+N8vW4Fj8LRBKmyNJx/syQOelqm6ka6
	S8+sjJnI7I+JKtiEyH9XiUF7opiml83SwvL2tbF1EMnjo74yJGmPEblRjyoGhmrZlEP2oJ1i3BX
	LDxCizewiPRLYqPgAO8VYbV0rbjffjFB57KBJT0rT/z1bjGM8Pn2cHFqcbkQu7lTMFjujXXJk/4
	4+Lr+HGvM6yiSqJeuHJJeqyuoaaXgMyQlcjs3jIIHqrqdvooRE9HbwElaZ21Zj6dpfImJPpG3of
	ihFjNwk2JTA
X-Received: by 2002:a05:701b:464d:b0:13b:975d:74e0 with SMTP id a92af1059eb24-14503f2ecb5mr605349c88.8.1790214344742;
        Wed, 23 Sep 2026 18:45:44 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14501794269sm2927598c88.8.2026.09.23.18.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:45:44 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 23 Sep 2026 18:45:38 -0700
Subject: [PATCH v6 3/3] i2c: xiic: don't clobber msg->len to signal
 block-read completion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-i2c-xiic-v6-3-3a15b6397f5a@nexthop.ai>
References: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
In-Reply-To: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790214340; l=2009;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=Bg5NkWAAvHyt3A3yj80XS79ACYShmuxSKGVO43oYPz4=;
 b=qFUA265qvuxhLpUmsONKjmI+890eW6TegPL4ejNVHCxg7BhwfRvUx5J2mId0Q73bl+JzaU3da
 kKnVPT0LVT0DtRfa/MazyqQI6uHZayGN/ngRyqxPV6aCXGvGTo4zlf3
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
index b4177d655cce..5d8492ed25f1 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -884,8 +884,11 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
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

