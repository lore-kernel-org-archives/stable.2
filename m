Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C41A6834
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085993; cv=none; b=IxsubCYM+MMNE1CoZdmgurTMO9xUUkL1anzpZ50hAUA46xA9zxbHWDpANWraUaApTLLs7CztlrAff1R88dteUTypwwshCmSpowYqEj0mSsO/GuZ94olVxGUqfIqI/lHdUV8qpNFCAsJcVBdfGN146csZArhLYrWbjkHtRyqQ4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085993; c=relaxed/simple;
	bh=xGajH+Q99N/P+RVUNpJK1L7q1oqoGhQMpZXKQ96EN4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVio9T3dTkbxGhkBFqHL8lCFOmx9cSAH9cDrcZhVophU6Uo4Yh71mJsmMl78W0KAtA3gE/kafStPshoKBPBhddgxqxM9TzcDnG9s3go0+QxwO4fdLqTpeuqyV3R8zi8Xo3T8XIah62hLGJN0dWpQKJl7G7EgxUJLw2HZABFa4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdYRzSy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdYRzSy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C6D1F000FF;
	Fri, 11 Sep 2026 00:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085992;
	bh=N1s4LurwplUVlHopjwTle18uPNXt9lCevZbEmURxHWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HdYRzSy898NF9r5q44sVsuI17DN6ULrLdgFMw+Tcm/AiuRJQVymlndz18FDfMVSjx
	 tOFPwE3O26z5UuG7nzuujvjhN+RZINAqK9uEjA9DvMtN2ZOMLJm/1Ee54QXZYuPSGY
	 EcajRqzIthK5YhbZGISTfuN+e3bXEn/fVL9PMZFQY0ANIo5uRGKw08X57uqDIQR058
	 SlHNWkG6dQq5n4o3JrJUoKEaLoV6eDH69W8tCTxJjuB5UNpyprHFIRwuBWPG1tNUc1
	 XOacMzkp+KMh3vnP1D8S8rwJ07Oq1MDdMnrII0XluowqXKaK7HoY7vOZeEIzdU4jnY
	 4ZQljVZuTsuhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nvme: add missing SRCU grace period in error path
Date: Thu, 10 Sep 2026 20:19:49 -0400
Message-ID: <20260911001949.3344611-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090940-antiviral-matchbook-0634@gregkh>
References: <2026090940-antiviral-matchbook-0634@gregkh>
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
index 636d3ef5b2d1c..028bd3e895961 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4437,6 +4437,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
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

