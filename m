Received: from mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE531F989
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877601; cv=none; b=bvVwxq9bBU1e+YRiPHgiEFqHwPaRI5XrslTvco0QF3I2DcZ3lAGSYV72k+nM4ycfPWe6+rSZPwTiJPLH9nguxVOntHohMRnkHN47x+Nd3nj+eNZUSi2bJuLZkHOBDdUd3NYJtf4b6bzjvI+S96JsfVKCiw560aA9lpHXsy97JPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877601; c=relaxed/simple;
	bh=+zAEpg0bzrJlzowQfLEjzSYuRg3JQjAXqFWQW+aQjcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXCWfalho35oSdYr4F5uIUJxq3mz6BFdapvIAq7fwxcOxFnKQpTNWM3hPlzGxwCgX+TsyAagbq3aHjCDa9XEuFNnRjJSvAh/G2WhxLoKQXkoUIjilFUDBMVTkDUc/ZgiBc8rpAzUKNXQ4KnbBQw3Gwlq/9AchAnUL4ilJ22WIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QcQk897C; arc=none smtp.client-ip=95.215.58.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QcQk897C"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+zAEpg0bzrJlzowQfLEjzSYuRg3JQjAXqFWQW+aQjcA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788877593; v=1; x=1789482393;
 b=QcQk897CIjxDalMXDHecXXj+jH8HtF0rW+5cYWyGn2vJLJfhH6s3d+VjvR7bALD0mNJpKB4H
 s8D4O+6S+PEamLJSWAAqpOHFPyU6eIB8EXSMtIltcWYN4HYxSgI7ZYQmvY1Cm0tvxmY7maWRuFY
 4K6OYe7jGVZMbdy2Hnf6qltI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6713a1d5765c73ea;
	Tue, 08 Sep 2026 14:26:33 +0000
X-Mizu-Trace-ID: 6713a1d5765c73ea
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
Subject: [PATCH 0/3] irqchip/gic-v3: Lifetime and range fixes in the GICv3 and ITS drivers
Date: Tue,  8 Sep 2026 15:26:29 +0100
Message-Id: <20260908142632.2795308-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

Three fixes to the GICv3 and ITS drivers, from reviewing the GIC series
floating around and chasing down Sashiko's reports.

The first releases the partition node that gic_irq_get_fwspec_info()
takes from of_find_node_by_phandle() and never puts. Sashiko raised it
on an of/irq patch of mine, and I said a fix was forthcoming [1].

The second widens the per-device MSI clamp, which truncates to zero when
GITS_TYPER.ID_bits is at its maximum and then denies every MSI on that
ITS. I couldn't find an implementation that reports that maximum, so
this is one value at the edge rather than something anyone is hitting.
It carries Cc: stable because the commit it fixes was itself
backported, so drop the tag if you'd rather.

The third clears vpt_page once its_vpe_teardown() has freed it, so the
NULL guard holds if teardown runs again on the same vPE.

Based on Linux 7.3-rc2 (df2908090cda3).

Cheers,
/fuad

[1] https://lore.kernel.org/all/CA+EHjTx7eP_30vP47=UFk_wMAut-2uf+2DF-MZqn2SLE_k-8qg@mail.gmail.com/

Fuad Tabba (3):
  irqchip/gic-v3: Release the partition node in
    gic_irq_get_fwspec_info()
  irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32
  irqchip/gic-v3-its: Clear vpt_page after freeing the pending table

 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 drivers/irqchip/irq-gic-v3.c     | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.39.5

