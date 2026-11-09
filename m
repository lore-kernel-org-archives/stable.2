Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202052;
	b=hx0gAvfkmCP5boHZfXa4HZ46lxXmS+48tcOTFaTgK6vgsCJ+4H57u2qXPPIShZeVg4RH
	 apAOI2+5m5aofyjTwpOrQXZSWxgzD0svtWbzkjkhi/pxZYIi9I/EQkt5v72QiCJfucdpe
	 u/scJp0ERsQF9X4buNuGhs7PGjgtj3I9Nw52hmfuIqaZPEwi0F+Zlwh6lUD9mBFi0P5BT
	 foqhPJe0uoM11SjZhK1vMS+QHOrIgntgOSoZD5dPPIwAG/wDqixVb53R5BYZQzbNb3RH0
	 D2QFfaf4Ln+IdUNKlwvZJCPR0q5VBUuRBv1gQORMIZ7dbthLGTZrF7JklX0BwyO28Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202052;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rNI0FhTOj0/kWQb6qFtt+AdoxirvrS8PR1o6nERy2kA=;
	b=h9qSWkjzrOF2O0V3FvzPlEdonhweMUGTdX96PTMDsUL3EpfvIxFzDJVJyryNrbCdpZ3H
	 yH4A++utAtGD9WahZSLQYJAcJWKE/fdXBCjBJTk+a1GI4Aql6IQjrk2//0tNkiAvegvXX
	 mdKaBqBrapf9HV90VKw5EsLUxS4H1FwWOWxE9wRI5GRgtnioAsyQOhlS2RrEVg8yC6FjT
	 AaRMQJ7wqY9aW2h7pobdoXBkGMEGWSYP1ZSZ46XkJJG7kb+2YEA+1yAZqeXshdL5RI8wh
	 Saca6QJCwPxP4LgabL3/UOUAQoCyZrWLQt9DJk3S6tsOfvy1WTNpmWvC5vf5/LFmoyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="rtu9/jAN";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFE2606A321;
	Mon,  9 Nov 2026 05:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CFE2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rtu9/jAN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rtu9/jANHgrk8oBvee/yT73qI0nL6CZeeU68zbfB/QOqzYEXFT5MHe+6kLAKbNxs6+rUSkAgjByoK
	 X9ZGmya5cqmthfYkAmffjIMcxKtN9fokyyvZ8t09nbFf0TPLVfR3vxeyi0vs76nllFiDptNBeOBBH0
	 YVYdsXvl4MaqivUo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af159bf31d-c65a6;
	Mon, 09 Nov 2026 13:27:27 +0800 (CST)
X-RM-TRANSID:2ee96af159bf31d-c65a6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af159bcc11-8263b;
	Mon, 09 Nov 2026 13:27:27 +0800 (CST)
X-RM-TRANSID:2ee86af159bcc11-8263b
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: linux-mtd@lists.infradead.org
Cc: miquel.raynal@bootlin.com,
	richard@nod.at,
	michal.simek@amd.com,
	linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: rawnand: fix GPIO descriptor leak in rawnand_dt_parse_gpio_cs()
Date: Mon,  9 Nov 2026 13:27:23 +0800
Message-ID: <20261109052724.1032-2-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261109052724.1032-1-zhaofeng2@cmss.chinamobile.com>
References: <20261109052724.1032-1-zhaofeng2@cmss.chinamobile.com>
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

rawnand_dt_parse_gpio_cs() acquires one GPIO descriptor per loop
iteration with gpiod_get_index_optional().  If a later iteration
fails, the descriptors acquired so far are never released, leaking
the GPIO references.

Roll back with gpiod_put() on the error path.  gpiod_put() accepts
NULL, so the NULL slots left by absent optional GPIOs need no special
casing.

Fixes: b85c943d181a ("mtd: rawnand: Add a helper to parse the gpio-cs DT property")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Verified against current upstream master.  Not runtime-tested (no
hardware using gpio-cs).

 drivers/mtd/nand/raw/nand_base.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5466,7 +5466,7 @@ int rawnand_dt_parse_gpio_cs(struct device *dev, struct gpio_desc ***cs_array,
 			     unsigned int *ncs_array)
 {
 	struct gpio_desc **descs;
-	int ndescs, i;
+	int ndescs, i, ret;
 
 	ndescs = gpiod_count(dev, "cs");
 	if (ndescs < 0) {
@@ -5481,8 +5481,14 @@ int rawnand_dt_parse_gpio_cs(struct device *dev, struct gpio_desc ***cs_array,
 	for (i = 0; i < ndescs; i++) {
 		descs[i] = gpiod_get_index_optional(dev, "cs", i,
 						    GPIOD_OUT_HIGH);
-		if (IS_ERR(descs[i]))
-			return PTR_ERR(descs[i]);
+		if (IS_ERR(descs[i])) {
+			ret = PTR_ERR(descs[i]);
+
+			while (--i >= 0)
+				gpiod_put(descs[i]);
+
+			return ret;
+		}
 	}
 
 	*ncs_array = ndescs;
-- 
2.39.2



