Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0D41D657;
	Thu, 24 Sep 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259239; cv=none; b=FP7Otuyg/Ae6bf2J7TnbXLGwAdURuYFothbhH+4kFFR7xx+lHN8EdpTISTCK3kpsBM1NbH2dmn0Pzx4112Pc4zUaUXh5T9C/8LCDs2AEvIlp9kk9NELK3LKVwoVUYKYc657N4PoBXl2ATjlHMqnXfdashNHjnDhwSiw77gaEtfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259239; c=relaxed/simple;
	bh=ERmwH0szn+7hBGZF2YJaSwG+CsGPO7spEvKIQFI1u1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPGyHt+vRcyJ4+YksiJSIWHpNM65Z+bBm/qTjf0KaVOs022dX31sK+W1xYmpLDaO3KbEmEwQ7ksPgIPrgiNfnLFhj0jraW2Cun5k2Ixx/XIe1WVG4dzsmkgfbZS2euNDdKT/dm7YY+0ETSVU1SViBogIcnLmOP97dJ/13Bcd9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GqNkEfEw; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GqNkEfEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=RA
	hokeqFsbnBJbkEONFbaiYK9L1M4OIvSgOvIhmQECo=; b=GqNkEfEwN4wUyY7oW9
	08xxW4nud3r5MYz9rfKF1l7pjh72VnwB0niGEAeIz6EnjfvZGtm4O7GRyrmLcZG/
	0+oCCTtShCpJ5FJagxmPZm2pRL80psERxQ49Ag3a0YYTnaVBUxPknXTtJh+KgsGR
	HdpVgQz3gRV7MKj1xhRvQ7SMI=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXN8sIMLVqBMA4Ag--.5098S11;
	Thu, 24 Sep 2026 22:13:40 +0800 (CST)
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
Subject: [PATCH 09/10] HID: pxrc: reject short input reports
Date: Thu, 24 Sep 2026 22:13:24 +0800
Message-Id: <20260924141326.1154421-10-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDXN8sIMLVqBMA4Ag--.5098S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr18Zw1xZr13ArW8AF45GFg_yoW8Jw48pF
	Z8t39Ykry5tw4xuw1DKF48Ca40kw1kXa4xWF93C3Wj93WYk34DGF4I9ryvvrW5ZrW0gF9I
	ga1qqwnxGFyj9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pib4SwUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BUZU2q1MBVc8gAA37

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

