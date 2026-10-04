Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F202223DFF
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791078049; cv=none; b=mkduyiXfOBwaWHQRx4KepctqQXzYxVJqywGFND5Dy8oKxVPrT7T/FGThT3+SBsa2JEJn70SvxAsbx5Q/nPWi5HNxHO4zxzfnGGeY5nQGqpYyldDbus/kUNRYkatERgGpmBPMlTGVeMmEMK+5FEYGwiflNQtOmAjRH3qaRJhUlsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791078049; c=relaxed/simple;
	bh=pDfT4KP3r/+fdCDOCRY6EdaKs+iciNqmaLwdouy0ZoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToBj7ptPSpfdDCkgNyxCmm3gWXZwvwXKeRZNFAZlRpGoNZ5w9SaILexFi+MFnHVqX3j/ATEcTXfHHgjVTvB1SNvpGoC+WhnLnv2mTBMQPlbQChHS9kl6PpvQQ9lt9I0B6Kl7rv8tFkhVHVtXrdggy9IG6pzW2ybPC2s0V2aVDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXWeqJMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXWeqJMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9407A1F0089B;
	Sun,  4 Oct 2026 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791078048;
	bh=0peAUhau9x3YNX8KE/TDRDLOMKB7pKsGw5bb+0LdkwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXWeqJMOgPS2GR6fmIL7dn7/TR+mENK9Yk9LvH5hJDE4HXE8hDlpBzGvYLUN4b39X
	 l9mGutN/OeZWSpa44qj8RGBrdFgaRzl1d2CIoXYkgn7mcI61Ob3gjxuO2Aof01MvBY
	 b7zsVsTSFT/38BlvXF/NWsC7s0VcRxrk5adhyS5hh4gnfZT1gOlH0Fwt6glAGkRuB5
	 AQtIk7Ie/Kb8oKMXfB12QIWNP8xzq/ZLtcoU0+Zeb1QKijnNrwTRlHJvoH8MCWS+aA
	 grFYCp2SJm9Ehwr22Pl/qehR/QRvq8ezTVJiEPXh8LsyKME8NjIpv8qBl82PmVTjVD
	 SHkLwWKJVTB3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ross Philipson <ross.philipson@gmail.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Alec Brown <alec.r.brown@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/8] tpm: Move TPM common base definitions to the command header
Date: Sat,  3 Oct 2026 21:39:58 -0400
Message-ID: <20261004012400.1311672-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004012400.1311672-1-sashal@kernel.org>
References: <2026100307-vacancy-udder-83a1@gregkh>
 <20261004012400.1311672-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ross Philipson <ross.philipson@gmail.com>

[ Upstream commit 88c5a62c3af7ca6f36dc6ffc52bcfb29cd2990cb ]

These are top level definitions shared by both TPM 1 and 2
family chips. This includes core definitions like TPM localities,
common crypto algorithm IDs, and the base TPM command header.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 9b522400bf5c ("tpm: fix off-by-four bounds check in tpm2_get_random()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm.h      |  1 -
 include/linux/tpm.h         | 50 +-------------------
 include/linux/tpm_command.h | 91 +++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 50 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 680f89d9c9f95..fa554c5ad80b1 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -33,7 +33,6 @@
 #endif
 
 #define TPM_MINOR		224	/* officially assigned */
-#define TPM_BUFSIZE		4096
 #define TPM_NUM_DEVICES		65536
 #define TPM_RETRY		50
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8551b24c2bff3..3630b2ea6aefa 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -27,49 +27,12 @@
 
 #include <linux/tpm_command.h>
 
-#define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-
-#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
-#define TPM2_MAX_PCR_BANKS	8
-
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
 /* opaque structure, holds auth session parameters like the session key */
 struct tpm2_auth;
 
-/* if you add a new hash to this, increment TPM_MAX_HASHES below */
-enum tpm_algorithms {
-	TPM_ALG_ERROR		= 0x0000,
-	TPM_ALG_SHA1		= 0x0004,
-	TPM_ALG_AES		= 0x0006,
-	TPM_ALG_KEYEDHASH	= 0x0008,
-	TPM_ALG_SHA256		= 0x000B,
-	TPM_ALG_SHA384		= 0x000C,
-	TPM_ALG_SHA512		= 0x000D,
-	TPM_ALG_NULL		= 0x0010,
-	TPM_ALG_SM3_256		= 0x0012,
-	TPM_ALG_ECC		= 0x0023,
-	TPM_ALG_CFB		= 0x0043,
-};
-
-/*
- * maximum number of hashing algorithms a TPM can have.  This is
- * basically a count of every hash in tpm_algorithms above
- */
-#define TPM_MAX_HASHES	5
-
-struct tpm_digest {
-	u16 alg_id;
-	u8 digest[TPM2_MAX_DIGEST_SIZE];
-} __packed;
-
-struct tpm_bank_info {
-	u16 alg_id;
-	u16 digest_size;
-	u16 crypto_id;
-};
-
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
@@ -127,7 +90,7 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
-/* fixed define for the curve we use which is NIST_P256 */
+/* Fixed define for the curve we use which is NIST_P256 */
 #define EC_PT_SZ	32
 
 /*
@@ -209,8 +172,6 @@ struct tpm_chip {
 #endif
 };
 
-#define TPM_HEADER_SIZE		10
-
 static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
 {
 	return handle >> 24;
@@ -239,15 +200,6 @@ enum tpm_chip_flags {
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
-struct tpm_header {
-	__be16 tag;
-	__be32 length;
-	union {
-		__be32 ordinal;
-		__be32 return_code;
-	};
-} __packed;
-
 enum tpm_buf_flags {
 	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 9dd903dd6b5c1..fc446a1282e2c 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_TPM_COMMAND_H__
 #define __LINUX_TPM_COMMAND_H__
 
+#include <crypto/sha2.h>
+
 /*
  * == TPM 1 Family Chips ==
  *
@@ -427,4 +429,93 @@ struct tpm2_context {
 	__be16 blob_size;
 } __packed;
 
+/*
+ * == TPM Common Defs ==
+ */
+
+#define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
+#define TPM_BUFSIZE		4096
+
+/*
+ * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
+ */
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+
+/*
+ * A TPM name digest i.e., TPMT_HA, is a concatenation of TPM_ALG_ID of the
+ * name algorithm and hash of TPMT_PUBLIC.
+ */
+#define TPM2_MAX_NAME_SIZE	(TPM2_MAX_DIGEST_SIZE + 2)
+
+/*
+ * Fixed define for the size of a name.  This is actually HASHALG size
+ * plus 2, so 32 for SHA256
+ */
+#define TPM2_NULL_NAME_SIZE	34
+
+/*
+ * The maximum number of PCR banks.
+ */
+#define TPM2_MAX_PCR_BANKS	8
+
+/* If you add a new hash to this, increment TPM_MAX_HASHES below */
+enum tpm_algorithms {
+	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_AES		= 0x0006,
+	TPM_ALG_KEYEDHASH	= 0x0008,
+	TPM_ALG_SHA256		= 0x000B,
+	TPM_ALG_SHA384		= 0x000C,
+	TPM_ALG_SHA512		= 0x000D,
+	TPM_ALG_NULL		= 0x0010,
+	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_ECC		= 0x0023,
+	TPM_ALG_CFB		= 0x0043,
+};
+
+/*
+ * The locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+enum tpm_localities {
+	TPM_LOCALITY_0		= 0, /* Static RTM */
+	TPM_LOCALITY_1		= 1, /* Dynamic OS */
+	TPM_LOCALITY_2		= 2, /* DRTM Environment */
+	TPM_LOCALITY_3		= 3, /* Aux Components */
+	TPM_LOCALITY_4		= 4, /* CPU DRTM Establishment */
+	TPM_MAX_LOCALITY	= TPM_LOCALITY_4
+};
+
+/*
+ * Structure to represent active PCR algorithm banks usable by the
+ * TPM chip.
+ */
+struct tpm_bank_info {
+	u16 alg_id;
+	u16 digest_size;
+	u16 crypto_id;
+};
+
+/*
+ * Maximum number of hashing algorithms a TPM can have.  This is
+ * basically a count of every hash in tpm_algorithms above
+ */
+#define TPM_MAX_HASHES		5
+
+struct tpm_digest {
+	u16 alg_id;
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
+} __packed;
+
+#define TPM_HEADER_SIZE		10
+
+struct tpm_header {
+	__be16 tag;
+	__be32 length;
+	union {
+		__be32 ordinal;
+		__be32 return_code;
+	};
+} __packed;
+
 #endif
-- 
2.53.0

