Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A334415F3A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749043; cv=none; b=U8znH0EoIJag9vs4xxTYaui5T1nSJWQgbchqEYRXwdAon61ynCIMScofn7NMu6GBbDK388IinY0pR1ddpoC8UjY5RSCLrz62es7kuMz3FZqLXl4EEuTjMxdoFPuSKFaGK04Wo2kGJ+T0Cpaw5fj8adNz2HvKzd62oebLAe0qs+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749043; c=relaxed/simple;
	bh=s0bSpZt4I5Mfa7qGfq8GiOKPWHitCaJW2h8ZH8oJGEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gR0wkmsZ6QhdXujeXJPUvVmV9HMirnM2ntpqHGgWLbC0wbrWWY8KjTEsxrg0VHOPlut/KizHoDTtKvWq2WIhixr9jLZu6H+wzBA4S2seC3M6cNu6AFzu2ud2jpU4ZIllM5YdluQns1noAhAqpF015FODttxek1cM7F7Gx+FQTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPFgBIBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPFgBIBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7041F000E9;
	Wed, 26 Aug 2026 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749041;
	bh=L9+pptBaxrXBbsHE8hoiIH4FwTvvqb4muzFeHW4u13c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GPFgBIBYQ83SuVx36Wpa6m4SC8c9N7DdOD+hgjfzgZtKX5YA6Zd3KlzusY/trbOcF
	 rxbcbOITARuNBXwDl9l+u+MFbtdonYW0K9sSVU2XI343W4Tz19OCmwwWZrZqVxPWiK
	 U4hJG+ccdJTHtiTz1HvGm1Cp0NaSFH+Rub8h+5lfqKW+suptGlv2pKQOMjhce0NPdL
	 Jwodr5rfPpZ3cKxsNx9NN/NeScthxAoWGIoUVM0dcWRwImdlFohbdj/QVrWACCABNQ
	 j6XD1v4t23sERNyMBN1C6ATwC/Xw9/trf8uldFNy07KUVUMgHp6cW0ilAvkA5PRwcJ
	 n4GTiUv5cvY8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] nvme: rename nvme_sc_to_pr_err to nvme_status_to_pr_err
Date: Wed, 26 Aug 2026 08:57:16 -0400
Message-ID: <20260826125719.2952832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082515-mobilize-facelift-6d03@gregkh>
References: <2026082515-mobilize-facelift-6d03@gregkh>
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
Stable-dep-of: 4a3f00262a04 ("nvmet-tcp: bound SGL data length before allocating command buffers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 1df7cb3155601..a50bb3bb97573 100644
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

