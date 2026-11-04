Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814502;
	b=g+xN2z7lgSCJtIuee5CUEDVzHDnEwowJ7kmWZsdShd3pPhfu6XDmqV9R9Swan72pp5AK
	 N8oeYM02335uOF8Ttza1ZYTHhzANzN32Srl9cORINl5jRmQNae86DvbjyNIunm9Ves/hB
	 YfT5Vbtgwj17eKH+m86Jzza7Afp3F/nlSK3qgDhvccTRSkAItjvDE8mEy8Ewe/L9/oUHw
	 FkPBek3xU6GZGfsTXvkhk3aXdElrFTfbYfZ2cw6DtQh9jJXwuye134m1PzagB1mIFbllu
	 TlvbJj6+iDeR3Xpc15rit7/WU6n3q82ahMglZydUZqJk9CrwhS3/gXyV7znSH2OgJ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814502;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=7yWlCk6T1JWk7Y87GbgVao/WZwSgW7q+kEJYjVA6XlM=;
	b=eqDC2ms+ZgGFPsLVH2D+P/cY0MLHZAv+biV/GDvA5yvvuIo9rGdQ8cc22n8auJ4hKVRe
	 8oS7ZxE6IKctZNjNtZuyo7NTlnH+J4zJV17MKi/j0flOq5YIcZu1J6OsAlcamYiH36znK
	 dXv0lV1/O3Dzh39dXeYGZjNBHox5Uu8pwY9q1RXTCkvRB6xLm/GK5ym8TIFLJcY2d5lKl
	 r1xn7EJJ4lZTwcQZV5rHlQCHCJrfu+s9HMXovVizKm+K0TF2+OCjipYIC0hOsxR9IZiPY
	 YLzfoLU8bbv22QAe/0l8kGBuNFVUaxUZvB1KMPXfUlr9XOoNl74qzdDJjezZFd2rneA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=r95KcpB8;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01B606A330;
	Wed,  4 Nov 2026 17:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF01B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=r95KcpB8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE91F1BB2;
	Wed,  4 Nov 2026 09:48:17 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C9E13F673;
	Wed,  4 Nov 2026 09:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793814501; bh=oASbG9IPRCzTNzC8UolpOCHZzz0087A7XJVv/tKS9jE=;
	h=From:Subject:Date:To:Cc:From;
	b=r95KcpB85plr8HqeMRPuE6sErFNS9LYMVz8+ERXlqXPBe45n+1ZIXcqvI1HUifO4w
	 oxzHPbHlNTlhrr0bVfoEYS+1az3US3k6ZY8jUKFFJo1UfQx3h4NWYSejoDIPNyS/z5
	 aGA3Czu+nCliBUIIKFP7r3qosmiBcsJu85o3/NbE=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Subject: [PATCH v2 00/10] irqchip/gic-v5: Fix misc IRS and ITS host driver
 issues
Date: Wed, 04 Nov 2026 17:47:54 +0000
Message-Id: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
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
X-B4-Tracking: v=1; b=H4sIAMpv62oC/32NwQ6CMBBEf4Xs2Rq6Qo2e/A9DSCkLrAnUdLHRE
 P7dgnePLzNvZgGhwCRwzRYIFFnYTwnwkIEb7NST4jYxYI5G6xzV4GWue3axrDt+kyhNRBYvLZI
 tIGnPQHuQrHv1Y3k1D3LztrM1BpbZh8/+GfXW+zMftcrVuTg1Rhs0nStvNoxH50eo1nX9AgH2B
 1fAAAAA
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
Changes in v2:
- Explained why IRS synchronisation uses a raw spinlock in the KVM
  affinity path.
- Clarified the ITS invalidation race and described the KVM forwarding
  path.
- Reworked to calculate the device-table size after capping the
  DeviceID width.
- Reordered local declarations in the ITS probe function to be in
  reverse fir tree order.
- Added Acked-by tags.
- Link to v1: https://patch.msgid.link/20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com

To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>
To: Sascha Bischoff <sascha.bischoff@arm.com>
To: Timothy Hayes <timothy.hayes@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Jonathan Cameron <jic23@kernel.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

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
 drivers/irqchip/irq-gic-v5-its.c   | 34 ++++++++++++++++++++++++++--------
 drivers/irqchip/irq-gic-v5.c       |  9 +++++++++
 include/linux/irqchip/arm-gic-v5.h |  1 +
 4 files changed, 51 insertions(+), 15 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-host_gicv5_fixes-1eeea29d2ea4

Best regards,
--  
Sascha Bischoff <sascha.bischoff@arm.com>

