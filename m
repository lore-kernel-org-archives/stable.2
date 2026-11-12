Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492769;
	b=y0Xpj7FFW/T2pxNAuTr/jn1d6RfeTV1pFSR6rGA44jXp+DvQWZzMidVDRO9ZNfWSC+kx
	 QMIf3VcZBN53a/g6ciMJM0v+mDXCUSBHr+xmamQurt6fyGbj55qdQT9iqohC6l+ZPdQs4
	 /sqIo8QBCBAmzzz8gvjwYT0mrfZI2jud4CZS6YosvCSJBFZtns2U1gog9C5Tk2HhSh4zr
	 2cZF/AXRDeaQjipeuJPyuA6n5BpbczT84AMbTvmGsrXBe4yw+Wlm0WYyUpySPoyVotTQe
	 RaNC2FeUu6ZgbtaVybmSqjc8Juwz3Zyvofec6eCc0L5QNWsfaV8wcIHWWhT608YorAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=oHfsArsV+1THff2lm6scfwyXYk/mjFnYjewXg7MQ8Js=;
	b=FAmyZvGFgjU6a5CRt8ckO5cBnjJ7J0PaneIUwfwinLkKjs8lVQ2R/+NtKx/O0gwACakn
	 eVUtGgVa5sUW4KQkju9U0dxOkJAwEjCAmdO02btSrFQ9DQ3EygxqR+QN7nI5BHrIhJe5d
	 ytRtxGvLgmV4FM/vKQo4s8RHn7vsBNfcRZ3tfixj3IyGWyaktumun1zIst/KSzdyyw6u3
	 QkMn3FoGrTG5hmd409iqb/SA1HAUAH/v36yzaNttcIFefdImuK4BfoCK4IiuLIn3/nT+v
	 EDcl3YIQ1/D2j/PKgsyaet6XNCUB1mpLb4glGGcZTPtoqbp6F9EgdaTiN5mXtdfmYew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=KSo0XWvf;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB102606A33A;
	Thu, 12 Nov 2026 14:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB102606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=KSo0XWvf
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQMm962fWz5B17q;
	Thu, 12 Nov 2026 22:12:41 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492761;
	bh=f0OoDwshwHor1bpR+thwy5qjLUhBVUxAgWxGvafydds=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=KSo0XWvfmd4GMSpg8OT9mfXABf1olU4bbgAMgz9+VYG3cCpfH/DvjxI/+LjX37C80
	 rQE+bKx0YnnsD3FrwV0RnByCSg+jlHWQ/E+zFAsZGLH6wOeSi+rijECzPaIR/Arf1i
	 LHOJ766XGQzIfGGzfectcxnRp5Idr2kVz6E1GVr2oXmj9S/teNuk19ntYMYyz18TKQ
	 jBTRh7ERm2DSjp3lnr6+R9fsE0qeq9V/uxNt/PVj1alMBJSmt18YrhLCyRom/z7SO5
	 T1tVAGoPqn5cpG9snAHH6csV8DKp7e/pnnl84tQaCUNb/yAWCeLb3cts6FoexvnvI3
	 NN8HdEV1avhFg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6ACECdhU063391;
	Thu, 12 Nov 2026 22:12:39 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:12:43 +0800 (CST)
X-Zmail-TransId: 2afc6af5c95bf1e-e468d
X-Mailer: Zmail v1.0
Message-ID: <20261112221243353Po9hRWMDIg_5GUj_V1gmf@zte.com.cn>
In-Reply-To: <20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn>
References: 20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn
Date: Thu, 12 Nov 2026 22:12:43 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDQvNV0gYXRhOiBwYXRhX2Z0aWRlMDEwOiBzdG9wIG9ubHkgc3VjY2Vzc2Z1bGx5IHN0YXJ0ZWQgR2VtaW5pIGJyaWRnZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ACECdhU063391
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 22:12:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C959.001/4jQMm962fWz5B17q

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
