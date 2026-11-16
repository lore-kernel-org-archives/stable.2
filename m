Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790278;
	b=U3wCajb6ADSHWGaFMaWdJUrsU2BnfY/CSDTtWksYh3nr04A3tfbknLzHBBnTnXxquu6I
	 K44bU8vDm55gQVV97/0qMFGfi1FPRXeR3fT5f1SR3z3kwzuv786el4HW9JhuygT5XDRov
	 0UjmADcB0R/wgU520lBkdHpn4kH+WtPzU0wE3UGpZJfshOonxmRbKgEV+NdtGVDaricqk
	 xOiBOgkZkWjd1Xe8gbYQBgzWA17vueUjFIQUJ5SPF1X2xKjOhAoC0Fb0uSd746cvmig98
	 4166PYe6cKg1mO4nEu60bG2R+dThjX8oRW/t0aPC71Mfv4kMeWrvA0y+su3kVTQ5teA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vmIQUtngFlNvhyn0Se9v5OKBcLzkjaEzyL4mMCGL7iA=;
	b=pwOSlYGpeFX+Yx4Nzka1iYYYw1iBoCk2lfOarg8juWrSeC4wj8gKbGv05sqitfKAf19R
	 DO57Vn2+PErKiOv7vGTVGAgXlzjlp/7A4nbo3IXtoZbaeY2+yqd+O/nKYlGQSHpBytqgQ
	 YntWaS/NU8VkNex2pvH7hkWRt9H43DGSSfKjIIT6G7gTfW2T0nvyJvkzccbPx1qwSAv6E
	 HgSA7hD3MThzrVWVmjH+AyAjXc6DKkd0B12EtpiUtd9/uCYUv4CTC2ECWHvvJFZx81QwV
	 m4nJvJvRHPGg3egBF8l7uaGiHMd1K4tn5vZXnmi8O39JpwUBtmKElLj/ufPQ98HZpUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eq7ioAIP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 75340606A31F;
	Mon, 16 Nov 2026 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eq7ioAIP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 89E611F000CA;
	Mon, 16 Nov 2026 00:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790278;
	bh=vmIQUtngFlNvhyn0Se9v5OKBcLzkjaEzyL4mMCGL7iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eq7ioAIPeF0yrZtyfdyYDfwFRm8Z/gSeDVQeqYSHHbiFq0pwZCd/bR7jWAkno9Kuq
	 Ck9/WmPpxTSdTBfbor7i9yYVy4U3okuxCikA7KrNiGt06NiueLAFUV3WGxK96vRSeb
	 9G7/4vUMofnFCrriU6EsbH66pTCCl/RYmHhdroUKQEyjtV+OdaT/ov2rhL/ttuCC4Q
	 vOXeLo/nvSrMJPQM33JywYX9nk1/wqOyrttguBmyDvXlEJ0Q0UWESR0gHRsvnnfxsg
	 3hKBs//kWbIJaNClv/M6NeSnjDgtlsmc7DBrBhQoiCP8nu5Kysd909E3JMJ+ZjqJN6
	 mRI9ydauZlpCQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	James Morris <jmorris@namei.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] tpm2-sessions: Drop TPM2_NAME_SIZE
Date: Mon, 16 Nov 2026 02:51:00 +0200
Message-ID: <20261116005105.1573016-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116005105.1573016-1-jarkko@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
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

TPM2_NAME_SIZE was left to include/linux/tpm.h when the base definitions
were consolidated. Switch struct tpm2_auth to TPM2_MAX_NAME_SIZE and
convert TPM2_NAME_SIZE users to TPM2_NULL_NAME_SIZE, removing the
redundant TPM2_NAME_SIZE definition.

Cc: stable@vger.kernel.org # v7.3+
Fixes: 88c5a62c3af7 ("tpm: Move TPM common base definitions to the command header")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-sysfs.c     | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 8 +-------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index d915307ae833..0f726cf65189 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -318,7 +318,7 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
-	int size = TPM2_NAME_SIZE;
+	int size = TPM2_NULL_NAME_SIZE;
 
 	bin2hex(buf, chip->null_key_name, size);
 	size *= 2;
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 9608e545602c..94c11135beb3 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -137,7 +137,7 @@ struct tpm2_auth {
 	 * we must compute and remember
 	 */
 	u32 name_h[AUTH_MAX_NAMES];
-	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
+	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
 };
 
 #ifdef CONFIG_TCG_TPM2_HMAC
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c3..84c8fe226235 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -94,12 +94,6 @@ struct tpm_chip_seqops {
 /* Fixed define for the curve we use which is NIST_P256 */
 #define EC_PT_SZ	32
 
-/*
- * fixed define for the size of a name.  This is actually HASHALG size
- * plus 2, so 32 for SHA256
- */
-#define TPM2_NAME_SIZE	34
-
 /*
  * The maximum size for an object context
  */
@@ -166,7 +160,7 @@ struct tpm_chip {
 	/* saved context for NULL seed */
 	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
 	 /* name of NULL seed */
-	u8 null_key_name[TPM2_NAME_SIZE];
+	u8 null_key_name[TPM2_NULL_NAME_SIZE];
 	u8 null_ec_key_x[EC_PT_SZ];
 	u8 null_ec_key_y[EC_PT_SZ];
 	struct tpm2_auth *auth;
-- 
2.47.3

