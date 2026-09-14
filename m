Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCF3A6F1C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411436; cv=none; b=h6wjB3pG3n9px9WO724+Y7RCd6aO+FCvE9BCu/isGmFv5yjwf4CTR0rIxih5/dLAN5OxSOdjBxkM+vzOe3bSKCYXYB+tNdvN9re7ljMCy5Q34kRyKRidVk6sxmeHGUooncMkoNvLSzTkn8HQP94OHRLun8n6orw6KWFfEUrXTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411436; c=relaxed/simple;
	bh=oO3CKt/8/HjdLq6yp7E56Wvll6wrFyFB1qXSWgiyzE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JW0No7TTethnjMZFKYz1InNb6XbIstqkR/v7z64RUGqfE7vwCLh+l3BQViGFZ5qQDbdp6Galw+PIK2zFWWjlMarLw8GRhWmqS8wIhEiJvE31nGLfSQiIoucJVcsyQnQAeU1hxMXuU2vR+/82jtMyEiTIGgN9CxPB/YMhQEQpGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD2Yz1rV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD2Yz1rV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E35B1F00899;
	Mon, 14 Sep 2026 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789411433;
	bh=lnRB+n11LFDtvurSayleZByeKa4sXoYBUw4ODWdPfB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RD2Yz1rVsFNXcPY2tYLTiHJPwg1VyLhTUjYCPfDnv9igsA1JLUBiMe5wpWPIgrxC6
	 nWzZqqFl0MbPrE8qDvJYsUT8dFm7xxrYl0DQPv1y+U6Fo7iQTzr5QJc3j/nB4gR3Ly
	 3AJHYYIE6J7b0t4TyUJEIrxyTrDrtAPMWZQuBmYal6rEA1hWdqxafIEkea0IhX/LdN
	 XjblzfJ7kxfI7DEJ50Hd3jjTwhPWhNhmmqJYmdOhHhwqmBilr42vhEIIvdImat7P9n
	 DnsXjigR8Q/tyHyCIoeNgWrGmBUha2XHBwRdjPRrmsSlTvjUYjFj+82lkQaTUQC/Uv
	 KcIqq2nwxjUsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] ksmbd: use __GFP_RETRY_MAYFAIL
Date: Mon, 14 Sep 2026 14:43:47 -0400
Message-ID: <20260914184350.571525-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914184350.571525-1-sashal@kernel.org>
References: <2026091413-gills-macarena-de56@gregkh>
 <20260914184350.571525-1-sashal@kernel.org>
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
 fs/ksmbd/glob.h              |  2 ++
 fs/ksmbd/mgmt/share_config.c | 22 +++++++++++++---------
 fs/ksmbd/transport_ipc.c     | 31 +++++++++++++++++++++++--------
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/fs/ksmbd/glob.h b/fs/ksmbd/glob.h
index 5b8f3e0ebdb36..3ce12b60e46fe 100644
--- a/fs/ksmbd/glob.h
+++ b/fs/ksmbd/glob.h
@@ -46,4 +46,6 @@ extern int ksmbd_debug_types;
 
 #define UNICODE_LEN(x)		((x) * 2)
 
+#define KSMBD_DEFAULT_GFP	(GFP_KERNEL | __GFP_RETRY_MAYFAIL)
+
 #endif /* __KSMBD_GLOB_H */
diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index e0a6b758094fc..bd31f4c75201e 100644
--- a/fs/ksmbd/mgmt/share_config.c
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -101,11 +101,11 @@ static int parse_veto_list(struct ksmbd_share_config *share,
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
@@ -148,14 +148,14 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
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
@@ -164,8 +164,11 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
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
@@ -177,9 +180,10 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
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
 			ret = kern_path(share->path, 0, &share->vfs_path);
 			if (ret) {
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 7e6003c6cd9bf..272f8f0b3a40a 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -13,6 +13,7 @@
 #include <net/genetlink.h>
 #include <linux/socket.h>
 #include <linux/workqueue.h>
+#include <linux/overflow.h>
 
 #include "vfs_cache.h"
 #include "transport_ipc.h"
@@ -229,7 +230,7 @@ static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 	struct ksmbd_ipc_msg *msg;
 	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvzalloc(msg_sz, GFP_KERNEL);
+	msg = kvzalloc(msg_sz, KSMBD_DEFAULT_GFP);
 	if (msg)
 		msg->sz = sz;
 	return msg;
@@ -268,7 +269,7 @@ static int handle_response(int type, void *payload, size_t sz)
 			       entry->type + 1, type);
 		}
 
-		entry->response = kvzalloc(sz, GFP_KERNEL);
+		entry->response = kvzalloc(sz, KSMBD_DEFAULT_GFP);
 		if (!entry->response) {
 			ret = -ENOMEM;
 			break;
@@ -434,7 +435,7 @@ static int ipc_msg_send(struct ksmbd_ipc_msg *msg)
 	if (!ksmbd_tools_pid)
 		return ret;
 
-	skb = genlmsg_new(msg->sz, GFP_KERNEL);
+	skb = genlmsg_new(msg->sz, KSMBD_DEFAULT_GFP);
 	if (!skb)
 		return -ENOMEM;
 
@@ -463,25 +464,39 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
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

