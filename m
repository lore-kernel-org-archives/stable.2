Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF01524AE4;
	Tue, 29 Sep 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685249; cv=none; b=teOa6MHbYGM1iWmE9bxX4pwYc3A1vIa+gNrNsDpb9l7HANFmbs3WeJVD0z/wZEx1TIXib/WljbqcBhTGWm3TlN5rxyMGinDWk44OTJW06e0TKI02hHQvLU6r+gK+N7jhyZuUVIqonzQcYnAY2FUcYZV5v4SSHiU4GMbAswBf6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685249; c=relaxed/simple;
	bh=wRbT7fU2I2ui6EMpMFFVKQeIOSH4jVqBM0XWcuHcyFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQKuG6phmCGoJeZroOTR2dEhSgsDcIjAt2n4ka9QlckzhVHnTgwa7MB3+vdu23UFkjaW4a2zE+XTp9jt2DFgcMdNk9Rckjkteuw92owcl1Y+bHKv1DlEha+aKFKIwC6Q+RngbM30H92wyel0sqdLrFh3fIk9uucPKJAON51k87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=EAF5JK1+; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="EAF5JK1+"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f81e7acb;
	Tue, 29 Sep 2026 20:33:58 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: "David S . Miller" <davem@davemloft.net>,
	"John W . Linville" <linville@tuxdriver.com>,
	Zhu Yi <yi.zhu@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] wifi: iwlegacy: 3945: protect sysfs TX power update with mutex
Date: Tue, 29 Sep 2026 20:33:29 +0800
Message-Id: <20260929123329.2135878-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ed28543003a1kunmab53cc0c23d9b4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB9JVh9PH0JMSh1OTEweQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EAF5JK1+ojoYGSMDz1mKlteLN3pkydjHHWvaN6iWtdsJYAc6LPFUnNbidWJI+m2VtYcmb0dQkeVOI1hyQ3JXW43Wdb5sns3uNJQ183JkngeVNgPlR/RvQvKlDUeJfxZ/GO70g2o365XMx4ceMrcV0oCnk2g6jNbrQIltgGTh32Q=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=4XRCNu0IyF90aKVxuMobHnbm6goKDNrYFuge0X35Otc=;
	h=date:mime-version:subject:message-id:from;

The sysfs tx_power store handler calls il3945_hw_reg_set_txpower(), whose
command path requires il->mutex to be held. The callback bypasses the mutex
used by the other 3945 control paths, triggering the lockdep assertion and
allowing concurrent TX power updates to race with other command or state
transitions. Serialize the update with the same mutex.

Fixes: b481de9ca074 ("[IWLWIFI]: add iwlwifi wireless drivers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index cbaf25062..e8cbc2993 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3083,10 +3083,13 @@ il3945_store_tx_power(struct device *d, struct device_attribute *attr,
 	u32 val;
 
 	val = simple_strtoul(p, &p, 10);
-	if (p == buf)
+	if (p == buf) {
 		IL_INFO(": %s is not in decimal form.\n", buf);
-	else
+	} else {
+		mutex_lock(&il->mutex);
 		il3945_hw_reg_set_txpower(il, val);
+		mutex_unlock(&il->mutex);
+	}
 
 	return count;
 }
-- 
2.34.1
