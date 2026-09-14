Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BFF449B2C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394852; cv=none; b=OrKnxeFZ1vh5aWS90KgZ7HU+Gjwxv5hZGnK122tYq/XpbLeqPD8UaaDIUDv1l8zgT+Lta/J4W59w+IpLJr3jyZc2hVuH29IhF3LBY3rk3LSETtf8neLlJv5xUVUJIQnoarG1z2cWj62y65RZ/qGPTT+kYogS390SvWast6bBrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394852; c=relaxed/simple;
	bh=O7LCf1ElwApOKCyRY9k3LQuLkP6dz8qZCbXDrNW+O9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI7dKVPwVq2gLMHd3QSmAjZXVOJ6kf/MBLOXl85sZXDM5SWh1teESad9yamh1iXCqPcTQRch0qg6U2BCg4Kkauyfmr9FPZn8fanj7vgHEdDfGLyr8QW61UQDVP8cisbXdLAC8TBTaR0FKYyJGCRG/kZ1GG5xSj5XvJUlagk8dTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIK1yThB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIK1yThB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D0A1F00898;
	Mon, 14 Sep 2026 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394851;
	bh=V1vGg7r4B9lDSgepWrDwNnsUBhfJAQQX4qe63vo5nzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YIK1yThB1qcjFHrp0s8C0QIkhX8RzbvvVQCjFzjm6CyFqOYFohiS0e3xgaCV0AQ0+
	 7oVpN8AeJH4pngby9gUme6r/y93V0pmzcU+6sXmKMJnU9Ahu+EP6Ytw/BHilthk75y
	 z8COf6cOr+UGVuyDqFODDLNGO4tPa1NuIShQWgrCAcuPnh1eCjfatjRvHQORWPw106
	 BCi30mEFEcnnEBK7IJm3c3fC4qFv4ElynJp7W2lG+ckKduwel9YFJfnvM6tm+AHud3
	 kv01eO0Mt0h6rVF0bEU1r7LWvzNqoA8Af0tPTAH9JYSnRgHBFpsygqQDoi25HIYq/F
	 4+6lMnmTs7yhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ksmbd: prevent out-of-bounds reads in share config responses
Date: Mon, 14 Sep 2026 10:07:28 -0400
Message-ID: <20260914140728.52182-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914140728.52182-1-sashal@kernel.org>
References: <2026091410-parole-marigold-985e@gregkh>
 <20260914140728.52182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit f25e93768fcc5d8287e50b1ec52a42e4c276df34 ]

Validate IPC share configuration payload sizes before consuming
variable-length fields. Bound veto list parsing and account for
the separator byte when deriving the path length.

Fixes: a677ebd8ca2f ("ksmbd: validate payload size in ipc response")
Reported-by: Kanishka De Silva <kpskanna1915@gmail.com>
Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/mgmt/share_config.c | 40 +++++++++++++++++++++----------
 fs/smb/server/transport_ipc.c     | 21 ++++++++++------
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index 2099beb426f47..632ce807775bb 100644
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
@@ -165,17 +168,28 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 	}
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
-		int path_len = PATH_MAX;
-
-		if (resp->payload_sz)
-			path_len = resp->payload_sz - resp->veto_list_sz;
+		size_t path_len;
 
-		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
-				      KSMBD_DEFAULT_GFP);
-		if (!share->path) {
-			ret = -ENOMEM;
+		if (resp->payload_sz <= resp->veto_list_sz) {
+			ret = -EINVAL;
 		} else {
-			ret = 0;
+			path_len = resp->payload_sz - resp->veto_list_sz;
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
+		if (share->path) {
 			share->path_sz = strlen(share->path);
 			while (share->path_sz > 1 &&
 			       share->path[share->path_sz - 1] == '/')
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 225f6459f3780..7c30b50f23f04 100644
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
2.53.0

