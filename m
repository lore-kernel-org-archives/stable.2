Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FB479880;
	Thu, 24 Sep 2026 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261090; cv=none; b=aYZWeZHv8PKxDjtms4d/UUfNWXBUF+Tgjv61iZD1hIHNa+GiqGx9R68llNkJr95WE1BUxl4a3GvHxIADz/CHPSNaIbRMoon5gy2JLmgmT1vVdoufoB2WKoHvEUqogvOOIKlCtEXCblTv8QbrW+7XGGSBK6K00J0R5XpbS4m2ElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261090; c=relaxed/simple;
	bh=ERmwH0szn+7hBGZF2YJaSwG+CsGPO7spEvKIQFI1u1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSGC3eTcrmJJEaR3GxmdQVCJt85jmp9VyefMdjvKCu4BHnK/zTv55aNlQPCgb29Ys6MCWyd2uYd3w5UY1WaO0QfGSxQzqmLKtEEDjNdpQ8THJss0UNlk7BYZuyNsGtHbg6U+U2Wf70VPEbOnWGZ0NvrIIardRts5lkpDNr7Qt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f2X6QiRF; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f2X6QiRF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=RA
	hokeqFsbnBJbkEONFbaiYK9L1M4OIvSgOvIhmQECo=; b=f2X6QiRFk/6pwOZHlQ
	4Y8vfjNRD+AOfdP+G6JQgKjhavPI2nrilzCQMG2Waj3KHgEJBhXoKZ8VpBqFG3X/
	gDGfP1JNudaA7+5bhGzKosaSxCuGl4eY0jOFhLaUc47F82I6qtSnd9OvhDQn3N/H
	AnX2TWzzjvj+p5nGP41pLYUiI=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD330ZHN7VqyTtKAg--.25624S11;
	Thu, 24 Sep 2026 22:44:35 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 09/10] HID: pxrc: reject short input reports
Date: Thu, 24 Sep 2026 22:44:12 +0800
Message-Id: <20260924144414.1192037-10-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD330ZHN7VqyTtKAg--.25624S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr18Zw1xZr13ArW8AF45GFg_yoW8Jw48pF
	Z8t39Ykry5tw4xuw1DKF48Ca40kw1kXa4xWF93C3Wj93WYk34DGF4I9ryvvrW5ZrW0gF9I
	ga1qqwnxGFyj9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMfOzrUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhPpJGq1N1NNOgAA3c

The HID core invokes raw_event callbacks before validating the report
length.  pxrc_raw_event() reads byte seven and writes bytes one and seven
without checking that the report contains those bytes.

A one-byte input report reproduced the first invalid access under KASAN:

  BUG: KASAN: slab-out-of-bounds in pxrc_raw_event+0x161/0x260
  Read of size 1 by task hidtrigger/90
  Call Trace:
   pxrc_raw_event+0x161/0x260
   kasan_report+0x139/0x170

Require all eight bytes before reading or rewriting the report.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: acc3e34613da ("HID: Add driver for PhoenixRC Flight Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-pxrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
index 71fe0c06ddcd..e3755d8b85c2 100644
--- a/drivers/hid/hid-pxrc.c
+++ b/drivers/hid/hid-pxrc.c
@@ -55,6 +55,9 @@ static int pxrc_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct pxrc_priv *priv = hid_get_drvdata(hdev);
 
+	if (size < 8)
+		return 0;
+
 	if (priv->alternate)
 		priv->slider = data[7];
 	else
-- 
2.34.1

