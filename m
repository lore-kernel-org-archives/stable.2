Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F224D37A85B
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067254; cv=none; b=eEuF7Wy3dCTHckvlqJ2kFR5vBzETVLxOESlZeUt3cP7xWZdpNFXasoeyGEGID4yLI4T7xpJPmqPQYudA3TFyUZogvKk5dXS/eH96/nDKDCgedYCfZd0gsoFGPFn5gtueDfXux6ZrsgMHSjdQ2j4PBxluAi2w0v9KaUE5QAk7T0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067254; c=relaxed/simple;
	bh=OEBFavJIwstfEBeUSAKsAQgg31ygshCBX8YFeojBcZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INWc+FUuDFTVop8VH7WMKmBF55n0dxHwM50nFU/6fMh+qLwfvEIorspsBthEhGiqY4wfnhJpTISDvLy5DPyANSVZQVigMAgRNi+iRZWeXrRP83wyH24PScc198+UQqJLzNo0iY9idgWoIpChkXhqws8hRuzBUPINXM7djCP50Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpM38HwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpM38HwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E641F00A3A;
	Sun, 26 Jul 2026 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067252;
	bh=jYjGSLaz9/Ek4sVii/PT9bMRhjzBMWB3OE2iNHTAGYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MpM38HwNyjlhm5GmeUY+s4UeALXwTsrDfH52oC/KpTAwnCKtdVv2Jr4Eyf2ZnLNDL
	 euIDZSDIrE95oxWoWhP0QIUMA4jWw9w865iK/aFr1WMQ3SACT+fogT1IHBqiQ96B79
	 Jj4KV8u2exJSokMwQeBER7/oa6arrkWL65gzdyCd4VlnzbMDc3STiEO1lw2NOCfpuT
	 bld4VgxF1abcbMGAy/NzoBnDSKhE85hFHazxwqEZzrS7gTrhYJjq6Ozx6lJ6sW8Y4d
	 i8Gle8lgXeOAk97vqBHlNOJxizosnxIG6Rrq6xRx5y1jkYijhROEPfi5zVxyUd+3S7
	 44AUcoKTY/tug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] thunderbolt: Keep XDomain reference during the lifetime of a service
Date: Sun, 26 Jul 2026 08:00:47 -0400
Message-ID: <20260726120050.4138299-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072000-karma-payable-51b3@gregkh>
References: <2026072000-karma-payable-51b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 8b4060998637f06975fceee9b73845d8672d411e ]

This is needed because we release the service ID in tb_service_release()
and the ID array is owned by the parent XDomain.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Stable-dep-of: 2c5d2d3c3f70 ("thunderbolt: Prevent XDomain delayed work use-after-free on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/xdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 458476907eab05..fd2356db934fe3 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1012,6 +1012,7 @@ static void tb_service_release(struct device *dev)
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
+	tb_xdomain_put(xd);
 }
 
 const struct device_type tb_service_type = {
@@ -1120,7 +1121,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
-		svc->dev.parent = &xd->dev;
+		svc->dev.parent = get_device(&xd->dev);
 		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
 
 		tb_service_debugfs_init(svc);
-- 
2.53.0

