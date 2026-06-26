Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E33E2AD1;
	Fri, 26 Jun 2026 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491035; cv=none; b=gGT0GdUBlSVg7tZj9PkTEF8nUlWZJ+S7ugPqg+F6JYwkiYJrfucGEks93idxl0hXyAAiyjhBSCuJGbbF5M3iEa+fIq5Ub8c0joRbA/jlsfRRoPYQLbi84DgPB3iccAwfE0O6tTvjT1k3go0Mv7tJAtgR5RRCs1dycKpeX/rcUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491035; c=relaxed/simple;
	bh=WMAQjwmHvvTBUfwzCc5KXHhq77yD+5TWIbi5Bk7J7sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/913XWoiq7Nau/niduUMmhTwYGIa81gitTbBA4TgWRJooKFRWiZPjTz4ybXrbscN9lOM42DsEDFvVQRWwt0z9dxn+SMQfyCKSgC9wRQJMEFRZLgqRcQPUeUxEjuOIzPOIHIlHDXncEgSmHfLwg+e1vpK5lJEA0K5R1C7QzvmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHpc2Upz5qg_dtAw--.54841S2;
	Sat, 27 Jun 2026 00:23:50 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: linux-kernel@vger.kernel.org
Cc: Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: soc: fsl/qe: tsa_of_parse_tdms: fix copy-paste errors in clock   cleanup blocks
Date: Sat, 27 Jun 2026 00:23:48 +0800
Message-Id: <20260626162348.55243-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHpc2Upz5qg_dtAw--.54841S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ury7Aw18tr1xtFW7Xw4Dtwb_yoW8uFyxpr
	Z3KrWFvrZ2qF1vgFnxG3y2gF1rta17ta4xGrsxCa1IkrZxJF1Utr1DCa4xuF18Cr1UCFsr
	JFyUKFWrG3ZrArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDpnQUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIKA2o+h0FRrgABsh

In tsa_of_parse_tdms(), the error cleanup label (err) contains copy-paste
errors in the if blocks for l1tsync_clk and l1tclk_clk. The l1tsync_clk
cleanup block mistakenly operates on l1rsync_clk, and the l1tclk_clk
cleanup block operates on l1rclk_clk instead of the correct clock
pointers. This causes double-put of l1rsync_clk and l1rclk_clk while
leaking l1tsync_clk and l1tclk_clk references.

Fix the clock pointer references in the cleanup blocks.

Cc: stable@vger.kernel.org
Fixes: 1d4ba0b81c1c ("soc: fsl: cpm1: Add support for TSA")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/soc/fsl/qe/tsa.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 4a88e54d25b9..502e2ffe8689 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -865,12 +865,12 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 			clk_put(tsa->tdm[i].l1rclk_clk);
 		}
 		if (tsa->tdm[i].l1tsync_clk) {
-			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
-			clk_put(tsa->tdm[i].l1rsync_clk);
+			clk_disable_unprepare(tsa->tdm[i].l1tsync_clk);
+			clk_put(tsa->tdm[i].l1tsync_clk);
 		}
 		if (tsa->tdm[i].l1tclk_clk) {
-			clk_disable_unprepare(tsa->tdm[i].l1rclk_clk);
-			clk_put(tsa->tdm[i].l1rclk_clk);
+			clk_disable_unprepare(tsa->tdm[i].l1tclk_clk);
+			clk_put(tsa->tdm[i].l1tclk_clk);
 		}
 	}
 	return ret;
@@ -1039,12 +1039,12 @@ static void tsa_remove(struct platform_device *pdev)
 			clk_put(tsa->tdm[i].l1rclk_clk);
 		}
 		if (tsa->tdm[i].l1tsync_clk) {
-			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
-			clk_put(tsa->tdm[i].l1rsync_clk);
+			clk_disable_unprepare(tsa->tdm[i].l1tsync_clk);
+			clk_put(tsa->tdm[i].l1tsync_clk);
 		}
 		if (tsa->tdm[i].l1tclk_clk) {
-			clk_disable_unprepare(tsa->tdm[i].l1rclk_clk);
-			clk_put(tsa->tdm[i].l1rclk_clk);
+			clk_disable_unprepare(tsa->tdm[i].l1tclk_clk);
+			clk_put(tsa->tdm[i].l1tclk_clk);
 		}
 	}
 }
-- 
2.39.5 (Apple Git-154)

