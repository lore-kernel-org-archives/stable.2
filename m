Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460364;
	b=cEQgPJfFTGU8hECfIWTVY+/ZQpb0eUGnGLnX0xejhacmsvpPqup3zKqKdNGYGgwcLBAY
	 AS7INcJvBRRIR2D91o4z85L3ENEXlCFGYskIBvEE/f4DIsed0e+BPFfAR8lNss2gvHJLd
	 pQIEatlztkxHka3wbo7Avc/V+QDyBLrOGUMGY6zk3UMM1JducCL0E9Y5+1a1aEEX3PHzC
	 XWJVqIq9TeET/n/OIG+Ollss2opqXNp+yar+Z7W8laKzVVvI2MJimjA1IoR5fQC5sxrCR
	 rKOU3VHkqlb+F3/yKJJRNnTlGatWwAFNMOaOb3NNVMw1uaR0MjTmfXukLjV3VTjqprw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460364;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c8HLZiQwinILcb8NHotneX73qYTCfJXD1L2tSseW6Ug=;
	b=NCmCuNbtruOKHn76bQJhIHCI/dDJCZUwy0di1Mo3Aw5NL06n1odaAikArA6j39TCN69Q
	 NhY/HwjBvV9ZR0kwtAM/dSpM3QapIcliB0N7PfWF5Vlqmz8Wj44l0p9wk4rZBTbVmprMC
	 t18vH0GZ+ek88BEVFzxm50/Alnc/ZPe+NxhaokSqH7DnbLdWM1CtOLyYbmUWQ9+2BDM3H
	 1CJMZWTFmGt6lNY/MchMCtKom/MY/5MZWiTJSd+oFTm/Qk4xCVFj40DMRLyMU3+8X/R+P
	 KcololfU6dLmQyVg6AF8E0fmsIxA4phVowZ+bHaWU4sF15e2YGl+63VRCiYgxZrXvCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWxlEMXw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9E1DC606A33D;
	Tue, 20 Oct 2026 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWxlEMXw
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EFAFA1F000CB;
	Tue, 20 Oct 2026 01:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460364;
	bh=c8HLZiQwinILcb8NHotneX73qYTCfJXD1L2tSseW6Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QWxlEMXwNH8raa3urVkoyKULJtf9a615bycG98eky7T7XHpylDFueKgPeXYgB7Hoh
	 whbeUP2TAUJKXxu8FBU689UkSalPDO8uoCrvLZFstTELeOXZP7juif7OXlmDrmbvWS
	 tIr2oeCNGFuQ5xCKBx+nXafoFHkMiLTluILWHvYLKuGtdDPVgRtvohhYxPuqSh57lj
	 SrDLEcUH6b1UHtnkorNk2Xdv3mqNKAyYzkIAXph3JaP3Wz1qM43TjKlM/cOMAG9v+T
	 n+ILlXcq8AtIOeCIh+FA+WMmt1GVeEsbw0RMJ0q27ESOWNNZgYJefO9QwUtzD3/F/Q
	 d/G0l0kk1w3FQ==
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
Subject: [PATCH v3 3/3] KEYS: Verify the key identity in __key_unlink_begin
Date: Tue, 20 Oct 2026 04:38:57 +0300
Message-ID: <20261020013903.1244157-4-jarkko@kernel.org>
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

