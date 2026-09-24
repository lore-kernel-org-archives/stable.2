Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582139EF33
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214348; cv=none; b=a1gFysx8ZIsZdbleBiw8Kn/q22eM4ZLQAKxwFCpVlVYU4UqMPEjYIrJOUvp36RAV/0LC64KKirlZKZCvoI0qsQqzNJ7D4B9/I+DwLj6bjnQDMS/Yt18wFGIdR/iamqRhTtGeocIQxoRfVsasvsADhb6kN/ev8Z8w8rLSgex17s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214348; c=relaxed/simple;
	bh=hjh/huwNpHT4R0O30TFZo10JCsexhfogEIYuCqGs5hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=plDmEsxWnQtyaAFxOza3BwRuKpumGdGsNL1ulxPXS6JSp8RMicwP+xIenBittjgLF6Y4+23u/mqwqwHgLXsgHPoGdw0srNq1/KBki4+9YN86ZHuh1MTDPwldtXLPyZIsrZ4MqkhaBg49utH347Guuqc+5ADydGoAcwT6kKwcni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=HId9yRDh; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="HId9yRDh"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd05d97cso2289773c88.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790214346; x=1790819146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFtQiwO6/6BJ7wa+vqmBzThl4fhyokGeBbXcNwOcE/A=;
        b=HId9yRDhWQsHx4gMUpLrT/1UClrCdOuNVrVF5fvkScInGoZ2BM3LfXEjcWO4z+H8+m
         thgC0Rf3ETDoiScB/Yejhu7p55LaV36D9+rR5655NSpz5nNFeJ5FP2UZbRQcLFOMNPY1
         wDXVlZPYoPP+VNdARW7AH//D6AqsCooFePelIhvBtz1b3waBIDUFkGhdSL4MQAJqBgtD
         CMU3V//akV/IUqTTZNlq6HV6Vh1zLdrW6q+DnDQ82BCjnZ3L0/dXE8dG+bt830fSMUtT
         zO6e/4elZ3B9gTvjthCHnHae5iNFKtQ7nYcwD02c7p0G8AWRMlDD0/YCtpsNwiXMG+iY
         I6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214346; x=1790819146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFtQiwO6/6BJ7wa+vqmBzThl4fhyokGeBbXcNwOcE/A=;
        b=nva/I0zq/cRkE3CkIMOt4ytPcIXGYLmwfZ8utNTo2XSNzuo26aQLk9wXd9dtA8pjtQ
         VzexT68ofRMxynPGl8tGYcZol8AnL0adanCElTFMJTB88VHCmPfc1rjAIgZPeF06eUSF
         FxwMEvyyXqP07UpZKjYGKC8Enotl6ZgaI+gde828AoFte8cZ0pjkKw23E6dWp7I6dVfg
         Qo2aSipNdZyE8EA/1ftktl0lzOnkGhz2PKm8bX/nqyAV4iWt2mapKYo1YrBlSNtkzKK2
         J2luitUdhKZ1KzzsgOk7p1yZmpvDl2P/b+S/Emn1Hc4I+k2DbENjLXK71gt47D2xXHKK
         D1uQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGbpLQ7Ujcq+OANeiOVO7Aqpk5GVBULTYZgaW4jcRR4UnPdmZ2WDCqHW7VPEdrd+qElomU9gk=@vger.kernel.org
X-Gm-Message-State: AFuF++l+rrkYO699bWdWoh3mFB15db5OUSglD8BDaZvss6llJG5wNqlf
	JT9eaZKRQ/gDVWzMEB20bLM6nD7peUlHgdAk7T9z7zaMbO82wFZJI8oXB3DRKX38pz7+Kx4uIgT
	go4TGnik=
X-Gm-Gg: AYBFou04Yd+QYn4XfFsNKqabbH4Zk4vPcwiUPLiVW9DFnmlO8C8VCUP1bhfX1BACoNR
	nyZ5CX66bi6VKv+m5/Y/+IiDlx4uvxVPANNTJM05w/hVy0AXOVMAf201qKxfp0oNIYAfHSQLeH3
	p5Fzru4f1Alu+Xm6iEBnXNW+H+BYadxWZkgeGu9qLDqqORRfPMtNMGBShiOClHVE9DvfzG65w7Q
	750ArHCX+03zInzJD2Vx4570J2C4soRRwsf0j6XZ/n4KvFKMuLL0Ts0ffLT4kmticsrni2O5wsn
	vgaUc5bks6JDffrCmqeGBJ23WdweQT8AcZDRg6GKV2ack960fGfFDaFTgEvhO0vRJXED3vWDChG
	Gt+y3h3xDklDOcT1Z91dQ2Pj2GoDe4qS+wsdDH9EhWT1sAmttt2Gi/4JwgDvlLlgm0mECcrHtMu
	M/UcaN1bnZ94Kbd88ZpW/WaR3L39sNq5tHhvnYk+xxQGcfBXG+4ZGNFlS5FNVZF5FMkIzeJsEd8
	w==
X-Received: by 2002:a05:701b:4292:20b0:143:89a6:9ea9 with SMTP id a92af1059eb24-14503f9735emr748692c88.19.1790214343219;
        Wed, 23 Sep 2026 18:45:43 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14501794269sm2927598c88.8.2026.09.23.18.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:45:42 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 23 Sep 2026 18:45:37 -0700
Subject: [PATCH v6 2/3] i2c: xiic: defer RX_FULL until all trailing bytes
 are in FIFO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-i2c-xiic-v6-2-3a15b6397f5a@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790214340; l=2996;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=hjh/huwNpHT4R0O30TFZo10JCsexhfogEIYuCqGs5hs=;
 b=ESsvAdfXRm0tlYcUbq3pUgtyTWOnDdmGWS56m6a/HeF5Da0WAGiwNahnaVp2p7ITa0+jdFYf/
 c8mhvMhlJF/Dy6plYKFa+nUrdBkJh84xQiUAqmZ5J7Qt0jGOh/jwkQx
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

For the normal path of xiic_smbus_block_read_setup() (rxmsg_len less
than IIC_RX_FIFO_DEPTH), RFD was programmed to rxmsg_len - 2, which
fires the RX_FULL interrupt while the last payload byte is still in
flight. xiic_read_rx()'s bytes_rem == 1 branch then sets NACK on that
byte still on the wire, truncating the read in the PEC-enabled case.

Raise the threshold so RX_FULL fires only once every remaining byte
(payload plus optional PEC) is already buffered in the FIFO. That
routes the drain through xiic_read_rx()'s bytes_rem == 0 path, which
reads everything out and emits the stop cleanly. For the non-PEC path
the full payload is still read out through the same bytes_rem == 0
branch; the only user-visible change is that the controller waits one
extra byte-time before servicing the interrupt.

The deferred-fire formula is rxmsg_len + pec_len - 1, and the RFD
register at XIIC_RFD_REG_OFFSET is a 4-bit field. Widen the
chunk-vs-defer guard to (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) so
the boundary case rxmsg_len == IIC_RX_FIFO_DEPTH with PEC enabled
cannot write 16 into that 4-bit register; it routes through the
chunked drain instead, which already caps RFD at IIC_RX_FIFO_DEPTH - 1.

Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")
Cc: stable@vger.kernel.org
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 6cb264cbc366..b4177d655cce 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -546,10 +546,11 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 		unsigned int pec_len = i2c->rx_msg->len - 1;
 
 		/* Set Receive fifo depth */
-		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
+		if (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) {
 			/*
-			 * When Rx msg len greater than or equal to Rx fifo capacity
-			 * Receive fifo depth should set to Rx fifo capacity minus 1
+			 * Trailing payload (data + optional PEC) exceeds Rx FIFO
+			 * capacity; drain in chunks. Fire RX_FULL when the FIFO is
+			 * full and let the ISR re-arm for the remainder.
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
@@ -566,11 +567,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
-			/*
-			 * When Rx msg len less than Rx fifo capacity
-			 * Receive fifo depth should set to Rx msg len minus 2
-			 */
-			rfd_set = rxmsg_len - 2;
+			/* Defer RX_FULL until all trailing bytes are in FIFO. */
+			rfd_set = rxmsg_len + pec_len - 1;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

-- 
2.54.0

