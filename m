Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626447;
	b=ZQW+I7QOJIUjpBx9tIl/qDyE2MWNqb7mk9iaSF0MLb1qNGvu3rklQsBC6lLnM+nG3U/2
	 xxJwIrx9vuFpIVWfcLFzI5Nc4HI4C7rkG3APiAFF/HTCQDpw5rfpbVbogMish2ubC+6g+
	 PYAjF7/paIoRy/mIm0h2KMuIHlioWDrOrfC+jD8jbvgoVAvhIraTyqe5Ygl6JUPPtc2Yo
	 lPMugZivgVjG48M8htRXU0SlWQ3Zg42yg4svQ4GhtPi6mWcOBNLfZVf/G04Xo2v7Kv8bo
	 P4fJ6kypH1otPMTCOZstn9f+yRT9Ek8SFhNe5RgjaEKkiIpZHDHTWhtT3KqgtyDr7bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626447;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=HdE8s/oDZnvA9c/rDs3AdCW8i2SXAODW6/GcFo46Vaw=;
	b=VC/X47ucyjMDlxlYHjDKD/0F747LD0c9eB/764deUX+SqYFa2WJw6efjn3rrBgqKL08L
	 /W/1Q6zKi6PcZOae//UHpJPo9UgXrils70g7c+ttuHOrAN7VqROeTtzXfIyTLrRc/XfjB
	 6WScZWIhN6mES25TBDyahSvsLFwOhHknCZsdZTHCZqirOWSwfWvKfThm7z8IuZZSm4Jwi
	 X5nGEQWh5t4U/n5+i08OsPjnM42H+eTjfUWTHczw1nvKgEhD+4czVFO6N1Vm1A/5RY7Ei
	 4KEGAg2+9g7e6oajv73wq80wi1xDiN4G/XryZ4gBdTKWw7XjS6wgY453hc0KNkf7jfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bK8pSNVx;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990960A2604;
	Mon,  2 Nov 2026 13:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1990960A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bK8pSNVx
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A5AD19F0;
	Mon,  2 Nov 2026 05:34:03 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ABDF3F632;
	Mon,  2 Nov 2026 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793626446; bh=1l84DnyE29UIZqaXwocfj0eDW62EnczijBTcbjuB21g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bK8pSNVxgrbvVGlvdtQpUQSUgrQdlqngjBVIHSN4i5sIxM0D2TlVckxHOdpJmz0/H
	 Cc+310cUynRQnplmCusETOhwi3QI2XECO2cPXpYdyl9OYnTebBTB2TOy7bLfWmXKKn
	 M6gu0LgHNJTZHCX9AByvObMrNW1RMveHeCIMaiKQ=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Date: Mon, 02 Nov 2026 13:32:58 +0000
Subject: [PATCH 05/10] irqchip/gic-v5: Use linear DT and ITT when L2 covers
 all IDs
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
Message-Id: <20261102-host_gicv5_fixes-v1-5-743b61626fc5@arm.com>
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
In-Reply-To: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
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

