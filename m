Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768C486629
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399838; cv=none; b=MKgt8xUJil9ZvwVlwugO83wjqde54TvbhOzzpO0jNztNNeSQQ5kKvOdL59EtuafkFsUYHcB9tOtHyYNfjsrk9unngrasr39yiBKZxYvJ9OTkq7x6jAEotO9VA96AVPR01jpJykJDLsCm8kspyKo0L2D5gg3d5pyYdX7KMX0Bfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399838; c=relaxed/simple;
	bh=VkFH+XvRdT+ti9etDCLTQevCW2HTEdkoMDMsaNelkUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7W1y1yozlG0D+WzSoWqEyX2f+ZlrQ5Jht6r/fqC/vdbC1rpnNgrEJVLACIob+Tg3dqEUe3GaZ1aMH3mBT9HPWPUmBqxEB3/qPAwTNG7K0+/UrB9YwNhGJS7uYhd5RwnevbrGxCN0WvVSH2wPsKgoKOPUzKDJTOw7DPbIm/Ba2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP30N90C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP30N90C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F11F00893;
	Mon, 14 Sep 2026 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399836;
	bh=B8gqlmLOqCjx0HfRouiRBtgDwaeYQIyRZ1gbSUWDpvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DP30N90CneHJQ0DzpdUcXkpldaPzMeJj0AFUcWEl3lD/v1pb6ZHrDvHOuTdMRQEHH
	 zJ4STwjvR7w9y/6DUjuc2Mn7sjN8wqQwinft1qjnZHM9hSXeSow2y6rGADmLhtI/Cn
	 13o/5HswIIf7EZCAMP3cikTzjIFv7GorKl3TsPnOxOiBEXlfwyHzK6XgtLSIRRzeB2
	 a5A8SCsdTcf9NA/Q3WgMf7iLqnMj4Zqn9+jYtC6W8s6mXeGgxZHLtR2p8wHTWnJO8d
	 WURh9NrJWf3dSFW1OCo8GM19reYLNCFzug6kiRZnZCpJWkMEAfgJCps2O19H0p1B2a
	 HQwPBxzny/maQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] ksmbd: use __GFP_RETRY_MAYFAIL
Date: Mon, 14 Sep 2026 11:30:30 -0400
Message-ID: <20260914153033.392874-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914153033.392874-1-sashal@kernel.org>
References: <2026091412-bottom-cadillac-a0fb@gregkh>
 <20260914153033.392874-1-sashal@kernel.org>
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

[ Stable dependency adaptation for f25e93768fcc5d8287e50b1ec52a42e4c276df34:
  Keep the default allocation mask and its uses in share_config.c and
  transport_ipc.c. Drop unrelated allocation conversions, including the
  hunks that require IDA, supplementary-group, RPC, interface, or durable
  handle code not present in this stable tree.

  Prepare the existing share-config path for the target by retaining path
  allocation failures and only parsing the veto list on success, as in
  a74668eb2c0b. Convert the existing IPC validator to a switch for its three
  supported request types; add the share-response header-length check and
  checked size addition needed by the target, from e9b33376bd07 and
  d6a6aa81eac2. Do not introduce extended-login support or new functions. ]

[ sashal: Reduced backport -- upstream 0066f623bce8f touches 24 file(s), this
  backport carries 3. Not backported here:
  fs/smb/server/asn1.c
  fs/smb/server/auth.c
  fs/smb/server/connection.c
  fs/smb/server/crypto_ctx.c
  fs/smb/server/ksmbd_work.c
  fs/smb/server/mgmt/ksmbd_ida.c
  fs/smb/server/mgmt/tree_connect.c
  fs/smb/server/mgmt/user_config.c
  ... and 13 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config responses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/glob.h              |  2 ++
 fs/smb/server/mgmt/share_config.c | 22 +++++++++++++---------
 fs/smb/server/transport_ipc.c     | 31 +++++++++++++++++++++++--------
 3 files changed, 38 insertions(+), 17 deletions(-)

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
index d8d03070ae44b..7f519a280188a 100644
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
@@ -150,14 +150,14 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
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
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
 		int path_len = PATH_MAX;
@@ -166,8 +166,11 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
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
@@ -179,9 +182,10 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
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
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index ed423d0ca99d6..5bf29431b4e48 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -13,6 +13,7 @@
 #include <net/genetlink.h>
 #include <linux/socket.h>
 #include <linux/workqueue.h>
+#include <linux/overflow.h>
 
 #include "vfs_cache.h"
 #include "transport_ipc.h"
@@ -230,7 +231,7 @@ static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 	struct ksmbd_ipc_msg *msg;
 	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvzalloc(msg_sz, GFP_KERNEL);
+	msg = kvzalloc(msg_sz, KSMBD_DEFAULT_GFP);
 	if (msg)
 		msg->sz = sz;
 	return msg;
@@ -276,7 +277,7 @@ static int handle_response(int type, void *payload, size_t sz)
 			continue;
 		}
 
-		entry->response = kvzalloc(sz, GFP_KERNEL);
+		entry->response = kvzalloc(sz, KSMBD_DEFAULT_GFP);
 		if (!entry->response) {
 			ret = -ENOMEM;
 			break;
@@ -446,7 +447,7 @@ static int ipc_msg_send(struct ksmbd_ipc_msg *msg)
 	if (!ksmbd_tools_pid)
 		return ret;
 
-	skb = genlmsg_new(msg->sz, GFP_KERNEL);
+	skb = genlmsg_new(msg->sz, KSMBD_DEFAULT_GFP);
 	if (!skb)
 		return -ENOMEM;
 
@@ -475,25 +476,39 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 {
 	unsigned int msg_sz = entry->msg_sz;
 
-	if (entry->type == KSMBD_EVENT_RPC_REQUEST) {
+	switch (entry->type) {
+	case KSMBD_EVENT_RPC_REQUEST:
+	{
 		struct ksmbd_rpc_command *resp = entry->response;
 
 		msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
-	} else if (entry->type == KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST) {
+		break;
+	}
+	case KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST:
+	{
 		struct ksmbd_spnego_authen_response *resp = entry->response;
 
 		msg_sz = sizeof(struct ksmbd_spnego_authen_response) +
 				resp->session_key_len + resp->spnego_blob_len;
-	} else if (entry->type == KSMBD_EVENT_SHARE_CONFIG_REQUEST) {
+		break;
+	}
+	case KSMBD_EVENT_SHARE_CONFIG_REQUEST:
+	{
 		struct ksmbd_share_config_response *resp = entry->response;
 
+		if (entry->msg_sz < sizeof(struct ksmbd_share_config_response))
+			return -EINVAL;
+
 		if (resp->payload_sz) {
 			if (resp->payload_sz < resp->veto_list_sz)
 				return -EINVAL;
 
-			msg_sz = sizeof(struct ksmbd_share_config_response) +
-					resp->payload_sz;
+			if (check_add_overflow(sizeof(struct ksmbd_share_config_response),
+					       resp->payload_sz, &msg_sz))
+				return -EINVAL;
 		}
+		break;
+	}
 	}
 
 	return entry->msg_sz != msg_sz ? -EINVAL : 0;
-- 
2.53.0

