Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAF444707
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318247; cv=none; b=VKobd7uSCgnOZWBlCsP+6EorCe8vm/BNf20ypmm9WG0/Ax7VRlXtXMiinj4Ewk5kzo1iUYA2/mEW3nXfb+gs06c9R95lHAnglr6hAaGEZka5Jt51cgIQ459FG9/ebK92JubwyWVDsDS21qbanPdunkfIwtzb203tjCRk0g/Dytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318247; c=relaxed/simple;
	bh=p8rPoimGT7ptCryeC8QfOSdY61uXG5Zy2i3YDZacfT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ixDOIvabvoy20savM+IZzVV6r4DTHMkV4H+pp9e/UtjkieVP5xVFO5H4MClGgdtImvfRPn3DA9KkgC8puncprQX3Wgwe0H7XtzCb/XBKT69Y13RJOuwSzj90SBv3EB1u4p/wtqE2iGwsyEoLmTp2pXeCQj64QujS9yKiSs2ldFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SGxY21Za; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SGxY21Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2111F00A3A;
	Wed, 29 Jul 2026 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785318245;
	bh=Hdv6CUAl2ZtP8r7itg04sGkIZSSi8AGHfME6AfvNP74=;
	h=Subject:To:Cc:From:Date;
	b=SGxY21ZanKgQQS010HCxVlws8NAdpaQGm5+CUwA4acojtauC/lNCTgR96wFnPKPDZ
	 okOHapq1umCizsy1ZOqaN/aJIBoEjq9X4MI91dZwTDjj1spdb9AbwxKa9QpG2K3RIn
	 fN9dyQiGSlXrL9zXswmvgOZLJ6Guv+8nZJQSFv7w=
Subject: FAILED: patch "[PATCH] drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion" failed to apply to 6.6-stable tree
To: biju.das.jz@bp.renesas.com,tommaso.merciai.xr@bp.renesas.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 11:43:52 +0200
Message-ID: <2026072951-ended-spoiler-e626@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7cbba8a8ba0219a267844d3116dbc77cecb4fcf8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072951-ended-spoiler-e626@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7cbba8a8ba0219a267844d3116dbc77cecb4fcf8 Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Mon, 30 Mar 2026 11:44:45 +0100
Subject: [PATCH] drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion
 delay

The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.1,
requires waiting at least 1 msec after deasserting the CMN_RSTB signal
before the DSI-Tx module is ready. Increase the delay from 1 usec to
1 msec by replacing udelay(1) with fsleep(1000) for RZ/G2L SoCs.

Fixes: 7a043f978ed1 ("drm: rcar-du: Add RZ/G2L DSI driver")
Cc: stable@vger.kernel.org
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260330104450.128512-3-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index ff95cb9a7de5..9d9f77d8f949 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -528,7 +528,7 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	if (ret < 0)
 		return ret;
 
-	udelay(1);
+	fsleep(1000);
 
 	return 0;
 }

