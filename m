Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822323A1696;
	Thu, 24 Sep 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262698; cv=none; b=tOLzjYFhX9pAS19z/C0u1HjTt1QydOinn5IY9S9mOjdCMYSbvp0oyyiK6XNaf6uZ0C4HyUzuWqkxkqugClXHuGzXuyQZX0pMBlaMLgNRJ+QuCIkfHQBseJW5Ko8mQtbjpjrJQF5+V6Sf9OZJKJ7nPxue1K3rkW/cEW+wl9/x+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262698; c=relaxed/simple;
	bh=gwrQLxdNoH2xOXIGrC8Gg+LQRFNJ7SQYjFmtJn/Saes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=szdNT5tSax6znvHc8w9vnWJGlQ55FWJBhiATbvW2jYqJRsoE3cwa4K1grmGTLPq1TZpYmnsIWTNVnaMGrj7RuNvNEKLXKcE9HxPLInwVnmaQKQZxcSLB4j61kFCMAyJedX0g5uCWORNIT8P7DqARldd7Dx9ROVfbjHwKkJcTfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XxK2LMYK; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XxK2LMYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aN
	M9D8pjjtnrUj86bj/Kpb2IbPeSJHeKVrd7N6ndAfY=; b=XxK2LMYKsGX4IE+k6o
	/WJrmF6ZAt6zOBC6Rc7l2T8OlLhda4egWvaJVl1s6qjKMz8oYFDa8ExE5wDCQagl
	ATnYtOO7CLxEOANm6cG9HN3cri6T2CgCDPkZKNtO4LND/mOPxaczF7vUCfKKaoji
	f8nIpKQdFDinOwQxH0wlpQ/DI=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3t3CKPbVqCtc_Ag--.20008S2;
	Thu, 24 Sep 2026 23:11:07 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: sensor-hub: reject short input reports
Date: Thu, 24 Sep 2026 23:11:01 +0800
Message-Id: <20260924151101.1233338-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t3CKPbVqCtc_Ag--.20008S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWUKry5Xry3Gr18Cw4rZrb_yoW8GF1rpa
	9ayr98Crn8KrW7Cw1UKr1UGFyYya1rJa15uFykWwna9F4Ykryjqrya9a4Yv3y5ZF48Kr9x
	Kr4YqasxGF1q93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piCPfPUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wt5s2q1PYtEPgAA39

The HID driver raw_event callback runs before HID core validates the
received report length.  sensor_hub_raw_event() walks the fields described
by the report descriptor and advances through raw_data by each field size
without checking that the received buffer contains the complete report.
A truncated report can therefore make the field copy and capture callbacks
read beyond the received data.

Reject input reports shorter than the length derived from their report
descriptor before walking any fields.  Commit 47669bec44fe ("HID: asus:
refactor the two workqueues and init sequence") added equivalent raw-event
length validation to hid-asus.

Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-sensor-hub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc..d3e7bdac916c 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -542,6 +542,8 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	hid_dbg(hdev, "maxfield:%d\n", report->maxfield);
 	if (report->type != HID_INPUT_REPORT)
 		return 1;
+	if (size < hid_report_len(report))
+		return 1;
 
 	ptr = raw_data;
 	if (report->id)
-- 
2.34.1

