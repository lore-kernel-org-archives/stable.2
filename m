Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550482;
	b=UL11AMkHGnTR0jPdwwkuiM6/vEYV26Nv9osk+gCfKf/lpxHRIsIEb8RrqeTdbYJxOkEp
	 OypVMTe9BLUbQ7k1XaqKvJoKJr0KWEs2k89PWP7w8pzubK8Q54cAuWiMCANx53URHds/L
	 St8UDZjUtsriNcSuynwLqrSU5Kvh2PFkce5I1eZO7xHcgX4qUrxfn+1nlp2KjLxW6pKif
	 zUc+z3YrYfNSm2WVo5/J/v4Rzm+TG5k40Xci9oScla6YeUd2IzWjv1+JSDfqZFXTjsCld
	 J8x0yAjTjNT8fyHiqUtp+gQ6Be4/Ko97ryCuftMpFdLB+wQJp42aDfV0Y4wj14rGH7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550482;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=3FWIccO4+PqefYbmq8748pKuyoRonWMFOwYeYh13ZZs=;
	b=KZJUbmslA8WmBdJqG6wU7/cpl/MXFGlkywSb1ULfunbdZAIkmg/mAE3PldvtJv45zGhB
	 dVQNOWTx7VsX+3dpgq+TP7rfd26V9YBT1AFsYhTXW0YXCxDK+IqVBRvFRk6vSAUM5IIqa
	 NUOf0b49HeGwN1P+dhR24VHZ11RjySVXqqrdEVEG+f8lk9wb+5KKWNVp1hMoWf3bQvhy6
	 XghjpLcTrn1Kugt9zl8bDRmpkCtGOzJo+E1YZcTHBVsAtp7kWpCmlYiwYsZ3x7Viqyi+m
	 R+rX6+jOJDzfC+tbBjO5UtJjgzVl+4inirVvLQRUDuW/nCLaBCf/xAS6LbhK3GjVWlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EjZXGZtM;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4685606A319;
	Wed, 21 Oct 2026 02:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4685606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EjZXGZtM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3F
	WIccO4+PqefYbmq8748pKuyoRonWMFOwYeYh13ZZs=; b=EjZXGZtMWmRTIUXZya
	bmqH2aHRWwYadT7FKh2WyQ5H+ErPrsOLLFQaBrkmM//syXwKNLU1R3cOZZH2CnFu
	BBsKCJqSR0yO78CyW8cQFEa/5PFU0IuWRYUBoJY5fc3mXWHa6WyG44pG6UZCdk9I
	cVGxROXFM9z+pLRTHnmzCoQ70=
Received: from jbd-ThinkPad-X1-Carbon-Gen-14 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3P78oJthqvUvuBg--.49322S2;
	Wed, 21 Oct 2026 10:40:42 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: mani@kernel.org,
	jeff.hugo@oss.qualcomm.com,
	krishna.chundru@oss.qualcomm.com
Cc: loic.poulain@oss.qualcomm.com,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] bus: mhi: host: pci_generic: Update the default autosuspend_delay_ms as 5000ms
Date: Wed, 21 Oct 2026 10:40:38 +0800
Message-ID: <20261021024038.17127-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.53.0
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
X-CM-TRANSID:_____wD3P78oJthqvUvuBg--.49322S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr48tF4fXrW7XF1xur48WFg_yoW8CrW5pa
	yF9ay5tr1rXr4jk3Wktw1DXry5W3y5GrW7KryDCw4F93s5tw1kKryvqryFgF10krZ3ZFsx
	JF1jqay5Wr1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piYFAJUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5wpkyGrYJiqkIAAA37

For some MHI devices in some specific scenario, the default value
of autosuspend_delay_ms may not enough to handle last wake event.
This may lead to some unexpected problems.

Refer to the Qualcomm's Windows settings and we checked this with
Quaclomm over case, Qualcomm recommend us to set this as 5000ms.
Qualcomm also suggests us to update this for all MHI devices.
Since this setting has affected some existed kernel versions, it's
better to be applied to stable version.

Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: define a autosuspend delay timeout and explain the reason
---
 drivers/bus/mhi/host/pci_generic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 7193a384cca4..1f52542794d7 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -21,6 +21,9 @@
 
 #define MHI_POST_RESET_DELAY_MS 2000
 
+/* Add define of  initial autosuspend_delay_ms to accommodate a potential 'late wake-event' issue */
+#define MHI_AUTOSUSPEND_DELAY_MS 5000
+
 #define HEALTH_CHECK_PERIOD (HZ * 2)
 
 /* PCI VID definitions */
@@ -1483,7 +1486,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Allow runtime suspend only if both PME from D3Hot and M3 are supported */
 	if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
-		pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
+		pm_runtime_set_autosuspend_delay(&pdev->dev, MHI_AUTOSUSPEND_DELAY_MS);
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_mark_last_busy(&pdev->dev);
 		pm_runtime_put_noidle(&pdev->dev);
-- 
2.53.0

