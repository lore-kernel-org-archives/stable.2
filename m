Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357463;
	b=sJdS1eyXJU+yz0rd4ma224GDOGddPHu39FmEeaAbg9IIFIGHZdYZ3WLIyb7tzo+nW6vT
	 XYup/2gM4YpidBreqGwkmTrYdZJMU0XGZuahl5qAlfElZGH3zgUMEggRokCDDqXWcUqd2
	 RYjbreR3cabVwQs0tlKOx97hmm02D10xA+s8E8t+OYKrs5szvaEku856tM/53mpu0SjcW
	 y7h27hjX5aUD/Ss9wwh2lWWaW16Mp7DnME2ZhsW+NBhfsi1kcJIIbV69/Nl1IsUpRdkV3
	 E9Pfr2LdGkL69yKtX6/ba+QkUbcShhDfehbCbcM/nIH1OzkijbPqQ2+hKs4qx1+g3SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357463;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rc8yH713lTTkC3YCGsQVmCdN2VXwj8IOvMwKjTz7x2w=;
	b=2m/Zr6KqzjS4PB527zVgL4BOnEOec4y4uwxSJG79g/9WNOSTzQRuSQwg8zvu0xUacwId
	 mmKfDO71PZO3B7SVzDVt53k3hXDE0dCk6D4j7Jzo4SgTLAAviRklkgNrk6/59V3JSDdmi
	 ChLJQOYW9mICFQ0946GgL+ccccv0MKUP77dxXW3Gufy1m2nPnXgyXXYGmK6OmR0841UL6
	 ZMBf3mT4kthigMJGKsViOfR82ji3ITHSO1H/I793CKLRnbS1VagYbSaVzStebj1lSLv9v
	 /8UuQ2w+5Bdo9a7IfhAxzUIQn4GcG+tSVMCxywOyFK3Pc4nEluLouDlf4rxOUdFbFEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfmoOaVH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8760A3831;
	Fri, 30 Oct 2026 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfmoOaVH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033961F000C1;
	Fri, 30 Oct 2026 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357462;
	bh=rc8yH713lTTkC3YCGsQVmCdN2VXwj8IOvMwKjTz7x2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gfmoOaVHZn191tLXONK7XlLWngL54hmcClr4De0X5oLOIAdmtthBVj7iyRfhUCEL7
	 QKPh6RdkexwIfgoIvLIhxa9bZHsoTzFj497Em3NZYex0t1NqNS/Cl5ZbcqYVW+GdZy
	 q/hz+avmrz/lFZK89D+b3wf332I9h8lGNzsKCe1/zQW4duTc1H+acv9d83f2mbQBON
	 ZqZBNjVq1a6DYgcTQjPMzP/gih4naZWCrhVQoT+YrTvjtgBM7ZRbrH1GYS8WBnqvZl
	 4DdRPvc9CruH2rsXG3Uq+qllrPTQx18Gb9eWZ1Gp76AH3Tyv/5JLxJ1rTX3DMk44QN
	 YqayY0ZrnIwkQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/21] soundwire: intel_ace2x: Protect bus.bpt_stream with bus_lock
Date: Fri, 30 Oct 2026 10:46:45 +0000
Message-ID: <20261030104840.3361217-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_ace2x_bpt_open_stream() checks and assigns cdns->bus.bpt_stream
without holding cdns->bus.bus_lock.  Concurrent BPT open requests can
both observe a NULL cdns->bus.bpt_stream pointer, allocate separate
streams, and overwrite cdns->bus.bpt_stream, leaking the first stream.
In addition, failures after sdw_slave_bpt_stream_add() jump past
sdw_stream_remove_master(), leaving the master runtime allocated by
sdw_stream_add_slave() on the bus list.

Hold cdns->bus.bus_lock when checking, assigning, and clearing
cdns->bus.bpt_stream, and remove both slave and master stream runtimes
on open failure.

Fixes: b2c9f1d5a7eb ("soundwire: Intel: test bus.bpt_stream before assigning it")
Closes: https://sashiko.dev/#/bug/linux-88535ed9-b7e9-4ede-93c7-59950c524c0b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/intel_ace2x.c | 36 ++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 642b33ab5526..3623fc9f4451 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -83,17 +83,19 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	int len;
 	int i;
 
-	if (cdns->bus.bpt_stream) {
-		dev_err(cdns->dev, "%s: BPT stream already exists\n", __func__);
-		return -EAGAIN;
+	scoped_guard(mutex, &cdns->bus.bus_lock) {
+		if (cdns->bus.bpt_stream) {
+			dev_err(cdns->dev, "%s: BPT stream already exists\n", __func__);
+			return -EAGAIN;
+		}
+
+		stream = sdw_alloc_stream("BPT", SDW_STREAM_BPT);
+		if (!stream)
+			return -ENOMEM;
+
+		cdns->bus.bpt_stream = stream;
 	}
 
-	stream = sdw_alloc_stream("BPT", SDW_STREAM_BPT);
-	if (!stream)
-		return -ENOMEM;
-
-	cdns->bus.bpt_stream = stream;
-
 	ret = sdw_slave_bpt_stream_add(slave, stream);
 	if (ret < 0)
 		goto release_stream;
@@ -105,7 +107,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	if (!pdi0) {
 		dev_err(cdns->dev, "%s: sdw_cdns_alloc_pdi0 failed\n", __func__);
 		ret = -EINVAL;
-		goto remove_slave;
+		goto remove_master;
 	}
 
 	sdw_cdns_config_stream(cdns, 1, dir, pdi0);
@@ -117,7 +119,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	if (!pdi1) {
 		dev_err(cdns->dev, "%s: sdw_cdns_alloc_pdi1 failed\n", __func__);
 		ret = -EINVAL;
-		goto remove_slave;
+		goto remove_master;
 	}
 
 	sdw_cdns_config_stream(cdns, 1, dir, pdi1);
@@ -136,7 +138,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 	pconfig = kzalloc_objs(*pconfig, 2);
 	if (!pconfig) {
 		ret =  -ENOMEM;
-		goto remove_slave;
+		goto remove_master;
 	}
 
 	for (i = 0; i < 2 /* num_pdi */; i++) {
@@ -149,7 +151,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 
 	if (ret < 0) {
 		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
-		goto remove_slave;
+		goto remove_master;
 	}
 
 	ret = sdw_prepare_stream(cdns->bus.bpt_stream);
@@ -293,15 +295,16 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 		dev_err(cdns->dev, "%s: remove master failed: %d\n",
 			__func__, ret1);
 
-remove_slave:
 	ret1 = sdw_stream_remove_slave(slave, cdns->bus.bpt_stream);
 	if (ret1 < 0)
 		dev_err(cdns->dev, "%s: remove slave failed: %d\n",
 			__func__, ret1);
 
 release_stream:
-	sdw_release_stream(cdns->bus.bpt_stream);
-	cdns->bus.bpt_stream = NULL;
+	scoped_guard(mutex, &cdns->bus.bus_lock) {
+		sdw_release_stream(cdns->bus.bpt_stream);
+		cdns->bus.bpt_stream = NULL;
+	}
 
 	return ret;
 }
@@ -335,6 +338,7 @@ static void intel_ace2x_bpt_close_stream(struct sdw_intel *sdw, struct sdw_slave
 		dev_err(cdns->dev, "%s: remove slave failed: %d\n",
 			__func__, ret);
 
+	guard(mutex)(&cdns->bus.bus_lock);
 	sdw_release_stream(cdns->bus.bpt_stream);
 	cdns->bus.bpt_stream = NULL;
 }
-- 
2.56.0.317.g454f8302e1-goog

