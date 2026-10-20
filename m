Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460361;
	b=0UWXM8A7sSDnn4YbPO4h5Hy0hflboDuk9PqrJMJyl4y2ITI4X4m4SzrHS3yI1Az81Ktu
	 YYzzDD0K9PowgqP8Ei3OSD5J9Qvo7DlBR23vqJ5jdcSWvevD7XitnJfDlVheo63J6ptD8
	 rrJyQe4WrRuEF7sxv+mR6OVJvM5QYDysQxLfmxO8r6WPwiclZSAhGJ3NyHi+b7QTJrEv8
	 +ERnA0dBktORCdaQGcuC+2H6ll583M9MkfAnktcwvlOCLnJin7xP7/09lVw+6S1GYqnuh
	 Uch+ZTUvH1YE9ZSKYpDahzhpgzmvPWhQYs+yHURrTb2/0WAiV9VPZrOxtSFx7pJb7Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460361;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=psGVTUYIsS0oYc2CZwBJkku7/c/lOtk1cT1WkJOmJmw=;
	b=O2PC0CaTzsq3Zh108ewehJqkya0V1vkYm2iKdZWxSs7h3d4DgBpxWfTJkGJRxaSpwYER
	 /aOJ+laQHk4a5C+bvqSTIo7BAchuFG1sFE64aOhey9UR6PLDYW0VPCjcFgroaq0mm3krg
	 xoPSNmwEq4dFmHtvG++rJJWYvF8rSMS9YrPG9yxSLczaRwfL3LsVJ9NmsQjsknkS3d4zN
	 tmOzEV7GZ1Ui1BZIse0Mh1/4fGSWZAWavebhvOHL44if3KY1mo0Rhe6I3HIYsGcW6+XeF
	 Nryad8McZGLtQ9wtHE0hLB/wHUJPNPz15x8BZ8lxdL3hpOlRMqteN90aIs1hVc7+qQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkNOFHFT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C0936606A32E;
	Tue, 20 Oct 2026 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkNOFHFT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D31221F000C4;
	Tue, 20 Oct 2026 01:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460360;
	bh=psGVTUYIsS0oYc2CZwBJkku7/c/lOtk1cT1WkJOmJmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hkNOFHFT18al5zoou4LGLid0BekDOeiv1v3RYldl/30eS9RZndt+f2jpzA+LIQ/NJ
	 T4m0MTT6DFHx/dFpUmPtQM/Y6u4JdOVPWL2e1HH56kvv+wvyZ5otSZbOu/JyWBdtxd
	 E40WOy8jqSVv1Na87eRRnU2uonjfCqY6jvLgKgNHxnZKhIJ1lxbNodoFazexdg4948
	 pr2W56tOG2WOdHfjlLteSKNEJhuO4y8ib9fnfDW6eXpVlxP72982UWvWJNLWC4rzbQ
	 FeD4rZIxG/WV23yhs4DWj7e9blj5omxhprdExMdVEX03Rc1qcbbqMa5ss80u4GeGIi
	 zRiRaNKn8xBMA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 2/3] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE in key_alloc()
Date: Tue, 20 Oct 2026 04:38:56 +0300
Message-ID: <20261020013903.1244157-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020013903.1244157-1-jarkko@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
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

@desclen in key_alloc() is saved to the 16-bit wide desc_len field in
struct keyring_index_key.

Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in order
to match the userspace limit. The constraints inherits from the one byte
required for the NULL character.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: f771fde82051 ("keys: Simplify key description management")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key.h    | 2 ++
 security/keys/key.c    | 2 ++
 security/keys/keyctl.c | 2 --
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 26139c3adf62..fa88de9b5a9b 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -37,6 +37,8 @@ struct net;
 
 #undef KEY_DEBUGGING
 
+#define KEY_MAX_DESC_SIZE 4096
+
 #define KEY_POS_VIEW	0x01000000	/* possessor can view a key's attributes */
 #define KEY_POS_READ	0x02000000	/* possessor can read key payload / view keyring */
 #define KEY_POS_WRITE	0x04000000	/* possessor can update key payload / add link to keyring */
diff --git a/security/keys/key.c b/security/keys/key.c
index 6ebb8691551f..e9f8cacf00c8 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -245,6 +245,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	}
 
 	desclen = strlen(desc);
+	if (desclen >= KEY_MAX_DESC_SIZE)
+		goto error;
 	quotalen = desclen + 1 + type->def_datalen;
 
 	/* get hold of the key tracking for this user */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 36ffba0ebba6..d6b10fd67627 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -24,8 +24,6 @@
 #include <keys/request_key_auth-type.h>
 #include "internal.h"
 
-#define KEY_MAX_DESC_SIZE 4096
-
 static const unsigned char keyrings_capabilities[2] = {
 	[0] = (KEYCTL_CAPS0_CAPABILITIES |
 	       (IS_ENABLED(CONFIG_PERSISTENT_KEYRINGS)	? KEYCTL_CAPS0_PERSISTENT_KEYRINGS : 0) |
-- 
2.47.3

