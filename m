Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E7357D0D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817140; cv=none; b=a/IrRymuXZJHDhhcgWGVND5ygyzi/STUXsUC4IlDhMFw6EjtxKYVkb4mhzuCiLS5zkU79+aGB4jIBGN30xFpaVSbQbP/IY6wq5YpdnHDIIptK+j4PdycVAVSvplwfiFySRsQ5sO8kG1O8vplPYtZfawGYEv0nb6Bu/xgziapZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817140; c=relaxed/simple;
	bh=4UAFxBKkOuOBdeg0v4vi8iyKfv/exvmr/sdyZsWC91w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VRGZeNUpTdXJ8GdiTWe1EC0sireiwqkjp+5lPczYMq6T4MPcPhohyL+9dmVxK3XhicxXLti/EcKg3gazjKeODUesBw1LgA640iKSZFzXW2U8FzK8HPNOmfmrEihxjGKm2DTd1ysUW/PBnsM4kOpS3BYLgH26zhpzVIUYueaHtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cK+RMUSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cK+RMUSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955BE1F0089B;
	Mon, 12 Oct 2026 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817139;
	bh=nvLFTm/Z4cbTvxC6+2Pf5uK2uNQA9Mb0wPVgi6QQuo0=;
	h=Subject:To:Cc:From:Date;
	b=cK+RMUSSJz20s6/dcm9N84haqshuXqRmqnFDyq982+qJvz1Xt/D48Rmd8un7eEUqv
	 A24kj0WWuJOtxfmQ0OImXY1lSvQ4G4KopUqw8J04qYYSTxI2JET7bSg0327p81vleE
	 oLAKj6vnmJHoYEm+sUrSQEij8tfBD2pp4T74BWNw=
Subject: FAILED: patch "[PATCH] pmdomain: rockchip: fix clock leak on domain probe failure" failed to apply to 5.15-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:58:58 +0200
Message-ID: <2026101258-outdoors-settle-2eb1@gregkh>
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
git cherry-pick -x d8b3847770661b7109146e6479eeadcdab9cecf0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101258-outdoors-settle-2eb1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8b3847770661b7109146e6479eeadcdab9cecf0 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 21 Sep 2026 14:52:51 +0800
Subject: [PATCH] pmdomain: rockchip: fix clock leak on domain probe failure

When of_clk_get() failed in the middle of the loop, the references of
the clocks acquired so far were leaked instead of being released by
the error path.

Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 068dd4b3705e..b6b099b9ed5c 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -842,7 +842,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
-			return error;
+			goto err_put_clocks;
 		}
 	}
 

