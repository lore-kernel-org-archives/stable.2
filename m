Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF5332604;
	Thu, 25 Jun 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374042; cv=none; b=Dk00AyTTU3N+ljvDaKeGIFQUgpPfyPbIQdAyG+qAaVS/RA4GeHu76qXh3loX71V63VXIXUHku73kz8N1xuEBgP5lvO36UiY81cgipW0wTmlUXrNc2d8aKFRJl2m2A+cBXMslDoOa9/NAnZC7sidtIpKvbIbOSYdHS96y09EsyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374042; c=relaxed/simple;
	bh=ERuqJGfBMrirKjmDbETROUHKZmnz/FKqpS2UzUsTj0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iYrzycoAMObI5qT6suOFVbz+gnFlIrkJzK4Aa8UqGijj5Xf3Nykex5bllLYg1m/j4v2q4AFnPQqZvbxqYMxjK5HRoHWAgtBJe2W1yy9zVNaB5NiUsatfimxbRGHqdLC8a2OVCSOVjJHXgzUtF5aMcdl6YR/8PCUDiI7lnSivSzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowAAnMsl23jxqPhrLFQ--.32777S2;
	Thu, 25 Jun 2026 15:53:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
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
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Fix reference leak in discover_upi_topology()
Date: Thu, 25 Jun 2026 15:53:11 +0800
Message-Id: <20260625075311.45599-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnMsl23jxqPhrLFQ--.32777S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1rur1xAryfWF18GryUJrb_yoW8Aw4fpr
	Wa9Fyvyr1rZrn2g3yDu3WS9FyYyan5t3s5Wr48W3yIkw15Xwn3tFW2ga4Ygay8CrWxtr1Y
	qw1qva18X3s8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8JA2o8pkqxnQABsb

In discover_upi_topology(), pci_get_domain_bus_and_slot() returns a PCI
device with its reference count incremented. The caller must call
pci_dev_put() after use.

However, the inner loop overwrites dev without releasing the previous
reference, causing leaks:
  - Between inner loop iterations within the same outer loop iteration.
  - Between outer loop iterations (dev from a previous ubox's inner
    loop is overwritten at the start of the next inner loop).
  - On the normal exit path from the while loop (the last dev is never
    put before falling through to err:).

Fix by calling pci_dev_put(dev) and clearing dev after upi_fill_topology()
succeeds, so each reference is released immediately after use. The error
path (goto err) already calls pci_dev_put(dev) and remains correct since
dev is set to NULL after release, making the subsequent put a no-op.

The similar sad_cfg_iio_topology() function does not have this problem
because it uses a single pci_get_device() loop and releases the last
reference correctly in all exit paths.

Cc: stable@vger.kernel.org
Fixes: fdd041028f22 ("perf/x86/intel/uncore: Factor out topology_gidnid_map()")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 arch/x86/events/intel/uncore_snbep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 215d33e260ed..1561bda43835 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5499,6 +5499,8 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 							  devfn);
 			if (dev) {
 				ret = upi_fill_topology(dev, upi, idx);
+				pci_dev_put(dev);
+				dev = NULL;
 				if (ret)
 					goto err;
 			}
-- 
2.39.5 (Apple Git-154)

