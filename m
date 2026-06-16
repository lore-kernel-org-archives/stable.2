Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D63624C1;
	Tue, 16 Jun 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619765; cv=none; b=KHhU6vtLT9COtb1lHDQtjY2+ZMNxaqvla4qCh0Hu4c9Z96FwjGlsFpzADxgfd/YEe3WE1abaNbyVjdczOPR8BRKR0o86jOxx8HqV0V9qbXSdQeVCjLVo9ubBXROVE6RbZc5+//3zw4zcoiO9GkDTCggblmtkTFVzed/Y94NX3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619765; c=relaxed/simple;
	bh=rPUlpii724+DCkmPeW9rSHCFn/3gLQDSUBcQ5krqFA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=brvFBbaTgRpdN+b8rxSb9CQXDcwPRtDZplM+kuHtg2YPJjJxhgMpWsuOkXuiHGsp/wnFzsvSlZ34kBOF0C9WVYUcMew4ENHrGtWCvQYwieZ2xODweHlolRnhMfdX8aWeg/Wrxcw0kCupjvrq4llJM/1xXKngJc0/gAVjGeO2PJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACHKNEuXDFqlqTvAQ--.40251S2;
	Tue, 16 Jun 2026 22:22:38 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: vincent.sunplus@gmail.com,
	vkoul@kernel.org
Cc: neil.armstrong@linaro.org,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: sunplus: fix refcount leak in sp_uphy_init()
Date: Tue, 16 Jun 2026 14:22:34 +0000
Message-Id: <20260616142234.1690457-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHKNEuXDFqlqTvAQ--.40251S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF43tw45Zw4kGr13Wr13CFg_yoWkZrg_WF
	18Kry7Jw4DKF1Dur40yrWIy3yS9Fn8XFy8Ka10vFWSyFyjyFnIv3Z7ZFWv9F1fu3yUCFy2
	kwnrZ34fAa92gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUz9aBUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcAA2oxFt-+7gAAsK

If update_disc_vol() fails after reset_control_deassert() succeeds,
the function returns without calling reset_control_assert() and
clk_disable_unprepare(). This leaks the reset control deassert count
and leaves the clock enabled.

Fix it by jumping to the err_reset label instead of returning
directly, so the cleanup path is executed.

Cc: stable@vger.kernel.org
Fixes: 99d9ccd97385 ("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/phy/sunplus/phy-sunplus-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
index 637a5fbae6d9..c7bc3ac89ca9 100644
--- a/drivers/phy/sunplus/phy-sunplus-usb2.c
+++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
@@ -129,7 +129,7 @@ static int sp_uphy_init(struct phy *phy)
 	/* disconnect voltage */
 	ret = update_disc_vol(usbphy);
 	if (ret < 0)
-		return ret;
+		goto err_reset;
 
 	/* board uphy 0 internal register modification for tid certification */
 	val = readl(usbphy->phy_regs + CONFIG9);
-- 
2.34.1

