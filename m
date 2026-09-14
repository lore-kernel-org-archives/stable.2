Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C447B42F
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395354; cv=none; b=K7EEi5lh7F+X+pSBSnTc6q1PT9dy0yYUlDIaNkpUIqI6Kj7qgqoh2P9subtTy8SOxLRgffb+AYnfPBCHp4NYvUf52PVYOLqAVdCwLxNcPLxzOd+5ZjzGsETGTx+0HMtIDNcKoAE2FR0BYdCxAAbRz0LjHDHanOO+3JCFPMKNp/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395354; c=relaxed/simple;
	bh=/qa6obdyKpfGQwFSSsXkfUHTD+fehjY+5mrwW3OVTMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Si/CTLHna+WOdPKQx9tRulzwMJE2aVuq3D9MGoHetjcz9L+id7dd3f43h56yD98VcRMin6D5bK0R6fU8W+7ylBAi7inFxJf5fbQWjd+gpG4q8eAS01jDloJiqYSAJe/b3wLfY1hf4ka+ZVaYnav8PMVx4M2btWbk0mhmOnlBzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSRtfI6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSRtfI6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC7A1F000FF;
	Mon, 14 Sep 2026 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395353;
	bh=FW4XdjfAzIrhID5SRjdJjT5VhxHYWdN9qNqOSc3PSE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CSRtfI6usRBW6S+Sa+imHvrMqgV4Aw/tKdSnjiU51cq1CZOLk1hKs+OdSJ4hXw+Vk
	 HxUzF6Sm7ru2JhSlhCSYT8kUrsDfrSyOU/yyJ0545FafmmpKsh+/+LT8++PcSLxChE
	 CRvKGVRMJk2ocGEyURJB/UnjufQ5KbDnTqa7ToaZp2YUVQd7h0lrdSzTfuTiqEtLep
	 wnXFf3F5PuiUTQNBVaGTPwoduDHSXzUzI9EPnm+WxZ2pyNJcIUPoIpzgArnjoSB5AG
	 zvQBqOhDXJem6qNvU5AbXM1OkFvQr7heMUs4sqyt3T5Xis1bFWV2c73DLYCn2aJ9G+
	 A7dOShy/lhndg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuhao Fu <sfual@cse.ust.hk>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ksmbd: fail share config requests when path allocation fails
Date: Mon, 14 Sep 2026 10:15:50 -0400
Message-ID: <20260914141551.61407-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091411-perish-luster-7e07@gregkh>
References: <2026091411-perish-luster-7e07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuhao Fu <sfual@cse.ust.hk>

[ Upstream commit a74668eb2c0b866d7ac4823be6006ab2e227bc03 ]

Non-pipe shares must have a duplicated backing path before they can be
published. share_config_request() currently calls kstrndup() for that
path, but if the allocation fails it leaves ret unchanged. If veto list
parsing succeeds and share->name exists, the partially built share is
still inserted into the global share table with share->path left NULL.

A later share-root SMB2 create uses tree_conn->share_conf->path as the
lookup root. If the share was published with path == NULL, that request
passes a NULL pathname into do_getname_kernel()/strlen() and can crash
the ksmbd worker.

Set ret = -ENOMEM when path duplication fails so the incomplete share is
destroyed before publication.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config responses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/mgmt/share_config.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index 4a5bc3c144284..97b0bbd619979 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -172,7 +172,10 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 
 		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
 				      KSMBD_DEFAULT_GFP);
-		if (share->path) {
+		if (!share->path) {
+			ret = -ENOMEM;
+		} else {
+			ret = 0;
 			share->path_sz = strlen(share->path);
 			while (share->path_sz > 1 &&
 			       share->path[share->path_sz - 1] == '/')
@@ -184,9 +187,10 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
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
-- 
2.53.0

