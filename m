Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C7476CD8
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817146; cv=none; b=Ts8BWf/C6R8kNdfEa6Vhga5x0pfbd6SfaaNzNTqWxHkwl5yI+0tzLgmpYqn2KxXFv3DMwGHsrbv1SN2orPurNmFPuzLuYUCIVbiYHm4J1zoul/46PHav/dgtjeEQkouE7/9JZ1+KmRAu0M1V80XhkBIgqI/7/xpAZP6Eyis7Sxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817146; c=relaxed/simple;
	bh=n4+pirHmECpGcs/KCosG/xSIQPASraNYVMJA3XXFfvk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tXDgzDx/QfxeeBhBJynnbDNhToIKd629KLbJ7HDYUMmGdOURUzuuHi8iTptJZEYR3E3dz3roLygfuubMQ8ypZE/sxzlOzUn7CnaO5/JIqMXIaVr5iSORaRnfk48RvCJ6pQDcFOOuUwG2Wg9gMEj89l005QZ0eDe7Oa1X9UxjtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZsJyBgHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZsJyBgHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0981F0089B;
	Mon, 12 Oct 2026 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817144;
	bh=Y6OIhF2gQFM+oHz1DCm3XplrSJN1iBXizE+sOwYQZJw=;
	h=Subject:To:Cc:From:Date;
	b=ZsJyBgHzx4Pw5KQssAUZ9MhVS05Bs5DdztdgI/km4gBb4rOz9nKXQ96xyrRR6fA10
	 L4mW/yeebAmPDy4VHegQx6CN9TP8xWnjjo3dxHDoI0Iq9hMatN/htapDWCPWHml07Q
	 LOlt4G9h5m5TMjTFq41tI0KqzjxhPXrIKw4Ba28g=
Subject: FAILED: patch "[PATCH] pmdomain: rockchip: fix clock leak on domain probe failure" failed to apply to 6.1-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:58:58 +0200
Message-ID: <2026101258-reforest-facedown-1968@gregkh>
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
git cherry-pick -x d8b3847770661b7109146e6479eeadcdab9cecf0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101258-reforest-facedown-1968@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

