Received: from mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029832ED55
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882344; cv=none; b=eDbjC6VXwCNVyBQPQW9soX5Z8VsY35sC9TOPBK1yZsej86lB/mhdi1guzEE9KbiaF/15rad1NptGTZCTZw/Cod41Bw2b/esRJX8aUee17h+piTYFivhaiFNxhn63ler0EAV9r+Xvtg+Xlz+iaWwLwmhOQ9YH6TQ+13bsvNgsoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882344; c=relaxed/simple;
	bh=AAcpEs2VGk20y3FAdUf8trsxmtZYFZ0VYb330q/Ah7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CslJy4doBHxu9+gCedARTGLV9094YYaFV8+UxdpQQhnTvHRTge8F+OKB+fyVcKVqEHR9uGGYCAUaKiu/W8RLYDyB58kmaQZFJeH4+6DzvdeEwyu/+CRm+V93dFyHZWXuqKGmymLtlbygQK0dlgdzCcvtM8sP2Xq9y22M3uUUrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OGzQgMnm; arc=none smtp.client-ip=91.218.175.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OGzQgMnm"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AAcpEs2VGk20y3FAdUf8trsxmtZYFZ0VYb330q/Ah7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787882340; v=1; x=1788487140;
 b=OGzQgMnmvTWKq+Q0pNExkPyHds9sFvt7mENRDFZeFJJg401MiIIrctzuWt3bT46qgknaNPwJ
 k0tNMlvL8WUXPbJoBClUVeKund944zYFiv0uA1812oBgZ5vBww2LNgOJOjKgpXMft1iT8rc5S0h
 zqkugct7TwVQnawPMb9spFkw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a1430dc3be629d11;
	Fri, 28 Aug 2026 01:59:00 +0000
X-Mizu-Trace-ID: a1430dc3be629d11
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	ahmed.zaki@intel.com,
	mateusz.polchlopek@intel.com,
	saikrishnag@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] iavf: add missing PTP adjustment callbacks
Date: Fri, 28 Aug 2026 09:58:37 +0800
Message-ID: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The PTP hardware clock documentation requires drivers to implement all
callbacks and return -EOPNOTSUPP for unsupported features.

The iavf driver registers a PHC without adjtime or adjfine callbacks.
A userspace clock_adjtime(2) request reaches ptp_clock_adjtime(), where
ADJ_SETOFFSET calls adjtime and ADJ_FREQUENCY calls adjfine. The missing
callbacks can therefore cause a NULL dereference.

Provide both callbacks and return -EOPNOTSUPP for the unsupported
operations.

Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clock")
Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
Link: https://lore.kernel.org/all/20260826101004.100979-1-xuanqiang.luo@linux.dev/
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_ptp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index 87b97e09df14a..fcb273828bc1b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -252,6 +252,16 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
 	return iavf_read_phc_indirect(adapter, ts, sts);
 }
 
+static int iavf_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+static int iavf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
 static int iavf_ptp_settime64(struct ptp_clock_info *info,
 			      const struct timespec64 *ts)
 {
@@ -326,6 +336,8 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 KBUILD_MODNAME, dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
 	ptp_info->gettimex64 = iavf_ptp_gettimex64;
+	ptp_info->adjfine = iavf_ptp_adjfine;
+	ptp_info->adjtime = iavf_ptp_adjtime;
 	ptp_info->settime64 = iavf_ptp_settime64;
 	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
 
-- 
2.43.0

