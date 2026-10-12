Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9D357D0D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817160; cv=none; b=eBFVaFCQTu1cgQ2MR03bhbQfrU+b/+YX1suqt/8GATGTsF7yUMW+1ff92bW5ZSfeRb4UiGsvpe/oCQ2YfI1Mbxfj2KX6sLktk03ZMgqVqwghiNt12lmEQF2sPHZG2ooZTbaln0zNDFsYURiMuUvGEI9KIBLJdNT/3b9RKLnaBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817160; c=relaxed/simple;
	bh=zpBkdBhMJ1hvLcOHQdPTl/JWXZ93kIWI0RtknUhqIhQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f3ZIvXUy9+eW6H7RvT0t6CC86svd8ABkTzOtLph88UIjrK/TTEAMEtOEc9ByzPz7A6fquoX+mYBIKTZPhj2jq9/04udu8PjbVnmDGORbm/Jq1CCntYgq24ndRh0668QHTfj3VnFT5daJUhVL5EV/B/ZSzLjVpU8Ffa5MFtdOnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qd8JEZ2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qd8JEZ2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8EB1F0089B;
	Mon, 12 Oct 2026 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817159;
	bh=AwH4q+n6b8qvfFAWjtd/1FA2tKOpB4PShCAZAmnBQko=;
	h=Subject:To:Cc:From:Date;
	b=qd8JEZ2JuQ1+EDgra0vTb23c3QnQI+CYWRZHC7O0FFRWigvQJ+9PcezXq1+XR7cu2
	 sLTZCvZwn6Y8B0nZGCihcikK78lAyCZoe0WrPrCio7khPPL6SGkMj/KG7gXTxHWCJT
	 JK3xpIXzMmwFm+1Yf3SFMzAS8bLsa60B33NE6Z5o=
Subject: FAILED: patch "[PATCH] pmdomain: rockchip: propagate subdomain add errors" failed to apply to 5.15-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:59:16 +0200
Message-ID: <2026101216-brunt-lubricant-e88b@gregkh>
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
git cherry-pick -x 4c0d69d677cf5b0065ebbb3ceb8ba66fddbec630
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101216-brunt-lubricant-e88b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

