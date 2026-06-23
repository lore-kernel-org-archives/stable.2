Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6A2797AC;
	Tue, 23 Jun 2026 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200340; cv=none; b=Pb8PSyzj0ErLj6ODENJVJwE75/7ZZ60vlCuIDwCgE88REVKQPtz6LAntSEosCDw0IDkyhN8wx4pYMsoGAZeT48b3qTf9auzJmIt6nmv3xlBYD4EGXXX5LzsZjrzR7SB5B7n5w5OuWMSY2nz21iWciU8xEbJVAkOyuZ3P2qkBI7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200340; c=relaxed/simple;
	bh=ZJppr6AfKSXHQ9GWfWV/WF6uJeCLhNxDezLnul6nu5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atfE3p8QXcQNjkwJSwUNuTD7EfIIVLkO7n5vffWwNS+RGk1WcsllWUBt6mIOJK7UTkMlXl31K9sPkcEdBFYSxN6f1sdMmsCVEVFKD6zpiL7jdSDq6rAEy2rbysZ4S+onrOtEgkOl1g/NNZpQO7YunTI5DOJjFhm71CtGtT+ZwdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j/J1/Z3v; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j/J1/Z3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cz
	wcxy20z7HdHob/DRitDJw7LqO+2Wxqq+k78T1yRIs=; b=j/J1/Z3v2dad4X8JkO
	zT5cvcYG/SQYIs6SKVpYOXZtxX7mEN2lbEQN/HT7ighVvJBW4VB0+ZyS3322xNvg
	yRCJ3U6zx7DRtyfTNScXKtvG19gIjqoOm29UQg0bV9MZe4K2w3JmHaS0juJi4sxj
	TIhPxbL8i2MW5DK/9LncjBeew=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3LCvJNzpqF4UrFA--.25662S2;
	Tue, 23 Jun 2026 15:37:47 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: anup@brainfault.org,
	tglx@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	rafael.j.wysocki@intel.com,
	sunilvl@ventanamicro.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/irq-riscv-imsic-early: Fix fwnode leak on state setup failure
Date: Tue, 23 Jun 2026 15:37:44 +0800
Message-Id: <20260623073744.2009137-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3LCvJNzpqF4UrFA--.25662S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruw4rKFy8tFWDurWDGr13twb_yoW8Jr1kpr
	45Jas09r15A3W8Xr4Utw18uFWrJryDCrZrKay8twnxXr45tFWkJFWDZFyfu3WDJrWfWa1a
	9F4rtaykZF1DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pidWrJUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxgspl2o6N8theAAA3G

imsic_early_acpi_init() allocates a firmware node with
irq_domain_alloc_named_fwnode() before setting up the
IMSIC state. If imsic_setup_state() fails, the function
returns without freeing the allocated fwnode.

Free the fwnode and clear the global pointer on this
error path, matching the cleanup already done when
imsic_early_probe() fails.

Fixes: fbe826b1c106 ("irqchip/riscv-imsic: Add ACPI support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index a7a1852b548c..b7cbfee3aeb2 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -272,6 +272,8 @@ static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
 	rc = imsic_setup_state(imsic_acpi_fwnode, imsic);
 	if (rc) {
 		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
+		irq_domain_free_fwnode(imsic_acpi_fwnode);
+		imsic_acpi_fwnode = NULL;
 		return rc;
 	}
 
-- 
2.25.1

