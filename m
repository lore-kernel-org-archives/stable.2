Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994551;
	b=3EJsiQ4m/8utXkLxhSJVXspy82kKRBzIol7aR0g2S02nbFYKcUkROle7miSxuEkNS3UH
	 a/hmUwzC/IfFyuqv/uYKHj/S+gO0qZsmsqX9QOvrPR37HZCEVb+qzc8P2V0H1f8Kc9XBY
	 4kvjl8gkRlxpwx9H9Bsw4zuR5qb+82BLGoXWuldYAdxeAMgrEaqDPDMg0nAnIzpoMbhn3
	 dhHiTM3gw6Nv3polQd6YiTdVg1xGxm9yZz3TFQkKovreyAGNnD6tjCCsBFQHFPYFOl+l/
	 ohXKKIozCb2FtjCDA5W0DcBPdErso9JKaHZdfAMh6uQspAEiugMdBoYif3fXrDw70GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=yutXwdHrJBnB8LOsOwQ8BkYwE92XH5YKiHEQoIncCIQ=;
	b=CXIHhiuU90zYOFcwo+j8HvLneRi48szX5p4B/BpBspTEeblrofb2yCcRwXJ9Mb/zjSsY
	 R45q0vfty3JgU9HWLZjuB7C0k3bQqmzsUu0Q4nGvgva5xDeAe8koSTk2r+i5W5aPKMOEl
	 3zBrYDIPzEIfw4zesBYaAeh5yB9Ag9S9sLnSHVGg2C9zWeuYcLwg9jaoUpOUlf6uwfssV
	 84DQFqQm4qBzg78kW/Er8ePt+OonUM+LO/XeXP/CFMLvgTC9gsUXrugIvMaZGMREZYwd9
	 ya0ZE8MlP9d1o2Uv1LoHGMbMd8bUm+8lwZiHo6eiU3wTHyLer0zGd8ReXJ40DWf9zxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=eYdiAj+q;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56711606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56711606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=eYdiAj+q
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c505186727fso99895966b.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794994550; x=1795599350; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yutXwdHrJBnB8LOsOwQ8BkYwE92XH5YKiHEQoIncCIQ=;
        b=eYdiAj+qfs+TuH17l5t706p217R6upcvbdehRBG7lrPAK4C5ElR+JyX4XZCKTsGbMu
         v2WanH5LAJ35xCc3MtQbX4d6U/7cZOWzAvfvZOMVGheXfoSJUJ5T4ctZ7u1cvTc2MoWK
         FRwxjl4NC/OtfOTIE2TtZtdxgwkb5mUAbNcpWYXTG4wt+7BnczzYfJWmEwp55Uz95OFA
         alCjdn2sLZkpNreboEhK3ws0fdDalzhE29YwC3pG/rmPOqMUNLU04UWSLZ3CKZJesj88
         3iYekr2yQPKosbYlvSr8evG4qyb2iJ9jdoZFzMN3ufMlY0zor/QCKgZRJDeFJItw/a1k
         jFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994550; x=1795599350;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yutXwdHrJBnB8LOsOwQ8BkYwE92XH5YKiHEQoIncCIQ=;
        b=jvjritfuS1JCh5j/Z0qDjq/HI0/Glez/g4nZtDOXiLk6KumJ6QT3qdxwJoQkp+4TU3
         C56htsj2el3y8kzHsznHxJL7NimBR80d9zZWVulXfjPs6QRmMYnnaMtTD52X/LGO9joT
         cm86YvTG3/u4oOK46TzASVAXuubNy8w6QTF0mWZ1c7+pzvQ5TjdVXz0mh5cVzXZ4/tz6
         D7Kgpke264TRYApz3p3qN5wGYn1YJLTGD/GSEyCyyrBuEu5xIle5pDpMgmzV/aAl1+ji
         ae8r9E6uUNqgftwepkxZ1r8hAifQJC6G/rsABvXorHz+1psI1a6peUtXTwoVvxQ88iJZ
         j3Zg==
X-Gm-Message-State: APuU4Z/fvXUguO3VlWWAysIIew3O0SgBNKUNnsjnxbw53jh8WyPpa2ha
	0WYNflTKvB0eO5ZdxYR+CXQiS66tOvZ+CweksTWzBHSoZE8J/KGELPuSg46eqDfPxVhxaEJf3pP
	OzNbgCln+ng==
X-Gm-Gg: AYBFou3YbGl0cLXHKgfhZ25mgbd63OZBFOyKWBl87SOi2lRntsn0rfte6m2BF7UIBGa
	DUuUQfzhhc5UYClw+lC2+akrUR9cTu1QguAOSk00jmCu96KwVZKDms4vEC/8BdkGTKtJtS88ZU0
	YP4vxi6bfTS4tTs5PJiUuoZtpMMmanYKcDAvfrInRfl/iJ1y2BdPO2h3mDiLdviws/FbnadfCVG
	ToDv964z6IdD0/djct5q4bzb9RI8+nGsdywiHkiPnmPjUL2JxrIH/WcHDIg5eEF5yBKZSdMBrnP
	NNmoe8Z+zSHBaCLVazdtOMfapupUVqWaF+wEN8h4U1h2m4wwlPzPZWdCQLpbAJRLI6puU842uXP
	tefXHv++meUpUlYn9P7RV6McP1UgwEB9Jr/k9pYpzTw+k6XWG6sTAiQJGIAQbhNNfPPrXbQZlxU
	UMdrPakpqk3GvEFiqfdy1G7lfrSRWU/LUOm+jdwr80UtilmT03G6B6EOYcj7b/zcnH4bwm07q2D
	XP2hXENydTy3ZZGwqWw/FIHvaCd4CM/iw8eBqsRAnptNSpMW/KCNgTzt/1Mb+TYGgyK4myBOwPk
	VXLqgdiRSsrGV8nW5pLlUmbtyrZL5NI1GAAxcGCCGcCKGibUCq/o+nBaZ4PWkzOePfVlGPx9Q9s
	vCztZFA==
X-Received: by 2002:a17:907:d409:b0:c40:3a99:3f96 with SMTP id a640c23a62f3a-c510e162740mr156295866b.10.1794994549643;
        Wed, 18 Nov 2026 01:35:49 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab3000sm75275066b.56.2026.11.18.01.35.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:35:49 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Nov 2026 10:35:41 +0100
Subject: [PATCH 5.15.y 5.10.y 1/4] sign-file,extract-cert: move common SSL
 helper functions to a header
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
Message-Id: <20261118-openssl4-515-v1-1-e1fbd1da96d4@fairphone.com>
References: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
In-Reply-To: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
To: stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794994548; l=4711;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=FxxlIUSKueRB2/V10iAP+tmgvxCalRpiaClqijNVrsA=;
 b=yqaorerxZ1GeKroGnwFKZX0w0hWW7mdxLLANvcsNVBU/8lHtaMJ0T0cn7gj/gxkOtzMAxdHps
 rS+yosNhIbpCYX6J2+qacsjvrSy7c52/9FMSonw/FLdfpxW/3gzHf0o
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Jan Stancek <jstancek@redhat.com>

commit 300e6d4116f956b035281ec94297dc4dc8d4e1d3 upstream.

Couple error handling helpers are repeated in both tools, so
move them to a common header.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[luca.weiss@fairphone.com: Backport to 5.15]
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 MAINTAINERS            |  1 +
 scripts/extract-cert.c | 37 ++-----------------------------------
 scripts/sign-file.c    | 37 ++-----------------------------------
 scripts/ssl-common.h   | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 70 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6635c3ba6403..fa7fe869deb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4347,6 +4347,7 @@ F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
 F:	scripts/extract-cert.c
 F:	scripts/sign-file.c
+F:	scripts/ssl-common.h
 
 CFAG12864B LCD DRIVER
 M:	Miguel Ojeda <ojeda@kernel.org>
diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index 79ecbbfe37cd..bf0e6788995b 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -23,6 +23,8 @@
 #include <openssl/err.h>
 #include <openssl/engine.h>
 
+#include "ssl-common.h"
+
 /*
  * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
  *
@@ -40,41 +42,6 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
-{
-	const char *file;
-	char buf[120];
-	int e, line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
-
-	while ((e = ERR_get_error_line(&file, &line))) {
-		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
-	}
-}
-
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
-#define ERR(cond, fmt, ...)				\
-	do {						\
-		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
-		if (__cond) {				\
-			err(1, fmt, ## __VA_ARGS__);	\
-		}					\
-	} while(0)
-
 static const char *key_pass;
 static BIO *wb;
 static char *cert_dst;
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 12acc70e5a7a..39ba58db5d4e 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -29,6 +29,8 @@
 #include <openssl/err.h>
 #include <openssl/engine.h>
 
+#include "ssl-common.h"
+
 /*
  * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
  *
@@ -83,41 +85,6 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
-{
-	const char *file;
-	char buf[120];
-	int e, line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
-
-	while ((e = ERR_get_error_line(&file, &line))) {
-		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
-	}
-}
-
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
-#define ERR(cond, fmt, ...)				\
-	do {						\
-		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
-		if (__cond) {				\
-			err(1, fmt, ## __VA_ARGS__);	\
-		}					\
-	} while(0)
-
 static const char *key_pass;
 
 static int pem_pw_cb(char *buf, int len, int w, void *v)
diff --git a/scripts/ssl-common.h b/scripts/ssl-common.h
new file mode 100644
index 000000000000..e6711c75ed91
--- /dev/null
+++ b/scripts/ssl-common.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ * SSL helper functions shared by sign-file and extract-cert.
+ */
+
+static void display_openssl_errors(int l)
+{
+	const char *file;
+	char buf[120];
+	int e, line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	fprintf(stderr, "At main.c:%d:\n", l);
+
+	while ((e = ERR_get_error_line(&file, &line))) {
+		ERR_error_string(e, buf);
+		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+	}
+}
+
+static void drain_openssl_errors(void)
+{
+	const char *file;
+	int line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	while (ERR_get_error_line(&file, &line)) {}
+}
+
+#define ERR(cond, fmt, ...)				\
+	do {						\
+		bool __cond = (cond);			\
+		display_openssl_errors(__LINE__);	\
+		if (__cond) {				\
+			errx(1, fmt, ## __VA_ARGS__);	\
+		}					\
+	} while (0)

-- 
2.56.1

