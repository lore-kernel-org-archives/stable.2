Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01F37DE99
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219299; cv=none; b=IQjLtJ/xUMCQiOnieFAZ4KtE94+BzDkVsPTvTdzxK5HpFWmBUsy9egb25sbWjiBB6QuDkIoZ4xJfJXwa3n//cSiiXCvjBDMgeoN10ofbkRIZz8M/md0eUQA2T0SlRbhYOL1bZffdfs3inosPNewvbCr9fYN5bxjxUXUJQfUfHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219299; c=relaxed/simple;
	bh=2/uXOnhrAIDBd0pR0uCC4qBwLL5LhAtCf2gIE/QuvwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk0BJdrEIyhdldA9i9dwx2NKVV2FOfO9CcIhR4mdPP4w8aGgeWiRnpCpOJF49pM1qec2adsGRSslgWYVQogTdO2OsNRn4jXs8QCzf7wIl51bHyF1BXkmOsM6iT8CpFZxiBas6ze0f9skt5eCgRzFqgdw2L3M0f3Uxg7E5V6SGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8cOAveW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8cOAveW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D2E1F00A3D;
	Thu, 16 Jul 2026 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219297;
	bh=KlHOu4B7KMbnqQVHTQmbcfMdlzlVws4PvHWN4U3tb0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8cOAveWp0jxEOqOArntelxjoldndlenRunh/hLraWwxz4xCgRhEr48UtAvB2eOD0
	 S3CIrkAFTfI9YZLi62tSNW020qvJrHXN6zGycrkWzK5cK4jHrZsgtAVnq9rYmRfAvw
	 +ndkKDd/sUVG+CvAnLY8umhxw1kzMHqzex7FbVWLYTy7W9oux0vOIN/pIM8nsBOkw7
	 RviicUOU4r4W35UT/21DLtYTS9pkgzB51RE2tM9ITqx0DHwe4l75BRfu4OPQ+fST9R
	 nKUQ7/pfJmEyQEjeRPCoWUv1stkcB/odXdOi3LYnSsJe/5hIGRSj0Zu5nl0ct79bJY
	 c8OtOWzpsvl0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <xizh2024@lzu.edu.cn>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: harden POSIX SID length parsing
Date: Thu, 16 Jul 2026 12:28:12 -0400
Message-ID: <20260716162812.635414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071425-undertone-protozoan-2d33@gregkh>
References: <2026071425-undertone-protozoan-2d33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

[ Upstream commit 7ad2bcf2441430bb2e918fb3ef9a90d775a6e422 ]

posix_info_sid_size() reads sid[1] to obtain the subauthority count,
but its existing boundary check still accepts buffers with only one
remaining byte. Require two bytes before reading sid[1] so all client
paths that reuse the helper reject truncated POSIX SIDs safely.

Fixes: 349e13ad30b4 ("cifs: add smb2 POSIX info level")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 4197096e7fdbcc..5c071089c7424f 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4520,7 +4520,7 @@ int posix_info_sid_size(const void *beg, const void *end)
 	size_t subauth;
 	int total;
 
-	if (beg + 1 > end)
+	if (beg + 2 > end)
 		return -1;
 
 	subauth = *(u8 *)(beg+1);
-- 
2.53.0

