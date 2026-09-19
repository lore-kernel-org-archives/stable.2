Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5133AC0ED
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383455; cv=none; b=Bs7K1xbfZRymFLwp2Ha3qcPD0KLQfPFzlaKo47fy/WkYIzhnd9RtBWIHlnmfmm0/FbVOesoBXmZ0sDmcQNhVtwFPj4SyVd3lXZe7x2Ej7rOviA/EmMM3K1MInopjOEKGRvkOJ/k6A0YXTi77+f5i1bDNB9VE+ERklsSREzCN77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383455; c=relaxed/simple;
	bh=iQlWWcySheYUweZmmyPAAk+56wGE1m2ux1Ks0y1tgVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WiEjZaNm9RanlX0kpuR7+yPH7rmtHUekX1XIpWLdiXYVSCiTJ76DL2Q9BzYMicMJ5Uoc29IDEFEmeHTvtZYnLhyzSEuhvXjM8Jp4/kBkTj7zZjYqeqa7Rzv38BAiG726tt7VvcMeBI2m5arAe+itsMH6oGY1g5q9xKvr0hT2v8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFaWVJnh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFaWVJnh"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso547850a12.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792383454; x=1792988254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prP+O9ilClnMZ8olBVpsFDNiu7XXS/mByYDkFEu2nFM=;
        b=hFaWVJnhROItFiqi40EONAIuUu4jDDvo88pEP/PgBkqiKPHoQ+vaGSM5qjCZNOe5KY
         C8UqkvsLKbSwIkmLNAxsggUChZ0Wa2l51fEb4PLUp1XgfTv3v+POo8chzR5UyW4s1/AO
         wDtx668fpPlahejqLzavaEUAC/c4q8Pkb3M6pZeLU8kQzGNBSZxp9u+rdQ5u/w5bSr4s
         3VxrxNEWhHLcIvRIshljdzMPUH6r1Hv/FP0RoeT03XI1VZdId/1tHud+NaWYARX7eqTP
         5G8+pmztX1CF8f1ScKy0ywldhmgU3n5oN5yL7LWgaj/1vbeARsf3qSTtz73+AEFfkH3n
         j6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383454; x=1792988254;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prP+O9ilClnMZ8olBVpsFDNiu7XXS/mByYDkFEu2nFM=;
        b=nd/XSu69VXz3gJxJ2O/WzTlEENVmHd2kufzUI51r9xK1Awdy9BpgS34JIytFNfNL+I
         nSh72AXprUdCxFhkdmR3bKs+gBItguUGVNj6jzTyHz8E9A+xUlAxCQrmvDAmtsPBXuzc
         LkxGq3bS018dpDqZXVonFtKBV45anw9zQci+fH6R5DOfqWPl+LaiXN2GPQu8WfU98s8y
         NwnKP7F6qNDByOmIY7cFahvHURfrWzsj2943YI5BTtPPi6Ym9BtVk/k2s5PahAmFiFkj
         l6SwLfAaimafsjjrvqfM1TqtLllDT3T/02wmF9U0/YTuuhBgdcNPujULWKFgag3QvD+V
         ggKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFXsCi+g5sRxYH7TEI/TS6MVgmzuJ7SSq+eRmssjtUauGW0dbXKiWVYR3zcn4hS2yr8l9+Li4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH79dZ07BtO7nCX0PVM2/HN2ODB7dvlMiu9kTJP9AIbTLGsc42
	CtJLaCeoEsY/dQA+/5R4A3jggjLGLoQeRssY2ldzvXQE7vi5KoGmSqnKLg6gXmeoRZ0=
X-Gm-Gg: AYBFou0y5lRm8C4iMLGx3gB9+NcuvKg09/v6y8XMR5GbadXX6rXMdpEaN3+y12a0ZhQ
	qrSqIiYYO2cWn1dFkESR0Z0rL1QTykg/W487qqn0tkYe6CC3EXfL2/tn1ix2n+9VGdiywxkvBFs
	qBmJdnyFenQ4u2vhoyLTN9bhUnVKs7bV1k+m+80DNC/GVczcQ+IeYkHeNUC9tUbMFsvV/qebA/V
	3nZMzCGialy5xU7h+8zOnRM+qvFpg8cFUlQThKeSiSSdJ2lnrVmIlbsyWzQ0alcxKMi6DEb/ZCr
	7W9+aaWiWu+djH2TyuSx+jwDrcDekohVJ+idGwz7p39lzqJfgm1WgMoKvE7NHCRtg+QYU2m+zJj
	XIZ/RMqpQdvAH+C7uwrAIfLBpGGRi5ABsTSMXER1pMOGdT7XGBQqar0GBcLdqiFKZ7KVAWxzk3M
	3euGC2GudxS4/SY6u13vHE88/2PhxRhyPOKEzRCo7/E08iaHFNgBimyqdzXQAMJMNE+e1zntsHP
	zcDofGtf55FLQsE0HThCtEe7Gi794/bp1MJtLCSUXpuBMwVyiVi45kFVgpY8Q==
X-Received: by 2002:a17:90b:1cc6:b0:3ac:c005:cf07 with SMTP id 98e67ed59e1d1-3acef3d6405mr5253607a91.42.1792383453387;
        Sun, 18 Oct 2026 21:17:33 -0700 (PDT)
Received: from 700-v3.eml (awork131052.netvigator.com. [219.76.131.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm18098029a91.11.2026.10.18.21.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 21:17:32 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@linux.win>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: [PATCH v3] KEYS: Account for asymmetric key payload data in the quota
Date: Sat, 19 Sep 2026 14:14:43 +0800
Message-ID: <20261019041314.48569-1-xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
user counter and refunds only the truncated key->quotalen.

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
Changes in v3:
 - Sashiko (High): "keys: integer truncation of key->quotalen causes
   permanent quota leak" on pkcs8_key_preparse() and
   x509_key_preparse(). A charge above USHRT_MAX is now rejected with
   -EINVAL before the payload is installed. key_payload_reserve()
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
   addressed in v3.
 - v1 Link: https://lore.kernel.org/all/cover.1789801335.git.xuyuqiabc@gmail.com/

diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
index 9dd1c181789a..e1bb37b6949a 100644
--- a/crypto/asymmetric_keys/pkcs8_parser.c
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -136,6 +136,7 @@ static struct public_key *pkcs8_parse(const void *data, size_t datalen)
 static int pkcs8_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct public_key *pub;
+	size_t quotalen;
 
 	pub = pkcs8_parse(prep->data, prep->datalen);
 	if (IS_ERR(pub))
@@ -144,13 +145,20 @@ static int pkcs8_key_preparse(struct key_preparsed_payload *prep)
 	pr_devel("Cert Key Algo: %s\n", pub->pkey_algo);
 	pub->id_type = "PKCS8";
 
+	quotalen = sizeof(*pub) + pub->keylen;
+	/* A charge past USHRT_MAX would truncate and leak quota */
+	if (quotalen > USHRT_MAX) {
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
index 25cf8ac7f257..ecceeb291833 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -163,9 +163,11 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct x509_certificate *cert __free(x509_free_certificate) = NULL;
 	struct asymmetric_key_ids *kids __free(kfree) = NULL;
+	struct asymmetric_key_id *id;
 	char *p, *desc __free(kfree) = NULL;
 	const char *q;
-	size_t srlen, sulen;
+	size_t srlen, sulen, quotalen;
+	int i;
 
 	cert = x509_cert_parse(prep->data, prep->datalen);
 	if (IS_ERR(cert))
@@ -221,6 +223,31 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
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
+	/* A charge past USHRT_MAX would truncate and leak quota */
+	if (quotalen > USHRT_MAX) {
+		kfree(kids->id[2]);
+		return -EINVAL;
+	}
+
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
 	prep->payload.data[asym_subtype] = &public_key_subtype;
@@ -228,7 +255,7 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	prep->payload.data[asym_crypto] = cert->pub;
 	prep->payload.data[asym_auth] = cert->sig;
 	prep->description = desc;
-	prep->quotalen = 100;
+	prep->quotalen = quotalen;
 
 	/* We've finished with the certificate */
 	cert->pub = NULL;
-- 
2.56.0


