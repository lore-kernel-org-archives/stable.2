Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A63D9529
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383815; cv=none; b=VajOpcBVp4dfoVhksJuq7HMCphJDy904bc76xjBaaK83B40zd7bPL/tta1bYm/gtCk6DaPYIYIWei4Fzs+cZUkB9FCvXOorpcG3S3FVJuslNuYJXHze8gbGpE4oRvbucWIJR3VYhblMfCAlbS9YC2zyyNpTYEfPzmOBqHxlL6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383815; c=relaxed/simple;
	bh=Wom84cRAyx93HwOBACRK0Xk5eSQohGljUcfHDsPJrnw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ol7i0x0fQau0E6JksRI6r9PFgodKwO0y5zQcoVZDDgEyVG0FtWSr35X3AeeYUu/yU8P5eA3vb2Ai0bCbD0IjtzAw5yCiYvppOcoGYqpNhQHbiVb3nbIkL/B1+M0eZ8ih/lrggmSHRQTvqADqzE9/m9gHhHLzKqVxC+5mD39fltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bQVVlB5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bQVVlB5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACCA1F000FF;
	Mon, 14 Sep 2026 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789383812;
	bh=NF3eApgsjTlHpV3dhj232diDrITJpPXuLzvPADO2qxw=;
	h=Subject:To:Cc:From:Date;
	b=bQVVlB5vxIPMZZBXt0aT1GLJ88rq4lQPku3gecdJQXbdW7OrSW71tylKssDQjdbMi
	 kScxUGxXILFQsyG8RVP0sAnW2GqgigwEqm0nKJ5IVUuPKQQZLhFs8ubfRgjlSdrkVO
	 Q/iVbMpi/HfbdCoyb6KRBSZDxND1y2XjcbzD/6xk=
Subject: FAILED: patch "[PATCH] ksmbd: prevent out-of-bounds reads in share config responses" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,farhad.alemi@berkeley.edu,kpskanna1915@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Sep 2026 13:03:13 +0200
Message-ID: <2026091413-gills-macarena-de56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f25e93768fcc5d8287e50b1ec52a42e4c276df34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091413-gills-macarena-de56@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

