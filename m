Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5D481673
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520185; cv=none; b=ZVVBf5Mz69UjPtgTzw5fpVm7yuTxiGIVyb3FaiEmPPDF0Cg9P5BVEk+0TD+UE+oHFkuWHdqROjV2FhA2NnlSX0dPxhRBLhRvHwCHEh+xKWcSNGGBRlR+i0iHsrVEI+CFEZldkmuSJFSGx3MfQNDSF2TQHQCN3IyVopOhulHBO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520185; c=relaxed/simple;
	bh=Cq+fpx/aYNWSA8waJFnoWBwl+vemFvK5noJFhXWsZDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udxWulLWdtCXZaXTJp4lVqQeMJJDqilCnizxx7fgtyOTW44ZUHzGxilWeTX7k4ZXLyG9OoZrdb9KA/gLu93bSpfK8ANKj3o9jFNp6dgPcI+HYUtTWUm5dq/9NU/sAyUFmKqxcWskXb0I0oXtb104ploCfuUOtC8ewot/7JJ/zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTi+jack; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTi+jack"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B51B1F00A3D;
	Fri,  4 Sep 2026 11:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520184;
	bh=A/Tbd+SfPZgwQ5DwOeZNhIz0/qTu3TxOJOb2Pa6ScrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTi+jackEijo/7qqTkkc8VVRD3iPX0My72kKBcgmkUnedDEE0rlG6h/piNUT2Egym
	 xTJJKdjj7MuMmE87mO+D1LwdkevE67j1uYP3E4ptn5sE6uQd5mg+Kg1jR7fm5Kc9A5
	 Crti2yMktCteITX8v+CZZkG+7oVeJsFHdxG2FmOR7n2OvvlIiDRWlSQLr/8gqyTzVQ
	 4mRllnmmewM0e8GqMdFk5dpots6tn0RvbZJZQ+Prkd7nr6/ZZk0qzvFLP152rok9+M
	 GSlquuo1Bir18drCBVWTK6k+6OefCjcr+KL5VLruZStyBwVE1w1zKPse5GibcGaYy+
	 gRC4Ka1M0g8Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] apparmor: fix out-of-bounds write when null terminating a label vec
Date: Fri,  4 Sep 2026 07:09:42 -0400
Message-ID: <20260904110942.3173381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-monotype-arguably-69b8@gregkh>
References: <2026090322-monotype-arguably-69b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 9f1e40193eef7f047e6b77cfb4b4cafdecd7a123 ]

aa_vec_unique() null terminates at vec[n - dups] when VEC_FLAG_TERMINATE
is passed. If the components are all distinct no duplicates are dropped,
dups is 0 and the terminator goes to vec[n], so the caller has to provide
room for n + 1 entries.

aa_label_strn_parse() sets up its vector with vec_setup(profile, vec, len,
gfp) and then calls aa_vec_unique(vec, len, VEC_FLAG_TERMINATE), but
vec_setup() does not reserve the terminator entry. Up to LOCAL_VEC_ENTRIES
it uses the local array of LOCAL_VEC_ENTRIES pointers, above that it
allocates exactly len pointers. The terminator therefore lands one entry
past the end of the local array when len is LOCAL_VEC_ENTRIES, and one
entry past the end of the allocation when len is larger.

len comes from the number of "//&" separated components in the label name
and label_count_strn_entries() does not bound it. An unprivileged task
reaches the parse by writing to /proc/self/attr/apparmor/current or through
lsm_set_self_attr(2), both of which go through do_setattr(), and the name
is parsed before the change_profile permission is checked.
The query_label() path behind the securityfs .access file, which is
mode 0666, performs no permission check at all. Every component has to
resolve to a loaded profile, so a system with policy loaded is required.

The other two VEC_FLAG_TERMINATE users work on a label vec that
aa_label_alloc() has already sized with "+ 1 for null terminator entry on
vec". Reserve the same entry in vec_setup() and DEFINE_VEC(). Passing
len + 1 from the caller instead would move len == LOCAL_VEC_ENTRIES out of
the local array and into kzalloc().

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
[ replaced unavailable kzalloc_objs() with equivalent kcalloc() allocation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/include/label.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 55986388dfaeb..a987bd117d88d 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -22,7 +22,7 @@ struct aa_ns;
 
 #define LOCAL_VEC_ENTRIES 8
 #define DEFINE_VEC(T, V)						\
-	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES];	\
+	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES + 1];	\
 	struct aa_ ## T **(V)
 
 #define vec_setup(T, V, N, GFP)						\
@@ -30,10 +30,10 @@ struct aa_ns;
 	if ((N) <= LOCAL_VEC_ENTRIES) {					\
 		typeof(N) i;						\
 		(V) = (_ ## V ## _localtmp);				\
-		for (i = 0; i < (N); i++)				\
+		for (i = 0; i <= (N); i++)				\
 			(V)[i] = NULL;					\
 	} else								\
-		(V) = kzalloc(sizeof(struct aa_ ## T *) * (N), (GFP));	\
+		(V) = kcalloc((N) + 1, sizeof(struct aa_ ## T *), (GFP)); \
 	(V) ? 0 : -ENOMEM;						\
 })
 
-- 
2.53.0

