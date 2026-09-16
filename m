Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC14B95A9;
	Wed, 16 Sep 2026 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574299; cv=none; b=VtfYKg9SVnAg4Z81sqlFMJPdItidQ4/4Px5SaLPjzY7JTIL8rGdxvszitURE5/9SKgDOJ6KNsL1Mh1+2DdJOtfEbRXYLWGZszUSe+xXbmJZE4zODdWWckaYiaOsIWaikBca21j9kkvnbMrVlN6IEdi0iRMQtsMdsnNvEnsAM6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574299; c=relaxed/simple;
	bh=p9N+srUYbPMnc0pluftk0ipj2NRLcleMzvs5Kew1GNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nlSNaVru5s53+DfzguKhGK9TXiFwJfZObPWl0ZLP9fCDcdhi030mxQ2dBaRyLZEzCWytbii7siUmGhhyfqWtmey+bE1HiTCTUOc2cB5BHesVckQEwYPxJzpJ9ahI7QHRv+JC7n3z4Yq+W3ydwJQfJBfG/y5ICp8PTVrlBOgnMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3J0KFvKpqkEBtCA--.21786S2;
	Wed, 16 Sep 2026 23:57:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andriy.shevchenko@linux.intel.com
Cc: angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	dianders@chromium.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wenst@chromium.org,
	wsa+renesas@sang-engineering.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: of-prober: Fix device node reference leak in i2c_of_probe_simple_enable()
Date: Wed, 16 Sep 2026 15:57:30 +0000
Message-Id: <20260916155730.2077434-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3J0KFvKpqkEBtCA--.21786S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDZF4fKF45Ar1DuFWDXFb_yoWDXwbEkr
	1xuasrXrWDCrsxZwsxuFZxZr9xKF1jgay8Jr4xta43J342kF43GFnxAr93Z3yUZF4DKF1D
	Ww1kur4xu3WfXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYx
	BIdaVFxhVjvjDU0xZFpf9x0JUJWrAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2qqpVg55wABsv

of_get_compatible_child() returns the child node with an incremented
reference which the caller must drop with of_node_put(). The error
paths release it via the out_put_node label, but the success path
returns without doing so, leaking the node reference.

Release the node before returning success.

Fixes: 897261149d25 ("i2c: of-prober: Add simple helpers for regulator support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/i2c/i2c-core-of-prober.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 6a82b03809d4..603de487ee2d 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -354,6 +354,7 @@ int i2c_of_probe_simple_enable(struct device *dev, struct device_node *bus_node,
 	if (ret)
 		goto out_disable_regulator;
 
+	of_node_put(node);
 	return 0;
 
 out_disable_regulator:
-- 
2.34.1

