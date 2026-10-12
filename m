Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D5306D2A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817123; cv=none; b=dTtgdTQuA3BCF6FDEsRwbZLqn9A/d5avz1w/p7s0y9+sKm8kh8dNvkC5uAX4VEXKKjskcKxJ7UeElSRZsc2ccnFVTAiWH4mJ9zeMDE4Buph1bOJbF1R/O7zeS7ynTtQQiW/D9n+94+e/3kpyARYscMRy3zut7l3NE9de54cYx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817123; c=relaxed/simple;
	bh=zWIbgFRsrJhINefREbrKrZHJCmrxaxE9Ep+6TQkQu0k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T6NayLpjevz0Vc4CaK3uI7E6R/OA8VeAL+y2xAUDTBE7WT8ffGqWLWI65NNM0gLGUqYFkXYsjsXnvG52Rl4IYR76gUGfccEAdpD4cuIJUb+4bZIwbghaecGOfykzLcde4Fx5nr6Wz8MRd6IPyDptxH68KzKnozdIqCFiAMz6yw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1qr1nhWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1qr1nhWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2451F0089B;
	Mon, 12 Oct 2026 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817122;
	bh=9YhQrp9PHlYJaLu1ATNji/iHIrV9p3TxPdHv5x897co=;
	h=Subject:To:Cc:From:Date;
	b=1qr1nhWqjuPIHJM+JoE6eWcWjZS4MDvPDGOspwLQHOE6RP7GU5u4R9piwtbZyLq17
	 xfQxF2tlpYsUKrKal8wYRsWfhh1w3BaqJE/0YZ0XIBai3cWamr4dcXfIRofxeprDrE
	 M0ZAAOdBb3E8lggQGkGR3aTh1ilzhC99Kf3p056w=
Subject: FAILED: patch "[PATCH] pmdomain: rockchip: don't ignore clock lookup errors on" failed to apply to 6.1-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:58:47 +0200
Message-ID: <2026101247-marshy-gerbil-50c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4c66c423593e26273ea0d644906ed007630c6f6d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101247-marshy-gerbil-50c3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c66c423593e26273ea0d644906ed007630c6f6d Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 21 Sep 2026 14:52:52 +0800
Subject: [PATCH] pmdomain: rockchip: don't ignore clock lookup errors on
 attach

rockchip_pd_attach_dev() treated every of_clk_get() error as the end
of the clock list, so a clock that exists but is not available yet
(e.g. -EPROBE_DEFER) was silently skipped and the device ended up
without pm_clk management.  Only -ENOENT means there are no more
clocks.

Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index b6b099b9ed5c..e193f978d5f3 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -759,7 +759,19 @@ static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
 	}
 
 	i = 0;
-	while ((clk = of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
+	while (1) {
+		clk = of_clk_get(dev->of_node, i++);
+		if (IS_ERR(clk)) {
+			error = PTR_ERR(clk);
+			if (error == -ENOENT)
+				break;
+
+			dev_err(dev, "failed to get clock %d: %d\n", i - 1,
+				error);
+			pm_clk_destroy(dev);
+			return error;
+		}
+
 		dev_dbg(dev, "adding clock '%pC' to list of PM clocks\n", clk);
 		error = pm_clk_add_clk(dev, clk);
 		if (error) {

