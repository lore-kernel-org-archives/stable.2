Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178098;
	b=ZCmdIXchQYZmiWha9rcvSR7S2skfNLflRCtf1GoQatmtGpta3PHHHFI3XMVFVqpXTIot
	 ml/kWOdBl5e0DHrxjfIj5r3/99ZRrCK8Fm4H+3Y8NLrhjqJMmoC0kpcCTOla+3WfB8ANw
	 QbwNP5hVMpBNg3dR87vKctxjTe0GRMCw09vaPPLrfnaEu3TQqSnp9uFrismhR7TT+oaTa
	 kiy4a888AgG69f7kDMbVwa3XP1UeckpbwLthI1nGx95ahdstJr+TpLRpsdASZ7HfBYfIu
	 QrTBMPs154JptHrgvxYtMV7VyM/xEOw7cmgmmYDANRCJXi9Hzx+veU02upsUvNJR/IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178098;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=fKEfqmxYOZU7820kF8aXFu+f7z3LClCPd6Mm3BHbyZg=;
	b=VqnGhJK/pv3zwAxMvXMdNmlod/U7trLOeb9hCZMs9oWJSs4bwn29ADDwNRBUTKFWdE5o
	 pbFiRXrY8VK1k51GNeGxGQ2cAcw4IlWfyRCtAi2KxG6lPCXgirS9OF3yQPxRECekMyD3l
	 pREZ4OdZuA/iOvGc6LLTLJV/WQoAdp6adBoWStZArSRG+0WUaeoeBK7vYvIUMfTV5Twgm
	 VTt4oF51duFhLlT5myOeYqRSIhKwo3YZBx+SWr67Gymu13KyjzzPg9GbFmEGwQ/1JLKnf
	 +R+SQt1Z71wrYomrCaUWTc8B6kgenlxf+Djm2P2pD1Amu0wQBsEfGpLK/1mOtwNVsKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=blHPXQir;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE989606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE989606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=blHPXQir
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jN7Nl4pQPzMlDJ;
	Sun, 08 Nov 2026 23:48:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794178087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKEfqmxYOZU7820kF8aXFu+f7z3LClCPd6Mm3BHbyZg=;
	b=blHPXQir+f9k70ZLeRVdSPep5fDGpxSrTf415x3ndV6x32VnuD5e+1uuizavK6EClVQlDp
	LMyj4H0YbmEsMz1VCriB0rP8xrOTUWSmDlCp9gBUDAKzwDmyDyV5VT693LW+WvQ86436Ps
	rTkH09Hk+WVL1LfMKqMW3WxFjQnaa2eGc3f8vXR25AnIagYLUqacUzcJI9pgmW/BYnugCp
	OxYhAQSQJJiBDqNEnZbX4s4aXJw1dJo+xjnVJ1Si3XbDf8efCD3/hstSwWHxwLBqYMuaZk
	+A4+sdLHfkm1CeTyKn8oPEv0nBTWNfkHGOFRcn46THmHDrn6Q2S8Gj2VWQ0oiQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: stable@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.12.y 2/2] PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes
Date: Sun,  8 Nov 2026 23:47:48 +0100
Message-ID: <20261108224801.2533200-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108224801.2533200-1-marek.vasut+renesas@mailbox.org>
References: <20261107051635-failed-6.12-f0a5c6bd797c@kernel.org>
 <20261108224801.2533200-1-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: he8ifn5j5a6ow5ti6s5qcdzwt89jk74q
X-MBO-RS-ID: bef619eaf7c73b906e8

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
index 8dcb63f813beb..a5f750709e2ce 100644
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

