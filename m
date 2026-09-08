Received: from mta1.migadu.com (out-134.mta1.migadu.com [95.215.58.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01505476D1
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877614; cv=none; b=sNDFQlqves2UFbvlv5ilmuoWWw3Nyw+X9Om/rJtw91s5ySPJEpXTgNe1mu+7bOtEAonEWtHvLg+H5ePpS81GuJZ+z4rQeR29N5mkbv9Gi94ILKd9qx8dcvOkx/OJfzlksp3+6pm3jW2vLsJ0s7FanTE/EftHUe5UYC15lk55lbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877614; c=relaxed/simple;
	bh=nBNi3rr/ynuXU4SgyyxAlr6fIfq350MdVspuBNckMOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wf4YnWKckTXzzEjY0skgBoz1oULNo4Lps0dRwyZVsucJTMRjDvadGAHeAe3yPRioJU/RtvHNi2+WQyjzF0VWTfeYxFPuugjiJl+JJf0yZnT9OUqLNv35VmWL3i8OjFp9oNCyWfeVfqa7Wn80bs2spnE2WgwAyH2KaLrfOLbRelE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e0W48CzJ; arc=none smtp.client-ip=95.215.58.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e0W48CzJ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nBNi3rr/ynuXU4SgyyxAlr6fIfq350MdVspuBNckMOI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788877595; v=1; x=1789482395;
 b=e0W48CzJU7EbNKzAtEbpGqNrB/IaIf24kcvNpIfG/+D1XnKnK3L99QVaWHUgKL0J6QiFr839
 aMEC5xObauclnZnxySDjg2QaeFznJKE11bXCiP0K+bL1LbtuZz6uqy+/VeIOzjfFKME3QtcIf2Y
 RShliwTu8FVfJ7dM1Bc5ZirA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7cbc54a65df9e3cc;
	Tue, 08 Sep 2026 14:26:35 +0000
X-Mizu-Trace-ID: 7cbc54a65df9e3cc
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
Subject: [PATCH 3/3] irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
Date: Tue,  8 Sep 2026 15:26:32 +0100
Message-Id: <20260908142632.2795308-4-fuad.tabba@linux.dev>
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

its_vpe_teardown() frees vpt_page without clearing it, so its
vpt_page == NULL guard only holds the first time it runs on a vPE.
struct its_vpe outlives a failed KVM_DEV_ARM_VGIC_CTRL_INIT, so a retry
that fails again frees the pending table and the vPE ID a second time.

Fixes: 325ff3e78c64c ("irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domain_alloc()")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 drivers/irqchip/irq-gic-v3-its.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 81a96149f9154..f5d89e829c168 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4599,6 +4599,7 @@ static void its_vpe_teardown(struct its_vpe *vpe)
 	its_vpe_db_proxy_unmap(vpe);
 	its_vpe_id_free(vpe->vpe_id);
 	its_free_pending_table(vpe->vpt_page);
+	vpe->vpt_page = NULL;
 }
 
 static void its_vpe_irq_domain_free(struct irq_domain *domain,
-- 
2.39.5

