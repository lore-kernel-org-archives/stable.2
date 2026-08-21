Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5332E696;
	Fri, 21 Aug 2026 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278008; cv=none; b=p8UVE/cKa/KfP5KWD3P1goboURDPk+853kft2Auzp3UrDVTvLibeCdShIlLr8ixVygBk5chqfQziFNd7fjWirffvg2xKqSwkCnVQqYT5jp36hekNchH9+EWSJ5mBP62+iI6MwZbjz4ripXTw4QzSJfnkLn74IPIFJ0RfZKl6G1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278008; c=relaxed/simple;
	bh=5IkXvg2mBCLPxuYvvJQh2wbLppn2C00GgAkHb7wnP9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IwzeFNAPNk3IoIh346h66zlk4/bQb8L2QJIc4nLeSP4yMiaKMTPOr0XjacrGBWkuMHKoAyAQ8938NCWUdPrPhQeM/x8evvnABNCaM5ORa9b7muRCPfZZh/WbxgZXNim4JaaRVgcZ5tfzTTawDC1i2AEgi0LY+AUBCUQg59vNCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kIp4YdPy; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=O2hePe7M; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kIp4YdPy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O2hePe7M"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hR3Zp6sPszMlDm;
	Fri, 21 Aug 2026 04:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787278003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=61xxDssEoMTgU4EO+itVPFOaaikfmZAy4Onv2p4eAu8=;
	b=kIp4YdPy7mVImmb18MXH78kuuBiyZhG5wQF+wQKt2H0pM8pEzPfbtBYHVbfcXqw68uMlS/
	ElD3GPBb/+7cACU5OLipG4bD6XbRmTWngG9h15ISnqGIAKCVdsJP7gqZEg7RhK2jPi58XZ
	WjvvXxgjgIFjd1tYUfui0ARGZN54nWwOv1AtCNI+HgMS5w4oCzvdHUAUxYkjI0a2FwMDa6
	GhcLWnwJ/j6csgheY9ddtFpWXBOgVrqoeds3/Spvw6vzsrcgwtrLF1eBKXCBc/+/rSpETe
	CB3VvtXcYAiLNTxcn5X7eX3VrsnyVchZu1bkvAxcZhYDiPF/rdOQnmmOXLSKRg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=O2hePe7M;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787278001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=61xxDssEoMTgU4EO+itVPFOaaikfmZAy4Onv2p4eAu8=;
	b=O2hePe7MhF2P4QX4E3xQ8+cpibDhzL0lbdYjO3yblTIrGN7fMfHMgX7hMhGOgKBjPbrfJB
	xZrheJ/p4UQ9nPQK2G6tkWPRXRS7RoPLUihhgEyxUGocdMpS/LJ/adA4ImOPbKX6iuJ+it
	oFCI27UNJfChbSS3etZ8ceG7KCd6HSHea/2ZB4sXxBcaYjvuFG4bPGzHUaES4GXwpCg1Gk
	HdpxwxU0OGWK54QMRApGUY4yBmELG/NW3M33YBzUsEe1zU/rKKM9Nf0phO7x3dI+RzVvvY
	WSK1WPlXZSMisz55UMAsqBmAeHUSCxV7ZoTETlww526rGpQJuh2D5vnD4QZ1Og==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and Max_Payload_Size to 256 Bytes
Date: Fri, 21 Aug 2026 04:05:51 +0200
Message-ID: <20260821020636.111719-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wqjhkzf9uff7kay4k5kqk7p7bpxfc8nt
X-MBO-RS-ID: 544535875d00c52fa02
X-Rspamd-Queue-Id: 4hR3Zp6sPszMlDm

R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
Max_Payload_Size (MPS). PCIe specification indicates that the MPS
must not exceed minimum MPS of any element along the packet path.
Force limit Max_Payload_Size to at most 256 Bytes for each device
connected to this PCIe controller.

R-Car Gen4 Reference Manual, chapter 104.4.8 Usage notes for
MRRS (Max Read Request Size) states:
  Please set "Max Read Request Size" to 128 bytes or 256 bytes.
  If "Max Read Request Size" is set to anything other than the
  above, the transferred data will not match the expected value.
This limitation also seems the apply to devices issuing MRd TLP.
This limitation can be triggered by using non-HMB NVMe SSD with
Max_Read_Request_Size 512 Bytes, for example Crucial P5 Plus.
Any write into the SSD (MRd TLP issued by the SSD) longer than
256 Bytes wraps around at 256 Byte boundary, and the same data
are written into the SSD starting at offset 0 and at 256 Bytes.
Force limit Max_Read_Request_Size to at most 256 Bytes for each
device connected to this PCIe controller to avoid this behavior.

An non-HMB (Host Memory Buffer) NVMe SSD can be identified using
the following command. Affected SSD reports 'hmpre' field as 0:
"
$ nvme id-ctrl /dev/nvme0 | grep hmpre
hmpre     : 0
"

The symptom is a read from the SSD which wraps around at 256 Byte
boundary. The test for this symptom can be implemented by writing
512 Byte of random data into the SSD and reading the data back. If
the read back data repeat after 256 Bytes, the device is affected.
"
$ dd if=/dev/urandom of=/tmp/data.bin bs=256 count=2 ; \
  dd if=/tmp/data.bin of=/dev/nvme0n1 bs=256 count=2 ; \
  dd if=/dev/nvme0n1 bs=256 count=2 of=/tmp/readback.bin
"

Expected data:
"
$ hexdump -vC /tmp/data.bin
00000000  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca
00000010  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b
...
00000100  7a ce 3c b2 e1 d5 d9 11  88 63 10 59 76 3c dc 32 <-- random
00000110  72 32 2a 7d a3 e1 aa 13  7c da 58 a1 7b 21 11 50 <-- data
"

Faulty readback, collected without this change in place:
"
$ hexdump -vC /tmp/readback.bin
00000000  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca <---.
00000010  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b <-. |
...                                                          | |
00000100  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca <-:-+- repeated
00000110  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b <-+--- data
     ^^^
      |
      '--- Repeat starts at offset 0x100 = 256 Bytes
"

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Dispose of the reprogramming of MPS/MRRS altogether
    - Dispose of the entire fixup quirk
    - Replace both with bridge enable_device hook
    - Limit MPS/MRRS along the entire packet path to follow
      MRRS limitation requirement
V3: - Set no_inc_mrrs to prevent periperhal drivers from increasing MRRS
      over the limit set by this PCIe controller driver
    - Warn on MPS > 256 Bytes
    - Recheck updated documentation and update code comments to match
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 51 +++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fbe465a29068f..e38cde2257bb4 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -411,6 +411,54 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
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
+	 * will not allow MPS to be set higher than MPSS, warn here in case
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
+	 *   Please set "Max Read Request Size" to 128 bytes or 256 bytes.
+	 *   If "Max Read Request Size" is set to anything other than the
+	 *   above, the transferred data will not match the expected value.
+	 * This limitation also seems the apply to devices issuing MRd TLP.
+	 * This limitation can be triggered by using non-HMB NVMe SSD with
+	 * Max_Read_Request_Size 512 Bytes, for example Crucial P5 Plus.
+	 * Any write into the SSD (MRd TLP issued by the SSD) longer than
+	 * 256 Bytes wraps around at 256 Byte boundary, and the same data
+	 * are written into the SSD starting at offset 0 and at 256 Bytes.
+	 * Force limit Max_Read_Request_Size to at most 256 Bytes for each
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
@@ -418,6 +466,9 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
+	if (pp->bridge)
+		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
 
 	ret = rcar_gen4_pcie_common_init(rcar);
-- 
2.53.0

