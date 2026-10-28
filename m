Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204207;
	b=h9t13tg7etZzfIRpJOvei9svMh/XAdqBCsHVLx8kPj4COcF9finQqJORbt3bRXahGP2T
	 8SjHD6W4lhVEauQdjZcwDHyp5niV4VqtTK+MJYUaTL65m/I0ZgjD4Qq6ZmWjNRaxEP/Jp
	 EFPDLGwNl5K0EnoKrjJIju6cKLALu7UVl4Dy6cFxQ2zuIb7AtszxcXArv1Qz+GWa+3KUj
	 6LWBwIbjVVvOTI3cPDNUpBH9GLHqtjhVVnKoPnzSoxC5WnLpwvG+8uFfiMrkZE17kZAGQ
	 zRUtUgwHps6+EZcHnbp8DraY5po+QSmrKCaiq9E8cgMOIjvQogqE3N6Y89Sfdqh8c9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204207;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kKLLlX8oLQEGdJFeoVEjt38VZPFlRJO3E5XzPYqYqW8=;
	b=CQvUNPnRnJ3ophZAbjSyTpVxZAo/vw0PbI5FBTpx9OAS5FCdMeG66t+TVvnUJdSndZBu
	 zPMa87p7higTx/h85zfOVzp4SXpE9Q23as3W9cqmBO3GmQeixzXUYt7k0jGVxyD/7m3NP
	 NpNdSb/zzJ6f4XdlXFAXoAwnc8ECeUSOkVMxSv0rHfoZ7cx+Ixjp1gaE7XX0bjkRc8Cwq
	 3binigVajsPdZ9yBTOBFbrhxz6j2Ri35MvNLEahlFi6MKYLvZNdnN7Yt1N83BfOcFfLQO
	 YLOw6NaTXsAd0HV+cL3QGDOx4rnJTyUJx2iHVd5NeI8SOG8Ll1/x0RPrDJ4flKNQKPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MO0TU1RQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02D606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MO0TU1RQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7341F01825;
	Wed, 28 Oct 2026 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204207;
	bh=kKLLlX8oLQEGdJFeoVEjt38VZPFlRJO3E5XzPYqYqW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MO0TU1RQqoyBIIEBdOe+fyxaIaOTkrUxkf9COgpAEDwirDiiRTwrrQ/hAX9VHntgE
	 4/FuInTEdcZzgo9mjPXVaG7VGu49Ffn2vKOMoadKidDAFxPpbjKBpK3oBUHaM/3E1r
	 Z5f15A1HDHw0iYnl/j9DrD/thtJummAyRpZx984KzsshLO6QSR6PQzsrjDERWvKqD5
	 GJKoOqx1pIIa1k8caGiJhd3L6kncXevsBT11UoA182HpqG09SqaQbmBoMtcCMou9ow
	 N47bJGmGdtmYs2UNFRvtFQcLSON85JPn9VYk5w7pQB36KUCx+7RqXuYRR9tTVDUQfp
	 gZ/nwOUUa8KeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] asymmetric_keys: reject trust keys without IDs
Date: Wed, 28 Oct 2026 12:16:45 -0400
Message-ID: <20261028161610.943036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102817-causation-protozoan-b0fc@gregkh>
References: <2026102817-causation-protozoan-b0fc@gregkh>
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

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit 9695df3b1db4ac4534274d38ee16e3b9b0bf910e ]

The PKCS#8 parser deliberately leaves the asym_key_ids payload slot
empty. key_or_keyring_common() unconditionally dereferences that slot
when a PKCS#8 key is supplied to a key_or_keyring restriction. Both the
plain and :chain forms reach this branch, allowing an unprivileged caller
to trigger a NULL pointer dereference through KEYCTL_RESTRICT_KEYRING
followed by add_key().

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000
 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:key_or_keyring_common (crypto/asymmetric_keys/restrict.c:205 crypto/asymmetric_keys/restrict.c:279)
 Call Trace:
  <TASK>
  __key_create_or_update (security/keys/key.c:884)
  key_create_or_update (security/keys/key.c:1021)
  __do_sys_add_key (security/keys/keyctl.c:134)
  do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>
 Kernel panic - not syncing: Fatal exception

Reject an asymmetric restriction key without key IDs. A PKCS#8 private
key cannot identify the signer of a candidate certificate and is not a
valid trust anchor.

Fixes: 3c58b2362ba8 ("KEYS: Implement PKCS#8 RSA Private Key parser [ver #2]")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/r/20260429181629.110802-2-bestswngs@gmail.com
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ sashal: Reused the existing signer_ids structure pointer for the NULL check instead of introducing a separate kids variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/asymmetric_keys/restrict.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 84cefe3b35856..d95002812bb84 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -154,6 +154,8 @@ static int key_or_keyring_common(struct key *dest_keyring,
 			const struct asymmetric_key_ids *signer_ids;
 
 			signer_ids = asymmetric_key_ids(trusted);
+			if (!signer_ids)
+				return -ENOKEY;
 
 			/*
 			 * The auth_ids come from the candidate key (the
-- 
2.53.0

