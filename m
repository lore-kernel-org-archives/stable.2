Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEB4CE669;
	Thu, 17 Sep 2026 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643050; cv=none; b=f4J62HRtt6tfvEbM0iHnNiP3K5wdkc+/leXUYD6WPfEsv7w7tJM87NiehJBCYIBwZCi1alG2nVHKawsOtv+t5+OaOIdDX5BvWVtyFGIbO1i1Kj1TFnETYDyg8QdwUIukut1B+hg4oF86F8X9UYIJ0KU3cOFh78cELbJQlDXeyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643050; c=relaxed/simple;
	bh=7Q6ySHJtaEP5omwtEgtb7y0hRXA2+ruqTI1YI8lZAeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GAaQBuS7oqC6KZnQ8EFzEWQXXZyyAfdsAR/Y7u/m1t6fcuywjdAdss2AJ3S0ZDhcLqDcCKZ2jbv3CoEQbutBNgEP/TQC7B+ZwM24Ojp6tlS4HJYCmgEAo1W85Yc7HNgMHnSsVHo99bdXUy8CA154GSkQOU6yBIPBr9gdIXDRxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHsTsOyatqpit_CA--.1172S2;
	Thu, 17 Sep 2026 19:03:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	nsaenz@kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsl/fman: Fix fm_node reference leak in read_dts_node()
Date: Thu, 17 Sep 2026 11:03:42 +0000
Message-Id: <20260917110342.2148155-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHsTsOyatqpit_CA--.1172S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1UJr13ZFyrZr4kGFy8Zrb_yoW5ArykpF
	W7G3ya9rWkGF1fGryxXws7uFyjka1Ut3yrK39rKw4Sy3s0vrn0qF4Y9F1FgF4fAFZ7Cw1U
	Jr9FvrWkAa1jvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU5TOJ7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAINA2qrrJpddQAAsf

of_node_get() takes a reference on the FMan device node. That reference
is released neither on the success path, which returns straight after
of_platform_populate(), nor on the failure paths that jump to fman_free
without going through fman_node_put(). Neither read_dts_node() nor its
caller keeps fm_node around to release it later.

Release the reference on the success path, and route the remaining
failure paths through fman_node_put().

Fixes: ecb239d96d36 ("ethernet: fman: fix wrong of_node_put() in probe function")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/freescale/fman/fman.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 0f342b1a845b..403278aa357e 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2758,7 +2758,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		err = -EINVAL;
 		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
 			__func__);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 	err = of_address_to_resource(muram_node, 0,
@@ -2767,7 +2767,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_node_put(muram_node);
 		dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",
 			__func__, err);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 	of_node_put(muram_node);
@@ -2777,7 +2777,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err < 0) {
 		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, irq, err);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 	if (fman->dts_params.err_irq != 0) {
@@ -2787,7 +2787,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		if (err < 0) {
 			dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 				__func__, fman->dts_params.err_irq, err);
-			goto fman_free;
+			goto fman_node_put;
 		}
 	}
 
@@ -2795,7 +2795,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (IS_ERR(base_addr)) {
 		err = PTR_ERR(base_addr);
 		dev_err(&of_dev->dev, "%s: devm_ioremap() failed\n", __func__);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 	fman->dts_params.base_addr = base_addr;
@@ -2807,7 +2807,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err) {
 		dev_err(&of_dev->dev, "%s: of_platform_populate() failed\n",
 			__func__);
-		goto fman_free;
+		goto fman_node_put;
 	}
 
 #ifdef CONFIG_DPAA_ERRATUM_A050385
@@ -2815,6 +2815,8 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_property_read_bool(fm_node, "fsl,erratum-a050385");
 #endif
 
+	of_node_put(fm_node);
+
 	return fman;
 
 fman_node_put:
-- 
2.34.1

