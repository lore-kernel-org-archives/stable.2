Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7F306D2A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817132; cv=none; b=ZBd1bUeDgLmsD9g1Y1GjkfJT7fxU/gx3C7/VhR9K7jYwu/0tRS0i0KV+O3xWxCBPypJ5m6ARBplI6ziDH7pYBdUrF4JNngO9cuvxgZVM/fz0m8twyeEY69HYJM6d8cIeFB1Zg8g8PV1WJMcT2fJ+VZAB6K+ymtYn+6NQ27ldYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817132; c=relaxed/simple;
	bh=T6wqyflYuFmEXjav/qlWwVP7ItyCi3+CHenv5Oo75I4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EMDxsgGZiv3lC1HhVaGpxY13XCc6DB8aF5sLoayEE90HbyGN5wa+ewj5QwfzpBa355BGdr9C5oxaCe1OnbOp3zpVZovRspgaOs7TbcAT4802toEBheU5kipkYnmwZ94hp/hUMjRYI7bndR/Xjp1/p5A5zh6VCjCAVvRBvkFbaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P/1jon8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/1jon8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C4A1F0089B;
	Mon, 12 Oct 2026 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817131;
	bh=e7tizrhwC8kNHVHHe3vp65/709skwv+4QHdRyCN7A3A=;
	h=Subject:To:Cc:From:Date;
	b=P/1jon8NNC1iIlzPsnfJjy5Xmy6hdQklQRYFJk8BiRF0anC9RhjO3GxTtzyoqw8Qc
	 mJAoJy1RCgJP6/cDum7JtYAMnXqjJTruUr+gLifChxHFIrABCfhtd9KlAtLMVJjTPk
	 QSmDOZZ26A4S5stoUUX3n0AZMn2ueFNvhptlbm/Q=
Subject: FAILED: patch "[PATCH] pmdomain: rockchip: don't ignore clock lookup errors on" failed to apply to 5.15-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:58:47 +0200
Message-ID: <2026101247-chapter-smitten-cd41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4c66c423593e26273ea0d644906ed007630c6f6d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101247-chapter-smitten-cd41@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

