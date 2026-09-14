Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C853D413F
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394852; cv=none; b=gDQT1nHauEmgC6ZFKs4a6avvQrZaxfq4hj+HNd8FEvNGTG9ipgJ0bF2a2RbMQzDTqB1+Fj/HYwe5gU6BaQieVxT0d1aul4cbD7ZpoqY/w6g29YNurkE07UsAIaRRC9J++7ajoZOqfzqMp9npmAkQ2Ihw1KSy8nbqPEilyN4jS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394852; c=relaxed/simple;
	bh=xlMp4ClKjpyGIfqNfQUJyfG2f8b7hEzXAtx3S2U/xUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Up+YELvrumAoJgvVrNnvGrcrB4/xY/04v92oSK7cdk5ekEM1sbvqt4jjqhRSe9S5ro8/Wu1xqHgjxLMNs8bvZiu6tN0EXuwsEanVd4DwWSOkEjhFZ9N3l3+fOI45ysB4wak77FgMT297mkA4D2m/+k+PBMoVf7qU3tKiyeQ6g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE9QjEK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE9QjEK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA531F000FF;
	Mon, 14 Sep 2026 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394850;
	bh=mV3QtlxbqTUFB/qxTKylr5sSOkvyKVBFa7YasrWX+Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TE9QjEK1gHuAZw9Y/7FLr8HVDVe3q+F/MKK3GsUG7BTrVTEMpgpxukdCwnzpRufUm
	 LXoINyz07VyYWxgdHkulkrIeVER8p81JGTq3IenrgFSUKjrAmkAWzYMxwXYx5Aar5K
	 ZI/PXA2pR0K9syaf2+NDbSL7ohj8wNOGQwZL1D0T1ycZZF02FlyxzuUY/voas3kRyp
	 hZ+8nqx+vIwV3JnLe4F0mxSGRT64ThukOQyYOW7+u4XuV6zOYipmiTSGnF3AvUAdfx
	 EGAAzx0CMj8QGiwNssBeZ+Dookfz+m7vhX/kMJdm53ZZTD26koBeb2yZjaZfjoAGoG
	 J9v7BMm+9A99Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuhao Fu <sfual@cse.ust.hk>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ksmbd: fail share config requests when path allocation fails
Date: Mon, 14 Sep 2026 10:07:27 -0400
Message-ID: <20260914140728.52182-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091410-parole-marigold-985e@gregkh>
References: <2026091410-parole-marigold-985e@gregkh>
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
index 1e90fd30bd771..2099beb426f47 100644
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

