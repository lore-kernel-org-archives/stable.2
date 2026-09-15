Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F03D813C;
	Tue, 15 Sep 2026 04:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447149; cv=none; b=ucYwl7TIIJCHvRadjrpUq8OphJcyl4vOYgEDZYD97Z8edbq+M4xk5ULhhY9Q+TdtbfqiVx4UOqPeM33WptNir0cvXG3RmFEERUCDSco7k6yEptsb0spgmU4H5G6R6SLVfX+PwfBH1Tgw59yg/N392ZJ418ehHRFnVPNSGBerMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447149; c=relaxed/simple;
	bh=r/dPwbAh8i88upap23qPyRrphls1N1dlzD9H6k2NPUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dVhw6ifKkTfkzF8/hQGavtip4IjI5qj3pswJS42fJeu/5wb4BrhnokJVXMWoOUWzZVyxAQ6+b+qO1r8yd5BdpsyPu5Fb/Kb5/L4sbmuVZvQ8NXxiM/0CMZfszPhC/jWC+bjc4ZqLe3XwmsRnwQfF+uFjVVoKfiXuZ83Ft9eCO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACXbvLVy6hq5dcICA--.24574S2;
	Tue, 15 Sep 2026 12:38:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 6/6] perf/x86/intel/uncore: Fix PCI device reference leak in box register paths
Date: Tue, 15 Sep 2026 04:38:17 +0000
Message-Id: <20260915043817.1726135-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXbvLVy6hq5dcICA--.24574S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4xXrW5KF18Kw4DuFWDtwb_yoW8Kw1Dpr
	ZrXFn8try09F4v9ayDGF47tFyY9FWSvFZ3ur4UJ34Igws3G34Sqr42gFy2gw48A3ykKF13
	Jw4jqw48urW5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUU-eoUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgULA2qowR0oxQAAs4

uncore_pci_pmus_register() obtains a PCI device reference with
pci_get_domain_bus_and_slot() and hands it to uncore_pci_pmu_register(),
which stores the device in box->pci_dev.  Nothing ever drops the
reference: both uncore_pci_pmu_unregister() and the PMU registration
failure path in uncore_pci_pmu_register() simply kfree() the box, so
one device reference is leaked per registered box, and each discovery
loop iteration additionally drops the previous reference on the floor
when it looks up the next unit.

Make the box own a reference to its PCI device instead: take an extra
reference in uncore_pci_pmu_register() and drop it in both box release
paths, and have uncore_pci_pmus_register() release its own reference
right after registering the box.  This also covers the case where
uncore_pmu_register() fails after the box has been installed.  The
reference held by the driver core for a device probed by the uncore
PCI driver is left alone, since it belongs to the PCI core and must
not be put.

Fixes: f76a8420444b ("perf/x86/uncore: Apply the unit control RB tree to PCI uncore units")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 arch/x86/events/intel/uncore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e9cc1ba921c5..70f654e06ef6 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1154,6 +1154,7 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 	atomic_inc(&box->refcnt);
 	box->dieid = die;
 	box->pci_dev = pdev;
+	pci_dev_get(pdev);
 	box->pmu = pmu;
 	uncore_box_init(box);
 
@@ -1166,6 +1167,7 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 	if (ret) {
 		pmu->boxes[die] = NULL;
 		uncore_box_exit(box);
+		pci_dev_put(box->pci_dev);
 		kfree(box);
 	}
 	return ret;
@@ -1233,6 +1235,7 @@ static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
 	if (atomic_dec_return(&pmu->activeboxes) == 0)
 		uncore_pmu_unregister(pmu);
 	uncore_box_exit(box);
+	pci_dev_put(box->pci_dev);
 	kfree(box);
 }
 
@@ -1376,6 +1379,7 @@ static void uncore_pci_pmus_register(void)
 				continue;
 			pmu = &type->pmus[unit->pmu_idx];
 			uncore_pci_pmu_register(pdev, type, pmu, unit->die);
+			pci_dev_put(pdev);
 		}
 	}
 
-- 
2.34.1

