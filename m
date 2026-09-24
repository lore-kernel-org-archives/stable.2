Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC63C7E1D;
	Thu, 24 Sep 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260206; cv=none; b=CfZVvQM7Wc3dKsjZ8a+V2X+d8XZMS8x8brEKOwWTcggei49yZ/9W+6P//lKcvRZfaJE1T+elDrWnTCYJoRu2DYu8AnzbL1+j1nXBnSf7uVelCK5cT29R3vEWm7TFFfRWhXEdEmCCMAzKAIP5YzRUdNe8hFZi59ML4nYwEWaWMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260206; c=relaxed/simple;
	bh=Bq6L8cVFFtlnAtZu7YG/xjIwfic4Dwt1kcm1RLeYuXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aihrz4DRrYEjhy6A/Q8XGFv6MCbLQUCPaCV/byvxKgJscFMcDrGsufAMMYiIKckhkOuwDuJ04Ab+QHez6+14cqZgvZNHD2KXj7bB3Kpk84lJk2P+2fj8g08l+SOv6dFGnWLYCDbj7qiB3mhW2a6as3lL1RxJlZIS57LZuAKJGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F6RR1fxK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F6RR1fxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I+
	mLd6HrH/8Ctmif5CFCvV/sEYuAreQ2+rWwL4cPZZE=; b=F6RR1fxKCHaZjUjD2J
	14j8n4NHLM9PFxbzTNRu2O32wjlidxQwyCZg2IL5Qd+zaUDtRm4KAY+vS69TX/2X
	OcXYCrHijCgskcMqIwIQ/YCO8JR/kirQCi01lkmNRw5wG5Oa7Q36DiIRnQdzq5Rb
	UB4SrRaXKICpdeyD3VI/2yZuo=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v7zAM7VqMhFPAg--.56297S8;
	Thu, 24 Sep 2026 22:29:48 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/7] HID: roccat: ryos: reject short special reports
Date: Thu, 24 Sep 2026 22:29:16 +0800
Message-Id: <20260924142918.1177952-7-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924142918.1177952-1-yaojiale02@163.com>
References: <20260924142918.1177952-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7zAM7VqMhFPAg--.56297S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyfCFy3KFy8WF4rZw18Krg_yoW8JFWfpF
	ZIyFZ0kryDKrW0kw1Uuw18Aa4rZw4kWayUWF9Ygwn8uF15tFyjkFW09asYqrWrJFW0grZr
	ta1Dtan7Ga4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMPfQAUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xwMRmq1M9yn6gAA3E

The raw event callback runs before HID core validates and zero-pads the
report.  It reads the report number without checking the received length
and passes matching data to roccat_report_event(), which copies a complete
struct ryos_report_special.  A truncated report can therefore cause an
out-of-bounds read and expose adjacent data through the Roccat character
device.

Require a complete special report before inspecting or forwarding it.
Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw-event length validation to hid-asus.

Fixes: 6f3a19360545 ("HID: roccat: add support for Ryos MK keyboards")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-roccat-ryos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index db83f42457da..85df7955b87c 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -189,6 +189,9 @@ static int ryos_raw_event(struct hid_device *hdev,
 			!= RYOS_USB_INTERFACE_PROTOCOL)
 		return 0;
 
+	if (size < sizeof(struct ryos_report_special))
+		return 0;
+
 	if (data[0] != RYOS_REPORT_NUMBER_SPECIAL)
 		return 0;
 
-- 
2.34.1

