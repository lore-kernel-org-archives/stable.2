Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6BC361968
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973941; cv=none; b=KJQKBIIET6fRdSzaYuxadsN8y+NDYa7JViUqf2TBm1xUn3kutDccwu+i/LHPj8fDivKmcOhSwqAf2x162VxTe3JzZN2RYRh9l7BBUy9SsXdt2EheZkiMAxI6dVVisXhagh7Iakx0i0Oh6I5psw6vXl8ySZ0bmtzeFjyydSdCkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973941; c=relaxed/simple;
	bh=TnAOK4SuQBnzaiaegqAzbuIGDf/a9SskgtK+LamUbcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHVKJuhkje2L+WimUc+cCw8HU1bPgWhkGUiHz4fWZVCGmgSMtABxp1WiS6C+rXUQpOts1R260LGwpPHnv2Oh6bamp4UT+SK4Qj2f5EBJ6JWeTtM1eJfY9QZHGqRZPmneYpQV96r5KkNrPpX2B4eP+bY7x0kwmVEB3QQAdHPjZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os4hY8Kb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os4hY8Kb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657041F00893;
	Wed,  9 Sep 2026 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973937;
	bh=dFnvCjr7OWEG35/dsUZEkIKDiU0oWib+iUMUmS+tZhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Os4hY8Kb2vsCYzWzUP2NB962qTHjvU+BBJ8+WP/ybyLtuRchIQvewq2kSXbd6/OLd
	 nDzv5ZEnyf0huxcEfTk96gAcLU4PukYcAb34tDpFnSIAIWkLWBWt1tCjggBeL/q8zo
	 MhsKzCnp3d+UEXNqZtz6I0+4wCvdBpEqcaaEyFa9v3k1CTEeC+WqUpNnHuu11Al5b9
	 hJex9Yid+Fha1sh01Ap4oyrcJLELIV0ye/HIMBZJYY/mpcIVm6BqnRm3kpM9ipWxV1
	 fC2rMmMLeY8w/Zh6iAlb6IBSesphZ5gFUJ0wcCiknZTkg12hm3mKJJcmYSUYnLE/K8
	 aAyTIguSCluYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Ye <fy15309206903@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: thunderbolt: Release the Rx HopID that was handed out on mismatch
Date: Wed,  9 Sep 2026 13:12:14 -0400
Message-ID: <20260909171214.3227301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090349-steering-carbon-b5d7@gregkh>
References: <2026090349-steering-carbon-b5d7@gregkh>
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
index 7a448a6bd3374..f329e1d407eb2 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -625,6 +625,8 @@ static void tbnet_connected_work(struct work_struct *work)
 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
 	if (ret != net->remote_transmit_path) {
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
+		if (ret >= 0)
+			tb_xdomain_release_in_hopid(net->xd, ret);
 		return;
 	}
 
-- 
2.53.0

