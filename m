Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4156DCDD;
	Mon, 19 Oct 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419967; cv=none; b=lrgUPDAOZv4FW3XOx+IghBwZJC5O/her8HmuV4oQdmIRVn4zx9YJUgIUtWZPuCmG8zHND5Xp49ZzqwEpu+zN00torOfwfZ4UKB0gFbHor0zqX5FEfXaWAwDf6qArFCEj24ZKXQ9kkAVp8k/1Wt8pkwsJB4luRGZCQ/UBp0VlsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419967; c=relaxed/simple;
	bh=koZeMyxGNBlOTT1LjPvu2Qikkq5hyG+Vr4MPSrsGO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Viksvd/GjdMTP6hscZqBjAdaH4FeVcIT2glt64M1a7w2eSwMkDK1Z9vP1qR7q09G5B9Hqik1iWcuUdjA4Gsv3JYLj5PJ1FlX6+4Eut5BbWBRbuP8xodxtXsb65LEsHFPEDqQdlBP83g4goLVOryoC+eWBwZTJ/EtNLE5wZ9ETs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUP8N/rJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUP8N/rJ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1B8571F000C7;
	Mon, 19 Oct 2026 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419965;
	bh=skxcJp9zwrJVgDVjVljLICivl5v/0jQaIPiugtaJATk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JUP8N/rJY/CDiTnI6wWIvQ4LpUoUCpPNElaVf/Ldbctyu74lex5U+6KF798a3STML
	 l8TU0YWVCtKTQc7vFl+rWjS0UDldLXQxXYyEzJr85DAA+k5JvdGP5AQucU3LfQpeFn
	 18QdC5OQx0Xr42dnIMSABFRF/an9bTgMCPVRvh46cegPbZPSVCPBUbZumg96MVB4Jg
	 N9sycEk1GIfP3zc+fr3l+nhTHHp9Xf/FMm73XglSY8PrJvCvlAnQCJyKoidKqaSLSf
	 I3vt6Pr5OU4GRb+tID7ibo097AJOLfKQ9iE9E1QZ0TeonPyo87SDjGcMdP+4Yfnsts
	 HbVGFyWCa5I8w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 8/8] KEYS: Verify the key identity in __keyctl_unlink
Date: Mon, 19 Oct 2026 17:25:08 +0300
Message-ID: <20261019142516.300040-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019142516.300040-1-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's define the following preconditions:

- Two keys: A and B.
- R is a keyring.
- Both have the same type/description/domain.

Then:

1. KEYCTL_LINK(A, R) => {A}
1. KEYCTL_LINK(B, R) => {B}
2. KEYCTL_UNLINK(A, R) => {}

Instead, verify key tidentity before unlinking, and return -ENOENT on
mismatch.

Cc: stable@vger.kernel.org
Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Assisted-by: LLM
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/keyring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7143f3079d20..b025331488c5 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1501,9 +1501,15 @@ static int __key_unlink_begin(struct key *keyring, struct key *key,
 			      struct assoc_array_edit **_edit)
 {
 	struct assoc_array_edit *edit;
+	const void *object;
 
 	BUG_ON(*_edit != NULL);
 
+	object = assoc_array_find(&keyring->keys, &keyring_assoc_array_ops,
+				  &key->index_key);
+	if (!object || keyring_ptr_to_key(object) != key)
+		return -ENOENT;
+
 	edit = assoc_array_delete(&keyring->keys, &keyring_assoc_array_ops,
 				  &key->index_key);
 	if (IS_ERR(edit))
-- 
2.47.3

