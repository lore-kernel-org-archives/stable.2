Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518249;
	b=WUsk0v/ekhliNSE+XkPed7VT7OtLo+QrblIyPU/gacWtUIDzqjUKL0oJ3TXLGi2Vs960
	 4/OX29yBInMkzFWJgGhoBRqvEIh4Kemn0saSXrJnOEIhks+1OtVEIm+sOihzf04KQj+5q
	 8MIFceGBbo6p4eNyiANVZHpL7GRLOTgehiM+wNcbLLqKOnvtmDzDDw9SRmzY+v7pOHkFZ
	 hZsz7v+mVYP2KPdJEUR7z8xC8+XX3FGdseq8dmj1hFsdCbCUIUvW1qNHp002jOoDxlMy7
	 P470Fq+Khnq9BIaARwDIhilVXgihtFCqjwtu1IhMngiopLmh4AI5kKFj9H6s1dtOtNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518249;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5dAqZyIdnLqZkDPsYtrDxXC8F11XV4d+UfmkgL0qrH0=;
	b=SQ6yXjf/HXomYfzCS+zSCgUcIUC9XrgS11Pq8/4fagdvCLjEXPrq5vDbD/NBBeSGvP8a
	 sb1wnPLHnBVsDQDnkdFg0mzZnsJO8II0uA55fqDhqy0PLeRI0LCxLVARg37IX2rfF7qUe
	 +MAJBBj9hg2Tmk05vBKqcrUdfgZ8DFsEidWZoyaYgp3sBJJCoCOH8ToHYrZmw6SqUMXDk
	 cp3ugHxIXaS/QyXcPgWaREqFaGGxWmo8fHOHTuuJ2ysxEPBDOXuKEd7fhDjI02O/PB1Oy
	 HtGhtisn3ZdAk5XcZWqjNSOnLL7H2XtgayebT84JgyZrt7CfmW4gJyw0ZYoTUmEL1uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3ox2Okf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 935FC606A32D;
	Tue, 20 Oct 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3ox2Okf
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A321F1F000C9;
	Tue, 20 Oct 2026 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792518249;
	bh=5dAqZyIdnLqZkDPsYtrDxXC8F11XV4d+UfmkgL0qrH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3ox2OkfS/0A8Wu+iLxT5Hloq26brloB7KfmJ2124DkToVAurh2mPE2mUmlOsnbBj
	 JhciHIYKcZOplUmzJrz1AJkzd+pxmpcEfqkd0g3M82soVL/OrC3A1gpKdsDVwJhNXY
	 BwFmh0m9hBMQiPWTiTGI3ZwXgEpk4cJYms2lTh1ygjy7v7JgFINwdlLiksp51pYJHY
	 BeCPeoUaLany4ZZa9g57z6zAuG0IuAbqjeomyjv3Rl7/kw1L8XKiQ5vu2mToagMq9v
	 XD3e/p3nIOLxF/D3Ff6vORdue0pSrj6sjOR5zvRrBUwe5y1T2RHSkNlq+fCic59o1c
	 aPyfN1k1PIa1w==
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
Subject: [PATCH v4 3/3] KEYS: Verify the key identity in __key_unlink_begin
Date: Tue, 20 Oct 2026 20:43:21 +0300
Message-ID: <20261020174325.2229448-4-jarkko@kernel.org>
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

