Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEC3BB126
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476512; cv=none; b=X5UhAG46h7C5IBVgIWA5EvG3Vndtcqsca9u6tI/Y8NA163ApcjZVKS1LwYtJzE+Qt7bIDE96nPZEOoI836ULtYiMwoPKPYxkCtGT3Ncvyp50j+vSN20SSUfKHRjNSVYw+A+4WryDzTLHrK+WDbwTaw7KmTmd9fFs2ShkK/7tvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476512; c=relaxed/simple;
	bh=G6SPaP8N664mlxej6ynSmb7FI9nGnGd3GQk2ofVcpiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGB496F+f9YLPTwnYLvEsVj+obp4+ltIwLMU/eqMtUD/t2V4w5o0ynkC3ixLhtuH8jFclM4U/B+IYF4UzxJo1knWSGJAmrbKh8zq9y0yDkYrUvJpDijBaqvCpfG6auWFoP2oxP+Fjy5BGez3Dv3azKuKvvgmPwKrbYaqslEZ5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyGJ2VBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyGJ2VBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C481F00893;
	Tue, 15 Sep 2026 12:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476511;
	bh=ByDyyyjB7/WNvEPhSp5HsvWbNGJh9fGN/4LGbn+za+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyGJ2VBLTU2Fxa2HRM3qG8SLJLkUK/nf95hsY0r8hEYOlMdmAoxAlyLSsDi8ZMTdZ
	 gecrZj4KUEkVY2pgd/lkAENmYnl+/theT0Z8K/zWfS85aVescS+JLtVuk0flf0pQf+
	 dj3mq6gsO6rMxHAIJCfZz3pG2v48GVcBf2pGALEB6sWEfaAUtqq2U0feb/bpxEGPHS
	 h7KPRpbH/ut6fh9C7PK/48w91FRTNOzQnBcI149RpcW9JEDWPvNdNn5j/3DkZur/Ul
	 jz9LN5LwyAvM899Qx5gfhKBv/pzk0y9xD+9p3kXCbN6v1m+TerbX6QfFnoTklL2K8s
	 9t/iSWbCtHdAw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: [PATCH 6.18.y] ksmbd: prevent out-of-bounds reads in share config responses
Date: Tue, 15 Sep 2026 21:48:05 +0900
Message-Id: <20260915124808.6052-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915124808.6052-1-linkinjeon@kernel.org>
References: <20260915124808.6052-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit f25e93768fcc5d8287e50b1ec52a42e4c276df34 ]

Validate IPC share configuration payload sizes before consuming
variable-length fields. Bound veto list parsing and account for
the separator byte when deriving the path length.

Fixes: a677ebd8ca2f ("ksmbd: validate payload size in ipc response")
Reported-by: Kanishka De Silva <kpskanna1915@gmail.com>
Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/mgmt/share_config.c | 38 +++++++++++++++++++++++--------
 fs/smb/server/transport_ipc.c     | 21 +++++++++++------
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index 1e90fd30bd77..8813a81ca662 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -88,9 +88,9 @@ static struct ksmbd_share_config *__share_lookup(const char *name)
 
 static int parse_veto_list(struct ksmbd_share_config *share,
 			   char *veto_list,
-			   int veto_list_sz)
+			   size_t veto_list_sz)
 {
-	int sz = 0;
+	size_t sz;
 
 	if (!veto_list_sz)
 		return 0;
@@ -98,7 +98,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 	while (veto_list_sz > 0) {
 		struct ksmbd_veto_pattern *p;
 
-		sz = strlen(veto_list);
+		sz = strnlen(veto_list, veto_list_sz);
 		if (!sz)
 			break;
 
@@ -106,7 +106,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 		if (!p)
 			return -ENOMEM;
 
-		p->pattern = kstrdup(veto_list, KSMBD_DEFAULT_GFP);
+		p->pattern = kstrndup(veto_list, sz, KSMBD_DEFAULT_GFP);
 		if (!p->pattern) {
 			kfree(p);
 			return -ENOMEM;
@@ -114,6 +114,9 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 
 		list_add(&p->list, &share->veto_list);
 
+		if (sz == veto_list_sz)
+			break;
+
 		veto_list += sz + 1;
 		veto_list_sz -= (sz + 1);
 	}
@@ -165,13 +168,27 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 	}
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
-		int path_len = PATH_MAX;
+		size_t path_len;
 
-		if (resp->payload_sz)
+		if (resp->payload_sz <= resp->veto_list_sz) {
+			ret = -EINVAL;
+		} else {
 			path_len = resp->payload_sz - resp->veto_list_sz;
-
-		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
-				      KSMBD_DEFAULT_GFP);
+			if (resp->veto_list_sz)
+				path_len--;
+
+			if (!path_len) {
+				ret = -EINVAL;
+			} else {
+				share->path = kstrndup(
+					ksmbd_share_config_path(resp),
+					path_len, KSMBD_DEFAULT_GFP);
+				if (!share->path)
+					ret = -ENOMEM;
+				else
+					ret = 0;
+			}
+		}
 		if (share->path) {
 			share->path_sz = strlen(share->path);
 			while (share->path_sz > 1 &&
@@ -184,7 +201,8 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 		share->force_directory_mode = resp->force_directory_mode;
 		share->force_uid = resp->force_uid;
 		share->force_gid = resp->force_gid;
-		ret = parse_veto_list(share,
+		if (!ret)
+			ret = parse_veto_list(share,
 				      KSMBD_SHARE_CONFIG_VETO_LIST(resp),
 				      resp->veto_list_sz);
 		if (!ret && share->path) {
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 225f6459f378..7c30b50f23f0 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -524,14 +524,21 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 		if (entry->msg_sz < sizeof(struct ksmbd_share_config_response))
 			return -EINVAL;
 
-		if (resp->payload_sz) {
-			if (resp->payload_sz < resp->veto_list_sz)
-				return -EINVAL;
+		if (strnlen(resp->share_name, sizeof(resp->share_name)) ==
+		    sizeof(resp->share_name))
+			return -EINVAL;
 
-			if (check_add_overflow(sizeof(struct ksmbd_share_config_response),
-					       resp->payload_sz, &msg_sz))
-				return -EINVAL;
-		}
+		if (resp->veto_list_sz > resp->payload_sz)
+			return -EINVAL;
+
+		if (resp->flags != KSMBD_SHARE_FLAG_INVALID &&
+		    !(resp->flags & KSMBD_SHARE_FLAG_PIPE) &&
+		    resp->payload_sz <= resp->veto_list_sz)
+			return -EINVAL;
+
+		if (check_add_overflow(sizeof(struct ksmbd_share_config_response),
+				       resp->payload_sz, &msg_sz))
+			return -EINVAL;
 		break;
 	}
 	case KSMBD_EVENT_LOGIN_REQUEST_EXT:
-- 
2.34.1

