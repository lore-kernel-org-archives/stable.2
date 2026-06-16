Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAF35B654;
	Tue, 16 Jun 2026 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578984; cv=none; b=ERecEnou/BqP8/dvz9E+WCBbPubcTmlATTtfZcpkExXYVK6jg0EZwOBcgGJ3lyyvHFF4saroStZipQxSz9dsifa/H/KeMirB3lpsRyISkXu1D2QJoZ4SwxRfOMtTavnfnwQY1QLRFBH43w81Tp0leghuLeNgNrdKlNUB0QVJTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578984; c=relaxed/simple;
	bh=oyR9p5VtYwpI3FRcEw4r6hp2pV/vqJ+uviGUzttcr1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dM9gGnaDFur0HNuGD/XuIfzI8YkW8Af3HzbFWDMnOn5iwooNMXtq5tyd5IqCuGOQXjm+VUvqqnKw8xM1orgEQt85DcpqbzfZJ7mJzX2oRtVORs2PXZ2G8ibFFb6S+qLeLJT6uQ7LOVvZ9ziiXAyUzJ3TFOFwbbiau8AbYLub4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHINfgvDBqUfbhFA--.8356S2;
	Tue, 16 Jun 2026 11:02:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: djbw@kernel.org,
	bhelgaas@google.com
Cc: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/TSM: fix use-after-free in find_dsm_dev()
Date: Tue, 16 Jun 2026 03:02:43 +0000
Message-Id: <20260616030243.1661791-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHINfgvDBqUfbhFA--.8356S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4DuF43Gw4fXr4kCFWruFg_yoWkWwcEga
	4UZFsFgr4IyFnIkw15tF4fury293WFvr4xWw4xtFy3tr9avw4DJFy7uF98JrnrWw4rG34D
	Cwn5Aryfury7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUyEEU
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoAA2owkLOi+AAAst

In find_dsm_dev(), pf0 is obtained via pf0_dev_get() which returns a
reference-counted pointer.  It is declared with __free(pci_dev_put),
so pci_dev_put() will be called when the variable goes out of scope.
Returning 'pf0' directly while it still has __free cleanup causes the
reference to be dropped before the caller can use the pointer, leading
to a use-after-free.

Fix by using return no_free_ptr(pf0) to suppress the automatic
cleanup and properly transfer ownership to the caller.

Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/tsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f2e820..dd4e0cb0c6aa 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -670,7 +670,7 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 		return NULL;
 
 	if (is_dsm(pf0))
-		return pf0;
+		return no_free_ptr(pf0);
 
 	/*
 	 * For cases where a switch may be hosting TDISP services on behalf of
-- 
2.34.1

