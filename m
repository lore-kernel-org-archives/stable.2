Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765F35E936;
	Sun, 28 Jun 2026 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782645495; cv=none; b=sniOZnaXofyrwC0Vjf8o5gBwAB7IexccE1uEk1NFcZUtyS6gKEfizboPfzj7H5NrXYdhRZlEHzml73mCmYk4Wou8jOKr/WueSGKWjyqBGF1umyhe2Ooh1t4w5DLoGEYVF6LzJnPCBhUdBOJSRTxRAIxWT6lN7N3voIbiKm9K+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782645495; c=relaxed/simple;
	bh=eybrTZFW+5aGnf77L00LY6WYIYBuAr3zDWx/OvIhanc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p2Pk9CNPaQi0TzoPaOchc5AL+Rl+jkoLazRvD/YNEKh6rzUc09seJ2EYI/oGdsItSHTq26eGTTsoGLewAAclD/kAiBfo/KAeMFEPasZP9TZGOgaQhTpAeHNoZwjpOyt2nTfvtVHvFPFItgDdZnSygvlV5UtJzfNUXHrPX4FUkHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowAAHfO_ZAkFqYAzCFQ--.32658S2;
	Sun, 28 Jun 2026 19:17:48 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2] x86/events/intel/uncore: fix PCI refcount leak in discover_upi_topology
Date: Sun, 28 Jun 2026 19:17:39 +0800
Message-Id: <20260628111739.43731-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHfO_ZAkFqYAzCFQ--.32658S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrykuFWfGw1fKw1ktFWUJwb_yoW8GFyUpr
	W3tF9rtr4fW3s2ga98C3WI9rW2vFs8Gr9Ygr4UK34I9wn8Xr1xJFW2gw15KFy8CrykJr1a
	v3Wjvw48X34UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRx-BiUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2pAiNnF5gABsL

In the inner for loop, dev is repeatedly overwritten by
pci_get_domain_bus_and_slot() without first releasing the previous dev
via pci_dev_put(). The err label only releases the last ubox and dev
references, while the references from earlier loop iterations are
permanently leaked. Fix by adding pci_dev_put(dev) before the overwriting
assignment.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: fdd041028f22 ("perf/x86/intel/uncore: Factor out topology_gidnid_map()")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
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

