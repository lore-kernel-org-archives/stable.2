Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795078648;
	b=OEw10uLyL/6zKr/pk+goU+hLon/2Zu+U0StnULq+i10k2kJR7YzDvHfYJMTBcyIFAawp
	 fVfySK4LAU9CRMk/s7/MZe0UQY3IbjCfBc/UvDbXkCWHE9dodf8XaGllPSdlx7rtMtyOp
	 WBnlQcO4dolJYziQ9EjuXAKcbtF1kL0n4AVgSGEg4ryBOgWkO45UkV27mjmM0ShlVVcBA
	 kY4YzM5Yo4gsla7mFqzxoz3p0LAbj/hajakotkBC+DcSXAtvHzvPaNgKUbf6Xwi1I0ucg
	 51hAwA7KBRm7+XAHwIzpdChakalzTLv7TR4EKTBOPV6wC96VBgOGtveJ2Hm7d2uZ0Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078648;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ifiR5xDoIm1BWsps4FmkgCuuoSgYYEsVsmccd9iJImY=;
	b=1KOVGKTyc5EW/EbLsPAo34VifMKpUWLavsfQIRe1DdfFL5R5cavZpPy21zLtcKmbidnX
	 2FGOjMvgLvrHsDl54oYDl9jSpaySbgrxNNmHQKPQhv/aEYumvfYylAx+FR7eqNBW1BCG5
	 vqq9npPChCl1qd5CRjCFwmpUYGH7R5wk5uRhJGyqoLeTa4SKaMlR5gTm7E1H8nUNN61UD
	 MBwRFCtXGvmFAHA3qkHEYd6ahTSh97Sueh6uwbQJY7uVsrGj+0YKo88TlM720mIbUPcB1
	 vJEGiYVqGj36IkghZsFrUJNLFc0WOPpvpBO0wbPw/wZOn+Qw3jYT/xqM4jAQkyIIeZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+92DBaG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA588606A330;
	Thu, 19 Nov 2026 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+92DBaG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795078647;
	b=PGz+VRclifhR1QfZAtu2cSPhlMfASn4U1sjJgMn5M91RnnFukFl+QVZnmHWlNgkZMMwM
	 CMN2UhvpbNf6YNPVcY2mT/VHXFUlUUwj+OItMKSRvMcsom4sHMN5sjcmd50lbMG+TnzvR
	 /717wNXLKzPIs1I+XcuBMNHF/jdZlok+p38uXSIlnGNtiluwCkzH4CLk2jd5afZtqgWk4
	 lgKgtpxqLRo2Xnx76yUP4ToDQdoY/qfDZNvqcRVv2YNR8Uo4YIlXtFCwBAOsm3S0rosD4
	 B6Zji+ekXFGShncv58oRwKUsOVTnpO7/FrFEBkSBCaFNQBnha+xVu0rQO11e7jrElkg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795078647;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ifiR5xDoIm1BWsps4FmkgCuuoSgYYEsVsmccd9iJImY=;
	b=yZf9pQpBsP4Qv5B/cT5tSwkZlMCn6yEHo+6iYcwG1z0HRZNQdl5W186QZI/WwZ1A66Bg
	 aI5NtNelq1vpBPI312jN4BzIleBgRsJMQzDCunpmy1pFl3zt0B9l8ut//H8QWZl8Nted9
	 LyZ297YhGvxWq+EuNTDeIsvEkv6dA2J9wCB4U0uGN9mfzNL5fsJMO/9DcSfNe4lFUglgP
	 nbf2SZRXvok837jZ3k0ouwnUPxFe8kNPCFCl09u7ZE1yuaYSaaWPBRhNjHi8VU7iRSEUK
	 rq6XQaFV3spHCqWFKVp3JFEe9aIC4Y4R7ZRz5p6pkF4wAYHmUit0q/f/aUO++H/fCng==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5FCB21F000C7;
	Thu, 19 Nov 2026 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078647;
	bh=ifiR5xDoIm1BWsps4FmkgCuuoSgYYEsVsmccd9iJImY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h+92DBaGr+1eBZOd/NdPLdTEyAAtH75F65Hx8wRxspH39degf+6vKCUHM+aIrAbLf
	 tD3AvFNydEYOe2HPZOg8P2RbCRyZfQHk+hQwKRtSIdBrRjL+EI+5sARzYxQa6Mb2F/
	 vCzrt4gVnDubpkVTFc2CUizn4nHaoOjgLZytz/rJif7UTWkyit9RD3NTPrSb19wIVt
	 wmEA/hmZAMahXkVEreUFAUGyxWDqKMrNq0JF/oNHWgz7WyRvQQtb+IeMoSYMLE+pSv
	 SPG50HobImQEK//znueSaMUrZW0LfzisBh7LXgRIYXSW6r1Kdf6crvuE6O3NQXovfA
	 J1CCFQL6Uykng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E1A6D4B1D4;
	Thu, 19 Nov 2026 08:57:25 +0000 (UTC)
From: =?utf-8?q?Jordan_DESNO=C3=8BS_via_B4_Relay?= <devnull+jordan.desnoes.francetv.fr@kernel.org>
Date: Thu, 19 Nov 2026 09:57:24 +0100
Subject: [PATCH 6.18.y 2/4] libceph: introduce ceph_crypto_key_prepare()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-aes256k-6-18-y-v1-2-bd5db87da2f5@francetv.fr>
References: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
In-Reply-To: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
To: stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 ceph-devel@vger.kernel.org, 
 =?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795078645; l=5970;
 i=jordan.desnoes@francetv.fr; s=20261119; h=from:subject:message-id;
 bh=r+BtKaIKJzewhgo+SyxJROekPa6qPWOkLbWCTMsh/C4=;
 b=3MyhsdlWE8yjoA0LVsHGh+LPI3d3+rQzGbMBYWA6+uhJXDuWlXvEtsRBknFMyJkGuozT1T2ol
 zmY50iDAQOSCaZ/Sycs/19SXIQaNc10dKEwZqMQv4f2PPeThsGitJLD
X-Developer-Key: i=jordan.desnoes@francetv.fr; a=ed25519;
 pk=NsqAnHujTt5QBjYGvDgx/bh9SKZzYfCniV8bhRv6vTA=
X-Endpoint-Received: by B4 Relay for jordan.desnoes@francetv.fr/20261119
 with auth_id=1567
X-Original-From: =?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
Reply-To: jordan.desnoes@francetv.fr

From: Ilya Dryomov <idryomov@gmail.com>

commit 6cec0b61aacce4da5125b21c718189f0dc11eb51 upstream.

In preparation for bringing in a new encryption scheme/key type,
decouple decoding or cloning the key from allocating required crypto
API objects and setting them up.  The rationale is that a) in some
cases a shallow clone is sufficient and b) ceph_crypto_key_prepare()
may grow additional parameters that would be inconvenient to provide
at the point the key is originally decoded.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Jordan DESNOËS <jordan.desnoes@francetv.fr>
---
 net/ceph/auth_x.c | 26 +++++++++++++++-----
 net/ceph/crypto.c | 73 +++++++++++++++++++++++++++----------------------------
 net/ceph/crypto.h |  1 +
 3 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index d1c7b7880..a23e0e2b8 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -226,6 +226,10 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	if (ret)
 		goto out;
 
+	ret = ceph_crypto_key_prepare(&new_session_key);
+	if (ret)
+		goto out;
+
 	ceph_decode_need(&dp, dend, sizeof(struct ceph_timespec), bad);
 	ceph_decode_timespec64(&validity, dp);
 	dp += sizeof(struct ceph_timespec);
@@ -385,6 +389,10 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	if (ret)
 		goto out_au;
 
+	ret = ceph_crypto_key_prepare(&au->session_key);
+	if (ret)
+		goto out_au;
+
 	maxlen = sizeof(*msg_a) + ticket_blob_len +
 		ceph_x_encrypt_buflen(&au->session_key, sizeof(*msg_b));
 	dout("  need len %d\n", maxlen);
@@ -1118,21 +1126,26 @@ int ceph_x_init(struct ceph_auth_client *ac)
 	int ret;
 
 	dout("ceph_x_init %p\n", ac);
-	ret = -ENOMEM;
 	xi = kzalloc(sizeof(*xi), GFP_NOFS);
 	if (!xi)
-		goto out;
+		return -ENOMEM;
 
 	ret = -EINVAL;
 	if (!ac->key) {
 		pr_err("no secret set (for auth_x protocol)\n");
-		goto out_nomem;
+		goto err_xi;
 	}
 
 	ret = ceph_crypto_key_clone(&xi->secret, ac->key);
 	if (ret < 0) {
 		pr_err("cannot clone key: %d\n", ret);
-		goto out_nomem;
+		goto err_xi;
+	}
+
+	ret = ceph_crypto_key_prepare(&xi->secret);
+	if (ret) {
+		pr_err("cannot prepare key: %d\n", ret);
+		goto err_secret;
 	}
 
 	xi->starting = true;
@@ -1143,8 +1156,9 @@ int ceph_x_init(struct ceph_auth_client *ac)
 	ac->ops = &ceph_x_ops;
 	return 0;
 
-out_nomem:
+err_secret:
+	ceph_crypto_key_destroy(&xi->secret);
+err_xi:
 	kfree(xi);
-out:
 	return ret;
 }
diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 2b98daffe..3453dc303 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -16,65 +16,61 @@
 #include <linux/ceph/decode.h>
 #include "crypto.h"
 
-/*
- * Set ->key and ->tfm.  The rest of the key should be filled in before
- * this function is called.
- */
-static int set_secret(struct ceph_crypto_key *key, void *buf)
+static int set_aes_tfm(struct ceph_crypto_key *key)
 {
 	unsigned int noio_flag;
 	int ret;
 
-	key->key = NULL;
-	key->tfm = NULL;
-
-	switch (key->type) {
-	case CEPH_CRYPTO_NONE:
-		return 0; /* nothing to do */
-	case CEPH_CRYPTO_AES:
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	key->key = kmemdup(buf, key->len, GFP_NOIO);
-	if (!key->key) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
-	/* crypto_alloc_sync_skcipher() allocates with GFP_KERNEL */
 	noio_flag = memalloc_noio_save();
 	key->tfm = crypto_alloc_sync_skcipher("cbc(aes)", 0, 0);
 	memalloc_noio_restore(noio_flag);
 	if (IS_ERR(key->tfm)) {
 		ret = PTR_ERR(key->tfm);
 		key->tfm = NULL;
-		goto fail;
+		return ret;
 	}
 
 	ret = crypto_sync_skcipher_setkey(key->tfm, key->key, key->len);
 	if (ret)
-		goto fail;
+		return ret;
 
 	return 0;
-
-fail:
-	ceph_crypto_key_destroy(key);
-	return ret;
 }
 
+int ceph_crypto_key_prepare(struct ceph_crypto_key *key)
+{
+	switch (key->type) {
+	case CEPH_CRYPTO_NONE:
+		return 0; /* nothing to do */
+	case CEPH_CRYPTO_AES:
+		return set_aes_tfm(key);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/*
+ * @dst should be zeroed before this function is called.
+ */
 int ceph_crypto_key_clone(struct ceph_crypto_key *dst,
 			  const struct ceph_crypto_key *src)
 {
-	memcpy(dst, src, sizeof(struct ceph_crypto_key));
-	return set_secret(dst, src->key);
+	dst->type = src->type;
+	dst->created = src->created;
+	dst->len = src->len;
+
+	dst->key = kmemdup(src->key, src->len, GFP_NOIO);
+	if (!dst->key)
+		return -ENOMEM;
+
+	return 0;
 }
 
+/*
+ * @key should be zeroed before this function is called.
+ */
 int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end)
 {
-	int ret;
-
 	ceph_decode_need(p, end, 2*sizeof(u16) + sizeof(key->created), bad);
 	key->type = ceph_decode_16(p);
 	ceph_decode_copy(p, &key->created, sizeof(key->created));
@@ -85,10 +81,13 @@ int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end)
 		return -EINVAL;
 	}
 
-	ret = set_secret(key, *p);
+	key->key = kmemdup(*p, key->len, GFP_NOIO);
+	if (!key->key)
+		return -ENOMEM;
+
 	memzero_explicit(*p, key->len);
 	*p += key->len;
-	return ret;
+	return 0;
 
 bad:
 	dout("failed to decode crypto key\n");
@@ -322,7 +321,7 @@ static int ceph_key_preparse(struct key_preparsed_payload *prep)
 		goto err;
 
 	ret = -ENOMEM;
-	ckey = kmalloc(sizeof(*ckey), GFP_KERNEL);
+	ckey = kzalloc(sizeof(*ckey), GFP_KERNEL);
 	if (!ckey)
 		goto err;
 
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index 736ec6d2f..2b8f8f68f 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -19,6 +19,7 @@ struct ceph_crypto_key {
 	struct crypto_sync_skcipher *tfm;
 };
 
+int ceph_crypto_key_prepare(struct ceph_crypto_key *key);
 int ceph_crypto_key_clone(struct ceph_crypto_key *dst,
 			  const struct ceph_crypto_key *src);
 int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end);

-- 
2.43.0


