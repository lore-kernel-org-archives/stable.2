Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362896;
	b=OIIs4r2f3mzWP9WSNPIteHKjyN77hCE8rJxDy2GugA30ZAKVoPVsBMDnJWlBbj+V2zPm
	 uyGCVfb9QzLDTRSxqxUAZ+6rdJ0vga5laPZMbtRfj1yfO6JTVJn7k28YLrnkFgdSJDaXT
	 SmGNaCmVSsScOQCNMqBtoT+IOiKnjD0x/CQufAiouXAwTbkXJhK56M6HOq3r4JOl9tUAF
	 1nV539c2GmwllD8PM+5AuzZc8RaoVHUd/+wdyy3yns1owilvJVKfwk02B2QpchindtEmv
	 pCxaJAEbN61WPRDAdclViFBZ11ztVIVNB+9wPtbp45mlakjWleGrugwYWP7FN39Bq8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jC2+x6umGaLHTBKWTEKFe6YEY581JOgxGFFdY1U2bhk=;
	b=o2zEjFpSlaB8/sgpEzplImLzwcZtO+TOWADEV/Nxs5K7gktBfF+nUSpM61Atjh/cVb/y
	 jQJiV60nUmv3OBgq3dzSn/Y9YkxHAmZ8pMpu+X4uCIuZvmlp2IHW/lDzhC95kml0J5EqV
	 sMMV1UUr2S+fFgW8Awf4SgT+DAbeIK7b/rUvP4BGmPUbWnd38P4hwLevThhahGZJQCx8l
	 TizNK+RaSZljzlZR9uhtvVN6KokOUp3r6BL8FI6iln8gJCf/ki8s411nd+rsFBgB986lT
	 28GWbZlbh8+dRpky6BK95/yLyEInOq0bHSx2SNPrp3NEFCgYHkcSwksKaSI0SLRwkqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yd//eMvv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD7F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yd//eMvv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0E61F0089F;
	Wed, 11 Nov 2026 02:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362896;
	bh=jC2+x6umGaLHTBKWTEKFe6YEY581JOgxGFFdY1U2bhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yd//eMvv2mnh0gigLC9PCnJmXZo/ihw+3uCj96aT8qufkpKO9BlnajafJjaTefMUv
	 BpuNlGrqDjIXZwEjlTpiskMwdBeXFhj9GK6Og/q3130fhwp9p9fgkGC9uJCSom6P1c
	 acSC2mN+eOSvaOZG0Vh+TTG4BskuXnXfUSWVVJWjrnD0cw5C4Sd38w6JdrfXbO+jLE
	 jgvhdBB6Pp150DiakiC/8RfzTyfgpvfjuLvpYX4rZwkR0Pod8OBidofSazR7ZncM1k
	 Jh9h080xtv3iZvGLHtpCttQrE5DeFMTRd3qr+M30Lw2sKC7/IYuzk4q4HSHB4LMXGg
	 qS8wcwhBATNuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] apparmor: fix refcount leak in aa_get_newest_profile()
Date: Tue, 10 Nov 2026 21:08:14 -0500
Message-ID: <20261111020757.531515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061334-failed-5.15-33ed50716251@kernel.org>
References: <20261107061334-failed-5.15-33ed50716251@kernel.org>
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
[ sashal: Adjusted header context because the adjacent labels_view() macro is absent. ]
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

