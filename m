Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C8470120
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038521; cv=none; b=mFugPpS47WBGXYlGe18liwllxvBmGW6/KEMQvKN/qt0+0G+3vrOHlsmtIIoSXf/0wd9KtbFdgBFYWH/Coz50xNA8jAyw95LRsv+4kRVFH038pxrGxQZ2vZsv99RSf1KcToAlqBhe5OcJd+P87db+G+hsQvhw/tfDKFkD6VvXQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038521; c=relaxed/simple;
	bh=AjpS5WCIKvXjfqCYnsSRLYE3ZOP54YnahxG77ULK0qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWducuILxG08Z1EgVg0TRAFMgfNiwdqmqMeF2scTnifKjBQHPJjHmDR95BiFdskM3wMycPZOm6toMt5tQfEOnnJUcOGlcjTfQr/a8cKZusF7cSGl47b7IvLrRl2P4TX1jgS/VG3WXMgo+1NROPg81s9l26uO8KQ/p6ZaaZyN5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flFH92sx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flFH92sx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A231F00899;
	Thu, 10 Sep 2026 11:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038520;
	bh=pxqn+MMkstPw1ZfBZ6zbQ/QdOo2AQd2diFK+L8vt1m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=flFH92sxFV1RZm8Q7AoDVKa1YwMMDLuzM1qPfwG9F15VwZ+vB2GYJKaJnlw/e9ekB
	 hCZEDh7SlTodoI9QPrHxgHF6kzbJ4qYy8ujkynHqVFDKYz9TZDVoLB8e61UUEp6rxJ
	 t4jmLJsMa+15ih1YNKdNzKLbOfCPH49cF2IZeLFe4rdqtEyoTGDr3WxWSr6xeS8fMz
	 Nd5J6y0Olq9IfIxSlU3pxbjSUHz5m2GxUn9uXj1nd1HwMbKF19VQvQeF0PpI9z7rL/
	 IpIUBPchqeUK2YoTNQCDHqmaPUFxefjYsDdgVLmYErAKmh8riOigHGwoaAojc8ZyYc
	 IuvP7GHcpq/vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	lei lu <llfamsec@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/7] fs/ntfs3: Add more checks in mi_enum_attr (part 2)
Date: Thu, 10 Sep 2026 07:08:33 -0400
Message-ID: <20260910110835.4144700-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110835.4144700-1-sashal@kernel.org>
References: <2026090804-parakeet-recolor-7d74@gregkh>
 <20260910110835.4144700-1-sashal@kernel.org>
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
index e8d25f6ff15ed..76b12444633c5 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -207,7 +207,7 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 			return NULL;
 
 		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
-		    !IS_ALIGNED(off, 4)) {
+		    !IS_ALIGNED(off, 8)) {
 			return NULL;
 		}
 
@@ -231,8 +231,11 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
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
@@ -254,10 +257,17 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 
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

