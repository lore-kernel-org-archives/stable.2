Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050462;
	b=5QfivVr3J86KndWT1EsPxMYEF8Y/fKneFfhpl1XqHc07KdqHS9F6AW8+R9B+KgqlVNZO
	 oww/aX5CRA6OWq5VaUcREJTDGjjcAJGs215FPF15htcuphY7PsttrhvAC6gwPY9/yyg6c
	 HDSL2/MXTS9W4HUYmPiF4Muswgw69v2z5Zj112byJoDPayHOyed3NTHgSi7tJMpuwR5bP
	 MuWRMUPmwzpSvJoklo8FI/+obiLW3m8oKHEUFDjUzCoku9FvmlnArp02WEDBwVoRBHiO2
	 BlWpyiWxLVug3QiADrXlaW6fXJcY+4Fn6/7BxXxWzoz2TsWIYdd/GWaC518DuEXSVsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5tKjO/gO9rSHO+wVoEO0QmdcAE4Vq8SgtIqirlqLOgs=;
	b=lnmeHQxZcgahV58WsWCiPTzJAXWohBqVRlq7ZaRP5Ld/Sjgwt+bO82/rA/bjlgNzWAqG
	 juLaqFc84uvD9dJDU75ZSfoq4N45J4CScoSDSdygVPFx1S9YUYt0jXbN+9GM0+DuE39p+
	 RIQHNrHCLDio7Cnvo0ClRdp8SeMurC/nWc7lH2aQIS4uaGhACUlJjoeTzqtHTimn1+eud
	 V/y9Fl+YKk2nppLdJNoaZzrwQl0DVIPwva+EyCIr1jNgBeS3xbBZNKAH6UDL1W5uNjdcr
	 pdnqS1Qg1yvNbbBVbcsKqHbJWozWgbiwaGK5rM+XICDIdT86Uj7tmldB8yFpYkMzVCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVA68tNX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55491606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVA68tNX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80CE1F0089F;
	Sat,  7 Nov 2026 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050462;
	bh=5tKjO/gO9rSHO+wVoEO0QmdcAE4Vq8SgtIqirlqLOgs=;
	h=From:To:Cc:Subject:Date;
	b=bVA68tNXFtqOMVtAru2DdJGwKYvW2+E3ob5HovX61Y2J2xtZcrxw93vaDedixnaog
	 0U1gmt1UAkjP2xQnTGzx/8PzTDsQs5UXmP4OaCEZ5HltFVm048tgu5Bt9jrFKYEed6
	 he6M9xG+B4WC/2N+YY0NLIm5/y+KFFX2Np9Ud8vuzHlpZycfzqCfo8cnZTomTmbaE/
	 jxl4U40IMXZ+t7MB0P2SXfzO8Yp6OvIKAJ5O6sZkR2Gj39nnVhg6tmJKuYoFElOhOo
	 Qe7NdyvnvxW3Jtyypgbbkd6ZFmckJPiLUo6nS8KpQKvUUu5+JFy1P0QyqKm1J1uEQg
	 raMVTJKIxTi4g==
From: Sasha Levin <sashal@kernel.org>
To: gvozd188@mail.ru,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:00 -0500
Message-ID: <20261107062100-failed-5.10-2c88c2dc1852@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2c88c2dc18528489b403fe95741f5731e292f7ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062100-failed-5.10-2c88c2dc1852@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2c88c2dc18528489b403fe95741f5731e292f7ba Mon Sep 17 00:00:00 2001
From: Vladimir Nedoshivin <gvozd188@mail.ru>
Date: Fri, 11 Sep 2026 00:05:39 +0400
Subject: [PATCH] PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Per the Intel Core Ultra Processors (Series 2) Specification Update
(ID 834774 of 9/1/2026), the Arrow Lake VMD device 0xad0b is affected by an
MSI erratum:

  ARL004: MSI from VMD-Owned Device May Pass Memory Write

  Problem      When the storage subsystem is configured to operate in RAID
               0 or 1 mode, a Message Signaled Interrupt (MSI) from an
               Intel® Volume Management Device (Intel® VMD) owned device
               may interrupt a core before a previous write from the device
               is completed.

  Workaround   None identified. The VMD MSI interrupt-handler should
               initially perform a dummy register read to the MSI initiator
               device prior to any writes to ensure proper PCIe ordering.

The existing VMD_FEAT_INTERRUPT_QUIRK implements Intel's documented
workaround by issuing a configuration-space read to the MSI initiator
before dispatching the interrupt.

Enable the existing quirk for 0xad0b as well as 0x7d0b and make the
comments describe both MTL016 and ARL004.

Tested on an MSI Vector 17 HX AI with Intel VMD 8086:ad0b and an NVMe
device behind VMD. With the quirk enabled, the NVMe completion stalls
observed without the workaround are no longer reproduced.

Link: https://bugs.launchpad.net/bugs/2166325
Signed-off-by: Vladimir Nedoshivin <gvozd188@mail.ru>
[bhelgaas: include erratum source and text, cc: stable]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260910200539.10862-1-gvozd188@mail.ru
---
 drivers/pci/controller/vmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e45ef8cb16e47..9d97a832785ee 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -94,7 +94,8 @@ enum vmd_features {
 	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
 
 	/*
-	 * Meteor Lake VMD (device ID 0x7d0b) is affected by erratum MTL016:
+	 * Some Intel VMD devices are affected by interrupt ordering errata,
+	 * including MTL016 (0x7d0b) and ARL004 (0xad0b):
 	 * the VMD may signal its MSI before the posted writes that carry the
 	 * child device's DMA data have landed in memory.  The demuxed handler
 	 * then runs against a not-yet-coherent completion queue and misses the
@@ -131,7 +132,7 @@ static DEFINE_RAW_SPINLOCK(list_lock);
  * @enabled:	true if driver enabled IRQ
  * @virq:	the virtual IRQ value provided to the requesting driver.
  * @flush_addr:	config space address of the initiating device, read before
- *		demuxing to flush its posted writes (MTL016); NULL if the
+ *		demuxing to flush its posted writes; NULL if the
  *		VMD is not affected.
  *
  * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
@@ -1300,7 +1301,7 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_VDEVICE(INTEL, 0x7d0b),
 		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0xad0b),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xb60b),
-- 
2.53.0




