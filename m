Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2835950
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005558; cv=none; b=CM5rWcntD7b4bWwMETogFItrknPWqxPj5GrUe6ElnLDGdS8sL30ISnIQ5AqQU1KJWlxTDRhSHvI1ku7n7DOOZfk16POk1hyHy8ezc4GkIIgpBWwtGlayQ+CyDv7LDbVhM+ryPF5M8/QG2zQQrnIXg7qqzOoVg7Dp+eUXsdSE02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005558; c=relaxed/simple;
	bh=DMfHWJ+jhLwbvv4KNqk9hk/ao784aBl/c9GqkPf6PEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA+q9h6ou7G3rznvO3t5yItMuey1x0yXiGx6DHzuZQ+Wwo5yBK0n4T7N68agXMaqQv98r2GoOKFxn4S9xxCsvW4O8d7JYy/gKdB11WAaySzt0JAhXItX9ampC2SchQ9IBTZkde1zque8Po6+CkMYuOIXX0DssLsOYAFJNscocaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/v6sQVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/v6sQVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1369F1F000FF;
	Thu, 10 Sep 2026 01:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005556;
	bh=Sc9jNHfKcx7NtVYYjoFn6BmVowgnJ/vRSUVHg5M9FDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j/v6sQVuYNw3Kr7nOZvm5fOzqMO/TTUhTaO2EaTGS9uhvlpWGEKFsrExXS/V2eorT
	 fkfWUMU74OSZXjidRlRwVdJ7/Wm4cnaH4x37vsXw5oxR0OjFZJGo2FfOm0FdsFPO8u
	 Tt9kzgxoGPWHLB2NGcQW8feoMiUQJubo2JkE12/B72BmY039TYUpdHBCP1CI/Al7+w
	 fkVmKBXBdIXiweQm1sTivZcXXt12Y/vvEHCIMl7iGu+1XokJFEM4jrQsZy11/yTNBT
	 AzgL7ophrO7Y3Hrzj1OFhPH+9MWZh8sag4mbrLMA5Yizq7DGvbX+29CNwbhfBqbH6J
	 Yw+OM+Tb/m+Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	lei lu <llfamsec@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] fs/ntfs3: Add more checks in mi_enum_attr (part 2)
Date: Wed,  9 Sep 2026 21:59:12 -0400
Message-ID: <20260910015914.3948870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090804-handiwork-afford-7887@gregkh>
References: <2026090804-handiwork-afford-7887@gregkh>
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
index bfb1f4c2f271b..d8d43f6a96fd0 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -206,7 +206,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 
 		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
-		    !IS_ALIGNED(off, 4)) {
+		    !IS_ALIGNED(off, 8)) {
 			return NULL;
 		}
 
@@ -230,8 +230,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
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
@@ -253,10 +256,17 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
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

