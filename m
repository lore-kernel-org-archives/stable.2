Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0533672AA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974103; cv=none; b=AvvPX7TDilJstd8+maD8LEM+K6Gm/9flknT5J0d2y8SvobdEezzlMEM3v5nv8K1YmbGlJHKku+HB2r2ByO4SNI2zl1+aPHxVfmcou3f9wyQPjy/nayXDjYo5TnvWjJkdvCMY4btKbvN/4DQUfooINGfcMsX1GWzt7Kq0BrR9o1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974103; c=relaxed/simple;
	bh=sHmm7a01FgLUplYWk4eJE5MzEmYc/wqX78oCrJY9Qk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCAbIbYlQsVrYCUf33kyd8sceCMBaZZjI/QMgyxH8fUwDpqhW/fjSPxD51A+sdY8DlV+4PFAdUZS4O1EWrNwoYJqPl984xtpk9Rk98IMaL+D7dU67aS6C6gsNHfPLcIw38JZs/ZCOzRHmCPjYb2mhpaQbRwCfFsm1tjVIOoJX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAMpXJGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAMpXJGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCB61F00893;
	Wed,  9 Sep 2026 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974101;
	bh=2yCN23tVde8F6V3hIi/k41P9DDHusLy4gZ9XY+2PhT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nAMpXJGyXh+AQ5u/BS4KLP4NrAp3LDeWaNZ3d4KQ1RH0EwgdDcGIG+sb9i0HYqwr7
	 gE8CB1kQ66mDU0G8TIrZmGsd61QtIOoFisj6kP2vsB4cvyoL3E/FCkmUFwo6eGorD0
	 nZoNP485bemzK/FxsGNbHe4I37zh4xyOyb4FmU2kouDd4yCZaXBJN7drdARRPdeNGN
	 1/8AVYCw+wuxVRMqkNiH1HDsO+g2VmVgLa+nIROBfiXk2XP6s1SeHizKdb5MCSWVCz
	 s52xwq1aIn5XCczXfq/G9s0uaSKCXGJqpl2XXoHWpdicyNzqMZJ20h8nFpoD/0K/Ae
	 d+mh4dOozjhYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Ye <fy15309206903@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: thunderbolt: Release the Rx HopID that was handed out on mismatch
Date: Wed,  9 Sep 2026 13:14:58 -0400
Message-ID: <20260909171458.3236215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090349-egomaniac-herald-cc74@gregkh>
References: <2026090349-egomaniac-herald-cc74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ye <fy15309206903@gmail.com>

[ Upstream commit 2f1463554d0561a2fead81e3888604e5c1125e29 ]

tb_xdomain_alloc_in_hopid() passes the wanted HopID to ida_alloc_range()
as the lower bound, so a taken id is not an error there: the allocator
returns the next free one above it. tbnet_connected_work() asks for the
peer's transmit path, treats any other id as a failure and returns
without releasing what it got, so that allocation stays live for the rest
of the XDomain connection with nothing left holding a reference to it.

Release the id when it is not the one we asked for, the same way the
error unwind at the end of the function releases the expected one.

Fixes: 180b0689425c ("thunderbolt: Allow multiple DMA tunnels over a single XDomain connection")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260811-b4-tbnet-hopid-v3-1-9e75d1b51331@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/thunderbolt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index 7900d35096b01..fab332302e981 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -619,6 +619,8 @@ static void tbnet_connected_work(struct work_struct *work)
 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
 	if (ret != net->remote_transmit_path) {
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
+		if (ret >= 0)
+			tb_xdomain_release_in_hopid(net->xd, ret);
 		return;
 	}
 
-- 
2.53.0

