Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236D48E0F5;
	Wed, 16 Sep 2026 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550297; cv=none; b=hYy8lgj2pW4qmNrcGE9RFQHYldRRtShS7I77PWhu7DjJhOWxfel6WtD4Zs1ePX0bONKUaMJ41EMCSU1a+PRd9levrJjozmxC+8+luu5vcLC8XmlOuYpau2dDfNm2NCx7ofvrTj2EqdDY/an7nWMoWSHsmXUnJq5QSaKZVfcnIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550297; c=relaxed/simple;
	bh=pGB2Hl6EYWKcbZqPkmhicGsa294JBnp5MIVMK/XqHjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OQcw3JKVFajpPDW8K9b+Nsn8QYi4bPOdXIjsWCUuCMtUgSMLC81NCx5hRo0PplAvgP3oQT8st4i9KAfMeEy49ldh+949RQiMNKu2FrkCdSuIykT6gSJbY3TvYkNnXYET3gi3cav1FehbL4LRdCL58R1eG1pBcjXGzrAaCG4QB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXnz29Xqpq5zbgBw--.41776S2;
	Wed, 16 Sep 2026 17:17:49 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: aris@redhat.com
Cc: bp@alien8.de,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	qiuxu.zhuo@intel.com,
	tony.luck@intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/sb_edac: Fix pci_vtd reference leak in broadwell_mci_bind_devs()
Date: Wed, 16 Sep 2026 09:17:21 +0000
Message-Id: <20260916091721.1999379-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXnz29Xqpq5zbgBw--.41776S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWkCFWxWF45tF13GF13CFg_yoWDtFgE93
	4rZFn7XFWkAF4vkwnrJr13ZrZ7Ka12gayIg3929w4fKryjvr45XF9xCF93Aw47WrW0vF9r
	Kw1jkFW7Wr4xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULo7
	NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMMA2qqQJWANwAAsp

In broadwell_mci_bind_devs(), a reference to the VT-d device is taken
with pci_get_device() and stored in pvt->info.pci_vtd.  If one of the
required devices is missing, the function returns -ENODEV without
putting that reference, and the caller frees the mem_ctl_info along
with its private data, leaking the reference.

Put the device reference before returning on the error path.

Fixes: 1f39581a9a7a ("sb_edac: Add support for Broadwell-DE processor")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/edac/sb_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 5075c703e19e..7ec29e50f5d7 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -2929,6 +2929,8 @@ static int broadwell_mci_bind_devs(struct mem_ctl_info *mci,
 	return 0;
 
 enodev:
+	pci_dev_put(pvt->info.pci_vtd);
+	pvt->info.pci_vtd = NULL;
 	sbridge_printk(KERN_ERR, "Some needed devices are missing\n");
 	return -ENODEV;
 }
-- 
2.34.1

