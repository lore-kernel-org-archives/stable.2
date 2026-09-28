Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203D34DCC7
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584053; cv=none; b=o0L0VC5rjRNN9S7CcbeJj/DYOfUzN+LCFPeaQ9P547LV7kUPjJNCdGY94RKAwj7AlAjxk1qOBvDg8oh4m02alFqlBJejyHP92i0sL0rorqlZi+Cjo/Nz242Oki4A4Jh5zNpv42LvwpC3CGojsRGfOYK9+wAyjjWJZ7vH6RdQx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584053; c=relaxed/simple;
	bh=qN08mNiTv8J0Mp8pchCpuaOb37f3jGZ6uX0U4uGWXkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sK9sCPvi7JM4SziJo6lYCM/794Rfd4zeDAY7ZlXcgMGrWu/yt4+rL4qgi7O01vW1bIt7vd24lFXaPdYrkzZgpsS3p4ykiR4qnWhb5A7hVK3pzGtRgfVv6ebPPTIBb+Y8gRA0JCaU+T9WOtxskX7lwVQrM3quE9UsUPT2nOJQhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rILIjyTg; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rILIjyTg"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so1373387a91.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790584051; x=1791188851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Or5RdHKya3kgS3wekTCtYwbuyr5PA8u9N7BZEUfzztI=;
        b=rILIjyTgtTb3sl9xAeR99PS25HhYoyeIulusu7lM5C5kTV0iwEsLUapx72jUmuQa00
         gftK6KbcBNU4+3oiznLBpL6lqQFQMjWuZmtBBdBhBQJdGeDFOVbp6GVJQpJwzzt7a+0Y
         6XCDjrI3P9u0O+ENIcQ3riyTVHK9LMU0bbYhlISGe69V0yVUjfuqA2pD6cDqNpp1BiZ6
         kpHlET96e181zYmAQT/lTS4Vq+rfLIgOb8HlKC7GelNQotIp0M87EetFFlc6pSe8Dfrt
         NxU43pSV8CdfUweEiCLf0bcnbjOCjc0RyyH/yB8J8347h1+/eraPZU2E11db5glep//o
         cj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584051; x=1791188851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Or5RdHKya3kgS3wekTCtYwbuyr5PA8u9N7BZEUfzztI=;
        b=Ivt2/dOugByO8a8f1COtTTngEHiLZ3jqscOyGPogdJNqJZ2FoJE+E8y2Ou5yYiuXS3
         KJkZxqApfWq/H2SjZESNz+y3EgU3aHKSzHxZQBzMAFOuWtaQSmbZhauYnJRc4AyU/ypy
         iafFzy/Jis5EbnxFrCRzzXb4BHazyDCahULG6y0nXhFGEE9AQdW3FM3KaXMn9yfSm6Ai
         WcXv3AQRJKa46zAzY4vZlg79z5Rckvni6VM7EgifCovPEy7GQvMP2QbqCIBDBFpmRj9R
         4aVBvVyLXhcodwFShSKu5KEDCBkfxMDf3M+EAQ31wYvI0J3ZP3jCqSTsQmHQWXpzJ6tI
         +Qqg==
X-Forwarded-Encrypted: i=1; AKwUvBxbT6dEYfaavK++mZO6YLRmEvgLbaaQX8Qa7CnoaN8hO/FG+1fXWSk0LURlMNv6W/dgI66JzVk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWeGOA/mHA3854K8t6Jblb2M4YMkZ3s5mlokK8a4YZX1oM6c8X
	iV4EP3A85DMdmE/z27T7GBOS7lXPiXSPZx1TNBCz2FPgeKRif56YAMDJKi15pS/nFDDD5A==
X-Gm-Gg: AYBFou1i0BJdbK1776FuB1kCJ4qRolJWVljmOJQoXxWZgYbvRollYS/TRfpCpehArFN
	FQLULk2nuNz8aV0xjlob8NpLuEN0G73jjinVH1Nzf2V1rgXkSMpb7o9rnHLydZtdi+AbrdpRFjx
	JwzrADKCXZVrYGLXqejXAI8nQzV0qw4BAwSqMnoSGkegXeJPgTQJqYsGkDzuNCoyjK/JYzOrGy7
	++CjIo5z6HnXAN1OFqyNqxVhHYg2jen8V9rNgntXUi6WC7rHjjQh/OxThYr+obSqjlXXxk0yNJK
	uKqEpE4uoCmlkB0TY2eOc/bB7zFN74GbJiFWmPF8lJM9v51rJdyBGWtJPz+okEEbilm5JtqyR/w
	1/1/fdKKe54fAD8rbBsNx0FHnGK8tJPm6v0ZdVKzRhzi9tDoRAxGIEcBid5ro0BH4ggbJwHFWfx
	nW5/+D30sWZKdb+M9svP7AFHvQAFMp3hQ2xW31g8e9q9Cqjii3okvuv7kdMnz1Tks6r3HBdenEU
	UGPFm94LcRFKdSWkoQAanpZwd7Q7lc1COpkgJ56kHujcufuU32d7Pu7Rf52DZqKWRpYtmrj/nvX
	Okundmcodsv1QvaIiJE=
X-Received: by 2002:a17:90b:3d8e:b0:3a2:b033:4a42 with SMTP id 98e67ed59e1d1-3a2b03367bamr1690472a91.35.1790584051312;
        Mon, 28 Sep 2026 01:27:31 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e05d674dsm5287801a91.4.2026.09.28.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:27:30 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-crypto@vger.kernel.org,
	keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rusty Russell <rusty@rustcorp.com.au>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH v2] KEYS: Account for asymmetric key payload data in the quota
Date: Mon, 28 Sep 2026 16:27:24 +0800
Message-ID: <4a0b2e00f5cc62c173a01fec2f56eab1b04d70bb.1790568982.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
public key or set of authority key IDs.

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
Changes in v2:
 - Move the bug details and the measured quota numbers into this
   commit message, as requested by Ignat Korchagin.
 - Sashiko (High): "keys: integer truncation in key->quotalen causes
   permanent quota leak" on pkcs8_key_preparse() and
   x509_key_preparse(). Not changed. The truncation is real only past
   USHRT_MAX, the unprivileged maxbytes is 20000 so add_key() fails
   with -EDQUOT first, and this patch does not widen key->quotalen.
   Replied publicly: Message-ID
   20260920073515.64399-1-xuyuqiabc@gmail.com
 - v1 Link: https://lore.kernel.org/all/cover.1789801335.git.xuyuqiabc@gmail.com/
 crypto/asymmetric_keys/pkcs8_parser.c    |  2 +-
 crypto/asymmetric_keys/x509_public_key.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
index 9dd1c181789a..fa8b142a8e14 100644
--- a/crypto/asymmetric_keys/pkcs8_parser.c
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -150,7 +150,7 @@ static int pkcs8_key_preparse(struct key_preparsed_payload *prep)
 	prep->payload.data[asym_key_ids] = NULL;
 	prep->payload.data[asym_crypto] = pub;
 	prep->payload.data[asym_auth] = NULL;
-	prep->quotalen = 100;
+	prep->quotalen = sizeof(*pub) + pub->keylen;
 	return 0;
 }
 
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 25cf8ac7f257..f2bdd0244262 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -163,9 +163,11 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct x509_certificate *cert __free(x509_free_certificate) = NULL;
 	struct asymmetric_key_ids *kids __free(kfree) = NULL;
+	struct asymmetric_key_id *id;
 	char *p, *desc __free(kfree) = NULL;
 	const char *q;
 	size_t srlen, sulen;
+	int i;
 
 	cert = x509_cert_parse(prep->data, prep->datalen);
 	if (IS_ERR(cert))
@@ -228,7 +230,26 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	prep->payload.data[asym_crypto] = cert->pub;
 	prep->payload.data[asym_auth] = cert->sig;
 	prep->description = desc;
-	prep->quotalen = 100;
+
+	/* Charge the memory retained in the payload, not a fixed estimate */
+	prep->quotalen = sizeof(*cert->pub) + cert->pub->keylen +
+			 cert->pub->paramlen;
+	if (cert->sig) {
+		prep->quotalen += sizeof(*cert->sig) + cert->sig->s_size;
+		if (cert->sig->m_free)
+			prep->quotalen += cert->sig->m_size;
+		for (i = 0; i < ARRAY_SIZE(cert->sig->auth_ids); i++) {
+			id = cert->sig->auth_ids[i];
+			if (id)
+				prep->quotalen += sizeof(*id) + id->len;
+		}
+	}
+	prep->quotalen += sizeof(*kids);
+	for (i = 0; i < ARRAY_SIZE(kids->id); i++) {
+		id = kids->id[i];
+		if (id)
+			prep->quotalen += sizeof(*id) + id->len;
+	}
 
 	/* We've finished with the certificate */
 	cert->pub = NULL;
-- 
2.55.0

