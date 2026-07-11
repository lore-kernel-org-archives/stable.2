Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C953C141F
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773416; cv=none; b=OC0FiYTz38FjL/CArJR+l8kcHyJNysWGXkf6CpmBfefyU1HdQ2tbKSU3nOPapxqtd0aKWacHzvXxcUDdoO4IzyW9haCtDMu7pAFgMXpLeCxAwaQ/gJajNuDcNGkI5zMnkAmIQCzW2lJD6aLmLnGQ4e2vqLmK6mEFFdo0B/BK+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773416; c=relaxed/simple;
	bh=yuIVmBPzTzrv2Dm30aECT2hNK8SzBGa9AOom3Qlk6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YI138VR/9N47t0iroFQhfQtyPp1Kt8TjMj6iTkVYQmG2ksYQzog3YPv43hND3b1Rp37gFi4Y7ptMFQMuZQqee+XNEZraFIC5U8mkRZGCkO8mdTGMR/IOMbWIA4cR1JaSJGeVZ4mw1Dg5/l1zPuvHr9Viw6Dp4FTzjcLExnRvMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=oD4I3hle; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="oD4I3hle"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1586788f8f.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783773413; x=1784378213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKxklP1jarkRVxjcZK6OwpDBv6NsE5WBXhYoYNX2yBM=;
        b=oD4I3hleSwky7wC8lEMH0NoEXAcjtj/ecd+gaCHQmDFZQ/l2HkgeypDZDIlX5AgGUC
         UrEDyWXqxXe4Z6PNVPoYN/uBfiZe8uWMSRP82yNLZJ6uH7OWc1/sKmDIziM3mkEgaI2E
         OchUdmz2JKAkSGwMa+BIxar+zICyEUvXml9PG1aWHQKzVeT/9vsGZd/YzFxy2TNRNrn8
         SmGURwjDiD86+zb2FRfaC4WCJGq6GYIhq0mI+m3U33rRrfnk8YFthPSpA87xcrLQRtbt
         ZPxF//Q59i3kKhDpFnj9M13sqZ/+8n5TIHxEtxXotnaTsntiYkrFq1964VVoYKjHKzug
         Ptwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783773413; x=1784378213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKxklP1jarkRVxjcZK6OwpDBv6NsE5WBXhYoYNX2yBM=;
        b=EaMJN1SxRqd+AZrgWFx5rAxy6hWzdb/G3QmVepy4yVEn0MJ1RwkZa4MxkoFnqAHbNF
         vbYbWlUdIzYiGqG8OdO/JzEFgBPZ5AsxZ3kkgD3iSzBwdj2CifgxausINyOV9XukxRTx
         ph0qUvaGy/54QHqHtV8+fmIMqYctMybwELl2CkP3j39menm0bjpGfPlxlJgStlpYNnC0
         ZWQqpowOdGgfsJ3muUs1flOCanQ32t0xEir6xtT4Ey7lhxfD1r3YYWhyIrUMksMYbFQB
         4b1HSloab/MWv3r5poHwkqNFFrpRWMDu1b/wZsgx168B5y3Zpn9eEDV8NNYODBHb2s8O
         i//g==
X-Forwarded-Encrypted: i=1; AHgh+RqjdM/iWfTSN9r/qcNEOQwYTaTk3Z+w3HQUkSNcE7gsZH9SNa7w4ptv2Xxx59TjZ/bEMC54kno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIACTJlmhtmOGf8Pzn6F5DQUwKn1RyxgfLpSHa2N5PDOEOzDj
	7PjVlu79188Z/ucjfbwExxqi1hpLdtTVUjfP7pICvKC33bQwiCew5j64Z72nWSCOSKek
X-Gm-Gg: AfdE7cmR8TBBw7lhSIUovBIjV4ZLoh9ZN6/BcDwMQGhoEt4dwQ8pJY75OxXvS5msDKb
	v10OKvQA73SvLR7Gjf3gKk68Q9flLiY06p9udkpF8uVklLPvMloL6pcwW744kASHHwiKVwIPrrX
	wFmaIDjeZe00Il2iKtx+74GhwQ191lm8ztD4CRaj4s87ebxKVszwdm2POAHHoETl8Tvgjl45YVt
	xZ+Vm20NNURBHQ2HJLnNjUjg0o4xsQ+6LTVDiyzyvxTZzM5YO4w/fJbpIfIRt0+csLo059p51g7
	YgFM7dzXb/el6n8nH6RVx6l0x4RStCgnSsZ6PEoNfjx0gCBZ7aBvdHPPUVB6hjiXUen9w8fmNaC
	/RPmhu7YQ5u5R8TtGRRitJJWikcCilCyVZAk5SIwsmtM/i5I8BIfka+M/VPeqn2KeJeMJ0rh/CR
	RbbguwtU1p7bCqDO6gz6IsQ09fGJkBa+OLVHokdUgaZaVUrGh2BsVPPAXdJw44sQf7w+dCTzviL
	hJqhg/WK+JlRtIrNRnA0sMwiFrZy8uyqfs=
X-Received: by 2002:a05:6000:2387:b0:476:7036:f854 with SMTP id ffacd0b85a97d-47f2dce9662mr2553907f8f.21.1783773413232;
        Sat, 11 Jul 2026 05:36:53 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm67690276f8f.13.2026.07.11.05.36.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 05:36:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: port100: reject frames whose declared length exceeds the received data
Date: Sat, 11 Jul 2026 14:36:51 +0200
Message-ID: <20260711123651.32595-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

port100_recv_response() passes the URB transfer buffer to
port100_rx_frame_is_valid(), which checksums le16_to_cpu(frame->datalen)
bytes of frame->data. datalen is a 16-bit field supplied by the device
and is never checked against the number of bytes actually received
(urb->actual_length), so a device reporting a datalen larger than the
received frame makes port100_data_checksum() read out of bounds past the
transfer buffer.

Reject a response whose declared frame size does not fit the received
length before validating it.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bound is evident from source. Compile-tested.

Fixes: 562d4d59b8a1 ("NFC: Sony Port-100 Series driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/nfc/port100.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 5ae61d7ebcfe..30a4e09875d3 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -636,6 +636,13 @@ static void port100_recv_response(struct urb *urb)
 
 	in_frame = dev->in_urb->transfer_buffer;
 
+	if (urb->actual_length < PORT100_FRAME_HEADER_LEN ||
+	    urb->actual_length < port100_rx_frame_size(in_frame)) {
+		nfc_err(&dev->interface->dev, "Received a truncated frame\n");
+		cmd->status = -EIO;
+		goto sched_wq;
+	}
+
 	if (!port100_rx_frame_is_valid(in_frame)) {
 		nfc_err(&dev->interface->dev, "Received an invalid frame\n");
 		cmd->status = -EIO;
-- 
2.43.0

