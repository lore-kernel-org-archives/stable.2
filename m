Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128C3D8103
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383806; cv=none; b=dUsuQLDpXXOOdlwp+Ol487vbgiQB8yQKiZk/Qjpt4/PE4sLP3zU1tfdO6nr55kGpCOIAbvShhWT6HYQj6eBIfMftcRVh6oNRYJ1dxtQjfPq+CJW8/5I8tb3P3y1p7ZGpzLp0kbPgCOlPZmYBJJEkjauDl9Y8HuNn1JHsua7WQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383806; c=relaxed/simple;
	bh=rBZY85RruDJtgKLrLUpgAV4fIqoAo+Wdj6L1V7n3F1c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fUzI/aeOdAN6R0NdMFpwFKAiFDuBu0+ILWNUzmRbZPkgczbgHYMC5IqjObrDLc+pMnafm4A7CyWSPLsybnjrqi4+6hDSyQLkajAgU9DDW//usQDbcSDr4BOyGt5Jh7eaezrExkSnJyVrK1qc/HemMAlVZI/n8CaKwXrR9nNXtMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LbJ4Q68Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LbJ4Q68Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE14E1F0089C;
	Mon, 14 Sep 2026 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789383803;
	bh=WoPP1QCzrVMx8NVXUxbmzWrEndtX24A6h2u4qNeOVBM=;
	h=Subject:To:Cc:From:Date;
	b=LbJ4Q68YjJb7O9Bk1IjqidrIBUIon8FWlBKDxtmJBm3hmF1b+x0n37WVHitrvQ7+q
	 qUxArS0URvYs1PWksThC048/8qIX/SxXPC6x78s5HyHrlEq3JHN5pp/GXTULXb/2/C
	 cFygH00IawlXl8mA/AdAr8KHi6yMZSTO5wFn2nGU=
Subject: FAILED: patch "[PATCH] ksmbd: prevent out-of-bounds reads in share config responses" failed to apply to 6.12-stable tree
To: linkinjeon@kernel.org,farhad.alemi@berkeley.edu,kpskanna1915@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Sep 2026 13:03:11 +0200
Message-ID: <2026091411-perish-luster-7e07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f25e93768fcc5d8287e50b1ec52a42e4c276df34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091411-perish-luster-7e07@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f25e93768fcc5d8287e50b1ec52a42e4c276df34 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Aug 2026 08:39:57 +0900
Subject: [PATCH] ksmbd: prevent out-of-bounds reads in share config responses

Validate IPC share configuration payload sizes before consuming
variable-length fields. Bound veto list parsing and account for
the separator byte when deriving the path length.

Fixes: a677ebd8ca2f ("ksmbd: validate payload size in ipc response")
Reported-by: Kanishka De Silva <kpskanna1915@gmail.com>
Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index b2d9580bddc6..cc9f18ede80d 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -146,9 +146,9 @@ static struct ksmbd_share_config *__share_lookup(const char *name)
 
 static int parse_veto_list(struct ksmbd_share_config *share,
 			   char *veto_list,
-			   int veto_list_sz)
+			   size_t veto_list_sz)
 {
-	int sz = 0;
+	size_t sz;
 
 	if (!veto_list_sz)
 		return 0;
@@ -156,7 +156,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 	while (veto_list_sz > 0) {
 		struct ksmbd_veto_pattern *p;
 
-		sz = strlen(veto_list);
+		sz = strnlen(veto_list, veto_list_sz);
 		if (!sz)
 			break;
 
@@ -164,7 +164,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 		if (!p)
 			return -ENOMEM;
 
-		p->pattern = kstrdup(veto_list, KSMBD_DEFAULT_GFP);
+		p->pattern = kstrndup(veto_list, sz, KSMBD_DEFAULT_GFP);
 		if (!p->pattern) {
 			kfree(p);
 			return -ENOMEM;
@@ -172,6 +172,9 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 
 		list_add(&p->list, &share->veto_list);
 
+		if (sz == veto_list_sz)
+			break;
+
 		veto_list += sz + 1;
 		veto_list_sz -= (sz + 1);
 	}
@@ -224,17 +227,28 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 	}
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
-		int path_len = PATH_MAX;
+		size_t path_len;
 
-		if (resp->payload_sz)
-			path_len = resp->payload_sz - resp->veto_list_sz;
-
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
index 4b0b572a3e1b..e550aa41ad2c 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -532,14 +532,21 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
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

