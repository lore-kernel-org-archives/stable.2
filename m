Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C33859E0
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069372; cv=none; b=sVnHeuhE3BDMN8I78VPJ9FqMeFT47Yn7rclaKigYXWf66zI7m7RVPsjsA2CvsiJta6CU1F+1L8b/orTSRbVJvRMvPwFFdchwzB6voHJVEYPdWMAxDZgUBLjxe7iY8/3yEFZHx/hiyvkAT48zrZdHpcqyotmtavAmVId2ph/pwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069372; c=relaxed/simple;
	bh=Fz6ACYP/Qa/xab2tdBCi+B7H5kPPc4Q4dr22bPc7NrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abZLvXjJLjXbrKPG5TARTXxt11AwBK2a9ttBNCxz5VZMOowEkjHXG41FXB16yfke1PVsOJc5d9PWBlf+SoMzgllz4raIsDIne52DbKa8oVMGwRXjO2Kfd/huce6PcFvEZH5+2NrGG7ZH33xmbF71P118E027B4d7H47r5rb58/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc8XOEg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc8XOEg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ACE1F000FF;
	Thu, 10 Sep 2026 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789069370;
	bh=Y/uZhc6owDYUak9SsgVWFx9u00Z/nY/mz5tk4QyZEj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oc8XOEg+YXwi8WvpettsrHh0sZX4SF3V9p2t+E4R7PIjEgqZ/NzV1Li/i2/mS1D38
	 QCejmJFupgyEaYlOsQbuNio8U0WUbKB3FDmQKAD5b/kFiijlUdxryAcYIPN1v03P/M
	 zXVfjPLSCQRHsIQKzO0O6TAA6DPVQbW6x/r5PpOm0BNgdrBAY5aImGF1LS8epEyF5H
	 A8icTCgrbC0ervnQnWgpUKrQeGUowJg+boFNlxZKZ2rXpi4RSahghuU1faH0GrfR5J
	 GHLe5hWjeNRfmqa8dQksT+SAy4n1Q9LMp8kIyA/ZWudBUfdYpd1jI1ehIS8APcgK/z
	 MA8BBCwPwyKWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nvme: add missing SRCU grace period in error path
Date: Thu, 10 Sep 2026 15:42:48 -0400
Message-ID: <20260910194248.1586769-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090940-spray-energy-c72e@gregkh>
References: <2026090940-spray-energy-c72e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit ef248d5de4469fb6bbaf8dbe0c4c47800080d648 ]

nvme_alloc_ns() error path at out_unlink_ns removes ns from the
namespace head siblings list with list_del_rcu(&ns->siblings) but
does not wait for SRCU readers before freeing the namespace struct.
Multipath code iterates the head->list under srcu_read_lock() in
nvme_find_path() and nvme_mpath_revalidate_paths(), so a concurrent
reader can still hold a reference to ns when kfree(ns) runs.

The normal removal path in nvme_ns_remove() correctly calls
synchronize_srcu(&ns->head->srcu) after list_del_rcu() to wait for
in-progress readers. Add the same grace period in the error path.

Fixes: ed754e5deeb1 ("nvme: track shared namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Adjusted patch context to account for missing last_path reference-counting code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b13427d0a8a4..cb36fe02c6457 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3966,6 +3966,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (list_empty(&ns->head->list))
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
+
+	/* guarantee not available in head->list */
+	synchronize_srcu(&ns->head->srcu);
 	nvme_put_ns_head(ns->head);
  out_cleanup_disk:
 	put_disk(disk);
-- 
2.53.0

