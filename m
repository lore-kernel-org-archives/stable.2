Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A848C3F2
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817163; cv=none; b=XswHeGWG4QGZvhRGbQ0lTpQVQ/tfsPHP85K6dolNMkF5zuTxiPpmO+OtZqtCxi2W4SveSTigGZDwn54pt6RY4uko9w2S8boqy93XYDv5H/lVoRIfQoYeWjaUDdVlYmCPhSME5Wy4jmC1b/KOgOox2BVq2Hq+8K/jyCYpyNt+nLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817163; c=relaxed/simple;
	bh=Go9R01Sr71x0bfO04Jk178SMa18Qgk23XKdtuc4lrsM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OLe2Y5JcKoDr9Dh78HltGsOhs+xn0i0+gqAP7pZiITjT1RqDlIkgLzG6qRMxkBKEyS6+3WnG90t0AFZfq7bZioIwBO7ePm6WYvBOEQPWGNVBd0EBlMPDj2x20gFpuKnzatA/geAmXEy0BlnGxmC5My5NFpFYPHbjg5zmjGcfHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WU5VdKIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WU5VdKIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1941F0089C;
	Mon, 12 Oct 2026 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817162;
	bh=58iowRuOIjKKVjgu6+hKpgunebr9G2lqerFIK8cx/Ks=;
	h=Subject:To:Cc:From:Date;
	b=WU5VdKIippLjKuwWrzVf6/YehcjSPlXprW7Q9VtnMGTDhhHykJh1pJjdnX7plMNLe
	 ePPzpHszRxyxVAynlRr3l0wO6VcsV6biaB3/00hqxLlLld9CDbhVyvAJe9RybK6Utx
	 fntqaq43aMSRR6g2+qGQCztdKNLjzeYIPKZPk2G0=
Subject: FAILED: patch "[PATCH] pmdomain: rockchip: propagate subdomain add errors" failed to apply to 5.10-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:59:16 +0200
Message-ID: <2026101216-thousand-footsore-3cfc@gregkh>
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
git cherry-pick -x 4c0d69d677cf5b0065ebbb3ceb8ba66fddbec630
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101216-thousand-footsore-3cfc@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c0d69d677cf5b0065ebbb3ceb8ba66fddbec630 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 21 Sep 2026 14:52:50 +0800
Subject: [PATCH] pmdomain: rockchip: propagate subdomain add errors

rockchip_pm_add_subdomain() ignored the return value of its recursive
call, so a failure deeper in the hierarchy was silently dropped and
probe still succeeded with an incomplete domain tree.

Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index ba66ae719428..068dd4b3705e 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -1018,7 +1018,9 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 				parent_domain->name, child_domain->name);
 		}
 
-		rockchip_pm_add_subdomain(pmu, np);
+		error = rockchip_pm_add_subdomain(pmu, np);
+		if (error)
+			return error;
 	}
 
 	return 0;

