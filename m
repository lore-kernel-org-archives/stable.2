Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695894;
	b=NmrTErMsYXSqgUONJtDAabYWjmKD5nm5X1SAzcuvkJthg+M8DnJu+aWDz+xHUASgSCbj
	 wd7Zb3qnE7P0GXf0I+r2JenAi7Bt8N6EpTMTqMP8sVkF8vje5QEvoNXMrNa6m9IcD3CEL
	 BnS4t3L1zwHDO5JBkn5GP0mxHxCbNtKgWDqmYv3EncRCd45xCtzecD4aXBUQzr0mdP24l
	 256vzhmJg4CvNwmqMsupw2OF76abiJjQ1Ey9byA+GcVHp0YrSStHg5KMp4JS8MaEyp/p5
	 ooC6z0dMw9ny7mHYB4EDJzpYfuqV75uBVc24M7L+RNbF7EOoOpBNLEcx0LEVC8OAnQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695894;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=RG3M7Ph6b75JaKSja+lviEDA771cXnI1I1R7J4t2jQQ=;
	b=w8bOPPqvcFmIX2DCJ4tyGkdmiCr4uMnfdNOh/vK7pFE1+jts2b/NZB330QvIQGAIehzl
	 04qOO7UkBhGYvjpcWjh+2csKB7j+1un3ZxHyPtmWm1hWWnu85FlRETti56UJ1J0uDr+AY
	 5Lj6ii/sEtjtAKa73JgUUiSzOK/ZCEiRsBf5AiA0viQmpyi6dXIsgw0vNRLY5rvX5UZ65
	 d3fWR3VzzaGKT9268b9XwrVXoFrgWDJ75DGAFDbEeGTUUfT8KLEYGaQncBuAk7O/JJHNf
	 Vknw7peHiiyz21uXTq1/MONm7O+jWV2bvfZL2Fo5a5iljzt39i+9xsLX7EBny+YYXuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=cM18b86I;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669C606A326;
	Tue,  3 Nov 2026 08:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5669C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=cM18b86I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793695889;
	bh=HAwwRZHDcggCJMNdBWfKXUgydT26+prS+DXdfiaeX8k=;
	h=From:To:Cc:Subject:Date:From;
	b=cM18b86Ip85zBZKa5x31ZqdfftWc9/JOpZDGjXLnfBVZShL8Mdan4ouOkNw2Tvfv6
	 5qaOWU5beL4yqM6zc6lOoYySVKShLdVZREE7IlKh7GRge+ppLN1VizFARFHk8YzuSf
	 EvFP2ECa1Ydx053zQAgEBa/xli7VbF5DSvxZTG0gil4vnCSXCpJR0XvPXQ2XdWPcC8
	 Ri+CsHD6TImTcriiH9OnihpdscYw/HgPQt7Ty8CS+ngb5T2Lj/MOLRhyrf/j2iBPLe
	 rSLDS0oXFI2zydxSkQkHQ4zui1n9dv8/llxNygyMC3AhFgLsPEPQHG4JTi8BdFpQrQ
	 NpdTuoQE52yKA==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 69999263AB;
	Tue,  3 Nov 2026 11:51:29 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue,  3 Nov 2026 11:51:28 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.27.207])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJhrt2clqz3tDN;
	Tue, 03 Nov 2026 11:42:06 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Martyn Welch <martyn@welchs.me.uk>,
	Manohar Vanga <manohar.vanga@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] staging: vme_user: added bound check to geoid
Date: Tue,  3 Nov 2026 11:41:44 +0300
Message-ID: <20261103084145.678-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/03 08:16:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207207 [Nov 03 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/03 05:25:00 #28784436
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/03 08:16:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Riyan Dhiman <riyandhiman14@gmail.com>

commit a8a8b54350229f59c8ba6496fb5689a1632a59be upstream.

The geoid is a module parameter that allows users to hardcode the slot number.
A bound check for geoid was added in the probe function because only values
between 0 and less than VME_MAX_SLOT are valid.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20240827125604.42771-2-riyandhiman14@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[mdmitrichenko: Apply the checks in drivers/vme/bridges/, where
 the bridge drivers reside in 5.10 and 5.15.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
 drivers/vme/bridges/vme_fake.c   | 6 ++++++
 drivers/vme/bridges/vme_tsi148.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/vme/bridges/vme_fake.c b/drivers/vme/bridges/vme_fake.c
index eae78366eb028..03469b1bdffb2 100644
--- a/drivers/vme/bridges/vme_fake.c
+++ b/drivers/vme/bridges/vme_fake.c
@@ -1071,6 +1071,12 @@ static int __init fake_init(void)
 	struct vme_slave_resource *slave_image;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* We need a fake parent device */
 	vme_root = __root_device_register("vme", THIS_MODULE);
 	if (IS_ERR(vme_root))
diff --git a/drivers/vme/bridges/vme_tsi148.c b/drivers/vme/bridges/vme_tsi148.c
index 5ccda1a363ecc..ee005ea0a6a92 100644
--- a/drivers/vme/bridges/vme_tsi148.c
+++ b/drivers/vme/bridges/vme_tsi148.c
@@ -2285,6 +2285,12 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vme_dma_resource *dma_ctrlr;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		dev_err(&pdev->dev, "VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* If we want to support more than one of each bridge, we need to
 	 * dynamically generate this so we get one per device
 	 */
-- 
2.43.0

