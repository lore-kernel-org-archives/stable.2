Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389A3BBFC3
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476515; cv=none; b=crLc8uVinGcqyyKMK35dxd1W7GzIwbuRQdoQ8b5lklajLksj+EjPbVPlKwhzyqd5PRG5UpCj9bLIIL8+ZzgauW4ohkfAjQQw+svhDFGJTkpEMeLttNluYsRSTjFHNph+tnz192A3pNlCJjkaS7buravsraZU3mglxMw8hPPa2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476515; c=relaxed/simple;
	bh=3WNS/j8DOkullMQv/rtEYARImI1J863lTyB2wAwDeHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbsIDYKfKXwEG1sk+DvT1f5aTSfHAimJYTqJCg5WIwlhh2vtG1Z8tGJF6XRosvnw0j6vNGQn9/mV7kjB9OSkYP/BAQmlJbeO43TIOG1U02VLPZGA2/1eIHMGh9TP+ukjUWEpDcJIxYKKT0vEINRniMxUygtaPsQCbji/K6CGf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy/M9wwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy/M9wwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759DA1F000FF;
	Tue, 15 Sep 2026 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476513;
	bh=qNTFZEQSUqSFLvDFB4CRtMGPhuT1YinBLkhbB29RVT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jy/M9wwUM/eFzVe0SBgE0pvSydsBJLePwPXYQtIH6McIYzMCBhmcmPB+pughvJllN
	 XQ+4+V0xYj4EM+nnfYENQ/XdtIHZrggGd2MX0DEuU6uieviwXGc6UawpvKghP2k4iV
	 m6QfEzCtHBUKbmggxPNVLjiAfxoOwRJtc3TEK2gciBtH/GMiLnHx3BKMwI9MN+UNFH
	 wmXaj2F94Cr26Kph/cMSY602YFOs8fUHyHKBiEQYMCc45XEG4LTj8xk3/z/10a9Ccb
	 YyAwA3ye0JLUa2ErnesSgRZ4zCuDM2q126IYJ/MDvNsR4feCwB9fgm5b7Phhy8cwQh
	 nNu8EDz4I5wKw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: [PATCH 6.1.y] ksmbd: prevent out-of-bounds reads in share config responses
Date: Tue, 15 Sep 2026 21:48:06 +0900
Message-Id: <20260915124808.6052-4-linkinjeon@kernel.org>
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
 fs/smb/server/transport_ipc.c     | 24 ++++++++++++++-----
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index d8d03070ae44..7db7345f1af9 100644
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
 
-		p->pattern = kstrdup(veto_list, GFP_KERNEL);
+		p->pattern = kstrndup(veto_list, sz, GFP_KERNEL);
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
@@ -160,13 +163,27 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 	share->name = kstrdup(name, GFP_KERNEL);
 
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
-				      GFP_KERNEL);
+			if (resp->veto_list_sz)
+				path_len--;
+
+			if (!path_len) {
+				ret = -EINVAL;
+			} else {
+				share->path = kstrndup(
+					ksmbd_share_config_path(resp),
+					path_len, GFP_KERNEL);
+				if (!share->path)
+					ret = -ENOMEM;
+				else
+					ret = 0;
+			}
+		}
 		if (share->path) {
 			share->path_sz = strlen(share->path);
 			while (share->path_sz > 1 &&
@@ -179,7 +196,8 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
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
index ed423d0ca99d..89fae5e1886a 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -487,13 +487,25 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 	} else if (entry->type == KSMBD_EVENT_SHARE_CONFIG_REQUEST) {
 		struct ksmbd_share_config_response *resp = entry->response;
 
-		if (resp->payload_sz) {
-			if (resp->payload_sz < resp->veto_list_sz)
-				return -EINVAL;
+		if (entry->msg_sz < sizeof(struct ksmbd_share_config_response))
+			return -EINVAL;
+
+		if (strnlen(resp->share_name, sizeof(resp->share_name)) ==
+		    sizeof(resp->share_name))
+			return -EINVAL;
+
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
 
-			msg_sz = sizeof(struct ksmbd_share_config_response) +
-					resp->payload_sz;
-		}
 	}
 
 	return entry->msg_sz != msg_sz ? -EINVAL : 0;
-- 
2.34.1

