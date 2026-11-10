Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282323;
	b=eC/oNzGPRFOKqnK7Sj/v8ynZlLKmKTj9TV0EppXjNmEF+4qIUur+8nKfRE15poDk3Coz
	 C3fhOLQmMT3BNUBc9dcVTJr9KFb5NMR0UuKeVdvk+9JFGM5O3UsDWh98Xx4PbSSN7mGFa
	 CDFCrPaqwsYhG+V+g8Yv68M6jqRHDuAdrdSUcNr+FF2u1LF+KuQcXaaemUePTBfGqUAJ+
	 CNiE9EhEfFhUdR+eoPBKLi4iNjmRrV1IxXeNmRpOKi1xSQYmNAc2tSWI5bdzJ1eN8kFJD
	 +NwTQGQAiSJuayVnvBxgKoGthuX/0pSDckuyM+AOXo7AuS0Ifycj4TiBtNw7AwZgzqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282323;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gXYgU0DjAK5KX2q2HqeIGb9XOA2xHoJERFPwbgwT8dA=;
	b=oCN4i6B6CiOHJzMOPORlqDNif59GFlrhqu+Fbt/pW0NblNUj5lupJQg2v401CdAXPjHE
	 hFO9LKHDG2vBjHuosWJYf4yLEja2HvRld56lZQb3Lj93f13E+z7xn6kbKTtZmHXmYvRpg
	 Y19vY2BbEWXZlCzYjXhn6ijgHIUFBmbyLKUxe8SCgDYQZXbINE0ks7wXKWJdG8VywSMlt
	 Xa9XbvML3AN3Hh+ImHzLWyqKKaKnQrbRY05Tv9Nlim8+CXwc6mUdqmkDvxU6bxn67lsUy
	 Br6Rn61gfwpnlLGT403YA28Hygjm1+I6P86YLSmj+SFyR/94n9L6PwqETP7HJrb3tgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrVehWBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6094606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrVehWBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70EA1F008A1;
	Tue, 10 Nov 2026 03:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282322;
	bh=gXYgU0DjAK5KX2q2HqeIGb9XOA2xHoJERFPwbgwT8dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hrVehWBByq/Dv/0VkGiAzh+fEPTLM2E+9dwIQOrK5V99YYD6Iw6VDcGpC2Q92t3ha
	 2/k/27T758pIUDd1M2Q70NebtFIdRDJhJNH1HqgqFmYhjdJj/d0Gz3t1cRWxxi4kYG
	 xeqrfDaPZeWYJcG9LzAZyxmjQf7GQ+zoP+EQAOQ/dY5zVFMu+K56Ed97i9eaiqgEuB
	 O8Jh6IY4t8szYQXR+gmOfLd8QUj7PA1CA1PlVy3+7XzEjUGxHY0lkxx1IEpaHuxxoV
	 Whc5zMLGE/tFKrlKJFAgNxaoMipkF3w2kHM3L/+Trgsdfv4DtwOIBVYCNrBS59tvmw
	 QmJMzRMfWcsqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Meng Yu <yumeng18@huawei.com>,
	Zaibo Xu <xuzaibo@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] crypto: ecc - expose ecc curves
Date: Mon,  9 Nov 2026 22:45:17 -0500
Message-ID: <20261110034443.239021-3-sashal@kernel.org>
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

[ Upstream commit 14bb76768275a056a91d249525a717019fd46663 ]

Move 'ecc_get_curve' to 'include/crypto/ecc_curve.h', so everyone
in kernel tree can easily get ecc curve params;

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 40ec9605cb19 ("crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/ecc.c               |  5 +++-
 crypto/ecc.h               | 37 ++------------------------
 include/crypto/ecc_curve.h | 53 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 36 deletions(-)
 create mode 100644 include/crypto/ecc_curve.h

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 09067e4b320f5..c8b21c76496c1 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -24,6 +24,7 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <crypto/ecc_curve.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/slab.h>
@@ -42,7 +43,8 @@ typedef struct {
 	u64 m_high;
 } uint128_t;
 
-static inline const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
+
+const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 {
 	switch (curve_id) {
 	/* In FIPS mode only allow P256 and higher */
@@ -54,6 +56,7 @@ static inline const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 		return NULL;
 	}
 }
+EXPORT_SYMBOL(ecc_get_curve);
 
 static u64 *ecc_alloc_digits_space(unsigned int ndigits)
 {
diff --git a/crypto/ecc.h b/crypto/ecc.h
index d4e546b9ad79e..38a81d404821d 100644
--- a/crypto/ecc.h
+++ b/crypto/ecc.h
@@ -26,6 +26,8 @@
 #ifndef _CRYPTO_ECC_H
 #define _CRYPTO_ECC_H
 
+#include <crypto/ecc_curve.h>
+
 /* One digit is u64 qword. */
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
@@ -33,43 +35,8 @@
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
-/**
- * struct ecc_point - elliptic curve point in affine coordinates
- *
- * @x:		X coordinate in vli form.
- * @y:		Y coordinate in vli form.
- * @ndigits:	Length of vlis in u64 qwords.
- */
-struct ecc_point {
-	u64 *x;
-	u64 *y;
-	u8 ndigits;
-};
-
 #define ECC_POINT_INIT(x, y, ndigits)	(struct ecc_point) { x, y, ndigits }
 
-/**
- * struct ecc_curve - definition of elliptic curve
- *
- * @name:	Short name of the curve.
- * @g:		Generator point of the curve.
- * @p:		Prime number, if Barrett's reduction is used for this curve
- *		pre-calculated value 'mu' is appended to the @p after ndigits.
- *		Use of Barrett's reduction is heuristically determined in
- *		vli_mmod_fast().
- * @n:		Order of the curve group.
- * @a:		Curve parameter a.
- * @b:		Curve parameter b.
- */
-struct ecc_curve {
-	char *name;
-	struct ecc_point g;
-	u64 *p;
-	u64 *n;
-	u64 *a;
-	u64 *b;
-};
-
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
new file mode 100644
index 0000000000000..19a35dae88a1b
--- /dev/null
+++ b/include/crypto/ecc_curve.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 HiSilicon */
+
+#ifndef _CRYTO_ECC_CURVE_H
+#define _CRYTO_ECC_CURVE_H
+
+#include <linux/types.h>
+
+/**
+ * struct ecc_point - elliptic curve point in affine coordinates
+ *
+ * @x:		X coordinate in vli form.
+ * @y:		Y coordinate in vli form.
+ * @ndigits:	Length of vlis in u64 qwords.
+ */
+struct ecc_point {
+	u64 *x;
+	u64 *y;
+	u8 ndigits;
+};
+
+/**
+ * struct ecc_curve - definition of elliptic curve
+ *
+ * @name:	Short name of the curve.
+ * @g:		Generator point of the curve.
+ * @p:		Prime number, if Barrett's reduction is used for this curve
+ *		pre-calculated value 'mu' is appended to the @p after ndigits.
+ *		Use of Barrett's reduction is heuristically determined in
+ *		vli_mmod_fast().
+ * @n:		Order of the curve group.
+ * @a:		Curve parameter a.
+ * @b:		Curve parameter b.
+ */
+struct ecc_curve {
+	char *name;
+	struct ecc_point g;
+	u64 *p;
+	u64 *n;
+	u64 *a;
+	u64 *b;
+};
+
+/**
+ * ecc_get_curve() - get elliptic curve;
+ * @curve_id:           Curves IDs:
+ *                      defined in 'include/crypto/ecdh.h';
+ *
+ * Returns curve if get curve succssful, NULL otherwise
+ */
+const struct ecc_curve *ecc_get_curve(unsigned int curve_id);
+
+#endif
-- 
2.53.0

