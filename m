Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382497;
	b=GHZrwunniU+Pws17BXt3lQxlEpUPmDL8kY9jt/BS8UZW8keMKlK7DXiYFy7kQREaK9yX
	 CIZDw/k+3s/ycDFaQZMweawdWBKGVfCIXrJJXiD1KeAfeWsDgzXYC8LBslVP47p2TfRZ6
	 ur+2uJpAoTF+JPL4oztMTs9LZPnT8Tt+/jEmfJe0+kXmMND/K0S9qveNKrS+hBm07kwS2
	 o7thIAxYY/AN4cJpaneWwWFHIzo5SP2R6G5AxUK0dYgWcuW2wtSkUEffEDik1HlwtXRxi
	 4UigiSX2WXx89HqTEKUMnDT3z+X8RCTkUV5YNH6L+CNsseZhIHBnt/os/iY7noBd5iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QifswEpo/VzVa3gM1oejLCHs90gFC7vt6ot63/EwXeM=;
	b=lhWv+hMirhS8y4E9sn02SEYeng869Q7R8iMJMG/Kt92p/vVLVuGGo0M9ZWuJH9T/SB23
	 doeytLT88mYVSEYhtihQIXcKkjAVfRNt3+5wrSBrR4cEOPWNcmi3D8MYcPXWKhRXkGMNY
	 nzZgQ3ruzgVbtABj4UR41cCVW4BHKUccAfN3Ko9UkkEkcwBEcO3IyV8j7Yg5afLqlKg4P
	 YXstr/Oj2p+6AzpCEUI1/8563J/HGTfQ9VPJHmwtQiAswYZwQ+R0Pf/rYi7k5zCP4JeSb
	 CIRYEi9/M8/JmIeVvkoRYvvoLj+IKu3wD6Db+GQRJk+n1dYrvyfY7R5JRSIAVyAX+Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cmz6HFlr;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEAE606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EEAE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cmz6HFlr
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-369ef2c6802so117981eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382495; x=1793987295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QifswEpo/VzVa3gM1oejLCHs90gFC7vt6ot63/EwXeM=;
        b=cmz6HFlrxjsYkh9KmIyQgYp4fuzvyDIEzoTziAXsNdNpg8O2PhgbACnW4IC/mVeDGy
         IE1gOc7WFqaZLUCuMA+jG4dQOIywUoCPedRGG++vuL/TMQF+RyxTBmoCMPyjyRead3J5
         Q00Z1hVkKtQNpMdOz9t0cgsmIaJS7N7Y3mgVNCyS6l+N+CD7D7uzMtYM5aNY43uAcd9S
         +iIvEI7IPWGJ59hi9MOflEo71DV5FI1Z1R5gop2B8czU+OxACB4iWhOdDdTwkfuSuEyi
         YTKd3U+gtyMV4Io5iSWCscaniS/3m6W8shGjHebI06iR7Yvr8wt4xO/UrrSsm+uHrWhp
         b10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382495; x=1793987295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QifswEpo/VzVa3gM1oejLCHs90gFC7vt6ot63/EwXeM=;
        b=jSYWd6dLcN7FFPzVYpr99HgdFP1YSBnwIvSJwRzQO+X/4oMS8MeAiTMmww9hg1pYcA
         xaOFBAO9wDsYVgfWeniVLTbNWSV/NszuCpZd4GK7PaJ7liDaMrJ3tPsNmhY2beoUF1uh
         9asDxuZ97jLlH+Lu12JYXixjvG/8mS/yxnf7qgZea8FqyNB38HP6V1gHrZXTXIo8fC5j
         xXeNPWFP4UFNz+h+1XxlVyW4D8MDcprlvpVaU7LAXf3BH3otJfaflCsOl1+068xHOtaE
         uGb1UFuDoT4915LLYX/rRuymjw0AuTlofphEQA14A5euxwwtLRTlwq9qtlwoL9WURt/v
         DSkw==
X-Forwarded-Encrypted: i=1; AKwUvBzTJNaIFmpglpWi/A+DpPEfo8+5up/qOL+7eAUIfX5oDbBcso2I566uXtQDhWFt6QBW/8Z9Ps0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKBtuKlPWPBz+RCOa+oaLZot3rrG+/onBn+HAv6kOEvQR+s5qy
	gHmAjhfPF7ZSSpomeQgWWEd6ni6TWwDSHRu0mi4Qs+ymcHTZllyWbVQ=
X-Gm-Gg: AYBFou27ODuIq9nTVid91RgOhqQuMepHdqdaCtcyv/R1oaziv7FLOIf2Rh1fo8JIckm
	GtXMpOw2cUxtcK+5k6Dn3sHGV52JvY0zSMZycMCajDxZaeg5G41Oyq3K/K64BvMUzdnR+OnHU2R
	f8YbkzC6ZkeGDfvTZGr7l7TLHYVLZMEOMkmf9gouf8BjkOUIEAWo7maDiQqFRh5Mnv9CDIF/k7J
	0c8k2sj06EP7AiwTv7u4F60N9OzDuxmJakzqpAqhciXqqZ6w/9sBWq1gAJVUAjUAj5M7YudSApr
	rqu5A7FrScOZxPg0+a2UXxHi3O0tByQRF3TG+wfPJn9POeTLaR8bCpOHkxT6AFgZZqlQWyy6v+I
	oEsp/68JBEMBLhIF6PH0AJDD6GklnhMuoZo8rqPDeU/WUuKLs29OOr9cPJoZzFiukT+AYmLHA2R
	nMlNas80PNo74VlMFO5mGc3n3w+xdRxFzErzYskgx1JdJ8ndSkQvZHvUzUhWUN84NsovQUAQssg
	hYVtaRDCPBF+bGZH1t5UxJboRVHAwTUGGU2bzjxzSYknmUQE5FTNGQvBNowUsySWJAwQ7Wq2nU4
	xTwAKKLVJFMHiOyUWTFQQplmFHleqDfr2nimgGLZ
X-Received: by 2002:a05:7300:ce81:b0:357:ee3a:267a with SMTP id 5a478bee46e88-36a422062e0mr4357375eec.2.1793382495268;
        Fri, 30 Oct 2026 10:48:15 -0700 (PDT)
Received: from archlinux ([2405:201:ac01:5300:6b3d:54be:288a:1de1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm7631968eec.4.2026.10.30.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:48:14 -0700 (PDT)
From: Anvik Loitongbam <permissiontogallop@gmail.com>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anvik Loitongbam <permissiontogallop@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: request_key: enforce keyring restrictions on constructed keys
Date: Fri, 30 Oct 2026 23:09:30 +0530
Message-ID: <20261030173930.40948-1-permissiontogallop@gmail.com>
X-Mailer: git-send-email 2.56.0
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

construct_alloc_key() pre-links a newly allocated key into the destination
keyring with __key_link(), bypassing __key_link_check_restriction(). If
the request-key helper instantiates the key with ringid 0 (or any keyring
other than the restricted destination), the key becomes positive while the
provisional link in a restricted keyring remains, so the restriction never
sees the payload, potentially resulting in a policy violation, where a
user with write access can inject keys which are restricted on the restricted
keyring.

Restricted destinations lose the provisional-link deduplication while the
key is being constructed. Callers that pass
KEY_ALLOC_BYPASS_RESTRICTION keep the existing provisional-link behavior.

Fixes: 5ac7eace2d00 ("KEYS: Add a check to restrict new links into a keyring")
Cc: stable@vger.kernel.org
Signed-off-by: Anvik Loitongbam <permissiontogallop@gmail.com>
---
 security/keys/request_key.c | 97 ++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index e6ba2d054399..3de6c9160651 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -370,18 +370,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 			       struct key *dest_keyring,
 			       unsigned long flags,
 			       struct key_user *user,
-			       struct key **_key)
+			       struct key **_key,
+			       bool *defer_link)
 {
 	struct assoc_array_edit *edit = NULL;
 	struct key *key;
 	key_perm_t perm;
 	key_ref_t key_ref;
+	bool link_locked = false;
 	int ret;
 
 	kenter("%s,%s,,,",
 	       ctx->index_key.type->name, ctx->index_key.description);
 
 	*_key = NULL;
+	*defer_link = false;
 	mutex_lock(&user->cons_lock);
 
 	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
@@ -404,6 +407,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
+
+		/*
+		 * A restricted keyring should not take an uninstantiated key,
+		 * the restriction has to be evaluated with the payload,
+		 * which is only available after construction. Skip the
+		 * provisional link and add the key with key_link() later,
+		 * unless the caller explicitly asked to bypass restrictions.
+		 */
+		if (dest_keyring->restrict_link &&
+		    !(flags & KEY_ALLOC_BYPASS_RESTRICTION)) {
+			__key_link_end(dest_keyring, &key->index_key, NULL);
+			*defer_link = true;
+		} else {
+			link_locked = true;
+		}
 	}
 
 	/*
@@ -424,7 +442,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	if (!IS_ERR(key_ref))
 		goto key_already_present;
 
-	if (dest_keyring) {
+	if (dest_keyring && link_locked) {
 		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
 		if (ret < 0)
 			goto link_alloc_failed;
@@ -432,7 +450,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	}
 
 	mutex_unlock(&key_construction_mutex);
-	if (dest_keyring)
+	if (link_locked)
 		__key_link_end(dest_keyring, &key->index_key, edit);
 	mutex_unlock(&user->cons_lock);
 	*_key = key;
@@ -446,15 +464,44 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	mutex_unlock(&key_construction_mutex);
 	key = key_ref_to_ptr(key_ref);
 	if (dest_keyring) {
-		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
-		if (ret < 0)
-			goto link_alloc_failed_unlocked;
-		ret = __key_link_check_live_key(dest_keyring, key);
-		if (ret == 0)
-			__key_link(dest_keyring, key, &edit);
-		__key_link_end(dest_keyring, &key->index_key, edit);
-		if (ret < 0)
+		/*
+		 * The outer search checks Link permission on a key it finds.
+		 * The second search must do the same; otherwise a key that
+		 * appeared in the race window could be linked without the
+		 * caller holding Link permission on it.
+		 */
+		ret = key_task_permission(key_ref, ctx->cred, KEY_NEED_LINK);
+		if (ret < 0) {
+			if (link_locked)
+				__key_link_end(dest_keyring, &key->index_key,
+					       NULL);
 			goto link_check_failed;
+		}
+		if (*defer_link) {
+			/*
+			 * The key may still be under construction, in which
+			 * case its payload cannot be checked yet.  Do not add
+			 * a provisional link to a restricted keyring; only an
+			 * already instantiated key can be checked here.
+			 */
+			if (!key_is_positive(key)) {
+				ret = -EPERM;
+				goto link_check_failed;
+			}
+			ret = key_link(dest_keyring, key);
+			if (ret < 0)
+				goto link_check_failed;
+		} else {
+			ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+			if (ret < 0)
+				goto link_alloc_failed_unlocked;
+			ret = __key_link_check_live_key(dest_keyring, key);
+			if (ret == 0)
+				__key_link(dest_keyring, key, &edit);
+			__key_link_end(dest_keyring, &key->index_key, edit);
+			if (ret < 0)
+				goto link_check_failed;
+		}
 	}
 	mutex_unlock(&user->cons_lock);
 	*_key = key;
@@ -495,6 +542,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 {
 	struct key_user *user;
 	struct key *key;
+	bool defer_link;
 	int ret;
 
 	kenter("");
@@ -512,7 +560,8 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 		goto error_put_dest_keyring;
 	}
 
-	ret = construct_alloc_key(ctx, dest_keyring, flags, user, &key);
+	ret = construct_alloc_key(ctx, dest_keyring, flags, user, &key,
+				  &defer_link);
 	key_user_put(user);
 
 	if (ret == 0) {
@@ -522,6 +571,30 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 			kdebug("cons failed");
 			goto construction_failed;
 		}
+
+		/*
+		 * The key was not provisionally linked because the
+		 * destination keyring is restricted. Link it now that the
+		 * payload is available so the restriction can be checked.
+		 */
+		if (defer_link) {
+			/*
+			 * A helper may have negatively instantiated the key
+			 * (e.g. KEYCTL_REJECT) and returned success.  A
+			 * restricted keyring must not cache a negative key;
+			 * key_reject_and_link() rejects those too.
+			 */
+			if (!key_is_positive(key)) {
+				ret = -EPERM;
+				key_put(key);
+				goto error_put_dest_keyring;
+			}
+			ret = key_link(dest_keyring, key);
+			if (ret < 0) {
+				key_put(key);
+				goto error_put_dest_keyring;
+			}
+		}
 	} else if (ret == -EINPROGRESS) {
 		ret = 0;
 	} else {
-- 
2.56.0

