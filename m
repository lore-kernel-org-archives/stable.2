Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046214;
	b=CgfMgLm9etI3caLBb2Kr/ad85NhQnEfb4mqkLD3z7nyai+5C9NgdTH7qQwSpxq3w3ZZ3
	 HzBnuz+XiV5+3clRmPl+24Fpahmj+FbbRa+c2otjq83zH1W55dsDbB/mG8iNF3ViMa/CJ
	 L1xDf96ASNEfRurXOGB16N+xGoHixe4dXhEq5yr+enZtKTuyopmsX0ymExQ7vjqlnyeow
	 SlcI1HeiWTZ4kInzGFl+HCKdYsVrPCl5hzffSTy2JwQNykUR4a/rIcavvPjO1RaVD5Rzm
	 J12jsf4E/vKXdtISFuKRhqfwAGN5Z2uiFRQQDSxdcTFm1zJzg0r3arfyN5OtTm+qpXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=orS03UeNQSq3G+uPLUuHZssDv3zp2nve+tm0f3WDeo4=;
	b=aCaijES9QhJ2KJPIXQC/qrCn3171CQie3Cm2TDQN1kLurRQi1roTJKkziGY1IPWq0cFj
	 ztz0WigVGKfZFXbaj3hfojQjurLm0hVLgptxoHO3hAQeLweXbjUUDPPbylQBe/p9kNT2T
	 Sy6O9iyg2RmQTgqPBSVhgbasO2i0Z5Qdd75e1dVZuKkJVkDJfGtCWtANBDbDMC5Bb/285
	 yn6+jnOVRUYNSNvRT2rFwqth4TyYbljnB6J8rUjmRt6FzjuIW9REWrpI0QfDLTl2/oLcc
	 JjQ/ogWVGPuDjTAM5PDYt0fkUiieiRyGh+58yw5wombQ+MIwkQ4IRG/QNMFBy3cdyyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlHVnhPe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC8606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlHVnhPe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00B71F0089F;
	Sat,  7 Nov 2026 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046213;
	bh=orS03UeNQSq3G+uPLUuHZssDv3zp2nve+tm0f3WDeo4=;
	h=From:To:Cc:Subject:Date;
	b=XlHVnhPeaaBEgdyKX9Mr0Y00lQ2eVs0424KdSIM696e1CRwlF1CDdMY+CmD/FC0VS
	 ABfvL4UNrnN+Cqw5DN7c7/yvfreDO5OhGYkeKYspP/mRXH1RhA0bjKUIyyypBZeAk/
	 1IMBgiV0kt4z7T0NtImCelYeV2qzq8rPqsetda0H7w9RDjhX5UqL8xh0LJe1nKAYYY
	 DxWDydzcd8k5CH6+iRZfC2cA1bR30PReiI+DRczawqLRv4Nc/kHQwgTABPTCUleLsM
	 6zyGbNQkEMZStTT3b6C8MytSmo6op3RjfoYx+K7Jcd3ZgOrh1FG1l8yCvYDovspcaH
	 e29TtaJ2fbQcQ==
From: Sasha Levin <sashal@kernel.org>
To: gvozd188@mail.ru,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:11 -0500
Message-ID: <20261107051011-failed-6.18-2c88c2dc1852@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2c88c2dc18528489b403fe95741f5731e292f7ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051011-failed-6.18-2c88c2dc1852@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




