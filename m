Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E19235BE2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059058; cv=none; b=qmH8Dse3jNoykbdd0jy1H69IonziwjXFKqFuskiUUWUncFR+jQDAlzGJuzqOYZWqgn10Qcx9XHq2P/Cl9kXs186D7TanGgw0BRbxhcZiUGO1h0MP46FnXUFxZmugwANBGZ5ur0Q+k3LCwK+WxrSWKZxBPM6vsrOQNM5futA0PJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059058; c=relaxed/simple;
	bh=6IR+ihr8+lcxk06JrZypdtztydEDuahF88MIzzFTlPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldFDvJLUWYeJw6ZG0tQtUwW0h5P1woCzjpgY5xn6Gk+IvfdjVIxdMpvugPnEZSVMO3Wxpau9Ks08BDA/FQmE3D9UWepKexTDevzS7HUUaG+KgSWDOXdyzoW1mpE7GCiUSE5EQZz63EJ1oI7g/yxsY+RSiHU+veeNjElkIcvto8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3PvIAd+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3PvIAd+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059057; x=1821595057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6IR+ihr8+lcxk06JrZypdtztydEDuahF88MIzzFTlPY=;
  b=i3PvIAd+kMvF/vT8kd+FXSHkikaQZ+4j9CPn45hcZbdP3WW9k6DtdMgO
   yOMyi+1gxlV0ApIJcOW/JT4oc35E1KuBfcl/E2RKkll2rDkdNQmaQj5JJ
   qZFGGP2FGxdUTCVu4J1eYI9wVpesrlHzP0966L0sFSQe4JdAt7uZdpdLu
   Bxev/HWeOZ7SENqiUhzL62aZTACsXBbSWWkNBQ7dtngkSGHNNigHIVdM6
   0pEgP83F+2b2bvymqnfWLDGczUecs0oBxMlOMUDS72z+yaGux5FsHCS66
   SirqOKmejFv6Or3imH9vSVwHIBvhGc7RaOXuh0k91ET+u2hDRgWqpJSiz
   g==;
X-CSE-ConnectionGUID: 8F6Nu1EoRs69iUxiXRJKZA==
X-CSE-MsgGUID: piqeUTqATNaQAjv8REaQfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93135646"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="93135646"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:37:36 -0700
X-CSE-ConnectionGUID: JAohI9T2TdOgACaD0fn5lQ==
X-CSE-MsgGUID: VDk05sbUTi6oF9qWN+8xAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271541848"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa006.fm.intel.com with ESMTP; 21 Sep 2026 23:37:34 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: chandrashekar.devegowda@intel.com
Cc: kiran.k@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: btintel: fix buffer over-read in btintel_hw_error()
Date: Tue, 22 Sep 2026 12:06:47 +0530
Message-ID: <b484c13e104eab61a42e319dd858bce971a8a8ab.1790053452.git.chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
References: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "Exception info %s" print uses skb->data + 1, but the 12-byte
payload is not guaranteed to be NUL-terminated and can be read past
its end.

Bound the print with "%.*s" and skb->len - 1.

Fixes: 973bb97e5aee ("Bluetooth: btintel: Add generic function for handling hardware errors")
Cc: stable@vger.kernel.org
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e6d1ddc99c6..12bf795db84e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -290,7 +290,8 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 		goto unlock;
 	}
 
-	bt_dev_err(hdev, "Exception info %s", (char *)(skb->data + 1));
+	bt_dev_err(hdev, "Exception info %.*s", (int)(skb->len - 1),
+		   (char *)(skb->data + 1));
 
 	kfree_skb(skb);
 
-- 
2.43.0

