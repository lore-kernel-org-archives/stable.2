Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994552;
	b=KX4oAEkheO+kJDSGPTi/EDuq+5FKlfMloQYrddQE1fsBe+EpxKKqbpHdrEa6fpTsDIrL
	 uUa4QS2OYNAgYQ/SKq/+xRQVq8VkDpFE1aqfzZ4GHB7O676AmdpIuR6mYwTuIoBRZUXtk
	 MS+0dR/r59EaZXvFxbFCbnjHYm11doU3Vcyi0WC1EV4z0OqK6XdyrMEBrCF1lipwJ+Tn3
	 JjfGriljNGPqemqiqioKOq5WTkAXRAVoNvc7KUbdSEmkDf0hCt52vgBTmYA5gPfge7kWo
	 HNsclmZ2IC2Fe7oiknzGtxdITESCY4iEOI3Unk8g60Ji+zlQXJTnLom5kQZCjqkSp8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=j9Q7j/lSzpYrZC7nU0P30O2GgF77mxfFgzqRuaAVLyM=;
	b=1ObOIa/wkWtGNW53C2toJgURiMtWJ609NoaKCyQKKn5x/NDBiyqsL2UKn6G99e0MYk3x
	 qp8MSmlzhb0g7z9AtpwrTPZAEEG2+PtSkZoblQb6RDd3ZSjMeN+lQeRHYDNW//a7L3aZu
	 N8TqyypVZBXAYSGJEpYcvt3F9vdA6QtYkkXt1jHE0LoTf5CPznr70AmjcQCcbEv1p+UNc
	 GYKCR9vc/D61bxephqfTHU5Az7Diyt4xnwbgYxO/kEq5kkkOOmsBQLq5UgmCCqR7qSGJn
	 7A4Sb3pwIf4NvRJUySGJjW1znshGlGlZF1CMBBKnUqa6YgGqaKQsA/jEyMBioQg9wKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=0vBVVhdq;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAE606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAAAE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=0vBVVhdq
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso113515466b.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794994550; x=1795599350; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9Q7j/lSzpYrZC7nU0P30O2GgF77mxfFgzqRuaAVLyM=;
        b=0vBVVhdqbh+7qK2uPS80P3GXH5M/W3xHTfrzjMmdbztWKAB9f1cNfia6PulvYoVmo/
         FtHd1xdTVLWOukuvCBhMOrz0gh1ZKs99gpQUBqjLx440kbVzEpFuvXZD4nUGFo2Qqrcg
         wH/Xe9T5FSgXaq16AC9LX+nspVzxEzT5LUr2waJVNwcGk0bxh+y+zV0qaHkg5rzWczfF
         pJV4ELBCYD+/U1/UkLwGLwFNyfotgwba3T2eMwFUErL2OGEjow3IaCHJibGjw2llZjWw
         0LLgqeSnGR+1biEHz1uZSB1636OnpXt9O6+QiNxz3MYjwTqq0nStA+ngmUweWc4C6vYp
         kmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994550; x=1795599350;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9Q7j/lSzpYrZC7nU0P30O2GgF77mxfFgzqRuaAVLyM=;
        b=yUQ6DhOXrFQrjbpLsj/wVR7EYl2lKudWcPk9VtR5USZDfWUWpMjrUl6w8ILepqktPu
         HHRDhRoDj9AgaqqeNIZT7Ux+kClXU/vBAJA77btOuXrYGKDPb4EEb58LtBCaCP1ZSNQG
         B3ptq9QdDKOZ7rs5aGX8O97Lu06JQEnVX8ikBomAZSd12V5HXPQ3i+0bmdftdTOyVTWE
         YQtoj5ki31xMGuFCvIZJL7nUk6S66JQk27ksx8YaC1I0viHfwK2uWx/ppNkLYHv/7KJc
         uZ5hGHOJUZA0ZpsZ1xTk1PxSOMIhZ0UqAQKrUcNu0X9KqrU7D9hcWya30IzpAmeHmG+P
         fXVw==
X-Gm-Message-State: APuU4Z8xe4jUSRgl8p/4UB0xRo7T5EuZ6wYZ2Kf37N/ISJzN3zdnIFMc
	DwwZdIbm8UZBLTo7uNlv7XIwiV/3oumwGS8vbjToGi7mkRpLZc+Oa1UXl23Ar8qIhTAO1JKNaSn
	ZTZCxb/KawQ==
X-Gm-Gg: AYBFou0OYR3BQ8Lz/6h9mayIx+HCOwsZ3nw6laCy7QEYOMfuSWyp8/tXTa3v2dtNRz4
	yOhC8RJNPdSDF7eLHjSpcU93zKlvzJe9Op36pZ1dUkL2cblyEtVgvB4FmjXvVul5hDhSoKZOeKi
	yxorp+1dzxjlIa1k8CHzs3kzmtbIGzOvHC6PXw+sz0Pq2CiS8E7Y+9VEXMx/jVSboKjUF5WqOJr
	kP5bRVVYhW6canQa3pCcacyMQSYDwW6ntGTV0pkW+kkcbxBahtw0HkKA4zOdsYohdiKFIsah8cd
	s2+NF+W+nkhq/sqGynsfQb6HC3sVhHh/E6d7o/PHBaL7+dRe8lUqL8GIwecXFYQKRgQaRFBUNXQ
	+W2ymHbhdTqqrDn2WSvLTo8zQqHGt9F3ZK7JeoNLu/ayM3gDQPfeHxS8z9i3/1w9koakFAjUDWM
	NVGdAb10xvuL8UMhSiMZ1ofcrwjdqcsiYMshUOZ18kDt/31ZveyJdKg8WjL9umaxzBEzMws29Nv
	E/0ZfU/Hl6IfZSs5ZM5sCWIAzDlg/s/iY7twT/VUJF5rJ1YMrOvFpTotXQDnsAyvF8gCS09lb1U
	12K6J8TEftRhb3JJqD2QT37NFr66zazz5i/+IWwsb3yTsb8ODyNiSi2jFNyiWR+MpNIg9g1bWcA
	Xkh00KA==
X-Received: by 2002:a17:907:8908:b0:c31:fb29:a137 with SMTP id a640c23a62f3a-c510e30c079mr165899666b.21.1794994550072;
        Wed, 18 Nov 2026 01:35:50 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab3000sm75275066b.56.2026.11.18.01.35.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:35:49 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Nov 2026 10:35:42 +0100
Subject: [PATCH 5.15.y 5.10.y 2/4] sign-file,extract-cert: avoid using
 deprecated ERR_get_error_line()
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
Message-Id: <20261118-openssl4-515-v1-2-e1fbd1da96d4@fairphone.com>
References: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
In-Reply-To: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
To: stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794994548; l=3673;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=sn8Lxp6YpeUV3EvbbWkOOAIntw0rX6inws0AlKgVgVw=;
 b=0HGaDUbwIR/SpimnrYGqW7Y/bx7Z4oSy5ukW19a7i53mUf4On0EoqQcLsfaDjp5UfUvai6YZ4
 vUY3yFFxUfHD7FCMQ7AboUkTcejJ3UmBjbqq18w/3lJeWUuqg91LJNW
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Jan Stancek <jstancek@redhat.com>

commit 467d60eddf55588add232feda325da7215ddaf30 upstream.

ERR_get_error_line() is deprecated since OpenSSL 3.0.

Use ERR_peek_error_line() instead, and combine display_openssl_errors()
and drain_openssl_errors() to a single function where parameter decides
if it should consume errors silently.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 scripts/extract-cert.c |  4 ++--
 scripts/sign-file.c    |  6 +++---
 scripts/ssl-common.h   | 23 ++++++++---------------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index bf0e6788995b..8101549c98ae 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -96,11 +96,11 @@ int main(int argc, char **argv)
 		parms.cert = NULL;
 
 		ENGINE_load_builtin_engines();
-		drain_openssl_errors();
+		drain_openssl_errors(__LINE__, 1);
 		e = ENGINE_by_id("pkcs11");
 		ERR(!e, "Load PKCS#11 ENGINE");
 		if (ENGINE_init(e))
-			drain_openssl_errors();
+			drain_openssl_errors(__LINE__, 1);
 		else
 			ERR(1, "ENGINE_init");
 		if (key_pass)
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 39ba58db5d4e..bb3fdf1a617c 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -114,11 +114,11 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 		ENGINE *e;
 
 		ENGINE_load_builtin_engines();
-		drain_openssl_errors();
+		drain_openssl_errors(__LINE__, 1);
 		e = ENGINE_by_id("pkcs11");
 		ERR(!e, "Load PKCS#11 ENGINE");
 		if (ENGINE_init(e))
-			drain_openssl_errors();
+			drain_openssl_errors(__LINE__, 1);
 		else
 			ERR(1, "ENGINE_init");
 		if (key_pass)
@@ -273,7 +273,7 @@ int main(int argc, char **argv)
 
 		/* Digest the module data. */
 		OpenSSL_add_all_digests();
-		display_openssl_errors(__LINE__);
+		drain_openssl_errors(__LINE__, 0);
 		digest_algo = EVP_get_digestbyname(hash_algo);
 		ERR(!digest_algo, "EVP_get_digestbyname");
 
diff --git a/scripts/ssl-common.h b/scripts/ssl-common.h
index e6711c75ed91..2db0e181143c 100644
--- a/scripts/ssl-common.h
+++ b/scripts/ssl-common.h
@@ -3,7 +3,7 @@
  * SSL helper functions shared by sign-file and extract-cert.
  */
 
-static void display_openssl_errors(int l)
+static void drain_openssl_errors(int l, int silent)
 {
 	const char *file;
 	char buf[120];
@@ -11,28 +11,21 @@ static void display_openssl_errors(int l)
 
 	if (ERR_peek_error() == 0)
 		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
+	if (!silent)
+		fprintf(stderr, "At main.c:%d:\n", l);
 
-	while ((e = ERR_get_error_line(&file, &line))) {
+	while ((e = ERR_peek_error_line(&file, &line))) {
 		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+		if (!silent)
+			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+		ERR_get_error();
 	}
 }
 
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
 #define ERR(cond, fmt, ...)				\
 	do {						\
 		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
+		drain_openssl_errors(__LINE__, 0);	\
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\

-- 
2.56.1

