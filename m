Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5534446F9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567734; cv=none; b=M04Ha+cZzqJukf9VSLGvD/EbwkGT/vgOvOmNpzVKuQR6DC2P/nzpMYRmRP/b/B5GMwqG18265njXqxLRr+D1JkWtvpe1Y+zJKnZ5m/OxoNzm02AuFyu8C4+Xlihkk+ZKuXx0NVp+Pes5p1rwBnzpUv/ZfoxrRk75nqNV3w4smIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567734; c=relaxed/simple;
	bh=vJL4VpDlagCdTco1HSnsO1SutaF1aIXKk7ZDpocEW6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6OCAkIvT5pnDSbFu2eva08wpCYWY0IOGaqlnmubu/lFEGyB4ekTAUQCHYHOE62A3P5xxFBV1rS5WrL+g/ON2+7rub9jb3szh1kmC+2BGbHVgIwELI15WucyUsjEm3oVG7pkQFBy4pt12/9KP/R220XoLsCSr+vcZPEZgTS8nv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEG8aN3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEG8aN3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBAB1F000E9;
	Mon, 20 Jul 2026 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567728;
	bh=yNU03f5z66qikIHhPq382zUd1zuALvbfSqI/i+ve7BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEG8aN3fjkT4Qbaz0lz1mICPxJAaZSYc6MvB4en6Y45DBSgGwwkaMipcXTkXVZDtC
	 O5VUKElO09IS4XV8BaQl33eylwL2XlZT6Hn6pYM54yeOaikdED7RNaQseOOeQh4CIp
	 uvJM/Diz9ffHQMYOOp9yhElH/ty+kaZt6eNXVXs36nlDlD+z49E06qweavkYGRqokY
	 dGCHVb/J41/Of/fm/UkN+GwweXWT0LkSejq+Bz1jmcFOvxWlNMGGGgmEtGRQoF1QSq
	 CCF2f0f1yA3O1CsH9pVLOPyR3y6ijAzRBZz1GdBwuIXLkjYKKBJqtIBWMyjM1N3dHs
	 xmyIDl4A2YVWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] nvme: rename nvme_sc_to_pr_err to nvme_status_to_pr_err
Date: Mon, 20 Jul 2026 13:15:22 -0400
Message-ID: <20260720171525.2695254-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071540-stiffly-shrill-b8b3@gregkh>
References: <2026071540-stiffly-shrill-b8b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiwen Hu <huweiwen@linux.alibaba.com>

[ Upstream commit 22f19a584d7045e0509f103dbc5c0acfd6415163 ]

This should better match its semantic.  "sc" is used in the NVMe spec to
specifically refer to the last 8 bits in the status field. We should not
reuse "sc" here.

Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 53cd102a7a56 ("nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 1df7cb31556011..a50bb3bb97573c 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -72,12 +72,12 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
 	return nvme_submit_sync_cmd(ns->queue, c, data, data_len);
 }
 
-static int nvme_sc_to_pr_err(int nvme_sc)
+static int nvme_status_to_pr_err(int status)
 {
-	if (nvme_is_path_error(nvme_sc))
+	if (nvme_is_path_error(status))
 		return PR_STS_PATH_FAILED;
 
-	switch (nvme_sc & 0x7ff) {
+	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return PR_STS_SUCCESS;
 	case NVME_SC_RESERVATION_CONFLICT:
@@ -122,7 +122,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	if (ret < 0)
 		return ret;
 
-	return nvme_sc_to_pr_err(ret);
+	return nvme_status_to_pr_err(ret);
 }
 
 static int nvme_pr_register(struct block_device *bdev, u64 old,
@@ -197,7 +197,7 @@ static int nvme_pr_resv_report(struct block_device *bdev, void *data,
 	if (ret < 0)
 		return ret;
 
-	return nvme_sc_to_pr_err(ret);
+	return nvme_status_to_pr_err(ret);
 }
 
 static int nvme_pr_read_keys(struct block_device *bdev,
-- 
2.53.0

