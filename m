Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626440;
	b=jSrBXGFdfZ4wui3xwkzuKKbEuxv4O91/jg2b3gwBxItqsnuf3wvXODh7pKZCKGNO9+vZ
	 pvGQuJnbPF8LgRs3F84+UiZTY8apQSJ/ftYn/jWmi15MgoKSHhjoTv1yxY31n6OVeTKu2
	 dQp+llkZ5CpinaxVuG+LwEHIXpLcOUMWy+XA83JKDTeBanBqnox/8vieabe/nYaapxitc
	 CXhMdUmuu191V5tx/xX1BEtldSc6qejRuFJFeoXJ8uJbpV4VlGC1TamU2BHtjSKbBwrId
	 3cRizgC6Gu9RKMIn3ts43xGENEVM6e9tVdlICkqMYZeQBbALp3RVXr/J8NblyR987PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626440;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=3RRTjdcKKSIbRizT4XTN1LUL2BEmwDT8TLX5Ln0/2cA=;
	b=dblyL2gTY5iKBNh6n/31qcTr6ruEt3H9nGSoHjBCnbkotHdDYGWlHOrmR1KAAM0Y1Cbu
	 2GibOpQXeE+7Ja5ju+3DB9xbrbgU8SmOCpSAyFOmj2RibICS5NDp62xxr4BsmIPz3sJhQ
	 R1L9RU3qbqizuod47d8DqyZadzAtXCgDGLFGcH4VOFfDkHwHeEyCuxHVRv1PBlsJe/yLI
	 rBBf6OKAAVvU2q/Q5w0n/ZiEDENvQOUG9uXissvNig/KvlfFXqrONT2PgQDaIspkDnoU0
	 Yahpeyizav3GG84S90G7PJ7fsMOEiV8KYQJg+81Xjl0/24NigXRAGCGLvOYwZ5VkeIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p3lhb4EH;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEFE606A324;
	Mon,  2 Nov 2026 13:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CEFE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p3lhb4EH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C1C91595;
	Mon,  2 Nov 2026 05:33:55 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95B513F632;
	Mon,  2 Nov 2026 05:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793626438; bh=ty+YvfFlBIL70X7iGAg7g9ZH+ueSEa+D2C0x4sJ4+60=;
	h=From:Subject:Date:To:Cc:From;
	b=p3lhb4EH70UiHyExePImKptARY+F9jF9N52LNr1gKFdcIEblXoFjtVoEh8JUH+ffL
	 D3c87E+SVwrVLqjb7sYmzYFB5ZT97jvQihbyofcsIH6KSn/5HpwWehiqEZAO+mdsB9
	 ODjgAe0vVCfI8MD97TxnCiB8oREz1fAZn+ZzPK7k=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Subject: [PATCH 00/10] irqchip/gic-v5: Fix misc IRS and ITS host driver
 issues
Date: Mon, 02 Nov 2026 13:32:53 +0000
Message-Id: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWR6GoC/yXMUQqDMBCE4avIPjdgllrQq0iRNE6T9UFLVkUQ7
 26sjx/DPzspkkCpKXZKWEVlGjPsoyAf3RhgpM8mLvllbckmTjp3QfxadV/ZoMYCcFz3DPeknP0
 S/kOu2vdtXT4D/Hz90HGcoER+x3QAAAA=
X-Change-ID: 20261102-host_gicv5_fixes-1eeea29d2ea4
To: Marc Zyngier <maz@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Timothy Hayes <timothy.hayes@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Bischoff <sascha.bischoff@arm.com>, stable@vger.kernel.org, 
 Sashiko AI <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

This series fixes issues in the GICv5 host IRS and ITS drivers.

The ITS invalidation serialisation fix addresses Sashiko's report of a
race between event and device invalidation commands [1]. The other
patches correct IRS allocation and routing behaviour, serialise IRS
synchronisation, and fix ITS L1/L2 table selection, cache maintenance,
ACPI coherency handling, and resource cleanup.

The IRS changes:
* Reject allocation of an SPI without an IRS, preventing a null-pointer
  dereference, and warn about low-quality firmware.
* Only program IRS_PE_CR0.DPS when 1-of-N routing is supported as this field
  is RES0, otherwise.
* Serialise IRS synchronisation requests, as the IRS ignores a request while
  an earlier one is still active.

The ITS changes:
* Serialise event and device cache invalidations because both use the ITS's
  shared DIDR register, so concurrent writes are a bad idea!
* Select linear device and interrupt translation tables when one L2
  table covers the full ID space. Currently, this selects the wrong
  path, then the L1 table code rejects the attempt to create the
  table.
* Check the ACPI noncoherent flag with ACPI, rather than checking the
  DT's property.
* Correct cache-maintenance sizing after limiting the DeviceID width.
* Invalidate the device cache before freeing an ITT.
* Use firmware-node names in initialisation warnings.
* Release the reserved MMIO region if DT-based ITS initialisation fails.

I've CC'd stable for the IRS/ITS locking fixes, the ITS table alloc
issue, and the ACPI coherency fix, as these are the most important
changes to backport.

The series is based on v7.4-rc1. Thanks for taking a look!

Sascha

[1] https://sashiko.dev/#/patchset/20261016155741.979985-1-sascha.bischoff@arm.com?part=11

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
Sascha Bischoff (10):
      irqchip/gic-v5: Reject SPIs not backed by an IRS
      irqchip/gic-v5: Only set IRS DPS when 1ofN routing is supported
      irqchip/gic-v5: Serialise IRS synchronisation requests
      irqchip/gic-v5: Serialise ITS invalidation commands
      irqchip/gic-v5: Use linear DT and ITT when L2 covers all IDs
      irqchip/gic-v5: Honour ACPI ITS noncoherent flag
      irqchip/gic-v5: Use firmware node name in ITS warning
      irqchip/gic-v5: Invalidate ITS device cache before freeing ITT
      irqchip/gic-v5: Clean the allocated linear device table size
      irqchip/gic-v5: Release ITS MMIO region on DT probe failure

 drivers/irqchip/irq-gic-v5-irs.c   | 22 +++++++++++++++-------
 drivers/irqchip/irq-gic-v5-its.c   | 29 ++++++++++++++++++++++++-----
 drivers/irqchip/irq-gic-v5.c       |  9 +++++++++
 include/linux/irqchip/arm-gic-v5.h |  1 +
 4 files changed, 49 insertions(+), 12 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-host_gicv5_fixes-1eeea29d2ea4

Best regards,
--  
Sascha Bischoff <sascha.bischoff@arm.com>

