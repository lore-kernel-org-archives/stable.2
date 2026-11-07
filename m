Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048373;
	b=z840KlAaTKrs0ng2CzPFC6eUhRiXhZ82JYFwT8zdmlclRxaIY+VjLmQUSVky3loici77
	 BYN3yA0bFh8+tRPwDIgfZta3BU7XRmvmp7L1j6LsauZ6fQXVkC/5dJZDeUiF0oXJ8KZxC
	 dCCt+XT45+hGH0dI76U6OgJum+wXuDja3dYJ7JIM98I1AId7xIi3cfAbrJXdXg8QgSzxa
	 v/rdR/QCQYZbMovIDB1LR44XAHlDYH8nkBw6xQRyW09Y/Ap6wOSr2dMy81Fv4bdw5zdoS
	 m7HadObcDqU3Pv8YvXp+0wQQh+AJHn6awLts6lCitJxv5esPkExlMK7fnuUbq+gZ5Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vh8G/NOVyem66M/6riNFbNE1bVIC7dygNSMqHQpCVVI=;
	b=FnTzcLESjyAxUIIszxOOc9GJ3oLHe0L/21b0CDHOjUGAZgLMNEHZFDC0oE6bXj8VNBu4
	 izH/o9LdE9UVQMNlRoFovwqa9c0QgDE5yJGg8QiPMiTk1biDsJD0W08eQHUn3+4lmXtIY
	 uN12/vCtNyjqUiTRPzxQvxpmDjhJMqPGYj9puh7++zOjjZSFhHz2O4Wqh4YYL1sETZw9I
	 YUvDXqaT37hTJWG3xcu9tv5gAohvI9T4fmk4MshOAkE9vVgvQeAP6CTwdOHZbbKyI51GE
	 lN+qXbjfSJMNOaR/eBJpG5Pvj3FVIMHzqG5vKXmLWO6tE789my7MJvZ4Djc+CPkd2dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPoFL+eo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPoFL+eo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5D81F0089F;
	Sat,  7 Nov 2026 10:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048373;
	bh=Vh8G/NOVyem66M/6riNFbNE1bVIC7dygNSMqHQpCVVI=;
	h=From:To:Cc:Subject:Date;
	b=hPoFL+eoT1f6rrsyDPkI0MqOSDXoAnZXvMfLcLbKAdFdjdBmQEg21XbUA6POCu2kN
	 TF6MYwA6KLBEPylBIPcoMM8rWBT6vKkj73tgmM2GhyorJppjb3n3kUNxSBzy9WG4HX
	 kER6Gs5+ZHUrhOtcrs0o8+wZDC251lwI8K/cLQeuQ7nQr6Nw81r5/R0oZJw8+0Z38K
	 cH9R60P2xwS+u0YQURIuQ2rDekWHLZ/8BBS5B/l4AqTNglgx+TgkY2Ig8QrSkB14ku
	 fX9S4LDtlSWC6cLkssQdJNPSLKastVw9q5wauzqfOE9gQKFL2+K04yf5sypyGzoznv
	 YGbD9J6FNKszA==
From: Sasha Levin <sashal@kernel.org>
To: ross.lagerwall@citrix.com,
	roger@xenproject.org,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen-blkfront: Fix IO race during unplug" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:11 -0500
Message-ID: <20261107054611-failed-6.1-61b6d1df1d62@kernel.org>
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
git cherry-pick -x 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054611-failed-6.1-61b6d1df1d62@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4 Mon Sep 17 00:00:00 2001
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Tue, 6 Oct 2026 17:34:07 +0100
Subject: [PATCH] xen-blkfront: Fix IO race during unplug
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During unplug, blkfront stops the hw queues and marks the disk as dead,
then later during removal calls del_gendisk(). However, IO issued after
the hw queues are stopped but before the call to del_gendisk() will be
queued but never handled. This causes del_gendisk() to hang forever
waiting for the queue refcount to drop to zero.

This can be reproduced by issuing IO during an artificial delay after
stopping the hw queues.

Fix this by simply not stopping the hw queues directly. Marking the disk
as dead already freezes the queue which prevents new requests being
added and it synchronously runs the hw queues to clear anything pending.
If the hw queues are stopped when calling blk_mark_disk_dead(), running
the hw queues is a no-op and can leave queued requests unprocessed.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Roger Pau Monné <roger@xenproject.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20261006163411.2583538-1-ross.lagerwall@citrix.com>
---
 drivers/block/xen-blkfront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 86f5dd3aced13..ad0cb42c10197 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2142,10 +2142,8 @@ static void blkfront_closing(struct blkfront_info *info)
 		return;
 
 	/* No more blkif_request(). */
-	if (info->rq && info->gd) {
-		blk_mq_stop_hw_queues(info->rq);
+	if (info->gd)
 		blk_mark_disk_dead(info->gd);
-	}
 
 	for_each_rinfo(info, rinfo, i) {
 		/* No more gnttab callback work. */
-- 
2.53.0




