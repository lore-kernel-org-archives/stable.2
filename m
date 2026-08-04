Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413D432300;
	Tue,  4 Aug 2026 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882148; cv=none; b=FaYAu6Ttr+lSitM5okR1Mkqc/wbKly4fsKv5fsxJHsYJdWS9a4E63cCZ58DkzWwUPibsl61ajJ/BOEedksRxadW4rFnaF1SYdhlxeEMEunhzww+I/Nl8VlC7QmnBMcVJoFdo3En6dTnP89YnOSqZpq6fIMgI3ZzgXAwfKz6F6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882148; c=relaxed/simple;
	bh=YKgNVFpKFMpMijzl7Q0nhw3OAsr5q7NY9bjTSbCZglA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiM8lMyLqFYWTITlzA3LXxdJzoUu9fzc7hDB2wgH4gsyNzseK5fqMC1gJaboQDdVoQg7wb/4WSt/0KD+UBxI2BaEN3kb35tqxFbo6gWClPvdcDBSmoHtUD5LKu9CEc9BYUvbfYZ+stZmQ5ZnVuU1RUMgGQc2zJXc/AR6kunJV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHnRPztt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHnRPztt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882146; x=1817418146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKgNVFpKFMpMijzl7Q0nhw3OAsr5q7NY9bjTSbCZglA=;
  b=cHnRPzttFfXcvz2BFv6Cmofn/x7o1snspQwTfkL7oUiNLkLq3gA84ikb
   merLMtkuRtuQsrVV8c3ggQd/d8sKLAc932jKBRfnt9FvGO0uoLQLAsubP
   x0Arow/CGA9Jcq/uX3N/w9Z/s7yx1qdDWBVe7BAHYmCETINsOeqfLsyRo
   Q1Zo+gVeHuV6Eac8XeqONsG+GSCFvNqEjfXpkKXVjL0D3ZBNnI+cln6hh
   mckLyf3qUOFI55KNBFE5+XVAmOFSgExw4rpwTH5mN6UuVIhbdp6KlBzJ/
   wreCGJa3eKhHWha/P2ulEJ9fejezJVlcXiYl39liWQn+iJf/nuaNdfctG
   w==;
X-CSE-ConnectionGUID: zJwzz7iOSh6/WdGLeqRuzQ==
X-CSE-MsgGUID: 093I4eghSxeIXeybEi2jsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96803472"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="96803472"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:22:22 -0700
X-CSE-ConnectionGUID: oKM73YRpTLmNWvDi9NdFhg==
X-CSE-MsgGUID: ee4zreWkSIeZ/BacBjcKBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257308024"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 15:22:22 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Philipp David <pd-lkml@3b.pm>,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: [PATCH net 10/10] igc: fix netdev not re-attached after resume if interface is down
Date: Tue,  4 Aug 2026 15:22:03 -0700
Message-ID: <20260804222205.1580328-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp David <pd-lkml@3b.pm>

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
---
 drivers/net/ethernet/intel/igc/igc_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 16fcc8cf6191..39043d8ca1bf 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7585,11 +7585,13 @@ static int __igc_resume(struct device *dev, bool rpm)
 		err = __igc_open(netdev, true);
 		if (!rpm)
 			rtnl_unlock();
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
 
 static int igc_resume(struct device *dev)
-- 
2.47.1

