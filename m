Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781682;
	b=c0bLpj0kVr7isUsBxQROARehUfvB1zXh5CgOTnfed6QrecaZZ6K+khwUqzm/f42aEk8W
	 +WJQBp0LHV/ibQAKP0qs6jo4KRZutdnuqtD980tslG+O9sw9eJLOooMVGsz+zoE6hKDYp
	 YdmGFdo77hHw7M5VYbBm3m0i/yHDG3kI8E4ob/95PGJxnWYre4uNLGBQ21nVxSgNf79RD
	 xvi/fZW3cD77SYY+rrw28FEm85XEZgxzG/lbta2cooCLdh+KF8GvKI9uuWvqSNgeUW03X
	 LaUhjH6+bsKdO4vz+6OYHPZrU6tmCol60Mz9sfxj56/2GCZVLYRaMadp4SZK3xCV/7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tJkp4jjw29pq/VBXLpjOqSdlrx+Ca5bWhyG9uxhkkZc=;
	b=hp60X+w2l4cG8INnhvL2VI+DUORp5NbXkqHo9l6NeBOQWQgL3ZAfvXKdZS+Y/agdEIgT
	 jTXpqknWKgEfSnh9LXc/icVXW9Q02fU7+hiuT1153OF/swy1l+i2+Kie0ar0RoXgsrekK
	 Al00qRdVjUFFbAMfzLQITPBzpAGAk+hriRKev995dqMUKBrNI7lYYprUwr8jOmu+OkyLf
	 jfM32eo4scAH0FPGSxnb5PR16B18LoK35pcvECxyRPCjuJMsc1OhGOpk2dUlXhpZBSQ3m
	 gHO49L263HFAIE3J8dfitj9VqNDezpeBKUAKcdLoLvmfuj8VSMx9QY2ShWWEzLpXtag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMWIudjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 55E03606A31C;
	Fri, 27 Nov 2026 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMWIudjD
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2BB131F00897;
	Fri, 27 Nov 2026 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781681;
	bh=tJkp4jjw29pq/VBXLpjOqSdlrx+Ca5bWhyG9uxhkkZc=;
	h=From:To:Cc:Subject:Date;
	b=FMWIudjDWVn3Gidsk10pQzsf6soPY1SlOwITA5tQV0A7nfT9V7YS5Qw7Jx3ux+ySB
	 /1KFcj7KVlmcHySV0I/ZYEGMA/zE9LWE9Y+qSJcfzSOkuJEjkwTcdHrDYu/skqnSr/
	 sI2RN3DwA7N1fIS4AQnhyT5gzWVnPcf0VC5OHG407PRdieFmAlN47Lxf4BT80yb/iX
	 WL1ZlFMgzRM00IwFZOHZ74RFGZIRIpH1nGuGweGeZTDXH/02oEuZO5ED0mxm9z9HXJ
	 EWJ2LPZ+hKu18yxnLI6c8Qax6LrEqKEDdvmftA3ecM5mdjor6fTRMCZ8ecsPY8fAFT
	 AwN6SBy1D8uYQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v4 1/2] KEYS: Return user session keyring on lookup
Date: Fri, 27 Nov 2026 14:14:31 +0200
Message-ID: <20261127121433.2400766-1-jarkko@kernel.org>
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

A process without a session keyring looking up KEY_SPEC_SESSION_KEYRING
without KEY_LOOKUP_CREATE mutates the credentials. This causes struct creds
instances shared with other subsystems to become stale.

Address this by returning the resolved user session keyring directly
without installing it into credentials.

Cc: stable@vger.kernel.org # v5.10+
Cc: keyrings@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
Suggested-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
- No changes, resend.
v3:
- In keyctl_session_to_parent(), check the resolved
  cred->session_keyring instead of mycred->session_keyring.
v2:
- Added mandatory tags.
- No code changes.
- Link: https://lore.kernel.org/keyrings/20261019145624.309790-1-jarkko@kernel.org/
 Documentation/security/keys/core.rst |  6 ++--
 security/keys/keyctl.c               |  5 ++--
 security/keys/process_keys.c         | 44 +++++++---------------------
 3 files changed, 16 insertions(+), 39 deletions(-)
---
 Documentation/security/keys/core.rst |  6 ++--
 security/keys/keyctl.c               |  5 ++--
 security/keys/process_keys.c         | 44 +++++++---------------------
 3 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 37ed42382f16..e3a215e55f81 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -165,8 +165,10 @@ The key service provides a number of features besides keys:
      When a process changes its real UID, if it used to have no session key, it
      will be subscribed to the default session key for the new UID.
 
-     If a process attempts to access its session key when it doesn't have one,
-     it will be subscribed to the default for its current UID.
+     If a process attempts to access its session keyring when it doesn't have
+     one, the default user session keyring for its current UID is returned
+     without being installed into its credentials.  If creation is requested,
+     an anonymous session keyring is installed.
 
   *  Each user has two quotas against which the keys they own are tracked. One
      limits the total number of keys and keyrings, the other limits the total
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d6b10fd67627..b11716f88ded 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1682,8 +1682,7 @@ long keyctl_session_to_parent(void)
 	 * there's no point */
 	mycred = current_cred();
 	pcred = __task_cred(parent);
-	if (mycred == pcred ||
-	    mycred->session_keyring == pcred->session_keyring) {
+	if (cred->session_keyring == pcred->session_keyring) {
 		ret = 0;
 		goto unlock;
 	}
@@ -1701,7 +1700,7 @@ long keyctl_session_to_parent(void)
 	/* the keyrings must have the same UID */
 	if ((pcred->session_keyring &&
 	     !uid_eq(pcred->session_keyring->uid, mycred->euid)) ||
-	    !uid_eq(mycred->session_keyring->uid, mycred->euid))
+	    !uid_eq(cred->session_keyring->uid, mycred->euid))
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 3af71c6322af..cdf03b8124d0 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -356,31 +356,6 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 	return 0;
 }
 
-/*
- * Install the given keyring as the session keyring of the current task,
- * replacing the existing one if any.  If the given keyring is NULL, then
- * install a new anonymous session keyring.
- *
- * Return: 0 on success; -errno on failure.
- */
-static int install_session_keyring(struct key *keyring)
-{
-	struct cred *new;
-	int ret;
-
-	new = prepare_creds();
-	if (!new)
-		return -ENOMEM;
-
-	ret = install_session_keyring_to_cred(new, keyring);
-	if (ret < 0) {
-		abort_creds(new);
-		return ret;
-	}
-
-	return commit_creds(new);
-}
-
 /*
  * Handle the fsuid changing.
  */
@@ -720,20 +695,21 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 
 	case KEY_SPEC_SESSION_KEYRING:
 		if (!ctx.cred->session_keyring) {
-			/* always install a session keyring upon access if one
-			 * doesn't exist yet */
 			ret = look_up_user_keyrings(NULL, &user_session);
 			if (ret < 0)
 				goto error;
-			if (lflags & KEY_LOOKUP_CREATE)
+
+			if (lflags & KEY_LOOKUP_CREATE) {
+				key_put(user_session);
 				ret = join_session_keyring(NULL);
-			else
-				ret = install_session_keyring(user_session);
+				if (ret < 0)
+					goto error;
+				goto reget_creds;
+			}
 
-			key_put(user_session);
-			if (ret < 0)
-				goto error;
-			goto reget_creds;
+			key = user_session;
+			key_ref = make_key_ref(key, 1);
+			break;
 		} else if (test_bit(KEY_FLAG_UID_KEYRING,
 				    &ctx.cred->session_keyring->flags) &&
 			   lflags & KEY_LOOKUP_CREATE) {
-- 
2.47.3

