Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994552;
	b=vpDDbMUOeIXp1czgoEW+bgYJwPQGr69X8slEMdt/LJiBIN+GIM8hf9nH9MKBdErOvI1w
	 wwzQRNMO9wwPTGUfZMN+mFkhQJ4u7vs7p3Sw+hCg5EiwbDTDgPdxh5LHa0xDGoiKLOTEr
	 QFzsOScAKFEEwVmoXQIb0QyEZFHDTuLyKfj716FxCJA4V3iT27HvgZ15friEtnHIJm2xz
	 YU1UlgzIKV3rXQwZvPRf52sT3SodBSlGpEkRLytUKSqa/OX1xUlfQARu/tD7djVjhzbwZ
	 Yf6VxWFo4UFNoYwX5ipgcoySdoYXIwNedC1Bv7zRmJZ5j9XelSKkF9XR0WkjS/CXAvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Ly/F24Q2hYwiMQ5vhxGkL8qVuwIGhGpKKIzVi9DbbcM=;
	b=X3465OW/e3z7ZYGYsStBYUHvWjRKNFJ73kED8lM/mfiUP93mBz7K1ln7qQ/YjhJ6tI8W
	 2CcT9YduDj7I2wmPodPlNu8YxTJALHLkDYSS0MQUJgR+Gb+NDwJBVnUiMPAVzAhaF+OKd
	 OFUycGbRRiNNA1ZlEhj18hnZBtAMm//A/dPBod8bauJQRjDTRibbehWXx1E/tnYCzcQcG
	 RRv6IS0D8YrWpg5TGQihar4UFBrN3FFicm5rPld6IkgfxYge9DZfrdnRw0LtKY1Pbx43p
	 MqkgftST4vNPVbFGRZ/bK3kRdCy9bMV9WQoU6h8eCUZmCJIhsATR0PdfMVTBoENVCew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=MbcmXncG;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DD606A335
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A3DD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=MbcmXncG
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c445c95d553so95461466b.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794994551; x=1795599351; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ly/F24Q2hYwiMQ5vhxGkL8qVuwIGhGpKKIzVi9DbbcM=;
        b=MbcmXncG0y1iLs1skBz7D4OPWNdf2/AUylZf6668NraHrV2T7Gycd9uCEUHuRpHz9m
         yudjtTWL1mdOTKe2FMHnT/E+GmzumX3Rrmu8F2c6YQw+MHARNdXt3kIjxnObxyjrzPb5
         1lNuLaS+JaLCA36JSrshDKLoT6d37gRvHUK/KxrWr0Cnj2M769+s3qkoAzGZCaiNVAF5
         gujm3OpAIFtOoLvik5c9qTzzERDvy4WFrO0XAem+8xqih8ZYg99S1/bHo3ottABa15oS
         iq3YQh7J58YAZKxluLXU5EjEByM/evOVnzFF4hhgNosE5SQCVPePSP4MZsSMFd2CGSWr
         4fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994551; x=1795599351;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ly/F24Q2hYwiMQ5vhxGkL8qVuwIGhGpKKIzVi9DbbcM=;
        b=2T6ln03KTIzXTHs17FXAIalJ0vCI5WdzeyGzt4aqutytoNvHx0XJbFYwMtxTsmiQvG
         obk3UjervKJ3QsLD4iLvVg+VjRfdCqFgxZ6TEV7ivxozdGp7P42pvEp5agPCrDV4gAbw
         LGFIt+gluhNpk72ffZT/tGt8emasY04aiJhGzYINGo3B2tWg/v0HH8R7neVgtO+uq6GL
         UowYJDO9i+sl8ZvvnYyrKD52OiLiu5c9iD8XiFqPzNKB+8jY4qp65jf8VXVCAHv3JIHH
         ryGm4JzjNCpB5+LGHAAQcS5V7SUv9kxCVpU2+H/CznYNB4rNPQ76LsIptNdNIq7WR5+j
         UUUA==
X-Gm-Message-State: APuU4Z8Mnm/z/7q2p6mglVpPjSLFfwYYuF28YhUD/do85n6J3yj1suyt
	AREUQ+nZMqwy367oBMD+AkitLXY+Du/zqH+EIPiXL3GENA3WXvytiw7OAS8JwH/Jwl7l58CyJq0
	3+YPnvy7X+g==
X-Gm-Gg: AYBFou2UvZysQn0xbApba0t8rWCAAs/DdNxa2GASfU+F+eIEmMr5e1k+f5wnzCs2tfk
	Atbv4QBV6fEH8mKfTsV1up0QQ8vHazPx3tMYVb2KFY6Fa8k1uYyjkxgrbUk6RXqyD+cJaKHbxU/
	sCVo9cCtAP76649R6sRl5nZ1dnNVClb9943afdtJB55fTShTS0BiibBz7iNBwkgIBbnFm7zwYA1
	EUCowhSqa4sKtR3ZqYnCqDDwkVyT6G3rOgU/eoVKi9IFGjyXHm4lcXcpUKd1Z1ZLD8u204thBrA
	qtRlKP9c9kWp67kFAxXo1MiuGQxBkz7E70KeWF9P9hJ5sVm9GLP+9foyNJk6Wp4oL++VyeO/3Dm
	NPDSTblG7f9GTgl+hRq4fDl0BVughPXGmzJESV5WtO+o1Z6XToBhJ4jqPpXc3rpRAALJLYi1XGc
	aLSlfJlYqaeUSKL0tUOClDqjxwuq875EIWR1w/zTI4xCtNp/gHaQ7t+TBBX7/KyvkrrzYXhDDId
	aJ/I4Td5Gkh41l2KRNHI84evHE4Cib39GNHisDoc85Yr3uBvwYLf0FmdfT6bvOZMee7Vu6W/jDn
	tMripvSx1p3ty7EEIBm/Q79646zMQbCmpP0yv5RnCTbzlMGxzjXFmFIO7umdnW/slv6y3zbAvHu
	uT21LQv8=
X-Received: by 2002:a17:907:d16:b0:c50:f1c5:f815 with SMTP id a640c23a62f3a-c510e3c960cmr165683266b.31.1794994550600;
        Wed, 18 Nov 2026 01:35:50 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab3000sm75275066b.56.2026.11.18.01.35.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:35:50 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Nov 2026 10:35:43 +0100
Subject: [PATCH 5.15.y 5.10.y 3/4] sign-file,extract-cert: use pkcs11
 provider for OPENSSL MAJOR >= 3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-openssl4-515-v1-3-e1fbd1da96d4@fairphone.com>
References: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
In-Reply-To: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
To: stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794994548; l=8391;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=zVyzzOljbY+dCeWDG34fL5CDSWoJK3l8gxI0xpFTFE4=;
 b=DdWCXSW0LfHwg+aLey0p+98KaFdU6PJVg7biX3/Puhpcdv1acGKHE3uUpKdInOPTzIIHFRg2L
 FVOpYVjjvEEDNXTkmvzh8bAaWjetVeOJyDITj8IGunN2ve6EHuTn1tT
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Jan Stancek <jstancek@redhat.com>

commit 558bdc45dfb2669e1741384a0c80be9c82fa052c upstream.

ENGINE API has been deprecated since OpenSSL version 3.0 [1].
Distros have started dropping support from headers and in future
it will likely disappear also from library.

It has been superseded by the PROVIDER API, so use it instead
for OPENSSL MAJOR >= 3.

[1] https://github.com/openssl/openssl/blob/master/README-ENGINES.md

[jarkko: fixed up alignment issues reported by checkpatch.pl --strict]

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 scripts/extract-cert.c | 103 +++++++++++++++++++++++++++++++++++--------------
 scripts/sign-file.c    |  95 +++++++++++++++++++++++++++++++--------------
 2 files changed, 139 insertions(+), 59 deletions(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index 8101549c98ae..6d9886024c5d 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -21,17 +21,18 @@
 #include <openssl/bio.h>
 #include <openssl/pem.h>
 #include <openssl/err.h>
-#include <openssl/engine.h>
-
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
 #include "ssl-common.h"
 
-/*
- * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
- *
- * Remove this if/when that API is no longer used
- */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 #define PKEY_ID_PKCS7 2
 
 static __attribute__((noreturn))
@@ -61,6 +62,66 @@ static void write_cert(X509 *x509)
 		fprintf(stderr, "Extracted cert: %s\n", buf);
 }
 
+static X509 *load_cert_pkcs11(const char *cert_src)
+{
+	X509 *cert = NULL;
+#ifdef USE_PKCS11_PROVIDER
+	OSSL_STORE_CTX *store;
+
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(cert_src, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_CERT) {
+			cert = OSSL_STORE_INFO_get1_CERT(info);
+			ERR(!cert, "OSSL_STORE_INFO_get1_CERT");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (cert)
+			break;
+	}
+	OSSL_STORE_close(store);
+#elif defined(USE_PKCS11_ENGINE)
+		ENGINE *e;
+		struct {
+			const char *cert_id;
+			X509 *cert;
+		} parms;
+
+		parms.cert_id = cert_src;
+		parms.cert = NULL;
+
+		ENGINE_load_builtin_engines();
+		drain_openssl_errors(__LINE__, 1);
+		e = ENGINE_by_id("pkcs11");
+		ERR(!e, "Load PKCS#11 ENGINE");
+		if (ENGINE_init(e))
+			drain_openssl_errors(__LINE__, 1);
+		else
+			ERR(1, "ENGINE_init");
+		if (key_pass)
+			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
+		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
+		ERR(!parms.cert, "Get X.509 from PKCS#11");
+		cert = parms.cert;
+#else
+		fprintf(stderr, "no pkcs11 engine/provider available\n");
+		exit(1);
+#endif
+	return cert;
+}
+
 int main(int argc, char **argv)
 {
 	char *cert_src;
@@ -86,28 +147,10 @@ int main(int argc, char **argv)
 		fclose(f);
 		exit(0);
 	} else if (!strncmp(cert_src, "pkcs11:", 7)) {
-		ENGINE *e;
-		struct {
-			const char *cert_id;
-			X509 *cert;
-		} parms;
+		X509 *cert = load_cert_pkcs11(cert_src);
 
-		parms.cert_id = cert_src;
-		parms.cert = NULL;
-
-		ENGINE_load_builtin_engines();
-		drain_openssl_errors(__LINE__, 1);
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
-		if (ENGINE_init(e))
-			drain_openssl_errors(__LINE__, 1);
-		else
-			ERR(1, "ENGINE_init");
-		if (key_pass)
-			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
-		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
-		ERR(!parms.cert, "Get X.509 from PKCS#11");
-		write_cert(parms.cert);
+		ERR(!cert, "load_cert_pkcs11 failed");
+		write_cert(cert);
 	} else {
 		BIO *b;
 		X509 *x509;
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index bb3fdf1a617c..7070245edfc1 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -27,17 +27,18 @@
 #include <openssl/evp.h>
 #include <openssl/pem.h>
 #include <openssl/err.h>
-#include <openssl/engine.h>
-
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
 #include "ssl-common.h"
 
-/*
- * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
- *
- * Remove this if/when that API is no longer used
- */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 /*
  * Use CMS if we have openssl-1.0.0 or newer available - otherwise we have to
  * assume that it's not available and its header file is missing and that we
@@ -106,28 +107,64 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
 	return pwlen;
 }
 
+static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
+{
+	EVP_PKEY *private_key = NULL;
+#ifdef USE_PKCS11_PROVIDER
+	OSSL_STORE_CTX *store;
+
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
+			private_key = OSSL_STORE_INFO_get1_PKEY(info);
+			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (private_key)
+			break;
+	}
+	OSSL_STORE_close(store);
+#elif defined(USE_PKCS11_ENGINE)
+	ENGINE *e;
+
+	ENGINE_load_builtin_engines();
+	drain_openssl_errors(__LINE__, 1);
+	e = ENGINE_by_id("pkcs11");
+	ERR(!e, "Load PKCS#11 ENGINE");
+	if (ENGINE_init(e))
+		drain_openssl_errors(__LINE__, 1);
+	else
+		ERR(1, "ENGINE_init");
+	if (key_pass)
+		ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
+	private_key = ENGINE_load_private_key(e, private_key_name, NULL, NULL);
+	ERR(!private_key, "%s", private_key_name);
+#else
+	fprintf(stderr, "no pkcs11 engine/provider available\n");
+	exit(1);
+#endif
+	return private_key;
+}
+
 static EVP_PKEY *read_private_key(const char *private_key_name)
 {
-	EVP_PKEY *private_key;
-
 	if (!strncmp(private_key_name, "pkcs11:", 7)) {
-		ENGINE *e;
-
-		ENGINE_load_builtin_engines();
-		drain_openssl_errors(__LINE__, 1);
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
-		if (ENGINE_init(e))
-			drain_openssl_errors(__LINE__, 1);
-		else
-			ERR(1, "ENGINE_init");
-		if (key_pass)
-			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
-			    "Set PKCS#11 PIN");
-		private_key = ENGINE_load_private_key(e, private_key_name,
-						      NULL, NULL);
-		ERR(!private_key, "%s", private_key_name);
+		return read_private_key_pkcs11(private_key_name);
 	} else {
+		EVP_PKEY *private_key;
 		BIO *b;
 
 		b = BIO_new_file(private_key_name, "rb");
@@ -136,9 +173,9 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 						      NULL);
 		ERR(!private_key, "%s", private_key_name);
 		BIO_free(b);
-	}
 
-	return private_key;
+		return private_key;
+	}
 }
 
 static X509 *read_x509(const char *x509_name)

-- 
2.56.1

