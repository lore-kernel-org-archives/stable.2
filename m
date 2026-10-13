Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99D48641C;
	Tue, 13 Oct 2026 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870232; cv=none; b=G5Lb4vtQIRilv9XvEgCYNO1RMMGt1ZPq/+wOl7mx+Dvkt9J3kGLaR9FWLr2WxmtZRITcc+c7UdgmBlletJ0GaQ/8Dd+qBWx0UUrsUopW82/3zNnutmzGAGEACeM7cmQ7KCP3htCt9f7vzbMh10yZY80H43lm/GAXuznZH/SJxDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870232; c=relaxed/simple;
	bh=6bJS+k1/gc2Tsyv/9juJug8u4fHJ03qelOvsCrch6NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wtsj+qeOuBWcaXPHVolpruVPWYGuJTHSILRGLyQVjc9v5wfUkMy26sYdMWUVfI2hrRM0q5+pzc3n4lL6kLYQF+HNIOEAp3qDikHgUFnmy0EnPoQf29yqMOHd9eDDs3kHknqMbdym0N84nVC56BmlRsbHpao9496bMrgE5m+Nx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=L5fqdPHc; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="L5fqdPHc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791870221; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hm7RovbDj9xZoiFp6sWkbbpUg8po/7TsN/jrvQ43fJg=;
	b=L5fqdPHc3Iw0ozGlTsFE9bN0R4bg0ZJk0vd9W9McktwmSrNlhSYbJ94/nJpt2+y6PiDMDrhj+EOj7nUEvI/sdGAxtTwJamf1qHDJ4WoUls4uAcPNkUfkCx1cGhnN5JHM+UMfwtHw2qduuMrsjp3frcBCLFAHjhXLJ1+cvle3lcM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07899456|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00511588-0.000218161-0.994666;FP=10013908775060655552|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jb7aQWV_1791870219;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jb7aQWV_1791870219 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 13:43:40 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: jth@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: ch341: handle transfers without a TX or RX buffer
Date: Tue, 13 Oct 2026 13:43:39 +0800
Message-ID: <20261013054339.77477-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929081152.41753-1-liuwb@xiaopeng.com>
References: <20260929081152.41753-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ch341_transfer_one() unconditionally copies from trans->tx_buf into the
TX packet and hands trans->rx_buf to usb_bulk_msg() for the readback.

The SPI core allows half-duplex transfers where either of the buffers
is NULL, so a transfer without TX data crashes the kernel on the memcpy
and a transfer without RX data makes usb_bulk_msg() store the received
data at address 0.

The CH341A clocks data in both directions on every transfer; there is
no mode to disable a direction. Set SPI_CONTROLLER_MUST_TX and
SPI_CONTROLLER_MUST_RX so the SPI core fills in dummy buffers for
half-duplex transfers.

Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Changes in v2:

- Set SPI_CONTROLLER_MUST_TX | SPI_CONTROLLER_MUST_RX instead of
  handling NULL buffers in the driver (Mark Brown).
---
 drivers/spi/spi-ch341.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 6448a44a8..56a5caa59 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -189,6 +189,12 @@ static int ch341_probe(struct usb_interface *intf,
 	ctrl->transfer_one = ch341_transfer_one;
 	ctrl->set_cs = ch341_set_cs;
 	ctrl->auto_runtime_pm = false;
+	/*
+	 * The CH341A SPI_STREAM command clocks data in both directions on
+	 * every transfer, so the driver always needs a TX and an RX buffer;
+	 * let the SPI core supply dummy buffers for half-duplex transfers.
+	 */
+	ctrl->flags = SPI_CONTROLLER_MUST_TX | SPI_CONTROLLER_MUST_RX;
 
 	usb_set_intfdata(intf, ch341);
 

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.50.1

