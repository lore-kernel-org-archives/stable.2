Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454293;
	b=kpq4VGjbiXmusdWld1OUON8jFM64V7w79gqqbykKiiqnxv+yBb2GGnCBCsoZZbQVp6Lf
	 brgbvdQlA2HplHOKYcnnGmyVfwdB/EFxsLaFd5ZB3Ts11VX3pMDu5mKIVSGUDCPGq6Jok
	 O/XA396GPqNRkBIeWbLAprH0vxrhKKlvBXQ1ND/BY0Z6+9FQTd7rbls1aseoJrCVOZdA1
	 DflUo1wpNOSMfgmTKdqYkEI03/EmML2r+GW6lqFy0O3yaeIAzrpMN66UxIa6EZ+haVJr5
	 JNvcMOlfzK8dIH/Ibh5qVJsv3uZ95qU0EbQdJPlIqLQ1y26oFru3kiohhb5B7+XvRRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ezehNQR5AhmzfIMyUmFOMdIqxDD8heKmFuN2zWiuWRk=;
	b=Ku1JWhsqumwXtAtixIutJyIPEOMxgjNh0CKMIBOVxzaX8rQESRt2qyWXae/dluf4ZL3f
	 02bgmJH3sVafEJ2tY+GTWO8vtteZS3gRxlNcOSOp6YgpVN6FhIhFAFidQFmvU4TQDZWU4
	 Ukqm8o5jZv8tE90ZheIK0C+dERXFf7qC8niit3Dz02jfXSrfRq7+SBb6UEwRMGtJ/J2/8
	 6dT1UndRNl+Q5JAzNGPIAfEM9AIlNvDDXIi3s4ELHTzkAFJFRPXUHz39vSYv7flqbTTJk
	 VMrY55a4q5rH/uiAE/xECRqUjXS1KusLWz5omhUEes96bDBbZWkgdxmpBFTe8/vDAJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fZLII/HY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC60606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZLII/HY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E431F1F00A05;
	Thu, 12 Nov 2026 03:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794454293;
	bh=ezehNQR5AhmzfIMyUmFOMdIqxDD8heKmFuN2zWiuWRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZLII/HYZHrC8NYp4MnCgNuuJNY+LjlWRF2+k1doqewm6FdtOD+SExmx8c9hYNOnv
	 bh32UZH+QtZara9B7O3zVis5T2uoFQcKo1cLmPLmxuEvEwORe/1rdyFwy4yT+KDqOn
	 pA7/l/mc8VC37qKXRCjtBEmMWg4/zm5/+u3c8Dl/RbZqbvQp7HXAy35EoFzM6nGDYc
	 tgGr0MhBKeklfY0pXenC30TVXoggxXf7xVoKZJs45op0/mRxXgI5eyQTBKBZQhhyhx
	 94WbAAsIHBQLnu7avo+Hubu+0gE2gn5oXryvP6Dy5ZJrM/milLPquiOSMQsGZQb33o
	 37bA80we62ztw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix to fetch ino via ino_of_node() under cache lock
Date: Wed, 11 Nov 2026 22:31:31 -0500
Message-ID: <20261112033110.1552460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062918-failed-5.10-cd6d8b189139@kernel.org>
References: <20261107062918-failed-5.10-cd6d8b189139@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit cd6d8b1891395b681f2060916a4b83880b765698 ]

In f2fs_writeback_node_caches(), it's better to fetch ino via ino_of_node()
under cache lock, otherwise, node cache content may become stale after cache
is unlocked due to racing w/ truncation.

Commit 493b9dc8b52c ("f2fs: cache: use node cache") fixes similar issue in
f2fs_flush_inline_data() introduced in commit 34c061ad85a2 ("f2fs: Avoid double
lock for cp_rwsem during checkpoint").

Cc: stable@kernel.org
Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Adapted node-cache operations in f2fs_writeback_node_caches() to page operations in f2fs_sync_node_pages(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1dddb65e249ad..b53100ee004fb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1958,9 +1958,11 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			/* flush inline_data */
 			if (is_inline_node(page)) {
+				nid_t ino = ino_of_node(page);
+
 				clear_inline_node(page);
 				unlock_page(page);
-				flush_inline_data(sbi, ino_of_node(page));
+				flush_inline_data(sbi, ino);
 				goto lock_node;
 			}
 
-- 
2.53.0

