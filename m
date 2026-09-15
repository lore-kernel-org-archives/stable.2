Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB54440A13;
	Tue, 15 Sep 2026 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455838; cv=none; b=vC3W8P14ZFRA6+QVWGxJ4I9u0BUn8F7AJ5PTAcCpTYphn97PSX7DJq0z4ZsCdWS2AyFoTErNFY6Xdij8wWmyCyUdqPnF6vGZw5UICEzXJ2aBsReanfiN8cUuRgunCo3Tvve51sFyCQaKRW55/HUXhGRP+7ncVxOYbiGAEVrc79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455838; c=relaxed/simple;
	bh=YRkU8KyF0H00Cx9BRK5RyuQ5oPriNisF6tBCyuGf2e0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=arAHozB1VFZTaxC5W2kWmbjGA+7pSWKiouVpWYd4EbwXoucNUkOoPc095YBR9LBgI9aovtpw5Mefvh1OzGWwjlpN+2ebs1yKz3WgCG5tq7wJn0Y4JsGoxTUY29JTW+EU0Zxw2ENmqP0P4lG7TnvW5jUMYxS7KB9oGnSE057a9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADX4T_K7ahq+anIBw--.20952S2;
	Tue, 15 Sep 2026 15:03:39 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bhelgaas@google.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	macro@orcam.me.uk,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] x86/PCI: Fix device reference leak in pirq_find_router()
Date: Tue, 15 Sep 2026 07:03:10 +0000
Message-Id: <20260915070310.1733310-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX4T_K7ahq+anIBw--.20952S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1DGryUAFy7Ar1xGF1xZrb_yoWkWrg_ua
	s3Za9rXF48t3Wjkry5tFsxZFZ3u34qvF4kAr4xtFn8K3y5XF1DtFyUAr1rZF13u3yrAr95
	J3sFqr45Ja1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU11rW7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAALA2qowzOhDQABsb

pci_get_domain_bus_and_slot() takes a reference on the router device
looked up from the routing table. If the device is found but no router
handler probes it successfully, the reference is neither stored in
pirq_router_dev nor dropped. Put the device reference when the router
probe fails.

Fixes: ac7cd5e16df8 ("x86/PCI: Handle PIRQ routing tables with no router device given")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 arch/x86/pci/irq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 0de436316a1d..2bb80b6bf606 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1312,8 +1312,12 @@ static void __init pirq_find_router(struct irq_router *r)
 	if (rt->rtr_vendor) {
 		dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
 						  rt->rtr_devfn);
-		if (dev && pirq_try_router(r, rt, dev))
-			pirq_router_dev = dev;
+		if (dev) {
+			if (pirq_try_router(r, rt, dev))
+				pirq_router_dev = dev;
+			else
+				pci_dev_put(dev);
+		}
 	} else {
 		dev = NULL;
 		for_each_pci_dev(dev) {
-- 
2.34.1

