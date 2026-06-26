Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E83A168B;
	Fri, 26 Jun 2026 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487921; cv=none; b=lwyDsZWdDm2MjNNnmWqHPvFPtfjCAK78Ia0vofTDuyusWv4sFPt1JrN4DjsQi9Bf6dOfCDGyKHI8kt2XpcTeVJKvt/Rm/CT7NJ83ta/g6rmjBbH7cC//nsbvBZxy9fbfQdZ4RvB5Py7jPQMQJUmcoCUKW3CcXuj2Ixrd+7SIZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487921; c=relaxed/simple;
	bh=vxxKpeQd3oR6u3/gFXrmmqLmgbVj2s8NkdXDc5z9e40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OlTbVMRdoT9MAB/fJQcW2G2xOsZspN0RwrCu0/NJRXsPn3avc9G2AGMavVWHFYhXNipRleq5EVol8PYaIPtuNP6GTaPlaMXSnao5epPDYXfE/iyIW7NjJ6odRn1s68usUWMNLKCcVN+4YwN/IgUpBN6JBjwRdo68VByUi/9SXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACHLtdkmz5qd1FsAw--.37601S2;
	Fri, 26 Jun 2026 23:31:50 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-omap@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: net: ti: cpts_of_mux_clk_setup: fix device_node reference leak on   success path
Date: Fri, 26 Jun 2026 23:31:48 +0800
Message-Id: <20260626153148.52612-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHLtdkmz5qd1FsAw--.37601S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFykZw15tFWDCr4fXFW3GFg_yoWkGFcEgr
	yIgF1fXa4UGr4qyw43trW7uasayFnF9a4xZayIyay3t3y3Cr4Fyrn8Cr1fZry7W3y8Gr1U
	twnFyFW7Z342yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5dgADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAKA2o+idsuXgABsy

of_get_child_by_name acquires a device_node reference for refclk_np, and
  of_clk_add_hw_provider additionally takes an extra reference internally.
  On the success path, the function returns 0 without calling
  of_node_put(refclk_np), leaking the initial reference.

Add of_node_put(refclk_np) before returning success to properly release
  the acquired reference.

Cc: stable@vger.kernel.org
Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/ti/cpts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 2ba4c8795d60..d6e6d074747e 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -714,7 +714,8 @@ static int cpts_of_mux_clk_setup(struct cpts *cpts, struct device_node *node)
 		goto mux_fail;
 	}
 
-	return ret;
+	of_node_put(refclk_np);
+	return 0;
 
 mux_fail:
 	of_node_put(refclk_np);
-- 
2.39.5 (Apple Git-154)

