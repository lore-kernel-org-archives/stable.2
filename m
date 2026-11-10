Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320231;
	b=siQ68hLiA2MsoOhnJpYnYBjnMWRY5IcNSeNRCSG6fGMm9r/ZdSKfoPk1W3ckyuhZJOvW
	 Uh0SEqyNC7JVLrtVXNclttHCuDnL0e3Al/giPlGKEf/2Y5GsjSPYMeDCKMwDN5G1FXMU2
	 0TsjcIyWIfFsxAs2tkyasY6EpRyF7Sp+WhodT4Yhgw/VySPEZDef9c7QJEvR/jkn3fgdG
	 AEMM900imeZHYDwA5KYSl/9fsctd9QNky51j+QHyQt/COhPh918rTo5ZYBWDDxNXPbpiF
	 kvP527vedbNtl2RAyGtW0u9c7nixjA/2Ch+Q0DonT/QELfPWxX950vWWdDY29OgHzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320231;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IyPDhGhISCDZBt6ovS1pCdTJ+NbS0QoXb+FYRbTSqZc=;
	b=I+zAsOFPw/PfON7tKWVEADnhs/Ba4zD+UTrmzOSxAaUyDGtB4EEvPZKJz0+TRJ7ozf9A
	 UzSmcfkPSmYfivrM+AApReRCZmqHDtCUNmNUk20ErRsSNL9bqTa/ygvVe85Bq30llqhBl
	 RW1aqxfm7ZLI0Jsj8meJiF/WiKmELEx9yGvTq1sAkjVc4hp/ZTObM8fELubGZGwq+qkQU
	 d8tLbJcofoLsEM0iF596Up2SyuVpMbUb/S2iKOICgl/5kSdBSS6h3tY1mrdbDVEaPZfMy
	 RTx5xmyrpFTmdrGhT0fZ7OW1lvsv4hzkMUTSjzkBEt+w88BsZasr+L88y6My9umKegA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MTr+/oAj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326D60A2615
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTr+/oAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3E71F0089F;
	Tue, 10 Nov 2026 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320230;
	bh=IyPDhGhISCDZBt6ovS1pCdTJ+NbS0QoXb+FYRbTSqZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MTr+/oAjCWmHvWnNcO4clqR3F2eu/07qgX96KZNdqKXBBlD0E2ATn7ADjgSptUmNv
	 RPY+cmh1O2BR3wKtwA/i7eKvtqbMiVq0PP6I6UfXO9hPAMXD8qNoQbTMLrWyHhlyMJ
	 4JWINDuBsbY8n+aT+m0k2R+/Tt984StjXnasz0NgGkYFIekpWMb8h4dAl8RQBYzvPF
	 5hKyUfQ6fR2bSw1gxNMRHX+qYdlbgvxrjUk3AQLkUsU/iJrEbN4rzX4vtrfMskF+Gd
	 GUmN/9YdoiWBnfukSBC7uqN0S0AbF6kSUYsZ+pExRoif0+zmdzTmcdf7lCGNnqrhnE
	 pjaKElV3jlH9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Nedoshivin <gvozd188@mail.ru>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake
Date: Tue, 10 Nov 2026 09:17:06 -0500
Message-ID: <20261110141653.1791478-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141653.1791478-1-sashal@kernel.org>
References: <20261107051011-failed-6.18-2c88c2dc1852@kernel.org>
 <20261110141653.1791478-1-sashal@kernel.org>
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

From: Vladimir Nedoshivin <gvozd188@mail.ru>

[ Upstream commit 2c88c2dc18528489b403fe95741f5731e292f7ba ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9ab52b2e59fc3..f09d97a3ee3da 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -88,7 +88,8 @@ enum vmd_features {
 	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
 
 	/*
-	 * Meteor Lake VMD (device ID 0x7d0b) is affected by erratum MTL016:
+	 * Some Intel VMD devices are affected by interrupt ordering errata,
+	 * including MTL016 (0x7d0b) and ARL004 (0xad0b):
 	 * the VMD may signal its MSI before the posted writes that carry the
 	 * child device's DMA data have landed in memory.  The demuxed handler
 	 * then runs against a not-yet-coherent completion queue and misses the
@@ -125,7 +126,7 @@ static DEFINE_RAW_SPINLOCK(list_lock);
  * @enabled:	true if driver enabled IRQ
  * @virq:	the virtual IRQ value provided to the requesting driver.
  * @flush_addr:	config space address of the initiating device, read before
- *		demuxing to flush its posted writes (MTL016); NULL if the
+ *		demuxing to flush its posted writes; NULL if the
  *		VMD is not affected.
  *
  * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
@@ -1187,7 +1188,7 @@ static const struct pci_device_id vmd_ids[] = {
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

