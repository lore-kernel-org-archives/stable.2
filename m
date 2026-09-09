Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734F332EAE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973568; cv=none; b=m1BBAmiWYr7eBdm3SJqQ+o9vT4bufZ8Bv2nCE7rO5aHluf/GgA6JlQbwa8sBWucOYYkPyy7d604bDYfpEH4mq2sG5Xmvd3BVgoKh3Wcd4CnBfu0/sInOA+nxWNKH6IWNq0aVQh61qXEB3/X8tT8ZFHF2fkjIhiwgoiYrod2KaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973568; c=relaxed/simple;
	bh=V2mHaMSm73sJtJK/Vy9tAiTqKuG3nIJNCzhYPZqFykU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2z60Ko+NF4aVloiWEhCoIP8112vWi6eAlF1gQIVUXLiRuBprqqvFRrYaWTPI4KKdQJXDgHLjskkDpXBuFyioYGHr9HvLbxuzUyRBLPEJMY20qWzuBWpH6UnNrH/MWMDp0mPx3XlDo8e4jr22djxe9wEGymOwNuuj6zngJf0tmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGl0guCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGl0guCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722751F000FF;
	Wed,  9 Sep 2026 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973567;
	bh=SvbzFBItj/0UTBqMjEbXZKPb+ulV7JgKgEXj5laJoNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGl0guCIhYNrwiWq5VUGTuEj/oBa/UvNfRfFlxbx7qdSSMqcvri3cu7j1uTq8Sims
	 J5AV6SgH3AxaQOz0KiHYXR2DVSL1lKDE7+Zyed+4VpPXG4uxW7Vtzaq1m21vpPFxDt
	 mckuI+MqsSWgFeF3FKuE3650kXtc7nrOqnCbRe1LwenXVAZkmYotzHlgjNMUV2bnj8
	 YKhDdo8c/R1rMLQxzmT0ee6SVY/PeLPWRb9lE0oEM2agjEe0ZaPzG7OOmoeLuxDQ7H
	 tC0IiLuYWFpsOoUA/Z6GGhtRfUXas8zp7apVDj4OV6vXuIHEobKortvJcABJ761x75
	 1YUPuE28LiEhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable
Date: Wed,  9 Sep 2026 13:06:00 -0400
Message-ID: <20260909170604.3185721-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090346-clang-google-039d@gregkh>
References: <2026090346-clang-google-039d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit a6ee7f19ebfd158ffb3a6ebacf20ae43549bed05 ]

nvme_pci_configure_admin_queue is called right after nvme_pci_enable, and
it's work is undone by nvme_dev_disable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
Stable-dep-of: 08660a5c8d49 ("nvme-pci: disable controller on admin queue IRQ setup failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 660e8fbb18136..9d67043aa1fff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2701,7 +2701,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
-	return 0;
+
+	return nvme_pci_configure_admin_queue(dev);
 
  disable:
 	pci_disable_device(pdev);
@@ -2894,10 +2895,6 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out_unlock;
 
-	result = nvme_pci_configure_admin_queue(dev);
-	if (result)
-		goto out_unlock;
-
 	if (!dev->ctrl.admin_q) {
 		result = nvme_pci_alloc_admin_tag_set(dev);
 		if (result)
-- 
2.53.0

