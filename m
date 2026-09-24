Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A73CCFAF;
	Thu, 24 Sep 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261087; cv=none; b=DPj/sgAyzNGb0OHp2pzFU/O0Gb6p0Mjtks1PfT0x26+vzvjLPMeTLCaBAzFc+nXnNz1YSmgSRlBblvH8mUOhFfxgH3Q5F6m1alDDiw2c8snI0ml+TNzver2gTqiPSluHbfXoC2KsuszACJT01WfSwIi5L34Sjq54hpPz6d5EtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261087; c=relaxed/simple;
	bh=cztF09N+3wyfNtfZwVMPnNEUWplO8pYv7+uEbrMz/1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eeJOlm3FE/W4LmxleZFl5l+pRImmHcKkVTeUYQFpc7/Gxwtg3+5AUezR4RHPf0ZJk/ZXvy5637SVbhLNEE9pHq+VcikOMrGSX1A0Nr0gKHaoNtkVx0J6Taq7g+KZUT/Pn4hiSUBcgHwhZOI1i/OGnrm5eVo4POV6WdCIh42Rrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g19wLnoO; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g19wLnoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pO
	K9Z15/6NeZFY3XKFZNY5eck7brRsBImPrG/E/vqOA=; b=g19wLnoOvUjv+b2sls
	A3PvY9s1pxQhPs1NzIMf+E6z7Z2n+Sjyz2pMyaIzZ5y1Bdg2IqpqmRYIcy0tysC9
	GRzcZiC5qKeILYDk7fjFctEKOJq9S/cI2Oo4/t90NXnUqJS3RX78x+LvtMArZfzx
	cjnOibTRCq53/NAkeoW8crfQU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD330ZHN7VqyTtKAg--.25624S6;
	Thu, 24 Sep 2026 22:44:30 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/10] HID: elo: reject short touchscreen reports
Date: Thu, 24 Sep 2026 22:44:07 +0800
Message-Id: <20260924144414.1192037-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924144414.1192037-1-yaojiale02@163.com>
References: <20260924144414.1192037-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330ZHN7VqyTtKAg--.25624S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWxCw1DGFW7WFy8JF47urg_yoW8JFyxpr
	Z3JF90kw47Jr4xuw4UKa1kua4Y9wn5JrWfuFyfGw1agw15AF9agFWYk34Y9ryrJFZ5Kwn3
	ta1DtrZ3Ca4j9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRjQ6JUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8A7oI2q1N073CAAA3s

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

