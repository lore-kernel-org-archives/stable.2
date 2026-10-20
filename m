Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501236;
	b=ypwyDYRpcpxWL8qblWbhOQwhQeRmG82EealZ4JnEht9Ss+uXHA18UjvC98bYffQFGPUx
	 rpMtjoVmMNifcWPgu235e7nZJ3yj9J3S9msLHScf92+R2jp4iizQTBStDQZucLMVEV/Rv
	 4tuEq3KYZLcs7Wc/J5deAbomcwY6/mErC472DVHOKSTWdN2qFOY5a/HhWEb3h9xpoBuWA
	 wXREmDzy0rxb20Op/G1to/yOkUEErDyhnJI5JD5pH1qDyjJrWmOy2S9MHTfqu3axotW2c
	 /usHMpOcbBrNT04VqlSkDqnFqcVxkH/ibIcY/I76/3riLMNtwQ2qyM0DcXMWb9sW36w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mPjL4JH1CnVB6JWn6E4dZNxmDBtmsH8KM7v4zcnTmKc=;
	b=jDpM7zEcNWFePly1W9saSjjLDmtKwnStaBA/nofgNBVQ40hJLxMWuW6+yhWzxPMW89Oj
	 lXVcyWRPUPW5nt/AX712tkMNJy1tguWQXu3UK+18qtS33hcoIxACShVSde5TX0+oimaJS
	 snFz6TUao0CRCrVxU8OlKUQRrLQu1q/FILJkyS3RTE9tt/jXMiPjZzkyEm0KziD8RQ0yl
	 GsA7goslgJ2DgLaWlwvZSBcTGBtkorN/mg6FIXh5YQz013Uevv5bx6gB8HSumY+JSrBYP
	 oOaCVcRr59W7EB9lMemp9ssnbyKOI6Y+jqWt5sq9v8h4/1+5cxuQqATWO4Ln9EVL0Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/Q8mV6b";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C6CDC606A32D;
	Tue, 20 Oct 2026 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/Q8mV6b
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EC6861F000C4;
	Tue, 20 Oct 2026 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501235;
	bh=mPjL4JH1CnVB6JWn6E4dZNxmDBtmsH8KM7v4zcnTmKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L/Q8mV6b6SQwE9qDqIk9v3YIFQoNIzVsOxkV5jsOmNXtBkipGkTN7fgctd9fl18bv
	 1YGS48pE4UHUCa3lx3cI0A9sJtoBHy7mEG1BZY3A7WcxkaaaHFiILJcgaxdm747W2H
	 U+89ui2OZs/EAeSZUTgXw4AkTCn/51YXtORxFY8fvpojEpAOLmtdChHrLuz65nr5af
	 CrpNn7FkqRx2b18DH+uisiaeQaFNyzX6any9OPbiv+KLZbTF5vTkyiGmrEYSEiEDa2
	 f9CVxTg2KJ1sg21+mbHouct+k+eDkaA400cs7Mqc8rzBrvxRToSmRnl8S8w2DTF/Eq
	 smak2L43RY7sg==
Date: Tue, 20 Oct 2026 16:00:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE
 in key_alloc()
Message-ID: <atdl74PtEpLxVPdd@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-3-jarkko@kernel.org>
 <atbIP003h_YHofQb@kernel.org>
 <20261020022832.GA3727@sol>
 <atdJC3-PsaNh9PCA@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atdJC3-PsaNh9PCA@kernel.org>

On Tue, Oct 20, 2026 at 01:57:19PM +0300, Jarkko Sakkinen wrote:
> > Sure, this fix is still incomplete though, as I mentioned.
> > 
> > Turns out Sashiko found this too; see the comment on
> > https://sashiko.dev/#/patchset/20261020013903.1244157-1-jarkko%40kernel.org
> 
> I did not ignore what you said honestly but I overlooked generated
> descriptions.
> 
> By comparing your v2 response and Sashiko's response and going through the
> code this is the list that I have where similar check should be placed:
> 
> - key_alloc(): before quota calculation (in place)
> - __key_create_or_update():  before assigning index_key.desc_len
> - keyring_search(): before match_preparse
> - request_key_and_link(): before match_preparse 
> - request_key_rcu(): before check_cached_key()
> 
> Some sites might require some minor changes I just wrote the around the
> ballpark locations.
> 
> Did I miss any site that you are aware of?
> 
> Because there are so many, despite simple check I also wonder, should
> we have a macro for this check?

It's better that I show the diff I'm talking about. With the diff below
I try to address all the sites I mentioned.

Couple of open questions:

- Would it make sense to wrap strlen + check into key_is_valid_desc()?
- Would it make sense as a safe-guard to use strnlen(), which is capped
  to KEY_MAX_DESC_SIZE?

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

Br, Jarkko
