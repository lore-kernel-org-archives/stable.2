Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433863;
	b=StfQqDulrUR9D4ZkwMgS+x25s6WoiGlByafgRguAl9QrQ0h4xNwbpvFAd9wFp2Iyk8Yl
	 m3CsNPI2RNDJlyXV3bZLLyzo3L+27ii12P33rr047zCDDjgWOxlfOZtgEfB677vX+2zgt
	 DxpIzgY3OGD50BKcpNpSQPH6KKTgMFiggh819Gccx87wITXkK7Trzg87vt3KzWwMgAUYB
	 Ddeg6PQUCjSmmjsGtCSiZpAgWN49paOJQhLhLnzJT5q/bxuvC2yZ24tx6MF/4vRzPqmq8
	 zNHuOO1l5uu70R3/m6JqIDctO/ikO+18fSLmKDgyhWyAhJYuDKxCtRkE2NqBK//pjfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L/h7XAXISDUBbevw8iUGnMimHu5FAox8Ny2Kp/dregc=;
	b=Hl4WGfZ55+2RLKrs1yePo3DlI+7hQ9MGU1sNAwr3b0stCzkYWXH0G9/Iax5JEaTDmWbU
	 xpZ/KbYi2dNvSyx9+Fmp6PvsO1K51LoxzvmnUMu1b/AlYgD2g2xn3eHFUlB7di2mNPjCb
	 R5z3GueIGpSzJDqobDG/CnxwuU4JLcmn48B3PXOM3UktG+u0hw2WN4nEOjqQ8IrBYfSBP
	 d02XW+w5B+LUWtIty+DP3nnWawUXT1UOBWutogIj6LHuyZWsa1UYOedTt9AO7GXOxztCQ
	 XNgfA0x1e0Yd7pFduvm8gynezG6oM8IBHUjap7XjPtystKF1G0RWKf9aQxyAYiUh5vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvk65aLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 65686606A325;
	Mon, 19 Oct 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvk65aLE
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 754E51F000C6;
	Mon, 19 Oct 2026 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433863;
	bh=L/h7XAXISDUBbevw8iUGnMimHu5FAox8Ny2Kp/dregc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mvk65aLEZHMvEw9B487mROmJQTl5V5TR5er2biUstPCAszsDZ2Jp/ppju7djw2/Tm
	 nygjI99Z8fMnHu1yjW+xTBL/8iSe5JHRBMz5ZWFLvrVvGinhxYX+4NZpPG9wo97eIh
	 NZXi2fHmRXpwo9K2oq4l47FwU6qoDHWjsP3uFMejg04vgB8bKeCVE7HwJXAzXENUX5
	 kE9uiKE3mc0OEiJyXVistyjJohTyadKK+APeTFGUdsgguP4u4o3cCEhX2iUkvZwNbq
	 cqU1qIONZDxy0P5RRXL/sbtf5Bb4mCvnn9HvDprLKqXGT989nFuMspEqnR5s/uPJa3
	 U8tAeT9GBtBjQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 1/6] KEYS: Expand key->{datalen,quotalen} to unsigned int
Date: Mon, 19 Oct 2026 21:17:21 +0300
Message-ID: <20261019181732.449591-2-jarkko@kernel.org>
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

In key_alloc() and key_payload_reserve(), key->quotalen and key->datalen
can receive values larger than USHRT_MAX.

Change their types from unsigned short to unsigned int so that they can
carry the full payload and avoid truncation.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e40b5267658f..26139c3adf62 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -216,8 +216,8 @@ struct key {
 	kuid_t			uid;
 	kgid_t			gid;
 	key_perm_t		perm;		/* access permissions */
-	unsigned short		quotalen;	/* length added to quota */
-	unsigned short		datalen;	/* payload data length
+	unsigned int		quotalen;	/* length added to quota */
+	unsigned int		datalen;	/* payload data length
 						 * - may not match RCU dereferenced payload
 						 * - payload should contain own length
 						 */
-- 
2.47.3

