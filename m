Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488338;
	b=pfZ1YevwqWMiaDZYMXy7e00LyuvlUZkpx+nTEjFUdbJ+rQvhPbzpDNwvlVoNODa+CdvC
	 7oZYjlcRN2swIknw09msMlChyzoCejHqiD5CZETyfOhp1sAyvmEtAF5YPMFdFR5GQMXEJ
	 a6X5u3+1V7FOYq5KfDC8mdWJceYDzjVvV4AyZ/sXE2BIV+pCP6KEFqHUt+WFu7yj2ZUKT
	 iiYljQI0tPfY5NmdHcmGbR2u3LI5oOpeDKRcTA+GuggKsPY779t8bGj7hPzolTcJvsxAE
	 5Q2ahrvy1qh3WGnEFiP43Po8kvkhCwEwBVCO0bF70kr3f+cuY9S1dBOT6N6u02GI4WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488338;
	h=DMARC-Filter:X-UUID:X-CID-CACHE:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fgpttzXHXOwMzQVloHp+GVdUMpOqfpnhZMTL9/tKDM4=;
	b=oXb6WXxYHaZdFg3JNt9+5qtdEYOBQE0+XklLmBm0GyYtYvIW0GAyGfDOypRlVXQStWDr
	 yml1jkJVmGElkY7OYMq64o0x9nGSw6vRQykUOZhTl0/d3Swur4/ckqt53S0y6Qp1YNtEp
	 4/Yfj0HMfPfJ0mDqiEVOR9p55k4WEwYIqndv0b1UUkR/bdk8noLA28PIOXm3rC3z6w0TN
	 lrLhhTXGBmMYNS6Bbr6SbFfCExsFkHR4enHwOq++LkvPwLlOIRDxTLIHoDjJxB6BmsBJz
	 WHFYjbMfRmXYdc7uoZ710NQXXGWZbpuI+TP2mJTBEdeCmU8VwYyd0ksRRAOalR0k+5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0888606A321;
	Tue, 24 Nov 2026 02:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0888606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 188c0ab0e7b111f19a56ed5b684f684d-20261124
X-CID-CACHE: Type:Local,Time:202611241040+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8e27f014-2349-4788-96ee-a2b033117f39,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:a1994da0e658bd37d7b78e0e0f45c24a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 188c0ab0e7b111f19a56ed5b684f684d-20261124
X-User: huyuming@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huyuming@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 959411961; Tue, 24 Nov 2026 10:45:23 +0800
From: Yuming Hu <huyuming@kylinos.cn>
To: hminas@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thinh.Nguyen@synopsys.com,
	stable@vger.kernel.org,
	Yuming Hu <huyuming@kylinos.cn>
Subject: [PATCH] USB: dwc2: shut down the wakeup timer before removing the HCD
Date: Tue, 24 Nov 2026 10:45:16 +0800
Message-Id: <20261124024516.2621743-1-huyuming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

The wakeup timer is armed from hardirq context (WKUPINT, 71 ms) and its
callback dwc2_wakeup_detected() ends up calling
usb_hcd_resume_root_hub(hsotg->priv) when the port is suspended.

dwc2_hcd_remove() invokes usb_remove_hcd() and clears hsotg->priv before
it reaches dwc2_hcd_release(), where fd772af9512c ("USB: dwc2: shut down
wakeup timer before freeing HCD state") performs the
timer_shutdown_sync().  If the timer expires inside that window, or its
callback is in flight while hsotg->priv is being cleared,
dwc2_hcd_rem_wakeup() passes the NULL hcd to
usb_hcd_resume_root_hub(), which dereferences it without a NULL check
and oopses in softirq context.

Shut the timer down before usb_remove_hcd(), so that an in-flight
callback always observes a valid hsotg->priv and any later rearm attempt
is ignored by the timer core.  The timer_shutdown_sync() call in
dwc2_hcd_release() is idempotent and keeps covering the probe error
path.

Fixes: 7359d482eb4d ("staging: HCD files for the DWC2 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yuming Hu <huyuming@kylinos.cn>
---
 drivers/usb/dwc2/hcd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2e1927dfa..0d6549832 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5377,6 +5377,14 @@ void dwc2_hcd_remove(struct dwc2_hsotg *hsotg)
 	if (!IS_ERR_OR_NULL(hsotg->uphy))
 		otg_set_host(hsotg->uphy->otg, NULL);
 
+	/*
+	 * Shut down the wakeup timer before the HCD is removed: its callback
+	 * reaches usb_hcd_resume_root_hub(hsotg->priv), which must never see
+	 * hsotg->priv == NULL.  The call in dwc2_hcd_release() is idempotent
+	 * and still covers the probe error path.
+	 */
+	timer_shutdown_sync(&hsotg->wkp_timer);
+
 	usb_remove_hcd(hcd);
 	hsotg->priv = NULL;
 
-- 
2.25.1

