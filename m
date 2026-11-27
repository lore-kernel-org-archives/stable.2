Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781686;
	b=Xrm4HW5mJk6bGnELPLT/Jtuf1Ffg6CdA6sNNLueAEsFRXWnVdfJiJD8x3ip7E5HqkPAn
	 O0cF4yPNOonqQigpXYoU6lnvGF0PrJuCnfX4My2P4HF2seD9EGrq1ktCwYPZXfBtmocmG
	 BgpxJ/dtB2sWFq+H52xZSxRCQEFW8POEUFSiEIZVkP00k28YqwbwPpaZFLRcv0GJob7rz
	 IGKJeLR/29qBLlSz4YV5Y2B98cGOG6YEMITT/oryPRqQzohiFQWmXezneBvWsxobglIw6
	 DWx6efTTjZ2X0gWHrLR2/lNd88605HmxrIFmMGofk4NnP4fxwqxLz5+srVQMvpDHe0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781686;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VV+35C0MvsxTapmXmpaf8AhrJo2KO0fBkkJmq50cT5w=;
	b=z6F0PZKwytQB2/8OjeMv02EM6dMYqVBV1Z74WBJfwC5qAIxgrzUXS2Au0P2pmYr0SI7c
	 /VmZ3PDwJ+t2jv3LLw9M/TiV9NEX6UXvcyaXTCt9u8SlUpGpBN6A4wXyY6QA2tP+bMRwz
	 kEnVgheXtUZpXKn2W6pvD2q+cSWoSAOOM7v+kJWaVd/PU8LOzHyrT+XXKgUIzXwi+tDYh
	 L7ItxuWnvYNg5zstZgyzt6JdVG6zeJK2aUpwexR9puIy3Tem8Vz2sdZNsqO5o/pQh0FmR
	 HVbrHDjQ/n+115sBKaAgJcGCYHbqu/Ab+buY+WaNHE2EK9JP9prRuOdRdS21sH2TkWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWMc9vif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6F8CA606A324;
	Fri, 27 Nov 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWMc9vif
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7FB111F0092F;
	Fri, 27 Nov 2026 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781686;
	bh=VV+35C0MvsxTapmXmpaf8AhrJo2KO0fBkkJmq50cT5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWMc9vifFatAwSs+l2yKqgqXpFi498wBZ5KHRf9zZWpVwJDuxaiLB90kEaCqdxh6V
	 lJzdQLdUg7J2tYpfNiIM22/BOnvpNusZMicsFh6LqkMlAbEIIQBA1ji3JkgBVkaMoB
	 zn21RcN9r6H4t7lhz1+QrmUiAmDkqHYvh8MPEJ1u6lEFplL/8V68saGWrCXeL0Sr1s
	 AjAoEPykflvNqRcT6tmo5DOfLOHBs+X2uCgpdNirRg0MBR5lN5lFj6zlK2seX0lSIm
	 VQ1FDynJY/BWYnQruOhAB6qbmZddncAtiuj1Q1SjbUmBezpDSHhmyq/J7+oo1EGLFw
	 LbPpBz3ylFz4w==
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
Subject: [PATCH v4 2/2] KEYS: Reject keyring creation with overridden credentials
Date: Fri, 27 Nov 2026 14:14:32 +0200
Message-ID: <20261127121433.2400766-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127121433.2400766-1-jarkko@kernel.org>
References: <20261127121433.2400766-1-jarkko@kernel.org>
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
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Fixes: 3b11a1decef0 ("CRED: Differentiate objective and effective subjective credentials on a task")
Suggested-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
- No changes, resend.
v3:
- Collapse and open-code cred_overridden() to the entry point of
  lookup_user_key() (David).
v2:
- Added mandatory tags.
- No code changes.
- Link: https://lore.kernel.org/keyrings/20261019145624.309790-2-jarkko@kernel.org/
 Documentation/security/keys/core.rst | 3 ++-
 security/keys/process_keys.c         | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)
---
 Documentation/security/keys/core.rst | 3 ++-
 security/keys/process_keys.c         | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index e3a215e55f81..a60b2f725a0b 100644
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
index cdf03b8124d0..c878a5f8d47c 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -633,7 +633,8 @@ void key_register_fs_verity_keyring(struct key *keyring)
  * to a key or the best found key was a negative key; -EKEYREVOKED or
  * -EKEYEXPIRED if the best found key was revoked or expired; -EACCES if the
  * found key doesn't grant the requested permit or the LSM denied access to it;
- * or -ENOMEM if a special keyring couldn't be created.
+ * -ENOMEM if a special keyring couldn't be created; or -EPERM if KEY_LOOKUP_CREATE
+ * is requested while credentials are overridden.
  *
  * In the case of a successful return, the possession attribute is set on the
  * returned key reference.
@@ -652,6 +653,9 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 	key_ref_t key_ref, skey_ref;
 	int ret;
 
+	if ((lflags & KEY_LOOKUP_CREATE) && current_cred() != current_real_cred())
+		return ERR_PTR(-EPERM);
+
 try_again:
 	ctx.cred = get_current_cred();
 	key_ref = ERR_PTR(-ENOKEY);
-- 
2.47.3

