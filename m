Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782863;
	b=VP6OQzAsv2GmYkn1bvLnEidxV7e2VSK3UNh2KSUuUlP4KzhN4iTu7Bdhqe4odTweIc+6
	 CC2wuqJWFdNA4fWa7u/ILqjlp414fuLBLBQBK1uOlRF9cpXarUkG4h/+q/F0JjV84Wuqp
	 yZpalcZXfZLREZROJ2sCcj+m7FCJxjSEEgSY+mVLsm4o0ug1PnXD2YN546nWvn0uM+v7o
	 f71SsYX27bSsCbzWHG5gNd0iT3aruTfEX5jp3LHO5Z5KpK/gs51e1PIvxcWjalApL0ION
	 wOQAdDeq4oIiBH4JYXOCHTtdaahOpK4ILNmcZ9chn8RoJ+9US/xyiPF+CeWLZ980OHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vmIQUtngFlNvhyn0Se9v5OKBcLzkjaEzyL4mMCGL7iA=;
	b=rC//sBMHJ1B48QWcoMpU8CQgeRgv+H0zvB2MGvJq3wbbgftmWrWi6OGDzBZ+cv22s3eb
	 FMwE4/qXSXt5ntm8sw+CLghXdUQMsyppoEES6tkldkauYsrDzN/3OtQyGzeSLTstm66mH
	 oObIGvz0qSDzEzRRyZQYR9YyJ1KJL5q28fqQff759t2T9UIcBzvFB2Jx2VN01C0AjXF/z
	 IScasL7MRbT5O8JqxiB4CPNsJ4gOO74iGTke+dQzX8ALZFseorJL1rpXz3PZpVetVzWVQ
	 etNpBilgb53yLCiIrOnlmeqtnqeVRgrqOajTg3YwQw4h6cieHj9I34cCdSLpT5ePFKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="drQzCY/z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D5FEC606A323;
	Sun, 15 Nov 2026 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drQzCY/z
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E90411F000C4;
	Sun, 15 Nov 2026 22:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794782863;
	bh=vmIQUtngFlNvhyn0Se9v5OKBcLzkjaEzyL4mMCGL7iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drQzCY/zcArnVbkrH5ozxrhbHxqvht7G5xLpBAoI+YzqGK+JcpE/xcvkqSmbKVfaX
	 hUknJ2m/scdAQ1vGQrUQcbTAlzt8mA9/4MypJ/z8/z6ydej3XdsKgsnEg/DGjm8FJR
	 xgAk60otF/V76ETgpC2RHPkqLfV0Juhyenbzi9XAHy/Ng/xU7etn9PQXycThvub3D1
	 MVacsJulj5FAsIQT8lsvz0zGk+32N7RriJpbC+V6dp+FKHuO84wRbfBl4y0T/VK4pS
	 0aI3Y18+YEh+BLJ3LSqlxVJJB+yz1LZap90XZ+JlCt9yZG4YA5pOzEKc525Dq3yi0/
	 eiNJbwFYvbZCg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	James Morris <jmorris@namei.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] tpm2-sessions: Drop TPM2_NAME_SIZE
Date: Mon, 16 Nov 2026 00:47:19 +0200
Message-ID: <20261115224722.1450498-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115224722.1450498-1-jarkko@kernel.org>
References: <20261115224722.1450498-1-jarkko@kernel.org>
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

