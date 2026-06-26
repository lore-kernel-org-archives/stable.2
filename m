Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AC3EBF04;
	Fri, 26 Jun 2026 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782468058; cv=none; b=MZObO2rgfoOuMvqLuE4G2dVTretEuo+TaJKkvTDk58k9rOBnygy//cTJpOsOFGH3E/dG5ndxZmq5EvIG7BEtmLrt0c1Mj4h79R3gdBs0qvLgEJrwYVwnJY98RWNDqEtBPeGxNazjzHhM9VWnvHP+OwEnkXgRNONdIQ26F1e3HlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782468058; c=relaxed/simple;
	bh=UQVMOzVSc1P4F67Vk3YGL4CKtzNcOICf4bkwy2cjU/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qYdF1/PeownP+r0qiSdQrtpvznM75nPT2cujg4uQHYvN0GIKdwu/i0lT1uGyqlSTmaMWPc4AAoQJ1nlEXMu+ElaPl0MfEs8BgzgWwXo8iaV2Pz7nO9jY/BDsZ3n90EwPWeVUjl4pHVyiXrI6hPISmQNp5ACYc3h5JFkqUjri0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowACXaZDBTT5qhSXrFQ--.21S2;
	Fri, 26 Jun 2026 18:00:35 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	hpa@zytor.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: x86/events/intel/uncore: discover_upi_topology: inner loop leaks PCI   device references from pci_get_domain_bus_and_slot
Date: Fri, 26 Jun 2026 18:00:31 +0800
Message-Id: <20260626100031.31494-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXaZDBTT5qhSXrFQ--.21S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrykuFWfGw1fKw1ktFWUJwb_yoW8JF4fpF
	WaqFy7Kr1fWas2ga98u3WS9rZFvF4kGF9Yg3yIg34I9wn8Xr17JFW2g3WYga48CrykXr1a
	y3W2vw48X34UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoKA2o+SxkLIQAAsp

In the inner for loop, dev is repeatedly overwritten by
  pci_get_domain_bus_and_slot() without first releasing the previous dev 
  via pci_dev_put(). The err label only releases the last ubox and dev
  references, while the references from earlier loop iterations are
  permanently leaked. Fix by adding pci_dev_put(dev) before the overwriting
  assignment.

Cc: stable@vger.kernel.org
Fixes: fdd041028f22 ("perf/x86/intel/uncore: Factor out topology_gidnid_map()")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 215d33e260ed..cecc1ce0a248 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5494,6 +5494,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 		for (idx = 0; idx < type->num_boxes; idx++) {
 			upi = &type->topology[lgc_pkg][idx];
 			devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
+			pci_dev_put(dev);
 			dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
 							  ubox->bus->number,
 							  devfn);
-- 
2.39.5 (Apple Git-154)

