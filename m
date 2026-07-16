Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B441BA8D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201916; cv=none; b=myT76ppln68KqDjGrTU7e+1BhqFHcOBgfMena9Q9vUwL7fnA51d2njx2M4WNUavyN0b9/G2+zsWf9wqNWOQJFlE+8S/O64+8pdqK8XDXMbAz/4xxn2fW72NmzfHO1yXu5oCdoa0Rio7s9Qd5KE95LZwwmM+3X+XEp7uc7kxc730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201916; c=relaxed/simple;
	bh=5/KHbT/FK//A00L5cX2Ci2rgUqFgfnhTrmrnp6Y3gaM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MDzSSullYl64IzL2YAwntvnDgbIt9NQ68Fzubz6viGptSYy+wMEgpUnHP26MqOKlnV3Z4gyfEdWBjoeSyWArno5FUd+Zcxh9B8I1ato/3fOqSfGwiYWRRQCG2A31TtNwc63suWEjdrFIeRIZVrc5CU+LKprJSEAiOiOemvktCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QcsuKwdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QcsuKwdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3399F1F000E9;
	Thu, 16 Jul 2026 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201909;
	bh=kk5YWzsniazyS7aqGXQS1kchgcicvVIfj4Cr1eJlWbc=;
	h=Subject:To:Cc:From:Date;
	b=QcsuKwdcOa4QZ5xbh1fzjwb7F4ffcJT0KJ/4QhXFrHqT5ei1LwkZLdKkNmcKmtjdO
	 4QbMVDwwnLNJ7auk1ElUbY2rt+0aFvLIDMWkBUG06MLxbbnL+Hkt7ImSS3HbiWpU+0
	 8KM1/ALMPRvI3WoGHooFSxwOkEBi+dyXmEMa97EE=
Subject: FAILED: patch "[PATCH] landlock: Account all audit data allocations to user space" failed to apply to 6.18-stable tree
To: mic@digikod.net,gnoack@google.com,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:38:22 +0200
Message-ID: <2026071622-boil-spotlight-afbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b232bd12789fa57405b5092f28788be97aae9999
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071622-boil-spotlight-afbb@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b232bd12789fa57405b5092f28788be97aae9999 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Wed, 13 May 2026 20:03:08 +0200
Subject: [PATCH] landlock: Account all audit data allocations to user space
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 06b6bd845060..04b69b43fbf5 100644
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
index a9d57db0120d..35cac8f6daee 100644
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

