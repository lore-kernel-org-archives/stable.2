Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593003;
	b=lZzao9eXzSjgofT4cr9e2CVCVDuCg1hGcA2NAFqqiUk/IfWXFzDnDcq4uf6r+7t2bZsC
	 Vzs6r8Ht3J/b145sxau3XXRRhyL1nlonl9Y79BYEmz1sAifjQAgPe5f359jNbk0AG9KTf
	 yc/qR0Yi+lz5Oa3mg37kowxyIeG4axTEKaOWxYKNiv4o6dDc43gPVyby9snNFB+XnuVB0
	 EMfgKRHkGwr7iqVdcoghOEbU87EfmBLb+5weAurdFR5lTQHgTZsXFxBO5NcIEz6eHTPpf
	 h7jIGVPAxsOJ2CKDGtVYdePIczMSfXOCX018mZNYgjSI3q3zQl78LB6EKq3vdQGpGDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593003;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=G+adoV0PMqXFKT8tWBJOs534Nn/4DUFwSmqIUTPOYr8=;
	b=AG2PV79KbHZXuhC7kMwmL75lmQ/W/uHq0o7eFvQJZTRtIaS1o+VA9wNmyC8MI4AIVrxW
	 xCNUFyAq/h0L1pHlWvOl3ukSk0H2cnLrbwVVFVL22wmXrfEuDLd4/BmejslSU2dXyq2v8
	 Aq0Tonk2SvUHZPQCxprB1C4z5tgjlDyQmbk6p0TyiZi6UaJKKpdjxadR/Cs06l7UbCl7R
	 fIP3Q5w1RVPG23N0gID81xKI84igDB0IJE6rE3FRiC2c/k4K7GNQ/2hD+AMS10T7tcvvk
	 jCSIhkDD8V1VkPp0RUn/sEqTxSJ8zldo6WLKiVR648zISCpTgCkrYY5rDvjO9VF23KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=tM09Cjy6;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD45606B219;
	Fri, 13 Nov 2026 18:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FD45606B219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=tM09Cjy6
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qr2ykrz8XrrZ;
	Sat, 14 Nov 2026 02:03:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794593000;
	bh=yBIQYLbJkZ5lwh8QI0T2TpRVjjIaQ9RAKkjkRfl2e0c=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=tM09Cjy6pIFiQOnA2bLoQDe1l2aweyeWG+ZNd56pcZ8QKVhnKTvHaYUpz/Tzu+fkg
	 +cti5lZe8dy97EjVL1Nz9DsIvi1/rHjWBVNWvZ/cG08HQUs3JAHhMuWYLqvrhoR7kH
	 M+k+2eM6H3OJA2BgzASJdPSS+JItHKH6UC502NX2tMw4gUPbJNiflxGYDb8ccKPw6S
	 ziIe9aED3saOakaP4CYwj490+jXOtKh4fX56E4W1pB5ET9VI3kqR4HICUmL/asX4nv
	 YpQSx8dGaMHYYAylKGrs//TjhixZjyf8QKzT4kyEcTJvluBW2ec8a2oAI0ya+pQDdH
	 owDX+kQcrYZIg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6ADI37Rv099944;
	Sat, 14 Nov 2026 02:03:07 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:03:11 +0800 (CST)
X-Zmail-TransId: 2af96af750df226-1616b
X-Mailer: Zmail v1.0
Message-ID: <202611140203115772rYUcbkXLPF5hieKIzB1T@zte.com.cn>
In-Reply-To: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
References: 20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn
Date: Sat, 14 Nov 2026 02:03:11 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCA0LzVdIGF0YTogcGF0YV9mdGlkZTAxMDogc3RvcCBvbmx5IHN1Y2Nlc3NmdWxseSBzdGFydGVkIEdlbWluaSBicmlkZ2Vz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADI37Rv099944
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:03:20 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750E8.001/4jR4qr2ykrz8XrrZ

From: Shao Mingyin <shao.mingyin@zte.com.cn>

A Gemini ATA port can start successfully when only one of its SATA
bridges comes online. gemini_sata_start_bridge() disables the clock
of a failed bridge, but port_stop later stops every mapped bridge,
including the failed one. A missing disk on one bridge can thus cause
an unbalanced clk_disable() warning when the port is removed.

Record which bridges start successfully and stop only those bridges.
Clear the bitmap after stopping them so a later start begins with
no bridges marked active.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260626091006.5A2C11F00A3A@smtp.kernel.org/
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.4.0-rc1-next-20261105 under QEMU/KVM (x86_64, 2 vCPUs),
with lockdep and KASAN. Both kernels carry the same TEST-ONLY harness
using synthetic ATA hosts, RAM-backed bridge registers and clock
providers. The original port and bridge callbacks run through libata
and the real common clock framework; only this fix differs.

Each kernel completes 24 start/stop cycles covering both partial-failure
directions, both bridges ready, neither ready, single-bridge controls
and repeated starts with the same private state. The unpatched kernel
reports six CCF "already disabled" warnings; the patched kernel reports
none. Both retain 16 successful starts, eight -EINVAL returns and zero
clock enables left over. The patched guest shuts down without lockdep
or KASAN reports. Real Gemini probe, PHY hardware, disk I/O, DMA
allocation failure and full device unbind were not exercised.

 drivers/ata/pata_ftide010.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index c41da296eb..ca683fd96f 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -29,6 +29,7 @@
  * @master_cbl: master cable type
  * @slave_cbl: slave cable type
  * @sg: Gemini SATA bridge pointer, if running on the Gemini
+ * @sata_bridge_mask: bitmap of Gemini SATA bridges successfully started
  * @master_to_sata0: Gemini SATA bridge: the ATA master is connected
  * to the SATA0 bridge
  * @slave_to_sata0: Gemini SATA bridge: the ATA slave is connected
@@ -47,6 +48,7 @@ struct ftide010 {
 	unsigned int slave_cbl;
 	/* Gemini-specific properties */
 	struct sata_gemini *sg;
+	unsigned int sata_bridge_mask;
 	bool master_to_sata0;
 	bool slave_to_sata0;
 	bool master_to_sata1;
@@ -281,28 +283,36 @@ static int pata_ftide010_gemini_port_start(struct ata_port *ap)
 	if (ftide->master_to_sata0) {
 		dev_info(dev, "SATA0 (master) start\n");
 		ret = gemini_sata_start_bridge(sg, 0);
-		if (!ret)
+		if (!ret) {
+			ftide->sata_bridge_mask |= BIT(0);
 			bridges++;
+		}
 	}
 	if (ftide->master_to_sata1) {
 		dev_info(dev, "SATA1 (master) start\n");
 		ret = gemini_sata_start_bridge(sg, 1);
-		if (!ret)
+		if (!ret) {
+			ftide->sata_bridge_mask |= BIT(1);
 			bridges++;
+		}
 	}
 	/* Avoid double-starting */
 	if (ftide->slave_to_sata0 && !ftide->master_to_sata0) {
 		dev_info(dev, "SATA0 (slave) start\n");
 		ret = gemini_sata_start_bridge(sg, 0);
-		if (!ret)
+		if (!ret) {
+			ftide->sata_bridge_mask |= BIT(0);
 			bridges++;
+		}
 	}
 	/* Avoid double-starting */
 	if (ftide->slave_to_sata1 && !ftide->master_to_sata1) {
 		dev_info(dev, "SATA1 (slave) start\n");
 		ret = gemini_sata_start_bridge(sg, 1);
-		if (!ret)
+		if (!ret) {
+			ftide->sata_bridge_mask |= BIT(1);
 			bridges++;
+		}
 	}
 
 	dev_info(dev, "brought %d bridges online\n", bridges);
@@ -315,24 +325,15 @@ static void pata_ftide010_gemini_port_stop(struct ata_port *ap)
 	struct device *dev = ftide->dev;
 	struct sata_gemini *sg = ftide->sg;
 
-	if (ftide->master_to_sata0) {
-		dev_info(dev, "SATA0 (master) stop\n");
-		gemini_sata_stop_bridge(sg, 0);
-	}
-	if (ftide->master_to_sata1) {
-		dev_info(dev, "SATA1 (master) stop\n");
-		gemini_sata_stop_bridge(sg, 1);
-	}
-	/* Avoid double-stopping */
-	if (ftide->slave_to_sata0 && !ftide->master_to_sata0) {
-		dev_info(dev, "SATA0 (slave) stop\n");
+	if (ftide->sata_bridge_mask & BIT(0)) {
+		dev_info(dev, "SATA0 stop\n");
 		gemini_sata_stop_bridge(sg, 0);
 	}
-	/* Avoid double-stopping */
-	if (ftide->slave_to_sata1 && !ftide->master_to_sata1) {
-		dev_info(dev, "SATA1 (slave) stop\n");
+	if (ftide->sata_bridge_mask & BIT(1)) {
+		dev_info(dev, "SATA1 stop\n");
 		gemini_sata_stop_bridge(sg, 1);
 	}
+	ftide->sata_bridge_mask = 0;
 }
 
 static int pata_ftide010_gemini_cable_detect(struct ata_port *ap)
-- 
2.27.0
