Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2703C5540;
	Fri,  2 Oct 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790966542; cv=none; b=EGPqTeCZWkqtK0FcyDFbZmV/fvMARAuQvKt4H95u1AP1UjW/hTP3HyB9gngvBj/IryKRjoGetdddIY3usSQxDrQUfEochlrdBLYxw8ZBJNcG1eUpC4AriHbQYzhSb3T8Qv0D04AaCAKlo9xyAkEWChLCWOJYFZn2kvt7mqBFJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790966542; c=relaxed/simple;
	bh=AZXD5q68g4Nu388SyLDgugUmkG2rANtRZl26/TN0L0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZKwAanj/BWEVhctIkDIyQdSfkaTC92EjNdnD6IPoTg1/n09a75oR2zniC7iGXrh0sxsQB/6WCqpTrV3ClaG8ENYQ4gQK8zSUO6geWKakwFoaQhgk8shGi6Sl3VK87E3+lZ7h3erQ1YCa7C5405M8lKwSpud0bG3iYz2Xu6WiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com; spf=none smtp.mailfrom=mail.savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=l0BXd2XV; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="l0BXd2XV"
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D2D513D8182A;
	Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id xtUh8xImHPoI; Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E3B683D81839;
	Fri,  2 Oct 2026 14:35:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E3B683D81839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1790966140; bh=X01K62npLBkyCq2EBhFzAUYUmcK8TbWt+sbSbMh8Lts=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=l0BXd2XVAAK9HpSYKrEND/IRsCUfOKVU61ImlxlpnNfCUqRROY91/trm9hd1OvnDs
	 74JuOy1hJasNyK+GwDSGuyOwWwPeoFF3FP3+7cKGk+iLgrdN8Cks2lhA2/evVXNhY+
	 cxwMjatRrDB/Kyhlxme8dvHokebMUYBVlJiqAmnNXXTZT7LF3GiYFvW/s83Oumfjev
	 oCC3WXFryoucfJO40M/+wvSdHEus8YMc7HOplVbAPOvdoUeHh1geID41LLh909OeQQ
	 OW62uDIA2YHqWZ5ESjGFqKKvl8vZguRoxVWqkT/Hyd2sgIvlBhq354aoSqVE62htnh
	 pJuTMu3WDw8tg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XC2JfRUJZLsj; Fri,  2 Oct 2026 14:35:40 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A5CE23D8174B;
	Fri,  2 Oct 2026 14:35:40 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
	Alistair Francis <alistair@alistair23.me>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
	Felix Boucher <felix.boucher@savoirfairelinux.com>,
	Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH 1/3] Input: cyttsp5 - fix bug when parsing reset sentinel packet
Date: Fri,  2 Oct 2026 14:35:27 -0400
Message-Id: <20261002183529.166248-2-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When parsing a reset sentinel packet (0x0000), read size in
cyttsp5_read() will be zero, and we exit early with success (0), but
without modifying the response buffer.

If this happens when the response buffer has previous data in it, it can
lead to improper interpretation as a new packet.

Fix this by always writing 0x0000 to response buffer in cyttsp5_read(),
and comment the reset sentinel behaviour in cyttsp5_handle_irq().

Fixes: 5b0c03e24a06 ("Input: Add driver for Cypress Generation 5 touchscr=
een")
Cc: stable@vger.kernel.org
Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 drivers/input/touchscreen/cyttsp5.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscr=
een/cyttsp5.c
index e878a02dc9b7..04e141eceb45 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -221,6 +221,12 @@ static int cyttsp5_read(struct cyttsp5 *ts, u8 *buf,=
 u32 max)
 	u32 size;
 	u8 temp[2];
=20
+	/*
+	 * Buffer may contain previous data. Make sure to indicate that
+	 * packet has zero length in case size is 0 or 2, or if we exit early.
+	 */
+	memset(buf, 0, 2);
+
 	/* Read the frame to retrieve the size */
 	error =3D regmap_bulk_read(ts->regmap, HID_INPUT_REG, temp, sizeof(temp=
));
 	if (error)
@@ -705,7 +711,11 @@ static irqreturn_t cyttsp5_handle_irq(int irq, void =
*handle)
=20
 	size =3D get_unaligned_le16(&ts->input_buf[0]);
 	if (size =3D=3D 0) {
-		/* reset */
+		/*
+		 * Interrupt is asserted after bootloader or application is
+		 * started to indicate device is ready for communication
+		 * (reset sentinel packet).
+		 */
 		report_id =3D 0;
 		size =3D 2;
 	} else {
--=20
2.34.1

