Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615B3C870E;
	Thu, 24 Sep 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260207; cv=none; b=GpiIWgawhqGEHHDsSz7CO339OWPTNmkldGjDXqqx/wQexJ9ADvpV6vgd+kRkyvFN1nt2VafPdbeCVd54ysczz+M1Q31Xyaziq+b5eEAjJekf5K1OkMiwbtcME04/8zOR1hSmymNWMd2XS+CU/y5w7ww/V9ED9+HAR+NMd/XyrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260207; c=relaxed/simple;
	bh=T9HpdmgXGf+GzYILUjeBmLrJLLnZL/6XGiohv4VpYSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0MyRJsrUO+Pd/RbEH/HMv279h+/pCgZ7wpOgUb/zkolWPhbAYT4DXUQKtx1u4vjWs/y98z1vuK50JId/+ciWFeHqQN++NysUk6tHPda3jXKasckmSZZh8AuxBom2aSPSfnWXN+4du6MWrnWbIvZtmyp6/oVSxLhgEtcIEWRdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P7Yo0Pb5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P7Yo0Pb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ET
	K9pXz0W5XIVensP64P00Ew/rvfV1FbL/bQBd+BiTw=; b=P7Yo0Pb5+PtWiozaSN
	FO950lYBGrAZhLW2euZ/KuX4OD+83VTZWz3k/PJZmfb3wrwgUvTTFCZNlkqAKeAI
	5zc+nJi3rk/iVdvKjqV1Y++86DI3syNVEdCO3hRyMnexqMSGQNnF128gZ2BaMziB
	s+s9+eB0paWPOt4mVUiqBCEwA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v7zAM7VqMhFPAg--.56297S7;
	Thu, 24 Sep 2026 22:29:47 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/7] HID: roccat: pyra: reject short button reports
Date: Thu, 24 Sep 2026 22:29:15 +0800
Message-Id: <20260924142918.1177952-6-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3v7zAM7VqMhFPAg--.56297S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7JryDury7ur15uF1rWFy5CFg_yoW8Jr4xpF
	ZxAFZ0krWUGr4Sgw1Uuw48Aa4Fyw4kX3y5Z3sYk34Y9r1YyF1Dua4jg34jqr45JrZYgrZ7
	ta1qqFnxGa4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMPfQAUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRsLRWq1M9uU0wAA3o

The raw event callback runs before HID core validates and zero-pads the
report.  It passes the buffer to helpers which inspect data[0] and read a
complete struct pyra_mouse_event_button for button reports.  A truncated
report can therefore cause an out-of-bounds read.

Require enough data for the button report before calling either helper.
Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw-event length validation to hid-asus.

Fixes: cb7cf3da0daa ("HID: roccat: add driver for Roccat Pyra mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-roccat-pyra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 0d515995bb9d..44c2b416f2db 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -557,6 +557,9 @@ static int pyra_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (pyra == NULL)
 		return 0;
 
+	if (size < sizeof(struct pyra_mouse_event_button))
+		return 0;
+
 	pyra_keep_values_up_to_date(pyra, data);
 
 	if (pyra->roccat_claimed)
-- 
2.34.1

