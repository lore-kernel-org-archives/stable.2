Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73235C690
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439804; cv=none; b=DqF2bCivO/mZWzyEJNb1Ho6XIXM+hlfLMGhpO/7L+YIbQ+Q8M58ifiDeGcAYV0RyKkSfy47p3CQJmgAxuTYzjDZ+w0l+GIB5KA1M0jhGimqb2RhT1PB1V1JFXI25aUTGdB4ROnFuUkSr4tIkB1MTyut7xZqNBmiRu+rxOvpIVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439804; c=relaxed/simple;
	bh=2hMOqgeAHBmXAt2NmErg3pJ3buqwzj+bmwC7PVpVXNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugxRQd29cslgUE1pmeJvlmiQYIbULrayprtpgfYE1DZ8SY+RKVEg9djomi8l82dWo7Yd9nK89a+EPKsB20tp8ZGF5v/60WqVonydPfHoWNdYlYFTW0aUDJiGH9n/8CFmLzWMX+/xbLsjDfsnoJyahoyVtu3/xWDwPjLvOI7jY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+KLLEjR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+KLLEjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE31F00A3F;
	Thu, 30 Jul 2026 19:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439799;
	bh=eyubPnzDzrxecEuisD3YX1dytdLa+ggwQlgufiB++Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+KLLEjRoIjKItgxiIzS6od8kosMndl2KMQEaBewrH2z5ryvCujwCa74B2K+8oT1b
	 74979nFUwAW4hh6EZzVBbpPz/wcZhGIERpo2n8j/1Y/umJnLN5mjQnCePwGxha461c
	 1WemyeHx3FB/j+lQhDK7IZJu05ylDGPkdoLpVVNQB33GYfdiIC5GNwMUUKwxCtxtgF
	 geupwoJSBXhl3cYRtHUtStW02Z4se5Ri47KBUO6yOEpkyhq5yaQhUhb1PmLR5mZLgv
	 PL3NNa3rmjGvaPRUg+7N3IfhUv/s36yn+4jd6H9lUjW4lmntmPAzxRZyYhniyf+/ns
	 vea4VRuTEl6sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion delay
Date: Thu, 30 Jul 2026 15:29:55 -0400
Message-ID: <20260730192955.3124753-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730192955.3124753-1-sashal@kernel.org>
References: <2026072951-ended-spoiler-e626@gregkh>
 <20260730192955.3124753-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 7cbba8a8ba0219a267844d3116dbc77cecb4fcf8 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 6cec796dd463..a9216a99b2be 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -238,7 +238,7 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	if (ret < 0)
 		return ret;
 
-	udelay(1);
+	fsleep(1000);
 
 	return 0;
 }
-- 
2.53.0

