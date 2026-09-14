Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8F3AA4EF
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411439; cv=none; b=Va2mwGRkn5MBiU01s7eeHmgM9UmxMeWko5VCJOaenLK6HwD5lACU0ZVTGaTX4fy4hdFn9wg4hd95dh3ltqftUNTdJ35XEcU95fhyCpuFPJSnfcdxJN1WjpDUoJYV0k4qAXgLEPITltTvRpWfIagx1hp4dpQdkzt2uIZr67iFSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411439; c=relaxed/simple;
	bh=TEGRJ+l64A+zTv09YFwt/ONaWyjC8VPgOXfMQ5lISlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttJAWr27Lz7jSXUyKEdbbCag5Twq24zjhLk29YzAOOf/d/gjIv+3BqZxrQh46/fL74G1LcOWlYfkX/Wkp33I6wEHoaWaHdhmE9WZs/y9p6bBME8Zh8fdAY5gmRnL9l3ZCSh1dSTAU4DNiTAWausp5BzlUtpDDhFecVYbIHDmGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAyQoK2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAyQoK2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770A31F0089A;
	Mon, 14 Sep 2026 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789411436;
	bh=Gfqg4iDevTnbIBBrg/8MdseO/kl5THoldZCChzjm4ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TAyQoK2n2P3Pv0ClNCDYmW6Fv3dpEUId92z9CAN3iQCgSnAhypkTN1DgbAP1xX75y
	 kMz8mihViqwqHYKOIq4PnV2NmllL1rFOu3ntufGxUfxAaL2P7FajoGMp2HX9/4bqhA
	 VFqQBEFs0zU/LbCN2cOsYK1JQZB5TvJo2L5w73xHZ19AtN+DEowqcl0QSoD/b6lMug
	 g+z9jRNhDuAgy/RdcdcmMvH1fT1HiJeFzTIyh6DjwhEI51CoacqZc3QPCWDQou3XcW
	 EbFn+eVoVVqb0GGwbuYZfmLTR3kKxl9qJWzhWPmqTIp64tOrhWj431PmOgaDIvDBCw
	 QFt7LM7ysB5Ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] ksmbd: prevent out-of-bounds reads in share config responses
Date: Mon, 14 Sep 2026 14:43:50 -0400
Message-ID: <20260914184350.571525-5-sashal@kernel.org>
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
 fs/ksmbd/mgmt/share_config.c | 40 ++++++++++++++++++++++++------------
 fs/ksmbd/transport_ipc.c     | 21 ++++++++++++-------
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index bd31f4c75201e..695c9e78603a9 100644
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
 
-		p->pattern = kstrdup(veto_list, KSMBD_DEFAULT_GFP);
+		p->pattern = kstrndup(veto_list, sz, KSMBD_DEFAULT_GFP);
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
@@ -158,17 +161,28 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
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
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 15ec5d8bd776b..c4d7681679952 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -495,14 +495,21 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
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

