Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8453B5F8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888847; cv=none; b=aQOFFcWulcChn6LFRb/ixdAO6BcC/1iNg9XPTHtyu0foeK30IwtBSrrmPlr3OEAYJZPbm0yX8FFIaOVq2LwcUXTZKxe9QOi51UHfGosMLSkMOTTSt6R3DaZGTwa2Y7T3Drb9UfEwaihrVtg+oBXWG3QRkMeA1+/uhPIVZ5YnVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888847; c=relaxed/simple;
	bh=kz9XUu3mC1jvt2qTx8KPefKmWVG3J1sWLfBl5CrO8d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDvRIChVNBrlGKdIeUaDW5uN29QEP0TVjfvjx4rcBXOix+I/dd7p9bn1/4gudPM7Mxbg7QxVenB11ICWTd0qpW9D9XzWiBqeBao7aTC6FEbKJX394fsLoxDjOO2zH7/acGIqhq6QOstp/x5xAbw3rfuQusvDOUertM6mvYIFpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arAY5XiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arAY5XiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E32C1F00A3A;
	Tue,  8 Sep 2026 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888845;
	bh=59rgVtMDmJMysXnyfe/q+rL+hC/b0waDZX5W7M6EgZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arAY5XiDZ633BNgQlT1bDlm2yXybR0nUV5mVugoY6RsAVXTaUpBrMLaronnuBLFY1
	 hRqSJwb6pcIzWRcAMeyjA4vJfVDkHc1n6dV1yJuaF39FvpuGje7jOr67MejChDHeOf
	 EsD41U6CBXwFIdxX8YvQNpGmzLJPTjmBE7OJ8PYZsCiBLDxc1ay7v0TOmyqK/5W7SP
	 UylU5pSYxHvK37j0rgxYMoqtKkK3tdUjrOCUQolm87s3NU3oUEvV96O8NxlMVuKwKn
	 iGlQYSitGEGv2uVqhqc4k+havn5ISZ3NPEjPgPv8Gs227ssSHXRLhnDQmZeBi38BjC
	 ocFeAgzqpoBXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huang Yiwei <quic_hyiwei@quicinc.com>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mailbox: qcom-ipcc: Dynamic alloc for channel arrangement
Date: Tue,  8 Sep 2026 13:34:02 -0400
Message-ID: <20260908173403.109367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090341-antibody-riches-1252@gregkh>
References: <2026090341-antibody-riches-1252@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huang Yiwei <quic_hyiwei@quicinc.com>

[ Upstream commit e9d50e4b4d04165097a71e20e0a77e7ad7053dd0 ]

Dynamic alloc for channel arrangement instead of static alloced
array, it is more flexible and can reduce memory usage.

Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Stable-dep-of: 66c7bcad7243 ("mailbox: qcom-ipcc: fix duplicate channel allocation across holes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/qcom-ipcc.c | 90 ++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index f1d4f4679b17b..10cb0b5461090 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -13,8 +13,6 @@
 
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 
-#define IPCC_MBOX_MAX_CHAN		48
-
 /* IPCC Register offsets */
 #define IPCC_REG_SEND_ID		0x0c
 #define IPCC_REG_RECV_ID		0x10
@@ -52,9 +50,10 @@ struct qcom_ipcc {
 	struct device *dev;
 	void __iomem *base;
 	struct irq_domain *irq_domain;
-	struct mbox_chan chan[IPCC_MBOX_MAX_CHAN];
-	struct qcom_ipcc_chan_info mchan[IPCC_MBOX_MAX_CHAN];
+	struct mbox_chan *chans;
+	struct qcom_ipcc_chan_info *mchan;
 	struct mbox_controller mbox;
+	int num_chans;
 	int irq;
 };
 
@@ -166,25 +165,37 @@ static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
 	struct qcom_ipcc *ipcc = to_qcom_ipcc(mbox);
 	struct qcom_ipcc_chan_info *mchan;
 	struct mbox_chan *chan;
-	unsigned int i;
+	struct device *dev;
+	int chan_id;
+
+	dev = ipcc->dev;
 
 	if (ph->args_count != 2)
 		return ERR_PTR(-EINVAL);
 
-	for (i = 0; i < IPCC_MBOX_MAX_CHAN; i++) {
-		chan = &ipcc->chan[i];
-		if (!chan->con_priv) {
-			mchan = &ipcc->mchan[i];
-			mchan->client_id = ph->args[0];
-			mchan->signal_id = ph->args[1];
-			chan->con_priv = mchan;
-			break;
-		}
+	for (chan_id = 0; chan_id < mbox->num_chans; chan_id++) {
+		chan = &ipcc->chans[chan_id];
+		mchan = chan->con_priv;
 
-		chan = NULL;
+		if (!mchan)
+			break;
+		else if (mchan->client_id == ph->args[0] &&
+				mchan->signal_id == ph->args[1])
+			return ERR_PTR(-EBUSY);
 	}
 
-	return chan ?: ERR_PTR(-EBUSY);
+	if (chan_id >= mbox->num_chans)
+		return ERR_PTR(-EBUSY);
+
+	mchan = devm_kzalloc(dev, sizeof(*mchan), GFP_KERNEL);
+	if (!mchan)
+		return ERR_PTR(-ENOMEM);
+
+	mchan->client_id = ph->args[0];
+	mchan->signal_id = ph->args[1];
+	chan->con_priv = mchan;
+
+	return chan;
 }
 
 static const struct mbox_chan_ops ipcc_mbox_chan_ops = {
@@ -192,15 +203,49 @@ static const struct mbox_chan_ops ipcc_mbox_chan_ops = {
 	.shutdown = qcom_ipcc_mbox_shutdown,
 };
 
-static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc)
+static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
+				struct device_node *controller_dn)
 {
+	struct of_phandle_args curr_ph;
+	struct device_node *client_dn;
 	struct mbox_controller *mbox;
 	struct device *dev = ipcc->dev;
+	int i, j, ret;
+
+	/*
+	 * Find out the number of clients interested in this mailbox
+	 * and create channels accordingly.
+	 */
+	ipcc->num_chans = 0;
+	for_each_node_with_property(client_dn, "mboxes") {
+		if (!of_device_is_available(client_dn))
+			continue;
+		i = of_count_phandle_with_args(client_dn,
+						"mboxes", "#mbox-cells");
+		for (j = 0; j < i; j++) {
+			ret = of_parse_phandle_with_args(client_dn, "mboxes",
+						"#mbox-cells", j, &curr_ph);
+			of_node_put(curr_ph.np);
+			if (!ret && curr_ph.np == controller_dn) {
+				ipcc->num_chans++;
+				break;
+			}
+		}
+	}
+
+	/* If no clients are found, skip registering as a mbox controller */
+	if (!ipcc->num_chans)
+		return 0;
+
+	ipcc->chans = devm_kcalloc(dev, ipcc->num_chans,
+					sizeof(struct mbox_chan), GFP_KERNEL);
+	if (!ipcc->chans)
+		return -ENOMEM;
 
 	mbox = &ipcc->mbox;
 	mbox->dev = dev;
-	mbox->num_chans = IPCC_MBOX_MAX_CHAN;
-	mbox->chans = ipcc->chan;
+	mbox->num_chans = ipcc->num_chans;
+	mbox->chans = ipcc->chans;
 	mbox->ops = &ipcc_mbox_chan_ops;
 	mbox->of_xlate = qcom_ipcc_mbox_xlate;
 	mbox->txdone_irq = false;
@@ -233,7 +278,7 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 	if (!ipcc->irq_domain)
 		return -ENOMEM;
 
-	ret = qcom_ipcc_setup_mbox(ipcc);
+	ret = qcom_ipcc_setup_mbox(ipcc, pdev->dev.of_node);
 	if (ret)
 		goto err_mbox;
 
@@ -241,7 +286,7 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_HIGH, "ipcc", ipcc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
-		goto err_mbox;
+		goto err_req_irq;
 	}
 
 	enable_irq_wake(ipcc->irq);
@@ -249,6 +294,9 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_req_irq:
+	if (ipcc->num_chans)
+		mbox_controller_unregister(&ipcc->mbox);
 err_mbox:
 	irq_domain_remove(ipcc->irq_domain);
 
-- 
2.53.0

