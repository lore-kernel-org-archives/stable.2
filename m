Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80B2BEC45;
	Sun, 28 Jun 2026 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649703; cv=none; b=d0fQXVcrB8JCDGcmtZUg/Q8pxyYuMXHRxTTse0Wi2RkrRDnmxgVyacYB//GU2yBOQCxS7iD5h8Px7RR27NRVeuD6WOuodAcIziuwfZnZissCI62hkGi9A71Gsz+lbh4Q79cITDbBmkJ6OiEesF2Op0ogQZrOu317adZlMfTFY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649703; c=relaxed/simple;
	bh=cv8g4RrGYUNj5js/jIF60hmga11q/SlDxhgYukElUBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMbr105KESHp3x0LkpIEwph3QJcCEGTp/G1oXk3davHyz79+zO+9vOIESZIewHNALHoDrhn+jtPczteMMGNXjM/Yg1oxIxEOmCQwwY2hkgTXeFJPTCRw1NWQzSJi4LN10rcoPqjrvpUFaMbTP0uRxH/6EudT4YSDrUxIv41YD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowAAXXcBcE0FqX0rEFQ--.64351S2;
	Sun, 28 Jun 2026 20:28:13 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: paul@crapouillou.net,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: bmasney@redhat.com,
	linux-mips@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] clk/ingenic: fix clock leak on clk_register_clkdev failure
Date: Sun, 28 Jun 2026 20:28:11 +0800
Message-Id: <20260628122811.44799-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXXcBcE0FqX0rEFQ--.64351S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWUuw4kWr45ZFyrJw43Wrg_yoWkZFX_Wr
	W0v3429Fn8Gr4Skw1UAF1Fv3sYkFnrur1fWFyUtasxJ34UZrs5ur4UZwn7Ar1UWFW09Fyq
	qry8Gr48Zr17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbHa0JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMMA2pAixHjDQAAsV

clk_register() succeeds but clk_register_clkdev() fails, and the error
path jumps to out without calling clk_unregister or clk_put to release
the registered clock. This leaks the clock object within the common clock
framework, contrasting with the CGU_CLK_EXT type path which correctly
calls clk_put on error.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: b066303fb3e7 ("clk: ingenic: add driver for Ingenic SoC CGU clocks")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
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

