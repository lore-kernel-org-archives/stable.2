Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433872;
	b=hXcQeua5xkots6kmLZFDiABWP1RsiSj352EJP8U3iP/WenB8NDpE28K27nMt3zECclzn
	 7yD63uEsbQIw9jSUJYIVdqQN689VyOpf30Cl9Q0XBKckpDfAGSU075PU8fYIPNu9dD3RZ
	 LMrGP3L3SpROMrTJjeKuGCjdw3fcVg634Aa9fSqxdfawI0A3DZSQ5bylYG7xIU4d2lAJD
	 OlJhcFEOzrDauF8o9/qTPGp1jxuDiAeo6d60B2i+gEzE+yqVgLcB7eX9Yq8+A5C73A8AK
	 cMeksKAtdRZ0a9M4BSOVBiUXh+6wNuG6lvRtQ3eyjwOFRS/EiH6OBbnAZW9OZiPQJtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433872;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O6BlK7nAOyjOdvv1tEHcpabbnIixg3KZPSOBE+pyPU0=;
	b=XDjwKFUomSOryfVOE8MkEmpIQ5tnXwTQkiutatOoahxhiyemhFFG0l9fqjZClvZf2v5v
	 /HByajoR4hhSvbOaRn3vb4yMjYWuhA0ftEi6sxdDOKEJpojLUMLI/YmRRZDdeIr9QURoM
	 YZnqiBQUxIanfhdkojyYiDqJXFUEmLMD1ymun6RqdzCHvitcHqsfOPj5OkZ6Ngk8uq8wJ
	 f36PXijPPfmz2RWnqA1tw40YbbIEjRPgl2FIyGghYD+a0+cRCC3TxAj3JMBImz1h5hc1Y
	 sl4D2cwfVMwVcIv+gWNPI9y6qvV9/6NvBIy6ujrxcH/7YfEGpDiuQtUW0VCcbEzUWjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSz2HAot;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 16745606A327;
	Mon, 19 Oct 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSz2HAot
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1FC7C1F000C7;
	Mon, 19 Oct 2026 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433871;
	bh=O6BlK7nAOyjOdvv1tEHcpabbnIixg3KZPSOBE+pyPU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mSz2HAotgYYMvYdLjD4OFCodwwvMAf3ovugzw8yEdFwKatO5Lt/DaRg095cCVjfBh
	 WLcNY8mh3uwsW1acDqOjJFvw5uN/hLxj9SJefzLqEUOcujVnXgKhC8QY/uM3w5fJdT
	 Pkob1lMaN5R40XFdkXD89bs+ewKrmuPdNKG5DC8GzVKZ8Nxaui53DOZq2+OKmWFC0K
	 5wwIW9Jrf1MiuR/lFXCS84RfS3GgudXPBaRpdsnbYp/lcc609wDXCc6GuirgWb6q0a
	 1I/LQfmTviVQuESHLb1Gp/AGWcxuQTbKBPqTLTKevnXs7pQykGJDaa+q01eegB1CuB
	 dfFocjsShBD+g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] KEYS: Prevent overflow of user->{qnkeys,qnbytes} in key_alloc()
Date: Mon, 19 Oct 2026 21:17:23 +0300
Message-ID: <20261019181732.449591-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019181732.449591-1-jarkko@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
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

Add the missing overflow checks for user->qnkeys and user->qnbytes
in order keep calculations within INT_MAX range, which is the
absolute maximum quota.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index e9f8cacf00c8..d4e4a2e89a20 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -263,6 +263,10 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 			key_quota_root_maxbytes : key_quota_maxbytes;
 
 		spin_lock_irqsave(&user->lock, irqflags);
+		if (user->qnkeys == INT_MAX ||
+		    quotalen > INT_MAX - user->qnbytes)
+			goto no_quota;
+
 		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
 			if (user->qnkeys + 1 > maxkeys ||
 			    user->qnbytes + quotalen > maxbytes ||
-- 
2.47.3

