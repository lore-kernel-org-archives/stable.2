Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416811;
	b=u4XWZdpGxrvBWiFxmR8eEm1q3HKCToopBLUTgHmDhX2VzjK5QX6LKAT5okCsFe3WAuEi
	 PQ6GnSnNZ1aZc31Nac4B9mQi6Ie+OzikkRQolE0ISF5zZPI9RLxe133qfJxlOfLZ3UUlO
	 /ZOfTW19IpWG6qxtJE1NkvSBDbwXOmrvPvVNSXxPyiQMMf8lWAveSKWR36w8s80MFl3cY
	 IajXt+GzAwsX6fVtBfaPEXLzD6m0ZBU+e6O2F0z32PTTNabtv/UB8ho1YxuDrf+bim/Al
	 ouAFZAfedfomXegH6aiv//+nV/YmyUmL1ZSdsUtosStrw50HA3NgHWJzJgfDN0sFo3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z+ORvXgi1LbZOEvwI1ZM4L6LkhBJUEFOx8QQSqzi1Cg=;
	b=oxUBm5pDztX954nVambKMtU9m6ebwDYrYJhFfOKCjLhTy5yEG5vVPS9axUTGRwfGevqX
	 LRFjK3R3QWEewpxUvEIimW15mzebjv7/kv0Kfzbw2VRHDXz/Im1Ze299eB10r6DLRJTU5
	 ibM+HGgVeuguboXWGM3fD+vmAb1kABaLoaHsiI95ss1K5Lcg1mY5Hv78omo1i6tPXh7lw
	 /FZZtp0mb1rJDB90EaczkB45aDF5uBayNF/oJzzeZltLxpKZF2Z7RWhla70cpGYq6ddVZ
	 +bLrhyQJFhZQpYRfGGOYoXS4uipYjjd870H7fL1CSMhZ1g7ctWsO7/WIDsFzfOC9BJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2G8SuCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40C606A8AC
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2G8SuCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063B81F00A08;
	Wed, 11 Nov 2026 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416811;
	bh=Z+ORvXgi1LbZOEvwI1ZM4L6LkhBJUEFOx8QQSqzi1Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V2G8SuCYJ34G05DzMI6PvGWhLNNNyrLJhbg3Z4RxQvCLH40lRD2Y6oD49hgINSRqF
	 hAlcJmqapT/R35D/NGCpqdkOYZdMz9SJzjpwjEYeqnRGP5h8RHgKvWqG2YVNz2V6Lw
	 es8ySaVGQx9khV1OGzfMi7v/6KhNyIkn3FueQbdfonGUxoKWBM/ZuVxHmYaWqH5fha
	 UpRiA8h+pmD1ij586aIBPlW+ONZxil/Djzegcla+y1wD0YNttAEy02SQ7ToXImQJED
	 yALvYZq0tBk+VWohj/ET4ObDY1kYyfjB2q8OzX6F4ljyR/55mBYLG2vCGLKE9M3bmo
	 VAaj2Gp7JS1Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] spi: cadence-xspi: reject SDMA transfers larger than the requested length
Date: Wed, 11 Nov 2026 12:06:49 -0500
Message-ID: <20261111170612.3392578-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054911-failed-6.1-ea9854a169e9@kernel.org>
References: <20261107054911-failed-6.1-ea9854a169e9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weibin Liu <liuwb@xiaopeng.com>

[ Upstream commit ea9854a169e9c1437df8829bea21c2f2e80b137c ]

The XSPI controller reports the size of the slave-DMA transaction
through SDMA_SIZE_REG. Both SDMA handlers take this register at face
value and copy the reported number of bytes between the SDMA FIFO and
the transfer buffers, without checking it against the length of the
transfer that was actually requested.

While cdns_xspi_adjust_mem_op_size() clamps the size of the operations
issued by the SPI core, the device can still report a bigger SDMA size
than what was programmed, which makes the handlers read from or write
to memory beyond the end of the transfer buffers.

Track the number of bytes requested for the current data phase in a new
sdma_xfer_len field, set by cdns_xspi_send_stig_command() and by the
Marvell b0 transfer path, and reject any SDMA size that exceeds it.

Fixes: a16cc8077627 ("spi: cadence: add support for Cadence XSPI controller")
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Link: https://patch.msgid.link/20260929081146.41041-2-liuwb@xiaopeng.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ sashal: Adapted SDMA handling to the existing direct-call and byte-wise I/O implementation without Marvell support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index b8bed8f39d2ae..d5e3bd2cb7722 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -221,6 +221,7 @@ struct cdns_xspi_dev {
 	int irq;
 	int cur_cs;
 	unsigned int sdmasize;
+	unsigned int sdma_xfer_len;
 
 	struct completion cmd_complete;
 	struct completion auto_cmd_complete;
@@ -327,7 +328,7 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 	return 0;
 }
 
-static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
 	u8 sdma_dir;
@@ -336,6 +337,13 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
 	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
 
+	if (sdma_size > cdns_xspi->sdma_xfer_len) {
+		dev_err(cdns_xspi->dev,
+			"SDMA size %u exceeds the requested length %u\n",
+			sdma_size, cdns_xspi->sdma_xfer_len);
+		return -EINVAL;
+	}
+
 	switch (sdma_dir) {
 	case CDNS_XSPI_SDMA_DIR_READ:
 		ioread8_rep(cdns_xspi->sdmabase,
@@ -347,6 +355,8 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 			     cdns_xspi->out_buffer, sdma_size);
 		break;
 	}
+
+	return 0;
 }
 
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
@@ -392,6 +402,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
 		cdns_xspi->in_buffer = op->data.buf.in;
 		cdns_xspi->out_buffer = op->data.buf.out;
+		cdns_xspi->sdma_xfer_len = op->data.nbytes;
 
 		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
@@ -400,7 +411,11 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 			cdns_xspi_set_interrupts(cdns_xspi, false);
 			return -EIO;
 		}
-		cdns_xspi_sdma_handle(cdns_xspi);
+		ret = cdns_xspi_sdma_handle(cdns_xspi);
+		if (ret) {
+			cdns_xspi_set_interrupts(cdns_xspi, false);
+			return ret;
+		}
 	}
 
 	wait_for_completion(&cdns_xspi->cmd_complete);
-- 
2.53.0

