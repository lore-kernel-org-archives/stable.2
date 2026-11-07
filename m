Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049121;
	b=cV4/2LNSJgrWjV36gp+oXSme1McRrOWJes1J/vR8FLRfMwAZlAXVuPMMUmm2sPrksSPR
	 rCpxlAzxit9H8hV0+V+L7vJCIBYXRnphXvXDD78JoF/AbSwgSgoLSQl0qHiVvhGSZh0/q
	 WRPlDVEtZ69OmlEk895K56fYHfmkIx6qbJkZp5Fdhh9pFNvF6KQ6KFC7ZH9jfyoMKp2TZ
	 ZAZlnzhTYFHD02QPeyF/yFKBu6NDPI9urKif2gf+oFXO+z4L16sqrcAgNzzIexwSLpur6
	 WD862nuRaM3jNqDCA7ZVT7YjVTYto+ElQHB9TSlVy7awwMbjGlZ64Nb/C5535iWxqAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=af4PkeM011jArz1q5YgAW834UsgHB91AP3N2XM/4nR8=;
	b=guK2EaCnxkk0tk8kZGBPIVbjf/5TJbnWOcFXi9Gka+XaYDi2OV1qi8haOD+l7r9jd4qX
	 x8YHBhQhbKYUfC9y9oU3Hud6aG3nV4CUUWEoFWiC2YxLACagShpBS+55m+y30KkFQkwvP
	 0PIEGMjIOYR6vWvC/4ZL5CLEqn7nDHy5HB2X0kxhTw8a0nY9rC249e0OdMtegu3W0IwBA
	 X0RiBwAYBhYbrWlA5bjR7r5xVQjBXwhMNM3RyqAetn5bo7kENfDCMGvRaqyXWo96nZLPg
	 U60NwMkLCsReYJLEme+fZYDSNO0wBzGvV+Fwqcs0JtLzchnfxH4kUosbfHyIN6I9H9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwXBZkyl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwXBZkyl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106351F0089F;
	Sat,  7 Nov 2026 10:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049120;
	bh=af4PkeM011jArz1q5YgAW834UsgHB91AP3N2XM/4nR8=;
	h=From:To:Cc:Subject:Date;
	b=NwXBZkylRkLOo4cdzEVlTVJ6BnPXtBSOD2GofEQOA5gI7bm0fZS0bCJQdwIlZ2rQ8
	 MQ9tVwh3yoLPc05vUl6dcOQO+1z6IM1AwhsNER5ZPQBaq6HYa4pMAeC+wAa5NvC6oF
	 LIT9AVBZtzojjryac5NtCWsHrGyjaq/hvTBWEPRVtWGOGTpzttfvQ1rEX0Xob7AXcz
	 OHT2AuykK8YhbnToWNrv7z2sV6VMZWlO6bdciTEinA60ehqGzt4L79gdQGuQcwtWYn
	 33pJr8Mjc9F//xxkqyr3D1c5By12udUDJL+yHCDTFUVmG6UGk2Sb/JGPku2qzFMP7F
	 wx15Voml1SAwA==
From: Sasha Levin <sashal@kernel.org>
To: msakai@redhat.com,
	mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm vdo indexer: validate record page numbers better" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:38 -0500
Message-ID: <20261107055838-failed-5.15-e3683a76a313@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e3683a76a313a81f3f7bc7f65e4fc1e61232838b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055838-failed-5.15-e3683a76a313@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e3683a76a313a81f3f7bc7f65e4fc1e61232838b Mon Sep 17 00:00:00 2001
From: Matthew Sakai <msakai@redhat.com>
Date: Tue, 11 Aug 2026 15:02:34 -0400
Subject: [PATCH] dm vdo indexer: validate record page numbers better

Move the record_page_number validation check into the
chapter index lookup function in order to detect (and
discard) corrupted values on all paths.

Signed-off-by: Matthew Sakai <msakai@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/md/dm-vdo/indexer/chapter-index.c | 15 +++++++++++----
 drivers/md/dm-vdo/indexer/volume.c        |  6 ------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-vdo/indexer/chapter-index.c b/drivers/md/dm-vdo/indexer/chapter-index.c
index bb3b0ab5d50dc..9fb9e59238d4c 100644
--- a/drivers/md/dm-vdo/indexer/chapter-index.c
+++ b/drivers/md/dm-vdo/indexer/chapter-index.c
@@ -284,10 +284,17 @@ int uds_search_chapter_index_page(struct delta_index_page *index_page,
 	if (result != UDS_SUCCESS)
 		return result;
 
-	if (was_entry_found(&entry, address))
-		*record_page_ptr = uds_get_delta_entry_value(&entry);
-	else
+	if (!was_entry_found(&entry, address)) {
 		*record_page_ptr = NO_CHAPTER_INDEX_ENTRY;
+		return UDS_SUCCESS;
+	}
 
-	return UDS_SUCCESS;
+	*record_page_ptr = uds_get_delta_entry_value(&entry);
+	result = VDO_ASSERT(*record_page_ptr < geometry->record_pages_per_chapter,
+			    "0 <= %d < %u", *record_page_ptr,
+			    geometry->record_pages_per_chapter);
+	if (result != VDO_SUCCESS)
+		*record_page_ptr = NO_CHAPTER_INDEX_ENTRY;
+
+	return result;
 }
diff --git a/drivers/md/dm-vdo/indexer/volume.c b/drivers/md/dm-vdo/indexer/volume.c
index 78c3729f1f65e..38e51fa1cbd05 100644
--- a/drivers/md/dm-vdo/indexer/volume.c
+++ b/drivers/md/dm-vdo/indexer/volume.c
@@ -891,12 +891,6 @@ int uds_search_cached_record_page(struct volume *volume, struct uds_request *req
 	if (record_page_number == NO_CHAPTER_INDEX_ENTRY)
 		return UDS_SUCCESS;
 
-	result = VDO_ASSERT(record_page_number < geometry->record_pages_per_chapter,
-			    "0 <= %d < %u", record_page_number,
-			    geometry->record_pages_per_chapter);
-	if (result != VDO_SUCCESS)
-		return result;
-
 	page_number = geometry->index_pages_per_chapter + record_page_number;
 
 	physical_page = map_to_physical_page(&volume->geometry, chapter, page_number);
-- 
2.53.0




