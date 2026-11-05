Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916086;
	b=ujS4DcaG6DldgIxD6xcpwwL2w+YW9ug12F0JRQYrnawy2z45e02hUjJQz+lK9gxO12O5
	 sgR+qXiq5NF7Gy69luEEYVck/BqaqKVhWMJAbDjAOSbFssSnJU6aJtTIkj5z27wY5jcnx
	 7SqfKumK+WdwlxfnUUZlrIIWLbTrRPAmz8RuOAbRBaAxKE7C2HvxNwOIw+EqqTQRPXpAr
	 rzGNEOLn1uFnZ4U1ukt54/JxC+tBvrNSmKnOv6xnsRRJi8SuxqsRMc/Vj9bXaUzGJDk+j
	 KkGTcuEVltzi+wMAEexeMgpEyp6VMUgeaILvo/S8XUGzwGXY28TGo+d3vHolpdZZKQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=desrRdbrEuvuMPsaXsP5lb59aPa4lj2l+ZBPPXTms64=;
	b=L9AVkJAooifz+2YyninHG0k958Q34R9sDpTYT/fRmUs6Zed5nGIQ+zuMEs3uVAuT6AUW
	 x6pxdmLvazRNGJbbqgq8TTcGYKgnGUdNKkOQR3EsQTeOP2xBgOCzk9Nr7PU+Ix3tuI1en
	 zwNOB8SipE9fUWvqhRdTzRSQHGq57wElt/QmV5sLtYSPlSuEWcjOh+kC6xsebX2sN5gJT
	 jA+2yRBhJXB+Dh7/wxJhWxsKKPF/cPWxiFGfkCM+rKxoiqaNI2NybVz9U9sm2CumpX27a
	 EdH1b08Plb46Vj862R3hG+IizqqSrRH/1l+KZOQKu6msYr+ng1DZj2lluVP35gY1xXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9Oi0hFp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7306C606A326;
	Thu,  5 Nov 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9Oi0hFp
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 80DA31F008A3;
	Thu,  5 Nov 2026 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916086;
	bh=desrRdbrEuvuMPsaXsP5lb59aPa4lj2l+ZBPPXTms64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c9Oi0hFp9dhOsoeqmM1O0KhdWXGjSnMcBgGNjYegIyco3DVIiz/MIMgyKt8Gt334t
	 mULChLvxPNq9rqhj9bIDPMVQHA8kUfAzLK9BJOkLNpUXFjgBfzCrosv60DaZcvJ5ou
	 I5ueVyON/4UQXctgY+5L4e9rvwLvbZan2q/D/lEWickax0dmYewsxN+oHMLbBQvN84
	 ucKsqpOnARXuBMa5m/A2CQZrmNazaTzfuhsx0hJPOasfwfMBmxZAh3l9Z2eMx22oo/
	 qxozs1iUqLuMgR2+rseUpQT27B9K2VQJ4+xPwB0tk2Ks4ed15rAYcaPph12MlmmP8B
	 58Of10m3pK6rw==
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
Subject: [PATCH v3 2/2] KEYS: Reject keyring creation with overridden credentials
Date: Fri,  6 Nov 2026 00:00:50 +0200
Message-ID: <20261105220050.1421842-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105220050.1421842-1-jarkko@kernel.org>
References: <20261105220050.1421842-1-jarkko@kernel.org>
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

Cc: keyrings@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: stable@vger.kernel.org # v5.10+
Cc: stable@vger.kernel.org # v5.10+
Fixes: 3b11a1decef0 ("CRED: Differentiate objective and effective subjective credentials on a task")
Suggested-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
Collapse and open-code cred_overridden() to the entry point of lookup_user_key() (David).
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

