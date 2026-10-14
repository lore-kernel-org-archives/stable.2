Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C714A8402;
	Wed, 14 Oct 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981887; cv=none; b=uHfvfcnkjs+pD5tKFXBWfiOIExML41UEySBfrwhGeoUILgbut5n8duBit0LHSmZXwjG1KsCs2sNL//tNr0PEDsENyxIjViDTxc2oAGhLRJuZDNl8QE+4t0iBPjwdMuIHdl9k1/pfOg+fOmaHTgVFxcw3uJ2YaLkHW+MsY8WU/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981887; c=relaxed/simple;
	bh=mDdHTf516IGdoumw3MzJZu24tCIn8a+7Bldy2FJU7ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=acmVPuDQRQcy4jz52c4+YD6x0ei8R0tFIPyt8ud2IfH2sNEc7mIOsV4P4kkB+CqSBbzOy81436O3uGQ3fqRmJ7iZ2vcVM6HiPllc/9+V4Xn9Uybiz8WIks/k7x8SXacO/eRVI/KfLqcBubiWnG/Rx4yzEphBAC/NWsB7m4iHYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=OShhyR3D; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="OShhyR3D"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791981876; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=TeiDUz19S3tq4icMyyjsdQWJGtyrb+93Ex4WAelrBbE=;
	b=OShhyR3DvQeHP93XIfBnvCKlhz1BCprZ+9qw52CmHKHMrcG0/LdpSylyj/e3he6IN4Dp3O5SyG7hhQWvWhSxU0fdfhkBhrsndaWtTZ4Uf0v6CJgJmS78I3lxquhLusnr78e8hal+RlN0DIV/ceLcEYcRaaLPH842L+FoT2FuH1k=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436308|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0135348-0.00108863-0.985377;FP=11192971816904312030|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jdAkDg1_1791981553;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jdAkDg1_1791981553 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 20:39:14 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Wed, 14 Oct 2026 20:39:13 +0800
Subject: [PATCH] spi: amd: fix len==0 underflow and FIFO overflow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com>
X-B4-Tracking: v=1; b=H4sIAPB3z2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0MT3eKCTN3E3BTdtMy0fCBRoWtsnphskppmYJqUZqYE1FZQlAoUBhs
 ZHVtbCwAw1hV3YgAAAA==
X-Change-ID: 20261014-spi-amd-fifo-fix-37ac4ef05bf6
To: linux-spi@vger.kernel.org, broonie@kernel.org, Raju.Rangoju@amd.com, 
 krishnamoorthi.m@amd.com
Cc: linux-kernel@vger.kernel.org, sanju.mehta@amd.com, 
 stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>, 
 Weibin Liu <liuwb@xiaopeng.com>
X-Mailer: b4 0.14.3

amd_spi_fifo_xfer() unconditionally decrements xfer->len when a tx_buf
is present. The SPI core does not reject zero-length transfers, so a
transfer submitted through the SPI_IOC_MESSAGE ioctl with len == 0 and
a tx_buf makes the u32 len wrap to 0xFFFFFFFF, and the following
per-byte loop writes far past the FIFO window.

The driver also never checks the cumulative FIFO offset against
AMD_SPI_FIFO_SIZE. The core splits each transfer down to the
controller's max transfer size but does not bound the total message
length, so a message of several transfers whose total exceeds the FIFO
overflows it with out-of-bounds MMIO writes (tx) and reads (rx).

Skip zero-length transfers and reject any transfer that would run past
the end of the FIFO window.

Tested with a user-space replica of the fifo_xfer length arithmetic
(ASAN build): a zero-length transfer with tx_buf makes len-- wrap to
0xffffffff, and skipping zero-length transfers avoids the wrap. No AMD
SPI hardware was available, so the FIFO bound check was verified by
inspection against AMD_SPI_FIFO_SIZE.

Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
Cc: stable@vger.kernel.org # 5.8+
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 71a6e5c475b0..ddf89e5353c5 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -322,11 +322,22 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 
 	list_for_each_entry(xfer, &message->transfers,
 			    transfer_list) {
+		/* Skip zero-length transfers to avoid len underflow below */
+		if (!xfer->len)
+			continue;
+
 		if (xfer->speed_hz)
 			amd_set_spi_freq(amd_spi, xfer->speed_hz);
 		else
 			amd_set_spi_freq(amd_spi, spi->max_speed_hz);
 
+		/* Reject transfers that would overflow the FIFO window */
+		if (fifo_pos + xfer->len >
+		    AMD_SPI_FIFO_BASE + AMD_SPI_FIFO_SIZE) {
+			message->status = -EMSGSIZE;
+			goto fin_msg;
+		}
+
 		if (xfer->tx_buf) {
 			buf = (u8 *)xfer->tx_buf;
 			if (!tx_len) {
@@ -369,6 +380,12 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 
 		list_for_each_entry(xfer, &message->transfers, transfer_list)
 			if (xfer->rx_buf) {
+				/* Reject transfers that would overflow the FIFO window */
+				if (fifo_pos + xfer->len >
+				    AMD_SPI_FIFO_BASE + AMD_SPI_FIFO_SIZE) {
+					message->status = -EMSGSIZE;
+					goto fin_msg;
+				}
 				buf = (u8 *)xfer->rx_buf;
 				/* Read data from FIFO to receive buffer */
 				for (i = 0; i < xfer->len; i++)

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-spi-amd-fifo-fix-37ac4ef05bf6

Best regards,
-- 
Weibin Liu <liuwb@xiaopeng.com>

