Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366973E40FE;
	Tue, 29 Sep 2026 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668901; cv=none; b=LZZpb9n/eTXaXfFWNfZ5h+TZiiDIKUrv9ylJenifB7Gdg73olZ3jn8/cw/Fh9W3YY33uQmcsKEo/OmNkZokWW8TKrr2Wd+A00tldO+1yOnqVV6apdUsEruRbbKQnEykgMZfMpiZkIx1Aj0LDeXHhekRbGFSKm8ovDDbhjcSLkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668901; c=relaxed/simple;
	bh=FevbvR1Zg9k5Qy6r7fWziA3yOcFsBtehL5Iq3oXCDN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Frpx3rQ18uRzBxedZbM28FldtMolQXvm/OjJuHzRSQt0w6IbQqSl0JG9ljvNCsrJuUHNA87YUo2Tq0P/SMEXOFWwCUkb8SPALLcm2VQEXHob5MiEGi2s2+Lumeo0xbd+bFPMntTup4UyhHgWeFHvc+g3gWB4HG0+02LEzrdl/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=uDnfHbSd; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="uDnfHbSd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790668888; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ocj5Dw2czsY2Kug2CQGjyPGMTvL96e0VdEymMseMCB8=;
	b=uDnfHbSd4ebfTvRnS0IYB23Tm/VBlrFCfkUll0hxX9P4ZgA+B58atZjjry/5SOoRT4lcGH6icwWAoapGhX63gBG6m7kdYduG/iM2+9kYpnz1vkSrr1U0JTPauYpS36FIv5lXDeDeqoe0IqzLd52X3sqW5TpcXO5QMz829j85ZxI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437829|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0106428-0.00121216-0.988145;FP=10218751077233724657|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jR9XL0d_1790668886;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jR9XL0d_1790668886 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 16:01:27 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: wentong.wu@intel.com,
	lixu.zhang@intel.com,
	sakari.ailus@linux.intel.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] spi: ljca: validate the response length before copying the data
Date: Tue, 29 Sep 2026 16:01:26 +0800
Message-ID: <20260929080126.4168981-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

Reject responses whose announced payload is not fully contained in the
received data or exceeds the requested transfer length.

Fixes: caee8e38da67 ("spi: Add support for Intel LJCA USB SPI driver")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Reviewer notes:

- r_packet->len is a device-controlled field; the old code only
  required it to be non-zero before memcpy()ing that many bytes into
  the caller's buffer. The receive buffer is LJCA_SPI_BUF_SIZE (60)
  bytes, so an announced payload larger than what the adapter actually
  sent already reads past the end of the input buffer, independently
  of the transfer length.
- The new check bounds the payload by both the number of bytes
  actually received (ret) and the requested transfer length (len), so
  the copy stays inside both buffers.

Tested on x86_64: with this patch applied the driver builds, loads and
unloads cleanly; no LJCA adapter is available to exercise the SPI
transfer path on hardware.

 drivers/spi/spi-ljca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ljca.c b/drivers/spi/spi-ljca.c
index 0c6e6248d..bd07e5df9 100644
--- a/drivers/spi/spi-ljca.c
+++ b/drivers/spi/spi-ljca.c
@@ -105,7 +105,8 @@ static int ljca_spi_read_write(struct ljca_spi_dev *ljca_spi, const u8 *w_data,
 			    (u8 *)r_packet, LJCA_SPI_BUF_SIZE);
 	if (ret < 0)
 		return ret;
-	else if (ret < sizeof(*r_packet) || r_packet->len <= 0)
+	else if (ret < sizeof(*r_packet) + r_packet->len ||
+		 r_packet->len <= 0 || r_packet->len > len)
 		return -EIO;
 
 	if (r_data)

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
prerequisite-patch-id: e48582f6ffe124b3806593af6e22b74682c8a83f
prerequisite-patch-id: 369f74b9a7ecde56141b13ec671f9200345a3bab
prerequisite-patch-id: cbf6f60473c80add5b2cddf22d142f35a4e3c834
-- 
2.50.1

