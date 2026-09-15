Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593C2F7EF5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476501; cv=none; b=YpQdetIjZtpIbP7gCLEja4E8mTQYnC5k73RtAlGCRVyOAGHorOCMKjLYKlXvYzbIyq84JewPLCuSyNRH8d4Jx0su5bfCN6/7blEOlEWHUmlpiZUvaaq2I1WGQx6zzC/b9PL5PrGR/gVlrvkcmAVT1BfVEfaKRfp746qvLA2+aCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476501; c=relaxed/simple;
	bh=3BOedPtGj4ElEXzzm96+6Pyo1VCdKv117UEBGZMCuRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Il5VecrAnSg60LpPgMUEL2d+fUkPCwy22zq8Tz+L3CCvAt4AfN58m8vQVLEaSs4neB572fQFr4LZY2SLgTbx3o+Rig2/p8lzanmE9KKsl3ERtRJnrziTIitE7yRpTZP0XAx91P+onRxXVmzOclO3EHm66lxWNEdDePxeb1V9DyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl3FPdLO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl3FPdLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1DA1F000FF;
	Tue, 15 Sep 2026 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476499;
	bh=P6nG0AwMLIw1VHygU3Hwxb7RFUOnws6dkQPjd0/NX+k=;
	h=From:To:Cc:Subject:Date;
	b=fl3FPdLO+BANmqSWmH+ylrt1K8CojMUXW2+xYOG+Qqz3V5ey09bgWyFETyNuUkaaI
	 0DY+W5tYCLOUyibhuR1lY5rLGVmTcjlY+uiqdUMjWSO1T6uAZgjsYit+DDkrg4RX0b
	 N3i9t4kdiqfOEvBaRb8mQ+PsVV50S4+vg+yJSC74vOOjkVSIVXr3tz7ayKxXvayceM
	 oXKv9jlSm9khDMbB0DsM+xhUcRSS508xUNj0I0bNuXgIL0HohTI6TUhMt9AwFqPa5/
	 minfyow82vfvIMS4Ru/d45eQ21drKp3aqT1O3hKroM557Xngbf5HhGQSEuiL/IqNGS
	 GvxX13H8qXBWA==
From: Namjae Jeon <linkinjeon@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: [PATCH 5.15.y] ksmbd: prevent out-of-bounds reads in share config responses
Date: Tue, 15 Sep 2026 21:48:03 +0900
Message-Id: <20260915124808.6052-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
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
 fs/ksmbd/mgmt/share_config.c | 38 ++++++++++++++++++++++++++----------
 fs/ksmbd/transport_ipc.c     | 24 +++++++++++++++++------
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index e0a6b758094f..5e9959361239 100644
--- a/fs/ksmbd/mgmt/share_config.c
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -87,9 +87,9 @@ static struct ksmbd_share_config *__share_lookup(const char *name)
 
 static int parse_veto_list(struct ksmbd_share_config *share,
 			   char *veto_list,
-			   int veto_list_sz)
+			   size_t veto_list_sz)
 {
-	int sz = 0;
+	size_t sz;
 
 	if (!veto_list_sz)
 		return 0;
@@ -97,7 +97,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 	while (veto_list_sz > 0) {
 		struct ksmbd_veto_pattern *p;
 
-		sz = strlen(veto_list);
+		sz = strnlen(veto_list, veto_list_sz);
 		if (!sz)
 			break;
 
@@ -105,7 +105,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 		if (!p)
 			return -ENOMEM;
 
-		p->pattern = kstrdup(veto_list, GFP_KERNEL);
+		p->pattern = kstrndup(veto_list, sz, GFP_KERNEL);
 		if (!p->pattern) {
 			kfree(p);
 			return -ENOMEM;
@@ -113,6 +113,9 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 
 		list_add(&p->list, &share->veto_list);
 
+		if (sz == veto_list_sz)
+			break;
+
 		veto_list += sz + 1;
 		veto_list_sz -= (sz + 1);
 	}
@@ -158,13 +161,27 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
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
@@ -177,7 +194,8 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 		share->force_directory_mode = resp->force_directory_mode;
 		share->force_uid = resp->force_uid;
 		share->force_gid = resp->force_gid;
-		ret = parse_veto_list(share,
+		if (!ret)
+			ret = parse_veto_list(share,
 				      KSMBD_SHARE_CONFIG_VETO_LIST(resp),
 				      resp->veto_list_sz);
 		if (!ret && share->path) {
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 7e6003c6cd9b..9d7b21257bca 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -475,13 +475,25 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
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

