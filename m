Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88B40F754;
	Fri,  4 Sep 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504204; cv=none; b=hq/hFSXEPfBsZDogsJP7ju2+x8uE1+EMWDRn/gtV1yn/Lb3QIE0MfA+S0bOpXTDEXTrdy+8GEW91aVO7Yn4fJAJEqnUv4v8Ldx56idyC0vV9VesZjhyiYsykEQsCQXPRFXHI/VWZuVzijMdNJ7ZALRwIWojjh9p3rIp8DUPw8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504204; c=relaxed/simple;
	bh=Ej4PrRv4m3fJhq58933LdeFykDviYi6a3bbgKXPYXgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q61FnVFNOQCnB2MCMfY5N+KlTkMxYldSEyaOfEKxNDKTQSAUBqeucgJiTM3TzbdRd29bp22QdYIa7qzei9CNNm5tF0yP4xCibRi0pcLLnFZf6VY4fgDiQ/+RyLGUptB2+XsxUxVM136KEWj0bk9AD9ofoKuFpd9WEfVMkCLKKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=NbM6IGqn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="NbM6IGqn"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c8676ac5;
	Fri, 4 Sep 2026 14:43:15 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] ptp: ocp: prevent watchdog rearming during detach
Date: Fri,  4 Sep 2026 14:43:08 +0800
Message-Id: <20260904064308.4044677-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06b28413f03a1kunmfe0cb8a92c667
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0hDVk5LTR8dH0tPQk8YGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NbM6IGqnQpueNGD4I6wRhPjEY7bdtv8VQ/9IJmgI9oFQST1pRnTEFaPmLfDmM9sQTRubWxU4kE3gC47hgRUrB93b7iFDADIYzZx7YBM62l3BSzLpJw0uKdnfxofEGx54c0JNdvCeyz+syIZXOxbU4i1m4clSAkVIJEomXdonwEQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=IbolcQ+9WPWcHbbzU0LNSe4aUlO5vhq0Fg8ZrZC7I0c=;
	h=date:mime-version:subject:message-id:from;

ptp_ocp_detach() uses timer_delete_sync() to stop the watchdog before
freeing the ptp_ocp state. timer_delete_sync() waits for a callback that is
already running but does not prevent the callback from rearming the timer.

Since ptp_ocp_watchdog() unconditionally calls mod_timer(), detach can
return with the watchdog pending. A later callback can access freed state.

Use timer_shutdown_sync() for the final watchdog teardown. This ensures the
callback is complete and cannot rearm the timer before the state is freed.

Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 3d26ec1f7..6b5f615a2 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4870,7 +4870,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_debugfs_remove_device(bp);
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
-	timer_delete_sync(&bp->watchdog);
+	timer_shutdown_sync(&bp->watchdog);
 	/* Disable interrupts on all timestampers */
 	if (bp->ts0)
 		ptp_ocp_ts_enable(bp->ts0, 0, false);
-- 
2.34.1
