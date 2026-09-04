Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A741A54B;
	Fri,  4 Sep 2026 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502316; cv=none; b=Gxsw/D+a7JFP4apj5KfK9YBXcdeC+wL2b7ztfvZt6N9A2VY/ZXBe80xaZnKeOpowPi4iK1ZA+eNdrwu5l4KZqFqN6JTlVycsWF54odiXCC3GIJNcespm2tAgSFRBjjFo8Q9UPl4MRufjUgDkN54pmD/N+FbxNeucDgUQGgRlUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502316; c=relaxed/simple;
	bh=VWcCSH0dCpuBnV6oiRYjSwzVUgnxtoHKJ+yXnETEx3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aiRmKgRTVhFULrJf7n1pJ0koKr6HgsjovruUycZhqbs/2jFwMlfbiQpLTJBtmPnbuJnosL0fK4TUpdTvK+gqEXhOS1IZkTLSv7FECImjJZl1ppOpRoNbQBWhgSA1/sUUWeRoh7HEbs4N3Sz9UH9gLpz8MdZyYF9KIIq2M5chmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=AXWOwarS; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="AXWOwarS"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c84a5972;
	Fri, 4 Sep 2026 14:11:43 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Dipen Patel <dipenp@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	timestamp@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] hte: tegra194-test: shut down timer before GPIO release
Date: Fri,  4 Sep 2026 14:11:37 +0800
Message-Id: <20260904061137.4037269-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06b0b635603a1kunm17d27c262ab16
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHkkdVk1NSR8aTBpPGEtITVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=AXWOwarS7QhrIVl02efjy5LRtr8InSgy0R+P+DmPuXR41PqxGFR9WfKc+qv1B4jEXVHajHqaf7ed7UJG4lgAHOpk3c9NkxCVR/cyKHXktdF/AFgfQKO6wBTtZHmfMf+Ou6hHsTbAB8gBJqWU1lqNI+pm2/FePwjoZY3AVwfuDGM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=zbYzMXzKyFZV0cyFot9tpNTeo7XFZPJwRoTE/bMycuU=;
	h=date:mime-version:subject:message-id:from;

tegra_hte_test_remove() releases GPIO descriptors before stopping
hte.timer. gpio_timer_cb() accesses hte.gpio_out and rearms the timer, so
a callback concurrent with remove can use a released descriptor and rearm
after teardown.

Shut down the timer before releasing the GPIO descriptors.
timer_shutdown_sync() waits for a running callback and prevents it from
being rearmed.

Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/hte/hte-tegra194-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index 32907d951..cca33868f 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -217,10 +217,10 @@ static void tegra_hte_test_remove(struct platform_device *pdev)
 {
 	(void)pdev;
 
+	timer_shutdown_sync(&hte.timer);
 	free_irq(hte.gpio_in_irq, &hte);
 	gpiod_put(hte.gpio_in);
 	gpiod_put(hte.gpio_out);
-	timer_delete_sync(&hte.timer);
 }
 
 static struct platform_driver tegra_hte_test_driver = {
-- 
2.34.1

