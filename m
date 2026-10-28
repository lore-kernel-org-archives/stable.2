Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197229;
	b=iMi9lRbsCDFitOf6/DlrPLKGGne9SjwVYqh29IHKdJnP49REA99Blr92H6DIkIMw8rba
	 pA4EzCOi8UKW1h6ymYLJp1qyQw/mb3BMmLbhYFayCs6owQITXWznpOeehZD0QctP1My3P
	 Hj+ERvMxrCU6SROHYLKlJ7ElfQUwQWS0ziXu6I8z9fjKaGbBj46b8rdZHE7E+2873XnMc
	 AdRUYeFavXsmqhGYYB1emGIAZW1hFPuP49/JH/zO3+01nl5weblCfrBWLCfR3JaA4PS4a
	 k0VPS30UWNR17WiPIjcFAWed6Zo+CdW14HroBc3EVZgrbdD0h0aDEFKPApaf8ahqd5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197229;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=csfvkkjqV2B62d7uU1OSo9DGFmeVsvKlJVD7q2QtfCA=;
	b=FpZ5uw2Z7rw5qtiwi42bBMxhwekPCyr41vfc/jwBHs9vyVSYcYQ8sQIJLJN/vQ69Qae4
	 MFp/oYGqVdo6MpYB1AiHXeaRxayZTkRpYT/8vmEJIaH6b98i1zlS5deiChqMScwx62Hc4
	 4Ozcq6/Kps7/2Rz+5/Nbgmeq/9f9J3L5DGs/h9oOrh/24NexiEZybUU3YmbLaISkbNDuE
	 Kgu3TxSvCiVUfMMJ94RmoqHKLsm9htoPPPk3wkcJkVHk39gOuBHZM0tnEgJOh7i3KAfeA
	 wdE14sLOLn9pTFV8jSj+Lu6ls8f/fNZddtKgbweZGMOj8ouwwmtLKbxPsQyj43A4vpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=M3Z2kCtK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6981606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=M3Z2kCtK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9025E1F01825;
	Wed, 28 Oct 2026 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793197228;
	bh=csfvkkjqV2B62d7uU1OSo9DGFmeVsvKlJVD7q2QtfCA=;
	h=Subject:To:Cc:From:Date;
	b=M3Z2kCtKFhjGqRkBwptNYB0VIRrvmNqezJLf1wAr6W25J9/rO7O/AoAPLTzIjQWK2
	 KSRlI9P8bKH9nnov+dQtni2uo+xVHx2/iZO0DlEUNcon9qRLG3UE7vZ5QdjAz8V1b5
	 mIgVJ1Sam4IDYvSNRdp8wvriQ/7adV90+m6WZckg=
Subject: FAILED: patch "[PATCH] asymmetric_keys: reject trust keys without IDs" failed to apply to 5.10-stable tree
To: bestswngs@gmail.com,herbert@gondor.apana.org.au,xmei5@asu.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 15:20:18 +0100
Message-ID: <2026102818-nearness-dividing-d8eb@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9695df3b1db4ac4534274d38ee16e3b9b0bf910e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102818-nearness-dividing-d8eb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

