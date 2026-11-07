Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794036591;
	b=KUmrL/Rkps+IPt8mWtyxZVzSx1+/xjH2VzEUfoLiE0pvJQqKzSEF432f8vhSME35Q9CI
	 qMHBIT2YYdxDT1u+VYuA2EAGWuiwhdOlXXTCiMd5ZrMzeqhRXQkj2mga3i+WN/g9E6ADb
	 vMMq1Jw2qKbD1/lkIVV9LaLHu8JTba3ZzJqy3aO0GMFQJbxRcovpCViWUhEynf9Qju4Hy
	 pzlpPYwPFS84J8zTYMYc3tQd9koM6DF80trXdSD35+Fhpt4h8WQzaGa6US1Pnbql5mINU
	 aoxAfeKnAyUH0fQVqIfHU+EEHzdWld2y1m5mDHvVRGuc7iuQFLQAhIa/Z9FuIF4SO+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036591;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=zTLPhYoAUqZ3E8rSlJCnfKyWQg7GEvKe+ZthoEnnDdc=;
	b=xv1Iym/JwT//3+R2ae1JTDlZeQflPqwAX2XNxh9tam0SNQq95rknUxRyXRBbHA2gV1BQ
	 4Rsq1aVYoCvqubzG54NlHCvw+aGDcULLE4lOv7k4l2jjaIHS2cyswOIclvZ2ONyIIGyTA
	 ZMKzYNsk+RYkM1ml+W93en6KcV4hpPhE5LISvRpz1/vkJRU3CJnn3aHNoVA0Tlu6AQAGD
	 q9PQPXxHF9hj7xI7g54nWaY49qLcSVp8BrrYsQ9h3Gq8pmwwmQihCUccTQ/VLaQJip7r7
	 ofSzdzZKyTabPPDx1+p7LPaSFQWKGAq6E8/HSA5KduVYT66xq1EFYgXrOcBqUuAAJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A50606A326;
	Sat,  7 Nov 2026 07:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A50606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXgPpU0+5q4nVxAA--.12684S2;
	Sat, 07 Nov 2026 15:29:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 nsaenz@kernel.org,
 Sean Anderson <sean.anderson@linux.dev>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 vulab@iscas.ac.cn
Subject: [PATCH v2] fsl/fman: Fix fm_node reference leak in read_dts_node()
Date: Sat, 07 Nov 2026 07:29:41 +0000
Message-ID: <20261107072941.314160-1-vulab@iscas.ac.cn>
In-Reply-To: <20260921101757.GE13925@horms.kernel.org>
References: <20260917110342.2148155-1-vulab@iscas.ac.cn>
 <20260921101757.GE13925@horms.kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXgPpU0+5q4nVxAA--.12684S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1UXFyfCFWkZF13XF1DKFg_yoWrGFy5pF
	W7G3ya9rZ5GF1fCrWxXws7ZFyjya1Ut3yrKr97Gw4Sv3s0vr1qvr4YvFy0gr43AFZ3Cw1U
	JrZFvrZ5A3Wqvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUJWrAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAEA2rucfyZAwABsZ

of_node_get() takes a reference on the FMan device node. That reference
is released neither on the success path, which returns straight after
of_platform_populate(), nor on the failure paths that jump to fman_free
without going through fman_node_put(). Neither read_dts_node() nor its
caller keeps fm_node around to release it later.

Release the reference on the success path, and route the remaining
failure paths through fman_node_put(). The latter leaves the fman_free
label without any user, so drop it as well: fman_node_put already falls
through to kfree(fman).

The candidate was found with static analysis tools; DeepSeek and GPT-6.1
Sol were used to audit it and to help prepare this fix.

Fixes: ecb239d96d36 ("ethernet: fman: fix wrong of_node_put() in probe function")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Remove the fman_free label, which no longer has a user once the failure
  paths go through fman_node_put(). With W=1 the leftover label is an
  -Werror=unused-label build failure, as Simon reported.
- Rebuilt with W=1 on v7.4-rc1 (x86_64 defconfig + COMPILE_TEST,
  CONFIG_FSL_FMAN=m); drivers/net/ethernet/freescale/fman/ now builds
  without warnings.
- Link to v1: https://lore.kernel.org/all/20260917110342.2148155-1-vulab@iscas.ac.cn/
- Sorry for the late reply, and thanks for catching the build failure.

 drivers/net/ethernet/freescale/fman/fman.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 46cc28895e56..5507002097fd 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2760,7 +2760,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		err = -EINVAL;
 		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
 			__func__);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 	err = of_address_to_resource(muram_node, 0,
@@ -2769,7 +2769,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_node_put(muram_node);
 		dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",
 			__func__, err);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 	of_node_put(muram_node);
@@ -2779,7 +2779,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err < 0) {
 		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, irq, err);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 	if (fman->dts_params.err_irq != 0) {
@@ -2789,7 +2789,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		if (err < 0) {
 			dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 				__func__, fman->dts_params.err_irq, err);
-			goto fman_free;
+			goto fman_node_put;
 		}
 	}
 
@@ -2797,7 +2797,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (IS_ERR(base_addr)) {
 		err = PTR_ERR(base_addr);
 		dev_err(&of_dev->dev, "%s: devm_ioremap() failed\n", __func__);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 	fman->dts_params.base_addr = base_addr;
@@ -2809,7 +2809,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err) {
 		dev_err(&of_dev->dev, "%s: of_platform_populate() failed\n",
 			__func__);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 #ifdef CONFIG_DPAA_ERRATUM_A050385
@@ -2817,11 +2817,12 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_property_read_bool(fm_node, "fsl,erratum-a050385");
 #endif
 
+	of_node_put(fm_node);
+
 	return fman;
 
 fman_node_put:
 	of_node_put(fm_node);
-fman_free:
 	kfree(fman);
 	return ERR_PTR(err);
 }
-- 
2.43.0

