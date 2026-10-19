Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421801;
	b=eWDOPaFSibIhIbUS+4XAvE4ejWZKg8+wISdZTPkvBzp35ciE+re9tgr8v1KELa+HciGu
	 kKotuQ1eEQglczEscZIziBRNUTR4FfiZwWzcoaYkD0f8+PEgbJzYeHaaC882D2yJaIGgR
	 G7owIkNmNHB6oqcg3ymJj+XPVff/8nno07NtncuxPUVCEJ6xPtNSn8oiqtFDveKu0P30Y
	 dI/1s1+ILb+9RIYIsjdFlgkmsvGZqaV/eI7omc2tkx8YcbtNGkEnw71wDipQe9u7idiNx
	 /McJN/Wg1jDNbYhs/eHFzjM9AVu8vYgwnh/+FoRga5PBYE8bqey99/qH+IDxBU3OB6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421801;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nQaOzKUyFfhxCqzOjyjL/vuj9RfKeo4g0iZFPQ3y4Lw=;
	b=XnLdXHMe5u9392S4L5ii46TX4HGFeObxXHVz9M1S4xB2JevpITcFCq01tV3T4966dfgj
	 Mobgt8IPhgBVRAsiryEZopxS1BA7o35wCT7cd182yTV4s/GEg6sJDGkT3B5iIDd9rYlE/
	 qSnBUMypCgoXOq9jQgdbhtI/pwPCjtCna9oKnOI6n6WAOLJdW3ePGPSp83wDILhH5LxlK
	 TQrr7mZrFKDgDeyxY2ZVn6bFct7RaBFckjzy2jdZREEIHUd8hpeOlEmWG6FCEia3ou890
	 xBzMcvwAZWAGlj3P4QBo5BpgexeX9PrFX85qDxsyedz7bmqLRVKH6rIokywM7284HsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzF7A27z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1CC60724AC;
	Mon, 19 Oct 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzF7A27z
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02037234964;
	Mon, 19 Oct 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421801; cv=none; b=Qwx7o/rQd+Ti11kN7m6RYRPB8x5Wn5dNKbBqmhpLoXrqz1narLj1SMrRXVd4pygzUgj6RbsyN8BvSLLuVgztirjstARJ/x22RppX+kDzB56Un+xMzP+OIkFI+eictxmXiiVTkdo5tY5B0WqhuCA+fmK0N/hSGuGY2Z9JFg+7ALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421801; c=relaxed/simple;
	bh=Eqknhq3EWjyA4geTukVMuLqtmNXQLvHzoCXsl+BJ/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2OTCopCgKve0rcafdWGhz0BthSAXzFd/eDnCl8pYLL1fBzTnTAoukOZNX2nhPkqm9GictJaJfDBMe7s3sX4K6Wn6o0d+FR0vIecbMFXwI0V49TCE6pTNxj5EMIrK0xceQmAKRZPbkjxGaeyVR876CXuuE4dEQ+af2gYCl1uV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzF7A27z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 49C2F1F000C4;
	Mon, 19 Oct 2026 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421799;
	bh=nQaOzKUyFfhxCqzOjyjL/vuj9RfKeo4g0iZFPQ3y4Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzF7A27zvwvVA6XzUas5wRXkBGOKGUjq34sFWG7Gg1xMso0HCCI51PUMwo8nKiI0Q
	 3UPPnyLBgmcwn6SdXorvh+uojLwekgMCLnAZt39tdNHrkP9xjTMMBlZ2YeVwD5fQib
	 Crqpy0/qs35HMwKrIYB72+zJu1B6O/mE76R/JspPN1OeNXI5vQMA3yD8s111byQw9O
	 PEkY1x/Mim6c3TWuiVZFr4AWjDRqNml0JOd/1oE4R5AskqNhmyq9qWqbIASL15Gz1p
	 Pv6RENaFb1Yk0NVS2ZczxgaktqwnB4rRYriR1P20H49mddZAa8tQB6n/6ODZ9XtfzY
	 10Pk3v1xSQ/tg==
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
Subject: [PATCH v2 2/2] KEYS: Reject keyring creation with overridden credentials
Date: Mon, 19 Oct 2026 17:56:23 +0300
Message-ID: <20261019145624.309790-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019145624.309790-1-jarkko@kernel.org>
References: <20261019145624.309790-1-jarkko@kernel.org>
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

If the current task is running with overridden credentials calling
commit_creds() is forbidden and triggers a BUG_ON().

Reject keyring creation with -EPERM when credentials are overridden.

Cc: stable@vger.kernel.org # v5.10+
Suggested-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Added mandatory tags.
- No code changes.
---
 Documentation/security/keys/core.rst |  3 ++-
 security/keys/process_keys.c         | 31 +++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index c81a3a9fe236..9779ce71df47 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -168,7 +168,8 @@ The key service provides a number of features besides keys:
      If a process attempts to access its session keyring when it doesn't have
      one, the default user session keyring for its current UID is returned
      without being installed into its credentials.  If creation is requested,
-     an anonymous session keyring is installed.
+     an anonymous session keyring is installed, failing with -EPERM if
+     credentials are overridden.
 
   *  Each user has two quotas against which the keys they own are tracked. One
      limits the total number of keys and keyrings, the other limits the total
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 558ffe58b5d6..ab7f13ccebb1 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -346,6 +346,14 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 	return 0;
 }
 
+/*
+ * Determine whether the current task is running with overridden credentials.
+ */
+static bool cred_overridden(void)
+{
+	return current_cred() != current_real_cred();
+}
+
 /*
  * Handle the fsuid changing.
  */
@@ -577,7 +585,8 @@ bool lookup_user_key_possessed(const struct key *key,
  * to a key or the best found key was a negative key; -EKEYREVOKED or
  * -EKEYEXPIRED if the best found key was revoked or expired; -EACCES if the
  * found key doesn't grant the requested permit or the LSM denied access to it;
- * or -ENOMEM if a special keyring couldn't be created.
+ * -ENOMEM if a special keyring couldn't be created; or -EPERM if creating one
+ * while credentials are overridden.
  *
  * In the case of a successful return, the possession attribute is set on the
  * returned key reference.
@@ -606,6 +615,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 			if (!(lflags & KEY_LOOKUP_CREATE))
 				goto error;
 
+			if (cred_overridden()) {
+				key_ref = ERR_PTR(-EPERM);
+				goto error;
+			}
+
 			ret = install_thread_keyring();
 			if (ret < 0) {
 				key_ref = ERR_PTR(ret);
@@ -624,6 +638,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 			if (!(lflags & KEY_LOOKUP_CREATE))
 				goto error;
 
+			if (cred_overridden()) {
+				key_ref = ERR_PTR(-EPERM);
+				goto error;
+			}
+
 			ret = install_process_keyring();
 			if (ret < 0) {
 				key_ref = ERR_PTR(ret);
@@ -645,6 +664,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 
 			if (lflags & KEY_LOOKUP_CREATE) {
 				key_put(user_session);
+				if (cred_overridden()) {
+					key_ref = ERR_PTR(-EPERM);
+					goto error;
+				}
+
 				ret = join_session_keyring(NULL);
 				if (ret < 0)
 					goto error;
@@ -657,6 +681,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		} else if (test_bit(KEY_FLAG_UID_KEYRING,
 				    &ctx.cred->session_keyring->flags) &&
 			   lflags & KEY_LOOKUP_CREATE) {
+			if (cred_overridden()) {
+				key_ref = ERR_PTR(-EPERM);
+				goto error;
+			}
+
 			ret = join_session_keyring(NULL);
 			if (ret < 0)
 				goto error;
-- 
2.47.3

