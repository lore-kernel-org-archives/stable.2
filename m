Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD97349CFD
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003569; cv=none; b=M3ZbAbKw1BYwBpJJXQ+Jrc4oq/KmONhg9esfcTR2RKkrYWYEGMbr4yWDCASE2jKLJ/hLqmM8z7bjp5J8fHH26c20uTfNIZxTlyeOFBA3PWMKee7Qc4KuH12tKANJKzguHFL4kdaCJ+jef7PNgeL9AtOePLrn/WLb/onb3mfNLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003569; c=relaxed/simple;
	bh=lfDlNAYq41jAVSH3yhWALmIFtenJmpgwuNn7QlnV7ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+OtTyf30uHFS+IW8mqlH35ryhsMIlcm23eITvobav5qtENrJlvf9eFJrX62LZLvNeV6nt0N+p72lS/3Uj2UwvU+W2U8zJSbpqdnT2VpYuSAl2OiMTrClk+dfCBW3jVwHK6/yvCQgnhaJlQRKNz00FJN3FUOFEVCVLnj7bLioEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbxAkc3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbxAkc3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624461F000FF;
	Thu, 10 Sep 2026 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003568;
	bh=U/GocXmrfnwxAeHAh1DMzKsQEpNITV4WUcSRjglcez4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XbxAkc3hMZNss71MD0viZeGE/a6M/tSVan/I5wKF9mB6Oq/61tS1g3vZC31XHUqdL
	 V77a3NU8DrvrBCu5t/d9eewLCY1FfPR8ZPkoQNxB2AIJQOvPUTs2yjE5wzdxVmGHiX
	 53Z4ccEVdQK5icpPT+aAOukWdZmGDCBabMIrLQtGMM5sw6qo/idV3dDEmLasJMjnRD
	 /AVHgzXzRcfUs2Sqz5xyXII/DumMtU0dnXLQtq2Btc5lACQMsQCN3EwwW1LgoviMqG
	 b0ABX8Hlsnvdoh1hoQXh6IGy4Owe89de4B3tbzUhcSkxjEpv4xsDL7tqHIMg6lIL1o
	 zkwfcjXDzdNHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] i3c: master: Do not treat master device as a duplicate target
Date: Wed,  9 Sep 2026 21:26:05 -0400
Message-ID: <20260910012605.3866115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090412-tidbit-broken-5a32@gregkh>
References: <2026090412-tidbit-broken-5a32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 4dc1b3eeba7991905a5b5b8129ebea51be7d87b7 ]

i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
device with the same PID as the reference device.  The search can match
master->this, causing the controller itself to be returned as a
duplicate.

Since the controller is not a target device, it cannot be a duplicate of
one.  Exclude master->this from matching so that the function only
returns real duplicate target devices.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Link: https://patch.msgid.link/20260807145638.168865-4-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[ adjusted the duplicate-device comparison to match the older branch’s PID handling without nonzero-PID checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 22a95b30d5aba..513aaa29a55dd 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1869,7 +1869,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 	struct i3c_dev_desc *i3cdev;
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
-		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid)
+		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
-- 
2.53.0

