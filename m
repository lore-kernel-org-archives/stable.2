Received: from ag.fintek.com.tw (mail.fintek.com.tw [59.120.186.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A03002D8
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.186.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562103; cv=none; b=vDUl5kA+CaptFswDVcbrZmgKINgym6apkYDb1P5YOXX6kbLWg2ziDw/xmMilREfDUx8OmfddaxixuAMg3aZtGpPVUUqN4xpWEIbKFKbxVEt90GrU1dnmXXKidlIw5CfZ3rTk52YDZGIBmVWFHcgqLER9BL/VqwR1nInN7iaIEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562103; c=relaxed/simple;
	bh=JqdK3P4SbvGogEAI6INI00gm7WSlj6+2xsSn1HZ/6Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7Icec3jLGLi4Nlb50XZflViYeQ80pPDPH41ogf+QYZWUWfsO9mUWwhQ5E2pFakodK+FT4Id/xsJdPyaFBm4FuP+kdDGwE4239/0R719mj8HBNR5H7rEArmKVFmVNwrycEk8LdTSuyt1fKCfsGMeLjdE4uMdAv8+YtfEqj6IPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw; spf=pass smtp.mailfrom=fintek.com.tw; arc=none smtp.client-ip=59.120.186.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintek.com.tw
Authenticated-By: peter_hong
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67O90sKR21557877, This message is accepted by code: ctloc85258
Received: from localhost ([192.168.1.128])
	(authenticated bits=0)
	by ag.fintek.com.tw (8.15.2/3.29/5.94) with ESMTPSA id 67O90sKR21557877
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 24 Aug 2026 17:00:55 +0800
From: "=?UTF-8?B?UFMxMCBQRVRFUiBIT05HIOa0que5vOa+pA==?="<peter_hong@fintek.com.tw>
To: mkl@pengutronix.de, mailhol@kernel.org, gregkh@linuxfoundation.org
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        admin@dynetrex.com, Ji-Ze Hong <peter_hong@fintek.com.tw>,
        stable@vger.kernel.org
Subject: [PATCH] can: usb: f81604: fix struct f81604_int_data size mismatch
Date: Mon, 24 Aug 2026 16:27:58 +0800
Message-Id: <20260824082758.9118-1-peter_hong@fintek.com.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct f81604_int_data defines 9 bytes of interrupt data:
- Byte 0: Status register (sr)
- Byte 1: Interrupt register (isrc)
- Byte 2: Interrupt enable register (ier)
- Byte 3: Arbitration lost capture (alc)
- Byte 4: Error code capture (ecc)
- Byte 5: Error warning limit register (ewlr)
- Byte 6: RX error counter (rxerr)
- Byte 7: TX error counter (txerr)
- Byte 8: Reserved (val)

The hardware sends exactly 9 bytes for the interrupt endpoint.
However, the struct was defined with __aligned(4) attribute which
caused the compiler to pad the struct to 12 bytes.

This causes a problem in f81604_read_int_callback() where the short
URB check compares urb->actual_length against sizeof(*data). When
sizeof(struct f81604_int_data) is 12 but the hardware only sends 9
bytes, the check fails and valid interrupt messages are discarded.

This results in the driver only being able to transmit once because
the TX complete interrupt is never processed.

Fix this by removing the __aligned(4) attribute so the struct size
matches the actual hardware data size of 9 bytes.

Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb messages properly")
Cc: stable@vger.kernel.org
Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
---
 drivers/net/can/usb/f81604.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index f12318268e46..4c147b9d6d69 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -169,7 +169,7 @@ struct f81604_int_data {
 	u8 rxerr;
 	u8 txerr;
 	u8 val;
-} __packed __aligned(4);
+} __packed;
 
 struct f81604_sff {
 	__be16 id;
--
2.43.0
