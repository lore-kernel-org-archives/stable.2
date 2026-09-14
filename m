Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CD486629
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399840; cv=none; b=F+9xpzyUK8U/2Qtc7A19L615SAvv4bDvEhFM7tWJ8YbvjjyqNJQWihoQOMkLne/nIs66MdRg7eWGorF55hsyURScRWC0bUscN57JbmMDKsh5bMFIcqOPAyzbjLxE91mVnGb9/T8kDoZjG4he7V9SIbDRDYZydo67UrZmWrOsuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399840; c=relaxed/simple;
	bh=nKeb7J1BLhEDNDmY16lcHv18ybXYEB3PRx8BeuT4y8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDJlTVkEkOrWDBh2ybLATomlHQdKINB0tml7d2SZ757DhL8D0r6lkLCaADSkX4ssTq2p2++s9l6euUzRc/Gur8hI0M8Jl8/l7JGSXIBHprFLnt3WvPLI2a2epC7TZGEkxPUb/XSj1KgncIG0igMaDl2fxwpHv4/Hj1inDp4m2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoYa+PHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoYa+PHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E3C1F0089C;
	Mon, 14 Sep 2026 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399839;
	bh=GKU680bx3WkpMB11ACvzT8vCmgrtUVYA9fmEnYlLLt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QoYa+PHwIdvP5bPwYfLBphJdDeb2bEa3zdcBCrOPRD+EUlBDBFf8zCl6RJulryNxd
	 XBAS9wyrUWP2V4wxvOSv46P3zc+QaJciFiqcSDEvub55kN45ggKAlhtLs7AJQ24E3m
	 sVc032gPc2oRTHtbVsnOG6zhW3OG3I769uzuJ2/lb1dZLOVPw0yJiv5aou4mRcLlFA
	 6H/R/9jpcI0Y9vIfWIiJEmGQduzDf210v9/AOhfeDOdsFopv0CGPEWf0pJGuZHbPza
	 KYWgMkoGpCV/uE84CyEsMlRPg75zyJdjW/4Ta1SGBU0A00juzHgZNO7hYevFz7hqIa
	 dV55iDSh9IznQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] ksmbd: prevent out-of-bounds reads in share config responses
Date: Mon, 14 Sep 2026 11:30:33 -0400
Message-ID: <20260914153033.392874-5-sashal@kernel.org>
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
index 7f519a280188a..7c6e023abe2ed 100644
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
@@ -160,17 +163,28 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 	share->name = kstrdup(name, KSMBD_DEFAULT_GFP);
 
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
index 9edd598105c4f..c02aaa549c357 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -507,14 +507,21 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
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
 	}
-- 
2.53.0

