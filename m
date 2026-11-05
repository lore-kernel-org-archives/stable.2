Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916078;
	b=pZsckyvnyj4LT0nqaW1v/Yk39u05cx/D3OZIKuJwPPKUESyYa3u90c6gqWTYwLnGQsiz
	 1KfMBngEmSk/Ai0BrUGRmOoplBfgDy3KUczVZhsQjJ5htPTlGjPlShMp/QyBwt6f7R3rN
	 Mwt2Ne3bPSvYcdEN+VF+VCIpYQ8Be31+lanujudMslkNfMpH3c/mrc8Kyjm/xF0kGVtpn
	 KseM5X0uxhlOhYb4jQ3fzVxBD3QFbRvT83PJbEq2bRFpCOdSMJdz2J7rCY3pany4q1KKo
	 N8mSVrBUEX7aOE2Gk4Xd8wzuqzry3uK2NBb3q7701XdKdJ7Fiy4FvBJOExlFX+vncOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cgy5DVilFM6CzFnBGEzM5eRHWtTZeelbHEfIqvrPH2w=;
	b=5pdWY0xVqjG+oO66zGeKk2i98di1ye3ThlhehIIIXr+9X2X5YUQICsiHKrNl6e+MKsT+
	 7LGidzIx18POUaFzkDpFdJwJvYjMODjJUCw6hd0kAIO0rRr0tU27TBL4kXwkBGGg2yqTH
	 0+6gLI3uAKpDnWFG4wygm6MzfNLFqjNVVLKX0EX41F9vjpYjpy0iTBZti9UDWVDM4cI/J
	 TNGrV3O5b4uAAPUYxMC/LeW59nls8q1ZSpMc7vy/riEK96pK4cBo/VB0WmfULNDz/Ezdq
	 nv+99d+nIksn/zUGRhxsd8Wf+M/rmP8dfENVGXS7imZdc+pUUrD0hRp56b0S+/L9D4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WieLlrYp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9D56C606A328;
	Thu,  5 Nov 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WieLlrYp
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B60B61F0089F;
	Thu,  5 Nov 2026 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916077;
	bh=Cgy5DVilFM6CzFnBGEzM5eRHWtTZeelbHEfIqvrPH2w=;
	h=From:To:Cc:Subject:Date;
	b=WieLlrYpj6+/bEFJYfS1yZhcO+5c9zQePcf6xFYXBujXL9SxObOqW8ynbGFIvLrh7
	 kwumTlytIdkTabqBjsvGiu/LjEqze+sE9/NX5dWotEcEgaLWM5r7IuRWrnQwFr6dLU
	 Uq8KW6FntZ+xYDHg6TflPiA1ycHdmaAnRuCfcI2zfZJR7mR/0Kf22FXX27PwUPbNVv
	 YrP5u9NbVfivcdkJzenMEe2e20T4In/SJJqfsMUM8WGn74tu6WSWuPJTZlpIVpZGn9
	 oFm/vhwTWqjJfSg0vPSDfPESFaJDZGippf3IhTrpTv4aIFhYU1Zap3I4h5cPIQ8zez
	 NMfAjS1SZRU1w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 1/2] KEYS: Return user session keyring on lookup
Date: Fri,  6 Nov 2026 00:00:49 +0200
Message-ID: <20261105220050.1421842-1-jarkko@kernel.org>
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

Cc: keyrings@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: stable@vger.kernel.org # v5.10+
Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
Suggested-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
In keyctl_session_to_parent(), check the resolved cred->session_keyring
instead of mycred->session_keyring.
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

