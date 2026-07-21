Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01C433042
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662565; cv=none; b=jTpjvT4DfnJsZjuQ4/idHnYzMcfikVet+DZB3QJy14UEkQxGCw0VboL/T4iJrH3MZzirzczXx7FN+FefojzVJhdem14B5S0QvnKXLgth5yXEBaELa7SS5Lidfs0e9QZKmiOOcVj5+e+up9dfGUIVAgj3Roo4F7+YuXefzIkBcSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662565; c=relaxed/simple;
	bh=XN6PiNozn/V2DifZgt1DfIJy4KNRG22jxHpi6LhsvL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0ClHf2UoeBR8Mm7eBeZIfihglsgdaouzQpPsPGeOXdEOUrXho70qaw227GlTRvLU7e5Ct5kDmMsbkpskS8Hj5xNgF9rLZzwSNMec8l2ql9VqeMT5oWAFuWjo71KC+AUaYxsJ7vEY3pPZgwApsT1K2N92q4QDI0JMozpgUC2GvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zip+1VVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zip+1VVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFF91F00A3E;
	Tue, 21 Jul 2026 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662563;
	bh=LJOGFDI+YhSafgWjp5xkHtQ2qcutoQm4O2XjHMk6wS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zip+1VVZawV2rjdA3SkZFrh0gvq0Dbkpjpzb29aOdRmDKBDFdKPCfXUUjrNyIV7E6
	 U2PcXblIsukkvyyajjOOVjNTCaJclbDBJ9r3lsXk2dm8WvT4eWcAd0GPH60RyXLsF0
	 kXvy9Sz7eMQYUiHbwrsFj/aOT4xJRUhfWMHPNC6mT+fhXEEnaczs858meW8QPdqUtw
	 Z5uk6FV4CMmzqLIdbsJIvUXG197Iu+znWynS3dxRJkDySfBRGUSBW1TNQpb/8gQKIQ
	 m3jyflrOvQpYIe0pcpUM0kosKTdqsrseCeWkWwj0xtgtJ32IHHhsNdtPKggfLTg7oQ
	 J1XFMWMlGy6vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] landlock: Fix formatting
Date: Tue, 21 Jul 2026 15:36:00 -0400
Message-ID: <20260721193601.410261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071622-boil-spotlight-afbb@gregkh>
References: <2026071622-boil-spotlight-afbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit 405ca72dc589dd746e5ee5378bb9d9ee7f844010 ]

Auto-format with clang-format -i security/landlock/*.[ch]

Cc: Günther Noack <gnoack@google.com>
Cc: Kees Cook <kees@kernel.org>
Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20260303173632.88040-1-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Stable-dep-of: b232bd12789f ("landlock: Account all audit data allocations to user space")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/domain.c  | 3 +--
 security/landlock/ruleset.c | 7 +++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a647b68e8d060a..a1377c7d7e9b84 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -94,8 +94,7 @@ static struct landlock_details *get_current_details(void)
 	 * allocate with GFP_KERNEL_ACCOUNT because it is independent from the
 	 * caller.
 	 */
-	details =
-		kzalloc(struct_size(details, exe_path, path_size), GFP_KERNEL);
+	details = kzalloc_flex(*details, exe_path, path_size);
 	if (!details)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ce7940efea516c..2a1e57ac0c5373 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -33,9 +33,8 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 {
 	struct landlock_ruleset *new_ruleset;
 
-	new_ruleset =
-		kzalloc(struct_size(new_ruleset, access_masks, num_layers),
-			GFP_KERNEL_ACCOUNT);
+	new_ruleset = kzalloc_flex(*new_ruleset, access_masks, num_layers,
+				   GFP_KERNEL_ACCOUNT);
 	if (!new_ruleset)
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&new_ruleset->usage, 1);
@@ -553,7 +552,7 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		return new_dom;
 
 	new_dom->hierarchy =
-		kzalloc(sizeof(*new_dom->hierarchy), GFP_KERNEL_ACCOUNT);
+		kzalloc_obj(*new_dom->hierarchy, GFP_KERNEL_ACCOUNT);
 	if (!new_dom->hierarchy)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.53.0

