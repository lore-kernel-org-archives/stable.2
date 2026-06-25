Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B22750E6;
	Thu, 25 Jun 2026 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366120; cv=none; b=YAz5dKRE6oNhir+vCWg4MeVOhvcVkPtG2+Oc153W7sgb8vjuvGo/XaHxVH500s0MI30+mQvuxa2SA9exLxmn+jV5Kx8cBW3DlujQCK/nbsgyvx8BKwzpDNsJdHC9MFZX5tUCfW7X4BmGqfQGc7RhYP/fZssBV1JJz7r++HYbsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366120; c=relaxed/simple;
	bh=xhQWUSV8bRj449s/C2U7QBHZOKxGOeQJeq0nB3HB2YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro4gGuPpMHiSFN55qGjTwVlpquzLN36RlHIf9sXUoq0+JNermwqmIa7W8267kebAyarjNKRe1nIuXEB1NZGzSgnrca9pC+kQgOm5RcbxRx8T2ONUSEDgx+5DIvdto+Q0zYsCdzxDLsiuAqGppPb1pRez7/rt/oa9RwwAkMECEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhGivzxqToUnFQ--.8562S2;
	Thu, 25 Jun 2026 13:41:54 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rob Herring <robh@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] can: c_can: Use platform id data when OF data is absent
Date: Thu, 25 Jun 2026 13:41:52 +0800
Message-ID: <20260625054152.68413-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
References: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhGivzxqToUnFQ--.8562S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aryfuw4xAFW5Jw15Gw1Dtrb_yoW8WFW8p3
	yUZFWSkr18Wr4jkw17G3W8ZFy3ua1ay3y7Kryj9a1ru3s3Wr1DXry8WFyxZFsrta98G3Wa
	qF4qqr93uFZ8ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjJ73P
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The platform driver keeps controller metadata in both the OF match table
and the platform id table. Probe reads the metadata with
device_get_match_data(), which does not fall back to platform id-table
driver_data.

When the device is matched through the platform id table, drvdata can
therefore be NULL before it is dereferenced for msg_obj_num and the
controller type. Fall back to platform_get_device_id() when firmware
match data is not available.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes in v2:
- Add the Fixes tag requested by Vincent.
- Scope the platform id variable inside the fallback block.
- Carry Vincent's Reviewed-by for the requested v2 shape.

 drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 19c86b94a40e..8a0c88839d24 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -267,6 +267,14 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 
 	drvdata = device_get_match_data(&pdev->dev);
+	if (!drvdata) {
+		const struct platform_device_id *id;
+
+		id = platform_get_device_id(pdev);
+		if (!id)
+			return -ENODEV;
+		drvdata = (const struct c_can_driver_data *)id->driver_data;
+	}
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.50.1

