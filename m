Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885222E92BA;
	Sun, 19 Jul 2026 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784492424; cv=pass; b=ZwwKniIZZFVTehSciSE2Ac+0f3i1+wIilbpP2AMfF2HM4DvroLyfi1zAWUaTgHlzAVgHaVCme5R7Ugetu8a2bnzgnyXiXhkjQmnpIHyqxY6cD59fjEBOIYGymjKXAaaNFKWlMztmtVCl7ttdf7utQzdNnT+tv/a3VsVnCVYtC6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784492424; c=relaxed/simple;
	bh=kKlQiAmYKfNPgF+zFR0/vyJuTZHscc+/RcHIOIdYaWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=joq7A/JBzguLiXYLCPK3AKOzfhfRrZWkYF9omtaNDzpgKYhPRg4i7ZmorYNXfVBgV0HlNzJN5pnQ/wI9CoOf2M5uWidItFfM2I8S6N7cl9r5IyZml1ugPeS4+xqzglt86CNZ0KCs364HTteOQ2OW/SZdf3q1XzwJrvF4Ck+SeXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=bNxiirRN; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=+fljUks5; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bNxiirRN";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="+fljUks5"
ARC-Seal: i=1; a=rsa-sha256; t=1784492403; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kjVIf541L8Bu1M8hfqi0BuYngxoSzPNz4X4lFdSyhuzQCoYzfvIdtR2bvBMhhAuciv
    CaqELYbIS4hZ2/t2c9Y8JaQ32oRcXGC15Rq6wNqqUgLRcv7p8hDh6K4o2QY+mo1q8F61
    hdsD+xkbVlfeX3ZkaxMzKygyThXe7auHSruPHS+s9rb5eo54oNdrFJZnovwgeKFHnPaW
    SGXUB4y3CCf39wyIkl7oTAGv9PbXx0/mtmZqxcTtZmUO39Dlnj0Zq6MdHrXW2qlR9r6e
    +gfGk8lJV0zDPg4DhCeE10CNDkdEp8vGtpeALl7PuvFYfwTOhJRQGfveGSZ2ZMtJvqRa
    HZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784492403;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DGeEX502BY/Q1+XKpGRmjA3rFXgEQE6RwfBgPXI9uLM=;
    b=JYV2hlV426VF83I54/Y/3Kx7GXywZjEgqejrh96ny5QIudeteZPEml0LtgZxQ2V0hF
    mlCPKaobxN08gOAnT8LoCHQlufMgrLA7IUdRbZRH9XmFFJvdypRkjS7qswghhceRI6k9
    exI/9nIcnYL8EZ5gZ2vKT8t/0AjAW8KrqgEftnLP9at55vOj2NdsoX/M/ifuttOP6PCe
    JqRwSoVBvzr2w7g1M9C3syECPgzvMN+xj8nXNthV7fEMDYH6K+AIaO3biGEN0gOMRafX
    6a78ksaXSumd0+okDSN/2BtrORw8nOIS0Itek/jEoUp79STvMBEOXzA5+PVDGe7BN/Vi
    Nikw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784492403;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DGeEX502BY/Q1+XKpGRmjA3rFXgEQE6RwfBgPXI9uLM=;
    b=bNxiirRN2vLgGyLLAzIwgkHWpSeZLG2o58cQIGwDsyWazmrOTjHkOxZoNjOuCJ730a
    ORzeOQUTvLR/f8z+BE8v2t53p55tQCnzSaWYISMjUKShx/a9ne7j7kVFgs+yK8LWo14T
    gq4KrzXhygnkkBHyddhLb6VmCn/UKDWWaUSpMe7LuU18MWcTxxA+XXGBcX9Ce2DToiTc
    LUepbMloWU6pFJo0g2dMQ7UzhDB4VqxL1RYdIrZCysmwLNQ4q9IyW1DkaMkGWBVckp17
    NYv44UkTALVgMnjsEw/fjlYSzreNHRnsqkOov8i5r+kikE8UxngQo5hRpRIXhZW1CB1a
    m6oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784492403;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DGeEX502BY/Q1+XKpGRmjA3rFXgEQE6RwfBgPXI9uLM=;
    b=+fljUks5i0IOdvKB0+/E9vp/XxcWDIDP1LyhAD92tNt3HadFoY8y4LRYbCzVvhqJIg
    qEWFqIGxf3SBeXzg+bBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ0JoInciN3JyLCGNPVWcns8O5VzNQLiZpJpg="
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q58eac26JKK25nC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 19 Jul 2026 22:20:02 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Paul Cercueil <paul@crapouillou.net>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-mips@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] i2c: jz4780: Cache host clock rate at probe to prevent CCF prepare_lock deadlock
Date: Sun, 19 Jul 2026 22:19:43 +0200
Message-ID: <2db6fd233aceb7238474e4833f4d25ca681c3ffb.1784492382.git.hns@goldelico.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
and the I2C adapter lock, which triggers when an I2C-controlled clock
generator client (like the Si5351) is registered or modified under the CCF.

During an i2c client clock (generator) frequency change, the CCF acquires its global
'prepare_lock' mutex and the driver calls i2c_transfer() to update the client's
chip registers, stalling for the adapter's I2C bus lock.

Concurrently, an independent, parallel transfer on the same bus (e.g., a GPIO
expander handling LEDs) can hold the I2C adapter lock. Inside this parallel
transfer path, jz4780_i2c_set_speed() calls clk_get_rate() on the host
controller's input clock to calculate bus timings. This call attempts to acquire
the blocked CCF 'prepare_lock', creating a circular dependency that freezes
the system.

The jz4780 host controller clock itself is static and never changes at runtime.

However, calling clk_get_rate() inside the active transfer path introduces
an unnecessary dependency on the CCF internal locks.

Eliminate this synchronous clk_get_rate() call from the active transfer
path by caching the static host peripheral clock rate once - inside the private
jz4780_i2c structure during jz4780_i2c_probe(). Update jz4780_i2c_set_speed()
to use this cached value, safely decoupling active I2C transactions from the
CCF internal locks without any risk of stale timings.

Assisted-by web based Google AI (pinpointing the bug and writing the message).

Fixes: ba92222ed63a12 ("i2c: jz4780: Add i2c bus controller driver for Ingenic JZ4780")
Cc: stable@vger.kernel.org
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/i2c/busses/i2c-jz4780.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index 664a5471d93357..695be3b2146085 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -141,6 +141,7 @@ struct jz4780_i2c {
 	void __iomem		*iomem;
 	int			 irq;
 	struct clk		*clk;
+	unsigned long		 clk_rate_khz;
 	struct i2c_adapter	 adap;
 	const struct ingenic_i2c_config *cdata;
 
@@ -246,7 +247,7 @@ static int jz4780_i2c_set_target(struct jz4780_i2c *i2c, unsigned char address)
 
 static int jz4780_i2c_set_speed(struct jz4780_i2c *i2c)
 {
-	int dev_clk_khz = clk_get_rate(i2c->clk) / 1000;
+	int dev_clk_khz = i2c->clk_rate_khz;
 	int cnt_high = 0;	/* HIGH period count of the SCL clock */
 	int cnt_low = 0;	/* LOW period count of the SCL clock */
 	int cnt_period = 0;	/* period count of the SCL clock */
@@ -796,6 +797,8 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(i2c->clk))
 		return PTR_ERR(i2c->clk);
 
+	i2c->clk_rate_khz = clk_get_rate(i2c->clk) / 1000;
+
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				   &clk_freq);
 	if (ret) {
-- 
2.55.0

