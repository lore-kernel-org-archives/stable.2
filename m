Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282322;
	b=uZ8yGpmTtyQAgaCrveA1xpQMViO/ca4QmbjOvrCl6Exwguw7r7Tr7Wc0mA2NWZR+p8h4
	 BXtHSEmnfEXFJRuZYN54j2BXkyJxVJ2aKmDvYQFheDKwtLaRKaMpzWwB1IZle28ECAlOa
	 illoSMFpWps6OLKB0rmxpmCwRjgJ8OS9iOGVtECfFPO3Dfyg/knDryKofQWE7s9AMhi0h
	 RU+M0xalQv31POVVrdW0ZP3gUNWQy0nTYAxEwlb8fI4nJeAORCQGlNi+v6jefJSdtmH5X
	 Een/NiFKyKXCNr+0vNFphaqBBpe2QVjZaDZ+OYm/4jFGf3WFnBmSSCUs7EjDq6bwYrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282322;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ig0An5X/cpi8XT1pmU3BIMv5l2G6WyLnjo1QEXsgDxU=;
	b=uX6yhfuK0WCNMfA5+K/6GKYwOwGMaIRiRIqbZjKyDSMdj6iknwW2wS0mvhiW7+GQcWSD
	 fKIFM/9qtY3Bc4Tqxr+GDRUjMSXWrAeUGdqItG9xTKrm4o+j4nYh2+/mc8n895c+Hlrzt
	 bXW8xmXez4krDKBEOb3GpRRy9djn/L9M64PAOLDQfF+I/8xyZlmVXpwClCIMXu4jIAT52
	 VE05GhMVg0BDDQEi1ItzOCXX86kW1TU534f35l/MwNO9944Z1ZHx5RWiX9vjBGc0xVdj1
	 PGKZlcRwmBV4xeEoUI8QMRyHQe/jvI9EwyoBbGBtXhZMx9keuyo5mh2Sp6Zdj6i91mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faPtgsdL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFD606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faPtgsdL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8931F008A2;
	Tue, 10 Nov 2026 03:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282321;
	bh=ig0An5X/cpi8XT1pmU3BIMv5l2G6WyLnjo1QEXsgDxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=faPtgsdLJPtxHpOW7KKBi6tvWEt1OPb9DZ4odc/vyGJL/cyYgd2bqkJO0Yo/8oy2c
	 +qd3zgI9LKXljTC08MvCxBZpo7qv0XwgcoYsbTw1lnCNaewVjt5SoqsnpV42lAgz+Y
	 VfonejyZPoQiTCnM4Z/0wWL0xBiq/RhLFOAdTvIqlFEQ8s76SA1PcnyMkdjVi1y3fd
	 z+W6b4p4XETKFXrRW2RyP6DU6G/FRbz7IfGpigZG/ZHtZ0RxmhD6i3X1cfvCpg5g9z
	 BK6qJ6ZX+wktTdoBwacEJ8e6xO5qXLANo3hlUOdQhoyMWoUz5oAxTUl3cbRopYEf9d
	 agof+1bAsVMbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Meng Yu <yumeng18@huawei.com>,
	Zaibo Xu <xuzaibo@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] crypto: hisilicon/hpre - add algorithm type
Date: Mon,  9 Nov 2026 22:45:16 -0500
Message-ID: <20261110034443.239021-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110034443.239021-1-sashal@kernel.org>
References: <20261107061637-failed-5.10-40ec9605cb19@kernel.org>
 <20261110034443.239021-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meng Yu <yumeng18@huawei.com>

[ Upstream commit 9b94ae729068f6608ec7364dea891ee86dd3dad2 ]

Algorithm type is brought in to get hardware HPRE queue
to support different algorithms.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 40ec9605cb19 ("crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/hpre/hpre.h        | 10 +++++++++-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 12 ++++++------
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 11 +++++++++--
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index e784712b50c1f..7c7bfdd124e0e 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -10,6 +10,14 @@
 #define HPRE_PF_DEF_Q_NUM		64
 #define HPRE_PF_DEF_Q_BASE		0
 
+/*
+ * type used in qm sqc DW6.
+ * 0 - Algorithm which has been supported in V2, like RSA, DH and so on;
+ * 1 - ECC algorithm in V3.
+ */
+#define HPRE_V2_ALG_TYPE	0
+#define HPRE_V3_ECC_ALG_TYPE	1
+
 enum {
 	HPRE_CLUSTER0,
 	HPRE_CLUSTER1,
@@ -90,7 +98,7 @@ struct hpre_sqe {
 	__le32 rsvd1[_HPRE_SQE_ALIGN_EXT];
 };
 
-struct hisi_qp *hpre_create_qp(void);
+struct hisi_qp *hpre_create_qp(u8 type);
 int hpre_algs_register(struct hisi_qm *qm);
 void hpre_algs_unregister(struct hisi_qm *qm);
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 8142a30a52315..7501092463354 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -152,12 +152,12 @@ static void hpre_rm_req_from_ctx(struct hpre_asym_request *hpre_req)
 	}
 }
 
-static struct hisi_qp *hpre_get_qp_and_start(void)
+static struct hisi_qp *hpre_get_qp_and_start(u8 type)
 {
 	struct hisi_qp *qp;
 	int ret;
 
-	qp = hpre_create_qp();
+	qp = hpre_create_qp(type);
 	if (!qp) {
 		pr_err("Can not create hpre qp!\n");
 		return ERR_PTR(-ENODEV);
@@ -422,11 +422,11 @@ static void hpre_alg_cb(struct hisi_qp *qp, void *resp)
 	req->cb(ctx, resp);
 }
 
-static int hpre_ctx_init(struct hpre_ctx *ctx)
+static int hpre_ctx_init(struct hpre_ctx *ctx, u8 type)
 {
 	struct hisi_qp *qp;
 
-	qp = hpre_get_qp_and_start();
+	qp = hpre_get_qp_and_start(type);
 	if (IS_ERR(qp))
 		return PTR_ERR(qp);
 
@@ -674,7 +674,7 @@ static int hpre_dh_init_tfm(struct crypto_kpp *tfm)
 {
 	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
 
-	return hpre_ctx_init(ctx);
+	return hpre_ctx_init(ctx, HPRE_V2_ALG_TYPE);
 }
 
 static void hpre_dh_exit_tfm(struct crypto_kpp *tfm)
@@ -1100,7 +1100,7 @@ static int hpre_rsa_init_tfm(struct crypto_akcipher *tfm)
 		return PTR_ERR(ctx->rsa.soft_tfm);
 	}
 
-	ret = hpre_ctx_init(ctx);
+	ret = hpre_ctx_init(ctx, HPRE_V2_ALG_TYPE);
 	if (ret)
 		crypto_free_akcipher(ctx->rsa.soft_tfm);
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 8da9d6dc6e87a..87acec1597764 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -201,13 +201,20 @@ static u32 vfs_num;
 module_param_cb(vfs_num, &vfs_num_ops, &vfs_num, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63), 0(default)");
 
-struct hisi_qp *hpre_create_qp(void)
+struct hisi_qp *hpre_create_qp(u8 type)
 {
 	int node = cpu_to_node(smp_processor_id());
 	struct hisi_qp *qp = NULL;
 	int ret;
 
-	ret = hisi_qm_alloc_qps_node(&hpre_devices, 1, 0, node, &qp);
+	if (type != HPRE_V2_ALG_TYPE && type != HPRE_V3_ECC_ALG_TYPE)
+		return NULL;
+
+	/*
+	 * type: 0 - RSA/DH. algorithm supported in V2,
+	 *       1 - ECC algorithm in V3.
+	 */
+	ret = hisi_qm_alloc_qps_node(&hpre_devices, 1, type, node, &qp);
 	if (!ret)
 		return qp;
 
-- 
2.53.0

