Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047346;
	b=gPggSpkGOWzeWXqC0TiY916BCT6NHsE2dLDaZESTGD8u0F++ZKNrorhzM8L4yKO3dsop
	 CujOk9ED7vzYRQWTLFNq3G85WRYG4wMaKCkAQbICmZak/0ZTLcJpA7AvsiL12g7FpN+Is
	 9RcjbS9hlh6m5YcHKKjo2tZ+BCDct43m8Z9Lp7Q5knmthFElkfN/E5ViJzHnydGQ0FEOS
	 dWSFqJAQnE81z0qJQJ/oqhHgDsD7uZ4REN8l69t6QyFpyTvbKxAK8YlNcTZ1NnSubq/tl
	 MVAyXMrNNlDvxZuqJSe17QvSSDhfoawCsaV6EhLHK5WrAirYfabN1fKevpi4GdbLKUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047346;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YxHNHlP3tncIjtGxgyVcZ6nmHmGW3x8vcYv5+aKUCBw=;
	b=C6xfP1aqhTzdX1WcAt6H4NiwHLFkEeMX7nQ2dGVKZa7HHxaOLAF2BX/tPliykUfV5Wtq
	 EWXG5a1jXJYZMHU+ldAS8OmDAHqHjrVa/3ryl1xaht61vAIt4yE9U4O31ork+QVwje0hU
	 rIH6aVTxjTJQotWYaeKkc9wYlYVdHwYyFbo1QNAKya4TWqoAtxUvzv8PKpk6wrk9FHXCO
	 1IJBBsdNjUOE0w2PL7LYHGeYPp/vAD/stmUfwg88REZut+obYzxVsQLVnWaZjJbNXi7Nv
	 8h43Q4dwNfZlizTudysHLVSE+mVh4A/k9ko8U1fXL+UVk7ozW20dAGq/nSYukb0+c/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G50znMQC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD2606D817
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G50znMQC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0DA1F008BC;
	Sat,  7 Nov 2026 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047346;
	bh=YxHNHlP3tncIjtGxgyVcZ6nmHmGW3x8vcYv5+aKUCBw=;
	h=From:To:Cc:Subject:Date;
	b=G50znMQC4Mk3zuwjRFQqner0ZzlKNK5o+7xi+9IZR+WopOYc+G5y1vTu/lKJJC6Tv
	 e38oDR0Xl2H7OiKdCDwfwWKED3j6oE8pUet/HibrA/qPamZXN3sx6fh9Yes+TIfp1u
	 3DzYsVdUBsK+G8WJQUaVD36o+VWXy9AIZ1UTkJxTmJrImvM5hAWB5hnXBg99bU11Ag
	 55XnIJ1rMxhhEwV5IFMsGnnRfWT2hX1erm8fSUYffKygF/6226znQasxZb8rYsKB85
	 Bgk1qo6V59UfMobFs3a4umN1IxYaQeWSzX6dq2qS9RrltVmb/8mhmDUv3Ee3BeRnXo
	 jizjODJHN0a1A==
From: Sasha Levin <sashal@kernel.org>
To: msakai@redhat.com,
	mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm vdo indexer: prevent delta list overflow on load" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:04 -0500
Message-ID: <20261107052904-failed-6.6-936293c9f3f4@kernel.org>
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
git cherry-pick -x 936293c9f3f4f2a0d1b80df9332e96c552ac3b37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052904-failed-6.6-936293c9f3f4@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




