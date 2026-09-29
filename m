Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678952BE29
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688689; cv=none; b=oJXxfyKPZsfQ49frRkiBujBus3MnT6hFZ7SI1agYx1mNuZ6VWmrGmPKQqW4IuxSS7ubbaryiA2TcZuZXblwd8xyudrOW496gtql9DYDFQs3pYqV5CABUbK/5Rlk+Wjbdz/MhesP+C82SabUvVRHj3qESci3WouSHet5IQqlb5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688689; c=relaxed/simple;
	bh=Nmocx9mHpG9e6CGbvIRM/GaRkxFwfigKEnzNN3Zx34g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uny+d+fUj3HjIkktxU86ys/opb8PX774dYUi9k8OMvWItZ4TcxusJf22HTmFkWRJWB/pIN84ayDqZQ4uSpXE4NHW5o48g9HrcvgDmoA5Vg8tOSqAQVJPeM7JQ+AVIx0UjVQJ0+srVKjESjg/D9e7Yz64yQHCCL+UCCb75fbQMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0KKQlpE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0KKQlpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E0F1F00893;
	Tue, 29 Sep 2026 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688686;
	bh=qtZtE2IFquSgOEYFLRdMlm+gx01y4pQ5wn0GCa1xrU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G0KKQlpEh8AzPZqIE9J+7mUvwf61uCuc8zJvRfo9Rrq0EgPkHHPWBufUDu29rgFH1
	 V31bTnoY30EUKTletRYh4WxcA+ruFyRU6HQbFkvJdYsdu04Hnl6s41x4TOIxKbPYkt
	 TMVUqRkbDnK6wgDOZxmxpnbx+ZyfJjAqAdGeqgQUaRKLPumeAz6gDLA6dNZDnr//Vh
	 PHHZBVpUTGZxiDGY1Pb1potrohNIBO/fkpavF9gx7Ch97c2obzgbb8+Gx4mFE2Y7oA
	 VVuzvOgY7GVwxL1xIwe3K4XK8dkAWquIliMW8GzRoAHmB2Bs3PUoawskPK/TOk5Oqs
	 OCtNXFVbFA/lQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] fs/ntfs3: Redesign ntfs_create_inode to return error code instead of inode
Date: Tue, 29 Sep 2026 09:31:23 -0400
Message-ID: <20260929133124.3504204-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929133124.3504204-1-sashal@kernel.org>
References: <2026092904-porthole-attire-bdfd@gregkh>
 <20260929133124.3504204-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit c935c66878867dc87c36c36b21d35d7e7f08adec ]

As Al Viro correctly pointed out, there is no need to return
the whole structure to check the error.
https://lore.kernel.org/ntfs3/20240322023515.GK538574@ZenIV/

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 1abd643f3783 ("fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index ce08d44d0d250..e4cf4e647d037 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1261,6 +1261,9 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	struct REPARSE_DATA_BUFFER *rp = NULL;
 	bool rp_inserted = false;
 
+	/* New file will be resident or non resident. */
+	const bool new_file_resident = 1;
+
 	if (!fnd)
 		ni_lock_dir(dir_ni);
 
@@ -1500,7 +1503,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		attr->size = cpu_to_le32(SIZEOF_RESIDENT);
 		attr->name_off = SIZEOF_RESIDENT_LE;
 		attr->res.data_off = SIZEOF_RESIDENT_LE;
-	} else if (S_ISREG(mode)) {
+	} else if (!new_file_resident && S_ISREG(mode)) {
 		/*
 		 * Regular file. Create empty non resident data attribute.
 		 */
-- 
2.53.0

