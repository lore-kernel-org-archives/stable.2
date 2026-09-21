Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA14E77FB
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015145; cv=none; b=VsOOL2DHfxBPwiiEb0Cq5LPeT+s6fpSt89ES7XUcfjDdrNw7FOvSzyYFGbtlRp8hIMChRRfPLPfgobTBLr6mdf02LX1F4EWMotB3SEqt8oLLNpq8VJ/zRsrENRXKQB8rM0RWH771Loe4i0S79aS3uOvNpakUdQvV4iUmQ5iSv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015145; c=relaxed/simple;
	bh=/8Wrq+rYYeuzHylPud9tnFtGR3R2iGFzmcbe02TkznE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbjobiZJxQqdbf9QCLOV665oNlE3tKy6AZmAWkkQuT/oEA9ZDGT3xV9H58llXgg6dkAHTXfHHBEz/9k0ENNh5uHpxPfqWheMizK3TLDjH+bSlEHRkmSusGUFDqFUM/kYHmaRTjMEvICRB/G3nlrMUcr7eXR/YnlBkQYaaJ/1ttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=cChmHgOg; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="cChmHgOg"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e211a3so2916285b3a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790015142; x=1790619942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cquRnCIn6mlXF5rqmfxuhHyvgmYvV6WRP7O37Nb5MQ=;
        b=cChmHgOgrOV/Z98IinDbJFq2nN5Xt4u3o/pO5D2dcfcThwF/qIv6z92qX1wwzv6UxE
         aTL/g4iXapKaiT6PDwVhJpRnQYTWs3SlafuR78kMsLVLgiCoMtQTjTlVSrqktgx7bD3Y
         RrzRj3TauzlXHBy10eDYsS1hZYEDUHTpIvdGAQhI5UzqfXn4Lop5NzQM0hLh3E7AjFaD
         3Giot/qs4OyFOeoY+/Z5ZAzHJX4+gOYoNgOPk53J+CXNem1JkcePOuC8CWATMQNoJme7
         RIWjK9gIpCdbilXy4ppTEjKB/RqWFA/kmG8BSYdWzRRBQIgquxogpq9yw1rg9x19HwGm
         m06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015142; x=1790619942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cquRnCIn6mlXF5rqmfxuhHyvgmYvV6WRP7O37Nb5MQ=;
        b=scaZIscPV8PvdzxlNQxwPEYSY1B3GOjDyjQ3y+T7Yx+Mb+N5nPhD2IGBe2MyFzqktK
         BXK57o33W+L2lM641mlrn43503faQjSSuBkeeykuRDpmJNsIMxQaIYRF8gdFSGnT63i+
         rh/jxHcHvXXz2IC+MRTR+L1Y57tzBBd+SbVsRagFEPAIAri8exvGHuqmjHgJvVQwHrWI
         XeV6FFtAytDnClokgrVSmOzmtoQXPVnbkcY56vV3ee4plCXPDEdse9kmq+Tez5rxx47I
         b73cgD0KT4O2SLF5VeUcnTiyrLgpf+1oL86Oi6HmSzvRFZmg8UfStmD6uV6iYbml8p7v
         cHdg==
X-Forwarded-Encrypted: i=1; AKwUvBzujKUOHwk9Pc5wp9BTUl8qdBw3LRVMyyX2d1k3ED8Qn+sCLfdejX9yfGRwIFHmRuva+zY99DQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kd+h1q9LHLsZG0cMy8/5lkxu3S1bzwPM/28hWrTIAwacb4oXXh
	wmlI7l+BUpnOwjeWBNlVf/CPRqzPjZ1Lgo82El7A9XmEiN5X0dBjoGegtEiuiVJd2NI=
X-Gm-Gg: AYBFou2u+QraxT7ODGVkOUFpyeNdUHGft5T/tQt2dEinQ989fye7Da2eEsD363ZhDEb
	ItynNDAWnwEjwcCYtekhQRHgChAR5MzNtBrMk5RhrIbLwBVlk7BnbU05qZOJZORe12aMweIyiRy
	A7z7HLHnlOdTvFvP8ksmHgMKWsWQEEIn9Bjv7rtkioQOg80ce0qdc5hGlxFoVpaqBwoBz2GITnV
	5iyQHUtQkRYs4VnVZtpRPJof9D3rUPtzZYooz35GaKv/k0xgwMBueMtLLbN2/sFJHExMtIbY6Ie
	sirKPw7kG0KIDK9syE7MoMvIZhe9td9BUtI76rEC1MnNTpMo6fmYlvrzZuD+yuduCzLrmYS6arL
	2bYeNBBwAx7u7vh4jUnC/wURDaPWcBxxQ8i7FMkLTHfvmsOGEZy4JoIQbUHeydaFJrNIiDu1TyE
	hFNuK/Z2w9x1uCMAiHNGho92tydut0VN5CE5kJBeX+qOv6ULaPRq2sh7rEBu77URhsbUl/Ifunv
	w==
X-Received: by 2002:a05:6a21:78b:b0:3dd:a006:ed90 with SMTP id adf61e73a8af0-3dda006ee59mr12176552637.38.1790015141934;
        Mon, 21 Sep 2026 11:25:41 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm12408974c88.6.2026.09.21.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:25:41 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 21 Sep 2026 11:25:37 -0700
Subject: [PATCH v5 2/3] i2c: xiic: defer RX_FULL until all trailing bytes
 are in FIFO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-i2c-xiic-v5-2-2fca81e810ea@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790015138; l=2996;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=/8Wrq+rYYeuzHylPud9tnFtGR3R2iGFzmcbe02TkznE=;
 b=ubMp+70iyM/WFu2SL6u7ETfFM1C/uksEYesAWisxSq70C57ilk420Kkkx3zFsOacHFpd326ZC
 M+PBTrV7qDXBMzYY1xS+Z5RGXOLlN/FxyN7fsWzYAs0IouoYUBerFqo
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
index 22367a069ded..15fd17b703bc 100644
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

