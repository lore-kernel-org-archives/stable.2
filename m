Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781188;
	b=FbHI/LhGwoJk/18MBATZc7nx7iH6If2+AiFYOZIqbfOPnA770NdC0e3uOx4vIQJ2MNa4
	 lqO3hd+VO1Z+29a6AtuxgoL8YDK98YdHU7on46MmCzc1XCxkTXpw54Z2cdBYOSqycbWFc
	 UK8uPst7mt7OW9SXDgtzxhW06fqCRRImMOaZwtrzEcEGDu3Ko8oHiHgj+Gv7hQ2tGS4+0
	 3HQcL3P2gcvdbyZs+etMaqsdZahMwfscyfq5kIzc8+yrcEKUzTKeQZl9tggPopt2vdLOW
	 fiEnyN83ur+A3qX/brhBLga8dxNhadmGd9OwWx1/v0tfoLXsmRQbnhx/HzJS9li2WOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781188;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ku14Tz46TuTtJ1EhMyeHXoEtmOlUZzn240TsfezwQUI=;
	b=mMG9IBUyvjJk9HL7L4fqlcvv7BZ2HfE0dZJDLp+tLeq0GB+v6g8LSI33LklCUlsw/Xi/
	 dFcgINsBCgJzVijmmdDDnSOXGpawJHKSKxQJCChrnEeDUQZpcVR5X0JpbocLpcLrUyDJp
	 d/amIa+1V0Z+aQ4GSB9go/HxRAIM6iWAqVADhTnbJqi7cu+auBv5jTYhbylreYnYAGnx5
	 SZ8h0jHuwuL+lV4RX0jul/dplsTs5Bj7Uu9L59R8o0nu7qRgCxy8Jksmb7aftYujw9Wm+
	 VyVD7ViVcMBmNmHAz38MV8hcbkUp9oYFhShmCR2ko+TocgIsP/aueZKJVKMC+lIx2+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xfxevGJZ;
	arc=none smtp.remote-ip=91.218.175.8
Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CC606A326
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7CC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xfxevGJZ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rOgSkdivV16y0OtLZahaCadDyr2dew92S4kqD2VOpo8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795781186; v=1; x=1796385986;
 b=xfxevGJZrsmswq0apadRjAM46BFCNeKzJOt267M0+p44fNyK5TyCyiOnaWPP6RFctaERxeWh
 DuEzI9RN5BEPqXJqb5fqvMrTcoLY56ak5n9baIBYb6lgz6q36BFziToyeetXpZSqzBIwb13NVfr
 TAuhHWRMLKdIYMJfOUhLYtr4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5640ad402cc0b5a6;
	Fri, 27 Nov 2026 12:06:26 +0000
X-Mizu-Trace-ID: 5640ad402cc0b5a6
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Radu Rendec <radu@rendec.net>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/5] irqchip/gic-v3-its: Align sub-page ITTs to 256 bytes
Date: Fri, 27 Nov 2026 12:06:21 +0000
Message-ID: <20261127120623.891129-4-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127120623.891129-1-fuad.tabba@linux.dev>
References: <20261127120623.891129-1-fuad.tabba@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e36d4165f0796 ("irqchip/gic-v3-its: Rely on genpool alignment")
dropped the ALIGN() of the ITT address in MAPD, on the premise that the
ITT pool returns 256-byte aligned blocks. However, the pool's minimum
allocation order is get_order(ITS_ITT_ALIGN), which is 0, so its
granule is a single byte. An ITT whose size is not a multiple of 256
leaves the next device's ITT misaligned. MAPD drops the low bits of its
address, so that device's ITEs land on the previous device's ITT.
QEMU's emulated ITS has 12-byte ITEs, so two devices with 32 vectors
each are enough to hit it.

Create the pool with a granule of ITS_ITT_ALIGN.

Fixes: e36d4165f0796 ("irqchip/gic-v3-its: Rely on genpool alignment")
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6932dd0a02c42..5756ffe4ec13e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5854,7 +5854,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	bool has_v4_1 = false;
 	int err;
 
-	itt_pool = gen_pool_create(get_order(ITS_ITT_ALIGN), -1);
+	itt_pool = gen_pool_create(ilog2(ITS_ITT_ALIGN), -1);
 	if (!itt_pool)
 		return -ENOMEM;
 
-- 
2.47.3

