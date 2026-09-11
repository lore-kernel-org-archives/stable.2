Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A952253B0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085753; cv=none; b=id1Gi5PGSzeybzurCok7wdFqLpad3acMI6uJap27awKtpPuuKRxYMAHJ1O752vQ3qwxsqe5rqdC4VKuIDm17s0VvvHAvroH/q9ciRqGusa65UUqcxmPCifVKY2/FN7fk7JTxeevZAIy+/PmEOmloGiux/NsE40DC9iGU/n2fcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085753; c=relaxed/simple;
	bh=XB8lZpMyDwemWUFmnupV8F4d6G/Z7egFtqfLNBpmehU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3x6N0ChnF1/GvLUYe7nvbDSOR4CuY2rmHHT1h6IeJtTm+aU019jSTeCr69VNoCvZGIiJmFJSkvEAWXWtKUZxjG11e0YH/yQ9MJ4sdKWPTrCjWr/sfDvsroyWQTJDcXlJK0upSCBrFlVBjtGgKiMWqLxZ8U4nx3Zay1ZyG98iQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvXCalG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvXCalG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6897F1F00893;
	Fri, 11 Sep 2026 00:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085752;
	bh=6TtyutrOqUNXs8d51ld551a6eXI95+UWSsEbK78lO9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mvXCalG5H2SjKJj7x/EI9NkNa2dqF+PIsDNs4v7kjNsMxaAA45jeD/BOiK/AFwnBn
	 lqDWLH8WvtKtEZHkuCF9ifxYh60LJxOPm776n4Ev4Ch4VVBokSKk6Z54Qvb0rr7p6Q
	 E6n0WhVXF2HxDZH4LDrn6FRbg7dFeE5Gmct2Qu8u2MlXHH4/v0s2+wmMpGK//waOnX
	 konVdkjr7eTpvlqvhUOWOhGxwOaxz2a5vM77j35Tc/Zv905591o9t7U91sPbmRk5K3
	 Rhg1Q8D8jELqI4VQ0ug5b/LG55/40OWTbQVOLZFy7aYDUXOrCJaXbKSLRmCTlh2R+X
	 umNeRlYRLkDLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nvme: add missing SRCU grace period in error path
Date: Thu, 10 Sep 2026 20:15:49 -0400
Message-ID: <20260911001549.3304562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090940-seventy-hexagram-9370@gregkh>
References: <2026090940-seventy-hexagram-9370@gregkh>
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
index 331ddcd8e30dd..bad228a114f2a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3699,6 +3699,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
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

