Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814510;
	b=RxlW3RHmnwk/2QaIVwPY7hv/tbT4oPGycjy6y+agDHdfHN9n7uiC2MMf7Ow2WC+Pwd8h
	 luSC5awpESlq5S7SZcMrVd5Bqe/r8rdGCC0WUAHhE2oRoJSE5tpvfbfjE3gAfMkhu457l
	 uzUxThejRHZ3zVFoccviYFKTK35b9OVexEsz9dQFLEiEPeEipnqWckFrroW/x7N6iM13H
	 m+7pBXemmnLikKiP+qm1v3z39kQ18CLqK3ORDUSvbhBIbz0778+ysrd0MZwSCLaDpxTow
	 L52cnbuT++MK7kQx0RVJ6gAhSUrlqgRc5Xw5zfymBHM2nK2A+M5kFoY1gaRRD2qBixQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814510;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=neZ0CkKwQ/2yeD6Nrvi7PA3GDatnVpikIt+8B1tdahk=;
	b=KhY1K0PGvBuqMYWeZ1v+2tilE3KDdeusv9hWjLkSOI0VbjCEDyb9RRTiSa0C8v0Ws54z
	 OEQEqHNvx4cSqed7RNIfbc6D0KD4IcRS1zfZKA2wrPOcY31Uq/Wqi0gdRzJPPCX4qILrk
	 mlpJ6qyTM0p0mgHf+qQvEiVeMAjx5ZzQI/TuM2mAZqXPnBjtVwck1VErCx/FH5ZQ+xIXF
	 qYqh0btMdZ5kdRurKGFaEp7vPsH6WXBS2Nhq679Jokftbc3D/B6dBJX4E0qg+l89krUTs
	 9BghPZBFNKSjMAbURnqGofsOjOqB6VrA3m1YOR2BePwFUVK533qmRCJEA3bxOcXGPCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WL60KrG+;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42AE606A339;
	Wed,  4 Nov 2026 17:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42AE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WL60KrG+
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A12C1BB2;
	Wed,  4 Nov 2026 09:48:26 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039A43F673;
	Wed,  4 Nov 2026 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793814509; bh=GBDJobgrm/pgWodkC81bCrshlnHYVkpp4Pmf0qL2HDs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WL60KrG+MYMC4MKc8kLkqfOd/LYA5sklU/TVkDqgrabvIdYmRCujWk7lzW0zzKGG0
	 AxHDVzseqtn/Q07K49cHAlxa5aZBTOW1yabSIRJ4B5LAfDSaiWwIZlQDoI7DOZAMBU
	 iR8BIi6A7uGjawejnPAxbe57rynrtr/lVzoRSqMY=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Date: Wed, 04 Nov 2026 17:47:59 +0000
Subject: [PATCH v2 05/10] irqchip/gic-v5: Use linear DT and ITT when L2
 covers all IDs
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
Message-Id: <20261104-host_gicv5_fixes-v2-5-e47ad20ea3c8@arm.com>
References: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
In-Reply-To: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
To: Marc Zyngier <maz@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Timothy Hayes <timothy.hayes@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Bischoff <sascha.bischoff@arm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The DT and ITT level selector incorrectly chooses a two-level table
when the selected L2 table has exactly enough entries to cover the
full ID space. There are no L1 index bits in this case. ITT allocation
correctly rejects the layout and device registration fails; the DT
path instead allocates an unnecessary one-entry L1 table.

Select a linear DT or ITT when the L2 width equals the ID width.

Fixes: 57d72196dfc85 ("irqchip/gic-v5: Add GICv5 ITS support")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 drivers/irqchip/irq-gic-v5-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 6d98f3dbe34b6..866c238f08dfe 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -337,7 +337,7 @@ static bool gicv5_its_l2sz_two_level(bool devtab, u32 its_idr1, u8 id_bits, u8 *
 
 	l2_bits = gicv5_its_l2sz_to_l2_bits(l2_sz);
 
-	if (l2_bits > id_bits)
+	if (l2_bits >= id_bits)
 		return false;
 
 	*sz = l2_sz;

-- 
2.34.1

