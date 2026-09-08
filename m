Received: from mta0.migadu.com (out-120.mta0.migadu.com [91.218.175.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66926A1AC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877601; cv=none; b=r7XC7qim6YbfHGORTh5TfsJw8aaq+qDJwwKkEZ6gR2TPW4tCOquM/GVFJPt5pE9QcAqua2hM43AAMg3tviyGP+PrLSn/8qx8KbPfPRmREtnV1JOKijnVJMJFbC2U6Sh/72xB01HTtGrO5gMdbelWr/qT5sQQ3y7+CZCKilaiRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877601; c=relaxed/simple;
	bh=s9TT0fZk57NAYbdQgPZkg4s8vZfT60FtoXTyRRE+hbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=STglEy2MSI7gpI/FmaE4voszI1SPRz6Cs7kll0y4teV5Tg1ZYbK7y56zNW0woN9De6eRk9yL9xAtAsPyiz8oKICtdWJflEMRSI/fyLw5VNkkckGUpCbmO7JpmDw+Qw/A+yrLXW9IFHsFDAIiifoNaIsApi0lD3Sd76D8Vz6ywQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oUf2b2Me; arc=none smtp.client-ip=91.218.175.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oUf2b2Me"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s9TT0fZk57NAYbdQgPZkg4s8vZfT60FtoXTyRRE+hbY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788877594; v=1; x=1789482394;
 b=oUf2b2Me5yQ1AkdLjcXZPsY7ezdSRSf+FZqsh6OeISavuE1DxUeM4PkWAKetZy6F/KgvOdTk
 7YjM/Zm4Oj25/F61ESN1YtuOf0/UIxjFagO+BoPqwcXGe2jsfoNh+pG3w11trKG/0qEeEuiFq4r
 KaIfZarT0vQOs2O8ZK+a/KCU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 14221e000fbbf8e3;
	Tue, 08 Sep 2026 14:26:34 +0000
X-Mizu-Trace-ID: 14221e000fbbf8e3
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Radu Rendec <radu@rendec.net>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] irqchip/gic-v3: Release the partition node in gic_irq_get_fwspec_info()
Date: Tue,  8 Sep 2026 15:26:30 +0100
Message-Id: <20260908142632.2795308-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260908142632.2795308-1-fuad.tabba@linux.dev>
References: <20260908142632.2795308-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gic_irq_get_fwspec_info() never puts the node it takes from
of_find_node_by_phandle(), so every lookup from a four-cell PPI or EPPI
specifier naming a partition leaks one.

The node is only used for the comparison against gic_data.parts[], and
the mask returned points into gic_data, so it can go out of scope with
the lookup.

Fixes: 68905ea65ceff ("irqchip/gic-v3: Add FW info retrieval support")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 drivers/irqchip/irq-gic-v3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6e1fa5b247fc4..b0142b0a93fa4 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1728,8 +1728,6 @@ static int gic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_
 
 	/* If the specifier provides an affinity, use it */
 	if (fwspec->param_count == 4 && fwspec->param[3]) {
-		struct fwnode_handle *fw;
-
 		switch (fwspec->param[0]) {
 		case 1:			/* PPI */
 		case 3:			/* EPPI */
@@ -1738,7 +1736,10 @@ static int gic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_
 			return 0;
 		}
 
-		fw = of_fwnode_handle(of_find_node_by_phandle(fwspec->param[3]));
+		struct device_node *np __free(device_node) =
+			of_find_node_by_phandle(fwspec->param[3]);
+		struct fwnode_handle *fw = of_fwnode_handle(np);
+
 		if (!fw)
 			return -ENOENT;
 
-- 
2.39.5

