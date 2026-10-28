Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197220;
	b=w62yrWRUL677oo8XPoIO6yTpUe4G2u9tZg/rllRe0PWvS2p+koGU46Prwk0apgT2QxPw
	 /JHDsFqVVlicUJeT2bna5e1NfiTbN+Je+Lcrh2BBkygbdB2QCg8wurSTihFddamfE48Re
	 lZ+MXdZkfYSFSuhLFfL7MiGBieJB4SIGJ3nVwtdqPjmkvaRaBKO2OYFoLnllG6hcJh6O/
	 8nIBhSj9zL4vkK+sHWWjWHDB/vYrxUhmS3qvwArDMCPvUEw8G6j90BSFTyXXEUIh4nkFL
	 MnYG8a4A8EUvOyoAv42BupxrPm/zW7O5qoIJc4+Aw75DCtPm3t+7Ygg71wOyq0T7d4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197220;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ce8TPHkzKngXpCFl+JcqvTqr+Qs5ohmAx01iYwxX5ys=;
	b=ZoW3urZwJXX0lv0IUDjNOss0eIYSF1Gj537hJbSNFMu2xkgRmvz6ZMx8uKJ7TFyzEM+E
	 Dk52iVSREbAV3OOp+Uzz5dW6nJobVpYyCaviI09dToGSu+X9ompujsfNTChgDb3uQtyEP
	 TGrrXQ6dr1v85Cw5JqzA1vetq/4ucnIbO8GdQySoWpFfiZBEF2Kp0JwK9iPCyNHi3JWY1
	 7AlZtwsCuaUWnl4+up7aHEj4UcbptB8qQua5NrEf0ct0jZVN1tRXPg6N/R8SkrCIv+6Dl
	 YlQrmUQ8bjqWOEnKTb0hhBcHAgVHk0Q1+f0vbyfQA1xT5Til3fuprWSxG3z2cH35/AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zP93CnwP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BF606A330
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zP93CnwP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FA11F01825;
	Wed, 28 Oct 2026 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793197219;
	bh=ce8TPHkzKngXpCFl+JcqvTqr+Qs5ohmAx01iYwxX5ys=;
	h=Subject:To:Cc:From:Date;
	b=zP93CnwPUNF4UBSwkIZcZOTOW8/pvw9GnNigDtoE2b9e4/ktgKxv8Fw8Qijr9M0au
	 /1u0v8eia/g/sAg2RYJyhXyyYs+lfM6cLgQ6VGQHnLX9N4S4gyc9y0ta/QAnlP2qVS
	 dvD3n8GPO7Z9aF4+3HQ3oDoSYuxANxvkHfTJ2sPM=
Subject: FAILED: patch "[PATCH] asymmetric_keys: reject trust keys without IDs" failed to apply to 5.15-stable tree
To: bestswngs@gmail.com,herbert@gondor.apana.org.au,xmei5@asu.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 15:20:18 +0100
Message-ID: <2026102817-causation-protozoan-b0fc@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9695df3b1db4ac4534274d38ee16e3b9b0bf910e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102817-causation-protozoan-b0fc@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9695df3b1db4ac4534274d38ee16e3b9b0bf910e Mon Sep 17 00:00:00 2001
From: Weiming Shi <bestswngs@gmail.com>
Date: Sun, 6 Sep 2026 19:01:53 +0800
Subject: [PATCH] asymmetric_keys: reject trust keys without IDs

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

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 86292965f493..0e4783ff7d22 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -243,10 +243,14 @@ static int key_or_keyring_common(struct key *dest_keyring,
 			if (IS_ERR(key))
 				key = NULL;
 		} else if (trusted->type == &key_type_asymmetric) {
+			const struct asymmetric_key_ids *kids;
 			const struct asymmetric_key_id **signer_ids;
 
-			signer_ids = (const struct asymmetric_key_id **)
-				asymmetric_key_ids(trusted)->id;
+			kids = asymmetric_key_ids(trusted);
+			if (!kids)
+				return -ENOKEY;
+
+			signer_ids = (const struct asymmetric_key_id **)kids->id;
 
 			/*
 			 * The auth_ids come from the candidate key (the

