Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECEF3128B6
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003445; cv=none; b=V6kVcTbIDDa8LJRFKXpsl+IbQf4Xf1Wc01QaKzRSUSpOBNzuy2zv5LKhU3bq8Nsngj5DdEi83ETIvawy7RVfIP2T56ly10hA0CEYtO1vGLNbKVV/0WlDTENSFz75X8DUDTj4vErGStYTqNikJ5RN2WavgNi5ewgRDNVFxf3r6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003445; c=relaxed/simple;
	bh=fZ0w3qe8/Nmj7Lzm/kFeSh2lxusIM6eJ24fflpucA1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug2X+vn537GpY19bXkhhG3znorl5INJ5IHwuen0OhNufnKWxXtAnCjnxemlCeTVVoisesjL3k4XAFRo7S35WA+O9QYZzFVFIh9mNKTA7Rwp9jHqK5u7i2ZFfxzesgsbktjIR4/sWecvkinCchrDf257EQQQY/qxHFK0giwUtjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AioU73Rl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AioU73Rl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916891F000FF;
	Thu, 10 Sep 2026 01:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003444;
	bh=d2ashPz1ZOKO9yoU2BJ6hwfSKJKL5ngf7L39fiaMtGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AioU73RlJm5CXQijDD2Tr2Wf53qmeziVmTMvNVEZAriXhT8ihbozVgKh18k8tIiD7
	 2SIQ//v1zfxDUKlv+M4Xx65IF657ohkz9hT3cJEl2q0N8Ikg95gOwCkivmC5fgYZlD
	 UCLUOa3rpR2YjnZYBecjA0nscKoObvlh0txoETjqhTP0DxzrRmziXhoQLh6TI+uxpy
	 mEgLy3Rf6Ar3w18AqUwad3jsWijPKT0bySG3oTnTKy2MSy1BFHcVz4+4pYC0SY9gJ/
	 fjxan4tzyNHOF4vA+K2+PsgMtwJHCcHWLkJo7PKJzuQrB/KZPFSePFJTcajLGnPQa/
	 +EDuIdAj5h3QA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] i3c: master: Do not treat master device as a duplicate target
Date: Wed,  9 Sep 2026 21:24:01 -0400
Message-ID: <20260910012401.3854605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090412-disarm-stranger-9a23@gregkh>
References: <2026090412-disarm-stranger-9a23@gregkh>
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
index add78b03c5338..af55b881d33ce 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1828,7 +1828,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 	struct i3c_dev_desc *i3cdev;
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
-		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid)
+		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
-- 
2.53.0

