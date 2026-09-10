Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A730FC1C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003789; cv=none; b=huSXE3W82qL0GQ4TgB8mdsDljqCDY02UVp7LChIhSNTJkOK2+46afP2U9sxsGlUgZje84xhInawwI07RR1838zvY39kVz6V9rxV/Cu1ARApMaIJfve1f0dSWHp+ZZ2xHgJhuhDU4wjnx+jD5nnHa1glTeV4DZzFt+Dqi/uYm1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003789; c=relaxed/simple;
	bh=ezFBNYO8RqlvJl21MpkjfU+SceoyAeSFb3yRiVQskbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MS/m/o6yXD/wOlRDLzgeD6M3PMBCtQXszjyyvkNqWxCHLsjJoB4F7zso4ceOcZlu67yvkX2tr0u0Vd1g7AC73gmvkU/8zVfrjTYCzmAuYlu1IcaDIgsqoFBLy/AuxyC66QaGsO9q62OOJlv0DeatzddLGwA5niuzQ2SMHvurdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlvpq+fp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlvpq+fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB44A1F00893;
	Thu, 10 Sep 2026 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003788;
	bh=6fPC+ZYNV226Ej39Och9509/Ys5TYrTn8JvdFz578XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jlvpq+fpFf3gpSXS5l2Jo0/jm9NqkGpsogMlhuIQFqkbtsy6S0teUTXWfuyoDmWC4
	 +nWG5d+Tdkv72Gw0ICsjgBbAxCn1fvLjccOyrFtZWSTqadESRROIFei0x+dAogh8jG
	 Xzjqu1Ex7KDqTYH+2hF5pmZ7yx7OaIdAnadsI5QmjeYWpFgNwAmBGw5CWDsgobXBD/
	 TTwTfC/Pmdku0qdBLnA67OSTKBMJnb8r7MisGBHGJ5MItgrHRSzroxrNeULe9mHf9j
	 T4Yao90sAUlJYYOr+FS7QGYDeWBtnZI4J4Qg+pils1lK0pKabxn+tCCFBPIhPtJ8C7
	 KFx+e6i6UQxzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nirbhay Sharma <nirbhay.lkd@gmail.com>,
	syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
Date: Wed,  9 Sep 2026 21:29:43 -0400
Message-ID: <20260910012944.3879576-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910012944.3879576-1-sashal@kernel.org>
References: <2026090803-neutron-crazed-bd82@gregkh>
 <20260910012944.3879576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirbhay Sharma <nirbhay.lkd@gmail.com>

[ Upstream commit 5f33da04e6ceee849e76e6592cc283c72fef7af9 ]

The call to kmalloc() to allocate the attribute list buffer is given a
size of al_aligned(rs). This size can be larger than the data
subsequently copied into the buffer, leaving trailing bytes uninitialized.

This can trigger a KMSAN "uninit-value" warning if that memory is
later accessed.

Fix this by using kzalloc() instead, which ensures the entire
allocated buffer is zero-initialized, preventing the warning.

Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7e5a12e8decde..5a00008d85714 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -824,7 +824,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	 * Skip estimating exact memory requirement.
 	 * Looks like one record_size is always enough.
 	 */
-	le = kmalloc(al_aligned(rs), GFP_NOFS);
+	le = kzalloc(al_aligned(rs), GFP_NOFS);
 	if (!le)
 		return -ENOMEM;
 
-- 
2.53.0

