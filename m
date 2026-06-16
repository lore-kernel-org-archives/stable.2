Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37D1946DA;
	Tue, 16 Jun 2026 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619467; cv=none; b=oFyMVoze+7y0FuHBViwQS+8VpFA9zaodRhPF3M6rj9pV+jDQMwes5HWkx++YrwGUKNmd2YAJuBC/PhBbIDws3neYv5B18gGOyWRc2Yj1ucds9Hso4Rxvs81DmdAkk6BiGRisuzmp+qx71YFaglA1BEjJytjwpBshb7Ho7AKeiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619467; c=relaxed/simple;
	bh=QA/WhY7Cd5P/kxGZhBI5BaM1zbsD9PdkNFMfQw//quE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ioE4MuQTANs/6neov8iGb6SlPr/bNh8dOpASaKwaPbnetRm3pa2DCgFeSrBsRyardchNWJDpLx9wVhwFhFwfSf3VER6VoXRJ8bzSzSVPiLpO9F17lgWewUFifUg1s9h238oFxesmYXvAJx9TEzS33gt3SrNlNeRHjnOhC/rMges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnjdYBWzFqEYLvAQ--.15057S2;
	Tue, 16 Jun 2026 22:17:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bhelgaas@google.com
Cc: mika.westerberg@linux.intel.com,
	mani@kernel.org,
	andriy.shevchenko@intel.com,
	kees@kernel.org,
	adiyenga@cisco.com,
	vulab@iscas.ac.cn,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PCI/PTM: fix refcount leak in pci_enable_ptm()
Date: Tue, 16 Jun 2026 14:17:33 +0000
Message-Id: <20260616141733.1688264-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnjdYBWzFqEYLvAQ--.15057S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1UKw18JrWxZF1fZr4DCFg_yoWkZwb_ZF
	4UXrsrCw4jqFsxKa1ayw4DAryjk3ZrWr1kWw4I9FWfKFyxZr4aqa48Zrn8Arn5W3yjvF98
	GFyqvry8Cry7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU7TmhDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4AA2oxWswAvwAAs2

When pci_enable_ptm() enables PTM for a device, it first
recursively calls itself on the parent. This increments the
parent's ptm_enable_cnt. If the subsequent __pci_enable_ptm()
call on the child fails, the error path only decrements the
child's ptm_enable_cnt but leaves the parent's counter
elevated. That refcount is never balanced, leading to a leak.

Fix this by calling pci_disable_ptm() for the parent on the
error path, reverting the parent's enable state. Add the call
right after the child's counter is decremented.

Cc: stable@vger.kernel.org
Fixes: e8bdc5ea4816 ("PCI/PTM: Add pci_suspend_ptm() and pci_resume_ptm()")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/pcie/ptm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index a41ffd1914de..01f6c7da7ca9 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -201,6 +201,8 @@ int pci_enable_ptm(struct pci_dev *dev)
 
 	rc = __pci_enable_ptm(dev);
 	if (rc) {
+		if (!dev->ptm_root)
+			pci_disable_ptm(parent);
 		atomic_dec(&dev->ptm_enable_cnt);
 		return rc;
 	}
-- 
2.34.1

