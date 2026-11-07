Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047348;
	b=HT7sufRn3te8azmV8tgV7cFR+JzCuwY4P7M2RtIqVB207sjMv4JqOdympW6XsU92LBta
	 DCD3hGw3OckvJX6iuYaG6KScqvI1/kWvKiuEPag9oTg5Iq2ExUf4woH+bS2f3Hv2pv51p
	 /9+/ugQuCVe+x1gwgyuHAGLovmHuItJhbTJ/DLplKkOsUZSmldmjGoVior86OIAv4beFt
	 TzETThAXjltCWwmvO6WnsKqGXSdR0gUlGU8a4mqG4bsSg9qZGXDU6PPQ4vVQ6A4JUY/JF
	 v/zlz0T0Z/ehjxu7V9A+YfHCzvFYGymlkUUy911DZxkZat7ifoFt+FzUBz8YMxsEeNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sSJlDMs95YqloNG/qitNoPH8IEmcvNCI55c3Qa9KZeE=;
	b=J4fhBpXT0KWnAyh0s7am2a9kR9b2II1D93i/2ESvrcrwdJFGsMIMLq+agHVT8yS4qRKa
	 qLNpXvK/u6OUThin/Ud5snRSfrs31Lz5M1uK5woY38/dzTp0NOheiNn2f6mk653lPk/r8
	 uQJeiWMX3zAipKeY3Vp9Mikmej3S6bvyISYuRDIy/WTSbjXpX65wqn+ckoiBEBKiYSajc
	 jHCU7IILHvRxSr1hWisj3PkLDXgzSYPkjjRBkCmXFvdkM4Dic4gqpxUAozpmOoWlvMysw
	 z6Qkd9jbYyX6Teg/WUv43UFKosKXduzLUfYjD+FI81x90aJ2Kjbbekz2qF5EKIt5UiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6ITkz6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C7606A33D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6ITkz6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC831F0089F;
	Sat,  7 Nov 2026 10:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047348;
	bh=sSJlDMs95YqloNG/qitNoPH8IEmcvNCI55c3Qa9KZeE=;
	h=From:To:Cc:Subject:Date;
	b=e6ITkz6FvByDGY5ncvFis6regr2mP05tcd++sYX2y/MdDUO0lMBkKwpgfkXSwsyyf
	 7DYRHW4wvNCSfU9drtWJIlO81ab4T2VlKVQEj9qmP709evHm6ccnvlpRik0/4+hWZS
	 MCJ5HRpxOdM7DiKCeWYkw7e+3X4RRLN3RL0Q9N9e4aryuRNJSWIAyuf5GX6xStp/iD
	 cq36cTlQe9kdhgu2ffSwC4m4FOaMuG3E41QpwLa0/4m+D3lWc9fFsBSgI4qp9TEHur
	 Dt02pedrFKB8DvRXVz56zm+3KQOvaBsha/Ay2OT5KQnZtP63oCj0feVhOr8r/Rewd/
	 jvzE2MSt64x7A==
From: Sasha Levin <sashal@kernel.org>
To: msakai@redhat.com,
	mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm vdo indexer: validate record page numbers better" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:06 -0500
Message-ID: <20261107052906-failed-6.6-e3683a76a313@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e3683a76a313a81f3f7bc7f65e4fc1e61232838b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052906-failed-6.6-e3683a76a313@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




