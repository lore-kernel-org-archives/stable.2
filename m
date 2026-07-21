Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED42377AA6
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634467; cv=none; b=Rxb79TNjFRGMW3JUkip5qi012Od/iskdSGRIe5ss1IT5spKA35EWgHvO8Y/RO3zvfmxumKl0Ib2Xh64Cuf3K/l7dXiQRM2w+t16i4MhLCWd4Fw4yCp//TsyWBtaWYEGRwPAzUM1ij6nef4eOwy723ZpZYkXthjGD2Zz/WGuLM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634467; c=relaxed/simple;
	bh=IYIxOWGOM0YGPum+NpfJa588riqhp47+mhhxHzN5pRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjgv2h9/qKsLBMpoGCT8t5JDUPOSqMIGuM2QOf63WVm7rOnWpOReNHQoEJpHqd3p0bNLUBOIAB1EMZV2fX4LKoAGAqa/RSLEl1D2n58mx+ZtXZIiVLHcIhxAJb8mkvQuZeX8f++cO9nW+M1PuZvVjhQsx3pYWEswAWvIA7gqEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js6lUjp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js6lUjp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A771F00A3A;
	Tue, 21 Jul 2026 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634466;
	bh=Bl+Cmww4IlRe5gYuRJyfyVkt/zTCcUDYbawxVfx38ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Js6lUjp017jUoO2jQ1Bho9JKr789ZBteq+G1dGAPXAvUNsdcKjzCzW1DzJODTred5
	 Tnt+Gh4mkrHYRzYt+2ERc9PyP7Ic7ww8fwdi0TiwG8I6KEJUbMPnGJ2Vqh3z8lXRDB
	 e2S0kXhSOLNM1XYz8kxeuTBSB9Ah/5P5B3I6fbXIHw7OIz171wJHpdwBVO/dMbpWQj
	 M+sUtKZ9FWvyqJxAAVykfcJb5K4LZ3kBMGQwRlxw3t9/Il+g6qkL6aYCBOyGzyBcBf
	 6R317Zb6ckBkK+H1iXZRUtbAow+Yhn+iFmkGiX1EZ+IVQMHhyVimy4d50+ZOfGmBHr
	 Sa+XnzitBnaFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Andy Wu <Andy.Wu@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] exfat: move free cluster out of exfat_init_ext_entry()
Date: Tue, 21 Jul 2026 07:47:38 -0400
Message-ID: <20260721114743.3689685-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071545-counting-slander-c4c4@gregkh>
References: <2026071545-counting-slander-c4c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit 4e1aa22fea106014397455506d1383d519c4d3d1 ]

exfat_init_ext_entry() is an init function, it's a bit strange
to free cluster in it. And the argument 'inode' will be removed
from exfat_init_ext_entry(). So this commit changes to free the
cluster in exfat_remove_entries().

Code refinement, no functional changes.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 942296784b2a ("exfat: preserve benign secondary entries during rename and move")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/dir.c   | 3 ---
 fs/exfat/namei.c | 7 ++++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 99625a2ad33b79..6c714b110f089b 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -584,9 +584,6 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 		if (!ep)
 			return -EIO;
 
-		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
-			exfat_free_benign_secondary_clusters(inode, ep);
-
 		exfat_init_name_entry(ep, uniname);
 		exfat_update_bh(bh, sync);
 		brelse(bh);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 4657f893dea786..53fc0c26865deb 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1089,13 +1089,14 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 		}
 		exfat_update_bh(old_bh, sync);
 		brelse(old_bh);
+
+		exfat_remove_entries(inode, p_dir, oldentry,
+			ES_IDX_FIRST_FILENAME + 1, num_old_entries);
+
 		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
 			num_new_entries, p_uniname);
 		if (ret)
 			return ret;
-
-		exfat_remove_entries(inode, p_dir, oldentry, num_new_entries,
-			num_old_entries);
 	}
 	return 0;
 }
-- 
2.53.0

