Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363114;
	b=IIODRWY2RnJEry+JDRXk9LmMARubFVIwDJtzWQi8vg5+wi/Kusi5zL7Ck/rZ90xtKu+q
	 LcVQ5K848zHxLneMaLZ4/Zt/KsD3/nnxjQhACnMAa1kjwOhjapV+iRXmtbgUoyNg2c0C1
	 pKLBzS/RRK9+lZeJzjUvtGhN/XWjkn88td7Ctdih1BQNhAhwxhdBcJMcEE0soJpjxPri9
	 rDNVOJV7VgRFBoXpT/QA4/BzCF35BkfKxEY+b6fyc74pOxjP1GnW9vfoPz9x4SmGquT6v
	 rtCIa5yJLZACAHtsHYGVPfwvcS65Xw9W87TiqX27+AF4gsrHyLorktVwaywmrv5IxQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0AHgMxwdv0/JBdUcM1BBydQlJ3svTdzPq3h3gokgaas=;
	b=NB0ifkHvzDMMaLcG8JDA5PWz5VJRDrSmnsNmsOumFo6H3blR4ib2ob5Q+nDTi898xpfY
	 uUs0SD9hLNNDJN9woMKbXQQHu4DpMPzELfqdnYukcUg75UkH7KlI0VM9Q6hV6e2zkc5hq
	 G8r0Fl3o+LPbzUAlmy7YwX3fq3njd+BSjlgq8duIEmjnl2+TesK+4OQ5Y9nfQFUnoVgOe
	 rYqGGjrOmwFANsjzXGFhcDBLmiuI+2j4RQxZb3XZs00piK7CtGTw9hpOOLvi/a9vhD+0A
	 G6Nb+ycwUpdNkHzLO0Z+iZLhm91u/snZPfq8gaIUBYGePysm0pAT3vEkVtBLXimQR2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mILjOVHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A7606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mILjOVHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8618A1F0093C;
	Wed, 11 Nov 2026 02:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363114;
	bh=0AHgMxwdv0/JBdUcM1BBydQlJ3svTdzPq3h3gokgaas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mILjOVHVymndNSNfh5al/8zBPEgHxzn3RcL9UcYK79NBtBmhTpS+GScfH59MWIYvW
	 84BzF/w1SujmYjjWbqzS0pcf2C4lGIPGEvFbtsxo3n8BRxoRtS3r3JDJHgAN45CwnV
	 cvA7/+a8PbGBR3Th6ucrVAF1fTr6U8wJ96tqzP63lFgu5u9QXqSCYazp0PftxK9sx/
	 iHBL042lT5qBGQqylSd7p0AUEbAOzf/UCeP8cID/oBEozr1PsHlra9+V/XpG0sNHtR
	 MWJI3HjgbSHQ+hFIHIEPlb6fUZh2xbdg1dTl++zjUJs6AfJhXw429F1RFynXuxs7JG
	 DdPZHdwioTr/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] apparmor: fix refcount leak in aa_get_newest_profile()
Date: Tue, 10 Nov 2026 21:11:52 -0500
Message-ID: <20261111021132.584038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063050-failed-5.10-33ed50716251@kernel.org>
References: <20261107063050-failed-5.10-33ed50716251@kernel.org>
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

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 33ed50716251d5b2875706c40d0c8082d46be0b1 ]

The labels_profile() macro is evaluating its argument twice

  #define labels_profile(X) ((X)->vec[(X)->size - 1])

unfortunately aa_get_newest_profile() passes
   aa_get_newest_label(&p->label)
so every call to aa_get_newest_profile results in 2 refcounts
being taken with one being leaked.

There is no need for labels_profile() to be a macro. Convert it to
an inline fn, which ensures all uses are passing the correct struct
and removes the double evaluation.

Fixes: 637f688dc3dc ("apparmor: switch from profiles to using labels on contexts")
Cc: stable@vger.kernel.org
Reported-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
[ sashal: adjusted context around labels_profile() for differences in surrounding macros and declarations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/include/label.h | 6 +++++-
 security/apparmor/label.c         | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index a987bd117d88d..e7e0f3e0435fc 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -148,7 +148,11 @@ do {							\
 #define __label_make_stale(X) ((X)->flags |= FLAG_STALE)
 #define labels_ns(X) (vec_ns(&((X)->vec[0]), (X)->size))
 #define labels_set(X) (&labels_ns(X)->labels)
-#define labels_profile(X) ((X)->vec[(X)->size - 1])
+
+static inline struct aa_profile *labels_profile(const struct aa_label *label)
+{
+	return label->vec[label->size - 1];
+}
 
 
 int aa_label_next_confined(struct aa_label *l, int i);
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index c675a11d8a551..f14802e2c2264 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -377,7 +377,6 @@ void aa_label_kref(struct kref *kref)
 		label_free_switch(label);
 		return;
 	}
-	/* TODO: update labels_profile macro so it works here */
 	AA_BUG(label_isprofile(label) &&
 	       on_list_rcu(&label->vec[0]->base.profiles));
 	AA_BUG(label_isprofile(label) &&
-- 
2.53.0

