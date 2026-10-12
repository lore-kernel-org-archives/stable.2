Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57683AC0FC
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817135; cv=none; b=RfFf4IA/m8oHn3aFxcJgdAFhbN26e9bGUxqceTGrkzg6yi++a/N07PGhf8PNRqkdB71nFUWGWf8VrIvPB8dE8r1E/ZW8GUZ4zhDxjjri5daZ4IxgFgFPLxGsE9R8elfUqmuQ7Te8+sTGbNFKG2hNPqmuP6z34c9plmx+LApg9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817135; c=relaxed/simple;
	bh=ajAeiCDnuXGrBBdiulU2ihRfgFYjnVUv7Mmt35cxiqc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S1K++1v9CJEKfwu4mUbAInTPm11LZL64fOz/8Uje7iWa9PxWvgc6csXM5Tw6SuKu6+LHIqcMB2dOWFmNanXDRYWjs1/o4yfLEjOMhpQMs7yAcpQGvOMOSDHfclm9dqeB6M3IsMAQ7dO2vvbR9e2LbtY5awv9pjmd8i5eMhgM5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SLsWZmQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SLsWZmQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2261F0089B;
	Mon, 12 Oct 2026 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817134;
	bh=7m4B2cNcDDl3eDDD2gQxpfdBop7n1iZ45sN1k01ordk=;
	h=Subject:To:Cc:From:Date;
	b=SLsWZmQIVsI1FFqA721Afw/KNg050vlBtUauOCP2nVBwUP8C1JeL3AOMpx73anwOq
	 jDY9vnNbIZRe//1PBRJgx/qjN6HYuD2l7LGy0hiS348it37SxXi31xF3zf+Rnj9tNA
	 OEr9nd1r3lUhOdVtGbfQtVgo7wHbitfmR2b1kGcc=
Subject: FAILED: patch "[PATCH] pmdomain: rockchip: don't ignore clock lookup errors on" failed to apply to 5.10-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:58:48 +0200
Message-ID: <2026101248-refract-surgical-1e71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4c66c423593e26273ea0d644906ed007630c6f6d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101248-refract-surgical-1e71@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

