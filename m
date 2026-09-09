Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F783090CD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973632; cv=none; b=oM0YuSWpJavF9weHFD8FnvBG5Rwxxb5L3vpPkAebzW7Mm0vZP3J/78Kv6saP2gTkcbyx/rBAYX+aYpKf1EC7pxRlMdL3rh09arxoIJwz3EDdHvLSLK+PQjHzc908UMXH07H5I/MODj8YsXX+wRQjfNAvQsMnotlyTDwF/RCBVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973632; c=relaxed/simple;
	bh=b1pcUas9PgstMRLJ95L3zGxooFkVGCXzpM7vVM89vCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmbPjkdVVWo7F9kZpfL6h/8UlVN4kkIFuoas4N1trOv4jczg5g9QzQRSKg4oar4W+4LxdGUql5e7ByKmKE6nutBM7HYbQoHzJyiD4I8M2WtGPcv2g3KUmGHV7r5jigBYT/30h+CwzOM9H7we3U15eoYEt6YjI6uRPyPwkfayAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqUiHmhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqUiHmhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943BB1F000FF;
	Wed,  9 Sep 2026 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973629;
	bh=6Ow+CbOSLFNazY+FN8uM4XlJ5yA5vgaKAFIRjyJlIcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cqUiHmhWQlfaJW91najJNOZzrqWS/8BmTXRErhImxQs9DkX19aerEoxCpSuLGOc3c
	 XHjS4y2qn8EbcKK6iEO93t4lvyuFi8lHhnvzpQNmO+1LBO/fn2uJQcBqsRiRjtIQP6
	 k7GTtDb1wgj9wlUzWYBIPhn/MkChJGVTprK2weYwRDw2MOnbBJvresjanw/e102MHy
	 JnXQjTrNn+itEDY1ZTnC+tljkmrMFq7NIHk7YDxL518xeXS2vTylPtz4YXZv/iY+Sd
	 lfidtAlc3U/c1VvWywR+zMzmwMh5//0iWb6zAsjLpPpTd6lQRMW+0AVp3CGItHfgWh
	 Xy1KVaaladdOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ravb: Remove setting of RX software timestamp
Date: Wed,  9 Sep 2026 13:06:59 -0400
Message-ID: <20260909170701.3189413-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-boss-emu-7014@gregkh>
References: <2026090322-boss-emu-7014@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit 277901ee3a2620679e2c8797377d2a72f4358068 ]

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://patch.msgid.link/20240901112803.212753-8-gal@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 1f77af0aaf27 ("net: ravb: avoid dereferencing an invalid PTP clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4f115058eba19..578ab58c9fec7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1325,8 +1325,6 @@ static int ravb_get_ts_info(struct net_device *ndev,
 
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
@@ -1337,6 +1335,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
 		(1 << HWTSTAMP_FILTER_ALL);
 	if (hw_info->gptp || hw_info->ccc_gac)
 		info->phc_index = ptp_clock_index(priv->ptp.clock);
+	else
+		info->phc_index = 0;
 
 	return 0;
 }
-- 
2.53.0

