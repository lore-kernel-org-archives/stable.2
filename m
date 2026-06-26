Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CDB3F210A;
	Fri, 26 Jun 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475020; cv=none; b=hoOUjUe6GT8/PY+ZMpugkkZ67ljF9/lq+auK0bdvqebfm4RaI+zIrswK2CkEHhoHmqku3DX8F3EcUnWKS4V1fkRIvkmAusJAYvyJWGobvigKCexqMfoHf6/fdHbdA4uCYXeC75iOyf95ScM7cvz9kqdz2HUY7E5EAK8GD4Gn7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475020; c=relaxed/simple;
	bh=Z96Ba0wqRtrYIjh8bYu2gYtWrIIAUb1M9JX4wiGp52s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTF0vAQCXdj9WFtaxQe0LXyIPxVIhV4iXk2F5woWJXKpsbCn3WMHgr+bkd7Ul2zWB7iDH6a9GEGRuB92s8r1kCiMf35VF4hGTB7tAJiK0qRFgX5euDgP6rDtJMG3D0uU0lzj8dUMTuShttpW8lVvyIgxm+S8jIwqxC9aOuyjCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowABHntEBaT5qs+JmFQ--.42353S2;
	Fri, 26 Jun 2026 19:56:50 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: paul@crapouillou.net,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: bmasney@redhat.com,
	linux-mips@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: clk/ingenic: ingenic_register_clock: clk_register_clkdev failure   leaks registered clock
Date: Fri, 26 Jun 2026 19:56:44 +0800
Message-Id: <20260626115644.33779-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHntEBaT5qs+JmFQ--.42353S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWUuw4kWr45Zw4xZw4UXFb_yoWDZFX_Kr
	W0qryIgFn8Kr4a9w1UAF1Fv3sYkFnrur1fWFWUtasxA34UZrs5uryjv3Z7AryUWFWF9a4q
	qryUWr4kur17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwKA2o+TTtTMgAAsB

clk_register() succeeds but clk_register_clkdev() fails, and the error
  path jumps to out without calling clk_unregister or clk_put to release
  the registered clock. This leaks the clock object within the common clock
  framework, contrasting with the CGU_CLK_EXT type path which correctly
  calls clk_put on error.

Cc: stable@vger.kernel.org
Fixes: b066303fb3e7 ("clk: ingenic: add driver for Ingenic SoC CGU clocks")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/clk/ingenic/cgu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 41e4c69131bd..b59b24d0e3cf 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -774,8 +774,10 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 	}
 
 	err = clk_register_clkdev(clk, clk_info->name, NULL);
-	if (err)
+	if (err) {
+		clk_unregister(clk);
 		goto out;
+	}
 
 	cgu->clocks.clks[idx] = clk;
 out:
-- 
2.39.5 (Apple Git-154)

