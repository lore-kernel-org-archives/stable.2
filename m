Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421796;
	b=JMYM5XwsorwVN4aeuRb0pLE67jJ4KGTJ+0YWCgIgurn6sCzacK4Q7ZpgN62jIM9J2ztF
	 /LM9L4xUwjvOozliYEBJUEuzVzbSPmA0sE42GCJNqdO8ZNgET3FihlUhTn5g1xF2ymsRy
	 /+XHCNv2cW7gNay7APjPEGUJjjMXQX4rKKxL5GmsqGq0crQXSJJexj7wutWKt2ZMhtjQ9
	 OH/fV5R/n/J6Of5ryDyYr1UDLhkaHS2CtjVuRiCKFIp0AthfqrFerfjfxWmStel5qNIwJ
	 DmEi2npRPOQpT5PGqNDkVH95AOrJIwyAbJYNR37+WzM1JJPSdk+7KAFfMJrrvCu2uVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421796;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1Gq2xabCUzWCgQFVttvePt4Zi7fwm2U8qXzH8Q9Ni/Q=;
	b=wg3HlpDwDLWCVRlHEgLAWX89EDzaAIF+t9KVaH/CfXH22h/EZKvvpuExERjRU5e1v8Vn
	 DdV+S2VZ1hYzUfQXx19xzALN2k60b0AMPw+eMIwsFP9urt8rXG5HpZa36XCs+nItRpdY5
	 UyTn7Ma8C+lBwUTEnExmO3z/Krz6hkqzEBx8wh+dj9btGwmiW7hmHpR7qOamXCtxXqqcw
	 4K0mfXL+M3pfmeimO/t4C+pe+CrYtHgwd+4Zzz4ZhZ6CClU2C4jWXYxgpBOzP2HOvIqwW
	 BFo3KhTMHtr4XEa/lXxC2ev133PknMtJYkQZ1hFHoWljwvlbsLCusD+12RCfVt7AxHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4FlIoiC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1760724A8;
	Mon, 19 Oct 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4FlIoiC
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95206513C1;
	Mon, 19 Oct 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421796; cv=none; b=erpIf4m0+al3Unx5M7lfx9ZeMDn72Ek7RlA2D3BblYUZqi7fPB/eFBHg0uRYVLTZx7Z59Gdlv6NhWSg9SukG7YwOxwdDaEGKBmkNT6Ig3sSFUuEHlmpk2999Vb96+zjaXNDN3hUAnSVH609cz0WKGZeT2XPfFvu3ZjOMNNRzxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421796; c=relaxed/simple;
	bh=DwEfxiBZ++0PR9E/Pqv4joVI5/7plphHGS4+UCDxy1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JggorhJoy5DgEkisj0J35jWkhKqWmAYeVYIv05IXg89w4GwKs01cuOydHKW3Ia1NJkQ/QdMUM6T+VIammAaTn7z8ISG/wqOxq3pIM0eB/qSyhbBe/Xllin0Vs+eUYQSQaqAmmiW18/sfbzbRnK03EewQdkCBAExbwsOzJPuBKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4FlIoiC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D584D1F000C4;
	Mon, 19 Oct 2026 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421795;
	bh=1Gq2xabCUzWCgQFVttvePt4Zi7fwm2U8qXzH8Q9Ni/Q=;
	h=From:To:Cc:Subject:Date;
	b=h4FlIoiCv3D+ES1G8MT6j4RW5bq5GmaYRH8qBgMKRvYB9D+WXOrDPcOdQiio5dRbH
	 63rANYmMZGMaPbaJyKssOyszIcvC9xZiDdCfCIrUYs+KNq68eqwlM9RKo0NhRVWymP
	 uK4qvvpy/hCnvoSpVbOujwVGPDX7YJzKTwUtTPxdiTPTZVCmNLPUIhwE89NR3iFQrd
	 h344LLQpsnjnYK2vf7wzSYHZEh6MoeAYvCUR34MaGT7AAbSSocDkkdVFAkhw4Jf0+C
	 WGLJE6jDVhw4G23yht9x/8Z1P/6mTNUHP5QvH06i8RLPg6v6SALgp8OGkqS8SYpioN
	 4Qk3hu5whq3lA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 1/2] KEYS: Return user session keyring on lookup
Date: Mon, 19 Oct 2026 17:56:22 +0300
Message-ID: <20261019145624.309790-1-jarkko@kernel.org>
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
Suggested-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Added mandatory tags.
- No code changes.
---
 Documentation/security/keys/core.rst |  6 ++--
 security/keys/process_keys.c         | 44 +++++++---------------------
 2 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 326b8a973828..c81a3a9fe236 100644
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
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 1a51a36ce32a..558ffe58b5d6 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -346,31 +346,6 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
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
@@ -664,20 +639,21 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 
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

