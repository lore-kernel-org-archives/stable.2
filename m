Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048110;
	b=lB2LATbJ3u/Ook+WzPheQ5tQ60q+3CS6kYy3fMmPk/G2Gh1QjXhGoNP9dSEGGQhaWrRi
	 Pjj1nvyY8ebe3n+NHbCs5GwA5sT1+vod6s5rknIfe2TJnFpDPUDY0Q7BQjDaT6hoBxeSm
	 v+B036mqXV9y7RHc44X0QoQIS2r3ITLp1IWum/ACjbZStToSevPJDA0fOUsOHPrrWGCrZ
	 iS4ZFjyJTXnL2j8JqrhB2v/gpe/EcoEMs2qm6At49OaxPdDbflF+q9loTzOlptpf0KdP5
	 3V57szdywxmoF0rz+n8sEiEhD4GhWXxkVHtXk+AMs9E9lGJakr9TCQwIzOxOf4a2lDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048110;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XDtEFrlLqWfYWaUI03f2Xg2X3qAHB7rOe1k79YfGrF0=;
	b=IfoBGjqUQFZkSWjhLRQmytuiMLs6/G/UieYVeacyErbSXSpCn6BCexwVO5rEUKbnGPCP
	 zvuAntBsHnvn+Pl/LxOZoKTbxYY4+9jTQNdNSEMPxqIuWcrPMQqRIcFR6btTZbtjdGHTw
	 jHjDTR3tsHjRcQb4UIDFnqyAsJcI5tDImA9nZ7ciZKUBHGwmPi+U0M1HK0slA9wBB5brP
	 iOUQx8ghRYQXKqbygEmDkY0ll/tdw32A7wCOO9y+Gcs6GYK+vjVNJVFRziQolNyL61070
	 Vq0iBIkJy2jrY1O7UveTC8O8GDYOKdwdC8A3SrKe3rg3fddN758U/UhLPiVe9HTIvsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVJRTLEL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVJRTLEL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAEB1F0089F;
	Sat,  7 Nov 2026 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048109;
	bh=XDtEFrlLqWfYWaUI03f2Xg2X3qAHB7rOe1k79YfGrF0=;
	h=From:To:Cc:Subject:Date;
	b=VVJRTLELAyIoLsJArU9IZaZMyCkL6+CTm+T7AgTJEpzlq4xpXXAuiOyPP+deCMMY6
	 v5dkfFC5VoteLnvSVJd6QGao4oBKJvFsCHMtw6RF78276IrZS5bSpxRU0i2gVFT6no
	 H3xKGKCUTOjUyAQ696By9a6f+uo5EC1Gk25SQE2CiYPU8iOht8f1/0K8eydK76UQep
	 jESSrIwy2/FaaxGFm6xoMOCkC5L9R7EXCw88xfQqcXdtfYodK3xXNpBpwqI+BW7iTG
	 E5fZzwwgaNl2yqUeAZ228eguduVn4OS8unoTj7RHTUmVOpFDhWac/jhKoGFqkMz7qc
	 2AzCd78LX9bPw==
From: Sasha Levin <sashal@kernel.org>
To: msakai@redhat.com,
	mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm vdo indexer: prevent delta list overflow on load" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:48 -0500
Message-ID: <20261107054148-failed-6.1-936293c9f3f4@kernel.org>
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
git cherry-pick -x 936293c9f3f4f2a0d1b80df9332e96c552ac3b37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054148-failed-6.1-936293c9f3f4@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




