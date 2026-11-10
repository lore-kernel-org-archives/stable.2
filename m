Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282321;
	b=XJlZtLMac50tSazyUEeVE5T9HqsFx1MdnQsm3kqp7/DNzxFmHUIDjHhWzy3gZw+Gk7yj
	 1V1Cr5OzC2FIl+l2z1/AM5d1kp61JBxFqcEdC2vjdAbGGy6RKcJK7vvG7/VDPleJR9qF/
	 SA7cLW/zDbbUfmkLfurXqJwcfKs2j6CMjz40MsK0aSA5brsIZzT2BmSWx9D4gCVsXWtHJ
	 69Ln31nj2bbQ5aBTP093kDDpZYoLFwH1NkazMFEqxXnHzqiQQU96wmKIbuFwOuk+RtuPW
	 5n+pfSS34a5ckbk6IqVF6ikqZY1veWQKlNy/FQJh2RQyGyYKVoWGkZcUr6hESWtaYrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282321;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7PIBRB5sNJ9XFA4u+dEwjGtswpnRCok3blthxb/KFa4=;
	b=XTcxy+qNtP/EMmXStQWJwcZ48wGHOzQX0A/pvglAZtEglb9gxsxLBVpjD+VpJRl+qT+t
	 TCPdDdrrdDFA2u9j8ec5XjoJ8Sc9TNVE0bGohKO3KhGg5eiMi/S7cu9E2hFkEdxyraPpU
	 fVluFBnE7l1djHT6TzF0KBc7ACzQOAD+9PGD6QwuvGZfT3Gq0UGGBYM3F0NOusWmIBnRf
	 lcaptqy57zC3KafxAOHiNlI5kpnQ74OAFFxs0vjKY6NCSNtf4UmSM27es5ISBqEmX01Dl
	 rriEcN6a8XCXC8otwOO6MKaH7k5hN94L4xlI7sG5CaCo4t13t2+FsZrfl8d1iPS23sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M4Gg1s/2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4Gg1s/2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEE91F0089F;
	Tue, 10 Nov 2026 03:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282320;
	bh=7PIBRB5sNJ9XFA4u+dEwjGtswpnRCok3blthxb/KFa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M4Gg1s/2coW9nGzJm4P7xKOg/oXBAZattF2G7+Ufh1huUxpICmueSGZSDW47emnsP
	 wBdqps6U4pR5gict8hv1RXewU5mzDol8pvKxtoeVV9eKHxunKqzG4Y/mVNyi6TQdaT
	 pO6K6DMA4kTlKF5JP+AR9R6SdEezsQlx+acfulxFHk5uMQD92jsBcAUhOUuxe5GbjP
	 AaMIIraoI85vZoTQ8bdSzDwR+5x8GhLmdR2ZLX6WHLidtAXe3jov5TRsVjMq4ok9z0
	 hOd142NpbZcg8kxXxEM8wPIBUF6f/OExeqwRYtXd0gtN974KlKYR5CSKzKBS8iHhRj
	 BzOZJULai2ZqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Meng Yu <yumeng18@huawei.com>,
	Zaibo Xu <xuzaibo@huawei.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] crypto: hisilicon/hpre - add version adapt to new algorithms
Date: Mon,  9 Nov 2026 22:45:15 -0500
Message-ID: <20261110034443.239021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061637-failed-5.10-40ec9605cb19@kernel.org>
References: <20261107061637-failed-5.10-40ec9605cb19@kernel.org>
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

[ Upstream commit 8123455a648581ed08b1740e4fc33863eb353687 ]

A new generation of accelerator Kunpeng930 has appeared, and the
corresponding driver needs to be updated to support some new
algorithms of Kunpeng930. To be compatible with Kunpeng920, we
add parameter 'struct hisi_qm *qm' to sec_algs_(un)register to
identify the chip's version.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Reviewed-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 40ec9605cb19 ("crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/hpre/hpre.h        | 5 +++--
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 4 ++--
 drivers/crypto/hisilicon/qm.c               | 4 ++--
 drivers/crypto/hisilicon/qm.h               | 4 ++--
 drivers/crypto/hisilicon/sec2/sec.h         | 4 ++--
 drivers/crypto/hisilicon/sec2/sec_crypto.c  | 4 ++--
 drivers/crypto/hisilicon/sec2/sec_crypto.h  | 4 ++--
 drivers/crypto/hisilicon/zip/zip.h          | 4 ++--
 drivers/crypto/hisilicon/zip/zip_crypto.c   | 4 ++--
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index f69252b24671b..e784712b50c1f 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -91,7 +91,8 @@ struct hpre_sqe {
 };
 
 struct hisi_qp *hpre_create_qp(void);
-int hpre_algs_register(void);
-void hpre_algs_unregister(void);
+int hpre_algs_register(struct hisi_qm *qm);
+void hpre_algs_unregister(struct hisi_qm *qm);
+
 
 #endif
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 4477a781bc3f9..8142a30a52315 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -1154,7 +1154,7 @@ static struct kpp_alg dh = {
 };
 #endif
 
-int hpre_algs_register(void)
+int hpre_algs_register(struct hisi_qm *qm)
 {
 	int ret;
 
@@ -1171,7 +1171,7 @@ int hpre_algs_register(void)
 	return ret;
 }
 
-void hpre_algs_unregister(void)
+void hpre_algs_unregister(struct hisi_qm *qm)
 {
 	crypto_unregister_akcipher(&rsa);
 #ifdef CONFIG_CRYPTO_DH
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 8988ee714ce12..b62f3240313fd 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3960,7 +3960,7 @@ int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 	mutex_unlock(&qm_list->lock);
 
 	if (flag) {
-		ret = qm_list->register_to_crypto();
+		ret = qm_list->register_to_crypto(qm);
 		if (ret) {
 			mutex_lock(&qm_list->lock);
 			list_del(&qm->list);
@@ -3988,7 +3988,7 @@ void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 	mutex_unlock(&qm_list->lock);
 
 	if (list_empty(&qm_list->list))
-		qm_list->unregister_from_crypto();
+		qm_list->unregister_from_crypto(qm);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_alg_unregister);
 
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index aaad3d76dc04e..9382dfd3b81b6 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -193,8 +193,8 @@ struct hisi_qm_err_ini {
 struct hisi_qm_list {
 	struct mutex lock;
 	struct list_head list;
-	int (*register_to_crypto)(void);
-	void (*unregister_from_crypto)(void);
+	int (*register_to_crypto)(struct hisi_qm *qm);
+	void (*unregister_from_crypto)(struct hisi_qm *qm);
 };
 
 struct hisi_qm {
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 249735b7ceca3..fe321dd98a57f 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -184,6 +184,6 @@ struct sec_dev {
 
 void sec_destroy_qps(struct hisi_qp **qps, int qp_num);
 struct hisi_qp **sec_create_qps(void);
-int sec_register_to_crypto(void);
-void sec_unregister_from_crypto(void);
+int sec_register_to_crypto(struct hisi_qm *qm);
+void sec_unregister_from_crypto(struct hisi_qm *qm);
 #endif
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index ce2ff9538c8dc..8d5ee35afd091 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -1632,7 +1632,7 @@ static struct aead_alg sec_aeads[] = {
 		     AES_BLOCK_SIZE, AES_BLOCK_SIZE, SHA512_DIGEST_SIZE),
 };
 
-int sec_register_to_crypto(void)
+int sec_register_to_crypto(struct hisi_qm *qm)
 {
 	int ret;
 
@@ -1649,7 +1649,7 @@ int sec_register_to_crypto(void)
 	return ret;
 }
 
-void sec_unregister_from_crypto(void)
+void sec_unregister_from_crypto(struct hisi_qm *qm)
 {
 	crypto_unregister_skciphers(sec_skciphers,
 				    ARRAY_SIZE(sec_skciphers));
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 20f11e5bbf1d5..e4515714570da 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -210,6 +210,6 @@ struct sec_sqe {
 	struct sec_sqe_type2 type2;
 };
 
-int sec_register_to_crypto(void);
-void sec_unregister_from_crypto(void);
+int sec_register_to_crypto(struct hisi_qm *qm);
+void sec_unregister_from_crypto(struct hisi_qm *qm);
 #endif
diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index 92397f993e237..9ed74611f722b 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -62,6 +62,6 @@ struct hisi_zip_sqe {
 };
 
 int zip_create_qps(struct hisi_qp **qps, int ctx_num, int node);
-int hisi_zip_register_to_crypto(void);
-void hisi_zip_unregister_from_crypto(void);
+int hisi_zip_register_to_crypto(struct hisi_qm *qm);
+void hisi_zip_unregister_from_crypto(struct hisi_qm *qm);
 #endif
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 5db7cdea994ae..57d7f9750a930 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -665,7 +665,7 @@ static struct acomp_alg hisi_zip_acomp_gzip = {
 	}
 };
 
-int hisi_zip_register_to_crypto(void)
+int hisi_zip_register_to_crypto(struct hisi_qm *qm)
 {
 	int ret;
 
@@ -684,7 +684,7 @@ int hisi_zip_register_to_crypto(void)
 	return ret;
 }
 
-void hisi_zip_unregister_from_crypto(void)
+void hisi_zip_unregister_from_crypto(struct hisi_qm *qm)
 {
 	crypto_unregister_acomp(&hisi_zip_acomp_gzip);
 	crypto_unregister_acomp(&hisi_zip_acomp_zlib);
-- 
2.53.0

