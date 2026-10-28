Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207626;
	b=e8pKFkfB4LRSwo/qDWANfCRnA8Nygj6xpV9hlM9zcdJ5HHQSE+O0TRjR048uGBY8A+8e
	 0lMD5f4y4K3s0kcfLbqVSlB+28qYdujwCDaSItAYaYlDuvb02gWFy1CtZfSPICPwWD/6D
	 +aZ7OW+AAlrkPI9UII7pXlnGOh8C1067ZmueHc3kqnmz9shDJKY10DIhI2geoJBKr5mcR
	 wtzUWpQJcVQ07KHVpl3xWMD8FASkOJlU5eqhSXSb1F/sPitT66a7ocxBSu/CHvZHDrAtF
	 3bS9nWQvhmTrjjmqtlDlJyAmRDpmuifU//ek9cQMQr3A+/J3464yPn/JCBzcqLjsJbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lHE74WmuAc+bvvfMLcXvxqXUljTvFQl7OyL6yPddegA=;
	b=n9OcWnwVNrXKPVnunwEEHdn9QbcfcCMxizqwWUtr1GiKRurUfQUa6HvdoyaGb5H/nTXN
	 X2wkS82nTGGVzU/9zwr0fU45BaMCNPf/Dp93wW2pqBzMucmnfU/FC3Y4mYEXlUgaeTzbu
	 x581MwdCAE6ma1u2IWPHyDe3Kf+O16QZsk3sDWCITMjfstwK1AVFY11cGmiW5odx7XqeE
	 iURbzm0Lsm8HlgAgsAIzeMGFOjSRvVErAbkiid4Z+sOJPMCe/1cZXazSvSO7wfRKLThDx
	 rHMvK3CczbDTiNRNEhxZNSGKXWgYQtwwcIql8aIZjMPCOf2wyPdj7NaJy9+sKhdNdNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGIk8J1l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C1606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGIk8J1l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7283E1F01825;
	Wed, 28 Oct 2026 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207626;
	bh=lHE74WmuAc+bvvfMLcXvxqXUljTvFQl7OyL6yPddegA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gGIk8J1l1Ok8pIszN32qS/5Jt8v/cX3wquZ7qycuE3rDBhn/FnD8frfYEC9aRbWHr
	 bXDcr3S2Mcg19iiX6EdBS9IQJSjdwkim+wYoMc7HuNV85bOoaaQYtfWdwuNMUrzTOr
	 MpGbMBY+423BsU2Wygpsurpj7apfJqVRUnX+0oPDe2ns+FJte8JIYg1DJmJEfA83+I
	 G6UbAPCRRj8A3+fndT9j5Aphpsvw209u7EGRZJ4jT8WjOHhghw45RTDKf7c0hNsC79
	 I0wdla+wiWvxGha0h8LC1aJCHau5z+2QxN7ngINW5DsuVERWwvfA66yhrOHLprIh2O
	 iBvCoOfEXaA6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] asymmetric_keys: reject trust keys without IDs
Date: Wed, 28 Oct 2026 13:13:44 -0400
Message-ID: <20261028171309.1530696-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102818-nearness-dividing-d8eb@gregkh>
References: <2026102818-nearness-dividing-d8eb@gregkh>
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
[ sashal: Adapted the null check to the existing signer_ids structure pointer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/asymmetric_keys/restrict.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 77ebebada29c4..45b7fe05d84ef 100644
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

