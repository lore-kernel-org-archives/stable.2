Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047626;
	b=zCMIG3m8DSGtsvwIxLTKIv/H9QOmdDt42evFrtyU7tY9Hh60XD35cy9t5MzfTcaINDbJ
	 R8wjSBvVCrP8JZIBmHlD0HxtxNisU+LXubAzfVkXq+vIfrMSMLrryVtHj2XloKlxGBgrT
	 O/eUkUsqba+9Owb1gla/8uadIHQk1/31+9PL5j1HN5QuLL5nvtXeQTHA/vFAOR+UuR0YV
	 V/fI7a1CgoU4mZwdFaWN1lqfZGw3ifXNxULMvTOg8OOBvIzTU8gBZQMLj06zTnavT6wO+
	 0vzMbI7HzZmwglrvgnyS4YXpZCJUHDj8mMPB8QbY54D+H4JxVhzDkzRDA9P7KfmWJgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u4atQQg3s6WzRNzGY4nczJl7wB1smd47eqgk2dbMoJs=;
	b=KGYn9Yo3cI365IK6cEYkaTiKnfx8W64v+SiYJ9PVnpodTa8e9hsAzrl6CcoGX4jyUGRM
	 vKKFgbcOTMZB3p4ddcRJ1u3A60i2rG4G0dYOUcWksB4raV4Bfhr3vENQ3PKi5uNrLqChm
	 8vyMWmVuqN+xLQIQnR2CJR6pTDWqIJqmYTExEH1qywZHzZ+CSmzRukMOD2jNyCx0TvRZK
	 d1b03ek5e6Eilh19fdU6wiBl8zsEwQfvRNcZFhPhkPW/u4AOke+Djfpiq81B2XMYc7Rb9
	 QEE0WzDAOHRCTMZMap3KvsdsZ0zN5jpfrZec2N2PGMHHFND7Z+wDV8zQbS4+n9EFNpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJdQWoO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA9606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJdQWoO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD541F0089F;
	Sat,  7 Nov 2026 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047625;
	bh=u4atQQg3s6WzRNzGY4nczJl7wB1smd47eqgk2dbMoJs=;
	h=From:To:Cc:Subject:Date;
	b=lJdQWoO4Ts7jHLKQ4YCAq2j43u2t0C68swReWhqK4FBvUy+2xFQO6+A0YPAxQvhJB
	 Gr8kUS/k4iSG0TeZeE1AQ29rHxgo7zGYVX7vhjIgjNrKc+cxwKYmoTF7Ap6IBPqBbI
	 qhbXvylaxrTQ5fYtDeaFYbCZ5D2WTHhZMfgvZRQf2yyPq58zO1vwHMZoJS4plPfT18
	 +IUbKTgKsFHHVEEd4WVqOfL4jLj8fiTHArz8oOZh9wdGpSZorfRKESFqIDkMokbsLO
	 rbyF2NdtFrZUWvDnwbxgeyKR+fnL7Rsb4yqF+lT6XxOKf6luAhzLxYyiCT17QBbllW
	 7y0rAoT4w4P8w==
From: Sasha Levin <sashal@kernel.org>
To: gvozd188@mail.ru,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:44 -0500
Message-ID: <20261107053344-failed-6.6-2c88c2dc1852@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2c88c2dc18528489b403fe95741f5731e292f7ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053344-failed-6.6-2c88c2dc1852@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




