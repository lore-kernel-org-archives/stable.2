Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785527;
	b=3l1MTxuNH1z15eowV7GL7aokUkNvaqG4ux9hFUiTrFmIQR9+u/OiywdnqJCVbzRfpNur
	 cjsHUSPTExiAH/tST1Nfs3mQkWz1hbsyy6fnoLy5Y55UP1MWflVNwMkfr6SJNH2msEc2W
	 fUpWOM6zB5zmBaurFDOIBEuuFHz4CapkYlw+whIa7F1jNmCVq+YXiOcnjcaH3ZVKMcuEd
	 BiTqQnIS3eNODS73uNMH0D/uwwiQ7MnXHeCbAj99ddc4e6kCB8+u/0TntHxKo7CtceYSE
	 dB3rV3OwqkKry2LqTDdC9WITTyh71dNC1afwIVqQjzisKf5sFJ3ZLQ8obw/YvKFqhZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vmIQUtngFlNvhyn0Se9v5OKBcLzkjaEzyL4mMCGL7iA=;
	b=UanS++SRV/vtxqs1cZnR4wZBr/AsgLLiR4K6x2KF9p6lZTik9K6aQDkxmrrlAJmBEY16
	 Bkc7vXK5GfD4Zqctyrdkw/DUjSOTg7OvjVPcgxk1rjbc4DU+rVqO+pYrhXHLuuHJqQ+Ki
	 U7cl6nFCzW5OcrVIrJdCH8/ltRu5bdFpEr5bkcGNbhB2kBnY5Gqn4pEfpN3Q04mHm5PS+
	 QMxuYglRto6LGE+sC/usITJjdNBzzn3hQ0ts4MuiD3bKzNiN0rHv29PiHcyGR8YMnkwT/
	 Q2RB+t2McOWOlsO9W86AtSK3WmITj+lXKsc59iamg9ax8AginZuLRfNrjDuQxgzQB4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwSDbXcH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9A5DA606A329;
	Sun, 15 Nov 2026 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwSDbXcH
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A3D391F000CA;
	Sun, 15 Nov 2026 23:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785527;
	bh=vmIQUtngFlNvhyn0Se9v5OKBcLzkjaEzyL4mMCGL7iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JwSDbXcH0xLVDBjOubneAfKG+BnQveXGPS6YStjpCaqS+DJgTTAMWHDDXH27ClQpV
	 zu7e0qjLI1S5D+KJSs7p0O+v28kvH3i4MzeNhiFGxs6VeZ+7epc2Jq7NOnna4gySzC
	 NaSSX3yp0G7cQdvV3MSYKk+Zz/twPIOPRbZZu5AWHgEeedvx+Ibk9OKK2ByHA5qUE4
	 duSbbRxV3zdbH0mLkYKovi7GFqSjG8yDgEt4XNrPZOkB5GzHNdaemVW20CA3I/13Mk
	 gaXZXtmBwoMheEtQjwMAl928SZL5n4ULIcYz1R9Gsi7614R/H9lojl1GpbpzSIQiu3
	 3YxGEkFNmMTqQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
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
Subject: [PATCH v2 1/4] tpm2-sessions: Drop TPM2_NAME_SIZE
Date: Mon, 16 Nov 2026 01:31:53 +0200
Message-ID: <20261115233156.1485238-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115233156.1485238-1-jarkko@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
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

