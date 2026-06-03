Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9903EFD13;
	Wed,  3 Jun 2026 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465510; cv=none; b=Ckdefh4gHO6sfPZgvC9E6KIV3P8iahDYDpNxalDjCkIAF7RgBsLCU395bh7PWG0fl61FVtBOiVTfEuE4jGFC1N04FTRa+q51Iu2wlZqqkQyWQzAttyJDmgmxieEqMooei3FZVB/pz477RUVFsG2LECEvPSKtxbWuFl7MXAczMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465510; c=relaxed/simple;
	bh=O9iwnBIgKqDpqSNN6Pe+xusQynMyytAi0m4Q1+P8dMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4uiuc5j8s1V39yeA0S7dW4rawe6REuVo5z/ciaa2rQ2Fa0+zMUpokab+7oHuCJTt1ARq9ql3nm7R/g6PcxXMVw1tQJCVgeW/6uBlS2rMphoFCuSLxAcz8KCkvdP7X0m7pQs0hMM+4vMKMbNTNIbbAjAHmq8fOomOWQuQhAcH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X6gXf+Hb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X6gXf+Hb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=si
	Riv2CQkgh+HendkSQW8rEXA0fQkjnQBcAl8X/w2ck=; b=X6gXf+HbZficOLpqSU
	Mj1+X2geCB4wls+Q8oBk7A6+avoWV7FvT41VwZSgUSZY14fpyMMCC+Ip9VN2LeaI
	ZpK0oHeWDwgp6G81TdK5vsOsKiMueIAqnR/Mil6VEEtPevRkQP1Wujf8r3ClKMC1
	GuObPNOPRTIVioyvYrZsEPqiI=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3d6JSvx9qgI6ZBA--.34392S2;
	Wed, 03 Jun 2026 13:44:53 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] HID: core: Mitigate potential OOB by removing bogus memset()
Date: Wed,  3 Jun 2026 13:44:49 +0800
Message-ID: <20260603054449.80232-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d6JSvx9qgI6ZBA--.34392S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17ZF43Wr13Xr17ur4xCrg_yoW8Ww1xpF
	Z0yFs0kryqqFykCw47KF1xZa45ta4kJFy2gFW7Ww1rZr1Yka4UJr1IvFZIvrs8ZrWIyF93
	CF4qywn8A3Wjv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEVyxJUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7BVnMGofv1UTnQAA3-

From: Lee Jones <lee@kernel.org>

[ Upstream commit 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c ]

The memset() in hid_report_raw_event() has the good intention of
clearing out bogus data by zeroing the area from the end of the incoming
data string to the assumed end of the buffer.  However, as we have
previously seen, doing so can easily result in OOB reads and writes in
the subsequent thread of execution.

The current suggestion from one of the HID maintainers is to remove the
memset() and simply return if the incoming event buffer size is not
large enough to fill the associated report.

Suggested-by Benjamin Tissoires <bentiss@kernel.org>

Signed-off-by: Lee Jones <lee@kernel.org>
[bentiss: changed the return value]
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
[ Replace hid_warn_ratelimited() with hid_warn() in v6.1. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/hid/hid-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3f3de08969b5..f69b64d1e81e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2020,9 +2020,10 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (csize < rsize) {
-		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
-				csize, rsize);
-		memset(cdata + csize, 0, rsize - csize);
+		hid_warn(hid, "Event data for report %d was too short (%d vs %d)\n",
+			 report->id, rsize, csize);
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
-- 
2.43.0

