Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63C4CEE4D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573275; cv=none; b=cYWIoqmhekzF4MfsRtfDlTnsNxymbm/HmWRLorTh16fLh+NEO8rWHppiZJz/UvfJI5Grdhw1jaTZxhZJUjnzixb6iBmtmMJGzY8IvR4avHHoloriKdDOS9aIVWzJ7JwekTZHYtksBd7YRSNCyf5rAWs3bvpH3b4USY0QpvMd/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573275; c=relaxed/simple;
	bh=Buh2NaCr1YXxeHkV3eeTNs8vxo+J1wuJoC0NQnx0DWU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pAEN5cLa+1oLU52Iv11vPQDzsa1suEzBXxzxArkfNsi5/h51QMGqbdTb96xq4ylr7JdKqngHL5LKhRJ7TimGQ6LxyKICMtAWs68cD4pVTEn3Qj+QadriHzqJOpF+dk6kinsAk9hFuZ1sZsXxsMJlttUIN6nrkvxlCK7a7i/tRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/nf0P1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/nf0P1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765511F000FF;
	Wed, 16 Sep 2026 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789573273;
	bh=hEIAhkQ3ThjK4zKiyZDuWN5yas96zqipEJaR+rXPqYg=;
	h=Subject:To:Cc:From:Date;
	b=z/nf0P1hGU5pmSGppABCL5ZcqVMQEYPJ65IcCjZ0VpT2yejFm/7MYmVwQeDOcgDv+
	 pa57UgDdskqvDgGIJnLfi3yRXHXLdxRyFRQSQ7Auza/WmDi+Et62DEd+A+BGyE9nbB
	 HdLyzKzkf1pQxUovr69JC5qK0rdgOzjofSs+u1Pg=
Subject: FAILED: patch "[PATCH] net: macb: initialize PTP state before registering clock" failed to apply to 5.15-stable tree
To: runyu.xiao@seu.edu.cn,kuba@kernel.org,theo.lebrun@bootlin.com,vadim.fedorenko@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:30:47 +0100
Message-ID: <2026091647-cranberry-striking-e506@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e1406330d70e56dd44fa6fbafc86e77e5c80c122
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091647-cranberry-striking-e506@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1406330d70e56dd44fa6fbafc86e77e5c80c122 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Tue, 8 Sep 2026 18:39:24 +0800
Subject: [PATCH] net: macb: initialize PTP state before registering clock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gem_ptp_init() registers the PTP clock before initializing
bp->tsu_clk_lock and the TSU hardware. Since ptp_clock_register()
publishes the PTP character device, userspace may invoke PTP callbacks
before the lock and hardware are ready.

In addition, gem_ptp_init() is called from both the interface open and
resume paths. Reinitializing tsu_clk_lock there can reset the lock while
timestamp processing is using it.

This race is theoretical and has not been observed in practice.

Initialize tsu_clk_lock once during probe and initialize the TSU before
registering the PTP clock.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260904030439.3994047-1-runyu.xiao@seu.edu.cn/
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260908103924.607033-1-runyu.xiao@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 77dec2d6e3fb..4cb5d7088d43 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5883,6 +5883,7 @@ static int macb_probe(struct platform_device *pdev)
 	}
 	spin_lock_init(&bp->lock);
 	spin_lock_init(&bp->stats_lock);
+	spin_lock_init(&bp->tsu_clk_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7dac1d..6d9166389988 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -334,6 +334,7 @@ void gem_ptp_init(struct net_device *netdev)
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
+	gem_ptp_init_tsu(bp);
 	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
@@ -345,10 +346,6 @@ void gem_ptp_init(struct net_device *netdev)
 		return;
 	}
 
-	spin_lock_init(&bp->tsu_clk_lock);
-
-	gem_ptp_init_tsu(bp);
-
 	dev_info(&bp->pdev->dev, "%s ptp clock registered.\n",
 		 GEM_PTP_TIMER_NAME);
 }

