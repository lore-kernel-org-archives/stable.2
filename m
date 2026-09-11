Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136C2868AB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086565; cv=none; b=oAucfTcNqVbLNmiS4iyjKgPpxqRqPCmeEKfmMrmWXtlrQhF7ozpcqUd/zpCiwmRQcbCLwnsq32e7xqCXICqECe8KuixKCo+ZTaS6prBEyINaChBxUOTzIzT0aZcN9gEEIW7erNUQcDsmEQaXdCYR+aLNVw+fHydzpKl5SOCiRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086565; c=relaxed/simple;
	bh=D47f05Tgu8d9YUjj9oEphIe3EXSUy64XqA8XPLZmC6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6veCoHF67eJp5tiuCjDMlmjQYU2nc6yXxLVn/0miFjuc1bBh+PXWLMELCfodZZ7FORh4xU35T2XzydK4Hu4VfGm2ympzR/AAqTuYVaVQa04a+HyI0mjSt9LEyAkTuJHt1gKD4ZXZV/QOxvIHBNe/gnbNQI7e/TlDGABbeCS4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjepOPfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjepOPfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5B61F000FF;
	Fri, 11 Sep 2026 00:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086563;
	bh=iTDQkFSbRDfNf9mqrdGKpi3yufAiwK44zrc2slI/VD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjepOPfOM98Mvtg8lYo0nJnUgBCY/yLZhQVFs5ZXbdVlTbS3t4EkVS6pCb9QN5XLa
	 Yr9wwUfEYyACb6T4bBQvLFuDeqIGkTd9kvN+t2DBjOdsOQkqxOmQcDd0EGrDgbMWGQ
	 0GehU8lWVnD4COxZzcfBdTWALJqgYnBL+0RhpoO5jphOAIC23Zo11bK7UY7rjOG+oa
	 r+SA9qus/rDmA861ZCEoomsDXJ4kVrAFTMT8en0lM0M0tpFrnzVp9gNjZtQirseq1y
	 K/HS/YkUmoxY96bXTjRh1hZbbQb6zg9LPgsaKvy3u8bmqkrez3WleMKoGOJp1xZs4t
	 1j5A5PeAjDTKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nvme: add missing SRCU grace period in error path
Date: Thu, 10 Sep 2026 20:29:20 -0400
Message-ID: <20260911002920.3427959-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090941-alumni-snare-26ce@gregkh>
References: <2026090941-alumni-snare-26ce@gregkh>
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
index 0429ddda73be8..783758db4af78 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3953,6 +3953,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (list_empty(&ns->head->list))
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
+
+	/* guarantee not available in head->list */
+	synchronize_srcu(&ns->head->srcu);
 	nvme_put_ns_head(ns->head);
  out_cleanup_disk:
 	blk_cleanup_disk(disk);
-- 
2.53.0

