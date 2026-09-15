Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB0433E7C;
	Tue, 15 Sep 2026 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446731; cv=none; b=JfC3/VDEzPHqduca2JrxLIRgg/iQYWVfPMaiemqwuDQGvPdRlFY3+saWHBF8/LnGgl5W0p0gtdq2IHSNKzR7+L7qLyAXsrd4NVZbMote9FFIyTOJ7K7LqB3mAS9kenj8TrRam7jj6F400B+WDpLOVlAIahmuWDk0tXwIaEVmd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446731; c=relaxed/simple;
	bh=nkzg3a8+LvTNt/8oYVAeAj+HXIyWYCIf+6oPPLRiOuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3Ij1KWsELSUfzhWhWUIxPRPF+wDnqy2iSea59W+Ldv0uZ//QsKzEfhOFUwuUD6yIYzsc6EYGS52caapKW1bohQ17NezVWGBvBHZHOwflf5hwdKfcjhWmihFtooF/TQwOH5a0WZ0oElvynaGb7M66TXemhYi4M4AhFK17s4cqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACnfvI8yqhqTa4ICA--.59909S2;
	Tue, 15 Sep 2026 12:31:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy.tang@nxp.com
Cc: bmasney@redhat.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com,
	oss@buserror.net,
	robh@kernel.org,
	sboyd@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] clk: qoriq: Fix clock reference leak in input_clock_by_name()
Date: Tue, 15 Sep 2026 04:31:27 +0000
Message-Id: <20260915043127.1725773-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnfvI8yqhqTa4ICA--.59909S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1rAFyxZryDJw15tw45trb_yoW8Gw47pF
	Z5A34Yvw17Ar4DuF17tF4UuFnI9w48CFy3K3y8Can7ZF13W34xJF1rCFyYvFs0y3yfWw4j
	qFW2yF48CF4kArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU19Xo7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRULA2qowd0d1AABsC

input_clock_by_name() obtains a consumer clock with of_clk_get_by_name()
and hands it to input_clock(), which only uses __clk_get_name() to read
the clock name and then registers a new fixed factor clock.  The
consumer clock itself is discarded without clk_put(), so the reference
returned by of_clk_get_by_name() is never released.

Release the reference with clk_put() once input_clock() is done with
the clock, mirroring the pattern used by of_clk_get_parent_name().

Fixes: 80b4ae7acea4 ("clk: qoriq: Separate root input clock for core PLLs on ls1012a")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clk/clk-qoriq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 2ed8f93bc861..d0091b388cef 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1124,13 +1124,16 @@ static struct clk __init *input_clock(const char *name, struct clk *clk)
 static struct clk __init *input_clock_by_name(const char *name,
 					      const char *dtname)
 {
-	struct clk *clk;
+	struct clk *clk, *ret;
 
 	clk = of_clk_get_by_name(clockgen.node, dtname);
 	if (IS_ERR(clk))
 		return clk;
 
-	return input_clock(name, clk);
+	ret = input_clock(name, clk);
+	clk_put(clk);
+
+	return ret;
 }
 
 static struct clk __init *input_clock_by_index(const char *name, int idx)
-- 
2.34.1

