Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433867;
	b=tbWCIM+ZOVGVgY58Oty8PbUQi/6OvBpHLMstf3X5Jcfw6Lb3rmKuDWJp22Iy7FWlUE/C
	 Ae/Xt2YZqC18/C2nctcNfzQS8gUUeaFcYM/U6xWax8RxbddTpO/Y2Vb7VwtL+5wspmIs9
	 VAWuelpCR/0Qty62c4B0lVt7Z6TnWj5AfWl2l2ZaVWzAKhIHW675iYbtvzzjd1gcq5Tnl
	 a92W6tk4wiwb9r6fNgFYo+THHCYDYnVF4rIuwWBqrpLca/Q4LNtyLvFpDPE4U4nc1zE7r
	 cdBgnf9Z7oY/XH7r0lic5PO9CxQkCZ2gTaQQOKxqNY1XoaaSLbmeyjxbosAUhV+qn1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433867;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AD/0QM1s+n0Y17r4G9exUXYhUePQjtJ8TIe1aOaIaN4=;
	b=sWVnE9n4QebeyUsJ/7uzuJYFfC51bOL6ahg+suJ2oS0y1vsjjrUj12ls7TqlDOPlj7ZX
	 hUHKJbqNcve6gYejY8JYxpEp0jQv1UJdxceE/I8vPpzNxs1osDFUnrVHoUie1dxgRC2w2
	 4EI9TMt4NoRzJCsmiEBMwI/lrB7RYLZWMqt6kPf1Gz34QU00TwkR21OiJ3hI06M6esRZv
	 2Hjby/O5TwPXXGJvskIc5Hc2r/pAL8lZQJeAr2jveDwliYaPCJUrhrm30k8AkZVD9ELfh
	 qgWkdXWZvRWm2gAdW2p5o6hD1ke6a/NiVlVoFCUsp+BsRmwUHIf5Ft84o9vF58oySog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbFcEHEU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 956FC606A31E;
	Mon, 19 Oct 2026 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbFcEHEU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DFE2E1F000C5;
	Mon, 19 Oct 2026 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433867;
	bh=AD/0QM1s+n0Y17r4G9exUXYhUePQjtJ8TIe1aOaIaN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbFcEHEUs2RnJXABasNox7iuwCeT4InuoWVQq8I7TXDqIRcCMCFKLJAAb9lK+XxFw
	 +hnP2jzvxvYWa+uHNx7wX6/DDADDUYzvOgvAm2ahL+jQIPo+wtJLrvTHtHzVZA3dIi
	 +e2k4d20SOsZYLv9iNQXnFYTcu6KGmDPYxKmIn793JWtXXKjLM2P/cxnNcMFHzeDF+
	 yaYPXQ6QXQvbKbdH0kEjOW/RV3P2UtY1NFUNUkixkQ0iWMzqQgoM3iOz3ceHoS97c/
	 6SCNaqO9HCV2RdrOZR4tZuVOcDcZ7AhpZ7Tvck5WXRivGNI1gt85cFrd1luWE6Bip9
	 5XXm+rR5p/HJg==
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
Subject: [PATCH v2 2/6] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE in key_alloc()
Date: Mon, 19 Oct 2026 21:17:22 +0300
Message-ID: <20261019181732.449591-3-jarkko@kernel.org>
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

@desclen in key_alloc() is saved to the 16-bit wide desc_len field in
struct keyring_index_key.

Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in
order to account for the NUL terminator and prevent integer overflow.

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

