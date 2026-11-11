Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407056;
	b=h9v0OtxNM5mDna7tvZBbRztCLbzKfeuZ/yD9qafhnXkW/sOXuC/SzUzCzz27c0Sk+UdS
	 wgafFROP+VgNTcbjYdr2bixtZ9iqfRqT6vRe/wc4xHarjUnvgRJrwatJjDG92l8nr8I7c
	 TFzw4Tcx2jkSCk84dgIWMpiqCUVrrMQS0jxqmvwKpf0QNp8t3NeAlOchkF+09IXjOIalK
	 H8cUE49ChPpet6X5wz0FFpJw0M/O1l4zKroR2x+gXhMafY3UmLH0N18yddx5RbEpsrNem
	 f1aFyct8LTKHVOgHrjY8uDL4S/thpTzkrqd83fsIeYiUY/TZ0ZILYUSo43LheHvA99A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=SkvKw1RkLoUo4P/RmV52C0aJoH59lmWCBYxJx4Vfna0=;
	b=qi9C1efa0q8suXsAsqo+UXVErwoBcSC4JqvMgQjsWfZ682u9ecJyxFHIdOPG2iyYzqUm
	 HR3l4uSKiaYhFhvSaCbYh1HMA2XE+x7HE2y1juk4Mn/bLoKeVrboxxWaq+yL5Yl1lBP7P
	 7fBtwJPGszF35mj0Ta/kfw21UV1cg5kihyugx9RQ4KrJxtoqI6rtHRA7peNE+8g6Zf+pu
	 aMlQez0H7QtN8M5lXvR3jWBARkWJHz5V4lqncSjtmIfs2clYSaAHQXuiuvbV0Ny4IwUNu
	 6o2fetYfkLiJUEjWoGhbh+ZkEKXbG9sRebMnNzZXoq6TIiLf09ZDOTm2G/LNwsCXCZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=rKWeDpvM;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862C606A8B6
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4862C606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=rKWeDpvM
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-492f0a1b685so2210540f8f.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794407054; x=1795011854; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SkvKw1RkLoUo4P/RmV52C0aJoH59lmWCBYxJx4Vfna0=;
        b=rKWeDpvM3gXppe2w1jRx4FDwGNAKUchjBvJal0TxqQh/YSwzenzj6z021+9OEGGkJc
         6xDu+CwxTsiIQs9dXaZW1zMGcGb2MY2Ze4LFuhu0wQunAZhtjj8mh5eeTdtEln8n2kaY
         HDM+uHRB41a89Ckyx3ywLtKOazGptRSKp7wry4CMdH3f09HbqHr72HAAWe7pdmTVpehw
         t9HpUyDPpfR+ixEAM8He+pPQf8b8CSEwLdRqJUsESJWYp7CnHcv1scSb8uD2GIDIEOxB
         F7E+DYbshgAshLvgWXkdjbSdMBVlEXXKCzMhYOG6nlc28TvVyOClwEfQfIQ4LTklc8sy
         goxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407054; x=1795011854;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SkvKw1RkLoUo4P/RmV52C0aJoH59lmWCBYxJx4Vfna0=;
        b=BTH1ZOCA1t6HP1RbahzGXiW+7PVSV4UZwUCAn3NhgXl8503PLk4Pyj+LI2R7MqcBnq
         2SvupqE9yQIvQkBOhVAR7Ou489q/MG7yZj2g3nsdy3kfXaLh8Q4xzt59c/ldZJyxX+vG
         PsygumHdscp/J2mlmbxTEIcMgUdorpvrAFF0YoIk7jKLLGSbWGBjHGfGTHrYK/S7+uQf
         a5K6Sw7nkSh4zmXIumFwoGxxBTO9XCL0d0/r1osQLIXV0fdlHFVSd8UB93lqn6qeuO6e
         F1nGgrCDBilPbsKcnLm0vNVE7mXrs5QbWSFTM17HftafJkXqVH20VB5bbUAMjz0ZDdLT
         Ho9A==
X-Forwarded-Encrypted: i=1; AL+hErEhhdAjXicrI8NTMjXqkrWVqWQZIoRLzxx6F3vRXgv4twVMEVttkmxJaQcLd0CSPc/9hDJ0l+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+6vijUlE1OVTfEj97InGu4JO7DFLiuE7aL/mlFmYLJAZvIlVa
	ECb0buLJlaTw9fHCbvxyxegpfOqel9idAOL9y4wIpt3sy2zQTtiOXpQran8pttrpHHE=
X-Gm-Gg: AYBFou0Gxz4rSz13CdZJlyewhVgEsctYgdqLWY9gR5V1/cbeSofELd/xr0miCBsj+4V
	nuqRFuZoCJnyFKOEtIDVtyaNYNP3ldHmoOlA7oM5IVsC2fqnIY/IpZmDa9CF/ZWY5FqdaJbmsUB
	Mwltx/US0OuJ8FO53x5R/t+jHw47EzZWysuSvRZOOJhck9uUarKPY7vmQLSwTVR+8zMB6oXE4CC
	0S8yNisoqYlMlzslwr5yzfMgzpTEpzFlKlff9HIgd0xxNI368KpNe+WbbQomKe0gYg08WdRQRRB
	E7tW0nM8/kznmgOmJ1jp/PT42vR6ljbgh/KW3D4ABKIeNsYFiPekQ0hz6DgdJxUShwoLddwLm/y
	ANP/3DdTTkFCH65TXj3gupy+WT0HdJWMj+0xOs9naejP1uJ+8bqHz6Qe+4N/BNwPN4Rk8ZL9ap2
	JMgP85nHzvbls0zJhfmoS/xKTNDZAqZSdiBAn+5EzVTnNCkA5eqRcSj0A52oPFc0+PLzKk999w1
	t0kpsBYCbLjxAmuwebD4kxO4riMK2vTNs9OM3yb4pWK9NAJ1ZuYbsFkF3I7jE8oLmsig/lhjj8K
	MF0ZvJDxkl+JZd9RHBOLgt4igtpjDQKSiydpRm8LWS6eFtaNd4KMabuda3aK/+qoiyojCFDdfpB
	artJMQYOkoA==
X-Received: by 2002:a05:6000:5c7:b0:490:9fe2:6a39 with SMTP id ffacd0b85a97d-499c6027cc4mr4071191f8f.20.1794407053616;
        Wed, 11 Nov 2026 06:24:13 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498363df7a5sm11352871f8f.37.2026.11.11.06.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:24:07 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Nov 2026 18:24:01 +0400
Subject: [PATCH] scsi: ufs: core: Register the RPMB bus before adding
 devices to it
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-ufs-rpmb-bus-v1-1-b07100e53f6c@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINAtTSvWLSrITdJNKi3WTbZINUk2TDZKNrFMUwJqKShKTcusABsXHQv
 hF5cmZaUml4DMUKqtBQDF/kqFcAAAAA==
X-Change-ID: 20261111-ufs-rpmb-bus-c8e4c1c2c49f
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
 Stanley Jhu <stanleyjhu@google.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Avri Altman <avri.altman@sandisk.com>, Can Guo <can.guo@oss.qualcomm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211; i=alchark@flipper.net;
 h=from:subject:message-id; bh=rACyBhlqQdc7vEC+waUwW3Q2wxEerf4GPNn9xVrd1kk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9qWrhLHryfo6Zfv8kgTXmP5Ycq+UK9rIJfnTBefE/R
 eM7n25+6JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCq73UwMvTapVw7c+Px7UTL0o0fu0xWTvzBXzvvsdqKE/etJ54MVFzEyHCv4b9
 a2rTNWwKmWhle/3Oy5fFh30eWkzXP6YQY75960pYFAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

ufs_rpmb_probe() puts each RPMB region device on ufs_rpmb_bus_type, but
nothing ever registers that bus. The driver core used to accept such a
device and treat it as having no bus, which hid the problem. Since commit
36f35b8df697 ("driver core: reject devices with unregistered buses"),
device_register() fails instead, so no UFS host registers its RPMB
regions any more:

  bus_add_device: cannot add device 'ufs_rpmb0' to unregistered bus 'ufs_rpmb'
  ufshcd-rockchip 2a2d0000.ufshc: Failed to register UFS RPMB device 0

Register the bus when ufshcd-core initializes, before any host driver can
probe, and unregister it on exit.

Fixes: b06b8c421485 ("scsi: ufs: core: Add OP-TEE based RPMB driver for UFS devices")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/ufs/core/ufs-rpmb.c    | 10 ++++++++++
 drivers/ufs/core/ufshcd-priv.h |  9 +++++++++
 drivers/ufs/core/ufshcd.c      | 14 +++++++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
index 756673337648..591e7f2e1474 100644
--- a/drivers/ufs/core/ufs-rpmb.c
+++ b/drivers/ufs/core/ufs-rpmb.c
@@ -276,5 +276,15 @@ void ufs_rpmb_remove(struct ufs_hba *hba)
 	dev_info(hba->dev, "All UFS RPMB devices unregistered\n");
 }
 
+int __init ufs_rpmb_bus_init(void)
+{
+	return bus_register(&ufs_rpmb_bus_type);
+}
+
+void ufs_rpmb_bus_exit(void)
+{
+	bus_unregister(&ufs_rpmb_bus_type);
+}
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("OP-TEE UFS RPMB driver");
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 99f654b79035..4f2661036d7b 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -499,9 +499,18 @@ static inline u32 ufshcd_mcq_get_sq_head_slot(struct ufs_hw_queue *q)
 }
 
 #if IS_ENABLED(CONFIG_RPMB)
+int ufs_rpmb_bus_init(void);
+void ufs_rpmb_bus_exit(void);
 int ufs_rpmb_probe(struct ufs_hba *hba);
 void ufs_rpmb_remove(struct ufs_hba *hba);
 #else
+static inline int ufs_rpmb_bus_init(void)
+{
+	return 0;
+}
+static inline void ufs_rpmb_bus_exit(void)
+{
+}
 static inline int ufs_rpmb_probe(struct ufs_hba *hba)
 {
 	return 0;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c9b2eefbd7b0..4653d497e27b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -11687,9 +11687,20 @@ static int __init ufshcd_core_init(void)
 
 	ufs_debugfs_init();
 
+	ret = ufs_rpmb_bus_init();
+	if (ret)
+		goto err_debugfs;
+
 	ret = scsi_register_driver(&ufs_dev_wlun_template);
 	if (ret)
-		ufs_debugfs_exit();
+		goto err_rpmb_bus;
+
+	return 0;
+
+err_rpmb_bus:
+	ufs_rpmb_bus_exit();
+err_debugfs:
+	ufs_debugfs_exit();
 	return ret;
 }
 
@@ -11697,6 +11708,7 @@ static void __exit ufshcd_core_exit(void)
 {
 	ufs_debugfs_exit();
 	scsi_unregister_driver(&ufs_dev_wlun_template);
+	ufs_rpmb_bus_exit();
 }
 
 module_init(ufshcd_core_init);

---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261111-ufs-rpmb-bus-c8e4c1c2c49f

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

