Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A330F52B;
	Tue, 13 Oct 2026 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861450; cv=none; b=BnQMVaYRQnWTToAjaHWeSqdETe5uI/41W7hQt9auPIMuFZuELAF/GD0spnDoqkohx3jneKFCep0IbFiKvxQDa2u3HDPnBH7H8rgqd8Jfx5LMTDzJiaeP95doNPbpFRdBVYXnGp6Uyg2m8dmZzFWe0LBjx/3oyeWKDE6Ss8YJ4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861450; c=relaxed/simple;
	bh=oqDRtHDHS8cfhEC9V7UJ37223+ayv8mJTGtMcuQillU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NekBUbYNbYACEXLh6iwfBIIEAS4kcd9Yz4j1cFYG1hVKxQA+E02OiaaGH+pyZb158TVioJDNZpBn1HjuQsaLNhZuzdNG0/7Or05pdMLGE8scMF/fj0VzHc1cplf/uu7ntjn4vWhdeY/Dquf8GOJJHrhZHLDnNvzObSYuE1bvV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=lD5aGH/k; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="lD5aGH/k"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791861439; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lPN+z3EgMFXPMSMODHApgJuDQCNeOicr2z2iHKWcDk8=;
	b=lD5aGH/kuh1A4Kpx7h6Cr6eJ+T2nRB+HUWi45MB0dy974n+tT+0Siq/GJ7LUjTSCXnzVx8nhJShZzPyp8LhP0RgJ82BinEwL5L7uP/9e6W8wfgsev4MNStOsCmI6X8kdPQCI9nuLHhVSbWPrbecEEqDx/VR7ywNbhUUFSPBTX30=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07451011|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00509174-0.00094658-0.993962;FP=10146692383684185273|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jatvAiU_1791861437;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jatvAiU_1791861437 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 11:17:18 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: wentong.wu@intel.com,
	lixu.zhang@intel.com,
	sakari.ailus@linux.intel.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: ljca: validate the response length before copying the data
Date: Tue, 13 Oct 2026 11:17:17 +0800
Message-ID: <20261013031717.3933277-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929080126.4168981-1-liuwb@xiaopeng.com>
References: <20260929080126.4168981-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ljca_spi_read_write() only checks that the response from the adapter
carries the packet header and a non-zero payload length before copying
r_packet->len bytes from the response into the transfer buffer.

The payload length is taken from the packet the device sent back and is
neither bounded by the number of bytes actually received nor by the
size of the requested transfer: a misbehaving adapter can announce a
payload larger than what it actually sent, and the memcpy then reads
past the end of the 60-byte input buffer and writes past the end of the
caller's transfer buffer.

Check that the response carries the full header before reading
r_packet->len, then reject responses whose payload is not contained in
the data received or is longer than the requested transfer.

Fixes: caee8e38da67 ("spi: Add support for Intel LJCA USB SPI driver")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Changes in v2:

- Check for the full header before reading r_packet->len (Mark Brown).
- Regenerate on a clean tree; v1 carried prerequisite-patch-id entries
  for unrelated patches.
---
 drivers/spi/spi-ljca.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ljca.c b/drivers/spi/spi-ljca.c
index 0c6e6248d..8fd001610 100644
--- a/drivers/spi/spi-ljca.c
+++ b/drivers/spi/spi-ljca.c
@@ -105,7 +105,12 @@ static int ljca_spi_read_write(struct ljca_spi_dev *ljca_spi, const u8 *w_data,
 			    (u8 *)r_packet, LJCA_SPI_BUF_SIZE);
 	if (ret < 0)
 		return ret;
-	else if (ret < sizeof(*r_packet) || r_packet->len <= 0)
+
+	if (ret < sizeof(*r_packet))
+		return -EIO;
+
+	if (!r_packet->len || ret < sizeof(*r_packet) + r_packet->len ||
+	    r_packet->len > len)
 		return -EIO;
 
 	if (r_data)

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.50.1

