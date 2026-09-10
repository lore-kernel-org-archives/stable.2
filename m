Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7835FF58
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003036; cv=none; b=uxpKs5t/qYcsl9oH3mxTHv26UbVVmWb/gQFXNhS0bHNNH0WfP+UvK2XayC7CB5yK+NENNXZaIfw1Oe+4sIUf+3qAVj6cTzRXeYZfNI7dHQop1MJzKT0zlRUvZgjQKGnymo53ShYV1JbkH/ltb5j16Cpy13PFcVSREHYMjMHL6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003036; c=relaxed/simple;
	bh=YXlOxm0zcRF9RbY7TEq/AMLsZCVcUqXiFmiTUwp/xFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGpzMoH+Telm377INpx1J/+gcgTHgFxofIFX5UpIt6xw/ubqVphaOSWQ3zH0pFy2JnaxnNo26ud9lMxmGsvurCI+ifF2hN3P2s/DlMi2ubxXXWUsvVK9lKQvKGp0BQD4ljtnlFs0Unhsb9nlWnYAeqyEleqT1W1rkdces3VBSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StWcQamn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StWcQamn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589B51F00899;
	Thu, 10 Sep 2026 01:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003031;
	bh=qEKbNNRq+S2piGsCRxD1YiAuFdz2F1aZcn47G3i6jZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=StWcQamn7YMitGW37FZk4b8O4DZ+IvU29FWHd/8uaPk7O6ub8Nf8W9MZ6EmRAElrQ
	 fRsPYP4wj47GRdkNEcTUG7yhBPW+8rg7jlV6hfV1bIExJcRnfqAgwQUHqGEVteH6OY
	 Bc0o7qaBYPX/mO34AZZ8eHU/ZNCBgjhCDBrsicDDyZHFSIhFlVJWJiXukyMPlgzIcZ
	 drMeYT/SJngNA/nfmIvWBHQFV/7gRKUo3H8lb3nUlQ6OFWZDz7VPeKd7n70VLacQpj
	 mRSKzjDRUfg2S0df6Gzl9sEsmHbBMsGKM1aTVfzxGQMeMq3sB1z+/TciMfp9ZqRVTe
	 05dN1f1iUz1qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nirbhay Sharma <nirbhay.lkd@gmail.com>,
	syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
Date: Wed,  9 Sep 2026 21:17:08 -0400
Message-ID: <20260910011709.3831760-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090802-coherent-breach-4121@gregkh>
References: <2026090802-coherent-breach-4121@gregkh>
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
index 3a458975181c4..b24035c351925 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -769,7 +769,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	 * Skip estimating exact memory requirement.
 	 * Looks like one record_size is always enough.
 	 */
-	le = kmalloc(al_aligned(rs), GFP_NOFS);
+	le = kzalloc(al_aligned(rs), GFP_NOFS);
 	if (!le)
 		return -ENOMEM;
 
-- 
2.53.0

