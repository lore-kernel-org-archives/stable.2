Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758507;
	b=y91lgm1jq+PknaFvFhEJIgWTJu9V9IUh09gz8t8uLDSSwOzrPc9JOrs7xCYmytu6vDZc
	 4dYrElSedkn3qxBu5uotDfwK3TmMiFsvpKriGXcplP4HZMFWwwsVMBAtIVihkI9TqeNxL
	 rEIe/lpFnm5kMLXTA2B+so7osM6uZBznfMfXispsVPWThy/yj514S+jcUvYJnts+MUGHh
	 KK1LW369En8Rh+smLMepVLxCDf3B2QdWiCKt3Z654+kRPWqjtALdsTLV30wledS/HC+D9
	 WUEu1J0BGFkZTg/on/+8z3ZoqMLlHJze/N0KMlmxqZdnt0XguF1pB98vacUQ5hFi6bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758507;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h2yv/hj0WDpKJ/je5WQKd3uGQZ0jMDC+SeY0v8CSH6c=;
	b=kESiUx/8UGsYIKA7g0ig3e7TbB8NncQErNYtHimN1LL8JE54fYN46s6fVefbLSBwJORn
	 3Rrj8Qv7K02phfmiKpMEgquxf7fPa3cR617n9RVKluYzZ0/V0emEtxGz8cr3bP9RGLhLr
	 Pp95CxphahEu4Lt2AnhaxsBZS06/BV7nl2J75kORC6wvPlxcIG1daEA128sQS4EbDjxtH
	 GF+WWbCVeG2e/6n8fID8vt0p4hVywOaIXV5dAkuUZW3zMmdUPrPkT8AQEhBTHwGv3VUkq
	 Spu5Iy7EbbgsN34Ky+E0g9zcCYDwyezSbW0PH5C7Ceb9hW/U8EJSs5WbTlV+z/3j+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkCzCd41;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 416A1606A31E;
	Fri, 23 Oct 2026 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkCzCd41
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8DD331F031E2;
	Fri, 23 Oct 2026 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792758507;
	bh=h2yv/hj0WDpKJ/je5WQKd3uGQZ0jMDC+SeY0v8CSH6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fkCzCd41+NGM9bGhG6CQyssly6RFqC5ddd3raqOhrhFEt7UWDNEgeDa0BW+KpHy0M
	 r5VeZTgsH1vAKUboNFggZ2fEQg3JM2epe7CDSdZDkE50MnA7lWB0QuvlBwjqz89d4H
	 mdqM4sg8nsk8DxUusmcgvk+0anuHtgxGbFxJlV5ZYWzfqQIxs1sOxhvy1nAp69dgR3
	 fldC+tXLgG3yIjnsNn43pYIbFeMYm1C6CgiYoq//Hb22LrFLOb38Jtf56KhlvkxEHI
	 lK5vQa70mmcA13RAYKIrzkmWvFYC72nmhARBYbx1bpx8JQ12Wn99ivwEqiYTXRWVFI
	 HIB+683XbAhgA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 3/6] KEYS: Verify the key identity in __key_unlink_begin
Date: Fri, 23 Oct 2026 15:09:23 +0300
Message-ID: <20261023120953.1206778-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023120953.1206778-1-jarkko@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
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

When two keys have identical type and description, linking the second key
replaces the first in a keyring. However, attempting to unlink the first
key (no longer in the keyring) unlinks the second key.

This happens because __key_unlink_begin() calls assoc_array_delete() with
&key->index_key, matching only on type and description rather than the
key's identity.

Example:

  keyctl new_session >/dev/null
  keyctl newring ring_a @s
  keyctl newring ring_b @s
  A=$(keyctl add user A ss %:ring_a)
  B=$(keyctl add user A qq %:ring_b)
  keyctl newring R @s
  keyctl link $A %:R
  keyctl link $B %:R
  keyctl unlink $A %:R
  keyctl show

Verify the key identity before unlinking, and return -ENOENT on mismatch,
instead of unlinking the key with the wrong identity.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/r/20261020174325.2229448-4-jarkko@kernel.org
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/keyring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 2c54f7f84c55..5281da9d5bf7 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1506,9 +1506,15 @@ static int __key_unlink_begin(struct key *keyring, struct key *key,
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

