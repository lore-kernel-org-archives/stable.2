Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616555;
	b=2/nRmR80ICZvH0+ZHDr5WnOYpLWd4SGTwpceuDnkOhAJOjQpq9XeYJ4A6lwfsKCUKEIU
	 ZkP5bRWF6fsqX5SU2eMl52i2UzaJcJ/++0biNPd8LAhE/clGrfC5FXXuUzjhlpyrKQGmb
	 ImktxQkzMlbSpYlHdiKzArHZaPcAV7y/+lN9P0Q9gU8GEYGfj+4lo34ANpcwMDa8vpzU0
	 ao5H4Epfmr3ci2wPbB3GVhMwmaG7zQxIuX7ZPN07a537yZCGtHt3E7nFirw+fZR0bqlDq
	 qm38/hvJ0cm9USWdUGLQhSCZgKKO3yjhlStwKOw5ITYqw4fu1OmUkRZplxw/CBXXwWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616555;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=XkFRux2cvcc2fwND4RnTaahs4/FvfgM3BDyZJBB2wsg=;
	b=M8CI9eXqsp6f6GivOdJ9w2xmajHLrWMqu+t1KhLOEgonKixQQSa/uYXuUMbmGYBGCs1g
	 rVuKgws8LuoozRvi7xXcUC340VxfjMzi+lnHjMiCNjA2E2uLXhtzzWTp9L3xDhLQbSmNt
	 jB9kKuPTus+medRpHXb30pmp2JGFMOa/wUGSfbgInZeAz0e3qRcLA3/WpO2pODRGlKbpl
	 NGB4W8fBABgu/YE/vPhmSZbyXu34hJqjIAEs1TuXQm8+gkryRZGaOSfBLHqn+ss6hXygp
	 dVoa33E/n8C//uQiM987pSVFUlcKQ7pR27av8VHMixGIWTtz26OaEnKQsf6tmCXh3LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=BXQxqPRt;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF1606A321;
	Wed, 21 Oct 2026 21:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFF1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=BXQxqPRt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XkFRux2cvcc2fwND4RnTaahs4/FvfgM3BDyZJBB2wsg=; b=BXQxqPRthdgJ2wRJewPDhHKdpY
	61vzI3m2/gZ09FzrAlbPJCjc3ODRVDr54B8RbLtzKtWTJOlm6gG60VmnWhYwt/9bSk7K8wxW6G9VH
	5TtBf3b6g6cGYQjgUtbtKvwAL3l5UEB4b18iNWzBn9sciMgGLQF7Jg9XCCv1sx1qD90Y+CoJkwR54
	68A30kuK6Spl08v+OfySX3iHu7tNy5dbVpb0yCqu4ytaVCRdklgu3FBa15/QPF/6jT1/JCfwPiUIi
	81U4xKxpAui/aXQI14QC4g50S26eqST7MXkFFtY+ABftr8SpEPmon8EyHZOllpLbrU1eC56nXV+H4
	nrvcM8NQ==;
Received: from [151.115.150.205] (port=53842 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xJdSF-0000000EZvy-0URC;
	Wed, 21 Oct 2026 23:02:32 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] ima: discard modsig when detached data cannot be supplied
Date: Wed, 21 Oct 2026 21:01:46 +0000
Message-ID: <20261021210145.1851396-4-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

ima_collect_modsig() supplies the file contents to the parsed PKCS#7
message as detached data. If the message already contains embedded data,
pkcs7_supply_detached_data() returns -EINVAL, but IMA ignores the error.
ima_modsig_verify() then verifies the embedded data instead of the file
being appraised.

Make ima_collect_modsig() report whether the file data was supplied,
and discard the modsig if it was not. 

Fixes: 15588227e086 ("ima: Collect modsig")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---

v1: https://lore.kernel.org/all/20260822082434.489470-2-Jeremy.Jean@oss.cyber.gouv.fr/
v2: https://lore.kernel.org/all/20260924085516.3111521-2-Jeremy.Jean@oss.cyber.gouv.fr/

 Documentation/security/IMA-templates.rst  |  3 ++-
 security/integrity/ima/ima.h              |  7 ++++---
 security/integrity/ima/ima_api.c          | 10 +++++++---
 security/integrity/ima/ima_main.c         |  2 +-
 security/integrity/ima/ima_modsig.c       | 16 +++++++++++-----
 security/integrity/ima/ima_template_lib.c |  4 ++--
 6 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 15b4add314fc..de7a3dfee33d 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -69,7 +69,8 @@ descriptors by adding their identifier to the format string
    algorithm (field format: <hash algo>:digest);
  - 'd-ngv2': same as d-ng, but prefixed with the "ima" or "verity" digest type
    (field format: <digest type>:<hash algo>:digest);
- - 'd-modsig': the digest of the event without the appended modsig;
+ - 'd-modsig': the digest of the event without the appended modsig, empty
+   when no signature digest can be exported;
  - 'n-ng': the name of the event, without size limitations;
  - 'sig': the file signature, based on either the file's/fsverity's digest[1],
    or the EVM portable signature, if 'security.ima' contains a file hash.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 10214f73ca1e..62be9461de88 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -431,7 +431,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			    void *buf, loff_t size, enum hash_algo algo,
-			    struct modsig *modsig);
+			    struct modsig **modsig);
 void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
@@ -559,7 +559,7 @@ static inline void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig);
-void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
+bool ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
 int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
 			  const u8 **digest, u32 *digest_size);
 int ima_get_raw_modsig(const struct modsig *modsig, const void **data,
@@ -572,9 +572,10 @@ static inline int ima_read_modsig(enum ima_hooks func, const void *buf,
 	return -EOPNOTSUPP;
 }
 
-static inline void ima_collect_modsig(struct modsig *modsig, const void *buf,
+static inline bool ima_collect_modsig(struct modsig *modsig, const void *buf,
 				      loff_t size)
 {
+	return false;
 }
 
 static inline int ima_get_modsig_digest(const struct modsig *modsig,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 122d127e108d..00b83b4538ab 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -235,6 +235,8 @@ static bool ima_get_verity_digest(struct ima_iint_cache *iint,
  *
  * Calculate the file hash, if it doesn't already exist,
  * storing the measurement and i_version in the iint.
+ * If modsig is provided, discard it when detached data cannot be supplied
+ * so ordinary measurement and xattr appraisal can proceed.
  *
  * Must be called with iint->mutex held.
  *
@@ -242,7 +244,7 @@ static bool ima_get_verity_digest(struct ima_iint_cache *iint,
  */
 int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			    void *buf, loff_t size, enum hash_algo algo,
-			    struct modsig *modsig)
+			    struct modsig **modsig)
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
@@ -262,8 +264,10 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	 * the file digest without collecting the modsig in a previous
 	 * measurement rule.
 	 */
-	if (modsig)
-		ima_collect_modsig(modsig, buf, size);
+	if (modsig && *modsig && !ima_collect_modsig(*modsig, buf, size)) {
+		ima_free_modsig(*modsig);
+		*modsig = NULL;
+	}
 
 	if (iint->flags & IMA_COLLECTED)
 		goto out;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ab1e53b3210d..561fbd976a91 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -422,7 +422,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
+	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, &modsig);
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 632c746fd81e..f73d6f1b71c0 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -96,8 +96,12 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
  * Since the modsig is part of the file contents, the hash used in its signature
  * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
  * calculates a separate one for signature verification.
+ *
+ * Digest export is best-effort; not all signatures expose a single digest.
+ *
+ * Return: true if the file data was supplied, false otherwise.
  */
-void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
+bool ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 {
 	int rc;
 
@@ -109,11 +113,13 @@ void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 		sizeof(struct module_signature);
 	rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
 	if (rc)
-		return;
+		return false;
+
+	/* Digest export failure does not preclude signature verification. */
+	pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
+			 &modsig->digest_size, &modsig->hash_algo);
 
-	/* Ask the PKCS7 code to calculate the file hash. */
-	rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
-			      &modsig->digest_size, &modsig->hash_algo);
+	return true;
 }
 
 int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 8a89236f926c..1be78612394a 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -478,8 +478,8 @@ int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
 		if (rc)
 			return rc;
 		else if (hash_algo == HASH_ALGO__LAST || cur_digestsize == 0)
-			/* There was some error collecting the digest. */
-			return -EINVAL;
+			/* Keep the ordinary measurement without an exported digest. */
+			return 0;
 	}
 
 	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
-- 
2.47.3

