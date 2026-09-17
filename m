Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CE4D9558;
	Thu, 17 Sep 2026 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651977; cv=none; b=Ky1S/BEPDMmIVSirWyYTu1/rY2crRmxgPV7bp25V8ICpboELi6YN/rauQC9IY6WuEyA9+pgCh9m52oaFQ6A91GFdHuNn3WSz/RRiAqoB8bcrP0+LLNIEfqH83WDM8RA3JMaqp/TMoUJVga3WRghVPoh7JePFbBvNLP49D5IFsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651977; c=relaxed/simple;
	bh=vRIf4V6xqwIk3HxmxkIO2Qe26JzbgFlDeqoZmxc6ink=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KH8yhl4oy4/pUB9wOvywOeZF97s2fP+avWe9WmU6MbyDIL6oiFUzGSor1zI0vWhjxzqYQ9gbgWaUz0+faRVeR8QRd4toMMCfRBK+oEUrNu6r8TSlbumiuvpXwfxyqKoPEkeOec/zmH0bWQM3ERnd0NhSlyg3nsbRAwv38z9tv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXADv566tqtIeBCA--.3671S2;
	Thu, 17 Sep 2026 21:32:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: cuiyunhui@bytedance.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	xueshuai@linux.alibaba.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] perf/dwc_pcie: Fix PCI device reference leak in dwc_pcie_pmu_probe()
Date: Thu, 17 Sep 2026 13:32:41 +0000
Message-Id: <20260917133241.2153478-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXADv566tqtIeBCA--.3671S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF17JrW5tFyxAFW7KryrCrg_yoWDKrg_Ga
	4xua9rX34DCFnFyF1jyFy3ZryfA3srZa4xWFn7ta1aqrZFvF1rAr9F9r95AF47Wws5Gry8
	tw1DWr43ZrW3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42
	xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7I
	U5o5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAANA2qrrJrB-wAAsL

dwc_pcie_pmu_probe() gets a reference to the PCI device with
pci_get_domain_bus_and_slot(), but returns -ENODEV directly when
dwc_pcie_des_cap() does not find the RAS DES capability, leaking the
reference.  The other early returns and the success path drop it.

Release the reference on that path as well.

Fixes: 7f35b429802a ("perf/dwc_pcie: fix duplicate pci_dev devices")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/perf/dwc_pcie_pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 5385401fa9cf..edaf5d2e0daa 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -710,8 +710,10 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	}
 
 	vsec = dwc_pcie_des_cap(pdev);
-	if (!vsec)
+	if (!vsec) {
+		pci_dev_put(pdev);
 		return -ENODEV;
+	}
 
 	pci_dev_put(pdev);
 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
-- 
2.34.1

