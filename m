Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE03644A4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103628; cv=none; b=R1WTwC34bE88GeqBKwEuEyEBFY3OabOJlzU427xSgFW/6n4I0jAsiRkRPUBTlga47pBuoD4pcaMUymAq0wnmks49B9G03QJqjDVjfUk525mVn5fyBU+aWRKWjET/8TXVNpZPzuy5b/7ZYSKz/kLdEmCggHdj5T18rHSUI2/7h58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103628; c=relaxed/simple;
	bh=bvwwW4R0N6grdlPYNqdz9MLWc+DG/FhVQKqmEhPbqUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/eguq9pOWCoqYsu8ynzTZvjBGSLH0g9K3PUcEn8UXByN1HZZlG0z78AqMp5Wcf4PvBYuqhNOFWWS6hhaQg95stFVXjnsQwQdUkWEN8m4FTIWFICmXHIinNI/vJPYpEcEowG1U/bJy25p4fq61tyFo9EskT2o1M2atjydLI0uko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=cl9vi/Cl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="cl9vi/Cl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47362928f65so4695170f8f.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784103625; x=1784708425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JeyNa5yOVyOyuTQrDgjtAmBz1VuJ3FD4iF0lMD/jV2Q=;
        b=cl9vi/ClfyCuMOKE3Jw6Kvyq29f+9yHOd8WOdO2r75f8OFRWrnZFMP5ESYzh21edb9
         R8pYEPa+2r9ZbLnsCTKhVzXM6ljL3l9JQZ1H3Gi7LlbsxN9588RHyARxb6uQmhmcV1gr
         KHeVwIbggH2+R4dj6DH+47GDKb4yjqAicmTWXus16ShTospouJpshqkoychLuRgwvY/h
         6pMv59sC92f6QCAnt0XekJSorrGX78FSjo2LOOD4/54ZxIaHIcSjYvcMZPJSi1scik1K
         Ef+loQkAcdk3h2gy6m8I7fC0fvqQwgEdurPOZLszE1E7OasSXiUS1qE+d/F8beIy22FK
         0VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784103625; x=1784708425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JeyNa5yOVyOyuTQrDgjtAmBz1VuJ3FD4iF0lMD/jV2Q=;
        b=Q9KZMQDNLx4R/2y6BfuRJcg3GleoeGXrF+D4t57OPhhpoz7C5TMMpP2tJ4wTu0nJKu
         m9k02bvljWtglYGQUb7BxNzjnxYNJwPgAmIo8tTfln2C0jJhTRPgdBeprR3NxzHLjR20
         /BPBhzTgEnOV7NCtfYorDPVM8MyFGwbUdNFG4io30pEUBKd36q+UrWxV1WWqmyn0yT/5
         o+3WduwjTxRyc1+ilzTJuTypCO1BWRMtaDrZKdikluTeACTWWSRUfjYnXKiRQ2mcmq//
         xrbylt1WT57J1AUGpM7FbIpGVx+neZvjfGSxZhEaS957Iela4EEdMjHuIfjasxBgMBNb
         raww==
X-Forwarded-Encrypted: i=1; AHgh+Rr5597g2rGjy/SVe99HkWbJKl5ks3rLXL6BHIrjeKg5M+KG0CejzuT2efCON5zbgzWlqWALBMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEaQM1sTx2LV71DbHWVwEJtUgYhCkmCN0rU2JcoeKez2KDxN/P
	Rj+bEK577QD1aq+vvlwsunk7f/WGpRICYV+JaTtvTh6B8H2mPFOfceRSKgPf70AzvECUBXnXrTG
	MHYbIdKjh
X-Gm-Gg: AfdE7clL84E5fT1/iw7c0atVOFP3qlpjyUBPMtI+qIvGBQ7Z+v7esQp7V8DjzALfL9O
	KjNHz5Kj0iT8BBI5Km7NrDfdCHDu6swYRjq2vHSi0bEo1MTmLtFjvLJGcNxaDPZHrC77Wpli/aw
	EezS4mBsm30WlyfDkXuF0ArsxLGgOHVN3upphU+Y+mi63qtUXijWLmWJEtEjyEwoXpec5P8Whpw
	2DtvC2Y73gvDDRzhWWl8OTzF0NwK4lEHsMTeWkapfzI5NNM91LT62Ou3PmgcfE0kqIGVz8CzN8T
	vQce5T+032EYoylH3JLs+KzdBZvsEDBCOgRE/6Ql8kvsQwyLJu5Tp2b3jqXk7EkLMIfKt5aOtvG
	CIXNaLGHRS5oNOGAR1BUwiSRjWcIYG2zsXt8JrPCmkdmRXI8n3gcjsqoAV+mKfVrgCBjEXFTasX
	K7YuhHvvuRxyzGGPmok3Bjxah5w8Vb53l3oO8tJn8mv6LYJ1HPHnOmMDjzGt4quQ+8Dk6NGF0Fe
	3VWD9N2CSTmEqmMlrrR19l3DKT1QDVvGqA=
X-Received: by 2002:a05:6000:4201:b0:478:65a8:6305 with SMTP id ffacd0b85a97d-47f488a9beemr6540145f8f.49.1784103624560;
        Wed, 15 Jul 2026 01:20:24 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a974csm16390049f8f.18.2026.07.15.01.20.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 01:20:24 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] mctp: serial: handle zero-length frames to prevent rx buffer overflow
Date: Wed, 15 Jul 2026 10:20:21 +0200
Message-ID: <20260715082021.46315-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCTP serial receive state machine reads a frame length byte in
mctp_serial_push_header() case 2 and validates it upper-bound-only:

	if (c > MCTP_SERIAL_FRAME_MTU) {
		dev->rxstate = STATE_ERR;
	} else {
		dev->rxlen = c;
		dev->rxpos = 0;
		dev->rxstate = STATE_DATA;
		...
	}

A length of zero passes this check, so rxlen is set to 0 and the state
machine advances to STATE_DATA. In mctp_serial_push() STATE_DATA, the
incoming byte is stored and rxpos incremented before the terminator is
tested:

	dev->rxbuf[dev->rxpos] = c;
	dev->rxpos++;
	dev->rxstate = STATE_DATA;
	if (dev->rxpos == dev->rxlen) {
		dev->rxpos = 0;
		dev->rxstate = STATE_TRAILER;
	}

With rxlen == 0 the "rxpos == rxlen" terminator can never fire (rxpos is
already 1 on the first data byte), so subsequent bytes are written past
the end of the fixed 74-byte rxbuf, which is the last member of the
netdev private area. Every following data byte is an attacker-controlled
1-byte out-of-bounds heap write, and the overflow continues until a
frame (0x7e) or escape byte resets the parser -- effectively unbounded.

Reaching this requires CAP_NET_ADMIN to attach the N_MCTP line
discipline and bring the resulting mctpserialN netdev up, after which
the bytes arrive via the tty receive path.

Route a zero-length frame straight to STATE_TRAILER instead of
STATE_DATA. The trailer/framing bytes are still consumed, and the frame
resolves to a zero-length skb that the MCTP core rejects; the parser
never enters STATE_DATA with rxlen == 0, so the out-of-bounds write can
no longer occur.

KASAN, on a frame of 0x7e 0x01 0x00 followed by data bytes (before this
change):

  UBSAN: array-index-out-of-bounds in drivers/net/mctp/mctp-serial.c:370
  index 74 is out of range for type 'u8 [74]'
  BUG: KASAN: slab-out-of-bounds in mctp_serial_tty_receive_buf
  Write of size 1 at addr ... by task kworker/u16:0
   mctp_serial_tty_receive_buf
   tty_ldisc_receive_buf
   flush_to_ldisc
  Allocated by task 152:
   alloc_netdev_mqs
   mctp_serial_open

v2: route zero-length frames to STATE_TRAILER instead of STATE_ERR so
    the trailer/framing bytes are still consumed (Jeremy Kerr).

Found by 0sec automated security-research tooling (https://0sec.ai).
Fixes: a0c2ccd9b5ad ("mctp: Add MCTP-over-serial transport binding")
Cc: stable@vger.kernel.org
Suggested-by: Jeremy Kerr <jk@codeconstruct.com.au>
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/mctp/mctp-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 26c9a33fd636..a5070ffa9a95 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -318,7 +318,7 @@ static void mctp_serial_push_header(struct mctp_serial *dev, u8 c)
 		} else {
 			dev->rxlen = c;
 			dev->rxpos = 0;
-			dev->rxstate = STATE_DATA;
+			dev->rxstate = c > 0 ? STATE_DATA : STATE_TRAILER;
 			dev->rxfcs = crc_ccitt_byte(dev->rxfcs, c);
 		}
 		break;
-- 
2.43.0

