Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E313B47D2
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303369; cv=none; b=cnWPNv/CQfc+cmOOJij4jZyw7Iu/2Luerttxqao/4TkoTObm5UJiMfXSW/lU8hnBUgtNlKGpM3htt8xveQa40tExVvEMP7vgK4IOx2UTPLov5Hc1LFE+4ZitJ4R9WyQyxOHufppXrTTrBJTgAVcW5flNGlRR9COEmqdUnpKsFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303369; c=relaxed/simple;
	bh=jsBNgo7yP10EvBvWG8ShvFHEqp1/RXves5PbBc/u93g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbmdHqoc1YPYxhX0BMHRAV/Zzebimpkdsl7almgRSRqtTAmxFsFPSV8jphZnqUoTbb/C7d8sy8cEelpvMcSfNcGy71hYpuulbjQkL+pNBCdOOR6r+kRj1BuNVSkMXxuif/LY40cm+ldySHlNxqIiRQe0Us/rt7UInucmjjvxeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKt2Dcqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKt2Dcqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE18F1F0089B;
	Tue,  6 Oct 2026 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303368;
	bh=sPJXcRDYesi0IqYkA9xomN0e0WLL/01xeXS6kUROPxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKt2DcquqKFU6nfrIaPVlF91X635GLeYbMFndnPe81Fb84MYt7SjvFR6CgRvYzwP8
	 ++bqNGm3/PrHxK0JVqSmT7pdgdtyyWjAnG3QHovqB73abzgFyLoDI/cptXT/bIKM+F
	 AjE2S4ZFejp8fQuA9i4bfHJdPpe8bygI3AC6BeTDBp/oMd1tY9OvbHbcjhf12eJgBH
	 z6WFdB/vmc7zMDkSOAg8RkIIT8d596OvxNZJNYMgRrZ0/A908fWfVxYRjG6rAYRM/C
	 XabYO7brfxROouqtapf+fDL8+Tzqmc+RU/HU+z8w+okTLyTo2FBQPfZeAuAJeUWmU1
	 3UeqwdjSHT2ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known
Date: Tue,  6 Oct 2026 12:16:05 -0400
Message-ID: <20261006161548.852163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100505-fretted-bungee-8826@gregkh>
References: <2026100505-fretted-bungee-8826@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 4a5e49ba0abb8b4328d6318c9aef0c0121f95507 ]

The namespace head is marked zoned at allocation time based only on the
command set identifier.  If the zone info query reports a zero zone size,
the path namespace is registered without zoned limits while the head
still advertises the zoned capability with a zone size of zero, and
reporting zones or writing to the head then shifts by ilog2(0).

Drop the zoned feature from the head allocation and let the head limits
refresh stack it in from the path namespace instead.

Fixes: 28982ad73d6a ("nvme: set BLK_FEAT_ZONED for ZNS multipath disks")
Fixes: 3838e80fcfb3 ("nvme: skip the zoned limits update if the zone info query failed")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: Made the existing `max_zone_append_sectors = 0` assignment unconditional to satisfy queue-limit validation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 43f6991f964df..d2ab2413dbdc7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -647,10 +647,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
-	if (head->ids.csi == NVME_CSI_ZNS)
-		lim.features |= BLK_FEAT_ZONED;
-	else
-		lim.max_zone_append_sectors = 0;
+	lim.max_zone_append_sectors = 0;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))
-- 
2.53.0

