Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100838;
	b=LlARlkKHz5oK7oCbbKxb9hBDzNYDntZPADVx9GsQ6XsLh83+Ix+Vrfjb1woPyI5QneFo
	 AXPtqTKyAjJdavdpmlI5WPGLOh2KUx2Gp9TTEFhjONTrjK8TEm/le2fSPlLDo12aBSN3A
	 YX2pS6Qdu/SIXDE4IJJJQcuUBV5XtRYJ9tvYNfT9em0NIZzIgxCWNJ67Ghodfc/uXzx3A
	 4QGz2Xj68UibRLEZK6dwPUhweMfVrUV2mP0dQtg6qRkFwzieNIEEgEr9P6cxQBKidbfGM
	 tqC5ai6iTlbQtPBidPAIatYxEcJp43ModthKWct3fOIzzijwXg3ji6MKC6IhPIJc3Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100838;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=CN0dtFVmpDOGFXmF2YV+l5pk0MBZMY+XXE39oRFUnQs=;
	b=GizatQe92y8U05M3i4HP5zSuCda0S0LZwo/bQT1rJOgbx8hmXNY4tgcMcTIm1cXng3ko
	 6P7zOLRgUZGickJA6upRNzmW+TcHJGJ4Bgik+sKtp+MXxs4LGHLPDDvUKensN5G0g2Edu
	 GMzQXJEFmMcHUG7WpiQ8SUxvbNG28cH5qhIYFn9VxQpNhzTnIyBCzYmEPViQl9TfxmVQz
	 RKPpqkppudMFSpOtJW3sIyfVvj2vtuLLY9G9Z2CQ5+V9RaEnRvqOX02Hzul6k5grgDpLQ
	 YmywRXCVgWRRiOnWmft5PmuqAkYC/5B8iBjjeUoLh8xjWniVOYwesTlk8lskE4UIqWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=THlpvoI2;
	arc=none smtp.remote-ip=185.136.65.225
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E1606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 441E1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=THlpvoI2
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20261027113353113f507c540002073b
        for <stable@vger.kernel.org>;
        Tue, 27 Oct 2026 12:33:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CN0dtFVmpDOGFXmF2YV+l5pk0MBZMY+XXE39oRFUnQs=;
 b=THlpvoI298VNT0b2jyKfBl88c5iJaX/UNtSMCz+kJfY0rSPWX9AMUxezTMN91tU/zRF9+j
 4g4chWb3p0w7WxUzcbyqne2a2eetaLTVv+FCgYkZpij5n0hw/2aUgwP9M73+Gp5K9GA8QIdT
 wiCatsXzv8b7UeaEj3HdW9tuzLI/iL6d29U1dqXKLIhtChqdaFMByCheZ84j+R/+e9uuQ6S5
 DvtvYC7UDQp2jbftUVvm47zzAAEg9aT8vWJsAXRcpJyyq81bWlgr5/P8cw8moEqpQ0fRJtPE
 x3XYVsZzub/NvC8ThOfMcqqphfV00NMd8ixd42TmrMZAiZOwVBbr2y+A==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-leds@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6 1/5] leds: trigger: netdev: Put netdev on activate error path
Date: Tue, 27 Oct 2026 12:33:41 +0100
Message-ID: <20261027113349.383147-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20261027113349.383147-1-alexander.sverdlin@siemens.com>
References: <20261027113349.383147-1-alexander.sverdlin@siemens.com>
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
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

When hw control is active, set_device_name() takes a reference on the
netdev via dev_get_by_name(). The register_netdevice_notifier() failure
path frees trigger_data without dropping it, leaking the netdev.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/20260914140045.B8F4C1F000FF@smtp.kernel.org/
Fixes: 0316cc5629d1 ("leds: trigger: netdev: init mode if hw control already active")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v5:
- removed unset_device_name()
v3:
- introduced unset_device_name() as a counterpart of set_device_name()

 drivers/leds/trigger/ledtrig-netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 5b0132484594c..cfaf130157b3d 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -776,8 +776,10 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	led_set_trigger_data(led_cdev, trigger_data);
 
 	rc = register_netdevice_notifier(&trigger_data->notifier);
-	if (rc)
+	if (rc) {
+		dev_put(trigger_data->net_dev);
 		kfree(trigger_data);
+	}
 
 	return rc;
 }
-- 
2.56.0

