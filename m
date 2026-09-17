Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070761448E0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608794; cv=none; b=r8+QMUC9xpvsp5pxV+bPXKuA9HAZiHJ0jIcTuqNJxOx7PkrJImlEk1oF0Z5ffQxGsefS0N3/VlMw5h7ZPKabYCs9rvOoKryXqikH6/SILVXUhaZ0bBwpD5La1ej4lLnqDTPmGfvCV1EPBfC9l3lF5c5G0pZ87B7wvT3vB7J4kiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608794; c=relaxed/simple;
	bh=Rf1RPC0WkxfiedUCyVQgnztkS13V1cQnhr1nsgGhDxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw7lqCBfkODZlez+kIwkjkqOT1kVUwizPi/E28aakrMB0Xo6otlh2OQgEjVi8nUJ+AvNA8DjslkIsoLlvCJ94esEtHN09lps/uBoZg6TliG0wHSmE+cDfQOUR32Ie7fhg+8JRwY9aVfsPjDFCBE2FkUOZXy7x9E62op+H9Jtjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9P+Gqfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9P+Gqfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A371F000FF;
	Thu, 17 Sep 2026 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608792;
	bh=VKJpZS+PWYjITAU/7UXOc4amjEG4RIZG2yHBW/1CyMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9P+GqfgWUEjpIM7kscQOnWAkvGvQZn79yXHFuyby+FrC3EC/VGbvJcgnYrJN0IZb
	 t8i1FoC+LWZpckgmmCL3L9VHSStiIrPrmUiw/EvIKwBmuyJWIc5+p3kfPxLJFdKeGX
	 P+saUWc4yb8Kvbg1CdI6MKKL3VIVUSz54pV3WwChX62ZlX1vpQ78eG+SXBAJnHa3Sv
	 MOJknt/HehUqf2IfhVb4kIzwLtzQ79rIU6nsTeZ1BiJtZA1nGsv2nTP+U7aDboTSf8
	 9TdcDqIQRVJGOebWcmvpOkNKqdFTT2m8GUQXU5Uetfmzali2ZMrPoqolD+VTFMfWFc
	 ZMlggKOwysvJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <xiang@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] erofs: add sysfs feature entry for xattr prefixes
Date: Wed, 16 Sep 2026 21:33:10 -0400
Message-ID: <20260917013310.3594538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091651-stubble-sloping-7a9b@gregkh>
References: <2026091651-stubble-sloping-7a9b@gregkh>
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
index 284224d1b56fe..2997379bf8044 100644
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
index 435e515c07920..92f0bc13623cc 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -78,6 +78,7 @@ EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
+EROFS_ATTR_FEATURE(xattr_prefixes);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -90,6 +91,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(ztailpacking),
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
+	ATTR_LIST(xattr_prefixes),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
-- 
2.53.0

