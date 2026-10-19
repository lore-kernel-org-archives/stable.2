Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB954229B0
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406335; cv=none; b=s4QSKCtNAuI2xT9+NCU2Bnsclebfl73lOhwJ9dk85RYeoRGv7TgIJMFOXArFB/LRc6QdE18oFFw2KQUKppiJ7a3T9pqpX6uakmxbGMW/plRxzQH20It1Ekj9JMRU4CGUkWUBR7XKN95N2eMShz6SsBdwGHA6VfwkxO+VsftQTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406335; c=relaxed/simple;
	bh=ikwI3IDUOlUtgttfYZI9f3NuQy3lf5WdeZ+dRgaPhjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5kCoPu7Mt1S1XJFYOefAixaR0N6fpDnBvflUTe1biVhz/zUhiDRujpse7zym7smPUIxzjqbwVpzblQMRzHcaOKmevUd9IbDcb5B+xXowaoJmxH9qTh1NphbYkG2vV1lOo22jPO7gtoyQbo3aMVERlZbLdFc8QrBXaT/4Sxh7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F742x7jC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F742x7jC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so17523895e9.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792406332; x=1793011132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CkwPcQmuvefbrhjJjil0GWjjuqe1XsgFQ4iwd7oCs5E=;
        b=F742x7jCX0erRWc3CWyQtw7MlwkbiIf0Va3MuDJ7oCHn95AobxjPQDMMZYXmBoHqaq
         kiFTPSjGlLweyKp2sJm8u2p369i8PZdjO/wm0CXOG3TgmSjhHImH6imh/CbAe2pNXzT/
         UrTrJp3CsjN5lIz35dYNOfgQI7HNBiMZZp/zuVPvu9xmGZTIxPBysaJWZVnnEz23MpxF
         mdQi/0HY2WG1hvyNpcrPqWaosCGetRqitMDkLfmxy+bwxr1w7YoTmPpyyieP/VotHgk1
         h8apiggkMM9IJ0IOAYDw8IZxPoX7cs0DOXOlmwIHJh6lrY5nbeO2GZGT424MgXCPjIRa
         T1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792406332; x=1793011132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CkwPcQmuvefbrhjJjil0GWjjuqe1XsgFQ4iwd7oCs5E=;
        b=fKAUNQp744SjPFWQE4YS36X1mvHczcspw7FaZuIcXwYdaH8QpF8Q/j6GXJP+jWFFu5
         9ZkG0qOe4kh3hTZ7hssxPQpZYveGDkc02a9EnZh6pHDbsQJ710ZXr9/pL5E9A++xZqkM
         Ueb4kLgIxit/qXGIRv9KvuRlpAH6myoWgS2Br1RY8I6snP4WdIOlYXVIGH7PM+NJDS91
         2yqSrdltcmdgxjO/p0HB8FArhCPnm9EcuFmP6xBlUOZOuK6yd/oOIcpcbf1IiuCjMAIf
         9rLEqN9mAgBP4PaJ3J+oAZ5QburKVIEkUmjAjBRi7EXzLq8HDxT1JnGvw8wz261d9ZSd
         8fsw==
X-Forwarded-Encrypted: i=1; AKwUvBwNaXO/a1vx2RMupmJcIQcbykb2NwSEDWjvm7zQ3HbC4NVBdZuILW6t8eG7yeP/OQJcq1UrArw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBLcIfT9O5dGhGDEdvrBD/9tbz8PiNx9hYaBudeSkisErpN25q
	+Q9mmzO0jgS66poGIUcGmC2j90L7VQgyariF76XM8oaB1apP/aS6XX0=
X-Gm-Gg: AYBFou1PyDkLaCFwvT7vSvRRZUBlr17nDU7J0UwaIC1ZPrKv/AWOYxUYWHgcms6Z/OT
	d7eBhFP1OiAM3hk1Ocrp2JEWP1gdieHcp81MCL/J350N4Czr6X29ElRabw/SOaJ1dk0ASR6dh93
	XUn/KGQd1DSC32939JoMiciBedeRNfgtgZY8MTHs6/COx8vCdgbcoelIeCU2fj2uG3X0BywY/A2
	o25CpMEhNkPHfJ5r6Ls4Y/CPyQzlMNIxKGiUKrZyNfo/zxNXN/DuHG+pXnH8BI9lEZ4n7jyr1kP
	OQN6+cd24Qhnbvuy0vLxlS23qihgnXOyl6QHH1sW2VOgObFHTBYKKUc8hWRet7w4XzU8hogZpXZ
	/1cRBCtI1KB/RUe9Q4Nd+B6yDu9lafIUlHDLTioVhxY4V5PPyJXGaxsmJ7f73Jrqv56W4/jW0zZ
	dTmO4uKMAscgH8dKf/6qE3MsuyP6xBILEYHNhdoWDjh25pDlLvAQ==
X-Received: by 2002:a05:600c:3e0a:b0:4a1:ef9d:1b68 with SMTP id 5b1f17b1804b1-4a1ef9d1bcemr10231455e9.10.1792406331727;
        Mon, 19 Oct 2026 03:38:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d30d778bsm255693895e9.9.2026.10.19.03.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:38:50 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Lloyd <linux@sierrawireless.com>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] USB: serial: sierra: validate URB length in instat callback
Date: Mon, 19 Oct 2026 10:38:49 +0000
Message-ID: <20261019103849.3716324-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

sierra_instat_callback() reads request fields and one byte past the
usb_ctrlrequest header without first checking that urb->actual_length
is large enough.  A short USB interrupt transfer could cause an
out-of-bounds read.

Add two length checks matching the pattern already present in the
option driver (option_instat_callback): one for the request header
before accessing bRequestType, and one for the line-state data byte
inside the serial-state notification handler.  Use dev_err() since
failing these checks causes the interrupt URB not to be resubmitted.

Fixes: 033a3fb980b041 ("USB: Sierra Wireless driver update")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2 (Johan Hovold):
 - Split into two checks: one for the header before accessing
   bRequestType, and one for the line-state data byte inside
   the serial-state handler, matching the option driver pattern
 - Use dev_err() instead of dev_dbg() since early return prevents
   further interrupts

 drivers/usb/serial/sierra.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 6e443aacae07d..03ed76dfbb2e3 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -575,10 +575,23 @@ static void sierra_instat_callback(struct urb *urb)
 				__func__);
 			return;
 		}
+		if (urb->actual_length < sizeof(*req_pkt)) {
+			dev_err(&port->dev, "%s: short transfer\n",
+				__func__);
+			return;
+		}
 		if ((req_pkt->bRequestType == 0xA1) &&
 				(req_pkt->bRequest == 0x20)) {
 			int old_dcd_state;
-			unsigned char signals = *((unsigned char *)
+			unsigned char signals;
+
+			if (urb->actual_length < sizeof(*req_pkt) + 1) {
+				dev_err(&port->dev,
+					"%s: short interrupt transfer\n",
+					__func__);
+				return;
+			}
+			signals = *((unsigned char *)
 					urb->transfer_buffer +
 					sizeof(struct usb_ctrlrequest));
 
-- 
2.47.3

