Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023153C3C9;
	Wed, 14 Oct 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986456; cv=none; b=WDhdC0R2M3ZyZx1xREX7jCIckb2Qv7b9jyEG1ZrAZKZQzxIeA7G5BxM1ycjf/5n2M/AjwTlXJgGnSSlOEuGUxvbIgQOOwgzvMmafTfAkg/epOpdE8ruU/aIOA5nkd4rLRoMYaxNvoLI4rwh2br4V/7EeoZNg1iRXn6d8KpH/qaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986456; c=relaxed/simple;
	bh=M1HtyX/GuabzKa6KGI9dunJ3SHo1m4BPFa4/a7e3Gjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NultIivQAsduGk+ph8T214B/lfebq3a7u+Y6lJPxQ/V7YqOweLPubM9niSe4dtVuclCOiT5MebW+M2s1E7N4tWNjmo9fR7U+y+D/toptzJFHQ6zAqj1k0Njz7IcEAGrVbdTKq3zuW346+n5CUSshYhkgoJaM7zN/L9RF5a3lbWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=NuQF+m6z; arc=none smtp.client-ip=115.124.28.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="NuQF+m6z"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791986439; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=KXmjObW56wqK+XYVm3fO7eIclnO2pl8ldM8jZcDkjD0=;
	b=NuQF+m6z+MD7trOtwVJ9GG5M3KiH8BOXtlsiNYdMFMfynkbe29N8pHd7YNZol+Jeef1ExEzcgnkwBudyRr+8JBuglcAHx42zHf5VXPIxaFGk3ye8E89Xwt7kie7CNbW4CfSjOj/ivJ7xXormlcUDqwfJwV9ExPsfUQdHEYUzAl4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07471394|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00871135-0.00179765-0.989491;FP=12889925095836494970|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jdJOS1l_1791986437;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jdJOS1l_1791986437 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 22:00:38 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Wed, 14 Oct 2026 22:00:38 +0800
Subject: [PATCH] spi: sprd-adi: reject transfers shorter than 4 bytes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-spi-sprd-adi-minlen-v1-1-77fee7e64259@xiaopeng.com>
X-B4-Tracking: v=1; b=H4sIAAWLz2oC/x2MQQqAIBAAvyJ7bkElLftKdIhca6EsFCII/550m
 MMcZl7IlJgyDOKFRDdnPmMV1QhYtjmuhOyrg5baKqlazBdXksfZMx4cd4qoe2NlcOQ7Z6CWV6L
 Az38dp1I+zDK7rWUAAAA=
X-Change-ID: 20261014-spi-sprd-adi-minlen-28560f9ed795
To: zhang.lyra@gmail.com, broonie@kernel.org, linux-spi@vger.kernel.org, 
 baolin.wang@linux.alibaba.com, orsonzhai@gmail.com
Cc: linux-kernel@vger.kernel.org, Liu Chao <liuc63@xiaopeng.com>, 
 stable@vger.kernel.org, Weibin Liu <liuwb@xiaopeng.com>
X-Mailer: b4 0.14.3

sprd_adi_transfer_one() dereferences t->rx_buf and t->tx_buf as u32
without validating t->len. The SPI core does not enforce a 4-byte
minimum, so a transfer of 1..3 bytes (e.g. via spidev) makes the
driver read 4 bytes through (u32 *)t->rx_buf and store the result
back, and on the write path read two consecutive u32 values from
t->tx_buf. With a buffer allocated for fewer bytes this runs off the
end of it: the read path reads and writes up to 3 bytes past the
allocation and the write path reads up to 7 bytes past it, corrupting
adjacent heap objects.

The ADI protocol only supports 4-byte register accesses, so reject any
transfer shorter than 4 bytes with -EINVAL before touching the buffers.

Reproduced with a user-space replica (ASAN build): a 4-byte u32 access
from a 3-byte buffer triggers a stack-buffer-overflow READ of size 4.
No Spreadtrum hardware was available, so the -EINVAL rejection itself
was verified by inspection.

Reviewed-by: Liu Chao <liuc63@xiaopeng.com>
Fixes: 7e2903cb91df ("spi: Add ADI driver for Spreadtrum platform")
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-sprd-adi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index a6baaf02b3c8..24ece07ab5e6 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -338,6 +338,12 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	u32 reg, val;
 	int ret;
 
+	/* ADI only supports 4-byte register accesses */
+	if (t->len < 4) {
+		dev_err(sadi->dev, "invalid transfer length %u\n", t->len);
+		return -EINVAL;
+	}
+
 	if (t->rx_buf) {
 		reg = *(u32 *)t->rx_buf;
 		ret = sprd_adi_read(sadi, reg, &val);

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-spi-sprd-adi-minlen-28560f9ed795

Best regards,
-- 
Weibin Liu <liuwb@xiaopeng.com>

