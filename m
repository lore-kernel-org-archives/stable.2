Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B932D0EE;
	Fri, 25 Sep 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339782; cv=none; b=F5wsvXp/omOnySkaZZ0r1REiZ4kGLlnZ0GlLBcXDRKpMLeMlM2/52d574ORjOUO0qlcSVKWbgAOnzz6p8eI1cxTaSkJnrTY39q5N+YKvqXLJaymPU25SE3+AwSxZeKdkr1PGbXhXuWRy9+ApuAuuQEJ1LE+titVeFzgYiO/LKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339782; c=relaxed/simple;
	bh=rpQFIIFkv9fk4XIyvpy8zsWnjPeYC0WS8JZuxINRqHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h7akeUpqXPQrSktuXejBc0635AmIZTlzbSxstxlxTP7uxxIQz9Km1mCHqN3VKNH1JBDBesjUykvKdg4BEF6vS+G2O5fF8Y6mOQkyYZ3KaxxPz/36NyQQuOdiImKDa9gxIpxoELzkONofM/MdepOqUyIXAnKr/Ysifg9kLAByWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XHDOAbOm; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XHDOAbOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=67
	meGW5j/G0D+oDnqFcGKDrhbn8L41CakbHBABXFtL4=; b=XHDOAbOmvi66YtMvs3
	dTr5j5QEBxELn4tCmx+LdC8ChjF2rdjBA8dcpv/al+0p2kO+MPvy3cRXWnYU3ffA
	pbQBwhQOVeR8xcSlisEauBTdbLSOLuwAiX553on/l1VclOwjlH2m6AJrh/a1Do94
	pMU7PBKAyBLaDJ2Djor8ggaXc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD333ylarZqSbc3Aw--.20723S2;
	Fri, 25 Sep 2026 20:35:50 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] fpga: altera-ps-spi: reject devices without match data
Date: Fri, 25 Sep 2026 20:35:15 +0800
Message-Id: <20260925123515.2081743-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333ylarZqSbc3Aw--.20723S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF13try3XFWDWrWUtwb_yoW8GF1rpF
	WUWa4UCryDXFsxKrsrCry0vF90kan3t3yF93Wakwna93s5CFyrZrW8K3sYqwn2yFZ5JF1x
	tFW5Xw1ag3W0yw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEqg47UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgYMRmq2aqZR7wAA3s

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

The probe stores the result in conf->data and registers the FPGA
manager. A later programming request dereferences conf->data in
altera_ps_write_init() to obtain the device timing values, causing a
NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before registering the manager.

Fixes: 3b08f52c2561 ("fpga: altera-ps-spi: Use spi_get_device_match_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/fpga/altera-ps-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index d0ec3539b31f..69fcefce462c 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -240,6 +240,9 @@ static int altera_ps_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	conf->data = spi_get_device_match_data(spi);
+	if (!conf->data)
+		return -ENODATA;
+
 	conf->spi = spi;
 	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
-- 
2.34.1

