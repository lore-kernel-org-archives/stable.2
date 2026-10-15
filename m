Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A751FCBD;
	Thu, 15 Oct 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067994; cv=none; b=GDoL/29ltnglyO0vfkePOvJMGDBUL+bm5WHh5UJQmvDCM0QetaVJUGEpn9Y/UDNRly4ui1o6yrysQEMBPwo0NDrVIk86aam0fm/5L9gPEm0ok5t6oprw1dypmIMoOGiHUWWE6gJ1AVZ+gNtgpBwQgRTIOcTcXo+Q1XMJYx3Jfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067994; c=relaxed/simple;
	bh=xfqloxc207DM+3vrjBhxius1ZMSYVn/4xB0SR0ElFGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abvcNGrdFnz2K8yo79bmUjf4XsLbdwwn+NHFMT0HTy/GMFWVYq6wm5O9lLDyrYReumprzTuYzqvqc6ZaRtzf+PFK1cpMOMSOtA31VDFp5QV9rt3BjS6ZCJMmtx0PBgdSlmQHMgxu66p2F9cv5gFe2l6Kq/3xGttBd+16UWPCDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Eg2JKhzf; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Eg2JKhzf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792067985; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=Mq1uH6lmyEW8LmLn6qrjqg09TEW142OSbNDM2kTf6Eg=;
	b=Eg2JKhzf1Br6/t86Xjh3Fi60xRkwkRE8H6i1VSYwLUSPrsmafc60yY3AD26hiaL54tEeUh1Ff+6CSkGfl1USO8o++sID2aIG7CZ765i890uH5tu+k6wOchsrnjHvRF0IVFFh0iT81zx4gOrbcwr+NMfQV+f7pPuuJcDzrLQtb5g=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0767712|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00585194-0.00310147-0.991047;FP=3309286753990020273|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jem-UEy_1792067984;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jem-UEy_1792067984 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 20:39:45 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Thu, 15 Oct 2026 20:33:12 +0800
Subject: [PATCH v2 1/2] mfd: sprd-sc27xx: pass byte length to spi_read()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-spi-sprd-adi-exactlen-v2-1-13203b6aef7e@xiaopeng.com>
References: <20261014-spi-sprd-adi-minlen-v1-1-77fee7e64259@xiaopeng.com>
 <5e662ac5-efea-46dc-bd09-88a5a4841851@sirena.org.uk>
 <20261015-spi-sprd-adi-exactlen-v2-0-13203b6aef7e@xiaopeng.com>
In-Reply-To: <20261015-spi-sprd-adi-exactlen-v2-0-13203b6aef7e@xiaopeng.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lee Jones <lee@kernel.org>
Cc: Weibin Liu <liuwb@xiaopeng.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-spi@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>, mfd@lists.linux.dev,
 Guanglei Zhu <zhugl3@xiaopeng.com>
X-Mailer: b4 0.14.3

sprd_pmic_spi_read() passes 1 as the transfer length to spi_read(),
but the length parameter is a byte count, and the ADI controller
consumes a u32 register address from the buffer. The ADI driver
ignores the transfer length and always operates on the first u32,
so this happens to work with the 8-byte stack buffer, but the
advertised length does not describe what the controller actually
accesses.

Pass sizeof(u32) so the length matches the bytes touched by the
controller. The companion patch to the ADI driver rejects lengths
that do not exactly match the ADI register access size.

Tested in QEMU (aarch64 virt) together with the companion patch:
the SC27xx driver's register transfers still pass the new length
checks once it advertises the byte length.

Fixes: 25ca4ae43466 ("mfd: Add Spreadtrum SC27xx series PMICs driver")
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 9a8e6add8fca..8759cee052b0 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -156,7 +156,7 @@ static int sprd_pmic_spi_read(void *context,
 
 	/* Copy address to read from into first element of SPI buffer. */
 	memcpy(rx_buf, reg, sizeof(u32));
-	ret = spi_read(spi, rx_buf, 1);
+	ret = spi_read(spi, rx_buf, sizeof(u32));
 	if (ret < 0)
 		return ret;
 

-- 
2.50.1

