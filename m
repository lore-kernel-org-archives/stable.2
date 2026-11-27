Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799287;
	b=r3ffo+wF+h3XCKoZcrCyf7SMveC1YYMZl5HwFfNCoapYguxpGaefg6v1aLPvpLb2bPpp
	 ynq0SIrsoYTIPQtUD9g//TslmUhaFd0k5sxaR43RUHlBSzUVVWfDFrG05uKjYY6ViQxyc
	 F4jZCXgowtEwZ1OC+uEPa3TPxr86rHt7r8wYsns3+D+nXiIXhNIXhJSm9pOVPOYefmVOB
	 btrNn85oEOiMkGX2sGK9hOt8Jx6fpRv8jEUnGfmDeKUv04DroPksGpGCuX8EW2PZiXpNB
	 SidFcFpyq3W/gxKZXhVctqnefQfCLIXGHU1ABnXfyZVS6gNdqPgckuMXkLH89SVlZYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1o3dKC1ZiIA6DYeQV6iPkESo7g9RbTvvHtdK7xyzfEY=;
	b=1FU7CwTZsZ7fmP+t7Ks4aUfPCFZEuvlWz460rC/WSh4PvwGsf9uotMtXl2Vv2zb8ZSe1
	 O8494jT2f0aTRCa1ufFB8IN2+exVZgkffgBA82SFdZ/VSg8IUuTDCldS2QaqJsJuusdHi
	 /InkaP+bxXkxfV2PnxY6hFuBUxgbpnqJEmlqgFSpMTJDij1w92lsJ6kt28t3123U4Fgr4
	 T10G7fDzVGnAmJ4K5fK6/wgcDzgZ805UupehMCtciWcAp2OxENo5B/6cPMZ4ryOQ5ecIw
	 RhMRcrK0aam4GJg908wWLxVniSchtuROaKgPrgXacdwN3opOQZEN2bmmCpQBobDYryA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMTKoOd7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C8606A323;
	Fri, 27 Nov 2026 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMTKoOd7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450421F0089A;
	Fri, 27 Nov 2026 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799286;
	bh=1o3dKC1ZiIA6DYeQV6iPkESo7g9RbTvvHtdK7xyzfEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DMTKoOd70m9njn22QTAGUBUjhV1JtoFG+C85tGKSyYTXmFMdI7j/kdkojuc/OsZdT
	 +l4D8EjifUUwG3JbdmJ2+LV/eFezcoZ87vJxsxrSZ96OhVOm2q4hx8yCJDt2ZRq1Zf
	 Mp/NXscGkL87P59DWKI6vHCLXC+W07v98FBncUGL0Nd+1bHoPYVtdAMe0jmfc9NRNv
	 gLqGEeePlj96A1ecjInMB/zd9jYXmTN3hsA1pOQidv/R9zdXIGGEJ4D0bUuWMnG0F3
	 QiI3ewyWX8vrm5iH7JZiwWVc7KC1VuYtKdorKTMeX/eBdM19N9kBug465WgGJC/sx9
	 QkP9iu46YMtSA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Tianchu Chen <flynnnchen@tencent.com>,
	Pan Chuang <panchuang@vivo.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Charles Wang <charles.goodix@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 07/10] HID: hid-goodix-spi: Validate package sizes in goodix_hid_irq()
Date: Fri, 27 Nov 2026 17:06:25 +0000
Message-ID: <20261127170712.3163443-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

goodix_hid_irq() reads incoming SPI reports into the 95-byte
ts->event_buf heap buffer.  For the coordinate package, pkg->size is
only checked against the 2-byte minimum header size with no upper bound
check against GOODIX_HID_COOR_PKG_LEN (84 bytes), allowing an
out-of-bounds read of up to 65533 bytes via hid_input_report().  For
the trailing attachment package, neither the minimum header size nor
the remaining report byte count is checked, allowing both a 32-bit
unsigned length underflow when pkg->size < 2 and an out-of-bounds read
past ts->event_buf.

Validate that the coordinate package size does not exceed
GOODIX_HID_COOR_PKG_LEN, that the remaining report bytes hold a full
package header before reading the attachment, and that the attachment
package size lies within [GOODIX_HID_PKG_LEN_SIZE, rem_size].

Fixes: 75e16c8ce283 ("HID: hid-goodix: Add Goodix HID-over-SPI driver")
Closes: https://sashiko.dev/#/bug/linux-07f163f5-b48d-4fd5-addc-ba577c30fc6e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - No changes.

 drivers/hid/hid-goodix-spi.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index a2c6b92f74ee..c8c158a74235 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -574,7 +574,7 @@ static irqreturn_t goodix_hid_irq(int irq, void *data)
 	struct goodix_ts_data *ts = data;
 	struct goodix_hid_report_event *event;
 	struct goodix_hid_report_package *pkg;
-	u16 report_size;
+	u16 report_size, pkg_size, rem_size;
 
 	if (!test_bit(GOODIX_HID_STARTED, &ts->flags))
 		return IRQ_HANDLED;
@@ -600,13 +600,15 @@ static irqreturn_t goodix_hid_irq(int irq, void *data)
 		return IRQ_HANDLED;
 
 	pkg = (struct goodix_hid_report_package *)event->data;
-	if (le16_to_cpu(pkg->size) < GOODIX_HID_PKG_LEN_SIZE) {
-		dev_err(ts->dev, "invalid coordinate event package size, %d",
-			le16_to_cpu(pkg->size));
+	pkg_size = le16_to_cpu(pkg->size);
+	if (pkg_size < GOODIX_HID_PKG_LEN_SIZE ||
+	    pkg_size > GOODIX_HID_COOR_PKG_LEN) {
+		dev_err(ts->dev, "invalid coordinate event package size, %u\n",
+			pkg_size);
 		return IRQ_HANDLED;
 	}
 	hid_input_report(ts->hid, HID_INPUT_REPORT, pkg->data,
-			 le16_to_cpu(pkg->size) - GOODIX_HID_PKG_LEN_SIZE, 1);
+			 pkg_size - GOODIX_HID_PKG_LEN_SIZE, 1);
 
 	report_size = le16_to_cpu(event->hdr.size);
 	/* Check if there are other packages */
@@ -614,22 +616,34 @@ static irqreturn_t goodix_hid_irq(int irq, void *data)
 		return IRQ_HANDLED;
 
 	if (report_size >= ts->hid_max_event_sz) {
-		dev_err(ts->dev, "package size exceed limit %d vs %d",
+		dev_err(ts->dev, "package size exceed limit %d vs %d\n",
 			report_size, ts->hid_max_event_sz);
 		return IRQ_HANDLED;
 	}
 
+	rem_size = report_size - GOODIX_HID_COOR_PKG_LEN;
+	if (rem_size < GOODIX_HID_PKG_LEN_SIZE) {
+		dev_err(ts->dev, "invalid attachment data length, %u\n", rem_size);
+		return IRQ_HANDLED;
+	}
+
 	/* Read the package behind the coordinate data */
 	pkg = goodix_get_event_report(ts, ts->hid_report_addr + sizeof(*event),
-				      ts->event_buf,
-				      report_size - GOODIX_HID_COOR_PKG_LEN);
+				      ts->event_buf, rem_size);
 	if (!pkg) {
-		dev_err(ts->dev, "failed read attachment data content");
+		dev_err(ts->dev, "failed read attachment data content\n");
+		return IRQ_HANDLED;
+	}
+
+	pkg_size = le16_to_cpu(pkg->size);
+	if (pkg_size < GOODIX_HID_PKG_LEN_SIZE || pkg_size > rem_size) {
+		dev_err(ts->dev, "invalid attachment package size, %u vs %u\n",
+			pkg_size, rem_size);
 		return IRQ_HANDLED;
 	}
 
 	hid_input_report(ts->hid, HID_INPUT_REPORT, pkg->data,
-			 le16_to_cpu(pkg->size) - GOODIX_HID_PKG_LEN_SIZE, 1);
+			 pkg_size - GOODIX_HID_PKG_LEN_SIZE, 1);
 
 	return IRQ_HANDLED;
 }
-- 
2.56.1.839.g22a8290db9-goog

