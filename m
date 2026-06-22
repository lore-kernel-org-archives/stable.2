Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2439D6FD;
	Mon, 22 Jun 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120721; cv=none; b=Oj82Li8f2zcZeWLx5vc0W37vPF42FSbwvXaBvEX6aScTJevhULp1YYr8m2JfKcBrljxmcFPv1UrE7Ka/vNhBmQf0RWffIIQUKtHAutcRQGLWmIm0UUnvKzVC+9BvML3gXHufUxMcXKM2gCg6KfRa/hrZ/ZZapMI7ntqfyje931Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120721; c=relaxed/simple;
	bh=FKc2SrzAap8kCeUfWLH+dp5oozb8HCbZwsYL/n8/vB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpiuQn+y7JF50zQT+ZMw57NM2EPer7TxmqMvoFud/340DvlGWd36mXnb/h3mClN/A6KaZ67ReA8dFvoCmfdrw5W3Qb2Vs99i4fzpJTlQbeGUu+Q8kNodoz9nwb8hm/vN/AxEpD4Fzmb+1WurHG5tvbdJ6gDDtJblDfGsvKtAeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lHoTu4bc; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lHoTu4bc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=F6
	43udD+I2EbhSBnHb9DPRMM81MefYnLwXaGGR11J2o=; b=lHoTu4bctzIY7g+7kk
	PlaVuHKba1/zlQmi03OECMd8EyABnjftK5W/kJGZO11I/ioPW11114O3M1Te6hXM
	ccRxQK5pFJ3s2eFPPhhykM0DuLdFIYeOy/0Mv3Q25oc4/FiyhpA2VIFEuk/jkZ4j
	kz1pWNH04e6fXaYM+qAmHfOc4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX6rr1ADlqtrcPDw--.54368S2;
	Mon, 22 Jun 2026 17:31:34 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: bhelgaas@google.com,
	aduyck@mirantis.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/IOV: Drop device reference on sriov_init() failure
Date: Mon, 22 Jun 2026 17:31:32 +0800
Message-Id: <20260622093132.910859-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCX6rr1ADlqtrcPDw--.54368S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF15ur4rCw48Ww43XF1fJFb_yoWfKFbE9w
	10yr97Aa1jkF1kKw1YkF1SvrWSk3WDXa92grW0ga4fGFy3Zr4vvry5Z395G3W8Ww4fuF98
	Aw1qkF1UC34xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuCJPUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RcmlGo5APdsdwAA33

sriov_init() takes a reference to another PF device with pci_dev_get()
when an existing PF is found on the bus. If compute_max_vf_buses() fails
afterwards, the error path clears dev->sriov and frees the pci_sriov
structure, but does not drop that reference.

Release iov->dev before freeing iov on the error path, matching the
cleanup done by sriov_release().

Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..1a55863fa7a0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -905,6 +905,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	return 0;
 
 fail_max_buses:
+	if (iov->dev != dev)
+		pci_dev_put(iov->dev);
 	dev->sriov = NULL;
 	dev->is_physfn = 0;
 failed:
-- 
2.25.1

