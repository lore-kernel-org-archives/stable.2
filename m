Received: from 3b.pm (3b.pm [159.69.114.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422841685C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.114.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055298; cv=none; b=T93pojub4s6dDYeQJKbK1nTy3Rlz0muPtzPmezvxY90evM7AgryNpzhn+CvtZme86E1CiizHlpceqLz/sX5Xrhl4vEvMRec+hqJb9rQC73x3CgWqDep1/UPvrkTKc+o44oa6k/GmF/lTv7oziooCFGQBAfetVDSCDqBODzbOjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055298; c=relaxed/simple;
	bh=gVoB2ci4hpevgHpegJcxBmgUKOWDJKi0thjwhYL4g6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ1zNyx2LoJPj8CkvGSCT3MuwruQqakrdoWYNrmdwRTpmkHtQlSo1WeVMKFWW55xGkIkc4BChuTtMaJDxVswl8fjto+DpAnvkexlM+Z+L9foGlsPGnxWzqwRf/+/CuWXEc0UzyQMb+lIYRMkWePC6/SjUU57eiVUINKVPpb4Owc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3b.pm; spf=pass smtp.mailfrom=3b.pm; dkim=pass (3072-bit key) header.d=3b.pm header.i=@3b.pm header.b=SvCMH05k; dkim=permerror (0-bit key) header.d=3b.pm header.i=@3b.pm header.b=zvY0HuEY; arc=none smtp.client-ip=159.69.114.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3b.pm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3b.pm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=3b.pm header.i=@3b.pm header.b="SvCMH05k";
	dkim=permerror (0-bit key) header.d=3b.pm header.i=@3b.pm header.b="zvY0HuEY"
DKIM-Signature: v=1; a=rsa-sha256; s=20250428rsa; d=3b.pm; c=relaxed/relaxed; r=y;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID
	:Date:Subject:Cc:To:From:Organization:Content-Type:List-Id:User-Agent
	:Thread-Topic:Thread-Index; t=1787055150; bh=csibZ6lGZuCtYOGckI1w+5DALj4vNX
	5cf1HhE8Q//0s=; b=SvCMH05kCTH773GPw6a7n7oHfYXthpSGR4Xx5NpsFBUQDM1PvwYUnD0xi
	Hi32M6kPGHDiHaiAEDtIo9+zJsShtE9ETyPdSBX4ljxW5eWaaSg9yZma6JQXzvTwOg8LsdjKJPB
	fKCT1/IyrNgolpnofKvbMFkH1LpHjPvLLwFEhOjP5Vr/eZV0LinmlknlF3gqgFiO3TzE+HUVldi
	e9dyFK0Qrf3XxdWvqXGQ7ewn4lob9hg+kaAS3eNj9T9wEHOAxIE6uMhdjIhdJ8+jQz5wwZxM20W
	LXXasadGykda2Wn0v/Rcw45oKYhSUUCDj4PNwmohmZHv84lXX6xMOefIxGzNLJET8vjV2jOyxBC
	G2D34XEyRYuSxMhciXPQ9fQnsgXqHghBTX01vl36RvxzYoCaXl/9UKJYpmazsFV5r4/sRV3ytUY
	/YamYmg4OdB4bmhX5FJWr6n62YiFPuLLS170D2T6cdSZLExeKryLtJ3NxKQxn3er44TZOlPPqVr
	g5i+M;
DKIM-Signature: v=1; a=ed25519-sha256; s=20250428eddsa; d=3b.pm; c=relaxed/relaxed; r=y;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID
	:Date:Subject:Cc:To:From:Organization:Content-Type:List-Id:User-Agent
	:Thread-Topic:Thread-Index; t=1787055150; bh=csibZ6lGZuCtYOGckI1w+5DALj4vNX
	5cf1HhE8Q//0s=; b=zvY0HuEYexZTyc5E+JeMzGzO5DLwxQOrmK1KMF79BYCGwkbDWTYDxbc92
	wzewwdePqxLIqPFbGtieRiSm52eCg==;
From: Philipp David <pd-lkml@3b.pm>
To: stable@vger.kernel.org
Cc: Philipp David <pd-lkml@3b.pm>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] igc: fix netdev not re-attached after resume if interface is down
Date: Tue, 18 Aug 2026 13:54:07 +0200
Message-ID: <20260818115405.25997-3-pd-lkml@3b.pm>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026081708-decrease-satchel-2a72@gregkh>
References: <2026081708-decrease-satchel-2a72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__igc_resume() calls netif_device_attach() only inside the
netif_running() branch, so an interface that was down during suspend
is never re-attached on resume. It then stays in the not-present state
that __igc_shutdown() set via netif_device_detach(): ethtool reports
ENODEV and every attempt to bring the interface up fails the
netif_device_present() check in __dev_open() with -ENODEV, silently,
since __igc_resume() returns 0. Only reloading the driver recovers the
device.

This is easy to hit in practice because NetworkManager brings managed
interfaces down before sleep unless Wake-on-LAN is configured, making
the adapter unusable after every suspend/resume cycle with WoL
disabled.

Re-attach the netdev on every successful resume, as igb and e1000e do.

Fixes: 6f31d6b643a3 ("igc: Refactor runtime power management flow")
Cc: stable@vger.kernel.org
Signed-off-by: Philipp David <pd-lkml@3b.pm>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260804222205.1580328-11-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit b0ce5fd9fabe7c79463cf4602217d4dfeff5b1fd)
---
Conflict resolved cleanly using mergiraf. Backport tested on I225-V
hardware, suspend with WoL and suspend without WoL both bringing up
interface again after resume.

 drivers/net/ethernet/intel/igc/igc_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6fcf4fd7ee19..ecc33f797e37 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7405,11 +7405,13 @@ static int igc_resume(struct device *dev)
 
 	if (netif_running(netdev)) {
 		err = __igc_open(netdev, true);
-		if (!err)
-			netif_device_attach(netdev);
+		if (err)
+			return err;
 	}
 
-	return err;
+	netif_device_attach(netdev);
+
+	return 0;
 }
 
 static int igc_runtime_resume(struct device *dev)
-- 
2.55.0

