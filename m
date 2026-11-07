Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046597;
	b=QFlfSJpTG8MRHRBxFkzwb5r2yR08lKQevcClvhawCZUXN72byRuF5g3sJnU+CrQCAXst
	 P9nkQSlbWJsUG32xX9N7Qt6tF2DvVYm/eCOoa2YLWW6gcntCX0ADxwZeyPNPatGeQR/Y2
	 HVMR/o+lATEfLQ3pNjUzPJwQuIOzEa9aXVRqWesYlovT2yxzD4lwgVC4jetYcXv47wuCv
	 F/qBoSnFNAb1d8XEj5R1I7ASNEqQ3d4pqEFj32k+jOHNeaEtjDdT4eiHja3EeIGNbxcY/
	 s+FHpmC2jq7OskfbhEV0AnqeUXv1fsQUNeU7SHAh4pn6L2ZmluYM+kTN70LFeNaQAug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046597;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0FyQ1SUhgrQnNOn2VmdpSNvEBlI8QT6TfZM1efQ4hWw=;
	b=LRm3ZiBKQZ8QWIcKksE+XCwLTtTO3ZjjTlK/nSP43hBgXbc4Yw9OchiWEtApRBrdLX10
	 8oxpvevuKDEKIrkq5oETNzgULkuq17AJyt+/cXNZQjW/LasyNxqjNsdyUP6rkFZXl2wKj
	 HIOwx8dwjp8W15prNZpyPM8omeBvg+jk8TgeZy3XYeq78pViI8v6HYdO2t5BZlfiffRbv
	 6Jadp4f9MKJBzX8aQu85CzdJJpLmcwCfZuHJ2T3IfuGb6PmwArEXUZNve9Psr5zLI+MbE
	 6OsBb0ApJiPxPEf/1TvARNkSQGpxELpMSEIKN1SUagV3D1x1pOXo5CvFjYgrmHq2o3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jonUJ1M2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E4606EE8B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jonUJ1M2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABC91F008A3;
	Sat,  7 Nov 2026 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046597;
	bh=0FyQ1SUhgrQnNOn2VmdpSNvEBlI8QT6TfZM1efQ4hWw=;
	h=From:To:Cc:Subject:Date;
	b=jonUJ1M2zQtf2UdqraAU6SRlHAlCmR2AB96BtTPGKkQvUIKCSCDL0kgMqsWImmTFc
	 5IC5sHE44M6pFEzDaFB9N3FSizF5+nA/DXDgWUmfdKNufgKqUbNYLlkPRQTeT2STz4
	 rv+zea9ih/lSck9aqpH8v1EqQQybTDLzFCIejcVByPur2q4cKWO7t+dJSyDkQVxjaD
	 hg1243r0GmZ7czTeSQF8V2pfLuhEBE5N+yUOyFnP3oj5sZ1XXfkk/AYtpBBKzq/uEA
	 EqlcLlCIPd2vnGLTy1ghFIRl0eNSD+UgYA5Uyxxx/wqhc9cTr1LTY4XRunYwLHbDy2
	 mAtPtcRcturww==
From: Sasha Levin <sashal@kernel.org>
To: marek.vasut+renesas@mailbox.org,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:35 -0500
Message-ID: <20261107051635-failed-6.12-f0a5c6bd797c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f0a5c6bd797c2b9900034983a1118d27eb2f2f16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051635-failed-6.12-f0a5c6bd797c@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f0a5c6bd797c2b9900034983a1118d27eb2f2f16 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date: Fri, 21 Aug 2026 04:05:51 +0200
Subject: [PATCH] PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes

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
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fbe465a29068f..241adcd727894 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -411,6 +411,57 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
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
@@ -418,6 +469,9 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
+	if (pp->bridge)
+		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
 
 	ret = rcar_gen4_pcie_common_init(rcar);
-- 
2.53.0




