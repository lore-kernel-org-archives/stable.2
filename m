Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA00382F03;
	Thu, 24 Sep 2026 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259250; cv=none; b=Jkwgg/c9qQrKYQ8lyfHroCZlxsu1iJZbXo+w1h5YH+YpzKE/5hAqhLJ84C+rC/fu7aFK7yxrPrrPa1vuAtCQlJ3rg9m4lsDPZUs6Q79VVJezK1svFVg4EOaWEe8z0BwTkf9M4bzHNE7Z6dELnVqH26OmhbP9Bn9ZrAxR8Zf4DTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259250; c=relaxed/simple;
	bh=I0x4pLD4nLQwGeVJ220ZLW09C9oN4AYcKS5nDS8BcW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebfm4EdJypec4rxqTS5Q0CqDU/ulpYev12SCuvL36/fqRN7JRoXSMjP6gsM35RGoElgTbwCBdgAXzplLyp6G368c5ENJr838BiYi9HydfDiJ0v4g2S1FP9RvRtuFgj5VZzPg207OuQLenviBGxe9LepcJ/wXuXiVxzTZvfGTrj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N4lHVaLN; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N4lHVaLN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7e
	zqlRLaB/m82usWg35QC8fvDRKkXCvResgkSMj6v4E=; b=N4lHVaLNIQtpQv25Zx
	D1Yu2lI8jpbgUsOzbR9Q4eVqxQX7+ul9JUkLbu6K8uvcCaB+aMarFvtLpxKA1vGW
	RgonBjrkR+zr4Xpa7llth4Q2J/XyDCe1t/26jTDvlfpFthII5XLsGntDDDGmg7jo
	QqrqP+3KrP0O23wsfLceiYAjA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXN8sIMLVqBMA4Ag--.5098S9;
	Thu, 24 Sep 2026 22:13:38 +0800 (CST)
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
Subject: [PATCH 07/10] HID: mcp2221: validate response report length
Date: Thu, 24 Sep 2026 22:13:22 +0800
Message-Id: <20260924141326.1154421-8-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDXN8sIMLVqBMA4Ag--.5098S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW5tr4kAw4rXFyxWr4rXwb_yoW8GF43pF
	Z0q39YyrW5Jr4I934DCr1kG34fG3Z7G3y7uFW3W3WrX3s8Gw1YyF1j9asYgrWrXFWvgFn3
	Jws5KrsxGa4j93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pijQ6LUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRIYUmq1MBJFQAAA3t

MCP2221 responses are 64-byte reports, but mcp2221_raw_event() currently
accepts any report of at least four bytes.  Several response handlers read
far beyond that minimum.  In particular, the I2C status response reads
offset 20 and copies ADC samples starting at offset 50.  Other GPIO, SRAM,
and flash response handlers also access fixed offsets beyond byte three.

The HID core invokes raw_event callbacks before validating the report
length, so a truncated response can cause an out-of-bounds read.  Require a
complete protocol report before dispatching any response handler.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-mcp2221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index d52ce3531ab7..db0b15622c39 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -865,7 +865,7 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
-	if (size < 4)
+	if (size < sizeof(mcp->txbuf))
 		return 0;
 
 	switch (data[0]) {
-- 
2.34.1

