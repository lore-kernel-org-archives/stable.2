Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8739BFF8;
	Fri, 26 Jun 2026 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489050; cv=none; b=CW4YJjzfnoZUOaD7ptN+S+xVBqQ6nt7Snz8H743Pbhv0Qr+C4BZc/JeKW1D+FpBfkDCyVcDe9FSzzL+WX5Bk9tUT5XM9GfznSwV6qsY4rdbAu8hOP8YNwKKGsqaKYJKcNq7nPcMTvLqSIqg55ROkiAxUvx54NhKeULq4cKqsmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489050; c=relaxed/simple;
	bh=rCNP1yWutDLr4XMGZPVW4ZAm2wgPDvVY9z78kY7RitE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=czy4ewA9JJ6LbLqsl60PH4Qa3Dc0F18da54RACYYIXBNPeL+jIVWMZch8h76XDPfb41sEYawn6fzV/Y9zTqjotYpRTUwunFSgvyArCCZAfgGHpvi/p7dC4Bm3DHzooapknOmXkFa4YZGE+VYcvXY5ozIvm2LOBK/CYTcq7FD/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAXsMjSnz5qlO1sAw--.17012S2;
	Fri, 26 Jun 2026 23:50:44 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: PCI: pci_iov_remove_virtfn: fix unmatched pci_dev_put for PF device
Date: Fri, 26 Jun 2026 23:50:42 +0800
Message-Id: <20260626155042.53862-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXsMjSnz5qlO1sAw--.17012S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF17Cw47Jw15KF1kWrWfZrb_yoWDJrXE93
	WUuF97Xw48Aw4DGa43KFWfZr9Fk3WYqay0ka18tF9akryavrs8XryUZr93WrZ8W3yUGFyU
	Zw1q9r4akrWa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUbSdgJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEKA2o+ids5DQAAs2

In pci_iov_remove_virtfn(), the function calls pci_dev_put(dev) on the PF
  device at the end, but never acquired a reference to it via
  pci_dev_get(). The function parameter dev is passed by the caller who
  manages the reference. This unbalanced pci_dev_put causes a refcount
  underflow, potentially leading to premature PF device release or
  use-after-free.

Remove the spurious pci_dev_put(dev) call.

Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/iov.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..24a4fb3cd042 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -426,7 +426,6 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 
 	/* balance pci_get_domain_bus_and_slot() */
 	pci_dev_put(virtfn);
-	pci_dev_put(dev);
 }
 
 static ssize_t sriov_totalvfs_show(struct device *dev,
-- 
2.39.5 (Apple Git-154)

