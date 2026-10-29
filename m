Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282821;
	b=4XkzvoHPDqIvJnK2PmZMGIkzlHCHf2tuWBiZJer5lrZfcFo5uU17PAMelgZYrA9xnLYJ
	 VAhnMyxLSUsX+3zbEqmVbwrTckNeyHcSDonVrev7RIZG/eP/08QeTZzYIQGnZVGxR6OZ7
	 uIkezYwNgvB8ludbi5AtqptPj4rpVd+c4a4sIAessk/vB6HV2dsjk/JXxwWb3E55rlx30
	 NNI1cPq/OAWf+CdYh4bTecljmWe7vO3rqrbH4tECbL/EJWyiofDl4pjZ1/e8xp3CwwFgC
	 Xr4cSf5Czkn9kAVEXlNXdQglyg7c32UfM7oLxrnI18ESgYqWlIlcnSoXwjrwwkhdroA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282821;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=L/34/5aGidVAtrmJ3HlwuahtRo0oJeFu+iRYL5npqg8=;
	b=F8o7BdUiLarlum+1gW0aRBF0/DIO1aayk+uArJl5UQSAcB8aSJhWqE7vQO1AcfE+O8B8
	 X2lB3nRwUeLzTsDA5Jr5dFxo8aofbPsMZC268nVtwvXvFR777Glh0JHuyS53RYOOwX+ob
	 XBO7jo675TOxxalJyzQ2LKsvvqjvq90QJHRDwGTCMJ79e/2sMBZ9fNo6D0bcdnII/c4rd
	 ln9jdN9obZFnwDm8WmeD+xwMUzaNmhFPxM1+Rm0wyWFU9VbB8xwLLZ/KU2svpUyMXmdrH
	 OnCWXWj9N5XDe4Qga5CdnFOopV2BeJclIBP+0ss7685yQT6blNyzEjs/SihqE0+ufPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=APPR9rok;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6B606A31A;
	Thu, 29 Oct 2026 14:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=APPR9rok
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B1816F2;
	Thu, 29 Oct 2026 07:06:55 -0700 (PDT)
Received: from codex (cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com [10.7.13.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE1C43F673;
	Thu, 29 Oct 2026 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793282818; bh=q0c28uO2yFKIwwv0CuGrBNwX4jUhzWMjtJVty+m7Yxs=;
	h=From:To:Cc:Subject:Date:From;
	b=APPR9rokq+vKM/1Mp0AUXLaPfS3gclpfg9eIWqt9I46UAcdLLXiVbGyrxZINebETX
	 4XvizX+gk8hxF5fgUK72OmTcYmV0J41Ruwkpw4MDnJF5L0CJYjit3rjcu45dfo5Tmt
	 DrfJdU/0RmiVSwTZDYxUD1EFcYgq8t1+80ZPLuWY=
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: fix race on NULL ctx->peer in update_sk_ctx()
Date: Thu, 29 Oct 2026 14:06:43 +0000
Message-ID: <20261029140643.4092-1-emanuele.rocca@arm.com>
X-Mailer: git-send-email 2.55.0
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

The unlocked check in update_sk_ctx() can see peer_lastupdate set before
peer is initialized, passing NULL to aa_label_is_subset().

The earlier NULL checks only cover accesses under the socket lock.
Check for NULL and refresh the cache instead.

Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
Link: https://lore.kernel.org/all/20260824155822.9214-1-maxime.belair@canonical.com/
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Rocca <emanuele.rocca@arm.com>
---
 security/apparmor/af_unix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index d04d9cd268aa..b95959806303 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -657,9 +657,10 @@ static void update_sk_ctx(struct sock *sk, struct aa_label *label,
 	bool update_sk;
 
 	rcu_read_lock();
+	old = rcu_dereference(ctx->peer);
 	update_sk = (plabel &&
 		     (plabel != rcu_access_pointer(ctx->peer_lastupdate) ||
-		      !aa_label_is_subset(plabel, rcu_dereference(ctx->peer)))) ||
+		      !old || !aa_label_is_subset(plabel, old))) ||
 	  !__aa_subj_label_is_cached(label, rcu_dereference(ctx->label));
 	rcu_read_unlock();
 	if (!update_sk)
-- 
2.55.0

