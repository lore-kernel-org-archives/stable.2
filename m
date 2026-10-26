Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983000;
	b=WB7gPd1QMvaP1yTppDZYf3k03k51+FauILXYBkq3CJuHYr9e2x2LOGi3YgIPoTRTAfXc
	 6UtzVUpPVlF8umyfgQfM1EWaG3ApnY9TrZuGMIKQGQQIXkel7Z4SVDVc5KPRtORpIoQd7
	 dixk/Fx1vJFoDFxliIj4/ozJgNhy/b3jXzOqDD8uglSIpw4hmGDZs+ZiZZ80a+G9ZyK34
	 GXxEergUqYHua+k7wvr7ke3PAh65SYy5qKQwbYyvhemIznmaVJaI75nLLH5KfOigcgs/b
	 fIjIXN+6NU1Wfyp/x8n0N6HvhkjQQYSUZlvM1WyzqYcuVO7m0+B18FCOQvNBp6Fo+wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=4ZDK8iA0iBqRXCwykFRFBomnt4l4vOHobw4C2qbQYHY=;
	b=YjvC8syaBgBqeRY4VoybPh5IwaPxQddTU6UZ5XbgaVTscOQZTMqsI0YiIh8QoBAjPI71
	 gTTYhz4KZ6lBfcHM7Ipu668Nz0qnJeAqZLeqXx8Jn5GgvM+nSyVV1N2xqG1L+ONchy6oP
	 qb9ucBi/my4QYY4Ln7GFENORne8b/nXVE3RMexR0QCbm5exhW56qj76kQiKgcO2rdQof5
	 JZ4ZNFLL7flZN+UtyAycXKYjyoOKgfNhla+7EUr7OcSWajMminJ+ZoglEssDVkMFegogK
	 +7b5bEQPR9FLaqmq3rpO+KNEEnz1lnnTfkhDG8g77OrJQDI+6llROqFINEz6gWJO4Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iyd0wGM0;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D4606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F4D4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iyd0wGM0
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9ae391a05so16826165ad.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 19:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983000; x=1793587800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZDK8iA0iBqRXCwykFRFBomnt4l4vOHobw4C2qbQYHY=;
        b=iyd0wGM07xN9sX3e6w0JP59aqAHHFIPbSVOt26bAe2KMiNBl5EIrv/wXKnJDyRGK5U
         DJWPw8O7YGNVXKa5MZaBBJ1/TIfRvN8tKfMIY8EpdpS+SzA8t9IKriFAWewOKPYAGldV
         uBEBELQYseR74eAYBOqoeoNsX86ci69eWqKP8KouxwDH2gMF40vJb6IUIsJGRevwLKkv
         v/EFS+dJOu8KZJSuM9S+F6Nm+e5D/zTAmwz9OllKDXm/dl0Z3WAKPOieYP6bNI+9CsL5
         Z68DkhBvnY4MoT8v8G/NUelENLblRLW04zH6uB2Dua6uADHHN2ur+NmkiMHjrFIpS9lY
         oY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983000; x=1793587800;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ZDK8iA0iBqRXCwykFRFBomnt4l4vOHobw4C2qbQYHY=;
        b=pS6LopH1atnCR1KU+lNX8P7AX6khH4zaZqgq7Bfa2gC9XVuG7QtzB14UmNfxukJwnN
         tYXIdL2VQVSFPacCruT/xVkhZ2+iun1oHy2BRsphZQEVun+mAYFjjKHZ/hWphlGelxCX
         L+fOrjAiHQmbbjTHVXYvsMLB8ynNVPR6h2r8i8uEDAl0aj+ajCvt+dxYO7bNmwO8/bup
         Knt4VRC3DLf9YXHDp2FxwkB0MB7su+djrVpEIR3xS42+onsSU8EfWn9JIC4HNpLY3YbN
         5C4QhFsHAtiTgVi4MEjHy50wUg7Xz66J0a4eUzpalJDyZbQT5jAOcv/GkeNtayRUhrQu
         +e7A==
X-Forwarded-Encrypted: i=1; AKwUvBx918wzZVd/UvfTHnytA2b2gYMWuQMKbh5MvqlZDA3yJRGWu4tiSWv5wt7HeJnR960PY0ehDR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLi9ryasyMubnSQWfYX1Rq2kcfL/WfXjyGqGnVOOHJWGDkYVhmv
	2vzmfBu3iFmv9Mz9mB2/yccGEBRCLYBnWOlA836VSiDpSF8Pz55PPzbn
X-Gm-Gg: AYBFou0VlsisD2zNwaouWeIOz32MZlicwJQZ1C32fCBzjnGyEe0fdpS5ekrOl5dhQqL
	v+XKEdVJryHnHdh+wUF3y6xrjxdpfTmsywfVUll2IZhHplyNi4UOfyrAVMyKXDHjuyBRnsMH44H
	KnRb5cJ1EW4FVxdt5i6d6NN4wuLudhcvUVwVt2yt+GyOqgCyv67y8lHButw+p6AStF0qu0G4vsi
	B9YYLmD02zPr78KpgMEIDY8QzUI18bb1rkRwo7UI9GgSEXF3PyMl34SvhwOUAxMi/yAj/0AeUCo
	J8PGDZxtpN1iFegNYyQnCTD6TjHtO6wEVWZqLES2oTO+UUVq6MZxvWuymiituQTmlfjsRrhiaAr
	aNOeysazdYaAx8+Qc50azIT2l0D1hTtxbiCOAO5G/XzxGV/eBCc2HsE8ECIhGgT06/cs80ldeT/
	m1vbcZ+lqEMnZF2O5ZknQUGITzjCCjlvGKmxfndxSGp2NRtAnwyepU5HYbT327+bkomxVBmqsZR
	vHSxWdZO/mfMH+/6lGcg7GgYDFzSg5Iy027CPv7mA0/0Dx4WDZkmQ9OFDPP6oDgU90+FeCZhRMH
	Q1QXmeX2kpy6KOat1DBUzij2QuWMOCV8yrc=
X-Received: by 2002:a17:902:ea03:b0:2ea:1079:e518 with SMTP id d9443c01a7336-2ea9c812b32mr35073315ad.0.1792982999199;
        Sun, 25 Oct 2026 19:49:59 -0700 (PDT)
Received: from 700-v4.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eac205bb63sm2649025ad.48.2026.10.25.19.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 19:49:58 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@linux.win>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: [PATCH v4] KEYS: Account for asymmetric key payload data in the quota
Date: Mon, 26 Oct 2026 10:49:48 +0800
Message-ID: <20261026024840.23482-1-xuyuqiabc@gmail.com>
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
X-Mailer: git-send-email 2.56.0

add_key("asymmetric", ...) preparses the supplied blob and then
instantiates the key with generic_key_instantiate(), which charges
prep->quotalen to the owning user's key quota through
key_payload_reserve().

pkcs8_parse() duplicates the attacker-controlled PrivateKey OCTET
STRING with kmemdup() into pub->key. pkcs8_key_preparse() stores that
object in the asymmetric-key payload but hard-codes prep->quotalen to
100, so the quota records 100 bytes regardless of the retained private
key size. The ASN.1 decoder accepts blobs up to 65535 bytes, so one
key can pin about 64 KiB while consuming 100 quota bytes. With the
default non-root limits (200 keys / 20000 bytes) a user can retain
roughly 12 MiB instead of the 20 KiB the limit is meant to allow.

x509_key_preparse() keeps the parsed public key, its parameters, the
signature and the authority key IDs, but also charges a fixed 100
bytes. PKCS#8 later repeated the same fixed-100 accounting. The same
add_key() call reaches the X.509 parser, so fixing only PKCS#8 would
leave the bypass reachable.

Charge the size of the retained payload instead. An oversized PKCS#8
key now fails with -EDQUOT instead of being accepted for 100 bytes,
and the same applies to an X.509 certificate that retains an oversized
public key or set of authority key IDs. A charge which does not fit
in unsigned short is rejected with -EINVAL before the payload is
installed, because key_payload_reserve() keeps the full delta in the
user counter and refunds only the truncated key->quotalen. key_alloc()
also charges the key description to the same field, so include the
effective description length in that limit as well.

Measured on v7.3-rc1 (10396a2d6d41), 2 vCPU / 2 GiB QEMU guest, as uid
1000, adding PKCS#8 keys with a 65000-byte PrivateKey field. Before
the patch, 176 keys were retained (about 11.4 MiB) while
/proc/key-users charged only 19712 bytes. After the patch the
oversized key is rejected immediately, and a 200-byte PrivateKey still
loads and is charged 264 bytes. A small X.509 certificate whose only
large object is a 26000-byte authorityKeyIdentifier is likewise
rejected, while the unpatched kernel accepted it and charged 109
bytes.

Fixes: c26fd69fa009 ("X.509: Add a crypto key parser for binary (DER) X.509 certificates")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
Changes in v4:
 - Sashiko (High): "keys: integer truncation of key->quotalen causes
   permanent quota leak" on key_alloc() and key_payload_reserve().
   Include the effective key description length in the USHRT_MAX
   limit. key_alloc() and key_payload_reserve() add the description
   and the payload to the same unsigned short field, so checking the
   payload alone was not enough.
 - v3 Link: https://lore.kernel.org/all/20261019041314.48569-1-xuyuqiabc@gmail.com/

Changes in v3:
 - Sashiko (High): "keys: integer truncation of key->quotalen causes
   permanent quota leak" on pkcs8_key_preparse() and
   x509_key_preparse(). A payload charge above USHRT_MAX is rejected
   with -EINVAL before the payload is installed. key_payload_reserve()
   keeps the full delta in the user quota and refunds only the
   truncated key->quotalen, so that charge would leak quota.
 - Reposted so Sashiko records a review against this Message-ID, as
   requested by Herbert Xu. v2 was posted and Ignat Korchagin replied.
 - v2 Link: https://lore.kernel.org/all/4a0b2e00f5cc62c173a01fec2f56eab1b04d70bb.1790568982.git.xuyuqiabc@gmail.com/

Changes in v2:
 - Move the bug details and the measured quota numbers into this
   commit message, as requested by Ignat Korchagin.
 - Sashiko (High): "keys: integer truncation in key->quotalen causes
   permanent quota leak" on pkcs8_key_preparse() and
   x509_key_preparse(). Not changed in v2. The same finding is
   addressed in v3 and v4.
 - v1 Link: https://lore.kernel.org/all/cover.1789801335.git.xuyuqiabc@gmail.com/

diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
index 9dd1c181789a..db2d57489d96 100644
--- a/crypto/asymmetric_keys/pkcs8_parser.c
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/err.h>
 #include <linux/oid_registry.h>
 #include <keys/asymmetric-subtype.h>
@@ -136,6 +137,8 @@ static struct public_key *pkcs8_parse(const void *data, size_t datalen)
 static int pkcs8_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct public_key *pub;
+	const char *description;
+	size_t desclen, quotalen;
 
 	pub = pkcs8_parse(prep->data, prep->datalen);
 	if (IS_ERR(pub))
@@ -144,13 +147,26 @@ static int pkcs8_key_preparse(struct key_preparsed_payload *prep)
 	pr_devel("Cert Key Algo: %s\n", pub->pkey_algo);
 	pub->id_type = "PKCS8";
 
+	/*
+	 * key_alloc() charges the description to the same unsigned short
+	 * field that key_payload_reserve() later adds the payload to.
+	 */
+	description = prep->orig_description ?: prep->description;
+	desclen = description ? strlen(description) + 1 : 0;
+
+	quotalen = sizeof(*pub) + pub->keylen;
+	if (desclen > USHRT_MAX || quotalen > USHRT_MAX - desclen) {
+		public_key_free(pub);
+		return -EINVAL;
+	}
+
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
 	prep->payload.data[asym_subtype] = &public_key_subtype;
 	prep->payload.data[asym_key_ids] = NULL;
 	prep->payload.data[asym_crypto] = pub;
 	prep->payload.data[asym_auth] = NULL;
-	prep->quotalen = 100;
+	prep->quotalen = quotalen;
 	return 0;
 }
 
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 25cf8ac7f257..4a9c85277ce0 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -163,9 +163,11 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct x509_certificate *cert __free(x509_free_certificate) = NULL;
 	struct asymmetric_key_ids *kids __free(kfree) = NULL;
+	struct asymmetric_key_id *id;
 	char *p, *desc __free(kfree) = NULL;
-	const char *q;
-	size_t srlen, sulen;
+	const char *description, *q;
+	size_t desclen, srlen, sulen, quotalen;
+	int i;
 
 	cert = x509_cert_parse(prep->data, prep->datalen);
 	if (IS_ERR(cert))
@@ -221,6 +223,36 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	if (IS_ERR(kids->id[2]))
 		return PTR_ERR(kids->id[2]);
 
+	/* Charge the memory retained in the payload, not a fixed estimate */
+	quotalen = sizeof(*cert->pub) + cert->pub->keylen +
+		   cert->pub->paramlen;
+	if (cert->sig) {
+		quotalen += sizeof(*cert->sig) + cert->sig->s_size;
+		if (cert->sig->m_free)
+			quotalen += cert->sig->m_size;
+		for (i = 0; i < ARRAY_SIZE(cert->sig->auth_ids); i++) {
+			id = cert->sig->auth_ids[i];
+			if (id)
+				quotalen += sizeof(*id) + id->len;
+		}
+	}
+	quotalen += sizeof(*kids);
+	for (i = 0; i < ARRAY_SIZE(kids->id); i++) {
+		id = kids->id[i];
+		if (id)
+			quotalen += sizeof(*id) + id->len;
+	}
+	/*
+	 * key_alloc() charges the description to the same unsigned short
+	 * field that key_payload_reserve() later adds the payload to.
+	 */
+	description = prep->orig_description ?: desc;
+	desclen = strlen(description) + 1;
+	if (desclen > USHRT_MAX || quotalen > USHRT_MAX - desclen) {
+		kfree(kids->id[2]);
+		return -EINVAL;
+	}
+
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
 	prep->payload.data[asym_subtype] = &public_key_subtype;
@@ -228,7 +260,7 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	prep->payload.data[asym_crypto] = cert->pub;
 	prep->payload.data[asym_auth] = cert->sig;
 	prep->description = desc;
-	prep->quotalen = 100;
+	prep->quotalen = quotalen;
 
 	/* We've finished with the certificate */
 	cert->pub = NULL;
-- 
2.56.0


