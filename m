Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542050;
	b=rFHZwUk7DHWlCELvw1ouKYzacXHP3cX4seneXeouLnpErsS2C8vBCScN5c7z8D6l4bp6
	 zsL66EjoJJzdkN8Qit5q1CgTQbHmGO6nWKrVFaebW0y9gZ6A0HT1ZfhJ6ED5TnOvtLi0c
	 /xrJcJ3WaGqwI18Bkr273FQ2hht9BjpI4FhkkfVN779Ylmhgev1bxce0fODBtGOp0eC8f
	 XCX56BJ+UNy7l4fnUmESg1l4BAORoIbKp4H9YFE1/cntGv2rOFODNyVsg/ENjh/1B5McY
	 GAog5GJHjMF6XbueiKLTuhYeNu6y2+FYphTaoRcWmxTbJ6cNrEA/14ozwAX4xbiyJdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JiGfcjdRCtDBnzyi05+TISnK9oMnqVD2ugNTFvJl//U=;
	b=TcUVJYUsPR6l+x0U5MquqbodTrte7qZ+Geggj8V4oVSOf0NoNOC7DN/MQlJmQvxVXnIp
	 YIbjqN1W0U58Riq6aUC9ln6gEdJNqyaU/K0ZpbrfnSQEVji34r2X21peGlXe7xDCQm173
	 tPxR3bCL9myJEBO9iPDWrjArJLwYaa+wD96JJdSmMBI30Lx5QrOwZVwVPu/XFkMKOAr8Q
	 dbgte2WvoGUP7GjfHpQUH0NaugTa2i3xHozz9mDSKQJNVzGBAkTbO6Rag+AFbI2rMogck
	 ploclz4nm92hn7YlU7zC2CsgQAM7tfTGWUz362d2BrB54e7DoCKD2MoS/r/90Z+J+aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3WQWTT8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 55FCD606A330;
	Tue, 24 Nov 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3WQWTT8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6D0341F000D8;
	Tue, 24 Nov 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542050;
	bh=JiGfcjdRCtDBnzyi05+TISnK9oMnqVD2ugNTFvJl//U=;
	h=From:To:Cc:Subject:Date;
	b=Q3WQWTT8PUP6LAMfy0AbjbR2hWcvA37uwO+ozMsBmV072eee7nDT8JBDvi5aX/zWJ
	 Tg77Jh8j/w9fqCWGZYvmBy8U3HxzE80n5JuN+sH1SqhPzNJDPJs6bY2oKwU87TNfna
	 BZqNBhjv1qVxdBrn5+d6vk2e9YdtpfMEm77srxXvKo/dONpe9gl6j8RtprcXJCtshy
	 kg97K4E3gzF6xFhfy573WQbZ1zk5q187g9Fl3+BWT432i5pvdkjLCG6rOHIRisPj56
	 /e2I2gapOH8PGUt7y1MqMhFnks704B8/jO8N5rmPkrA55kC7QGGgeLwHZITjlCG4mn
	 +xWKbWuysrs6Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Guicai Ma <maguicai@kylinos.cn>
Subject: [PATCH] KEYS: Prevent key type removal during key_instantiate_and_link()
Date: Tue, 24 Nov 2026 19:40:35 +0200
Message-ID: <20261124174035.1614480-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
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

key_instantiate_and_link() accesses key->type outside key->sem, which can
lead into null deref due that key types can be dropped at any possible
time.

Address this by moving key_construction_mutex inside key->sem, and match
that order in key_reject_and_link())

Cc: stable@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Guicai Ma <maguicai@kylinos.cn>
Closes: https://lore.kernel.org/r/20261124091243.1019217-1-maguicai@kylinos.cn
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 139 ++++++++++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 58 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 5854c2e2c4e6..ea1046bbb4db 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -422,66 +422,56 @@ static void mark_key_instantiated(struct key *key, int reject_error)

 /*
  * Instantiate a key and link it into the target keyring atomically.  Must be
- * called with the target keyring's semaphore writelocked.  The target key's
- * semaphore need not be locked as instantiation is serialised by
- * key_construction_mutex.
+ * called with the target keyring's semaphore writelocked (if @keyring is
+ * given) and the target key's semaphore writelocked.
  */
 static int __key_instantiate_and_link(struct key *key,
 				      struct key_preparsed_payload *prep,
 				      struct key *keyring,
 				      struct key *authkey,
-				      struct keyring_edit *edit)
+				      struct keyring_edit *edit,
+				      bool *awaken)
 {
-	int ret, awaken;
-
-	key_check(key);
-	key_check(keyring);
-
-	awaken = 0;
-	ret = -EBUSY;
+	int ret;

-	mutex_lock(&key_construction_mutex);
-	down_write_nested(&key->sem, 2);
+	lockdep_assert_held_write(&key->sem);

 	/* can't instantiate twice */
-	if (key->state == KEY_IS_UNINSTANTIATED) {
-		/* instantiate the key */
-		ret = key->type->instantiate(key, prep);
+	if (key->state != KEY_IS_UNINSTANTIATED)
+		return -EBUSY;

-		if (ret == 0) {
-			/* mark the key as being instantiated */
-			atomic_inc(&key->user->nikeys);
-			mark_key_instantiated(key, 0);
-			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
+	/* instantiate the key */
+	ret = key->type->instantiate(key, prep);
+	if (ret)
+		return ret;

-			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
-				awaken = 1;
+	mutex_lock(&key_construction_mutex);

-			/* and link it into the destination keyring */
-			if (keyring) {
-				if (test_bit(KEY_FLAG_KEEP, &keyring->flags))
-					set_bit(KEY_FLAG_KEEP, &key->flags);
+	/* mark the key as being instantiated */
+	atomic_inc(&key->user->nikeys);
+	mark_key_instantiated(key, 0);
+	notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);

-				__key_link(keyring, key, edit);
-			}
+	if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags) && awaken)
+		*awaken = true;

-			/* disable the authorisation key */
-			if (authkey)
-				key_invalidate(authkey);
+	/* and link it into the destination keyring */
+	if (keyring) {
+		if (test_bit(KEY_FLAG_KEEP, &keyring->flags))
+			set_bit(KEY_FLAG_KEEP, &key->flags);

-			if (prep->expiry != TIME64_MAX)
-				key_set_expiry(key, prep->expiry);
-		}
+		__key_link(keyring, key, edit);
 	}

-	up_write(&key->sem);
-	mutex_unlock(&key_construction_mutex);
+	/* disable the authorisation key */
+	if (authkey)
+		key_invalidate(authkey);

-	/* wake up anyone waiting for a key to be constructed */
-	if (awaken)
-		wake_up_bit(&key->flags, KEY_FLAG_USER_CONSTRUCT);
+	if (prep->expiry != TIME64_MAX)
+		key_set_expiry(key, prep->expiry);

-	return ret;
+	mutex_unlock(&key_construction_mutex);
+	return 0;
 }

 /**
@@ -498,7 +488,9 @@ static int __key_instantiate_and_link(struct key *key,
  *
  * If successful, 0 is returned, the authorisation token is revoked and anyone
  * waiting for the key is woken up.  If the key was already instantiated,
- * -EBUSY will be returned.
+ * -EBUSY will be returned.  If the key's type has been removed, -EKEYREVOKED
+ * will be returned.  If the key type does not provide an instantiate method,
+ * -EOPNOTSUPP will be returned.
  */
 int key_instantiate_and_link(struct key *key,
 			     const void *data,
@@ -508,8 +500,35 @@ int key_instantiate_and_link(struct key *key,
 {
 	struct key_preparsed_payload prep;
 	struct keyring_edit edit = {};
+	bool awaken = false;
 	int ret;

+	key_check(key);
+	key_check(keyring);
+
+	if (keyring) {
+		ret = __key_link_lock(keyring, &key->index_key);
+		if (ret < 0)
+			return ret;
+	}
+
+	down_write_nested(&key->sem, 2);
+
+	if (test_bit(KEY_FLAG_DEAD, &key->flags)) {
+		ret = -EKEYREVOKED;
+		goto out_unlock;
+	}
+
+	if (!key->type->instantiate) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	if (key->state != KEY_IS_UNINSTANTIATED) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	memset(&prep, 0, sizeof(prep));
 	prep.orig_description = key->description;
 	prep.data = data;
@@ -519,17 +538,13 @@ int key_instantiate_and_link(struct key *key,
 	if (key->type->preparse) {
 		ret = key->type->preparse(&prep);
 		if (ret < 0)
-			goto error;
+			goto out_free_preparse;
 	}

 	if (keyring) {
-		ret = __key_link_lock(keyring, &key->index_key);
-		if (ret < 0)
-			goto error;
-
 		ret = __key_link_begin(keyring, &key->index_key, &edit);
 		if (ret < 0)
-			goto error_link_end;
+			goto out_free_preparse;

 		if (keyring->restrict_link && keyring->restrict_link->check) {
 			struct key_restriction *keyres = keyring->restrict_link;
@@ -537,19 +552,22 @@ int key_instantiate_and_link(struct key *key,
 			ret = keyres->check(keyring, key->type, &prep.payload,
 					    keyres->key);
 			if (ret < 0)
-				goto error_link_end;
+				goto out_free_preparse;
 		}
 	}

-	ret = __key_instantiate_and_link(key, &prep, keyring, authkey, &edit);
-
-error_link_end:
-	if (keyring)
-		__key_link_end(keyring, &key->index_key, &edit);
+	ret = __key_instantiate_and_link(key, &prep, keyring, authkey, &edit,
+					 &awaken);

-error:
+out_free_preparse:
 	if (key->type->preparse)
 		key->type->free_preparse(&prep);
+out_unlock:
+	up_write(&key->sem);
+	if (keyring)
+		__key_link_end(keyring, &key->index_key, &edit);
+	if (awaken)
+		wake_up_bit(&key->flags, KEY_FLAG_USER_CONSTRUCT);
 	return ret;
 }

@@ -610,11 +628,12 @@ int key_reject_and_link(struct key *key,
 		}
 	}

-	mutex_lock(&key_construction_mutex);
 	down_write_nested(&key->sem, 2);

 	/* can't instantiate twice */
 	if (key->state == KEY_IS_UNINSTANTIATED) {
+		mutex_lock(&key_construction_mutex);
+
 		/* mark the key as being negatively instantiated */
 		atomic_inc(&key->user->nikeys);
 		mark_key_instantiated(key, -error);
@@ -633,10 +652,11 @@ int key_reject_and_link(struct key *key,
 		/* disable the authorisation key */
 		if (authkey)
 			key_invalidate(authkey);
+
+		mutex_unlock(&key_construction_mutex);
 	}

 	up_write(&key->sem);
-	mutex_unlock(&key_construction_mutex);

 	if (keyring && link_ret == 0)
 		__key_link_end(keyring, &key->index_key, &edit);
@@ -957,7 +977,10 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 	}

 	/* instantiate it and link it into the target keyring */
-	ret = __key_instantiate_and_link(key, &prep, keyring, NULL, &edit);
+	down_write_nested(&key->sem, 2);
+	ret = __key_instantiate_and_link(key, &prep, keyring, NULL, &edit,
+					 NULL);
+	up_write(&key->sem);
 	if (ret < 0) {
 		key_put(key);
 		key_ref = ERR_PTR(ret);
--
2.47.3

