Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601191;
	b=YfXDnCW9MUmbgoLS4c/frpRycUjEyZEZ+B1JjRwvMGn9WuUA7+5FtgQ1pRIpEAlBfH4e
	 ASwSqy+no7BFTvvWOgx9SriNFY2QiL/XsOisJkPDUEwg5eHD69tMB4QFMchWlr6D9IMf3
	 bmDfGeDX25SFESJNXwAOAulJScP6XXpOjhhSPJX3atdsv/OpE2bRAz0btsjtn1uUiQaJm
	 W4bvywLIIJGyjNyPUeKICWnWf+PLJc8YJXOO+/fwUt7Rg3t+yY1Exbo7ZTiL8QAkI9bzp
	 JYZCbZX83AWdP2Zp+u882GU85UKEPFUo4tdaB0hvlI/KRHBbWbxGtfeyyyhv/O8bbGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601191;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=cF1S4AXEq3b6jfE9cxYhKtC+kS6OBPYZjYwpE8vdqAQ=;
	b=tJ38dC5FPOshrwnE0ZhdI77IcfRVVbCXbllvh41vTTcue3MZ/Uo14SRR7S/V0my3K54y
	 emEusdPI79dTfF87Nak5ZwoNUJ3EMUWagPkFmrdm0vkMC7JCKE5njUev0/L1hQLpiecIe
	 btly6Ln0Xx3AwLnCX1aGH8CfwKmqGbY/8cmyflm8YfNfW7Y2pL3Ya0/Rkrnoo17EAwqXJ
	 HYrRkvvX5GwT3OeCE0GdU1tTHxzVxGqcmZa8MkJNXsehPOPQnbgKhupHFBMHtzt9ahRBe
	 oNdN6KLm08FumT4+Yr0AqxwaFFUzTm1MyV6yj2Fr1xHFcTN4zqQKDyIHyWWbBekQYfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b="k3XN5nr/";
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8799606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8799606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=k3XN5nr/
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261113201940f98d23247700020755
        for <stable@vger.kernel.org>;
        Fri, 13 Nov 2026 21:19:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cF1S4AXEq3b6jfE9cxYhKtC+kS6OBPYZjYwpE8vdqAQ=;
 b=k3XN5nr/1x82k+bUnDcomARw6R0AtPUIaKiMkx2xwwC85wFtz3szoDCpfyExpkXgOdYyk2
 tjlkmRnHg/+y6s/qOmcPl0w2qOM/QMrSSaAKDUCs2Z+VLC4CtpvRyBNgUt/0BUzbfF+f0gEu
 +X1U24cz7QfLZnygxEsaeAfPNw2ttkMOa3rCLK8DlMab6PnsmA8pNEt2A5adEZt3Sv5bKsEI
 Kd2jffdzFrq/IbYsclzVOw35C3zepRHeXUU2J03ViMyQMA0wge5Z0j3DisWlPZHWgs4Ste8D
 zxY7qag92X2GhXk69NEl/5mAYh7NdJp6Hig1jj5rufvXa8/VS9q2PPUw==;
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
Subject: [PATCH v7 1/3] leds: trigger: netdev: Put netdev on activate error path
Date: Fri, 13 Nov 2026 21:19:30 +0100
Message-ID: <20261113201936.2645736-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20261113201936.2645736-1-alexander.sverdlin@siemens.com>
References: <20261113201936.2645736-1-alexander.sverdlin@siemens.com>
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
Acked-by: Lee Jones <lee@kernel.org>
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
index 9fa56ac523c7d..2afe7372aad78 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -795,8 +795,10 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
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

