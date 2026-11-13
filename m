Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540492;
	b=fYrX/h2MsyJ+D4X9okryc6pxkSlClE0nQwjN67dEWqx1xMw1XmQSPcMFJvNu7fMfDOVa
	 K3d8op/lLUizhmHVjUmLa+UxPOxXB0x322vfgIt7KMjtXPAU2t7XFQUtNz0ofnpBvD8HE
	 yQK4DaHtdOc1InUTPhYJff+htHYL3BLVKuWpT7RcQe2gVEhy2jg/Bp2D09x5esQAzfvqx
	 rXtDKMArzGlpX4nHqXP6zZL/O9Fg2q1X7HQLqGmjMmJ9ufirKfcaiNQ8+1tkxeoOW3Xe6
	 6XVPAmbD4kjdGeRpbkwqbLTE2Pv4cGfF6IVwcWFeKk2nkgRvtY/JeyWzCm1KeC7ug/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540492;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zhI3F0hMIjEpzqgHrIPj/aKTRjAs0Kuh3uEPdbSOUXw=;
	b=XmlfLPiPBpFCkce8YuGLmXwAfyXTwTQgu3ihxWc/S9qI0yqGNAxwDeEjeogKm09a702o
	 nRG0RLjGjzC+3hO0MrW9fkfNl4oWcPRiyZsqNJVS5y+Csqti5FHexPsk0owoVIVByQucH
	 AsGOH5EFHrrG+zawRcUobVrISKQ009v3GMu2eogPkSWbHKfuEjVRFViJnxclpfeihBMuF
	 xUQ/344ASlCmD6APL4GSdauFL1WXm2ZKy/uqtK6xCTL55agvFo9aCQUFAKnzO7CJNa4O/
	 zaxmErYbgrqHO7u/3wZSh0VGGlnzTRPIEiuS5kZNG3cHAYGkupcgyd4YCyYEZPiYNgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vs8r/J4j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F35606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs8r/J4j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAE61F000C7;
	Fri, 13 Nov 2026 03:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540491;
	bh=zhI3F0hMIjEpzqgHrIPj/aKTRjAs0Kuh3uEPdbSOUXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vs8r/J4jennao3PNgZCne3Oh3h7kp4nsdQrGS/uwUh6LPG9kb2BVXk4ZyAshEfhGp
	 gW5urwSR2/Txn2pcdOXnt7DubJQe+oqpb7tc2EdUF6nlm8dz2ULlDMbmveBFrFQCir
	 s6G/y/r6SojliAM45ISu4Yw0VTbowPogyRpH72DSu7+3Du99SFn63qpDnyZmwxRUi1
	 ZOX4spSdvynicu5F1UcQLHguiOV6hKoyh7BsQMknOJRg72GNdjCukUrZ8+lSWXvlfr
	 TIBZ8yBt0fpUESHwRPxaawWTcpHmbZYV8zJw0YiJlGpLfc97GWQwWfIvuB7ql9qob5
	 EntxMGY9Pho2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] nvme: unregister when pr_register() is given a zero new key
Date: Thu, 12 Nov 2026 22:28:09 -0500
Message-ID: <20261113032744.1045431-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113032744.1045431-1-sashal@kernel.org>
References: <20261109200733-failed-6.12-a9d431124fb2@kernel.org>
 <20261113032744.1045431-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit a9d431124fb2e58215daf0299d6fcf47bbc2d6b1 ]

The block layer PR API defines a zero new_key in pr_register() as
unregistering old_key. nvme_pr_register() sends Replace Reservation
Key with a zero NRKEY instead. The host stays registered with key 0,
and its next registration with another key fails with Reservation
Conflict.

The pNFS SCSI layout client unregisters this way at umount. A later
mount cannot register and sends all I/O through the metadata server.

Send Unregister Reservation Key when new_key is zero.

Fixes: 1d277a637a71 ("NVMe: Add persistent reservation ops")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe2648158..d8b6ac4d83bb9 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -128,8 +128,12 @@ static int nvme_pr_register(struct block_device *bdev, u64 old_key, u64 new_key,
 	data.crkey = cpu_to_le64(old_key);
 	data.nrkey = cpu_to_le64(new_key);
 
-	cdw10 = old_key ? NVME_PR_REGISTER_ACT_REPLACE :
-		NVME_PR_REGISTER_ACT_REG;
+	if (!new_key)
+		cdw10 = NVME_PR_REGISTER_ACT_UNREG;
+	else if (old_key)
+		cdw10 = NVME_PR_REGISTER_ACT_REPLACE;
+	else
+		cdw10 = NVME_PR_REGISTER_ACT_REG;
 	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? NVME_PR_IGNORE_KEY : 0;
 	cdw10 |= NVME_PR_CPTPL_PERSIST;
 
-- 
2.53.0

