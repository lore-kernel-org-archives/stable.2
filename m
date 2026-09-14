Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0709477286
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396766; cv=none; b=MCap8FF931S0dxIGuhdL13a9tvtYt56b+vk7SKbxlRNzZFe8qMcOq4eGZsYoYgLZrkfC4NegIZ4J2wtciohqHtT0RE7wQzjp/7AM9sYVXOiiR7PXxutHLpKSgqa3f/tuHzWG4bQ145/fS92V7w4n5b+h7f4SGh4mWSV9UBXXwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396766; c=relaxed/simple;
	bh=IobJDoFsqoQeG+EBk6FBy+wqIg2yPVDLwJfVGsbvfxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkchjruO9JENXrEpsPBeg/cMy5bUV++y1dTJuMQiupRnIAWcXsQhbY6T4AESrRvEH1ZPq/1RjyyCKd/Nbu4hUW1lVl6hmA0lhTagW2ebPfUAEwkmldSnTrZDe1r4R2Q58PL0rkoR4m+fJcaJPLEsBMiQk8v2EUPvjZw8qiSBvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9lZwLXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9lZwLXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF1B1F00893;
	Mon, 14 Sep 2026 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396764;
	bh=P/L6fhRkP+mSZJrv13md9XRbM73VOY6J+c26N8pQUoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g9lZwLXcMuSxUpNLEBDC2Ag32vTnFIrkh7XC8LB6ojJbg4LAOExA1rGksrfzvxSOy
	 mZExlIWN7n9YlcGGKacC8wHBednGwSdQWUtCNzOMuLuDZqcspEE1N6R8PD7IG6T8nV
	 Qh4nG3FRzlWzEPBcipE1UYmJ6A4ySVt/u1eWIX/KXv+njZAHlDk8k4Y/p3m/HydxTI
	 4dKdkEfaZHvNrMPXbjKcipQ/33o2gXqyGh6iZIzGu1/esMRkznhuVueJQKDZ8aFfFo
	 2AJvzjNS6RmovBCAfIbw6nkohjueCJd2mom6YMUQHPduqwbH5SVKTbrrEfOsG3VkRm
	 rE3BHT1DCuaYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ksmbd: use __GFP_RETRY_MAYFAIL
Date: Mon, 14 Sep 2026 10:39:19 -0400
Message-ID: <20260914143920.70748-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091411-kept-parish-8e82@gregkh>
References: <2026091411-kept-parish-8e82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 0066f623bce8f98b69b752ee03d46a5047c281b8 ]

Prefer to report ENOMEM rather than incur the oom for allocations in
ksmbd. __GFP_NORETRY could not achieve that, It would fail the allocations
just too easily. __GFP_RETRY_MAYFAIL will keep retrying the allocation
until there is no more progress and fail the allocation instead go OOM
and let the caller to deal with it.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

Stable dependency adaptation for f25e93768fcc5d8287e50b1ec52a42e4c276df34:

Limit the allocation-flag conversion to share configuration and retain
KSMBD_DEFAULT_GFP in glob.h. Drop the other subsystem conversions, which
are unnecessary for the target and conflict with stable's existing ID,
RPC locking, lease, ACL-buffer and network-interface implementations.

Include the existing-function share_config_request() error handling from
a74668eb2c0b8 (path allocation failure) and the share_config.c changes from
d2ccf905f47d2 (name allocation failure). These provide the target's patch
context and ensure veto-list parsing cannot overwrite a failed path
allocation or the target's invalid-path error. No functions are added.

[ sashal: Reduced backport -- upstream 0066f623bce8f touches 24 file(s), this
  backport carries 2. Not backported here:
  fs/smb/server/asn1.c
  fs/smb/server/auth.c
  fs/smb/server/connection.c
  fs/smb/server/crypto_ctx.c
  fs/smb/server/ksmbd_work.c
  fs/smb/server/mgmt/ksmbd_ida.c
  fs/smb/server/mgmt/tree_connect.c
  fs/smb/server/mgmt/user_config.c
  ... and 14 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config responses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/glob.h              |  2 ++
 fs/smb/server/mgmt/share_config.c | 29 +++++++++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/smb/server/glob.h b/fs/smb/server/glob.h
index 5b8f3e0ebdb36..3ce12b60e46fe 100644
--- a/fs/smb/server/glob.h
+++ b/fs/smb/server/glob.h
@@ -46,4 +46,6 @@ extern int ksmbd_debug_types;
 
 #define UNICODE_LEN(x)		((x) * 2)
 
+#define KSMBD_DEFAULT_GFP	(GFP_KERNEL | __GFP_RETRY_MAYFAIL)
+
 #endif /* __KSMBD_GLOB_H */
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index d8d03070ae44b..97b0bbd619979 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -102,11 +102,11 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 		if (!sz)
 			break;
 
-		p = kzalloc(sizeof(struct ksmbd_veto_pattern), GFP_KERNEL);
+		p = kzalloc(sizeof(struct ksmbd_veto_pattern), KSMBD_DEFAULT_GFP);
 		if (!p)
 			return -ENOMEM;
 
-		p->pattern = kstrdup(veto_list, GFP_KERNEL);
+		p->pattern = kstrdup(veto_list, KSMBD_DEFAULT_GFP);
 		if (!p->pattern) {
 			kfree(p);
 			return -ENOMEM;
@@ -150,14 +150,19 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 			goto out;
 	}
 
-	share = kzalloc(sizeof(struct ksmbd_share_config), GFP_KERNEL);
+	share = kzalloc(sizeof(struct ksmbd_share_config), KSMBD_DEFAULT_GFP);
 	if (!share)
 		goto out;
 
 	share->flags = resp->flags;
 	atomic_set(&share->refcount, 1);
 	INIT_LIST_HEAD(&share->veto_list);
-	share->name = kstrdup(name, GFP_KERNEL);
+	share->name = kstrdup(name, KSMBD_DEFAULT_GFP);
+	if (!share->name) {
+		kill_share(share);
+		share = NULL;
+		goto out;
+	}
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
 		int path_len = PATH_MAX;
@@ -166,8 +171,11 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 			path_len = resp->payload_sz - resp->veto_list_sz;
 
 		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
-				      GFP_KERNEL);
-		if (share->path) {
+				      KSMBD_DEFAULT_GFP);
+		if (!share->path) {
+			ret = -ENOMEM;
+		} else {
+			ret = 0;
 			share->path_sz = strlen(share->path);
 			while (share->path_sz > 1 &&
 			       share->path[share->path_sz - 1] == '/')
@@ -179,9 +187,10 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 		share->force_directory_mode = resp->force_directory_mode;
 		share->force_uid = resp->force_uid;
 		share->force_gid = resp->force_gid;
-		ret = parse_veto_list(share,
-				      KSMBD_SHARE_CONFIG_VETO_LIST(resp),
-				      resp->veto_list_sz);
+		if (!ret)
+			ret = parse_veto_list(share,
+					      KSMBD_SHARE_CONFIG_VETO_LIST(resp),
+					      resp->veto_list_sz);
 		if (!ret && share->path) {
 			if (__ksmbd_override_fsids(work, share)) {
 				kill_share(share);
@@ -199,7 +208,7 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 				share->path = NULL;
 			}
 		}
-		if (ret || !share->name) {
+		if (ret) {
 			kill_share(share);
 			share = NULL;
 			goto out;
-- 
2.53.0

