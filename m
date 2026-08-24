Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3911E5B68;
	Mon, 24 Aug 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577514; cv=none; b=kC0Zfsk86r+RZKPUdQ6+WtaBR8PV/HWWc6Ighc9hOaJYaWUJz1YF9pC480WylpKh3wpYlxdDdqnx42sQytvLMF07G4jYRABecAZ4Cc4b/GKu7jDJ2ddbSwja2LE9E5uP4RUpg8RjR7w1qZCg/riNeHoeVhGgnFXFqMEeRIwhHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577514; c=relaxed/simple;
	bh=+DYPpsduTMNFOxwuHRXJbv+k3E8Ew/WFprCmPFWBchg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GPxNwG4JXECZcwAabM/0CPfr7aQCRxzXOfmzlxb6RzGJokbGworBrnnePVesRD1O0ETb0MqDQA2BNd6+9tE0YxecPzuyQ9bq8oCoONSZssDxOkSYx+dZRj3eqjD6VODkK1MAXiPK5EuBa2s/UacDaC2O5PAmnaVlaXcp/y0wq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBd2jWks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBd2jWks"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCBE2C19425;
	Mon, 24 Aug 2026 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787577513;
	bh=+DYPpsduTMNFOxwuHRXJbv+k3E8Ew/WFprCmPFWBchg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pBd2jWksn7u1+YH//wmvHyV/2KSsAbQ5QAyV9/9qqU+Lnsj7JcwYepfot3kUJ28ol
	 BKypwif+xA/AC4reuhA1uIcXKWY2gii1xua1jVr7L9/XhEStVxPeXQkpKh4XET0xZo
	 zJzhanzeYS4qbtdh+nugEZU9Tu0+4+IxPZw2RmxRwUirfienToh8mYk9F5MtAHUDMy
	 gZ+9ZUdSz1UB4el5hwLdu+KiIXTGib5NPiWKuyBParrKZBBvRBPCE2J3pPKxZXXYJv
	 UDiwuyBiLQbe9VyMa/wQqAk1QN1Pii1Epf7EOFyhF+gRo+9tMbzK5WamqsBMpp8HH9
	 VKwK3U3qh4Qew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B2AC5DF9C;
	Mon, 24 Aug 2026 13:18:33 +0000 (UTC)
From: Ji-Ze Hong via B4 Relay <devnull+peter_hong.fintek.com.tw@kernel.org>
Date: Mon, 24 Aug 2026 21:18:14 +0800
Subject: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>
X-B4-Tracking: v=1; b=H4sIAJVEjGoC/1WMyw7CIBBFf6WZtRAgFdFV/8MYQ+lQ0BQawEfS9
 N+lunIxuTk3d84CGZPHDKdmgYRPn30MFcSuAeN0GJH4oTIIJiRToiVWcclq+DfRGvuB21Ygk1A
 f5oS1/srOlx/nR39DUzbDtrApTqS4hPpPWu+wV/TIuSKczFgwXV0MY2d9KHinJk60vGBdP7+so
 p6vAAAA
X-Change-ID: 20260824-f81604-fix-aaebd1f42e06
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Dynetrex, Admin" <admin@dynetrex.com>, 
 "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787577513; l=2109;
 i=peter_hong@fintek.com.tw; s=20260824; h=from:subject:message-id;
 bh=A/8jIUxJ46OgWF9VTd5CR2kRPJceYM0zgcKPipnmPJA=;
 b=fxLV2EfZZNHmnn2yfRfy1y5DN9RKGDTeDpiVKwJPxa7kBT1XFJQVpvn+wJuBa8uHhrz+2ccA4
 CpHVrwUXFjCAGXKNN/DXFoxh4QHcWwL+A/8loZYtj+sdK6a43IKvbdD
X-Developer-Key: i=peter_hong@fintek.com.tw; a=ed25519;
 pk=8sYixQfVOzNMM+g53fxG9d3MHOFC02ZggNS0OhG5LMA=
X-Endpoint-Received: by B4 Relay for peter_hong@fintek.com.tw/20260824 with
 auth_id=973
X-Original-From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Reply-To: peter_hong@fintek.com.tw

From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>

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

Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb messages properly")
Cc: stable@vger.kernel.org
Reported-by: Dynetrex, Admin <admin@dynetrex.com>
Closes: https://lore.kernel.org/all/A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.com/
Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
---
v2:
- Added Reported-by and Remove mismatched Fixes tags
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

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260824-f81604-fix-aaebd1f42e06

Best regards,
--  
Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>


