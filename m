Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050134;
	b=txuPUd6p5YnedXE5/eL5CqbloOBB3YcLCFTeZKHmRzYFDTF7Xc8MpSn7G/z1T/tJjO21
	 /u8OA2L7h5zoRg/tNAr88xpsLnE5RBpBUGxhhY3cProiszFGuVqXt8Rl0k0TdLQX9laUx
	 zm9CnpGRAgbkgVvAR0K3VZHMsE0GutYELYnHxrVlWlRwV+UwFUVng0UqKZqlwxE+ae6PC
	 rggKSaDklLLQOvfTyHLih2cpwvjkVlJXZhQ1cka0CHMpIVeuW/6ytbN8m3xntjEigBpjO
	 zG42g09wQ8bX6FjjgOcFKkOogbNNzXd1K4KI7zDp8KPhXQAtU1ONPy/3gxxpAxnONTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Aj1EqHMzvkbQ8ZxmXWkx69u4EsO2y3OGeDMzQh6Dvq4=;
	b=d1AgYQPXMRgYOSePKaNm5RQQyxzqi3T4fzLFjSNay10gwuK1OUoHQn7ZGTU0Vw4zCnSf
	 EqBd1W7tVLPBNMWQdoCt2qER8gaaYYkLpCnpbLlSMbjRE8Wd4/vHVwHRv8xsSaghkKiT9
	 9wJzprow06dK1nRrppCXV8L5sN84skU6gNPlUf9D8Nq1HN2Gwvp+2cwjIxffKapGMTf7C
	 oddRberxfFOhkX/O97FZZEW9TB+w66NH/mWxcm6Qnag68LitVkiQqmBa+D5iSEqiXiX1/
	 QlMSh5G/DeA4A8iiwQFbxXRqtxzqq8V21g5i4QV1vrcfAQ/NelmYVDb9+49SCfzjWHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHCsyfjs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF85606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHCsyfjs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FC21F0089F;
	Sat,  7 Nov 2026 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050134;
	bh=Aj1EqHMzvkbQ8ZxmXWkx69u4EsO2y3OGeDMzQh6Dvq4=;
	h=From:To:Cc:Subject:Date;
	b=EHCsyfjswcUOQkO1uD0qkup52TcLVD7VputiP5z5XOPjyMUtCNFcWhRlLQV/gYxiz
	 W5T82809QQLVTze1EydI1hezHAqq/fGph6e1Zi9ZH66D0he9iwWP0MtuVh+zJGbhxU
	 q5drzy4rv/VUp0OTC7cw0JcPBe0StX8g9O3eSIz8DlvnpXYdjuMnHTZdx8JtvmJbcj
	 uQuOzK1wxYd5Yz4YFK7cm3QNuW9ttsqT5elxTWlTEzxURtKCSONcLSgdtBHuSNaS0a
	 skTtejVBiF0oVkeHAv67cyyVp2qJmh7yGOe1cPyl0e5t0O3T/vu/xo3r4C+m5roglb
	 IAL+V3GWCDkZA==
From: Sasha Levin <sashal@kernel.org>
To: msakai@redhat.com,
	mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm vdo indexer: validate record page numbers better" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:32 -0500
Message-ID: <20261107061532-failed-5.10-e3683a76a313@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e3683a76a313a81f3f7bc7f65e4fc1e61232838b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061532-failed-5.10-e3683a76a313@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




