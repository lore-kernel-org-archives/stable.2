Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050131;
	b=IsLGg4nUizmW6obKYK+zpJiJXyix0F9tN/Ol8AvWpRJw98f9TKJNJx63pMLcEUaqUDwL
	 EJgj8eo84cUfRqzi7sQPu7Evq0LwcouMkU358U2VmT5KDKmBZ/LRZBVFPf2iyHTMcDBgM
	 6W8YOVdQWbQcfmGBWWS8bCG9DqhdcFTFHCJuXvpUWjrnC5ScUcUz9MsO2oHq8nfBKGPhl
	 wTP2kuD/jKTKF1+fIgBpSIxSjqoKGI2LpIv2aRLUTXC0yLu07rAAmoDAfLLK03Nie/NbX
	 wtLYg86ntAVC6fh8Cbd3P24txao3cLu+aMhQTnvbhg8d9wHuHLTm4Q62PuyqA5Qp88A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XjuLgF3pJcLKuTJrBSxsShsYORXutACc1cUZIsdsR88=;
	b=HURXxT5rYkwpaxdVcdmESR+qOy1NqWrRBpr0/boLyE85rtkuKsf2HS1JK7bevoAi0aLQ
	 1e4WomHKUQ6VX8k6rpZ975jfRBBc0Kx1mayQj5js2Fl/sbleuidnSGDpYjz8n2r+6tOuW
	 EpjR8PkbhXXuO4/e5TwoVBaVrtdA6yA/r9liQpo5PcglQW6mRly+eXHzE9da14KifwGgA
	 UMA/kNChmddjoO48fXBGQ6BQqI0L79QbbaAWpH74FDnTv2jgYlAlI3ioqcjA5WKGqTJCa
	 BNWUg/QcN4LqKu60jtlT6WQ01FPr+eFXIFZbObpETcUL3eifGe0zaq0mxF8ShJ+AImg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfoA7ZYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93293606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfoA7ZYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125321F0089F;
	Sat,  7 Nov 2026 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050131;
	bh=XjuLgF3pJcLKuTJrBSxsShsYORXutACc1cUZIsdsR88=;
	h=From:To:Cc:Subject:Date;
	b=jfoA7ZYd+wHn9hAyEITnz3zAp4Jj/E7SjQwrzQSgX7SgZha7tgDwMIkM5wi+VvFOj
	 lsphHpyf0Lvxtz+89ZPTgiA6ugZdyj9ziHynwkwdKQGb+t1ijubp7rsS9EhBRSLCMg
	 QC53KCUyDWIbNt+2UFjM4QmGB+Y+vVgk3KjxUxxFI98SZEV92ZCRWz4QlyGqc4dYMA
	 wDwR7oNbFoU6R/+NLNP9BmjNytkFOPg+XRDRF3EShMbU/RPWjpiE5sQ26Dekxv5OLD
	 ngViYZspYZ2YLU+xDiO28MkXe8+PFETa4CNL+jmtXxypZqRogFT6QvANNmME0Fbv3B
	 Nc3nzMbwtD1kg==
From: Sasha Levin <sashal@kernel.org>
To: msakai@redhat.com,
	mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm vdo indexer: prevent delta list overflow on load" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:29 -0500
Message-ID: <20261107061529-failed-5.10-936293c9f3f4@kernel.org>
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
git cherry-pick -x 936293c9f3f4f2a0d1b80df9332e96c552ac3b37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061529-failed-5.10-936293c9f3f4@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 936293c9f3f4f2a0d1b80df9332e96c552ac3b37 Mon Sep 17 00:00:00 2001
From: Matthew Sakai <msakai@redhat.com>
Date: Tue, 11 Aug 2026 15:02:33 -0400
Subject: [PATCH] dm vdo indexer: prevent delta list overflow on load

Check for corrupted delta lists sizes that overflow the
memory available for the delta_lists. An overflow can
cause the delta list data to be written outside the
reserved delta memory space.

Signed-off-by: Matthew Sakai <msakai@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/md/dm-vdo/indexer/delta-index.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-vdo/indexer/delta-index.c b/drivers/md/dm-vdo/indexer/delta-index.c
index b288749067dee..257612b81a9d9 100644
--- a/drivers/md/dm-vdo/indexer/delta-index.c
+++ b/drivers/md/dm-vdo/indexer/delta-index.c
@@ -800,7 +800,7 @@ static void compute_new_list_offsets(struct delta_zone *delta_zone, u32 growing_
 		(delta_zone->size * BITS_PER_BYTE - delta_lists[tail_guard_index].size);
 }
 
-static void rebalance_lists(struct delta_zone *delta_zone)
+static int rebalance_lists(struct delta_zone *delta_zone)
 {
 	struct delta_list *delta_lists;
 	u32 i;
@@ -811,9 +811,17 @@ static void rebalance_lists(struct delta_zone *delta_zone)
 	for (i = 0; i <= delta_zone->list_count + 1; i++)
 		used_space += get_delta_list_byte_size(&delta_lists[i]);
 
+	if (delta_zone->size < used_space) {
+		return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
+						"delta zone lists overflow zone size %zu",
+						delta_zone->size);
+	}
+
 	compute_new_list_offsets(delta_zone, 0, 0, used_space);
 	for (i = 1; i <= delta_zone->list_count + 1; i++)
 		delta_lists[i].start = delta_zone->new_offsets[i];
+
+	return UDS_SUCCESS;
 }
 
 /* Start restoring a delta index from multiple input streams. */
@@ -941,8 +949,11 @@ int uds_start_restoring_delta_index(struct delta_index *delta_index,
 	}
 
 	/* Prepare each zone to start receiving the delta list data. */
-	for (z = 0; z < delta_index->zone_count; z++)
-		rebalance_lists(&delta_index->delta_zones[z]);
+	for (z = 0; z < delta_index->zone_count; z++) {
+		result = rebalance_lists(&delta_index->delta_zones[z]);
+		if (result != UDS_SUCCESS)
+			return result;
+	}
 
 	return UDS_SUCCESS;
 }
-- 
2.53.0




