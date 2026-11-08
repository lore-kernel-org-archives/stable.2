Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167851;
	b=zMqK9euUyzIPegu8jiprLkDtN8kxPiRRjGiH8l33oeF47lqRppHUUZasaR6pknF8koz0
	 Ne2hl4XfyQFoWerwlbyHJm7i0G0Ly+YNJP7QK7+tUztCWh48FuDxx6gNXDs9IEZKFVgSu
	 Kl/AKPN5o5Qb4lDVIZ6D4mkrNWmgu6v0Q+2u+0IuFD5vN40QqlfwDR/0WFh+w5VSmPzbu
	 vdwOgoxGkWqYNlM65HfisjEX+7zVXqxP4XA1k5v7WmWValOnVOwMyRppurDLTZLooragX
	 vlGXlxLsPtf7NCh7BaoDZ96ExWAOo5pi1KlqxX3SMGsbC8tld9jrJfBBWvlImq97mvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167851;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=in5osYrfoLDOJ2Fuqy+RLhsPo3Y3hzOj0r9BAfaT1U4=;
	b=IiqdBexcdmFmVVrJCok8mZAyPd9aaf8j1LMiMcRJoJ00iCIaQtNMlo2VwvMHkBzhQgnR
	 8vyaEyXLAA1l1Kw5pnBW2bjadWNlLb2xxntscYxRqgPCguCXKuoxFC4q76JCOAoK5CrTo
	 dxeLxgM86w8+umDlbIHy/FIz3cRBsThEVRBd6Of/9gPvXjnuoy2P7CpaHiT6cqvmxQqVw
	 KOkcrGjqW1LNPvBplTEr0Jszi79xfnktH+97YCNj2vq+8vd+/+gFe9kEUmI5yb57Pf8WN
	 Wwv4xsbBCXHvkabr7/qOJHCSPAmTnb+kv2CYkSjGw3OeKiQAek+k+G3uqhkqD0EIg0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="AgC0//4r";
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661C606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 19:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3661C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=AgC0//4r
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jN3bp1jV3z8sfZ;
	Sun, 08 Nov 2026 20:57:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794167846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=in5osYrfoLDOJ2Fuqy+RLhsPo3Y3hzOj0r9BAfaT1U4=;
	b=AgC0//4rzjTNx7Cmd4qNsCCimVYgfpova2nsrTmmY19Rb+PdNYWQXvOIXGVkT5JJrlFC8x
	R9JrS9sHEB/9M/Bl2nQMPQdl44zZUTJRpQPvyKvItQgdwjIRL3c3xCxtfynfgfYXUu/qDI
	o8pPLYEdbMgFvgTK+QxqNyjYJTfb/2uf4UC3NILQTTQlF1oPr4vO/PhMpNTJ6x5+MzL7xw
	QIkwPma1t1I+p+EouoUaYBK+vlxYOExbOjz2tvJNfK8BnVuwZ4KWZPgF57PlCUicBQHAPw
	s+EN2SPnjyBMTYcwfCk6E5afgU5es8GXXusu+hycoleITVGE08w7/+wP3V/csw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: stable@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.18.y] PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes
Date: Sun,  8 Nov 2026 20:57:08 +0100
Message-ID: <20261108195708.2478016-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050622-failed-6.18-f0a5c6bd797c@kernel.org>
References: <20261107050622-failed-6.18-f0a5c6bd797c@kernel.org>
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
X-MBO-RS-META: 5g3rc9h9doe5sf4f597a6bqie6c3qbhq
X-MBO-RS-ID: 30f91bb1dc33bea20e3

R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
Max_Payload_Size (MPS). PCIe specification indicates that the MPS must not
exceed minimum MPS of any element along the packet path.  The PCI core
already enforces this, but add a check to warn if MPS is ever set larger
than 256.

R-Car Gen4 Reference Manual, chapter 104.4.8 Usage notes for MRRS (Max Read
Request Size) states:

  Please set "Max Read Request Size" to 128 bytes or 256 bytes.
  If "Max Read Request Size" is set to anything other than the
  above, the transferred data will not match the expected value.

This limitation also seems to apply to devices doing DMA reads, i.e.,
issuing MRd TLPs.  This limitation can be triggered by using non-HMB NVMe
SSD with Max_Read_Request_Size 512 Bytes, for example Crucial P5 Plus.  Any
write to the SSD (MRd TLP issued by the SSD controller) longer than 256
Bytes wraps around at the 256 Byte boundary, and the same data are written
to the SSD starting at offset 0 and at 256 Bytes.

Limit Max_Read_Request_Size to at most 256 Bytes for each device connected
to this PCIe controller to avoid this behavior.

A non-HMB (Host Memory Buffer) NVMe SSD can be identified using the
following command. Affected SSD reports 'hmpre' field as 0:

  $ nvme id-ctrl /dev/nvme0 | grep hmpre
  hmpre     : 0

The symptom is a read from the SSD which wraps around at 256 Byte boundary.
The test for this symptom can be implemented by writing 512 Byte of random
data into the SSD and reading the data back. If the read back data repeat
after 256 Bytes, the device is affected.

  $ dd if=/dev/urandom of=/tmp/data.bin bs=256 count=2 ; \
    dd if=/tmp/data.bin of=/dev/nvme0n1 bs=256 count=2 ; \
    dd if=/dev/nvme0n1 bs=256 count=2 of=/tmp/readback.bin

Expected data:
  $ hexdump -vC /tmp/data.bin
  00000000  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca
  00000010  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b
  ...
  00000100  7a ce 3c b2 e1 d5 d9 11  88 63 10 59 76 3c dc 32 <-- random
  00000110  72 32 2a 7d a3 e1 aa 13  7c da 58 a1 7b 21 11 50 <-- data

Faulty readback, collected without this change in place:
  $ hexdump -vC /tmp/readback.bin
  00000000  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca <---.
  00000010  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b <-. |
  ...                                                          | |
  00000100  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca <-:-+- repeated
  00000110  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b <-+--- data
       ^^^
        |
        '--- Repeat starts at offset 0x100 = 256 Bytes

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260821020636.111719-1-marek.vasut+renesas@mailbox.org
(cherry picked from commit f0a5c6bd797c2b9900034983a1118d27eb2f2f16)
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 7e171526b1ded..9e5dc1009ed4e 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -305,6 +305,57 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
 	return rcar;
 }
 
+static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
+					struct pci_dev *dev)
+{
+	/*
+	 * R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
+	 * Max_Payload_Size (MPS). PCIe specification indicates that the MPS
+	 * must not exceed minimum MPS of any element along the packet path.
+	 * The controller reports Max_Payload_Size_Supported (MPSS) 256 Bytes
+	 * for header type 0 and 128 Bytes for header type 1. The PCIe core
+	 * will not allow MPS to be set higher than MPSS; warn here in case
+	 * something went very wrong in the core.
+	 *
+	 * For details, refer to chapter "104.1.1 Features" in either of:
+	 * R-Car S4 R19UH0161EJ0140 Rev.1.40 Jul. 31, 2026 or
+	 * R-Car V4H R19UH0186EJ0140 Rev.1.40 Aug. 7, 2026 or
+	 * R-Car V4M R19UH0217EJ0110 Rev.1.10 Jun. 30, 2026.
+	 */
+	WARN_ON(pcie_get_mps(dev) > 256);
+
+	/*
+	 * R-Car Gen4 Reference Manual, chapter 104.4.8 Usage notes for
+	 * MRRS (Max Read Request Size) states:
+	 *
+	 *   Please set "Max Read Request Size" to 128 bytes or 256 bytes.
+	 *   If "Max Read Request Size" is set to anything other than the
+	 *   above, the transferred data will not match the expected value.
+	 *
+	 * This limitation also seems to apply to devices issuing MRd TLPs.
+	 * This limitation can be triggered by using non-HMB NVMe SSD with
+	 * Max_Read_Request_Size 512 Bytes, for example Crucial P5 Plus.
+	 * Any write into the SSD (MRd TLP issued by the SSD) longer than
+	 * 256 Bytes wraps around at 256 Byte boundary, and the same data
+	 * are written into the SSD starting at offset 0 and at 256 Bytes.
+	 *
+	 * Limit Max_Read_Request_Size to at most 256 Bytes for each
+	 * device connected to this PCIe controller to avoid this behavior.
+	 *
+	 * For details, refer to aforementioned chapter in either of:
+	 * R-Car S4 R19UH0161EJ0140 Rev.1.40 Jul. 31, 2026 or
+	 * R-Car V4H R19UH0186EJ0140 Rev.1.40 Aug. 7, 2026 or
+	 * R-Car V4M R19UH0217EJ0110 Rev.1.10 Jun. 30, 2026.
+	 */
+	bridge->no_inc_mrrs = 1;
+	if (pcie_get_readrq(dev) > 256) {
+		pci_info(dev, "Limiting MRRS to 256 bytes\n");
+		pcie_set_readrq(dev, 256);
+	}
+
+	return 0;
+}
+
 /* Host mode */
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
@@ -313,6 +364,9 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	int ret;
 	u32 val;
 
+	if (pp->bridge)
+		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
 
 	ret = rcar_gen4_pcie_common_init(rcar);
-- 
2.53.0

