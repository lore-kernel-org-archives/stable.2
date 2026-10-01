Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CA4A3859
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860339; cv=none; b=ddbyKaYyeZ03D/rsOw1xGPvwcOVPqDbm8e3aZClSbMD4/8hxM7a6Q+AAFOZv1klwI/GrdClHiVPqd86PNqmGm7sdxjGbdSbLl13+Idf+mY0BUNQT8MHQRI7YAsQwhUSxLSRSK1oUp7RZONqsx5+cNIYuNj4oEsnUShqrUbFMLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860339; c=relaxed/simple;
	bh=5eQizxKK9NuYLh8sm1blsIP6nlT5QAXKPTApBxVkzCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bydxad86UykOPLYKLStXvVZfi6UL2CxJC14fKj19h/YjzQXldQYZJTFr4rHvsliRbHoUta9R17lFrHee4VBbWyH01xEGFNVSRYGyIgQ2baY7C2MrnlTZLKbgXg6T0+u/qQiSMABI29m+FXVTg8U+1MGt3Zb1c010Q2f2O++DeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=J1vDXFi4; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="J1vDXFi4"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261001131209298a9ae42a0002072a
        for <stable@vger.kernel.org>;
        Thu, 01 Oct 2026 15:12:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=D6Ufe1MknHNgW3U5Ph4TDlWqQIvp7PRTpmjTSC8ykEA=;
 b=J1vDXFi49K0GXR0pP5N5uErx0CSAhOA5SoZRK1Kt0OQoYAEn64bEE5HAuwvFC5k8b+hDVS
 JexaxSSztLDFAdMcS+R66KYGt8y/EVPmU/D9gDisVmzHg2JsaHZMgJqdxoCLbY2Suu+XNt7w
 w0RxzsQM2/CsGx9c8Z3G9qZIeqwQjVjYS3SgxOKIdD9YjK/7D5h/CmposdkTnbXB3GaGEm/2
 aNHSb1eY5pyNEmQFkTW3MeqTUGcsp+hkezF4dpbozLCks7FXO0cZGCd3ihW8MSI/NUFjEeLU
 mpoPM1c1r3VRRmBKNiGFrQmJw6B8FxiiMdJCaleMyZ6UOTEwyLiZtc+Q==;
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
Subject: [PATCH v4 1/4] leds: trigger: netdev: Put netdev on activate error path
Date: Thu,  1 Oct 2026 15:12:00 +0200
Message-ID: <20261001131206.2513248-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20261001131206.2513248-1-alexander.sverdlin@siemens.com>
References: <20261001131206.2513248-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
v3:
- introduced unset_device_name() as a counterpart of set_device_name()

 drivers/leds/trigger/ledtrig-netdev.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 5b0132484594c..e2a6c95a0dc97 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -324,6 +324,13 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	return 0;
 }
 
+static void unset_device_name(struct led_netdev_data *trigger_data)
+{
+	dev_put(trigger_data->net_dev);
+	trigger_data->net_dev = NULL;
+	trigger_data->device_name[0] = 0;
+}
+
 static ssize_t device_name_store(struct device *dev,
 				 struct device_attribute *attr, const char *buf,
 				 size_t size)
@@ -776,8 +783,10 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	led_set_trigger_data(led_cdev, trigger_data);
 
 	rc = register_netdevice_notifier(&trigger_data->notifier);
-	if (rc)
+	if (rc) {
+		unset_device_name(trigger_data);
 		kfree(trigger_data);
+	}
 
 	return rc;
 }
@@ -790,7 +799,7 @@ static void netdev_trig_deactivate(struct led_classdev *led_cdev)
 
 	cancel_delayed_work_sync(&trigger_data->work);
 
-	dev_put(trigger_data->net_dev);
+	unset_device_name(trigger_data);
 
 	kfree(trigger_data);
 }
-- 
2.55.0

