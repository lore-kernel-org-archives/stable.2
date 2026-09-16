Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802594DD3AD
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599176; cv=none; b=nNwlSUDsKj8Y97VH+d87bwNBQvHqMSG97aJ4j4/npBtRvIc6jk2lyoDbcT3b9WZJVRfH7sQADDoQ4H+aFwnRAqpHfSnANHvxRucW+kn1RmAzNlG8ytNHnwt69i3LJM/UZC5WrotewR8qCAr0miwzBE6dzHkmiQ0X5gaYnJ4ting=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599176; c=relaxed/simple;
	bh=RemvWGD8fDNAJhodw9Rb4zkKHNonC2YABnYLA+65qEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5F2cOrAtY2KZDxXt093W3mvJXcE5f3a7C5yxJ1j7aDoAvMKJkx654OTKs8KG6prtjD1PQsUooEUtFy1Wybahz997KTKt/cYZCzfGploBMOjXAMVba0ZeWnhoqs7qNI6VVM1bmxlU34fkUJM2rF2MMMpVvDS8fYahhd+6y7DXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTDTTw2t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTDTTw2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789599171; x=1821135171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RemvWGD8fDNAJhodw9Rb4zkKHNonC2YABnYLA+65qEk=;
  b=nTDTTw2tSR9fbbCvdORwuJewQt198Sr5nb61WvkN8zCSDVCA5Kmq1274
   3p6J4DnXVQ3o20q7NqCpVVgclO0qfGHNAuMQdjYKhOBPISJYI5ABhX9cN
   pGghSR13TpFqIG+ZZ1n9FNXsag6MLIoh4QGDYwPxZR4w4ck1IEB9X7Qx3
   wFE+Uu4tKU6HqFlMEA3MZN/Xkx5QPEPe+74sWnHldXCciD2E/Rtd0p5gP
   bk+0DU3DYIzeDdlgIQSn+x+VfRuP1YkBkZ0rXyMFSDjIYjo9DaCUaqwbY
   U5cGpM46WKklp3tKcL9sshk3LDzU3quPmd7TfwQ5Cd8O4IrOMtHzyw0HW
   Q==;
X-CSE-ConnectionGUID: geLIqoUUTjmT9RFAgdNxRw==
X-CSE-MsgGUID: nTJF3vQzSp+pDGVp2tDAiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77547665"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77547665"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 15:52:48 -0700
X-CSE-ConnectionGUID: 6ghXNrN8TraImtp+ZEbBuQ==
X-CSE-MsgGUID: sHWpiTcaTl+ccLePdNbhtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272018129"
Received: from cdjpc409-it.jer.intel.com ([10.12.50.120])
  by orviesa010.jf.intel.com with ESMTP; 16 Sep 2026 15:52:47 -0700
From: Gil Fine <gil.fine@linux.intel.com>
To: mika.westerberg@linux.intel.com
Cc: gil.fine@intel.com,
	gil.fine@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] thunderbolt: Do not set up a DisplayPort tunnel when credits are insufficient
Date: Thu, 17 Sep 2026 01:57:53 +0300
Message-ID: <20260916225755.45127-1-gil.fine@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, an excessive DisplayPort tunnel may be set up, even if no
sufficient credits available. This could lead to malfunctioning
DisplayPort tunnel.

Fix this and bail out early if this is the case.

Fixes: 6ed541c53edc ("thunderbolt: Allocate credits according to router preferences")
Cc: stable@vger.kernel.org
Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Assisted-by: LLM
---
 drivers/thunderbolt/tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index c0342b1d6a8a..7a033df7f916 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1582,7 +1582,7 @@ static int tb_dp_init_video_credits(struct tb_path_hop *hop)
 		 */
 		nfc_credits = port->config.nfc_credits &
 				ADP_CS_4_NFC_BUFFERS_MASK;
-		if (nfc_credits / sw->min_dp_main_credits > max_dp_streams)
+		if (nfc_credits / sw->min_dp_main_credits >= max_dp_streams)
 			return -ENOSPC;
 
 		hop->nfc_credits = sw->min_dp_main_credits;
-- 
2.43.0

