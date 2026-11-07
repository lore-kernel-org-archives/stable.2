Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048112;
	b=ihZBOIY12AD8REy+Uf5w8NVNM62XaST9jfXlfmQT2mC9pgvl8K2sJOgrl/MS7ryRQrd2
	 63iW/h69d/xy8L/ocnOGr3piAr+mfTvZnRYEFjXApY4wnU+SXS7YnY9gOj/NSrCVTNtsH
	 FZq1p0x0hffSPmFzGttJ6gyt3ZsbRzLWgCC5DtoNn/PwRCEGNS7qDeQz4Vw7e1XbZjQ4I
	 AITNTyLqiiJ9SO4+k98tw6AfEV2lQ8VQgUd5rwo8/hwJX3CEYm/Rm9DrVRlHHJi1nUfUP
	 Gtq/XZWEwAyWiHdD15PDxpPkW97hj92PuUcz63YCF5OOmW9pUyedsAmzchfpK8XMaGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U6+Y4C7IhdaBB3BHxzpMY/VwX7A4HHZ22XRJm7SO8zk=;
	b=x5HSFNKKdZI5JsQsLyLHslYlMLgxFUV3o6+xGqoshxJbO0pdGhIuRLR3WgEQh35rDdNx
	 gBPfmZRHK+1fDKMm0GQJONSpsc99GBik2PX/XCalrM6NPKyDz5sb99eoCeSOPwSsL16mQ
	 ezuZO3rgdy02nr/N5o7k6nzvW46PrkIos4g7tzSxZBY9kcASfBZdLB82CO3QhMoKCrKbb
	 qmJhRxiCTc6PBblSFHDDfk4yNwTL0nM1QUsvSgngKK1ePiX/N2n8MhQXyPMMlF/jP6pdT
	 YP4/OYhhfhuloZekDlTkDKZ7+62HjhHqgH3QsktAbTLH8MaxkJaByvIB8IEY8VqCYmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx53dKD8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484F606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx53dKD8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712021F0089F;
	Sat,  7 Nov 2026 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048111;
	bh=U6+Y4C7IhdaBB3BHxzpMY/VwX7A4HHZ22XRJm7SO8zk=;
	h=From:To:Cc:Subject:Date;
	b=mx53dKD8aZ5pDd5VVfKJoTR1BKVnFJqmg9HtkSPffo15jd7n2tS/molQE87ylvUs/
	 mtnSVgJ5XWnmqX5QNRBv2cd4UPEwE6bM8XKDtkQ6Tb5L2r6W7hBq/LoDWTGTsAEbT9
	 BTmG4QTt4//WZk1ZuE0KwABKz1KuV9HGTrori0yASkE+8znMkdNZfH/tFwPEY3PnRT
	 nLYlj50oXkHohUR8Dg8ZfYbtUdEUkcJgetKN9Wam6RUfJEEBp23kLakFVQfkcjA9fA
	 nkakwT8ADFC+1LGFZoNfOPve6qcazkJR1v7ew5LItdvM00KfZY+7geIdS/UM18HVVw
	 b1HEUOMWlK4ug==
From: Sasha Levin <sashal@kernel.org>
To: msakai@redhat.com,
	mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm vdo indexer: validate record page numbers better" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:50 -0500
Message-ID: <20261107054150-failed-6.1-e3683a76a313@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e3683a76a313a81f3f7bc7f65e4fc1e61232838b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054150-failed-6.1-e3683a76a313@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




