Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7E51AFFD
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683753; cv=none; b=N5QhbVuxVH4eTd8VUStWYppkKqFX9+L94Uz4scJ677Qsi52elrVTdmdRmeMk2uvv7y9DbIezGZLQ/NJ+OcJFT0CuzWgAMgCSuzzA3A1Q9e2639oRTNo+98cXI9iek5Hdr0ncEN9xMk52LsOL3ctQaKlCjH4qt8OsoKw3PlN62Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683753; c=relaxed/simple;
	bh=5eQizxKK9NuYLh8sm1blsIP6nlT5QAXKPTApBxVkzCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQiCUwH4wKLa6ACKE5knvijw5AlpdVVIeZ9SMfXByV+123c4aG7obP0F9RwO3uXEUtrzSBPL61DLnTO6vIljIdCAHHVtuns0NpOyLTNUf3KAM3YNQCNItmOTq+Sci8pHG1w8UcQflaxRp9F9OsYfWSiarC10RIJJBo+Mi9xp/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=EaAR2F0D; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="EaAR2F0D"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260929120905054d550c71000207c3
        for <stable@vger.kernel.org>;
        Tue, 29 Sep 2026 14:09:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=D6Ufe1MknHNgW3U5Ph4TDlWqQIvp7PRTpmjTSC8ykEA=;
 b=EaAR2F0DfdcA5u4bHBYu2C3ZBGoT4UXD8xvofpgd+CuP7jGgouF7k0O+Vgncn+n38/D2md
 GMVPMAH8LrcIZGcQGxg8ziCKhbQYqrdkc3uLeInKY+J2Z73AD6qsgTybFytDywL+Lu08voUZ
 vA1AKMKtIG7phNjxdkTa2PPeFeXFjzzjAuxn7VF5gs3QJLhPvJrnp15AZHbX3/NeE/S9ESec
 WlqU6e40i+Gd3p3RYbbMPLr1bppBV928dIz6HAWet73MdLzwNfmsRxS5S4+GpZgfoZ/zeddO
 LQAcBderdtN6tTvPmdikRU0HnpdCDMbGbwXTygr1obyGRDjWrcVO+bYw==;
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
Subject: [PATCH v3 1/4] leds: trigger: netdev: Put netdev on activate error path
Date: Tue, 29 Sep 2026 14:08:51 +0200
Message-ID: <20260929120902.2793138-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260929120902.2793138-1-alexander.sverdlin@siemens.com>
References: <20260929120902.2793138-1-alexander.sverdlin@siemens.com>
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

