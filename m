Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF64F7999
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015146; cv=none; b=a9uyqenfMJuLIKwOGwiQCdxy7LhLPukJh7lk1iYAnz5YprMqWSp3EHomxOFxg4qzpgXNy75UX6e4Aetjo71ADWy31ypmPDr4WLntKPvYZ9RLwHiV/jU7x/FjDaQjcsdoloM3K+jYJf+T5cYt+bpoQEd1qyWQsB4Y2w1boLpysJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015146; c=relaxed/simple;
	bh=3PrQCnt7nbZH4iGz2QKgl18h5LexXtxJs2Js8bqLN/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvaRytjZpHBL/FAkmu3UehYiLTHf2WP5muGoFZme6wIFkVmrGQusGs3EQU/EAKOk34xPs/wn1oBE+kPBqnUqw5sEbXo1NzhwGpjjcf9omq39Zk4Q/3HSskQ4Zo+GEisAovy2WEM/tFBeOi6tNfvMLsC87VRJSqWuNOmwDfulPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=YeNDycI2; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="YeNDycI2"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a856865so3028884b3a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790015143; x=1790619943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bI4n9nsSaz78+BIYtu5OrBqpRPgWw2YHv3oM1NI7hyQ=;
        b=YeNDycI2+4f6RI3ZJHgpYqE16crQHERefAt/AwaHe/g9vPyw6/FMj47Z+iwFcBSz/j
         43uyyRjnB9kanAlAq6jGclTt0Y+RZmnDvqQK3Br+0eNfXczZcEE1oHqaYHcKEZHWfCPb
         bEoNYRyKDDoq4RxvScubIK3v+btx2NnomvH++7em++rilGP1yLhPEJm9IKyLOH3lFl8e
         FHsLyg8A9BItbuq8+X8Volc2f+oWQUXjIhzZqIyzPEzFN1HgWxg+PLkmJSV5nQZ1CByo
         iWSM1AX/TYvOWf1YPhfqucD3wErYuogSCXV8BMlCKHVDkON3P3O43Noo+/pY3DZNI6dK
         uNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015143; x=1790619943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bI4n9nsSaz78+BIYtu5OrBqpRPgWw2YHv3oM1NI7hyQ=;
        b=TGmCwWwWJS9oVAVCOQhc23P4OZOQcfScqfXmHkjiJQntM1vwnAU6sozd4hDSpXnDQu
         NpUo0EjKkPWnidEMGJ4PgnIbGZAT+YPJjyZ+2SXv5tFLX/tZg7qupAuErMpoFxYhRk+n
         45QBDjt+IY1xSddCE5GJlhYzfB0WRFINvblEh35e8G55RpJ9IUhD3S0aKzJPjU9tWSCk
         Q1YxZGW6MSH2k2xg4kISGGU4PAUQaLpltuWCUzyiIW0i9oA2nX42i4GyJH/B20jyn5Qi
         W7vbJiYnf8z9ZQETD1qbQ+onfVcVtbb7Evvoj2EoaqrtBmnCfXQBg+Je4nkqaUGzcHZ3
         QDaw==
X-Forwarded-Encrypted: i=1; AKwUvBwrLXb5okO4CLsgBGCVQO/QBWpvFbJGkgL+aMBYtDrXHsddpAFOGxq+QDUDkY0dApxc6StG25M=@vger.kernel.org
X-Gm-Message-State: AFuF++kNFin9rEHc0+CehIK8d02I8cAJmn1pgTQjhQ9nD9oP/kb0SbJx
	GaZQ4ge8QStKH9lbAnO1itCOhex0wZ+433z8JTYkz/IZJvC7kSoId8oGkQMENfch4Po=
X-Gm-Gg: AYBFou0xwijVtXftnQAQNZzrL/O5Wc1+qN0Gffu0RezCZ8+ILQsuJY6YEROFOPYQngq
	wl4HNQDX98svCI5dPxIcCwGYyxtXTiuG7CmFgv0VyLpHRM42BYcXjo2gOuyb3YLtBgI+LVrRwVR
	PFwswCgCeXgPctZ6pnApBmd0izlcHB5gJpKrkcJvNTw0ugzTEG66+k0OJl7wdGycr0UOqRmCipH
	K6zTQqKhFQBRdi4kAa8Dq6nmbijx0UH+1Z20FDoBQ25sQ7Cx0t6M0RyNQ0HlI+UFdbJlHMzDdOS
	AV8eR/KE3hvPGFtIRF3VxWHtuVxzWOiHUIm28EaDG7qDuSZ5ajcEx/juxGIgotRvhX2kMu1zU6K
	pVlPQ81a4kmwlgseq7WdNbs+IPiHR3A2Maqy6mtNfdmN5xQFOorHFLneHqNP44CgH60iUeJMDq0
	TFv4qhbtJk1fAg4K12xa84ajvNotQVtD2JfIGZkRG+TRYMGVuEYYmyGees/W4Xqk8L0D3GtpjmE
	3ZC62sqaRtK
X-Received: by 2002:a05:6300:48:b0:3dd:a197:cf1e with SMTP id adf61e73a8af0-3dda197d894mr11470586637.66.1790015143079;
        Mon, 21 Sep 2026 11:25:43 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm12408974c88.6.2026.09.21.11.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:25:42 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 21 Sep 2026 11:25:38 -0700
Subject: [PATCH v5 3/3] i2c: xiic: don't clobber msg->len to signal
 block-read completion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-i2c-xiic-v5-3-2fca81e810ea@nexthop.ai>
References: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
In-Reply-To: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790015138; l=2009;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=3PrQCnt7nbZH4iGz2QKgl18h5LexXtxJs2Js8bqLN/I=;
 b=QpYMk3wrZCPsBPJzi7e5IC/yKs9xc3WDRsvHMvbgmZ/JbIufqHEZJ+oMndO7RLskhkFHF8Dfm
 W10xBDmcpW3AiecVrKdpTJV3FKT6eEkSAmnb6uidqNVds4cIB9Kssiz
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
index 15fd17b703bc..d5e7b089a2b8 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -879,8 +879,11 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
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

