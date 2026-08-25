Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1B3FE348
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657086; cv=none; b=E/zb1tvYFh1YAwKS8mR/aUZj9oAzftZ8/Pf4PWvhvjw2Fqg0cr2xHfJRKKNRBdY3o/WHMNsQp1ye9usaqbw3/CQWhaSGjQDVB2TQjBZ7vxiDLX48Y0aSRZeRtQfAqFi7LPROhkQ1DDd8yNaw2kSSOAasjL/5eH6/LksnMJ2bnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657086; c=relaxed/simple;
	bh=RdtY1PAx9jEy1igCtRt03KHtzJjKE8wSbDaSiuR3v6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUy/DGr0ozpcVjVRwePfZaJpnKwReOl49ljp0A3zyeRV14Pe1ZbMpSKQojvr8sjvmTrIqQyW54slmctmseAKSpQ7XlSE6YxviYGRmc9WjH7DVMvYnUtdCbpnQ5yyCAwojtwANdzvo9jY36Fijs7OxoS2K9y0Lg1eClPcB+VE+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA9noaGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA9noaGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E671F00A3F;
	Tue, 25 Aug 2026 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657085;
	bh=qJ1QMx/F5rcRHN2wYXCkJIMmI5gCGrynHKya1gtMdvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JA9noaGrQtGuNdZeaOD4yD5UEvn67pblDx6q31TopRs7EI60BaEo/do9Xv/MEIYsf
	 +p6gfy8RELa5mzO6WsV1Esx1lAwAEeo7zaUUZl1YuyIdZrCTVSBxIcHd3VKVbt9vJs
	 zAZ9KOdEni/t4ukXRie5W9n5Dm1DD1CEDH8SqaBQ22l9gwwD2QXq+gIZ/jhPepW0kT
	 mz2T2clRN7b7hRUgPUKRrikh9FpbE0DOJMjXbLiW485gy5fW4OYQ0/KGocUnJbsZkE
	 VZ3kKyLL7+VyNCVVHqhyxf/kj35RIpIovqGjD4VLprW0U7SPAMRPtOaHh5UXMSPR/9
	 0NitEVQX/rDNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/9] selinux: avoid unnecessary indirection in struct level_datum
Date: Tue, 25 Aug 2026 07:24:35 -0400
Message-ID: <20260825112440.3543785-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825112440.3543785-1-sashal@kernel.org>
References: <2026082022-circle-gooey-f888@gregkh>
 <20260825112440.3543785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 749153636643aaa793f14e84e864fdaf5ed0620d ]

Store the owned member of type struct mls_level directly in the parent
struct instead of an extra heap allocation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: b98a8ac50775 ("selinux: require a class's permission values to cover its permission count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/mls.c      |  6 +++---
 security/selinux/ss/policydb.c | 19 ++++++-------------
 security/selinux/ss/policydb.h |  2 +-
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index cd38f5913b630..e7883e2aead5d 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -174,7 +174,7 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 	 * levdatum->level->cat and no bit in l->cat is larger than
 	 * p->p_cats.nprim.
 	 */
-	return ebitmap_contains(&levdatum->level->cat, &l->cat,
+	return ebitmap_contains(&levdatum->level.cat, &l->cat,
 				p->p_cats.nprim);
 }
 
@@ -296,7 +296,7 @@ int mls_context_to_sid(struct policydb *pol,
 		levdatum = symtab_search(&pol->p_levels, sensitivity);
 		if (!levdatum)
 			return -EINVAL;
-		context->range.level[l].sens = levdatum->level->sens;
+		context->range.level[l].sens = levdatum->level.sens;
 
 		/* Extract category set. */
 		while (next_cat != NULL) {
@@ -466,7 +466,7 @@ int mls_convert_context(struct policydb *oldp,
 
 		if (!levdatum)
 			return -EINVAL;
-		newc->range.level[l].sens = levdatum->level->sens;
+		newc->range.level[l].sens = levdatum->level.sens;
 
 		ebitmap_for_each_positive_bit(&oldc->range.level[l].cat,
 					      node, i) {
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3e96d7119c3f2..8e0c368e5f4d0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -296,9 +296,7 @@ static int sens_destroy(void *key, void *datum, void *p)
 	kfree(key);
 	if (datum) {
 		levdatum = datum;
-		if (levdatum->level)
-			ebitmap_destroy(&levdatum->level->cat);
-		kfree(levdatum->level);
+		ebitmap_destroy(&levdatum->level.cat);
 	}
 	kfree(datum);
 	return 0;
@@ -636,11 +634,11 @@ static int sens_index(void *key, void *datum, void *datap)
 	p = datap;
 
 	if (!levdatum->isalias) {
-		if (!levdatum->level->sens ||
-		    levdatum->level->sens > p->p_levels.nprim)
+		if (!levdatum->level.sens ||
+		    levdatum->level.sens > p->p_levels.nprim)
 			return -EINVAL;
 
-		p->sym_val_to_name[SYM_LEVELS][levdatum->level->sens - 1] = key;
+		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
 	}
 
 	return 0;
@@ -1612,12 +1610,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (rc)
 		goto bad;
 
-	rc = -ENOMEM;
-	levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_KERNEL);
-	if (!levdatum->level)
-		goto bad;
-
-	rc = mls_read_level(levdatum->level, fp);
+	rc = mls_read_level(&levdatum->level, fp);
 	if (rc)
 		goto bad;
 
@@ -2835,7 +2828,7 @@ static int sens_write(void *vkey, void *datum, void *ptr)
 	if (rc)
 		return rc;
 
-	rc = mls_write_level(levdatum->level, fp);
+	rc = mls_write_level(&levdatum->level, fp);
 	if (rc)
 		return rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index e01de17e569bf..e7a6f1a6c1461 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -126,7 +126,7 @@ struct user_datum {
 
 /* Sensitivity attributes */
 struct level_datum {
-	struct mls_level *level; /* sensitivity and associated categories */
+	struct mls_level level; /* sensitivity and associated categories */
 	unsigned char isalias; /* is this sensitivity an alias for another? */
 };
 
-- 
2.53.0

