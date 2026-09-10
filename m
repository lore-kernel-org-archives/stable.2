Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70C30FC1C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003788; cv=none; b=JkB7upLpLZ3jGkU9WsUc86Qb/+0ky+Uvn9AeALxeYC4UDwUZSbnI6kxIAYSWrhtp2kkgk403Refy1v74xeQLyL6j8bNVYsaRoZ25YA5iGH+l6TPLRCRF1xjR429pXQui/bo7oQXASpF21Oqeo11HZdzhroTbja8iDjYT3Xd6I5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003788; c=relaxed/simple;
	bh=gHhbcegFI52ltURzNuQjQZ9JQ3HihPiQJWnZQHR26Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrmHdZfJkNWKwn6NkJZ/QdeOMVodZQqCHodBkuQcVBCTPlKK1rimP6uLAxdSFZcnavZYa31N1S7b4IAUrPVdsGKKLJV2VQuxcdWkmXPZMw7nRB5RWxkrx2L8J9wP4mzf+188WcRxdSV7o88gpqI2TqiaTgvgpKQDDDh5RMSHkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQd6uWN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQd6uWN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBAB1F000FF;
	Thu, 10 Sep 2026 01:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003786;
	bh=5f7BoRCSnyInTL937znHjJbHXrv7ZYBfjGS5+E5QynM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQd6uWN6titYCYpPEL2kh2Vur4+THTfGPK7xLJiB7KvSfVJYr8T5ggagOwRAHUeP3
	 No0dCpTHSyVQf3mVveKq8aihkFaKe7omMhF+37MJfqxcJ6lFqH+vbUBidJJCPSbcXd
	 v8dY+fzvMbsLbCN4dADWkPUTaK+ZID9KNO9wl6EdBrNd1dwzbAmEDW+EoHCXoUXwnt
	 65FMfHBYt0EVhQe0YUldblgTcb00cjKXHyXobvgRahT5ql/mgZZPoAL2At29vclu17
	 05c8sW7N3d9RfUJVlUo9OPgP6quxfslfAcPBONy2iExSsvR/Fxc+1RmMLlBGHRGGWp
	 EOfu+fPk9Nx7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	lei lu <llfamsec@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] fs/ntfs3: Add more checks in mi_enum_attr (part 2)
Date: Wed,  9 Sep 2026 21:29:41 -0400
Message-ID: <20260910012944.3879576-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090803-neutron-crazed-bd82@gregkh>
References: <2026090803-neutron-crazed-bd82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit a8f659ce14f8f734894227ba2c5ca78c8451501e ]

Add offset check before access to attr->non_res field as mentioned in [1].

[1] https://lore.kernel.org/ntfs3/20241010110005.42792-1-llfamsec@gmail.com/

Suggested-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index f810f0419d25e..61d53d39f3b9f 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -212,7 +212,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 
 		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
-		    !IS_ALIGNED(off, 4)) {
+		    !IS_ALIGNED(off, 8)) {
 			return NULL;
 		}
 
@@ -236,8 +236,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		off += asize;
 	}
 
-	/* Can we use the first field (attr->type). */
-	/* NOTE: this code also checks attr->size availability. */
+	/*
+	 * Can we use the first fields:
+	 * attr->type,
+	 * attr->size
+	 */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
 		return NULL;
@@ -259,10 +262,17 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	asize = le32_to_cpu(attr->size);
 
+	if (!IS_ALIGNED(asize, 8))
+		return NULL;
+
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
 		return NULL;
 
+	/* Can we use the field attr->non_res. */
+	if (off + 9 > used)
+		return NULL;
+
 	/* Check size of attribute. */
 	if (!attr->non_res) {
 		/* Check resident fields. */
-- 
2.53.0

