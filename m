Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324A4D98FF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814073; cv=none; b=EuJ+V9RgnrxfRSJggbH9LBwYWTjY79RDofMpuhyMpRQ8gyS8vWRt/whlVMpMOCDmXnFXLp2YPFHJ5PrY7GswnHxqubHEKKE4C/+lL6uPU8lNgcSmGttp04mznGqjjKtT1Vm/bMBRjYsnFnUTwLXBkbLykTvQgduhoK4wcS5x8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814073; c=relaxed/simple;
	bh=hQphTun0YKe7wD1TxM+XfRHZxJ9Emr5qD5+3FpGqSfM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WFHpy9xN3db7pFmj1GCoL8oKa+i2oinzW61FEFI5YSzMEM+U7FP+oJhpe/thjRFGfdiz14uqSY8Z/HnK8yEBznZFPXMePm9sUTm+HGnK2yc2n2Cw5a7fSWmGdpMIw2XWT/C+MWDw38xrcUHbJuCz4JtFhnhw/Ypu4TVhbp+GLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ajaOA+Tp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ajaOA+Tp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1FC721A11AB;
	Thu, 23 Jul 2026 13:41:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7FF4602B8;
	Thu, 23 Jul 2026 13:41:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8450011C10CEE;
	Thu, 23 Jul 2026 15:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784814065; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=9Q185pF0DA/CFN6GHNn6AhfxIhuntfnhwSs6ZtpfhwU=;
	b=ajaOA+TpwOeT+/XVAyCAoZx5FLcgWMgaRocWAZKT/k2mFm6Q7CBoeMbon6X6oh+yoFE/zH
	g2n5avmiYgHPHvzVCwMK8UtQgNoov4EJVMJoo+yhSmJg1WaG1junlh7tveQ+rMQM0RK5YC
	419rvydyNrzvgbyT+SviqfuXEbAGuuoqfYA3z7rDpl8iawpqRSqpr/OLR6k58Be3KnqxUI
	m9xbN9P0PT8xi5wFr0NiPwbhFvQ4oMDOZOaQxQOUWN9I12gSBNRe9UDNb0eRyykkovR2aV
	buawn7YmpzX61CeoOzwTE01w9N24RKP0Qr/1QmMA0dGEmntyWP9Rk9b/4SqD8Q==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 0/4] rawnand: pl35x: Implement mixed ECC
Date: Thu, 23 Jul 2026 15:41:00 +0200
Message-Id: <20260723-mix-ecc-v1-0-7361c3baeb07@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vdp9uwm0CBSXsVwKNtB91DQFg0J4
 d1t5PhNJv9OGUmRqTc7JXw16zIX1BdD8vTzA6yhmGxl2+pqHUfdGCLctOhEQgPnQeX9Sph0+5f
 uw+mE96cE13Ok0WewLDHq2pvJ3cYgHaQOQsNx/ADtSlmQiQAAAA==
X-Change-ID: 20260529-mix-ecc-46e8ccd4e9ae
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

This series addresses the PL353 errata "SLC ECC misses single error to
bit0 byte0 and fails to detect some double error cases" (see 721059 in
[1]).

The ECC HW engine is known to be broken on this chip, it fails to detect
some bitflips on reads.

This series implements a mixed-ECC where the HW engine is used on writes
and reads are done by software. To make it work, the software ECC has to
use the same layout for the ECC bits than the HW engine. Patches 1 & 2
add the PL35x ordering to the available orderings for soft ECC. Patches
3 & 4 make use of this ordering to implement the mixed-ECC for the PL353
controller.

Note that this series is based on top of nand/next.

[1]: https://developer.arm.com/documentation/rlnc000227/a

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (4):
      nand: hamming: Replace sm_order boolean with enum
      nand: hamming: Add support for the PL35x ECC bit ordering
      rawnand: base: Export nand_read_page_swecc
      rawnand: pl35x: Implement mixed ECC computing

 drivers/mtd/nand/ecc-sw-hamming.c            | 179 ++++++++++++++++++---------
 drivers/mtd/nand/raw/nand_base.c             |  11 +-
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 173 ++------------------------
 include/linux/mtd/nand-ecc-sw-hamming.h      |  20 ++-
 include/linux/mtd/rawnand.h                  |   7 +-
 5 files changed, 161 insertions(+), 229 deletions(-)
---
base-commit: f97bdc8ec1dc7b33781a702eeba55326c206be56
change-id: 20260529-mix-ecc-46e8ccd4e9ae

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>

