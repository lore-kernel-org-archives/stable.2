Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CB514768
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752306; cv=none; b=VkZd71ZPFbdNeTABobDqetO4TYeug/VPJEyiSAbE+GE98rLUD2VQkJQPEpwsuX3+C4x5kY99KkgjAUPLVqq5l+oOcBXyAMZDqDnNjkjlKYdu6c/YJAPdo2heGQfEYoZc+62eNqT3gtPD6rchBefpja0DJpg0iPIbJnBP0xMuaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752306; c=relaxed/simple;
	bh=gyzu7hiJ3Qnl1lJv3yLmoKcTJ7DYT/6eEZnrdziKtHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gERho+CAsh/WeblTpYzH1gN0PatXnw5YNZHAs0at7T+G+llcoDskLFHBzOi9tww3g11PR6uU3w2xNDROQ7axYrjywxJuser+4bulIvmPhKL0vlAUYeP92Db6rrA7NFvfVtYUu2G4RWNGIy5c/h4KjVrMxIokv0zygeW3MzgFp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pq/mvND6; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pq/mvND6"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so1972197a91.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789752302; x=1790357102; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+kfPgEY96uE/H1ipyuvALA/uo1X/ydteu6QiwY353A=;
        b=Pq/mvND6DlrflQpBcuNad5p/op3caMU9JmIRjYQ9tqkQNQM7bBZc31WxZb47zo6c8c
         /RjvGU7UObK/LC2bF6sAigCAcrpeuYTaBcGU6+PwCZQJ5MJKdj6PClf0pUB+yOeF0FWH
         +T4uFHigBlKQJIVa3wUqUi7K7NfccEN15qDiSk0g0e3GROoxrpQo8N/TarEiCpFHm71V
         2kIaLCbEm762C5s71BB+2xJfj0A2fSJPm9lsccbWZchFk4UoJxE/+axNy6TPO9ac1PPN
         7LCQW2pd7/sxtlSvYEPCdJqKpTcWyScLnpHux3fE94RosSd8Of5kGhT+qfmHAFnnc3Z6
         nkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752302; x=1790357102;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+kfPgEY96uE/H1ipyuvALA/uo1X/ydteu6QiwY353A=;
        b=iXtRmjzx5jj5ms5Gs1x/PljmvPwHO2Hybs8HV6WdM+JbEQOiamJucoGe2qxTlHAAQM
         t+jIeJAHjR3SeZ1faWKNxCksIBNjKa/gwT/VTxdOcxexnJjV0wHhMKFXYW4VaZtyb4MM
         JW0dJAMnUbGoinCK0+jA0L2fYey7ULElOTWvM1J4wJOnT48AMhUkLYesIvVculUv8XKl
         Gam3RYERYhQSBQkaE+sZrU/RuWWsY2t5X7ZcNzVeSwDFRmruO/FcxSgFFFSSVr5VQHSv
         Ihl7lSPh2jFjUIJZAmgCRuwEfrMdDMMZr8lNitWdvfw0kioAMzFDeOQFdQb4sJMVy9EK
         6tAg==
X-Forwarded-Encrypted: i=1; AKwUvByQ9gZVx1oSzYBtS0P5rBxK0BKkuIOhoNbZ+8VlvwwPMrRM+JZ1i36atbHaJMWaeJYJH/zZ8Uw=@vger.kernel.org
X-Gm-Message-State: AFuF++k+5OjzFO62FsuBjnJMJN29onWJ4yXsS0vDMAPPboOk+V7IpB+v
	IrlOBRbR6ii64z+5E4+R7W+4A8QiEDKEX1gcne3JH4p1lJRLsNOy/1p+U5Ds+0dAm1qSZhJwxTc
	EmQWLCUFCYy2NHeoRqoZ1GXzdfHj0gRyRUA==
X-Received: from pjbin15.prod.google.com ([2002:a17:90b:438f:b0:39e:5e7e:fbe7])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:3f08:b0:39e:6a81:5a98 with SMTP id 98e67ed59e1d1-39e6a815e38mr670166a91.44.1789752301759;
 Fri, 18 Sep 2026 10:25:01 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:25:00 +0000
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260918-b4-fix-aer-memleaks-v4-2-f0a2c21ed1d1@google.com>
Subject: [PATCH v4 2/2] PCI/AER: Fix memory leak in aer_recover_work_func()
 when pci_dev is missing
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues
the entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

This is reachable whenever the device reported by firmware is not (or is
no longer) present in the PCI device tree, e.g. after hot-removal or when
firmware reports an error for a device the kernel never enumerated.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Cc: stable@vger.kernel.org
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b013b853b555..a6600801af6e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1366,14 +1366,13 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
 					   entry.domain, entry.bus,
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
-			continue;
-		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		else
+			pci_print_aer(pdev, entry.severity, entry.regs);
 
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
@@ -1385,13 +1384,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
-		pci_dev_put(pdev);
+		if (pdev) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+			pci_dev_put(pdev);
+		}
 	}
 }
 

-- 
2.55.0.1082.g2b9226bbc0-goog

