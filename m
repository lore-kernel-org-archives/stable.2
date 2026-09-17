Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75D36E477
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607615; cv=none; b=eLrap1Mb//LscAqtRr5wmhhE7eCXngXqaLDqEsAfAZTjddAx9dH824iMflgu3enEBg6LdwdRT/+clG3SZHz6oPFrZqYyC46Bbn9VbYH0Sh2ws/8a+ttOmSiGRbuZtHHAJgJWGxnuWw1XcgC8O+Dc7rsgQdECaDWI9TG3z1DSDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607615; c=relaxed/simple;
	bh=FP0gLMowt1oH0T8XqFa8Vu1OzCBlsg5JFo4RITEs9b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX84PXvvRW6kcWJV8o7ohnSJxlI1thK+SbdCHXNQu7GCpKKU04nfnwUL7n0S5VkisYoroX5UmUJSL/p3882LLAIqcXYn8i0xl7D1dKrHMYD2Hqt1CC+zoJrSXYqLJT0zNVsJqDEXBY8WK89qQA4d2vWa/s8bRyKkYaiHla1JBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMJt6NRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMJt6NRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512A91F00899;
	Thu, 17 Sep 2026 01:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607611;
	bh=ZMjzuuSJCd069EzjUuy7fYVvkulUOmYo1vFyEfun1v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mMJt6NRBzomyPeOfZuSST9lSzjP0+JE2K/8faUMXOOICNyBv4UneL3iieBEPQRV/k
	 UWZ/x9199k0y8ZoI/OsP7SuXWcobtMPriM4Osn79nauk+iA35euUI7h5K1NeQBxDeu
	 sQAS8M+EOKgRujshBIyUwiUWXva4pzUbSYZ4Guz4EVVAVladGSfY4x94xVKae1I/UZ
	 dMLCXNdY20Ut1yDYn7IHv4OmUdUVb9btXiAdR0GBfd0f5V74x5d1ff4MuHiDEHbxiV
	 w3zJ4+GoTRO27OGJFOso/sNaGtcnisp5ojq562CgmMyc7CuTaZuZbcVlQfOmgmAX3+
	 3P8l5pT+tnELg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <xiang@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] erofs: add sysfs feature entry for xattr prefixes
Date: Wed, 16 Sep 2026 21:13:29 -0400
Message-ID: <20260917011329.3531603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091650-jump-debug-f4b3@gregkh>
References: <2026091650-jump-debug-f4b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit 839f075aabdf5c21048f9801b87c0b841dd3d064 ]

Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.

Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
Cc: stable@vger.kernel.org # 6.4+
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
[ adjusted feature-list context for missing 48bit and metabox entries while retaining zero_padding. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-erofs | 2 +-
 fs/erofs/sysfs.c                         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index d76de22b6ef31..2aecd4b83335d 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,7 +5,7 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		zero_padding, compr_cfgs, big_pcluster, chunked_file,
 		device_table, compr_head2, sb_chksum, ztailpacking,
-		dedupe, fragments.
+		dedupe, fragments, xattr_prefixes.
 
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 3fbce0864a66f..77ec8790927bf 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -81,6 +81,7 @@ EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
+EROFS_ATTR_FEATURE(xattr_prefixes);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -93,6 +94,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(ztailpacking),
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
+	ATTR_LIST(xattr_prefixes),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
-- 
2.53.0

