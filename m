Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489062;
	b=SgH+wf4zfQ/eXLt7rghLgDBn5IQxRoAiMueBQl4mU8mOhpi8u62vVA+LX4nZfV+sgNQ/
	 y3LGtXR3vXrO89XVhD4lK41ywrzva4xE3aQPfsGaYywLYUXmF/a7s+7G1d33sxVgGPml0
	 s0BbMhzIovj7qHy0uEWMwnypOlLUAsy7m7bwUE/jdj/YtkV6GpzmHDH0g3JubL8GFhmM5
	 W4rPxoXzquZ7/E1qG/Jt0dv74WRwCO8iDMdHY/K93uTRd90NBW4zYbGhgwBBsJ0n8dThe
	 6BTUP5aUcS14kJUhweOq4L498FMffhykBeASZCW//ESrwBuvxrQlRV0vQilBNKzISwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489062;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=2cNlWNUoqUDDPQ6xXQ6ALQf3E5zOR4LUyb7Im43c3BQ=;
	b=BcsKw81lZM0zO6DlOD8zUqqqr4PjgHvzhX6K+fp0X0iULsNwXKf9z/K1I/SU83o8Zizf
	 +zKn+Z5mz7ebNbN/JdsicWj2phkC4nnZi/Bpr9OXS/adPkSpBYNVzcIJROlHWPQqh2Kh4
	 sfmiT6NSZHkeneaffQFSYEf8YiZs/wFV7mN/sYE9U3Kd8hKidcdkaO1apZv4DHJyaFsUC
	 Ys8K9sbiOZ5fhoyGm9iT/rijNnrH35jSYHOdiy1AITx6BKcLO3S81qelq4xNxGLHb5/RV
	 pQzxwtoXEOw1TRQcezflZggGMyLc34du4ilTo2Enf5hrAkXRbc7YTVGXwDq193HCUcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KCPucJyT;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2B60A2615;
	Tue, 20 Oct 2026 09:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DD2B60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KCPucJyT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2c
	NlWNUoqUDDPQ6xXQ6ALQf3E5zOR4LUyb7Im43c3BQ=; b=KCPucJyTQYq480p8S5
	YUxPK+cRgY1cqP/CoxWv6U1KHJASMP5qs65wEj68wZTIXGaCQ/GG5G5/bY6wAxWG
	WwmJntGoH67r5427dHSBlc5yZ6v24EMMaFlQnHdyvovwhEcBmmfMSt7Z4yxRYPmF
	dUEbYMIQS1WUwktj6lbZ5AKpc=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3_4ImNtdqupV5Aw--.29320S5;
	Tue, 20 Oct 2026 17:36:44 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/3] bus: stm32-rifsc: reject debugfs setup without match data
Date: Tue, 20 Oct 2026 17:36:35 +0800
Message-Id: <20261020093637.1654161-4-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020093637.1654161-1-yaojiale02@163.com>
References: <20261020093637.1654161-1-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgD3_4ImNtdqupV5Aw--.29320S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr13Ar1fKr43Xr15Gw43Awb_yoWkCrgEka
	92qa4xJrsrKrykGw1xZrnxZ3ya9w4UX34rXF4aqr93G39rXrn5XrZxXrZ7Aw47uws8u398
	CFykAr13Zw1xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnpHq3UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgwpY2rXNiymTQAA3E

Platform driver_override can bind a device to this driver without a
matching OF entry. With debugfs enabled, of_device_get_match_data()
then returns NULL and the configuration dump dereferences the resource
name table.

Reject debugfs registration without match data before exposing the
configuration file.

Fixes: 3bae4748c1cdd ("bus: rifsc: add debugfs entry to dump the firewall configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/bus/stm32_rifsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
index 19d10379dcef..dd008103b9c1 100644
--- a/drivers/bus/stm32_rifsc.c
+++ b/drivers/bus/stm32_rifsc.c
@@ -617,6 +617,8 @@ static int stm32_rifsc_register_debugfs(struct stm32_firewall_controller *rifsc_
 	rifsc_priv->nb_rimu = nb_rimu;
 	rifsc_priv->nb_risal = nb_risal;
 	rifsc_priv->res_names = of_device_get_match_data(rifsc_controller->dev);
+	if (!rifsc_priv->res_names)
+		return -ENODATA;
 
 	root = debugfs_lookup("stm32_firewall", NULL);
 	if (!root)
-- 
2.34.1

