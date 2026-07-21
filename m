Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C635DA40
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662565; cv=none; b=CRa2ipm+l+w1vsGqpHZUIijJtfeJ+aabwwoUllVNPLh0X0O3BysNhweIWeF+c4l/a72Zsaw2PrI4LILaHf/3M7a4aPmwVIoT0qoR2mhxEwgMVee207eGd2Zkmvrt9pqOV0uPBEQNCqxboloJecnV0+Ylk76BYPN89Ut4AJ18T0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662565; c=relaxed/simple;
	bh=F20xhVz99UfHaiML9ggIhB2GJnY69SVysVpKU05lJU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkJX9L9oHxqK/7qgjQtuDb6hhm9QeYB3K9uIUW15uHj8Fi68I5TUHoDtD7kOhh4W1Kn456eHoGheIzGU1y4MxKw49Lvdu+8VJ8DzBz/GeJYmj+WTATlJy/vAirULF7IpFF2ubG+kAkHPq3JyHz/rySvM+DGb2mHP28xxmY/+xMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmjuC5tS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmjuC5tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD621F00A3D;
	Tue, 21 Jul 2026 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662564;
	bh=8zjZuiO0j/sPwq0mIvtIByecYJhK2pIA0CmD5ukXOdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmjuC5tS2uGV5ATQrlIWuTBEXhu60Tn82PemhrKr4/lTTor/KxrDeieDUklAkAMlQ
	 G1YtSPvNnCj/wYwHngGX8C3qwzIDLkPDwc6mWNh3/9g5wsuUv1vWT1DQPTWbZPmxUa
	 G6ubRL2hKgY2gUeXGDCrWzkRHOV6OXUbjfDtUiNFHgQV9AN+usOk20uvxseVZ4W/p8
	 SblF9N3XSUgnPMc018mb+SGvR/uKcm9cQWAaw3q8r9SP2YjN97CKyQDK0rGhLreYHQ
	 HHdFB/Ok0TDzzSiRrmLVZKNq0Xgr1YUAaMvZJ5S1MhaxYuQ1+v0nbI6Z4QOkYumnKC
	 EHMaoGIGdbzlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] landlock: Account all audit data allocations to user space
Date: Tue, 21 Jul 2026 15:36:01 -0400
Message-ID: <20260721193601.410261-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721193601.410261-1-sashal@kernel.org>
References: <2026071622-boil-spotlight-afbb@gregkh>
 <20260721193601.410261-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit b232bd12789fa57405b5092f28788be97aae9999 ]

Mark the kzalloc_flex() of struct landlock_details with
GFP_KERNEL_ACCOUNT so the allocation is charged to the calling task,
like the other Landlock per-domain allocations which have used
GFP_KERNEL_ACCOUNT forever.

Every property of landlock_details is caller-attributable: allocated by
landlock_restrict_self(2), owned by the caller's landlock_hierarchy,
contents are the caller's pid, uid, comm, and exe_path, lifetime bounded
by the caller's domain.  While the caller may not know nor control the
size of this allocation (i.e. exe_path), this data should still be
accounted for it.

The deciding factor is whether userspace can trigger the allocation, not
whether the size of the data is known nor controlled by the caller.
This aligns with the kmemcg accounting policy established by commit
5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg").

No new failure modes: the hierarchy and ruleset are allocated before
details and are already accounted, so landlock_restrict_self(2) already
returns -ENOMEM under memcg pressure.  This change widens that existing
failure window slightly; it does not introduce a new error code.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: stable@vger.kernel.org
Fixes: 1d636984e088 ("landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain status")
Link: https://patch.msgid.link/20260513180309.165840-1-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/domain.c | 9 +++++----
 security/landlock/domain.h | 5 +----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a1377c7d7e9b84..74fbe8de1fc5f5 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -90,11 +90,12 @@ static struct landlock_details *get_current_details(void)
 		return ERR_CAST(buffer);
 
 	/*
-	 * Create the new details according to the path's length.  Do not
-	 * allocate with GFP_KERNEL_ACCOUNT because it is independent from the
-	 * caller.
+	 * Create the new details according to the path's length.  Account to
+	 * the calling task's memcg, like the other Landlock per-domain
+	 * allocations, even if it may not control the related size.
 	 */
-	details = kzalloc_flex(*details, exe_path, path_size);
+	details =
+		kzalloc_flex(*details, exe_path, path_size, GFP_KERNEL_ACCOUNT);
 	if (!details)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7fb70b25f85a19..e3525da27b9355 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -33,10 +33,7 @@ enum landlock_log_status {
  * Rarely accessed, mainly when logging the first domain's denial.
  *
  * The contained pointers are initialized at the domain creation time and never
- * changed again.  Contrary to most other Landlock object types, this one is
- * not allocated with GFP_KERNEL_ACCOUNT because its size may not be under the
- * caller's control (e.g. unknown exe_path) and the data is not explicitly
- * requested nor used by tasks.
+ * changed again.
  */
 struct landlock_details {
 	/**
-- 
2.53.0

