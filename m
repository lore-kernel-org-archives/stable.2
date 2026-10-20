Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518242;
	b=BY2Oi+yijEvwwRiLh/EvS+wiAY98bu5WJu6E4rAO6vYOTuvEWS2pDlHa4t2C14Tp1tSf
	 gL7LyUUQxZdvxtswfxLYsgWQVArDMb3ucV8WPSOL7sPmvv3cSDPJn8HSa2PxZWXV4rkN7
	 nEEgd0IJVwM/j7bUhWqmM/k8WLph2596ENI+M+ajORWCLEF/NPLLAU6Um+vuovS0fJhDf
	 yiKMQrsjHzPBRu8gNH31jsg1b/gQzJ5AZSjtOhUDma0kSgPRZrHv2Fy8un1dR0cFMoDL/
	 gJXga049JXEdTokjveQ78bqCR8wTU6YWRnVNKrWtbFO/DJIAvo1wpfAqhI6TIXZ4D4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518242;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=J13Gii564LW2bB1NzdfkwHO2ZrxJK69Wn5jRIjqhhls=;
	b=lH3duVT+Qv1E4qQE+dy/Wd3t86aNgMZRutWV7Ofl/U10vB55hNTEqm+4mQjjztZLsLpj
	 y9GpsYH14UvjSm0u2fFo4UrpzFVzVD++ccfTHOLhZGqQBdvok0iLRlaOZsFjG9P67k+FR
	 dCsZGqLhx1jjlX7qTWmTzr87ZEJsIgDtuuhMcg9QrtzSd6+hwR0kJpGPJc4Q/Dshx1gHk
	 SQkodOFn0A11mlSBiDtsRaeTi8NnQ7r9rKF3ewsepWQBhdweQCeHkMhbQKqbBTFHu/BPm
	 Ct7nd7Rru9SJ/c0QitpRtuLgUmGwswPhDcgnvz33QFKhJxEYEJHwt5N4xKa3YKbF8Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7A949606A326;
	Tue, 20 Oct 2026 17:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9B9E91F000CA;
	Tue, 20 Oct 2026 17:44:01 +0000 (UTC)
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
Subject: [PATCH v4 2/3] KEYS: Reject descriptions larger than KEY_MAX_DESC_SIZE
Date: Tue, 20 Oct 2026 20:43:20 +0300
Message-ID: <20261020174325.2229448-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020174325.2229448-1-jarkko@kernel.org>
References: <20261020174325.2229448-1-jarkko@kernel.org>
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

KEY_MAX_DESC_SIZE includes the trailing NULL character. Descriptions
generated from payloads and in-kernel paths bypass the userspace limit.

Reject descriptions at or above KEY_MAX_DESC_SIZE with -EINVAL at the
following sites:

- key_alloc(): before quota calculation
- __key_create_or_update(): before key_set_index_key()
- keyring_search(): before match_preparse
- request_key_and_link(): before match_preparse
- request_key_rcu(): before check_cached_key()

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: f771fde82051 ("keys: Simplify key description management")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key.h         |  3 +++
 security/keys/key.c         | 10 +++++++++-
 security/keys/keyctl.c      |  2 --
 security/keys/keyring.c     |  7 ++++++-
 security/keys/request_key.c | 14 ++++++++++++--
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 26139c3adf62..3b8af14fb323 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -37,6 +37,9 @@ struct net;
 
 #undef KEY_DEBUGGING
 
+/* Maximum length of a key description, including the trailing NUL */
+#define KEY_MAX_DESC_SIZE 4096
+
 #define KEY_POS_VIEW	0x01000000	/* possessor can view a key's attributes */
 #define KEY_POS_READ	0x02000000	/* possessor can read key payload / view keyring */
 #define KEY_POS_WRITE	0x04000000	/* possessor can update key payload / add link to keyring */
diff --git a/security/keys/key.c b/security/keys/key.c
index 6ebb8691551f..e88548f1a704 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -245,6 +245,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	}
 
 	desclen = strlen(desc);
+	if (desclen >= KEY_MAX_DESC_SIZE)
+		goto error;
 	quotalen = desclen + 1 + type->def_datalen;
 
 	/* get hold of the key tracking for this user */
@@ -829,6 +831,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 	key_ref_t key_ref;
 	int ret;
 	struct key_restriction *restrict_link = NULL;
+	size_t desclen;
 
 	/* look up the key type to see if it's one of the registered kernel
 	 * types */
@@ -869,7 +872,12 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		if (!index_key.description)
 			goto error_free_prep;
 	}
-	index_key.desc_len = strlen(index_key.description);
+	desclen = strlen(index_key.description);
+	if (desclen >= KEY_MAX_DESC_SIZE) {
+		key_ref = ERR_PTR(-EINVAL);
+		goto error_free_prep;
+	}
+	index_key.desc_len = desclen;
 	key_set_index_key(&index_key);
 
 	ret = __key_link_lock(keyring, &index_key);
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
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7143f3079d20..2c54f7f84c55 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -957,7 +957,6 @@ key_ref_t keyring_search(key_ref_t keyring,
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
-		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
@@ -965,8 +964,14 @@ key_ref_t keyring_search(key_ref_t keyring,
 		.flags			= KEYRING_SEARCH_DO_STATE_CHECK,
 	};
 	key_ref_t key;
+	size_t desclen;
 	int ret;
 
+	desclen = strlen(description);
+	if (desclen >= KEY_MAX_DESC_SIZE)
+		return ERR_PTR(-EINVAL);
+	ctx.index_key.desc_len = desclen;
+
 	if (recurse)
 		ctx.flags |= KEYRING_SEARCH_RECURSE;
 	if (type->match_preparse) {
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index fa2bb9f2f538..ef00c2b08fe0 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -584,7 +584,6 @@ struct key *request_key_and_link(struct key_type *type,
 		.index_key.type		= type,
 		.index_key.domain_tag	= domain_tag,
 		.index_key.description	= description,
-		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
@@ -595,8 +594,14 @@ struct key *request_key_and_link(struct key_type *type,
 	};
 	struct key *key;
 	key_ref_t key_ref;
+	size_t desclen;
 	int ret;
 
+	desclen = strlen(description);
+	if (desclen >= KEY_MAX_DESC_SIZE)
+		return ERR_PTR(-EINVAL);
+	ctx.index_key.desc_len = desclen;
+
 	kenter("%s,%s,%p,%zu,%p,%p,%lx",
 	       ctx.index_key.type->name, ctx.index_key.description,
 	       callout_info, callout_len, aux, dest_keyring, flags);
@@ -787,7 +792,6 @@ struct key *request_key_rcu(struct key_type *type,
 		.index_key.type		= type,
 		.index_key.domain_tag	= domain_tag,
 		.index_key.description	= description,
-		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match_data.cmp		= key_default_cmp,
 		.match_data.raw_data	= description,
@@ -797,6 +801,12 @@ struct key *request_key_rcu(struct key_type *type,
 	};
 	struct key *key;
 	key_ref_t key_ref;
+	size_t desclen;
+
+	desclen = strlen(description);
+	if (desclen >= KEY_MAX_DESC_SIZE)
+		return ERR_PTR(-EINVAL);
+	ctx.index_key.desc_len = desclen;
 
 	kenter("%s,%s", type->name, description);
 
-- 
2.47.3

