Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157339DBCC
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882249; cv=none; b=ZatdDQ0mFMLfTKTSxlyk8pM7XW0pk+Bo/AO0jfHGYESA+pP7sYaJbtDNiXxptXK1fgfAWBQCLLvLwZo7flHAI+0JCe3WZzbUvU77XuP73aKEAP4YGrlE9RbqGvk1m9q70IPzRW5flFxXofa7S8cggtLQwMNF45sH3L4ci/EL9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882249; c=relaxed/simple;
	bh=1oDriChURZPshYQWfLX6W+SoRjzlAPzsgRXYOZsx3JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTgRhvuapmWyXqfIInsQ6Vzzf+/rS6XaNom0MiPzPWZW4r/AYmcAlMh/KxTLN9nNvCovhGSAvJVIUWE78csc8y1nSVG4iDQ+lXQSJ1cksC/aoW8ZGymrskqxh6nmUekWlKSCo9N+xgcYbE2bggL+mb9BshAWr4wvfbMtIZ+EepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ9DXqXJ; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ9DXqXJ"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-142eed7df08so228020c88.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791882246; x=1792487046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLHMgr985P+kVdaCPslV6Iv4+PQzUDULB9m3V+hBlNg=;
        b=bZ9DXqXJO9Lg/fbejXrUN7kf77Iszki30EVjrVhGEcRGGtUlpv5ixOG133YCwyDb3r
         NVZvC0SdYnuClogsKEnQ1ZHVNZIDNJ8wrSCxmltvsiW5ir5OqHqIYXjSoJCwVE6paaNP
         KELLcBqC24OGkmPwSFz0mbDIGBvUbmo2MNCBvf9OVAKFFWcMoa5RKuWrZ3OCa8li0EHV
         KMMlDKmQIunwnN9VhswhgxoW57rvC2WRh+4jPyTQJQYuIcNBhhgCmVxn3gct7FGTDImq
         TqDp/UtAlpCu8UPDsB+zYXTKNNYL+/xS1I8fHyHGhdOpmwVlOBmzMxtcDGJAXqwybjxX
         /q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882246; x=1792487046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fLHMgr985P+kVdaCPslV6Iv4+PQzUDULB9m3V+hBlNg=;
        b=GAz0JP8jq1wLg6XHH4+iIZjgA1ZhEQ1C+/8/Y259zD0ZTG0fb/b6+T7QKWhUBhAwAv
         MyC7FRVAuVVCR5mK1Nj69GjHpTJ1fTuL2JU6NMnzu6xab0yn8vhB4KraIxICi9mUWSf3
         6kw34jiX+Avwoht8klfFaP7HRIZ7bFscbSNkuAoS0bIuODg3JlgbPeRUwdEy4l6jg2oZ
         BLGhCFa1OeE74YvwyHgzPaTz27FKrjaRfuRrN7CkLsG/T9qD0TEggcLo2/q+1wN9BpUq
         zrCO4be8Q5vXg5NbcoAt8M+P0RnHuwuiRXelJSySKGU56eFKh8jiElfe69RL9vBiKq7f
         pOtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUYR6H5kQeUaaarnJ5CoAeG01EcdMmqRYgpx8xYfSzII//VfY8EyO18Sn+sbfyHmvEsgRsTDQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkui8ozkGJ7Qighr07b1XMiYBsl7Y8ijJ57uafv4yFMIjSFwan
	9uP6iGXsziKv8LYhA1U9fI+EQZLT2+57zYCZwIvMYpqnKBJAKsPFfvyu
X-Gm-Gg: AYBFou2L0tTNoM4hf2ylQqLREoaChRAb8kHmuh3MUj4BQFqxxx/ZXPCAh8Dc6dyE+GA
	IvOcpnOCpo8LVOrypCr0+7GR1TftW71wIPWkGHcG5ZHNk+8lux31UD81BYrzmCi1jBhtnBpgvu1
	Rx0KM7wAPSxxx/Kecl6kbyWSGCdX28cgGZ7UNRoRsAU3KRARcSMkEqBNY5AsI/C6pNyixGyctSN
	uMfxkgT+UmT6j8Hf8FR2lFqEkv75irE2fa20J7IO3HRMTzO3EWcIL+JpSVBNHxC7ccg5zMHAoB9
	QkOMUEzxvl/FuRJd3OJW308fcg72LSqSTaXePUFLkgg+Tdgp0Lk43l65d3farbnM7JKSLw3clf3
	CjIo8JdCdtxN12YcdZHwHV6TDcnU+BPDJTMjA/hfr/ikIeyUq8RWwWoAi7zKymBA6Zcl+Ggl+fg
	o3J432Z5Mou/J0ta+0QnRL0FCm7RLZFRcUa4lmVcLdvuGPsRxbKSwxRQgVmcA7rhfl8etkx7ZI6
	ubUa/tyw447CGwYlv+WwrY7AwswlNjEOKBy6zfNCxnHPQG0QZlSNIcUwA/vrpB/
X-Received: by 2002:a05:701b:2815:b0:14c:cc55:aba1 with SMTP id a92af1059eb24-16a5afe6569mr28530186c88.1.1791882245696;
        Tue, 13 Oct 2026 02:04:05 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm36281803c88.11.2026.10.13.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:04:05 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v4 1/2] keys: Protect quota-owner reads in namespace filters
Date: Tue, 13 Oct 2026 17:03:57 +0800
Message-ID: <20261013090358.1178367-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keyctl_chown_key() replaces key->user under key->sem and drops the
reference to the previous owner after releasing the semaphore. Readers
which do not hold that semaphore can still be using the previous owner
when key_user_put() frees it.

For example, namespace filtering in /proc/keys can race with chown:

  /proc/keys reader                 keyctl_chown_key()
  user = key->user
                                    key->user = newowner
                                    key_user_put(old)
                                      kfree(old)
  read user->uid

An earlier instrumented run reported:

  BUG: KASAN: slab-use-after-free in proc_keys_start+0x353/0x440
  Read of size 4 at addr ffff8881128abbc0 by task poc/88
  Call Trace:
   proc_keys_start+0x353/0x440
   seq_read_iter+0x25d/0x1190
   proc_reg_read_iter+0x19e/0x260
  Allocated by task 86:
   key_user_lookup+0x1b4/0x540
   keyctl_chown_key+0x3cc/0xbf0
  Freed by task 87:
   kfree+0x149/0x330
   keyctl_chown_key+0x7b0/0xbf0

Take key_user_lock explicitly while /proc/keys and find_keyring_by_name()
copy the owner's UID. find_ge_key() is the initial/seek lookup reached
by the reported proc_keys_start() fault; key_serial_next() applies the
same UID filter to subsequent entries. find_keyring_by_name() reads the
same replaceable owner when looking up named keyrings.

key_serial_lock and keyring_name_lock protect these traversals but do
not exclude chown. Taking key->sem would sleep under those spinlocks.
The embedded key->user->lock cannot protect the dereference needed to
acquire it.

key_user_put() already holds key_user_lock for the final reference
decrement and tree removal. A reader selecting an owner before removal
blocks its final release until the UID copy finishes. After removal,
the lock and reference-count ordering make the preceding owner
replacement visible, including when another task drops the final
reference. Mark the pointer loads with READ_ONCE() and the chown store
with WRITE_ONCE(); the existing lifetime locking provides the protection.

Retain the quota-owner UID rather than substituting key->uid, since they
may differ for thread keyrings.

Other owner accesses already have lifetime protection. key_alloc() uses
a referenced owner before publishing the key. Final key_put() cannot
overlap chown, which holds a key reference. key_gc_unused_keys() handles
unreferenced keys: serial-tree removal excludes /proc/keys readers, and
keyring_destroy() removes named keyrings under keyring_name_lock before
the owner reference is dropped. /proc/key-users already holds
key_user_lock during traversal. Quota reservation and instantiation need
the separate accounting serialization.

Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v4:
- Move the quota-reservation and instantiation scopes from v3 1/2 to
  the complete accounting fix in 2/2; retain the combined lock coverage.
- Isolate the namespace-reader lifetime fix and make it independent of the
  accounting patch by relying on existing lookup/final-release locking.
- Pair READ_ONCE() pointer snapshots with WRITE_ONCE() in chown; explain
  lifetime ordering and preserve the quota-owner UID filtering semantics.
- Include analysis of of the other owner access sites in the changelog

v3: https://lore.kernel.org/r/20260927162528.943886-2-nicoyip.dev@gmail.com/
v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/

 security/keys/keyctl.c  |  2 +-
 security/keys/keyring.c |  7 ++++++-
 security/keys/proc.c    | 15 +++++++++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529c..c89a4d6efed40 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1039,3 +1039,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 		zapowner = key->user;
-		key->user = newowner;
+		WRITE_ONCE(key->user, newowner);
 		key->uid = uid;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 15bf4af8f2821..4a13749bc54cd 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1148,6 +1148,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 {
 	struct user_namespace *ns = current_user_ns();
 	struct key *keyring;
+	kuid_t uid;
 
 	if (!name)
 		return ERR_PTR(-EINVAL);
@@ -1158,7 +1159,11 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	 * grants Search permission and that hasn't been revoked
 	 */
 	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
-		if (!kuid_has_mapping(ns, keyring->user->uid))
+		spin_lock(&key_user_lock);
+		uid = READ_ONCE(keyring->user)->uid;
+		spin_unlock(&key_user_lock);
+
+		if (!kuid_has_mapping(ns, uid))
 			continue;
 
 		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 4f4e2c1824f18..aa42ea4becec7 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -68,7 +68,13 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
 	n = rb_next(n);
 	while (n) {
 		struct key *key = rb_entry(n, struct key, serial_node);
-		if (kuid_has_mapping(user_ns, key->user->uid))
+		kuid_t uid;
+
+		spin_lock(&key_user_lock);
+		uid = READ_ONCE(key->user)->uid;
+		spin_unlock(&key_user_lock);
+
+		if (kuid_has_mapping(user_ns, uid))
 			break;
 		n = rb_next(n);
 	}
@@ -80,6 +86,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
 	struct user_namespace *user_ns = seq_user_ns(p);
 	struct rb_node *n = key_serial_tree.rb_node;
 	struct key *minkey = NULL;
+	kuid_t uid;
 
 	while (n) {
 		struct key *key = rb_entry(n, struct key, serial_node);
@@ -100,7 +107,11 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
 		return NULL;
 
 	for (;;) {
-		if (kuid_has_mapping(user_ns, minkey->user->uid))
+		spin_lock(&key_user_lock);
+		uid = READ_ONCE(minkey->user)->uid;
+		spin_unlock(&key_user_lock);
+
+		if (kuid_has_mapping(user_ns, uid))
 			return minkey;
 		n = rb_next(&minkey->serial_node);
 		if (!n)
-- 
2.43.0

