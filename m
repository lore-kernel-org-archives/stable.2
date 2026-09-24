Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A65472555;
	Thu, 24 Sep 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259241; cv=none; b=mfNK5nz6Ovm8wM8aarVRtqrHn5Z1voSPsJvl7jmxwfX353eu4XcWNZ/m6BL6zpe5ViOSYKJWHo+JhZvQ5fyE3IW3+J7GPQ6Ga1nVtKRH+c61AlY+t0YGi7i4Bwf8m23A0L1klKwUyfis+vv1PXVVqdV+lYvZ8tEVmSr6W9UXf1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259241; c=relaxed/simple;
	bh=cztF09N+3wyfNtfZwVMPnNEUWplO8pYv7+uEbrMz/1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CO/BZDCF44U03+Ur9Fo0GqauZKnm+WU1Z6XBvNnfWviI1EEMI05OpVOdqzddIqSqxcdnyvQ08EqC50LxhQPjkeG1eLGRSTmljd3TXzemF9/lnlHU8GAY27W/c2Pq+uen/l8QK9di2iVZlXyG27Udjt9mrHtb5d7CGNEzn/YFL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YQQH6+Oq; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YQQH6+Oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pO
	K9Z15/6NeZFY3XKFZNY5eck7brRsBImPrG/E/vqOA=; b=YQQH6+OqUzabvNdoY/
	5nbdGojxKBBaXbWSQ2AoJRB/xBSyDU0vanY87aTqwG+CvWv0eN1N/NCd73wAI1lN
	6Y14SQShKYvJXkh14DeEIfaA+Hedsk51gwqfcawFv2dZexN9yyZmJM5IAKZ6HS0S
	SCU8QnmFSPVhNr75YwshoOsm0=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXN8sIMLVqBMA4Ag--.5098S6;
	Thu, 24 Sep 2026 22:13:35 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	"Daniel M. Lambea" <dmlambea@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/10] HID: elo: reject short touchscreen reports
Date: Thu, 24 Sep 2026 22:13:19 +0800
Message-Id: <20260924141326.1154421-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924141326.1154421-1-yaojiale02@163.com>
References: <20260924141326.1154421-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXN8sIMLVqBMA4Ag--.5098S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWxCw1DGFW7WFy8JF47urg_yoW8JFyxpr
	Z3JF90kw47Jr4xuw4UKa1kua4Y9wn5JrWfuFyfGw1agw15AF9agFWYk34Y9ryrJFZ5Kwn3
	ta1DtrZ3Ca4j9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRmFAJUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ8XUWq1MA9E7AAA3M

The HID core invokes raw_event callbacks before validating the report
length.  elo_raw_event() only checks the first-byte packet marker before
elo_process_data() reads coordinates, flags, and pressure through offset
seven.  A truncated packet beginning with the expected marker can therefore
cause an out-of-bounds read.

Require the complete eight-byte SmartSet packet before parsing it.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: d23efc19478a ("HID: add driver for ELO 4000/4500")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-elo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index b8f5f3eb53a4..86e8729e1975 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -85,6 +85,9 @@ static int elo_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || list_empty(&hdev->inputs))
 		return 0;
 
+	if (size < ELO_SMARTSET_PACKET_SIZE)
+		return 0;
+
 	hidinput = list_first_entry(&hdev->inputs, struct hid_input, list);
 
 	switch (report->id) {
-- 
2.34.1

