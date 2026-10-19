Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433886;
	b=VrXJa5ak9K6RAFZ2uC4/lNR0ABeFSWtxu4hT01V9lez+4qCWLTgCpIMymv/JiAtcvSRJ
	 Xzwf4VyjNpCkPEtb7drZxalmLwS3O8fGXPsNVwUkCxlTxN++3KWhzjDpZx1ahB+7nDO8I
	 Vror9hYpKzbfMl7Jqb0PXXIlf28qndYhXWdgZa4GLDX3TI8yg+wMBSZa1FObIZCpdIvFF
	 hJr1honMvJsZKcrS6goFD/KZk5/3Mq2G5CttQHzgg+XAeokm740G4QVedX+ss+Uf2rrtR
	 ztdxREl8D/7GHvWq+DMySI9/JAGdA3M7YwV0hekPG8KFB9hNtKG0vfByfIGSGj1oViQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433886;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GtBw/Wu0WnwjYL9xqON2SXYjgCC1DmhQpuIb3/Nqu5Y=;
	b=X0EJUUaYqZUDM39euIOdMyV0TawNm8bXXywZIukTWA4ZJYwbYWdeBFSEe0BkAv9NNcju
	 XnNIxvlHltxb6cR13oWEE8hbUpThDYgPMMY6bQmpzKXmXS8FM1Q89KNki/bMcRUNiBwcC
	 W7s/SX+wwA9LDDZM11iY5DCdkC+HrbtTQ+yAPWI+f7e6Op4PRPkM9x70OA9hcEbLBfG+Z
	 +5COh5qfxhwdLxuKZDGrts7k6Gfn3ugjpI5A/rMoTtSQBvfdJydo8QAWjDyxa0UpXO/p5
	 TMtdpBuyFLd5Mjz6oJYYrP0BQl3ewIFL9HxKoq1Pnh1Orace0OC41R+qy2riciSoP5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIw2YP+T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E901D606A320;
	Mon, 19 Oct 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIw2YP+T
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 040E21F000C4;
	Mon, 19 Oct 2026 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433885;
	bh=GtBw/Wu0WnwjYL9xqON2SXYjgCC1DmhQpuIb3/Nqu5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DIw2YP+T5Vlm+B1GP02dUbDQdFUjxfrL7V2usrFpBJmbaRybtcaVCPdt80fZfCKEp
	 uAE1A7l/CVD5ILHUOvTjnI0nuUENjrIrCaCE2F2fO12HlEauZVzrV3Y0Ddp80KyqGX
	 egH2UfixPMkmhyVP5KePT1EMZt6lU3KpbRZN6MBvehWm8hDrod+WWoXfIRkl4+71va
	 Dpk9eA9T52WAX3j2luQ8YDFUxOqTwyQv/mzN+1bC117tPkKDpgTj9zXrkSNmp8DmmX
	 vGEDHVdMqTZR7JF7UGIgEH2uY7/Z5S6bzWZadC06iE4sVvTdyfDyq3S+E6XTDbM4ff
	 msl+cgI4C/txw==
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
Subject: [PATCH v2 6/6] KEYS: Verify the key identity in __keyctl_unlink
Date: Mon, 19 Oct 2026 21:17:26 +0300
Message-ID: <20261019181732.449591-7-jarkko@kernel.org>
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

Assisted-by: LLM
Cc: stable@vger.kernel.org
Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Reviewed-by: David Howells <dhowells@redhat.com>
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

